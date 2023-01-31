---
layout: single
title:  Fourier Transform of Periodic Signals
date: 2023-01-30 14:19:21 +0800
categories: 
 - Signals and Systems
---

# Introduction

在博客[Fourier Series of Periodic Signals](http://whatastarrynight.com/signals%20and%20systems/matlab/Fourier-Series-of-Periodic-Signals/)中，我们讨论了周期信号的傅里叶级数；在博客[Fourier Transform](http://whatastarrynight.com/signals%20and%20systems/Fourier-Transform/)，讨论了非周期信号的傅里叶变换。由傅里叶级数得到的频谱是离散谱，并且是“实际谱”；而由傅里叶变换得到的频谱连续谱，并且是“谱密度”。

那么，周期信号的傅里叶变换如何求？

<br>

# Fourier Transform for Triangular Signals

三角函数信号是一类典型的周期函数，我们首先推导它们的傅里叶变换。

首先，有：

$$
1\leftrightarrow2\pi\delta(\omega)\notag
$$

根据傅里叶变换的频移性质$\eqref{appendix0}$，有：

$$
\begin{split}
\mathrm{e}^{\mathrm{j}\omega_0t}&\leftrightarrow2\pi\delta(\omega-\omega_0)\\
\mathrm{e}^{-\mathrm{j}\omega_0t}&\leftrightarrow2\pi\delta(\omega+\omega_0)\\
\end{split}\notag
$$

再由欧拉公式和线性性质可以得到：

$$
\begin{split}
\cos(\omega_0t)&\leftrightarrow\pi[\delta(\omega+\omega_0)+\delta(\omega-\omega_0)]\\
\sin(\omega_0t)&\leftrightarrow\mathrm{j}\pi[\delta(\omega+\omega_0)-\delta(\omega-\omega_0)]\\
\end{split}
$$

三角函数信号作为周期信号，它的傅里叶级数所对应的实际谱幅度$\vert F_n\vert$不是无穷小，是有限值。乘上无穷大的$T$之后变成无穷大，就变成$F(\mathrm{j}\omega)$，这和$\delta$函数的存在相吻合；并且，右边的结果也满足离散性。

<br>

# Fourier Transform of General Periodic Signals

## Method 1: Fourier Series + Fourier Transform

一般周期信号$f(t)$的虚指数形式的傅里叶级数为：

> 周期信号的虚指数形式傅里叶级数：
>
> $$
> f_T(t)=\sum_{n=-\infty}^{\infty}F_n\mathrm{e}^{\mathrm{j}n\Omega t}\label{eq1}
> $$
>
> 其中傅里叶系数为：
>
> $$
> \begin{split}
> F_n&=\dfrac1T\int_{-T/2}^{T/2}f(t)\mathrm{e}^{-\mathrm{j}n\Omega t}\mathrm{d}t,\quad n=0,\pm1,\pm2,\cdots
> \end{split}\label{eq2}
> $$

对式$\eqref{eq1}$进行傅里叶变换：

$$
\begin{split}
\mathcal{F}[f_T(t)]&=\mathcal{F}(\sum_{n=-\infty}^{\infty}F_n\mathrm{e}^{\mathrm{j}n\Omega t})\\
&=\sum_{n=-\infty}^{\infty}F_n\mathcal{F}(\mathrm{e}^{\mathrm{j}n\Omega t})\\
\end{split}\notag
$$

根据傅里叶变换的频移性质$\eqref{appendix0}$，有：

$$
\begin{split}
\mathcal{F}[f_T(t)]&=\sum_{n=-\infty}^{\infty}F_n\mathcal{F}(\mathrm{e}^{\mathrm{j}n\Omega t})\\
&=\sum_{n=-\infty}^{\infty}F_n2\pi\delta(\omega-n\Omega)\\
&=2\pi\sum_{n=-\infty}^{\infty}F_n\delta(\omega-n\Omega)\\
\end{split}\notag
$$

即：

$$
\begin{split}
\mathcal{F}[f_T(t)]
&=2\pi\sum_{n=-\infty}^{\infty}F_n\delta(\omega-n\Omega)\\
\end{split}\label{eq3}
$$

式$\eqref{eq3}$就是周期信号的傅里叶变换公式，即：

$$
\sum_{n=-\infty}^{\infty}F_n\mathrm{e}^{\mathrm{j}n\Omega t}\leftrightarrow2\pi\sum_{n=-\infty}^{\infty}F_n\delta(\omega-n\Omega)\label{eq5}
$$

式$\eqref{eq3}$表明，周期信号$f_T(t)$的频谱（密度）由冲激序列组成，并且：

- 位置：$\omega=n\Omega$，即谐波频率处
- 强度：$2\pi F_n$

## Method 2: Aperiodic Signal + Convolution Theorem

周期为$T$的单位冲激周期函数：

$$
\delta_T(t)=\sum_{n=-\infty}^{\infty}\delta(t-mT)
$$

首先求它的傅里叶级数：

$$
\begin{split}
F_n&=\dfrac1T\int_{-T/2}^{T/2}f(t)\mathrm{e}^{-\mathrm{j}n\Omega t}\mathrm{d}t\\
&=\dfrac1T\int_{-T/2}^{T/2}\delta(t)\mathrm{e}^{-\mathrm{j}n\Omega t}\mathrm{d}t\\
&=\dfrac1T
\end{split}
$$

> 这里使用了冲激函数的取样性质：
> 
> $$
> \int^{+\infty}_{-\infty}\delta(t)f(t)dt=f(0)\notag
> $$

于是，根据式$\eqref{eq3}$可以得到：

$$
\delta_T(t)\leftrightarrow2\pi\sum_{n=-\infty}^{\infty}\dfrac1T\delta(\omega-n\Omega)=\Omega\sum_{n=-\infty}^{\infty}\delta(\omega-n\Omega)=\Omega\delta_{\Omega}(\omega)
$$

即：

$$
\delta_T(t)\leftrightarrow\Omega\delta_{\Omega}(\omega)\label{eq4}
$$

式$\eqref{eq4}$的结果向我们提供了另一种求解周期信号傅里叶变换的视角。

周期信号$f(t)$实际上可以看做是一个时限非周期信号$f_0(t)$的周期拓展，即：

$$
f_T(t)=\delta_T(t)*f_0(t)\label{eq6}
$$

根据傅里叶变换的卷积定理式$\eqref{appendix1}$可以得到：

$$
f_T(t)\leftrightarrow\Omega\delta_{\Omega}(\omega)F_0(\mathrm{j}\omega)
$$

即：

$$
f_T(t)\leftrightarrow\Omega\sum_{n=-\infty}^{\infty}F_0(\mathrm{j}n\Omega)\delta(\omega-n\Omega)\label{eq7}
$$

<br>

# Conclusion

本文推导了周期信号傅里叶变换的两种求解方式和两种形式。

（1）根据式$\eqref{eq1}$的形式，推出了式$\eqref{eq5}$：

$$
f_T(t)=\sum_{n=-\infty}^{\infty}F_n\mathrm{e}^{\mathrm{j}n\Omega t}\leftrightarrow2\pi\sum_{n=-\infty}^{\infty}F_n\delta(\omega-n\Omega)\notag
$$

（2）根据式$\eqref{eq6}$的形式，推出了式$\eqref{eq7}$：

$$
f_T(t)=\delta_T(t)*f_0(t)\leftrightarrow\Omega\sum_{n=-\infty}^{\infty}F_0(\mathrm{j}n\Omega)\delta(\omega-n\Omega)\notag
$$

并且，上面这两个式子是等价的，进而可以推导出：

$$
F_n=\dfrac1TF_0(\mathrm{j}\dfrac{2n\pi}{T})
$$

<br>

# Appendix: Some Properties of Fourier Transform

## (1) Frequency Shifting Property

（傅里叶变换的频移性质）

如果：

$$
f(t)\leftrightarrow F(\mathrm{j}\omega)\notag
$$

则有：

$$
\mathrm{e}^{\mp\mathrm{j}\omega_0t}f(t)\leftrightarrow F[\mathrm{j}(\omega\pm\omega_0)],\ \mathrm{where\ \omega_0\ is\ real\ constant}\label{appendix0}
$$

傅里叶变换频移性质的实质是**频谱搬移**，它是信号通信理论中调制、解调的理论基础。

## (2) Convolution Theorem

如果：

$$
f_1(t)\leftrightarrow F_1(\mathrm{j}\omega),\quad f_2(t)\leftrightarrow F_2(\mathrm{j}\omega)\notag
$$

则时域卷积定理：

$$
f_1(t)*f_2(t)\leftrightarrow F_1(\mathrm{j}\omega)F_2(\mathrm{j}\omega)\label{appendix1}
$$

> 时域卷积定理提供给我们另一条进行卷积运算的方式：如果时域的卷积运算难以进行，就转到频域，变成乘积运算，再转换回时域。

和频域卷积定理：

$$
f_1(t)f_2(t)\leftrightarrow\dfrac1{2\pi}F_1(\mathrm{j}\omega)*F_2(\mathrm{j}\omega)\label{appendix2}
$$

<br>

**References**

[1] [信号与线性系统分析 吴大正 郭宝龙 - bilibili](https://www.bilibili.com/video/BV16E411E7PA/?spm_id_from=333.337.search-card.all.click).
