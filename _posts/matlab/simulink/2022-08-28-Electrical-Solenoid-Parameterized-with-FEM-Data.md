---
title: Build a Solenoid Parameterized with FEM Data using MATLAB Simulink
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
date: 2022-08-28 14:49:01 +0800
last_modified_at: 2024-07-17 12:29:14 +0800
---

# 模型介绍

## 简介

MATLAB示例[^1]展示了一个连接了复位弹簧（return spring）的有限行程电磁铁（limited travel solenoid）。当线圈回路不通电时，弹簧将铁芯保持在0.1 mm处；在0.01 s时，线圈通电，铁芯会运动到0 mm处；在0.06 s时，向动铁芯施加一个比保持力更大的力（50N），在这个力的作用下，动铁芯会向反向运动，直到0.2 mm处。

电磁力（solenoid force）和反电动势特征（back emf characteristics）通过模型中的 `FEM-Parameterized Linear Actuator`组件进行定义。该模块可以调用由有限元磁场建模工具输出的格式化数据。

这个模型和[^2]最主要的差别是本模型可以很好地捕捉磁饱和效应（magnetic saturation effects），相反，后者假设电流和电磁力是线性关系。这个线性假设也是 MATLAB Simscape模块[^3]构建的基础。

原文： Conversely the Simscape example assumes a linear relationship between current and magnetic force. 这里表述不准确，电磁力$F$和电流$i$之间的关系是：$F=\dfrac12i^2\Big(\mathrm{d}L(x)/\mathrm{d}x\Big)$。
{: .notice--danger}

在这个示例中，子系统`Linear Solenoid`是基于0.1 A时的电磁铁电感数据进行参数化的。这个电感是磁链关于电流的偏导数，同样是通过初始文件进行计算的。

将该模型的结果与电磁铁线性模型作比较，可以看出磁饱和效应。

## 模型文件

在电脑中找到`ee_solenoid_fem.slx`文件复制到当前文件夹中即可运行、编辑并保存。

![image-20220826145151878](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220826145151878.png?raw=true)



## 预加载数据文件

在模型的`PreLoadFcn`函数中可以看到：

![image-20220826150005970](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220826150005970.png?raw=true)

模型预加载了一个`ee_solenoid_fem_data.mat`，该文件中包含了模型的运行参数：

![image-20220826163902745](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220826163902745.png?raw=true)

其中：

（1）变量 `current`

```
current =

         0    0.1000    0.2000    0.3000    0.4000    0.5000    0.6000    0.7000    0.8000    0.9000    1.0000
```

（2）变量 `x`，`xmin`，`xmax`，`x0`

```
x =
   1.0e-03 *
         0    0.0500    0.1000    0.1500    0.2000
```
```
xmin =
     0
```

```
xmax =
   2.0000e-04
```
```
x0 =
   1.0000e-04
```

变量`x`，`xmin`，`xmax` 和`x0`都是和位移有关的变量，它们所代表的含义如下图所示：

![image-20220828132634721](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220828132634721.png?raw=true)

其中，`x0`是设置在模块的`Initial Targets`部分。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220827213551308.png?raw=true" alt="image-20220827213551308" style="zoom:50%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220827213612440.png?raw=true" alt="image-20220827213612440" style="zoom:50%;" />

（3）变量 `flux_linkage`

```
flux_linkage =
         0         0         0         0         0
    0.0085    0.0079    0.0075    0.0071    0.0067
    0.0171    0.0160    0.0151    0.0143    0.0137
    0.0254    0.0239    0.0226    0.0215    0.0206
    0.0330    0.0312    0.0297    0.0283    0.0271
    0.0396    0.0377    0.0360    0.0345    0.0331
    0.0452    0.0433    0.0415    0.0399    0.0384
    0.0495    0.0478    0.0461    0.0446    0.0431
    0.0526    0.0512    0.0498    0.0485    0.0472
    0.0545    0.0537    0.0528    0.0519    0.0508
    0.0554    0.0553    0.0551    0.0548    0.0542
```

后面可以看到，FEM-Parameterized Linear Actuator组件有两种使用磁链的方式，当选择直接使用磁链数据时，需要用到该变量。

（4）变量 `dfluxdi`，`dfluxdx`

```
dfluxdi =
    0.0918    0.0858    0.0799    0.0739    0.0680
    0.0877    0.0828    0.0780    0.0732    0.0683
    0.0825    0.0787    0.0750    0.0713    0.0675
    0.0762    0.0735    0.0709    0.0683    0.0656
    0.0687    0.0672    0.0657    0.0642    0.0626
    0.0602    0.0598    0.0594    0.0589    0.0585
    0.0506    0.0512    0.0519    0.0526    0.0533
    0.0398    0.0416    0.0434    0.0452    0.0470
    0.0279    0.0308    0.0337    0.0366    0.0395
    0.0150    0.0190    0.0230    0.0270    0.0310
    0.0009    0.0060    0.0111    0.0162    0.0213
```

