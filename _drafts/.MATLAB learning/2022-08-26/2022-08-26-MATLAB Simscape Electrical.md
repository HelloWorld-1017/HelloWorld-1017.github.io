【MATLAB Simscape Electrical】

# 简介

[Solenoid Parameterized with FEM Data - MATLAB & Simulink - MathWorks 中国](https://ww2.mathworks.cn/help/physmod/sps/ug/solenoid-parameterized-with-fem-data.html)

这个模型展示了一个连接了复位弹簧(return spring)的有限行程电磁铁(limited travel solenoid)。当线圈回路不通电时，弹簧将铁芯保持在0.1mm处；在0.01s时，线圈通电，铁芯会运动到0mm处；在0.06s时，向动铁芯施加一个比保持力更大的力(10N)，在这个力的作用下，动铁芯会向反向运动，直到0.2mm处。

电磁力(solenoid force)和反电动势特征(back emf characteristics)通过模型中的 `FEM-Parameterized Linear Actuator block`模块进行定义。

这个模块可以调用由有限元磁场建模工具输出的格式化数据。



这个模型和[【MATLAB Simscape】电磁铁的电路-机械模型](http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/)最主要的差别是本模型可以很好地捕捉磁饱和效应(magnetic saturation effects)，相反，后者假设电流和电磁力是线性关系。这个线性假设也是[Simscape Electrical™ Solenoid](https://ww2.mathworks.cn/help/physmod/sps/ref/solenoid.html)构建的基础。

原文： Conversely the Simscape example assumes a linear relationship between current and magnetic force. 这里表述不准确，电磁力$F$和电流$i$之间的关系是：$F=\dfrac12i^2\Big(\mathrm{d}L(x)/\mathrm{d}x\Big)$。
{: .notice--danger}

在这个模型中，子系统`Simplified solenoid with no saturation effects`是基于0.1A时的电磁铁电感数据进行参数化的。这个电感时磁链关于电流的偏微分（==所以是关于位置的函数？==），同样是通过初始文件进行计算的。



将该模型的结果与电磁铁线性模型作比较，可以看出磁饱和效应。



如果将供电电压从12V减少到1.4V，最终电流会稳定到0.1A，一旦电流稳定到这个值，那么两个模型的曲线将保持一致。









在电脑中找到`ee_solenoid_fem.slx`文件复制到当前文件夹中即可运行、编辑并保存。

![image-20220826145151878](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220826145151878.png)

![image-20220826150005970](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220826150005970.png)

## 预加载数据文件

可以看到，模型预加载了一个`ee_solenoid_fem_data.mat`，该文件中包含了模型的运行参数：

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



（10）变量 `flux_linkage`

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220826201555904.png" alt="image-20220826201555904" style="zoom:50%;" />

（11）变量 `L`

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

## 电磁学模型

### 参数化的两种方式

该组件参数化有两种方式，一种是直接使用磁链数据(flux data)，另一种是使用磁链对电流和位移的偏微分。后者通常是更好的选择，它能在给定电流和位置提供处更准确的结果。但是，这种方式也需要更多的预处理步骤。

![image-20220826195935803](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220826195935803.png)

第一种直接使用磁链数据的方式依据的就是法拉第电磁感应定律：
$$
U=iR+\dfrac{\mathrm{d}\Psi(x,i)}{\mathrm{d}t}\label{eq1}
$$
基于链式求导法则对式$\eqref{eq1}$进行展开：
$$
U=iR+\dfrac{\partial\Psi}{\partial x}\dfrac{\mathrm{d}x}{\mathrm{d}t}+\dfrac{\partial\Psi}{\partial i}\dfrac{\mathrm{d}i}{\mathrm{d}t}\label{eq2}
$$
该式就是第二种方式所依据的计算方程。

从数值计算的角度看，第二种方式更好，因为反电动势是分段连续的(piecewise continuous)，如果直接使用磁链数据，选择更合理的电流和位移网格尺寸、选择三次插值或样条插值可以改善结果。

### 电磁力的两种计算方式

无论使用上述哪种方式，都有两种指定电磁力的方式：

（1）直接基于**Force matrix，F(i,x)**，将电磁力设置为电流和位移的方程；

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220827114954823.png" alt="image-20220827114954823" style="zoom:50%;" />

（2）使用模块自动计算force matrix.

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220827115025907.png" alt="image-20220827115025907" style="zoom:50%;" />



如果直接使用电磁力数据，可以直接使用FEM工具所导出的数据，也可以通过下面的公式进行计算：
$$
F=\int^i_0\dfrac{\partial\Psi(x,i)}{\partial x}\mathrm{d}i\label{eq3}
$$
==这个公式什么原理？==

该模块还可以从用户所提供的数据自动计算force matrix。将 `Calculate force matrix?`选项选为`Yes`，模块就会再模型初始化时基于当前磁链信息计算force matrix。计算方法方式是对$\eqref{eq3}$进行数值积分。





如果电磁学模型设置为`Define in terms of Phi(i,x)`，那么模块必须通过磁链数据首先估计`flux information`参数值。当选用这种方式时，模块首先使用`Interpolation method`所指定的插值方法。通常`Smmoth`选项更加准确，但是`Linear`更加稳定。



用户可以设置$\Psi$和它的偏导数都只针对正电流，或者针对正电流和负电流均可。
