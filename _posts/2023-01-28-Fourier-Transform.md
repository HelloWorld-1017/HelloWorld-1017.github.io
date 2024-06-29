---
layout: single
title:  Fourier Transform
date: 2023-01-28 13:44:01 +0800
categories: 
 - Signals and Systems
header:
  image: https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230128135300193.png?raw=true
---

# Fourier Transform

在博客[Spectrum of Periodic Signals](http://whatastarrynight.com/signals%20and%20systems/matlab/Spectrum-of-Periodic-Signals/)中，我们推导并分析了周期矩形脉冲信号的频谱：

![image-20230126174004648](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230126174004648.png?raw=true)

并且得出结论：

当保持$\tau$不变，而$T$增大时，则频谱的的幅度下降，间隔$\Omega$减小，频谱变密。而当$T\rightarrow\infty$时（周期是无穷大的信号，就可以看做是非周期信号）：

- 谱线间隔$\Omega=\dfrac{2\pi}T\rightarrow0$
- 谱线幅度$\rightarrow0$

周期信号的**连续频谱**过渡为非周期信号的**连续频谱**。

![image-20230128130220281](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230128130220281.png?raw=true)

虽然各频率分量的幅度趋近于无穷小，但无穷小量之间仍有相对大小差别，出于这个原因，我们可以很自然地引入**频谱密度函数**这个概念。

我们仍然从周期信号的虚指数形式傅里叶级数出发进行推导：

> 周期信号的虚指数形式傅里叶级数：
> 
> $$
> f(t)=\sum_{n=-\infty}^{\infty}F_n\mathrm{e}^{\mathrm{j}n\Omega t}\label{eq1}
> $$
> 
> 其中傅里叶系数为：
> 
> $$
> \begin{split}
> F_n&=\dfrac1T\int_{-T/2}^{T/2}f(t)\mathrm{e}^{-\mathrm{j}n\Omega t}\mathrm{d}t,\quad n=0,\pm1,\pm2,\cdots
> \end{split}\label{eq2}
> $$

我们可以把频谱的无穷小幅度放大无穷大倍，观察它们的相对大小，所找的这个无穷大就是无穷大的周期$T$。针对式$\eqref{eq2}$，有：

$$
\begin{split}
F&=\lim_{T\rightarrow\infty}TF_n\\
&=\lim_{T\rightarrow\infty}\int_{-T/2}^{T/2}f(t)\mathrm{e}^{-\mathrm{j}n({2\pi}/{T})t}\mathrm{d}t\\
&=\int^{+\infty}_{-\infty}f(t)\mathrm{e}^{-\mathrm{j}\omega t}\mathrm{d}t
\end{split}\label{eq4}
$$

因为此时的“相对幅值”$F$与$\mathrm{j}\omega$的函数，因此我们常常记作：

$$
\begin{split}
F(\mathrm{j}\omega)&=\int^{+\infty}_{-\infty}f(t)\mathrm{e}^{-\mathrm{j}\omega t}\mathrm{d}t
\end{split}\label{eq3}
$$

式$\eqref{eq3}$就是**频谱密度函数**的定义；换句话说，已知任意函数$f(t)$，经过式$\eqref{eq3}$的运算得到频谱密度函数，其实这就是**傅里叶变换**。

> “频谱密度”也可以这么理解，式$\eqref{eq4}$中的：
> 
> $$
> \lim_{T\rightarrow\infty}TF_n\notag
> $$
> 
> 等价于：
> 
> $$
> \lim_{T\rightarrow\infty}TF_n=\lim_{T\rightarrow\infty}\dfrac{F_n}{1/T}\notag
> $$
> 
> 含义是：单位频率（$1/T$）上的频谱强度，也就是频谱密度。

仍然需要强调的是，傅里叶变换求出来的$F(\mathrm{j}\omega)$和傅里叶级数求出的$F_n$不在一个层次上。$F_n$代表的是实际频谱，即双边谱，的强度；而$F(\mathrm{j}\omega)$是将双边谱的频谱强度放大了无穷倍看到的频谱强度。但是，它们都反映了频谱的大小。

<br>

# Inverse Fourier Transform

式$\eqref{eq2}$和式$\eqref{eq1}$实际上分别代表了周期信号**从时域到频域**的变换和**从频域到时域**的变换，我们由式$\eqref{eq2}$推导出了傅里叶变换，同样地，我们也可以由$\eqref{eq1}$推导出傅里叶反变换。

由式$\eqref{eq1}$，有：

$$
\begin{split}
f(t)&=\sum_{n=-\infty}^{\infty}F_n\mathrm{e}^{\mathrm{j}n\Omega t}\\
&=\dfrac1T\sum_{n=-\infty}^{\infty}F_nT\mathrm{e}^{\mathrm{j}n\Omega t}
\end{split}\notag
$$

当$T\rightarrow\infty$时，有：

- $\Omega\rightarrow \mathrm{d}\omega\ (无穷小量)$
- $n\Omega\rightarrow\omega\ (从离散到连续)$
- $\lim_{T\rightarrow\infty}F_nT\rightarrow(\mathrm{j}\omega)$
- $\dfrac1T=\dfrac{\Omega}{2\pi}\rightarrow\dfrac{\mathrm{d}\omega}{2\pi}$
- $\sum\rightarrow\int$

于是可以得到傅里叶反变换公式：

$$
f(t)=\dfrac1{2\pi}\int_{-\infty}^{+\infty}F(\mathrm{j}\omega)\mathrm{e}^{\mathrm{j}\omega t}\mathrm{d}\omega
$$

最终，由傅里叶变换和傅里叶反变换组成了傅里叶变换对：

![image-20230128135300193](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230128135300193.png?raw=true)

可以记作：

$$
f(t)\leftrightarrow F(\mathrm{j}\omega)\notag
$$


函数$f(t)$存在傅里叶变换存在的充分条件是，函数$f(t)$绝对可积，即：

$$
\int_{-\infty}^{+\infty}\vert f(t)\vert\mathrm{d}t<\infty\notag
$$

注：**所有的能量信号（即能量有限信号）都满足此条件**，根据下面的结论可以进一步得到，**时限信号都满足绝对可积的条件**。

> 信号的能量定义为：
>
> 
> $$
> E=\int_{-\infty}^{+\infty}\vert f(t)\vert^2\mathrm{d}t
> $$
> 
> 两个信号的能量都可能是无穷大，它们的差别体现在功率上，即单位时间内（周期）的能量。信号的功率定义为：
> 
> $$
> P=\lim_{T\rightarrow\infty}\dfrac1T\int_{-T/2}^{T/2}\vert f(t)\vert^2\mathrm{d}t
> $$
> 
> **能量有限信号**：信号的能量$E<\infty$，简称**能量信号**，此时$P=0$；
>
> **功率有限信号**：信号的功率$P<\infty$，简称**功率信号**，此时$E=\infty$。
>
> 关于能量信号和功率信号有一些简单的结论：
>
> - 时限信号（仅在有限时间区间不为0）为能量信号；
> - 周期信号属于功率信号；
> - 非周期信号可能是能量信号，也可能是功率信号；
> - 有些信号既不是能量信号也不是功率信号，如：$f(t)=\mathrm{e}^t$。

<br>

# Fourier Transform Pairs of Common Functions

## (1) Unilateral exponential signal

单边指数函数的定义：

$$
f(t)=\mathrm{e}^{-\alpha t}\varepsilon(t)=\left\{
\begin{split}
&\mathrm{e}^{-\alpha t}, &\quad t>0\\
&0, &\quad t<0\\
\end{split},\quad
\alpha>0
\right.
$$

傅里叶变换对：

$$
\mathrm{e}^{-\alpha t}\varepsilon{(t)}\leftrightarrow\dfrac1{\alpha+\mathrm{j}\omega}
$$

## (2) Bilateral exponential signal

双边指数函数的定义：

$$
f(t)=\mathrm{e}^{-\alpha\vert t\vert}=\left\{
\begin{split}
&\mathrm{e}^{-\alpha t}, &\quad t>0\\
&\mathrm{e}^{\alpha t}, &\quad t<0\\
\end{split}
\right.
$$

傅里叶变换对：

$$
\mathrm{e}^{-\alpha\vert t\vert}\leftrightarrow \dfrac{2\alpha}{\alpha^2+\omega^2}
$$

## (3) Gate function (Rectangle pulse)

门函数（矩形脉冲）函数的定义：

$$
g_\tau(t)=\left\{
\begin{split}
&1,\quad&\vert t\vert\le\dfrac\tau2\\
&0,\quad&\vert t\vert>\dfrac\tau2\\
\end{split}
\right.
$$

傅里叶变换对：

$$
g_\tau(t)=\tau\mathrm{Sa}\Big(\dfrac{\omega\tau}{2}\Big)
$$

## (4) Impulse function

冲激函数及其导数的傅里叶变换对：

$$
\begin{split}
&\delta(t)\leftrightarrow1\\
&\delta^{\prime}(t)\leftrightarrow\mathrm{j}\omega\\
&\delta^{(n)}(t)\leftrightarrow(\mathrm{j}\omega)^n
\end{split}
$$

## (5) Constant 

常数的傅里叶变换对：

$$
1\leftrightarrow2\pi\delta(\omega)
$$

## (6) Sign function

符号函数定义：

$$
\mathrm{sgn}(t)=\left\{
\begin{split}
&-1,\quad&t<0\\
&1,\quad&t>0\\
\end{split}
\right.
$$

傅里叶变换对（推导需要使用广义傅里叶变换的概念）：

$$
\mathrm{sgn}(t)\leftrightarrow\dfrac{2}{\mathrm{j}\omega}
$$

## (7) Step function

阶跃函数定义：

$$
\varepsilon(t)=\left\{
\begin{split}
0,\quad&t<0\\
1,\quad&t>0\\
\end{split}
\right.
$$

傅里叶变换对：

$$
\varepsilon(t)\leftrightarrow\pi\delta(\omega)+\dfrac1{\mathrm{j}\omega}
$$

<br>

**References**

[1] [信号与线性系统分析 吴大正 郭宝龙 - bilibili](https://www.bilibili.com/video/BV16E411E7PA/?spm_id_from=333.337.search-card.all.click).

