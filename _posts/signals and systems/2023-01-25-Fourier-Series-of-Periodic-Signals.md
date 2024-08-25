---
layout: single
title:  Fourier Series of Periodic Signals
date: 2023-01-25 17:25:27 +0800
categories: 
 - Signals and Systems
 - MATLAB
tags:
 - MATLAB Signal Processing Toolbox
---

# Introduction

在博客[Orthogonal Decomposition of Signals](http://whatastarrynight.com/signals%20and%20systems/Orthogonal-Decomposition-of-Signals/)中，我们推导了信号的傅里叶级数：

> 任意信号$f(t)$可以表示为无穷多个正交函数之和，即表示为广义傅里叶级数：
>
> $$
> f(t)=C_1\varphi_1(t)+\cdots+C_i\varphi_i(t)+\cdots=\sum_{i=1}^\infty C_i\varphi_i(t)
> $$
>
> 其中，$C_i$称为广义傅里叶系数：
>
> 若$\varphi_i(t)$为实变函数，有：
>
> $$
> C_i=\dfrac{\int_{t_1}^{t_2}f(t)\varphi_i(t)\mathrm{d}t}{\int_{t_1}^{t_2}\varphi_i^2(t)\mathrm{d}t}=\dfrac{1}{K_i}\int_{t_1}^{t_2}f(t)\varphi_i(t)\mathrm{d}t\label{eq2}
> $$
> 
> 若$\varphi_i(t)$为复变函数，有：
>
> $$
> C_i=\dfrac{\int_{t_1}^{t_2}f(t)\varphi_i^*(t)\mathrm{d}t}{\int_{t_1}^{t_2}\varphi_i(t)\varphi_i^*(t)\mathrm{d}t}=\dfrac{1}{K_i}\int_{t_1}^{t_2}f(t)\varphi_i^*(t)\mathrm{d}t\label{eq3}
> $$

并且提到了两个完备正交函数集合：

> 两组典型的在区间$(t_0,t_0+T)(T=2\pi/\Omega)$上的完备正交函数集：
>
> （1）三角函数集（实数集）：$\{1,\cos(n\Omega t), \sin(n\Omega t), \cdots\}(n=1,2,\cdots)$
>
> （2）虚指数函数集（复数集）：$\{\mathrm{e}^{\mathrm{j}n\Omega t}\}(n=0,\pm1,\pm2,\cdots)$

本文分别以这两种完备正交函数集作为基对周期信号进行分解，得到我们最常见的三角形式和指数形式的傅里叶级数。

<br>

# Triangular Fourier Series of Periodic Signals

设有周期信号$f(t)$，其周期为$T$，角频率为$\Omega=2\pi/T$，当满足**狄利克雷（Dirichlet）**条件（见文末附录）时，周期信号$f(t)$可展开为三角形式的傅里叶级数：

$$
f(t)=a_0+\sum_{n=1}^\infty a_n\cos(n\Omega t)+\sum_{n=1}^\infty b_n\sin(n\Omega t)\notag
$$

接下来的工作就是根据式$\eqref{eq2}$确定傅里叶系数。对于直流分量：

$$
K_i=\int_{-T/2}^{T/2}1^2\mathrm{d}t=T\notag
$$

对于$n$次余弦分量：

$$
\begin{split}
K_i&=\int_{-T/2}^{T/2}\cos^2(n\Omega t)\mathrm{d}t\\
&=\int_{-T/2}^{T/2}\dfrac{1+\cos(2n\Omega t)}{2}\mathrm{d}t=\dfrac{T}2
\end{split}\notag
$$

对于$n$次正弦分量：

$$
\begin{split}
K_i&=\int_{-T/2}^{T/2}\sin^2(n\Omega t)\mathrm{d}t\\
&=\int_{-T/2}^{T/2}\dfrac{1-\cos(2n\Omega t)}{2}\mathrm{d}t=\dfrac{T}2
\end{split}\notag
$$

将$K_i$带入到式$\eqref{eq2}$中，有：

$$
\begin{split}
&a_0=\dfrac1T\int_{-T/2}^{T/2}f(t)\mathrm{d}t\\
&a_n=\dfrac2T\int_{-T/2}^{T/2}f(t)\cos(n\Omega t)\mathrm{d}t\quad(n\ne1)\\
&b_n=\dfrac2T\int_{-T/2}^{T/2}f(t)\sin(n\Omega t)\mathrm{d}t\\
\end{split}\notag
$$

为了使$a_0$和$a_n$的计算式保持一致性，我们通常直接从$n=0$开始计算$a_n$：

$$
a_n=\dfrac2T\int_{-T/2}^{T/2}f(t)\cos(n\Omega t)\mathrm{d}t\quad(n=0,1,2,\cdots)\notag
$$

求出$a_0$后除以2就是直流分量的值，因此三角形式的傅里叶级数通常表示为：

$$
f(t)=\dfrac{a_0}2+\sum_{n=1}^\infty a_n\cos(n\Omega t)+\sum_{n=1}^\infty b_n\sin(n\Omega t)\label{eq4}
$$

其中：

$$
\begin{split}
&a_n=\dfrac2T\int_{-T/2}^{T/2}f(t)\cos(n\Omega t)\mathrm{d}t\quad(n=0,1,2,\cdots)\\
&b_n=\dfrac2T\int_{-T/2}^{T/2}f(t)\sin(n\Omega t)\mathrm{d}t\quad(n=1,2,\cdots)\\
\end{split}\label{eq5}
$$


由式$\eqref{eq4}$可以进一步合并三角函数，得到余弦形式的傅里叶级数：

$$
f(t)=\dfrac{A_0}2+\sum_{n=1}^\infty A_n\cos(n\Omega t+\varphi_n)\label{eq6}
$$

两种形式傅里叶系数的对应关系为：

$$
\left\{
\begin{split}
A_n&=\sqrt{a_n^2+b_n^2}\\
\varphi_n&=-\arctan\dfrac{b_n}{a_n}
\end{split}
\right.,\ 
\left\{
\begin{split}
a_n&=A_n\cos\varphi_n\\
\varphi_n&=-A_n\sin\varphi_n
\end{split}
\right.\label{eq8}
$$

余弦形式的傅里叶级数可以解读为：周期信号可以分解为直流分量和许多余弦分量。其中：

- $A_0/2$，为直流分量
- $A_1\cos(\Omega t+\varphi_1)$，为基波（AKA一次谐波），角频率与原周期信号相同；
- $A_1\cos(2\Omega t+\varphi_2)$，为二次谐波；
- $A_n\cos(n\Omega t+\varphi_n)$，为$n$次谐波；

<br>

# Exponential Fourier Series of Periodic Signals

三角形式的傅里叶级数，含义比较明确，但是运算时会有些不便，因而人们也经常使用指数形式的傅里叶级数。

如果选取虚指数集作为完备正交函数集，则任意函数$f(t)$在周期$T$内可以分解为：
$$
f(t)=\sum_{n=-\infty}^{\infty}F_n\mathrm{e}^{\mathrm{j}n\Omega t}
$$

根据式$\eqref{eq3}$，可以得到系数$F_n$的计算公式：

$$
\begin{split}
F_n&=\dfrac{\int_{-T/2}^{T/2}f(t)(\mathrm{e}^{\mathrm{j}n\Omega t})^*\mathrm{d}t}{\int_{-T/2}^{T/2}\mathrm{e}^{\mathrm{j}n\Omega t}(\mathrm{e}^{\mathrm{j}n\Omega t})^*\mathrm{d}t}\\
&=\dfrac1T\int_{-T/2}^{T/2}f(t)\mathrm{e}^{-\mathrm{j}n\Omega t}\mathrm{d}t,\quad n=0,\pm1,\pm2,\cdots
\end{split}
$$

> 注：
> 
> $$
> \begin{split}
> &\mathrm{e}^{\mathrm{j}n\Omega t}=\cos(n\Omega t)+\mathrm{j}\sin(n\Omega t)\\
> &(\mathrm{e}^{\mathrm{j}n\Omega t})^*=\cos(-n\Omega t)+\mathrm{j}\sin(-n\Omega t)=\mathrm{e}^{-\mathrm{j}n\Omega t}
> \end{split}\notag
> $$

这种分解表明，任意周期信号$f(t)$可以分解为许多不同频率的虚指数信号之和。

<br>

# Relation of Two Series Form

根据周期信号的余弦展开形式$\eqref{eq6}$，可以进一步推导出：

$$
\begin{split}
f(t)&=\dfrac{A_0}2+\sum_{n=1}^\infty A_n\cos(n\Omega t+\varphi_n)\\
&=\dfrac{A_0}2+\dfrac{A_n}2\sum_{n=1}^{\infty}[\mathrm{e}^{\mathrm{j}(n\Omega t+\varphi_n)}+\mathrm{e}^{-\mathrm{j}(n\Omega t+\varphi_n)}]\\
&=\dfrac{A_0}2+\dfrac{A_n}2\sum_{n=1}^{\infty}\mathrm{e}^{\mathrm{j}n\Omega t}\mathrm{e}^{\mathrm{j}\varphi}+\dfrac{A_n}2\sum_{n=1}^{\infty}\mathrm{e}^{-\mathrm{j}n\Omega t}\mathrm{e}^{-\mathrm{j}\varphi}\\
\end{split}\label{eq9}
$$

由于$A_n$是$n$的偶函数，$\varphi_n$是$n$的奇函数：

> “$A_n$是$n$的偶函数，$\varphi_n$是$n$的奇函数”
>
> 根据式$\eqref{eq5}$可以得到：
> 
> $$
> \begin{split}
> &a_{-n}=a_n\\
> &b_{-n}=-b_n
> \end{split}\notag
> $$
>
> 再由式$\eqref{eq8}$可得：
> 
> $$
> \left\{
> \begin{split}
> A_{-n}&=\sqrt{a_{-n}^2+b_{-n}^2}=\sqrt{a_n^2+(-b_n)^2}=A_n\\
> \varphi_{-n}&=-\arctan\dfrac{b_{-n}}{a_{-n}}=-\arctan\dfrac{-b_{n}}{a_{n}}=\arctan\dfrac{b_{n}}{a_{n}}=-\varphi_n
> \end{split}
> \right.\notag
> $$

因此我们用$-n$替换掉式$\eqref{eq9}$右端第三项的$n$，于是上式可化为：

$$
\begin{split}
f(t)&=\dfrac{A_0}2+\dfrac{A_n}2\sum_{n=1}^{\infty}\mathrm{e}^{\mathrm{j}n\Omega t}\mathrm{e}^{\mathrm{j}\varphi}+\dfrac{A_n}2\sum_{n=-1}^{-\infty}\mathrm{e}^{\mathrm{j}n\Omega t}\mathrm{e}^{\mathrm{j}\varphi}\\
&=\sum_{n=-\infty}^{\infty}\dfrac{A_n}2\mathrm{e}^{\mathrm{j}\varphi}\mathrm{e}^{\mathrm{j}n\Omega t}
\end{split}\notag
$$

对比指数形式的傅里叶级数：

$$
f(t)=\sum_{n=-\infty}^{\infty}F_n\mathrm{e}^{\mathrm{j}n\Omega t}\notag
$$

可以得到：

$$
\begin{split}
&F_n=\dfrac12{A_n}\mathrm{e}^{\mathrm{j}\varphi}\\
\Rightarrow & \vert F_n\vert \mathrm{e}^{\mathrm{j}\Phi}=\dfrac12{A_n}\mathrm{e}^{\mathrm{j}\varphi}
\end{split}\notag
$$

三角形式和指数形式的傅里叶级数之间的关系为：

$$
\begin{split}
\vert F_n\vert&=\dfrac12{A_n}\\
\Phi&=\varphi
\end{split}
$$


<br>

# Example: Fourier Series of Square Wave Signal

## Triangular Form (Gibbs Phenomenon)

对于方波（square）信号$f(t)$：

![image-20230124134953108](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230124134953108.png?raw=true)

它的三角形式的傅里叶系数为：

$$
\begin{split}
a_n&=\dfrac2T\int_{-T/2}^{T/2}f(t)\cos(n\Omega t)\mathrm{d}t\\
&=\dfrac2{n\Omega T}[\int_{-T/2}^0-\cos(n\Omega t)\mathrm{d}(n\Omega t)+[\int_0^{T/2}\cos(n\Omega t)\mathrm{d}(n\Omega t)]\\
&=0
\end{split}\notag
$$

$$
\begin{split}
b_n&=\dfrac2T\int_{-T/2}^{T/2}f(t)\sin(n\Omega t)\mathrm{d}t\\
&=\dfrac2{n\Omega T}[\int_{-T/2}^0-\sin(n\Omega t)\mathrm{d}(n\Omega t)+[\int_0^{T/2}\sin(n\Omega t)\mathrm{d}(n\Omega t)]\\
&=\dfrac2{n\Omega T}[\cos(n\Omega t)\vert_{-T/2}^0-\cos(n\Omega t)\vert_{0}^{T/2}]\\
&=\dfrac2{n\pi}[1-\cos(n\pi)]\\
&=\dfrac2{n\pi}(1-(-1)^n)\\
&=\left\{\begin{split}
&0,& n=2,4,6...\\
&\dfrac{4}{n\pi},& n=1,3,5,...
\end{split}\right.
\end{split}\notag
$$

傅里叶级数为：

$$
\begin{split}
f(t)&=\sum_{n=1}^\infty \dfrac{2}{n\pi}[1-(-1)^n]\cos(n\Omega t)\\
&= 0+\dfrac4\pi[\sin(\Omega t)+\dfrac13\sin(3\Omega t)+\cdots+\dfrac1n\sin(n\Omega t)+\cdots]
\end{split}
$$

以周期为2的方波为例，可视化正弦型号对于方波的近似：

![image-20230124145237868](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230124145237868.png?raw=true)

> ```matlab
> classdef Square < handle
>     properties
>         t = linspace(0,2,1000)';
>         f
>     end
> 
>     methods
>         function obj = Square(Omega)
>             obj.f = square(Omega*obj.t);
>         end
> 
>         function Plot(obj)
>             plot(obj.t, obj.f, 'k', LineWidth=1.5)
>             box(gca, "on")
>             grid(gca, "on")
>             xlabel('t')
>             ylabel('f(t)')
>             set(gca, 'YTick', [-1,0,1])
>             set(gca, 'Xtick', [-1.5,-1,-0.5,0,0.5,1,1.5])
>             set(gca, 'FontName', 'Times New Roman')
>             set(gca, 'FontSize', 13)
>         end
>     end
> end
> ```
>
> ```matlab
> classdef SineApprox < handle
>     properties
>         t = linspace(0,2,1000)';
>         f
>         times
>     end
> 
>     methods
>         function obj = SineApprox(Omega, times)
>             obj.times = times;
>             obj.f = zeros(numel(obj.t), 1);
>             for i = 1:2:times
>                 obj.f = obj.f + 4/pi*(1/i)*sin(i*Omega*obj.t);
>             end
>         end
> 
>         function Plot(obj)
>             hold(gca, "on")
>             plot(obj.t, obj.f, 'r', LineWidth=1.5)
>             title(sprintf('Sum of the first %d harmonics', obj.times))
>         end
> 
>     end
> end
> ```
>
> ```matlab
> clc, clear, close all
> 
> figure
> for i = [1, 3, 5, 7, 99, 999]
>     nexttile
>     Omega = pi;
>     SquareObj = Square(Omega);
>     SineApproxObj1 = SineApprox(Omega, i);
>     SquareObj.Plot()
>     SineApproxObj1.Plot()
> end
> ```

可以看到，用**有限项**傅里叶级数表示**有间断点**的信号时，在间断点附近不可避免的会出现振荡和超调量。**超调量的幅值不会随着所取项数的增加而减小**。只是随着项数的增多，振荡频率变高，并向间断点处压缩，从而使它所占有的能量（能量占比）减少。

当选取的项数很大时，该超调量趋于一个常数，大约等于总跳变值的9%，并从间断点开始以起伏振荡的形式衰减下去。这种现象称为吉布斯现象（Gibbs phenomenon）。

## Exponential Form

周期为$T$的方波信号的指数型傅里叶系数为：

$$
\begin{split}
F_n&=\dfrac1T\int_{-T/2}^{T/2}f(t)\mathrm{e}^{-\mathrm{j}n\Omega t}\mathrm{d}t\\
&=\dfrac1T[\int_{-T/2}^{0}-\mathrm{e}^{-\mathrm{j}n\Omega t}\mathrm{d}t+\int_{0}^{T/2}\mathrm{e}^{-\mathrm{j}n\Omega t}\mathrm{d}t]\\
&=\dfrac1{n\pi}[1-(-1)^n],\quad n=0,\pm1,\pm2,\cdots
\end{split}\notag
$$

傅里叶级数为：

$$
f(t)=\sum_{n=-\infty}^{\infty}\dfrac1{n\pi}[1-(-1)^n]\mathrm{e}^{\mathrm{j}n\Omega t}\notag
$$

<br>

# Appendix: Dirichlet Conditions

迪利克雷条件包含三个方面。

**条件1**：在一个周期内，函数连续或者只有有限个第一类间断点（是间断点，左极限和右极限都存在）。

间断点的个数必须是有限个，无限个第一类间断点就不满足，例如：

![image-20230125171141635](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230125171141635.png?raw=true)

**条件2**：在一个周期内，函数极大值和极小值的数目应该为有限个。

同样的，无限个极值的情形也不满足，例如：

![image-20230125172457494](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230125172457494.png?raw=true)

**条件3**：在一个周期内，函数绝对可积。

这一条件是为了保证有界，比如下面的信号就不满足：

![image-20230125172553092](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230125172553092.png?raw=true)

<br>

**References**

[1] [信号与线性系统分析 吴大正 郭宝龙 - bilibili](https://www.bilibili.com/video/BV16E411E7PA/?spm_id_from=333.337.search-card.all.click)