```
dfluxdx =
         0         0         0         0         0
  -11.2641  -11.2641  -11.2641  -11.2641  -11.2641
  -19.8442  -19.8442  -19.8442  -19.8442  -19.8442
  -26.2136  -26.2136  -26.2136  -26.2136  -26.2136
  -30.3724  -30.3724  -30.3724  -30.3724  -30.3724
  -32.3204  -32.3204  -32.3204  -32.3204  -32.3204
  -32.0576  -32.0576  -32.0576  -32.0576  -32.0576
  -29.5842  -29.5842  -29.5842  -29.5842  -29.5842
  -24.9001  -24.9001  -24.9001  -24.9001  -24.9001
  -18.0052  -18.0052  -18.0052  -18.0052  -18.0052
   -8.8996   -8.8996   -8.8996   -8.8996   -8.8996
```

同样地，FEM-Parameterized Linear Actuator组件有两种使用磁链的方式，当选择使用磁链对于电流和位移的偏导数时，需要用到这两个变量。

（5）变量`force`

```
force =
         0         0         0         0         0
   -0.6000   -0.5000   -0.4000   -0.3000   -0.3000
   -2.3000   -2.0000   -1.7000   -1.4000   -1.2000
   -4.9000   -4.3000   -3.7000   -3.2000   -2.7000
   -8.3000   -7.3000   -6.4000   -5.5000   -4.7000
  -12.2000  -10.7000   -9.4000   -8.2000   -7.2000
  -16.2000  -14.4000  -12.7000  -11.3000  -10.0000
  -20.0000  -17.9000  -15.9000  -14.3000  -12.9000
  -23.3000  -20.9000  -18.8000  -17.1000  -15.7000
  -25.7000  -23.1000  -21.1000  -19.4000  -18.2000
  -26.5000  -24.1000  -22.2000  -20.9000  -20.1000
```

FEM-Parameterized Linear Actuator组件电磁力的计算方式也有两种，一种是直接使用导入数据，一种是模块自动计算。该模型使用的是第一种，需要用到变量`force`。在后面会再提及这一点，并且在代码文件中会对两种方式得到的Force matirx结果进行对比分析。

（6）变量 `R`

```
R =
    14
```

变量`R`作为线圈电阻输入到两个模型之中。

（7）变量 `lambda`，`mass`
```
mass =
    0.1000
```

```
lambda =
    20
```

变量`mass`和`lambda`分别作为Mass-Spring-Damper系统的动铁芯质量Mass和Damper系数输入到两个模型之中。

（8）变量 `L` 和 `dLdx`

```
L =
    0.0877    0.0828    0.0780    0.0732    0.0683
```

变量`L`用于输入到`ee_solenoid_fem/Linear Solenoid/Calculate Force and Current`中的`LUT PtoL`模块，与变量`x`对应，表示L(x)。

```
dLdx =
  -96.8551  -96.8551  -96.8551  -96.8551  -96.8551
```

同样地，变量`dLdx`用于输入到`ee_solenoid_fem/Linear Solenoid/Calculate Force and Current`中的`LUT P to dL/dx`模块，与变量`x`对应，表示dL(x)/dx。

<br>

# FEM-Parameterized Linear Actuator组件

该示例中基于FEM仿真数据的电磁铁模型仅仅包含这样一个FEM-Parameterized Linear Actuator组件和一个Spring组件：

![image-20220827151257870](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827151257870.png?raw=true)

因此，理解好FEM-Parameterized Linear Actuator组件的运行原理就掌握了这个电磁铁模型。

<figure>
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220827111006159.png?raw=true">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220827111019193.png?raw=true">
    <figcaption>The (a) Settings and (b) Description of FEM-parameterized Linear Actuator component.</figcaption>
</figure>
该组件的官方介绍文档见[^4]。该组件的各个参数都有默认值，但这里用的是`ee_solenoid_fem_data.mat`中的数据。

## 电磁学模型（Magnetic Force）

该组件的电磁学模型最终目的是计算Magnetic Force，根据用户的需要，组件提供了两个一级选项，分别是：

- `Electrical model`，用于选择磁链数据的使用方式。

- `Calculate force matrix`，用于选择电磁力的计算；

此外，还需要指定其他一些计算参数，下面分别对这些设置进行介绍。

### （1）使用磁链的两种方式

该组件使用磁链数据有两种方式，一种是直接使用磁链数据（flux data），另一种是使用磁链对电流和位移的偏导数，通过设置`Electrical model`进行选择。

#### 直接使用磁链数据

