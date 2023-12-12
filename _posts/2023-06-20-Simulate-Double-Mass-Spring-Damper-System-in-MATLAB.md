---
layout: single
title: Simulate Double Mass-Spring-Damper System in MATLAB
date: 2023-06-20 19:40:31 +0800
categories: 
 - MATLAB
 - Signals and Systems
tags:
 - MATLAB Simulink
modified_at1: 2023-12-09 01:32:35 +0800
modified_at2: 2023-12-09 21:24:33 +0800
last_modified_at: 2023-12-09 21:24:33 +0800
---

# Introduction to Double Mass-Spring-Damper System

## Basic concepts

两个质量-弹簧-阻尼系统 [^1] 连接在一起就可以得到一个二自由度的质量-弹簧-阻尼系统：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230620083127863.png?raw=true" alt="image-20230620083127863" style="zoom:50%;" />

对两个质量块分别列写动量守恒方程可以得到：

$$
\begin{split}
&F_1-k_1x_1-b_1v_1-k_2(x_1-x_2)-b_2(v_1-v_2)=m_1a_1\\
&F_2-k_2(x_2-x_1)-b_2(v_2-v_1)=m_1a_2\\
\end{split}\label{eq0}
$$

当（1）$k_1=k_2=k$，且$b_1=b_2=b$；（2）$F_1=F_2=0$；（3）$m_1=m_2=m$时，有：

$$
\begin{split}
&-kx_1-bv_1-k(x_1-x_2)-b(v_1-v_2)=ma_1\\
&-k(x_2-x_1)-b(v_2-v_1)=ma_2\\
\end{split}\label{eq1}
$$

若系统的初始条件为两个弹簧的形变量为$x_0=1\ \mathrm{m}$，则根据系统方程$\eqref{eq1}$，就可以搭建出相对应的Simulink仿真模型 [^1]：

![image-20230619153329559](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230619153329559.png?raw=true)

并得到质量块的位置与速度随时间的变化曲线：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230619160411359.png?raw=true" alt="image-20230619160411359" style="zoom:67%;" />

> 注：上面的模型取自MATLAB官方示例 [^2] 的一部分：
>
> ![image-20230620194555104](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620194555104.png?raw=true)
>
> 按照作者的原意，两个弹簧的初始状态应该都为`x0=1`，其中Simulink模型似乎是设置错误。后面我就主要以初始状态均为`x0=1`的i情况进行分析。

由波形曲线可以看到，两个质量块最终会稳定在$x=0\ \mathrm{m}$处，速度会稳定在$v=0\ \mathrm{m/s}$。因此，关于该仿真模型我们可以得到以下结论：

（1）质量体是理想的，是一个无穷小的质点，仅仅有质量这一个参数而没有体积，因而也就不占有长度；

（2）弹簧是理想的，当弹簧的形变量为零时就是一个“点”，而当弹簧的形变量为负数时，则弹簧向负方向延伸；

（3）墙体也是理想的，因为两个质量块的位移可以是负数（下文将会提到，这个位移实际上是弹簧的形变量）。

## Discussion 1

实际上，上面的示例得到的并非是“质量块位置”随时间的变化曲线，而是“弹簧形变量”随时间的变化曲线。如果想要得到“弹簧形变量”随时间的变化曲线，则可以在弹簧形变量的基础上增加一些常数的偏置。例如，假设弹簧的原长为`5`，质量块的直径为`0.5`：

![image-20230620174421406](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620174421406.png?raw=true)

两个质量块的位置波形如下图所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620174432244.png?raw=true" alt="image-20230620174432244" style="zoom: 67%;" />

可以看到最终质量块1最终稳定在`5.5`处，质量块2最终稳定在`11`处。

## Discussion 2

如果二自由度的质量-弹簧-阻尼系统垂直摆放：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620175154339.png?raw=true" alt="image-20230620175154339" style="zoom:50%;" />

则在整个运动过程中都会受到重力的影响。根据式$\eqref{eq1}$，有：

$$
\begin{split}
&m\mathrm{g}-kx_1-bv_1-k(x_1-x_2)-b(v_1-v_2)=ma_1\\
&m\mathrm{g}-k(x_2-x_1)-b(v_2-v_1)=ma_2\\
\end{split}\label{eq4}
$$

因此只需要在模型中添加重力的常数项（为负值）即可：

![image-20230620174624434](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620174624434.png?raw=true)

两个质量块的位置的实际波形为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620174741549.png?raw=true" alt="image-20230620174741549" style="zoom: 67%;" />

最终，质量块1的实际位置稳定在`5.3234`，质量块2的实际位置稳定在`10.5585`。

我们可以简单验证一下这个结果。当系统稳定时，根据式$\eqref{eq4}$有：

$$
\begin{split}
&m\mathrm{g}-kx_1-k(x_1-x_2)=0\\
&m\mathrm{g}-k(x_2-x_1)=0\\
\end{split}
$$

在该模型中，质量体的质量`m`为`3.6`，弹簧的弹性系数`k`为`400`，由此可以解得弹簧的形变量：

$$
\begin{split}
&x_1=0.17658\\
&x_2=0.26487\\
\end{split}
$$

由此可以获得质量体1和质量体2的实际位置：

$$
\begin{split}
&P_1=5.5-0.17658=5.32342\\
&P_2=11-0.17658-0.26487=10.55855\\
\end{split}\notag
$$

与仿真的结果是一致的。

