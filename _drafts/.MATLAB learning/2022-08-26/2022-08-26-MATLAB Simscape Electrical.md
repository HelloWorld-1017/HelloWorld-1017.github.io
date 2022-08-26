【MATLAB Simscape Electrical】

# 简介

[Solenoid Parameterized with FEM Data - MATLAB & Simulink - MathWorks 中国](https://ww2.mathworks.cn/help/physmod/sps/ug/solenoid-parameterized-with-fem-data.html)

这个模型展示了一个连接了复位弹簧(return spring)的有限行程电磁铁(limited travel solenoid)。当线圈回路不通电时，弹簧将铁芯保持在0.1mm处；在0.01s时，线圈通电，铁芯会运动到0mm处；在0.06s时，向动铁芯施加一个比保持力更大的力(10N)，在这个力的作用下，动铁芯会向反向运动，直到0.2mm处。

电磁力(solenoid force)和反磁动势特征(back emf characteristics)通过模型中的 `FEM-Parameterized Linear Actuator block`模块进行定义。

这个模块可以调用由有限元磁场建模工具输出的格式化数据。

参数化有两种方式，一种是直接使用磁链数据(flux data)，另一种是使用磁链对于电流和位移的偏微分。后者通常是更好的选择，它能在给定电流和位置提供处更准确的结果。但是，这种方式也需要更多的预处理步骤。

这个模型和[【MATLAB Simscape】电磁铁的电路-机械模型](http://whatastarrynight.com/programming/signals%20and%20systems/electromagnetism/MATLAB-Simscape-solenoid/)最主要的差别是本模型可以很好地捕捉磁饱和效应(magnetic saturation effects)，相反，后者假设电流和电磁力是线性关系。这个线性假设也是[Simscape Electrical™ Solenoid](https://ww2.mathworks.cn/help/physmod/sps/ref/solenoid.html)构建的基础。

原文： Conversely the Simscape example assumes a linear relationship between current and magnetic force. 这里表述不准确，电磁力$F$和电流$i$之间的关系是：$F=\dfrac12i^2\Big(\mathrm{d}L(x)/\mathrm{d}x\Big)$。
{: .notice--danger}

在这个模型中，子系统`Simplified solenoid with no saturation effects`是基于0.1A时的电磁铁电感数据进行参数化的。这个电感时磁链关于电流的偏微分（==所以是关于位置的函数？==），同样是通过初始文件进行计算的。



将该模型的结果与电磁铁线性模型作比较，可以看出磁饱和效应。



如果将供电电压从12V减少到1.4V，最终电流会稳定到0.1A，一旦电流稳定到这个值，那么两个模型的曲线将保持一致。









在电脑中找到`ee_solenoid_fem.slx`文件复制到当前文件夹中即可运行、编辑并保存。

![image-20220826145151878](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220826145151878.png)

![image-20220826150005970](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220826150005970.png)

可以看到，模型预加载了一个`ee_solenoid_fem_data.mat`，该文件中包含了模型的运行参数：

![image-20220826163902745](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220826163902745.png)

其中：

（1）变量 `current`

```matlab
current =

         0    0.1000    0.2000    0.3000    0.4000    0.5000    0.6000    0.7000    0.8000    0.9000    1.0000
```



（2）变量 `x`

```matlab
x =
   1.0e-03 *
         0    0.0500    0.1000    0.1500    0.2000
```



（3）

也把这个文件复制到当前文件夹中。`ee_solenoid_fem_data.mat`中包含了