当设置为`Define in terms of Phi(i,x)`时，为直接使用磁链数据，特有的子参数为`Flux linkage matrix, Phi(i,x)`：

![image-20220827134608116](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827134608116.png?raw=true)

这种方式依据的就是法拉第电磁感应定律：

$$
U=iR+\dfrac{\mathrm{d}\Psi(x,i)}{\mathrm{d}t}\label{eq1}
$$

用户通过向`Flux linkage matrix, Phi(i,x)`提供$\Psi(x,i)$即可。

#### 使用磁链对电流和位移的偏导数

当设置为`Define in terms of dPhi(i,x)/dx and dPhi(i,x)/di`时，为使用磁链对电流和位移的偏导数，特有的子参数为：`Flux partial derivative wrt current, dPhi(i,x)/di`和`Flux partial wrt displacement, dPhi(i,x)/dx`：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827134802234.png?raw=true" alt="image-20220827134802234"  />

基于链式求导法则对式$\eqref{eq1}$进行展开：

$$
U=iR+\dfrac{\partial\Psi}{\partial x}\dfrac{\mathrm{d}x}{\mathrm{d}t}+\dfrac{\partial\Psi}{\partial i}\dfrac{\mathrm{d}i}{\mathrm{d}t}\label{eq2}
$$

该式就是第二种方式所依据的计算方程。

用户通过向`Flux partial derivative wrt current, dPhi(i,x)/di`参数和`Flux partial wrt displacement, dPhi(i,x)/dx`参数提供$\dfrac{\partial\Psi}{\partial x}$和$\dfrac{\partial\Psi}{\partial x}$即可。

#### 两种方式的比较

从数值计算的角度看，第二种方式通常是更好的选择，因为反电动势是分段连续的（piecewise continuous），它能在给定电流和位置提供处更准确的结果。但是，这也需要更多的预处理步骤。如果直接使用磁链数据，选择更合理的电流和位移网格尺寸、选择三次插值或样条插值可以改善结果。

### （2）电磁力的两种计算方式

无论使用什么样的电磁学模型，都需要指定电磁力的计算方式。电磁力是电磁学模型计算的最终目的，也是和机械部分耦合的纽带。

电磁力的计算有两种方式，通过设置一级选项`Calculate force matrix`进行选择。

#### 直接基于Force matrix

将`Calculate force matrix`设置为`No`，表示直接使用Force matrix，而不进行计算，这种模式的特有子参数是`Force matrix, F(i,x)`：

![image-20220827142331204](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827142331204.png?raw=true)

用户通过向参数`Force matrix, F(i,x)`传入数据将电磁力设置为电流和位移的方程。

如果直接使用电磁力数据，可以直接使用FEM工具所导出的数据，也可以通过下面的公式进行计算：

$$
F=\int^i_0\dfrac{\partial\Psi(x,i)}{\partial x}\mathrm{d}i\label{eq3}
$$

#### 模块自动计算Force matrix

将`Calculate force matrix`设置为`Yes`，表示令模块自动计算Force matrix：

![image-20220827142248109](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827142248109.png?raw=true)

在模型初始化时，该模式基于模块的磁链信息计算Force matrix，计算方法方式是对$\eqref{eq3}$进行数值积分。

#### 本示例模型的电磁力计算方法

本示例模型所采用的电磁力计算方法是第一种，直接使用FEM仿真导出的电磁力数据。

在后面，在`ee_solenoid_fem_params.m`代码文件中，对比了两种方式得到的结果。

### （3）`Flux dependence on displacement`参数

为了对linear motor with a repeated flux pattern进行建模，需要将`Flux dependence on displacement`参数设置为`Cyclic`：

![image-20220827145512726](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827145512726.png?raw=true)

当选中了这个选项， the force and flux (or force and flux partial derivatives depending on the option chosen) must have identical first and last columns.

### （4）内插算法和外插算法

组件`Interpolation method`和`Extrapolation method`分别设置了内插算法和外插算法，用以输出给定点之外（区间内和区间外）的值：

![image-20220827144501646](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827144501646.png?raw=true)

另外，如果电磁学模型设置为`Define in terms of Phi(i,x)`，那么模块必须通过磁链数据首先估计`Flux partial derivative wrt displacement, dPhi(i,x)/dx`参数值。在进行估计时，模块首先使用`Interpolation method`所指定的插值方法。通常`Smmoth`选项更加准确，但是`Linear`更加稳定。

### （5）线圈阻抗和磁阻

组件的`Winding resistance`参数和`Magnetizing resistance`参数分别设置了线圈的电阻和磁阻：

![image-20220827145248204](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827145248204.png?raw=true)

`Winding resistance`的默认值是14 ohm，

磁阻的值必须要大于0，默认值是inf，表示没有铁损（iron losses）。

### （6）其他

