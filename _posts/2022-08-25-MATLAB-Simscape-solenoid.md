---
layout: single
title: Simulate Solenoid in MATLAB Simulink
date: 2022-08-25 17:03:51 +0800
categories: 
 - MATLAB
 - Signals and Systems
 - Electromagnetism
 - Circuit Breaker
tags:
 - MATLAB Simulink
---

# 电磁铁的电路-机械模型

## Simulink 模型及对应的物理模型

MATLAB 官方提供了一个电磁体(solenoid)的 Simulink 仿真模型$^{[1]}$，该仿真模型是基于 Simscape 模块进行构建的。用户在命令行中输入 `ssc_solenoid` 即可打开该模型：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825144343510.png?raw=true" alt="image-20220825144343510" style="zoom: 67%;" />

该物理模型主要体现出了电路系统和机械系统之间的耦合。

虽然电磁铁是基于电磁关系涉及的，但是这个模型并不包含磁路部分的耦合。
{: .notice--primary}

该 Simulink 模型所对应的物理模型为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825143608628.png?raw=true" alt="image-20220825143608628" style="zoom:67%;" />

当开关闭合后，电路满足方程：

$$
\begin{split}
U&=Ri+\dfrac{\mathrm{d}\psi}{\mathrm{d}t}\\
&=Ri+\dfrac{\mathrm{d}Li}{\mathrm{d}t}\\
&=Ri+L\dfrac{\mathrm{d}i}{\mathrm{d}t}+i\dfrac{\mathrm{d}L}{\mathrm{d}t}\\
&=Ri+L\dfrac{\mathrm{d}i}{\mathrm{d}t}+i\dfrac{\mathrm{d}L}{\mathrm{d}x}\dfrac{\mathrm{d}x}{\mathrm{d}t}
\end{split}
$$

其中， $\dfrac{\mathrm{d}x}{\mathrm{d}t}$ 为铁芯运动的速度；$L(x)$ 和 $\dfrac{\mathrm{d}L(x)}{\mathrm{d}x}$ 在 Simulink 模型中由 PS Lookup Table(1D) 模块给出：

<figure class="half">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825135120035.png?raw=true">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825135053982.png?raw=true">
    <figcaption>(1) Profile of L(x); (2) Profile of dL/dx</figcaption>
</figure>

驱使铁芯运动的力来自于电磁力，计算公式为：

$$
F=\dfrac12i^2\dfrac{\mathrm{d}L(x)}{\mathrm{d}x}\label{force}
$$

机械部分是由铁芯、弹簧所构成的一个质量-弹簧-阻尼系统：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825153817564.png?raw=true" style="zoom:67%;" />

力的平衡方程为：

$$
F=m\dfrac{\mathrm{d}^2x}{\mathrm{d}t^2}+b\dfrac{\mathrm{d}x}{\mathrm{d}t}+kx\label{mech}
$$

其中，$m$ 为铁芯质量，$b$ 为阻尼系数，$k$ 为弹簧弹性系数。

## 模型参数

该 Simulink 模型的模型参数如下：

- 直流电压源：DC 50V

- 线圈回路电阻： 1000 ohm
- 铁芯质量：0.1 kg
- 阻尼系数：20 N/(m/s)
- 弹簧弹性系数：200 N/m




## 运行模型：电流、电磁力和动铁芯位置曲线的绘制

官方在模型中的左下角添加了这样的注释

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825131210984.png?raw=true" alt="image-20220825131210984" style="zoom:50%;" />

其中超链接的部分既可以指向 URL，也可以指向一段执行代码。比如， 选中 `see code` 超链接，并右键选中 `Hyperlink`：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825131521923.png?raw=true" alt="image-20220825131521923" style="zoom:50%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825131558416.png?raw=true" alt="image-20220825131558416" style="zoom:50%;" />

可以看到，`see code` 超链接是执行了一段 MATLAB 代码，功能是打开 `ssc_solenoid_plotimf.m` 文件。`ssc_solenoid_plotimf.m` 文件的功能是绘制线圈电流和电磁力曲线。但是这个文件是只读的，无法保存修改，因此我们需要在电脑中找到`ssc_solenoid_plotimf.m` 文件，复制一份到当前文件夹。此时也不用修改该超链接所指向的 Code，因为 MATLAB 会优先在当前文件夹中搜索代码文件。

为了更方便地显示结果，我们在参照原来的代码，在其中添加绘制 position 的图像，最终代码如下：

```matlab
% Code to plot simulation results from ssc_solenoid
% Copyright 2015 The MathWorks, Inc.

% Reuse figure if it exists, else create new figure
try
    figure(h1_ssc_solenoid)
catch
    h1_ssc_solenoid=figure('Name', 'ssc_solenoid', 'Position',[843, 466, 890, 720]);
end

% Generate simulation results if they don't exist
if(~exist('simlog_ssc_solenoid','var'))
    sim('ssc_solenoid')
end

% Get simulation results
temp_soli = simlog_ssc_solenoid.Solenoid.R1.i.series;
temp_solmf = simlog_ssc_solenoid.Solenoid.Position_Velocity_Force_Interface.Magnetic_Force.f.series;
temp_solpos = simlog_ssc_solenoid.Position_Sensor.Translational_Motion_Sensor.P.series;

% Plot results
ah(1) = subplot(3,1,1);
plot(temp_soli.time,temp_soli.values,'LineWidth',1);
grid on
title('Solenoid Current');
ylabel('Current (A)');

ah(2) = subplot(3,1,2);
plot(temp_solmf.time,temp_solmf.values,'LineWidth',1);
grid on
title('Solenoid Magnetic Force');
ylabel('Force (N)');

ah(3) = subplot(3,1,3);
plot(temp_solpos.time,temp_solpos.values,'LineWidth',1);
grid on
title('Position');
ylabel('Position (m)');
xlabel('Time (s)');

linkaxes(ah, 'x');

% Remove temporary variables
clear temp_soli temp_solmf temp_solpos ah
```