## Discussion 3

从上面的过程中可以看到，Simulink中主要求解的是**弹簧形变量**这一变量。如果我们想要像上文一样得到与实际位置对应的变量，加减一些常数、注意一下系统的参考方向即可。例如，假如我们想要仿真这样一个模型：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620184428652.png?raw=true" alt="image-20230620184428652" style="zoom:50%;" />

则需要做以下的修改：

![image-20230621154606911](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230621154606911.png?raw=true)

得到的位置波形为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620190336362.png?raw=true" alt="image-20230620190336362" style="zoom: 67%;" />

质量块1的实际位置稳定在`94.3234`（100-5.5-0.17658），质量块2的实际位置稳定在`88.5585`（100-2*5.5-0.26487-0.17658）。

<br>

# Simulating using State Space Function

如果我们将二自由度的质量-弹簧-阻尼系统的位置和速度作为状态向量$\mathrm{\boldsymbol{z}}$作为状态向量：

$$
\begin{bmatrix}
z_1\\
z_2\\
z_3\\
z_4\\
\end{bmatrix}=
\begin{bmatrix}
x_1\\
v_1\\
x_2\\
v_2\\
\end{bmatrix}
$$

则根据式$\eqref{eq0}$有：

$$
\begin{split}
&\dot{z}_1=z_2\\
&\dot{z}_2=\dfrac1{m_1}\Big[F_1-(k_1+k_2)z_1-(b_1+b_2)z_2+k_2z_3+b_2z_4\Big]\\
&\dot{z}_3=z_4\\
&\dot{z}_4=\dfrac1{m_2}\Big[F_2+k_2z_1+b_2z_2-k_2z_3-b_2z_4\Big]
\end{split}
$$

进而可以写作：

$$
\begin{split}
\begin{bmatrix}
\dot{z}_1\\
\dot{z}_2\\
\dot{z}_3\\
\dot{z}_4\\
\end{bmatrix}&=
\begin{bmatrix}
0&1&0&0\\
-\dfrac{k_1+k_2}{m_1}&-\dfrac{b_1+b_2}{m_1}&\dfrac{k_2}{m_1}&\dfrac{b_2}{m_1}\\
0&0&0&1\\
\dfrac{k_2}{m_2}&\dfrac{b_2}{m_2}&-\dfrac{k_2}{m_2}&-\dfrac{b_2}{m_2}
\end{bmatrix}
\begin{bmatrix}
z_1\\
z_2\\
z_3\\
z_4\\
\end{bmatrix}+
\begin{bmatrix}
0&0\\
\dfrac1{m_1}&0\\
0&0\\
0&\dfrac1{m_2}
\end{bmatrix}
\begin{bmatrix}
F_1\\
F_2\\
\end{bmatrix}=A\cdot z+B\cdot u
\end{split}
$$

其中，$A$为系统的**状态矩阵**，$B$为**输入矩阵**，$u$为**输入（控制）向量**。

假设我们只对质量块的位置感兴趣，则有：

$$
y=C(A\cdot z+B\cdot u)+Du
$$

其中，$y$为**输出向量**，$C$为**输出矩阵**：

$$
y=\begin{bmatrix}
y_1\\
y_2\\
\end{bmatrix},\quad 
C=\begin{bmatrix}
1&0&0&0\\
0&0&1&0\\
\end{bmatrix},\quad
D = 
\begin{bmatrix}
0&0\\
0&0\\
\end{bmatrix}\label{eq3}
$$


带入模型的参数后：

$$
A=\begin{bmatrix}
0&1&0&0\\
-\dfrac{2k}{m}&-\dfrac{2b}{m}&\dfrac{k}{m}&\dfrac{b}{m}\\
0&0&0&1\\
\dfrac{k}{m}&\dfrac{b}{m}&-\dfrac{k}{m}&-\dfrac{b}{m}
\end{bmatrix}\notag
$$

$$
B=\begin{bmatrix}
0&0\\
\dfrac1m&0\\
0&0\\
0&\dfrac1m
\end{bmatrix}\notag
$$

矩阵$C$和矩阵$D$的取值与$\eqref{eq3}$是一致的。

在计算得到以上的参数后，我们就可以使用Simulink中的线性状态空间模块`State-Space`[^4] [^5] 进行建模：

![image-20230620192920475](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620192920475.png?raw=true)

其中`State-Space`模块的设置如下：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620193022838.png?raw=true" alt="image-20230620193022838" style="zoom: 67%;" />

两种模型得到的结果是完全一致的：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230620193130104.png?raw=true" alt="image-20230620193130104" style="zoom: 67%;" />

<br>

**References**

[^1]: [Mass-Spring-Damper Simulation in MATLAB - What a starry night~](https://helloworld-1017.github.io/2023-06-19/14-51-29.html).
[^2]: [Double Mass-Spring-Damper in Simulink and Simscape - MathWorks](https://ww2.mathworks.cn/help/simscape/ug/double-mass-spring-damper-in-simulink-and-simscape.html).
[^4]: [Implement linear state-space system - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/statespace.html).
[^5]: [Double Spring Mass System - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/double-spring-mass-system.html).

-  [Spring-Mass-Damper System, 2DOF - YouTube](https://www.youtube.com/watch?v=s5zO2fuiW7c).
-  [二自由度质量-弹簧-阻尼串联系统的Simulink仿真 - 知乎](https://zhuanlan.zhihu.com/p/104566650).