用户可以设置$\Psi$和它的偏导数都只针对正电流，或者针对正电流和负电流均可。组件会根据用户给定的电流值进行判断。如果设定只针对正电流，那么模块将假设$\Psi(-i,x)=-\Psi(i,x)$。因此，如果电流向量都是正值，那么：

- 第一个电流的值必须为0；
- 零电流所对应磁链必须是0；
- 磁链对位移的偏导数在零电流处为0；

## 机械模型（Mechanical）

组件的机械模型就是一个简单的带有Hard stop的铁芯运动模型。

`Plunger mass`和`Dmaping`参数以及和一个外部的弹簧构成了一个质量-弹簧-阻尼系统：

![image-20220827150036548](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827150036548.png?raw=true)

![image-20220827150228828](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827150228828.png?raw=true)

`Minimum stroke` 和 `Maximum stroke`参数是铁芯范围，电磁模型中`Displacement vector`参数中传入的位移向量的最小值和最大值：

![image-20220827150426084](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827150426084.png?raw=true)

`Contact stiffness`参数和`Contact damping`参数的设置相当于在`Minimum stroke` 和 `Maximum stroke`的位置放置了一个刚体模型已实现Hard stop：

![image-20220827150557237](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827150557237.png?raw=true)

## 模型热效应（Model Thermal Effects）

当考虑模型的热效应时，需要将组件的`Modeling option`参数设置为`Show thermal port`：

![image-20220827132229317](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827132229317.png?raw=true)

之后，组件将多出一个H端口，用于连接其他模块。

![image-20220827132514450](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827132514450.png?raw=true)

参数设置部分也会多部分：`Temperature Dependence`，`Thermal Port`：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827133129968.png?raw=true" alt="image-20220827133129968" style="zoom: 67%;" />

thermal port的使用可以参考另一个示例[^6]。

<br>

# Linear Solenoid模型

该示例的另一个模型是Linear Solenoid模型：

![image-20220827160600571](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827160600571.png?raw=true)

该模型与博客[^2]中的电磁铁模型基本上是一致的，只有两点需要注意的差异。

## Hard stop

第一点是该实例的这个电磁铁模型构建了双端的Hard Stop，以模拟撞击停止：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827160825839.png?raw=true" alt="image-20220827160825839" style="zoom:67%;" /> 

![image-20220827160844674](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827160844674.png?raw=true)

这一点更为合理。

## L(x) 和 dL/dx

虽然该示例的线性电磁铁模型的L(x)和dL/dx仍然采用的PS Lookup Table(1D)模块进行描述，但是这里的L(x)是线性的：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827161214103.png?raw=true"/>

![image-20220827161612092](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827161612092.png?raw=true)

而博客[^2]中的模型采用的是非线性L(x)：

<figure class="half">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825135120035.png?raw=true">
    <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825135053982.png?raw=true">
    <figcaption><a href="http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/" title="(1) Profile of L(x); (2) Profile of dL/dx">(1) Profile of L(x); (2) Profile of dL/dx</a></figcaption>
</figure>
这里显然后者更为合理。

<br>

# 绘图代码文件

Simulink模型文件中的两个`See Code`超链接分别指向了两个.m绘图文件，分别是：`ee_solenoid_fem_plot1position.m`和`ee_solenoid_fem_params.m`文件。第一个文件用于绘制仿真结果，第二个文件则用于可视化磁链和其他相关数据，后者并不依赖于模型的运行，因此我们首先介绍`ee_solenoid_fem_params.m`所实现的功能。


## `ee_solenoid_fem_params.m`文件

### Part 1：导入数据

该文件的第一部分是导入数据：