效果：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825133727626.png?raw=true" alt="image-20220825133727626" style="zoom:50%;" />

<br>

# 讨论

## 初始位置

### 设置

电磁铁中铁芯的初始位置是在 `ssc_solenoid/Solenoid/Position Velocity Force Interface` 的 `Translational Motion Sensor` 模块中进行定义的。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825125131631.png?raw=true" alt="image-20220825125131631" style="zoom: 50%;" />

并且 `ssc_solenoid/Position Sensor` 的 `Translational Motion Sensor` 的参数要和它保持一致。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825130237814.png?raw=true" alt="image-20220825130237814" style="zoom:50%;" />

### 修改

如果修改初始位置为 10 mm，则波形为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825134131412.png?raw=true" alt="image-20220825134131412" style="zoom:50%;" />

出现这种异常现象的原因：

（1）电压源太小，产生的电磁力无法使动铁芯运动（因为电磁力是和$\mathrm{d}L/\mathrm{d}x$ 有关的， 而根据 $\mathrm{d}L/\mathrm{d}x$ 的Lookup Table，在10mm的位置处， $\mathrm{d}L/\mathrm{d}x$ 的值很小）；

（2）在0.3s所出现的反向运动是因为这个Simulink模型在0.3s时会添加一个持续的10N的外力（后面将会提到），在外力的作用下动铁芯反向运动。

**总之，这就是模型参数不匹配导致的。**通过增加直流电压源的值可以解决这个问题，让动铁芯动起来，比如设置为DC 220V，结果为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825135727089.png?raw=true" alt="image-20220825135727089" style="zoom:50%;" />

## 动铁芯停止

在这个模型中，动铁芯停止运动的条件是**动铁芯和弹簧所组成的质量-弹簧-阻尼系统达到了力的平衡**，在这个过程中会出现振荡的现象，从而出现位置为负数的情况：

![image-20220825154554788](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825154554788.png?raw=true)

如果我们不想让位置越过零太多，或者说我们想让动铁芯 Hard stop，类似于撞击到刚体上停止，就需要再设计一个刚体的模型。刚体同样可以简化为一个弹簧和一个阻尼，具体可以参考：[Translational Hard Stop](https://ww2.mathworks.cn/help/physmod/simscape/ref/translationalhardstop.html)，[Friction Model with Hard Stops](https://ww2.mathworks.cn/help/simulink/slref/friction-model-with-hard-stops.html).

## 一个10N的外力

在0.3s时，该模型的这部分会向机械系统持续施加一个10N的力：

![image-20220825160920902](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825160920902.png?raw=true)

在图像上可以看到在0.3s时形成一个振荡：

![image-20220825161112347](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825161112347.png?raw=true)

如果我们去掉这个力，则图像为：

![image-20220825161218709](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825161218709.png?raw=true)

说明这个10N的力并不影响大致波形，但是它的具体作用不是很清楚，而且是持续施加的，不太可能是为了构建一个Hard Stop，可能是为了观察当系统稳定时，推动动铁芯给机电系统造成的影响。

## 切断直流源

该 Simulink 模型的电压源为 DC 50V，开关在 0.1s 时进行闭合，之后并不打开：

![image-20220825160105652](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825160105652.png?raw=true)

那么，如果开关在 0.4s 时断开会怎样呢？我们可以将 Step 模块换为 Pulse Generator 模块来实现这一功能。

![image-20220825162030557](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825162030557.png?raw=true)

结果如下：

注意：此时模型中已经删去了在0.3s后施加的10N的外力，并且仿真时间从原来的0.5s增加至2s。
{: .notice--danger}

![image-20220825162127797](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825162127797.png?raw=true)

这说明一旦切断电压源，电磁力就会立即消失，动铁芯在弹簧力的作用下向初始点移动。

还有一个需要注意的点，动铁芯在弹簧力的作用下运动的动态过程为什么不存在振荡现象？

<figure>
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825163343055.png?raw=true">
    <figcaption>The varying profile of spring's variables.</figcaption>
</figure>

这是由这个质量-弹簧-阻尼系统的状态方程所决定的。这个机械系统满足公式 $\eqref{mech}$ ，其中$m=0.1$，$b=20$，$k=200$，即有：

$$
b^2\ge4mk\notag
$$

说明这个机械系统处于一种“过阻尼”的状态，从一个稳态到另一个稳态就是一个非周期非振荡的过程。

<br>

# 其他说明

1. 该模型并不涉及摩擦力，动能损失， 热量损失；
2. 若不使用 Lookup table 的方式表示磁场，用磁路对磁场建模，可以使模型更加合理。可以参考 MATLAB 提供了另外一个示例：[Solenoid with Magnetic Blocks](https://ww2.mathworks.cn/help/physmod/simscape/ug/solenoid-with-magnetic-blocks.html).
3. 当使用磁路来表征磁场时，电磁力的计算公式不再是公式 $\eqref{force}$；
4. 当切断电压后，电磁铁无法将动铁芯保持在终点位置，可以在中间加入永磁体模型通过引入永磁力来改善这一点；
5. 另一方面，可以通过删去弹簧，并且添加一个Hard stop来使动铁芯保持在终点位置，但是在一些场合，弹簧是必要的。

<br>

**References**

[1]  [Solenoid - MathWorks](https://ww2.mathworks.cn/help/physmod/simscape/ug/solenoid.html).
