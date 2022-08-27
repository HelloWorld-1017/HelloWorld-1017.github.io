【MATLAB Simscape Electrical】

# 简介

[Solenoid Parameterized with FEM Data - MATLAB & Simulink - MathWorks 中国](https://ww2.mathworks.cn/help/physmod/sps/ug/solenoid-parameterized-with-fem-data.html)

这个模型展示了一个连接了复位弹簧(return spring)的有限行程电磁铁(limited travel solenoid)。当线圈回路不通电时，弹簧将铁芯保持在0.1mm处；在0.01s时，线圈通电，铁芯会运动到0mm处；在0.06s时，向动铁芯施加一个比保持力更大的力(10N)，在这个力的作用下，动铁芯会向反向运动，直到0.2mm处。

电磁力(solenoid force)和反电动势特征(back emf characteristics)通过模型中的 `FEM-Parameterized Linear Actuator block`模块进行定义。该模块可以调用由有限元磁场建模工具输出的格式化数据。



这个模型和[【MATLAB Simscape】电磁铁的电路-机械模型](http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/)最主要的差别是本模型可以很好地捕捉磁饱和效应(magnetic saturation effects)，相反，后者假设电流和电磁力是线性关系。这个线性假设也是[Simscape Electrical™ Solenoid](https://ww2.mathworks.cn/help/physmod/sps/ref/solenoid.html)构建的基础。

原文： Conversely the Simscape example assumes a linear relationship between current and magnetic force. 这里表述不准确，电磁力$F$和电流$i$之间的关系是：$F=\dfrac12i^2\Big(\mathrm{d}L(x)/\mathrm{d}x\Big)$。
{: .notice--danger}

在这个模型中，子系统`Simplified solenoid with no saturation effects`是基于0.1A时的电磁铁电感数据进行参数化的。这个电感时磁链关于电流的偏导数（==所以是关于位置的函数？==），同样是通过初始文件进行计算的。



将该模型的结果与电磁铁线性模型作比较，可以看出磁饱和效应。



如果将供电电压从12V减少到1.4V，最终电流会稳定到0.1A，一旦电流稳定到这个值，那么两个模型的曲线将保持一致。









在电脑中找到`ee_solenoid_fem.slx`文件复制到当前文件夹中即可运行、编辑并保存。

![image-20220826145151878](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220826145151878.png)



## 预加载数据文件

在模型的`PreLoadFcn`函数中可以看到：

![image-20220826150005970](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220826150005970.png)

模型预加载了一个`ee_solenoid_fem_data.mat`，该文件中包含了模型的运行参数：

![image-20220826163902745](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220826163902745.png)

其中：

（1）变量 `current`

```matlab
current =

         0    0.1000    0.2000    0.3000    0.4000    0.5000    0.6000    0.7000    0.8000    0.9000    1.0000
```



（2）变量 `x`，`xmin`，`xmax`

```matlab
x =
   1.0e-03 *
         0    0.0500    0.1000    0.1500    0.2000
```
```matlab
xmin =
     0
```

```matlab
xmax =
   2.0000e-04
```



（3）变量 `dfluxdi` 

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220826200111158.png" alt="image-20220826200111158" style="zoom:50%;" />

（4）变量 `dfluxdx`

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220826200450424.png" alt="image-20220826200450424" style="zoom:50%;" />

（5）变量`force`

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220826200620400.png" alt="image-20220826200620400" style="zoom:50%;" />

（6）变量 `R`

```matlab
R =
    14
```

（7）变量 `lambda`

```matlab
lambda =
    20
```

（8）变量 `mass`

```matlab
mass =
    0.1000
```

（9）变量 `flux_linkage`

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220826201555904.png" alt="image-20220826201555904" style="zoom:50%;" />

（10）变量 `L`

```matlab
L =
    0.0877    0.0828    0.0780    0.0732    0.0683
```

# FEM-Parameterized Linear Actuator 组件

<figure>
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220827111006159.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220827111019193.png">
    <figcaption>The (a) Settings and (b) Description of FEM-parameterized Linear Actuator component.</figcaption>
</figure>
该组件的官方介绍文档见：[FEM-Parameterized Linear Actuator](https://ww2.mathworks.cn/help/physmod/sps/ref/femparameterizedlinearactuator.html)。该组件的各个参数都有默认值，但这里用的是`ee_solenoid_fem_data.mat`中的数据。

## 电磁学模型(Magnetic Force)

该组件的电磁学模型最终目的是计算Magnetic Force，根据用户的需要，组件提供了两个一级选项，分别是：

- `Electrical model`，用于选择磁链数据的使用方式。

- `Calculate force matrix`，用于选择电磁力的计算；

此外，还需要指定其他一些计算参数，下面分别对这些设置进行介绍。

### （1）使用磁链的两种方式

该组件使用磁链数据有两种方式，一种是直接使用磁链数据(flux data)，另一种是使用磁链对电流和位移的偏导数，通过设置`Electrical model`进行选择。

#### 直接使用磁链数据

当设置为`Define in terms of Phi(i,x)`时，为直接使用磁链数据，特有的子参数为`Flux linkage matrix, Phi(i,x)`：

![image-20220827134608116](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827134608116.png)

这种方式依据的就是法拉第电磁感应定律：
$$
U=iR+\dfrac{\mathrm{d}\Psi(x,i)}{\mathrm{d}t}\label{eq1}
$$

用户通过向`Flux linkage matrix, Phi(i,x)`提供$\Psi(x,i)$即可。

#### 使用磁链对电流和位移的偏导数

当设置为`Define in terms of dPhi(i,x)/dx and dPhi(i,x)/di`时，为使用磁链对电流和位移的偏导数，特有的子参数为：`Flux partial derivative wrt current, dPhi(i,x)/di`和`Flux partial wrt displacement, dPhi(i,x)/dx`：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827134802234.png" alt="image-20220827134802234"  />

基于链式求导法则对式$\eqref{eq1}$进行展开：
$$
U=iR+\dfrac{\partial\Psi}{\partial x}\dfrac{\mathrm{d}x}{\mathrm{d}t}+\dfrac{\partial\Psi}{\partial i}\dfrac{\mathrm{d}i}{\mathrm{d}t}\label{eq2}
$$
该式就是第二种方式所依据的计算方程。

用户通过向`Flux partial derivative wrt current, dPhi(i,x)/di`参数和`Flux partial wrt displacement, dPhi(i,x)/dx`参数提供$\dfrac{\partial\Psi}{\partial x}$和$\dfrac{\partial\Psi}{\partial x}$即可。

#### 两种方式的比较

从数值计算的角度看，第二种方式通常是更好的选择，因为反电动势是分段连续的(piecewise continuous)，它能在给定电流和位置提供处更准确的结果。但是，这也需要更多的预处理步骤。如果直接使用磁链数据，选择更合理的电流和位移网格尺寸、选择三次插值或样条插值可以改善结果。

### （2）电磁力的两种计算方式

无论使用什么样的电磁学模型，都需要指定电磁力的计算方式。电磁力是电磁学模型计算的最终目的，也是和机械部分耦合的纽带。

电磁力的计算有两种方式，通过设置一级选项`Calculate force matrix`进行选择。

#### 直接基于Force matrix

将`Calculate force matrix`设置为`No`，表示直接使用Force matrix，而不进行计算，这种模式的特有子参数是`Force matrix, F(i,x)`：

![image-20220827142331204](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827142331204.png)

用户通过向参数`Force matrix, F(i,x)`传入数据将电磁力设置为电流和位移的方程。

如果直接使用电磁力数据，可以直接使用FEM工具所导出的数据，也可以通过下面的公式进行计算：

$$
F=\int^i_0\dfrac{\partial\Psi(x,i)}{\partial x}\mathrm{d}i\label{eq3}
$$

==这个公式什么原理？==

#### 模块自动计算force matrix

将`Calculate force matrix`设置为`Yes`，表示令模块自动计算Force matrix：

![image-20220827142248109](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827142248109.png)

在模型初始化时，该模式基于模块的磁链信息计算Force matrix，计算方法方式是对$\eqref{eq3}$进行数值积分。

### （3）`Flux dependence on displacement`参数

为了对linear motor with a repeated flux pattern进行建模，需要将`Flux dependence on displacement`参数设置为`Cyclic`：

![image-20220827145512726](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827145512726.png)

当选中了这个选项， the force and flux (or force and flux partial derivatives depending on the option chosen) must have identical first and last columns.

### （4）内插算法和外插算法

组件`Interpolation method`和`Extrapolation method`分别设置了内插算法和外插算法，用以输出给定点之外（区间内和区间外）的值：

![image-20220827144501646](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827144501646.png)

另外，如果电磁学模型设置为`Define in terms of Phi(i,x)`，那么模块必须通过磁链数据首先估计`Flux partial derivative wrt displacement, dPhi(i,x)/dx`参数值。在进行估计时，模块首先使用`Interpolation method`所指定的插值方法。通常`Smmoth`选项更加准确，但是`Linear`更加稳定。

### （5）线圈阻抗和磁阻

组件的`Winding resistance`参数和`Magnetizing resistance`参数分别设置了线圈的电阻和磁阻：

![image-20220827145248204](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827145248204.png)

`Winding resistance`的默认值是14 ohm，

磁阻的值必须要大于0，默认值是inf，表示没有铁损(iron losses)。

### （6）其他

用户可以设置$\Psi$和它的偏导数都只针对正电流，或者针对正电流和负电流均可。组件会根据用户给定的电流值进行判断。如果设定只针对正电流，那么模块将假设$\Psi(-i,x)=-\Psi(i,x)$。因此，如果电流向量都是正值，那么：

- 第一个电流的值必须为0；
- 零电流所对应磁链必须是0；
- 磁链对位移的偏导数在零电流处为0；

## 机械模型(Mechanical)

组件的机械模型就是一个简单的带有Hard stop的铁芯运动模型。

`Plunger mass`和`Dmaping`参数以及和一个外部的弹簧构成了一个质量-弹簧-阻尼系统：

![image-20220827150036548](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827150036548.png)

![image-20220827150228828](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827150228828.png)

`Minimum stroke` 和 `Maximum stroke`参数是铁芯范围，电磁模型中`Displacement vector`参数中传入的位移向量的最小值和最大值：

![image-20220827150426084](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827150426084.png)

`Contact stiffness`参数和`Contact damping`参数的设置相当于在`Minimum stroke` 和 `Maximum stroke`的位置放置了一个刚体模型已实现Hard stop：

![image-20220827150557237](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827150557237.png)





## 模型热效应(Model Thermal Effects)

当考虑模型的热效应时，需要将组件的`Modeling option`参数设置为`Show thermal port`：

![image-20220827132229317](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827132229317.png)

之后，组件将多出一个H端口，用于连接其他模块。

![image-20220827132514450](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827132514450.png)

参数设置部分也会多部分：`Temperature Dependence`，`Thermal Port`：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827133129968.png" alt="image-20220827133129968" style="zoom: 67%;" />

thermal port的使用可以参考另一个示例：[Simulating Thermal Effects in Rotational and Translational Actuators](https://ww2.mathworks.cn/help/physmod/sps/ug/simulating-thermal-effects-in-rotational-and-translational-actuators.html)。

## 总结

该示例中基于FEM仿真数据的电磁铁模型仅仅包含这样一个FEM-Parameterized Linear Actuator组件和一个Spring组件：

![image-20220827151257870](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827151257870.png)

因此，理解好FEM-Parameterized Linear Actuator组件的运行原理就掌握了这个电磁铁模型。

# Linear Solenoid模型

该示例的另一个模型是Linear Solenoid模型：

![image-20220827160600571](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827160600571.png)

该模型与[【MATLAB Simscape】电磁铁的电路-机械模型](http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/)中的电磁铁模型基本上是一致的，只有两点需要注意的差异。

## Hard stop

第一点是该实例的这个电磁铁模型构建了双端的Hard Stop，以模拟撞击停止：

![image-20220827160825839](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827160825839.png) 

![image-20220827160844674](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827160844674.png)

这一点更为合理。

## L(x) 和 dL/dx

虽然该示例的线性电磁铁模型的L(x)和dL/dx仍然采用的PS Lookup Table(1D)进行描述，但是这里的L(x)是线性的：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827161214103.png"/>

![image-20220827161612092](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827161612092.png)

而 [【MATLAB Simscape】电磁铁的电路-机械模型](http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/)中采用的是非线性L(x)：

<figure class="half">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825135120035.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220825135053982.png">
    <figcaption><a href="http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/" title="(1) Profile of L(x); (2) Profile of dL/dx">(1) Profile of L(x); (2) Profile of dL/dx</a></figcaption>
</figure>

这里显然后者更为合理。

# 代码文件

Simulink模型文件中的两个`See Code`超链接分别指向了两个.m绘图文件，分别是：`ee_solenoid_fem_plot1position.m`和`ee_solenoid_fem_params.m`文件。第一个文件用于绘制仿真结果，第二个文件则用于可视化磁链和其他相关数据。

## `ee_solenoid_fem_plot1position.m`文件



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
f(x,i)=a_0i^3+a_1xi^2+a_2i^2+a_3i+a_4x+a_0xi\label{eq4}
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

关于最小二乘法的描述见：[从曲线拟合、参数估计角度、超定方程求解的几何角度看最小二乘法](http://whatastarrynight.com/mathematics/MLE/)。
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

![image-20220827164330777](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220827164330777.png)

### Part 3：计算并分别绘制$\partial\Psi/\partial i$和$\partial\Psi/\partial x$的图像

根据原有的磁链数据`flux_linkage`肯定是不能进行求偏导的，因为`flux_linkage`只是一些散点。但是根据上一部分使用MLE所拟合出的多项式函数$\eqref{eq4}$就可以求偏导。

由式$\eqref{eq4}$可以得到：
$$
\dfrac{\partial f(x,i)}{\partial x}=
$$