```matlab
% Initialization for the Finite Element Parameterized Solenoid example,
% ee_solenoid_fem.slx.
% 
% It is assumed that the flux linkage and force as a function of current
% and distance are provided by a finite element magnetic field package.
% Flux linkage is the product of flux and the number of turns.
% Sometimes inductance is given instead of flux. Inductance may be quoted
% as total inductance (inductance per turn times number of turns) or
% inductance per turn. You can obtain the flux linkage by multiplying each
% total inductance data point by the corresponding current.

% Copyright 2009-2018 The MathWorks, Inc.

% Vector of currents for which data is defined
current = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]; % A
% Vector of displacements for which data is defined
x = [0 0.05 0.1 0.15 0.2]*1e-3; % m
% Flux linkage, Phi(current,x)
flux_linkage = [0         0         0         0         0;
  8.4997e-003  7.9390e-003  7.4582e-003  7.0518e-003  6.7144e-003
  1.7097e-002  1.6045e-002  1.5133e-002  1.4349e-002  1.3683e-002
  2.5367e-002  2.3914e-002  2.2640e-002  2.1528e-002  2.0561e-002
  3.2966e-002  3.1222e-002  2.9675e-002  2.8304e-002  2.7086e-002
  3.9631e-002  3.7726e-002  3.6016e-002  3.4474e-002  3.3073e-002
  4.5179e-002  4.3263e-002  4.1519e-002  3.9916e-002  3.8420e-002
  4.9509e-002  4.7751e-002  4.6123e-002  4.4587e-002  4.3106e-002
  5.2600e-002  5.1190e-002  4.9847e-002  4.8527e-002  4.7188e-002
  5.4509e-002  5.3657e-002  5.2789e-002  5.1855e-002  5.0807e-002
  5.5379e-002  5.5314e-002  5.5130e-002  5.4770e-002  5.4181e-002];
% Force(current,x)
force = [0      0      0      0      0;
        -0.6   -0.5   -0.4   -0.3   -0.3;
        -2.3   -2.0   -1.7   -1.4   -1.2;
        -4.9   -4.3   -3.7   -3.2   -2.7;
        -8.3   -7.3   -6.4   -5.5   -4.7;
        -12.2  -10.7   -9.4   -8.2   -7.2;
        -16.2  -14.4  -12.7  -11.3  -10.0;
        -20.0  -17.9  -15.9  -14.3  -12.9;
        -23.3  -20.9  -18.8  -17.1  -15.7;
        -25.7  -23.1  -21.1  -19.4  -18.2;
        -26.5  -24.1  -22.2  -20.9  -20.1];
% Total winding resistance
R = 14;
% Hard stops for plunger range of travel
xmax = x(end);
xmin = x(1);
```

这里导入的数据，是和预加载文件`ee_solenoid_fem_data.mat`中的数据是一致的，其中比较重要的后面主要用到的变量是：

- 变量`current`：给定点的电流；
- 变量`x`：给定点的位移；
- 变量`flux_linkage`：表示$\Psi(x,i)$；
- 变量`force`：表示$F(x,i)$；

### Part 2：拟合$\Psi(x,i)$并绘制图像

代码的第二部分是根据给定点的电流`current`和位移`x`，以及`flux_linkage`进行最小二乘拟合。

首先，该文件所选择了一个多项式函数：

$$
\Psi(x,i)=a_0i^3+a_1xi^2+a_2i^2+a_3i+a_4x+a_5xi\label{eq4}
$$

之后求解了一个超定方程所对应的法线方程，得到系数向量的最小二乘解：

```matlab
% Calculate partial derivatives for block parameterization in terms of
% dPhi(i,x)/dx and dPhi(i,x)/di. To do this, use least squares to find
% a smooth differentiable function fit to flux.
[b,a]=meshgrid(x,current+1e-5); % 1e-5 offset to avoid zero current; b and a, 11-by-5
a=a(:); b=b(:); data_coeff = flux_linkage(:);% Unwrapped to column vectors
X = [a.^3 b.*a.^2 a.^2 a b a.*b]; % X, 55-by-6
Coeff = (X'*X)\(X'*data_coeff);% Solve normal equation to get least square solution, ie Coeff; Coeff, 6-by-1
flux_linkage2 = reshape(X*Coeff,length(current),length(x));% flux_linkage2, 11-by-5.
```

Note: 关于最小二乘法的描述见参考博客[^5]。
{: .notice--primary}

最终绘制出真实的磁链数据图像以及多项式拟合图像：

```matlab
% Figure 1
if ~exist('h2_ee_solenoid_fem', 'var') || ...
        ~isgraphics(h2_ee_solenoid_fem, 'figure')
    h2_ee_solenoid_fem = figure('Name', 'ee_solenoid_fem');
end
figure(h2_ee_solenoid_fem)
clf(h2_ee_solenoid_fem)
hold(gca, "on")
view(-37.5,30)
% Plot 'Flux linkage'
surf(x,current,flux_linkage,'FaceColor',[1 0 0],'FaceAlpha',0.5);
% Plot 'Polynomial fit'
surf(x,current,flux_linkage2,'FaceColor',[0 0 1],'FaceAlpha',0.5);
% Plot settings
title('Flux Linkage vs. Current and Displacement')
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('Flux linkage (Wb)')
axis([0 2e-4 0 1 0 0.06])
legend({'Flux Linkage Data','Polynomial Fit'},'Location','Best')
grid on
hold(gca, "off")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220827164330777.png?raw=true" alt="image-20220827164330777" style="zoom:67%;" />

### Part 3：计算并分别绘制$\partial\Psi/\partial i$和$\partial\Psi/\partial x$的图像

根据原有的磁链数据`flux_linkage`肯定是不能进行求偏导的，因为`flux_linkage`只是一些散点。但是根据上一部分使用MLE所拟合出的多项式函数$\eqref{eq4}$就可以求偏导，并且多项式求偏导是很简单的，这也是选多项式为插值函数的原因之一。

由式$\eqref{eq4}$可以得到：

$$
\dfrac{\partial\Psi(x,i)}{\partial x}=a_1x^2+a_4+a_5x
$$

$$
\dfrac{\partial\Psi(x,i)}{\partial i}=3a_0i^2+2a_1xi+2a_2i+a_3+a_5x\label{eq6}
$$

```matlab
% Calculate partial derivatives
zeros_like_b = zeros(length(b),1);
ones_like_b = ones(length(b),1);

