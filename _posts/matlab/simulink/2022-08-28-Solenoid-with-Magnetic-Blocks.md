---
title: Build a Solenoid with Magnetic Blocks Using MATLAB Simulink
categories: 
 - MATLAB
 - Signals and Systems
 - Physics
 - Electrical Engineering
tags:
 - Electromagnetism
 - Numerical Analysis
 - MATLAB Simulink
 - Circuit Breaker
date: 2022-08-28 18:41:41 +0800
last_modified_at: 2024-07-17 12:28:39 +0800
---


# 简介

## 模型介绍

不同于在 [【MATLAB Simscape】电磁铁的电路-机械模型](http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/)  中介绍的电磁铁模型，本文所介绍的示例 $^{[1]}$ 引入了电磁铁的磁路模型。前者使用PS Lookup Table表示 $L(x)$ 和 $\mathrm{d}L/\mathrm{d}x$ ，并用电磁力计算公式计算线圈通电后所产生的电磁力，而本示例使用了磁路模型代替了上述计算过程。

<figure>
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825182445333.png?raw=true">
    <figcaption>Simulink 模型概览</figcaption>
</figure>

<figure>
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825182514188.png?raw=true">
    <figcaption>电路-磁路-机械回路耦合</figcaption>
</figure>
## 修改绘图代码文件

首先还是修改 `see code` 所对应的绘图代码文件 `ssc_solenoid_magnetic_plotxphi.m`，使我们可以绘制出电流、动铁芯位置和磁通的波形：

```matlab
% Code to plot simulation results from ssc_solenoid_magnetic
% Copyright 2015 The MathWorks, Inc.
% Reuse figure if it exists, else create new figure
try
    figure(h1_ssc_solenoid_magnetic)
catch
    h1_ssc_solenoid_magnetic=figure('Name', 'ssc_solenoid_magnetic', 'Position',[843, 200, 890, 720]);
end

% Generate simulation results if they don't exist
if(~exist('simlog_ssc_solenoid_magnetic','var'))
    sim('ssc_solenoid_magnetic')
end

% Get simulation results
temp_soli = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.R1.i.series;
temp_solx = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.x.series;
temp_solmf = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.phi.series;

% Plot results
ah(1) = subplot(3,1,1);
plot(temp_soli.time, temp_soli.values,'LineWidth',1);
grid on
title('Position (Magnetic Solenoid)');
ylabel('Position (mm)');

ah(2) = subplot(3,1,2);
plot(temp_solx.time,temp_solx.values*1000,'LineWidth',1);
grid on
title('Position (Magnetic Solenoid)');
ylabel('Position (mm)');

ah(3) = subplot(3,1,3);
plot(temp_solmf.time,temp_solmf.values,'LineWidth',1);
grid on
title('Magnetic Flux');
ylabel('phi (Wb)');
xlabel('Time (s)');

linkaxes(ah,'x');

% Remove temporary variables
clear temp_soli temp_solx temp_solmf ah
```

![image-20220825191409299](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825191409299.png?raw=true)

<br>

# Simulink 模型

