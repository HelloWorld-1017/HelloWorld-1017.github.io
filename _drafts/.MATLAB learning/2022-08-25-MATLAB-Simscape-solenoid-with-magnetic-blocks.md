【MATLAB Simscape】电磁铁的电路-磁路-机械模型

# 引言

不同于在 [【MATLAB Simscape】电磁铁的电路-机械模型](http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/)  中介绍的电磁铁模型，本文所介绍的示例 $^{[1]}$ 引入了电磁铁的磁路模型。前者使用PS Lookup Table表示 $L(x)$ 和 $\mathrm{d}L/\mathrm{d}x$ ，并用电磁力计算公式计算线圈通电后所产生的电磁力，而本示例使用了磁路模型代替了上述计算过程。

<figure>
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825182445333.png">
    <figcaption>Simulink 模型概览</figcaption>
</figure>

<figure>
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825182514188.png">
    <figcaption>电路-磁路-机械回路耦合</figcaption>
</figure>

首先还是修改 `see code` 所对应的绘图代码文件 `ssc_solenoid_magnetic_plotxphi.m`，使我们可以绘制出电流、动铁芯位置和磁通的波形：

```matlab
% Code to plot simulation results from ssc_solenoid_magnetic
% Copyright 2015 The MathWorks, Inc.
% Reuse figure if it exists, else create new figure
try
    figure(h1_ssc_solenoid_magnetic)
catch
    h1_ssc_solenoid_magnetic=figure('Name', 'ssc_solenoid_magnetic', 'Position',[843, 466, 890, 720]);
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

![image-20220825191409299](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825191409299.png)

<br>

# Simulink 模型

MATLAB Simulink 中的 Simscape 模块都会定义通量(through variables)和跨量(across variables)，之后基于广义基尔霍夫定律(generalized Kichhoff's law)进行多域之间的耦合。该示例的电路部分和机械回路部分的建模很简单，与 [【MATLAB Simscape】电磁铁的电路-机械模型](http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/) 中的电磁铁模型一致，最重要的是搞清楚电路和磁路之间的耦合以及磁路和机械回路的耦合。

## 电路与磁路之间的耦合

电路与磁路之间的耦合是通过 `Electromagnetic Converter` 进行的：

<figure class="half">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825201750664.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825201729093.png">
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

![image-20220825203245533](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825203245533.png)

磁阻的计算公式为：
$$
R_m=\dfrac{g}{\mu_0\mu_rS}\label{reluctance}
$$
本模型的铁芯磁阻和固定空气间隙磁阻的参数设置如下图所示：

<figure class="half">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825203623305.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825203614504.png">
    <figcaption>(a) 铁芯磁阻的参数设置；(b) 固定空气间隙磁阻的参数设置. </figcaption>
</figure>


可以计算出铁芯磁阻和固定空气间隙磁阻的值分别为 39788.74 ohm 和 3232.83 ohm。



## 磁路与机械回路的耦合

磁路和机械回路之间的耦合是通过 `Reluctance Force Actuator` 模块进行的：

<figure class="half">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825205223365.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825205205058.png">
    <figcaption>(a) Reluctance Force Actuator模块的参数设置；(b) Reluctance Force Actuator模块的描述</figcaption>
</figure>

机械回路是一个质量-弹簧-阻尼系统，它所受到的力就来自于磁阻力，磁阻力的计算公式为：
$$
F=-\dfrac12\Phi^2\dfrac{\mathrm{d}R}{\mathrm{d}x}\notag
$$

这里的 $R$ 就是动铁芯移动过程中变化的空气间隙 $x$ 的磁阻，我们可以查看一下这个变化的空气间隙的变化情况：

![image-20220825210613066](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825210613066.png)

可以看到，这与动铁芯的位置曲线是一致的。

根据磁阻的计算公式 $\eqref{reluctance}$ ， $\mathrm{d}R/\mathrm{d}x$ 实际上是个常数，就是 $\dfrac1{\mu_0S}$，我们可以验证一下简单验证一下这个想法：

==用mmf和phi计算出R，然后R的差分除以x的差分，看看是否等于 $\dfrac1{\mu_0S}$==，script1

## 系统方程



==总结一下系统方程==

磁阻是如何计算的？然后永磁体的磁阻是怎么计算的？





[1] [Solenoid with Magnetic Blocks - MathWorks](https://ww2.mathworks.cn/help/physmod/simscape/ug/solenoid-with-magnetic-blocks.html).