dfluxdx = reshape([zeros_like_b, a.^2, zeros_like_b, zeros_like_b, ones_like_b, a]*Coeff,length(current),length(x));
dfluxdi = reshape([3.*a.^2, 2.*b.*a, 2.*a, ones_like_b, zeros_like_b, b]*Coeff,length(current),length(x));
dfluxdx(1,:)=zeros(1,5); % Set partial derivative to exactly zero for zero current, according to official document.


% Figure 2
if ~exist('h3_ee_solenoid_fem', 'var') || ...
        ~isgraphics(h3_ee_solenoid_fem, 'figure')
    h3_ee_solenoid_fem = figure('Name', 'ee_solenoid_fem');
end
figure(h3_ee_solenoid_fem)
clf(h3_ee_solenoid_fem)
surf(x,current,dfluxdi);
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('\partial\Phi/\partiali (Wb/A)')
title('Partial Derivative of Flux with Respect to Current')
axis([0 2e-4 0 1 0 0.1])


% Figure 3
if ~exist('h4_ee_solenoid_fem', 'var') || ...
        ~isgraphics(h4_ee_solenoid_fem, 'figure')
    h4_ee_solenoid_fem = figure('Name', 'ee_solenoid_fem');
end
figure(h4_ee_solenoid_fem)
clf(h4_ee_solenoid_fem)
surf(x,current,dfluxdx);
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('\partial\Phi/\partialx (Wb/m)')
title('Partial Derivative of Flux with Respect to Distance')
axis([0 2e-4 0 1 -35 0])
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220827194947911.png?raw=true" alt="image-20220827194947911" style="zoom:67%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220827194953964.png?raw=true" alt="image-20220827194953964" style="zoom:67%;" />

其中需要注意的一行代码是：

```matlab
dfluxdx(1,:)=zeros(1,5); % Set partial derivative to exactly zero for zero current, according to official document.
```

这个操作是很有必要的，因为这里的电流只有非负值，在上面提到过，这种情况下零电流处的各个值要额外注意。

### Part 4：计算在i=0.1 A时的L值和dL/dx值

代码的第4部分计算i=0.1 A时的L值和dL/dx值，这两个值是用于上面提到的`ee_solenoid_fen/Linear Solenoid/Calculate Force and Current`中的两个`PS Lookup Table(1D)`中的。

因为有关系式：

$$
\Psi=L(x)i
$$

上式两边对i求导，可以得到：

$$
\dfrac{\partial\Psi}{\partial i}=L(x)\label{eq8}
$$

因此：

$$
\dfrac{\partial\Psi}{\partial i}\Big\vert_{i=0.1}=L(x)\Big\vert_{i=0.1}
$$

另一方面，根据式$\eqref{eq6}$和式$\eqref{eq8}$可以得到：

$$
\dfrac{\mathrm{d}L(x)}{\mathrm{d}x}\Big\vert_{i=0.1}=(2a_1i+a_5)\Big\vert_{i=0.1}
$$

```matlab
% Calculate L and dL/dx for i=0.1A - used by simplified solenoid
L = dfluxdi(2,:);
dLdx = reshape([zeros_like_b, 2.*a, zeros_like_b, zeros_like_b, zeros_like_b, ones_like_b]*Coeff,length(current),length(x));
dLdx = dLdx(2,:);
```

### Part 5：模型其他参数值

这一部分和预加载文件`ee_solenoid_fem_data.mat`中的数据是也是一致的：

```matlab
x0 = 0.1e-3; % Initial plunger position
lambda = 20; % Plunger damping (N/(m/s))
mass = 0.1;  % Plunger mass (kg)
f_c = 1e6;   % Frequency up to which flux is differentiated
```

### Part 6：计算电磁力

如果FEM仿真软件只给出了磁链，而没有给出电磁力的值，那么需要根据式$\eqref{eq3}$进行数值积分。

本示例给出了电磁力数据`force`，这里只是将数值计算的结果与真实的网格数据做一个比较，并展现数值积分的过程。
{: .notice--primary}

此处在进行数值积分的时候，并没有使用之前最小二乘得到的结果，而是采用了一个二阶多项式拟合$\dfrac{\partial\Psi(x,i)}{\partial x}$，之后进行数值积分。