MATLAB Simulink 中的 Simscape 模块都会定义通量(through variables)和跨量(across variables)，之后基于广义基尔霍夫定律(generalized Kichhoff's law)进行多域之间的耦合。该示例的电路部分和机械回路部分的建模很简单，与 [【MATLAB Simscape】电磁铁的电路-机械模型](http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/) 中的电磁铁模型一致，最重要的是搞清楚电路和磁路之间的耦合以及磁路和机械回路的耦合。

## 电路与磁路之间的耦合

电路与磁路之间的耦合是通过 `Electromagnetic Converter` 进行的：

<figure class="half">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825201750664.png?raw=true">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825201729093.png?raw=true">
    <figcaption>(a) Electromagnetic Converter模块的参数设置；(b)Electromagnetic Converter模块的描述</figcaption>
</figure>

从上图(a)图可以看到，线圈的匝数 $N=5500$；图(b)则展示了电路与磁路之间的耦合关系。

磁路的磁动势和电路中的电流有关：

$$
MMF=N\times I\notag
$$

电路中的电压则与磁路中的磁通量有关：

$$
V=-N\dfrac{\mathrm{d}\Phi}{\mathrm{d}t}\notag
$$

## 磁路

该模型中磁路部分是基于磁路的基尔霍夫定律([Magnetomotive force - Wikipedia](https://en.wikipedia.org/wiki/Magnetomotive_force))进行建模，磁路的基尔霍夫定律与电路的基尔霍夫定律非常类似，它们之间的类比关系如下表所示：

| 电路(electric circuit)                | 磁路(magnetic circuit)                |
| ------------------------------------- | ------------------------------------- |
| 电动势(electromotive force, emf): $E$ | 磁动势(magnetomotive force, mmf): $F$ |
| 电阻(resistance): $R$                 | 磁阻(magnetic reluctance): $R_m$      |
| 电流(current): $I$                    | 磁通(magnetic flux): $\Phi$           |
| 电路基尔霍夫定律：$E=IR$              | 磁路基尔霍夫定律：$F=\Phi R_m$        |

该模型的磁路部分主要包含两部分的磁阻：铁芯磁阻和固定空气间隙的磁阻。两部分磁阻都是通过 `Reluctance` 模块进行设置的：

![image-20220825203245533](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825203245533.png?raw=true)

磁阻的计算公式为：

$$
R_m=\dfrac{g}{\mu_0\mu_rS}\label{reluctance}
$$

本模型的铁芯磁阻和固定空气间隙磁阻的参数设置如下图所示：

<figure class="half">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825203623305.png?raw=true">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825203614504.png?raw=true">
    <figcaption>(a) 铁芯磁阻的参数设置；(b) 固定空气间隙磁阻的参数设置. </figcaption>
</figure>
可以计算出铁芯磁阻和固定空气间隙磁阻的值分别为 39788.74 ohm 和 1293133.91 ohm。可以使用代码验证这两个数值的正确性：

```matlab
% clc, clear
% 
% sym = 'ssc_solenoid_magnetic';
% open(sym)
% sim(sym)

mmf1 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Magnetic_Core.mmf.series.values;
phi1 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Magnetic_Core.phi.series.values;
unit1 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Magnetic_Core.mmf.series.unit;
unit2 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Magnetic_Core.phi.series.unit;

R1 = mmf1./phi1;

mmf2 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Plunger_Core_Fixed_Air_Gap.mmf.series.values;
phi2 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Plunger_Core_Fixed_Air_Gap.phi.series.values;
unit3 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Plunger_Core_Fixed_Air_Gap.mmf.series.unit;
unit4 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Plunger_Core_Fixed_Air_Gap.phi.series.unit;

R2 = mmf2./phi2;

R1(2)
8*(1e-2)/(4000*4*pi*(1e-7)*4*(1e-4))
R2(2)
0.65*(1e-3)/(4*pi*(1e-7)*4*(1e-4))
```



## 磁路与机械回路的耦合(一个没有解决的验证性问题)

磁路和机械回路之间的耦合是通过 `Reluctance Force Actuator` 模块进行的：

<figure class="half">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825205223365.png?raw=true">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825205205058.png?raw=true">
    <figcaption>(a) Reluctance Force Actuator模块的参数设置；(b) Reluctance Force Actuator模块的描述</figcaption>
</figure>

机械回路是一个质量-弹簧-阻尼系统，它所受到的力就来自于磁阻力，磁阻力的计算公式为：

$$
F=-\dfrac12\Phi^2\dfrac{\mathrm{d}R}{\mathrm{d}x}\notag
$$

这里的 $R$ 就是动铁芯移动过程中变化的空气间隙 $x$ 的磁阻，我们可以查看一下这个变化的空气间隙的变化情况：

![image-20220825210613066](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825210613066.png?raw=true)

可以看到，这与动铁芯的位置曲线是一致的。

根据磁阻的计算公式 $\eqref{reluctance}$ ，以及 [Reluctance Force Actuator - MathWorks](https://ww2.mathworks.cn/help/physmod/simscape/ref/reluctanceforceactuator.html) 中的描述的，$\mathrm{d}R/\mathrm{d}x$ 实际上是个常数，就是 $\dfrac1{\mu_0S}$，在模块中也是这么计算的：

![image-20220826135350929](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220826135350929.png?raw=true)

但是我想要根据数值进行计算验证，验证的思路是获得这个模块的MMF和Phi值从而计算磁阻R，之后使用`diff`函数分别计算$\mathrm{d}R$和$\mathrm{d}x$，之后比较两者之比，观察是否和常数$1/\mu_0S$相等：

```matlab
% This script is to verify whether the dR/dx is equal to 1/(mu0*CSA) 
% for Reluctance_Force_Actuator according to eq. R=g/(mu0*mur*CSA).
% https://ww2.mathworks.cn/help/physmod/simscape/ref/reluctanceforceactuator.html
% However, the answer is likely 'no'.

% clc, clear
% 
% sym = 'ssc_solenoid_magnetic';
% open(sym)
% sim(sym)

% Get mmf, phi, x
mmf = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.mmf.series.values('A');     % [A]
phi = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.phi.series.values('Wb');     % [Wb]
x   = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.x.series.values('m');  % [m]


% Calculate R using mmf and phi, according to magnetic Ohm's law.
R = mmf./phi;

% Calculate dR/dx
dR = diff(R);
dx = diff(x);
dRdx = dR./dx;

result = dRdx - 1/(4*pi*(1e-7)*4*(1e-4));
result = result(~isnan(result));
result = result(~isinf(result));
sum(result)
```

但是结果却是不相等，并且相差极大。

```matlab
ans =
  -7.2236e+17
```

另外，我想用相同的思路验证：

$$
\dfrac{\mathrm{d}R}{\mathrm{d}x}=\dfrac{\mathrm{d}R}{\mathrm{d}t}\dfrac{\mathrm{d}t}{\mathrm{d}x}=\dfrac{\mathrm{d}R}{\mathrm{d}x}\dfrac1v\notag
$$

结果好一些，但仍不太理想：

```matlab
% This script is to verify whether the dR/dx is equal to (dR/dt)/(dx/dt)
% The answer is 'maybe yes'.
clc, clear
sym = 'ssc_solenoid_magnetic';
open(sym)
sim(sym)

% Get mmf, phi, x
mmf = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.mmf.series;
phi = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.phi.series;
x = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Reluctance_Force_Actuator.x.series;

t = mmf.time;
mmf = mmf.values('A');
phi = phi.values('Wb');
x = x.values('m');

% Calculate R using mmf and phi, according to magnetic Ohm's law.
R = mmf./phi;

% Calculate dR/dx
dR = diff(R);
dx = diff(x);
dRdx = dR./dx;

% Calculate dR/dt
dt = diff(t);
dRdt = dR./dt;

% Calculate dx/dt, ie velocity.
velocity = dx./dt;

% Compare dR/dx and (dR/dt)*(dt/dx)
result = dRdx-dRdt./velocity;
sum(result(~isnan(result)))
```

```matlab
ans =
 -132.0000
```

这个问题可能是数值计算造成的。



## 动铁芯的运动距离与Hard stop

动铁芯的运动距离是由`Reluctance Force Actuator` 模块的`Initial air gap`参数所定义，另外，同样需要在`ssc_solenoid_magnetic`中的`Position Sensor`中进行相同的设置。

<br>

`Reluctance Force Actuator` 模块中还有`Minimum air gap`、`Contact stiffness`、`Contact damping`，这些参数用于描述动铁芯Hard stop的行为，在模块源代码中可以进行查看：

```matlab
...
equations
...
    if x > xmin
        mmf == phi*x/(N.mu0*mur*CSA);
        f == -0.5*phi^2*1/(N.mu0*mur*CSA);
    else
        mmf == phi*xmin/(N.mu0*mur*CSA);
        f == -0.5*phi^2*1/(N.mu0*mur*CSA) + K_contact*(xmin-x) - D_contact*u;
    end
end
...
```

这与[【MATLAB Simscape】电磁铁的电路-机械模型](http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/)中的电磁铁模型不同。这段代码相当于在电磁铁运动的终点加了一堵墙，以实现Hard stop：

![image-20220826110913989](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220826110913989.png?raw=true)

如果增加`Contact stiffness`参数的值，可以使所构建的刚体模型更加理想：

<figure class="half">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220826111505616.png?raw=true">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220826111420012.png?raw=true">
    <figcaption>(a) Contact stiffness=1e6; (b) Contact stiffness=1e8.</figcaption>
</figure>
<br>

# 系统方程

最后总结一下这个电路-磁路-机械回路的电磁铁线圈的系统方程：

$$
\begin{split}
&U=iR+U_L\\
&U_L=-N\dfrac{\mathrm{d}\Psi}{\mathrm{d}t}\\
&MMF=Ni\\
&MMF=\Psi R_{\Sigma}\\
&R_{\Sigma}=R_1+R_2+R_x\\
&R_x=\dfrac{x}{\mu_0 S}\\
&F=-\dfrac12\Psi^2\dfrac{\mathrm{d}R_x}{\mathrm{d}x}\\
&F=ma+bv+kx
\end{split}
$$
<br>

**参考**

[1] [Solenoid with Magnetic Blocks - MathWorks](https://ww2.mathworks.cn/help/physmod/simscape/ug/solenoid-with-magnetic-blocks.html).