```matlab
% If the finite element only gives flux and not force, then force can be
% found by integrating the partial derivative of flux with respect to
% distance over current.
ord = 2; % Use 2nd order polynomial to fit dPhi/dx
p = zeros(length(current),ord+1);
for i=2:length(current)
    flux_x = flux_linkage(i,:);
    p(i,:) = polyfit(x,flux_x,ord); % Use 2th order polynomial
end
force2 = zeros(size(flux_linkage));
force_x = zeros(size(x));
for i=2:length(current)
    % Take average dPhi/dx for the two adjacent currents
    dflux_dx1 = polyval(polyder(p(i-1,:)),x);
    dflux_dx2 = polyval(polyder(p(i,:)),x);
    dflux_dx = (dflux_dx1+dflux_dx2)/2;
    % Integrate dPhi/dx over current to get incremental force
    force_x = force_x + (current(i)-current(i-1))*dflux_dx;
    force2(i,:) = force_x;
end
```

之后将FEM提供的电磁力与数值积分得到的电磁力做对比：

```matlab
% Figure 4
if ~exist('h5_ee_solenoid_fem', 'var') || ...
        ~isgraphics(h5_ee_solenoid_fem, 'figure')
    h5_ee_solenoid_fem = figure('Name', 'ee_solenoid_fem');
end
figure(h5_ee_solenoid_fem)
clf(h5_ee_solenoid_fem)
view(-37.5,30)
hold(gca, "on")
% Plot force imported from FEM tool
surf(x,current,abs(force),'FaceColor',[0 0 1],'FaceAlpha',0.5)
% Plot force calculated by numerical integration
surf(x,current,abs(force2),'FaceColor',[1 0 0],'FaceAlpha',0.5)
% Plot settings
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('Force (N)')
title('Force Magnitude vs. Current and Displacement')
axis([0 2e-4 0 1 0 30])
legend({'Data from FEM','Calculated'},'Location','Best')
grid on
hold(gca, "off")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220827204556104.png?raw=true" alt="image-20220827204556104" style="zoom:67%;" />

## `ee_solenoid_fem_plot1position.m`文件

`ee_solenoid_fem_plot1position.m`文件用于绘制仿真结果，包括**弹簧的**的位置以及电流的情况：

![image-20220828191913588](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220828191913588.png?raw=true)

但是我们更关心动铁芯的位移和电流的情况，因此我们修改一下代码：

```matlab
% Code to plot simulation results from ee_solenoid_fem
%% Plot Description:
%
% The plot below shows the difference in behavior between a linear solenoid
% model and a solenoid model parameterized with data provided from a finite
% element magnetic field modeling tool.

% Copyright 2016-2021 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
if ~exist('simlog_ee_solenoid_fem', 'var') || ...
        simlogNeedsUpdate(simlog_ee_solenoid_fem, 'ee_solenoid_fem') 
    sim('ee_solenoid_fem')
    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_ee_solenoid_fem', 'var') || ...
        ~isgraphics(h1_ee_solenoid_fem, 'figure')
    h1_ee_solenoid_fem = figure('Name', 'ee_solenoid_fem');
end
figure(h1_ee_solenoid_fem)
clf(h1_ee_solenoid_fem)

% Get simulation results
simlog_t = simlog_ee_solenoid_fem.Spring_FEM.x.series.time;
simlog_xFEM = simlog_ee_solenoid_fem.FEM_Parameterized_Linear_Actuator.x.series.values('mm');
simlog_xlin = simlog_ee_solenoid_fem.Linear_Solenoid.Position_Velocity_Force_Interface.Translational_Motion_Sensor.P.series.values('mm');
simlog_iFEM = simlog_ee_solenoid_fem.FEM_Parameterized_Linear_Actuator.i.series.values('A');
simlog_ilin = simlog_ee_solenoid_fem.Linear_Solenoid.R1.i.series.values('A');

% Plot results
simlog_handles(1) = subplot(2, 1, 1);
plot(simlog_t, simlog_xFEM, 'LineWidth', 1)
hold on
plot(simlog_t, simlog_xlin, 'LineWidth', 1)
hold off
grid on
title('Plunger Position')
ylabel('x(mm)')
legend({'FEM','Linear'},'Location','Best');

simlog_handles(2) = subplot(2, 1, 2);
plot(simlog_t, simlog_iFEM, 'LineWidth', 1)
hold on
plot(simlog_t, simlog_ilin, 'LineWidth', 1)
hold off
grid on
title('Solenoid Current')
ylabel('Current (A)')
xlabel('Time (s)')
legend({'FEM','Linear'},'Location','Best');

linkaxes(simlog_handles, 'x')

% Remove temporary variables
clear simlog_t simlog_handles
clear simlog_xFEM simlog_xlin simlog_iFEM simlog_ilin
```

![image-20220828192245220](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220828192245220.png?raw=true)

<br>

# 模型结果分析

## 磁饱和效应

这个模型和博客[^2]中电磁铁模型最主要的差别是本模型可以很好地捕捉磁饱和效应。这个示例的目的就是为了展现磁饱和效应。磁饱和效应最明显的现象就是，需要更大的电流才能产生和线性情况相同的磁场：

![image-20220828143915042](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220828143915042.png?raw=true)

以及当50N推到动铁芯时的电磁力变化：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220828144415581.png?raw=true" alt="image-20220828144415581" style="zoom: 67%;" />



## “虚假的”保持力（数值计算的误差）

博客[^2]中的电磁体模型有一个很重要的特点就是它在最终的位置没有保持力，当电磁铁停止通电后，动铁芯就会在弹簧力的作用下迅速向反方向运动。

在该示例的模型中，我们将开关换为一个方波信号，使电路在0.01 s通电，在0.02 s断电：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220828114347407.png?raw=true" alt="image-20220828114347407" style="zoom:67%;" />

并且去掉在0.06 s添加的50 N的作用力。之后，观察结果：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220828114706220.png?raw=true" alt="image-20220828114706220" style="zoom:67%;" />

可以看到在0.02 s断电后，电磁力能够在最终位置保持，但是也仅仅是保持一会儿，之后就会缓慢地向反方向移动。

如果我们延长仿真时间到2 s（并且相应修改Pulse开关的参数），则结果：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220828114950237.png?raw=true" alt="image-20220828114950237" style="zoom:67%;" />

可以看到，动铁芯最终会返回并且稳定在初始位置。

但是这里的保持力并不是我们所期望的保持力（永磁体所提供的保持力），因为电磁力是通过数据文件中的`force`变量所定义的，`force`变量的行表示电流，列表示位移：

![image-20220828133727244](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220828133727244.png?raw=true)

我们可以看到当电流切断，即电流$i=0$时，电磁力一定为零，并不存在保持力。

之所以我们可以看到一小段的保持现象，我认为有两部分原因：

（1）是数值计算的问题，因为FEM-Parameterized Linear Actuator组件采用了内插算法，因此在不是给定点的位置的值不是很准确。

（2）因为电磁力是施加于Mass-Spring-Damper系统的，因此它们之间的交互使得上述数值计算的问题进行了进一步的放大。

我们也可以通过FEM-Parameterized Linear Actuator组件电磁力的曲线看到这一点：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220828134509587.png?raw=true" alt="image-20220828134509587" style="zoom:67%;" />

当切断电流后，电磁力并没有立即变为0。

Note: 如果想要得到例如永磁体所产生的保持力，`force`变量的第一行一定不能都是零值：

![image-20220828134739949](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220828134739949.png?raw=true)

## 线圈电流的双峰以及振荡现象

博客[^2]中的电磁铁模型得到结果：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220825133727626.png?raw=true" alt="image-20220825133727626" style="zoom:50%;" />

其线圈电流表现出明显的双峰现象，并且电流曲线和位移曲线都表现出振荡的现象，而本示例的结果并没有很明显。

但是我们仔细观察本示例的结果，其实也可以看到类似的现象：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220828142332932.png?raw=true" alt="image-20220828142332932" style="zoom: 67%;" />

只是很不明显。不明显的原因的原因有两个方面：

（1）本示例的模型的运动距离是0.1 mm，而前者的运动距离5 mm，这使得双峰现象很不明显；

（2）由于运动距离过小，就导致速度很小，于是Mass-Spring-Damper系统的振荡现象就不明显；

<br>

**References**

[^1]: [Solenoid Parameterized with FEM Data - MathWorks](https://ww2.mathworks.cn/help/physmod/sps/ug/solenoid-parameterized-with-fem-data.html).
[^2]: [Simulate Solenoid in MATLAB Simulink - What a starry night~](https://helloworld-1017.github.io/2022-08-25/17-03-51.html).
[^3]:  [Simscape Electrical™ Solenoid - MathWorks](https://ww2.mathworks.cn/help/physmod/sps/ref/solenoid.html).
[^4]: [FEM-Parameterized Linear Actuator - MathWorks](https://ww2.mathworks.cn/help/physmod/sps/ref/femparameterizedlinearactuator.html).
[^5]: [Inspect the Least Square Method from Perspective of Curve Fitting, Parameter Estimation, and Geometry View of Solving Over-determined Equations - What a starry night~](https://helloworld-1017.github.io/2022-07-07/15-36-27.html).
[^6]: [Simulating Thermal Effects in Rotational and Translational Actuators](https://ww2.mathworks.cn/help/physmod/sps/ug/simulating-thermal-effects-in-rotational-and-translational-actuators.html).
