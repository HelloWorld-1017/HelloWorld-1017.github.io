---
layout: single
title: 周期矩形脉冲（周期门函数）的三角型傅里叶级数和指数型傅里叶级数
date: 2022-02-11
categories: 
  - Signals and Systems
---



## 周期矩形脉冲

有一个幅度为1，脉冲宽度为$\tau$的周期矩形脉冲，其周期为$T$，如图所示。

![image-20220710135204578](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220710135204578.png)



现分别求其三角型傅里叶级数和指数型傅里叶级数。



## 三角函数形式的傅里叶级数(余弦形式的傅里叶级数)

根据周期信号的三角型傅里叶级数，周期信号$f(t)$可以分解为一系列正弦信号和余弦信号和的形式：

$$
f(t)=\dfrac{a_0}{2}+\sum^{\infty}_{n=1}[a_ncos(n\Omega t)+b_nsin(n\Omega t)]\label{equa1}
$$

公式中的系数计算公式分别为：

$$
\begin{align*}直流分量：&\dfrac{a_0}{2}=\dfrac{1}{T}\int^{\frac{T}{2}}_{-\frac{T}{2}}f(t)dt\\
余弦系数分量：&a_n=\dfrac{2}{T}\int^{\frac{T}{2}}_{-\frac{T}{2}}f(t)cos(n\Omega t)dt\\
正弦系数分量：&b_n=\dfrac{2}{T}\int^{\frac{T}{2}}_{-\frac{T}{2}}f(t)sin(n\Omega t)dt\\
\end{align*}
$$

进一步，可将式 $\eqref{equa1}$ 转换为**余弦形式的傅里叶级数**：

$$
f(t)=\dfrac{A_0}{2}+\sum^{\infty}_{n=1}A_ncos(n\Omega t+\phi_n) \label{equa2}
$$

可以根据式 $\eqref{equa2}$ 得到周期信号的单边频谱，包括单边幅度谱和单边相位谱。

给定的周期矩形脉冲$g_\tau(t)$为偶函数，因此正弦系数分量$b_n=0$，余弦系数分量$a_n$为：

$$
\begin{align*}
a_n&=\dfrac{2}{T}\int^{\frac{\tau}{2}}_{-\frac{\tau}{2}}cos(n\Omega t)dt\\
&=\dfrac{2}{n\Omega T}\int^{\frac{\tau}{2}}_{-\frac{\tau}{2}}cos(n\Omega t)d(n\Omega t)\\&=\dfrac{2}{n\pi}sin(n\Omega\dfrac{\tau}{2})\\
&=\dfrac{2}{n\pi}sin(n\pi \dfrac{\tau}{T})\\
&=\dfrac{2\tau}{T}Sa(n\pi \dfrac{\tau}{T})\quad n=0,1 ,2, \cdots
\end{align*}
$$

式中，$Sa(x)=\dfrac{sinx}{x}$为抽样函数。于是周期矩形脉冲 $g_\tau(t)$ 可以分解为：

$$
g_T(t)=\dfrac{\tau}{T}+\sum^{\infty}_{n=1}\dfrac{2\tau}{T}Sa(n\pi \dfrac{\tau}{T})cos(n\Omega t)\notag
$$

该公式也是余弦形式的傅里叶级数，因此可以直接根据它来绘制周期信号$g_T(t)$的单边频谱。



## 虚指数形式的傅里叶级数

根据周期信号的指数型傅里叶级数，周期函数$f(t)$可以分解为：

$$
f(t)=\sum^{\infty}_{n=-\infty}F_ne^{jn\Omega t}\notag
$$

傅里叶系数为：

$$
F_n=\dfrac{1}{T}\int^{\frac{T}{2}}_{-\frac{T}{2}}f(t)e^{-jn\Omega t}dt,\ n=0,\pm 1,\pm 2\cdots \notag
$$

于是可以得到周期矩形脉冲$g_T(t)$的傅里叶系数$F_n$为：

$$
\begin{align*}
F_n&=\dfrac{1}{T}\int^{\frac{\tau}{2}}_{-\frac{\tau}{2}}e^{-jn\Omega t}dt\\
&=\dfrac{-1}{jn\Omega T}e^{-jn\Omega t}|^{\frac{\tau}{2}}_{-\frac{\tau}{2}}\\
&=\dfrac{1}{jn2\pi}[e^{jn\Omega \frac{\tau}{2}}-e^{-jn\Omega \frac{\tau}{2}}]\\
&=\dfrac{1}{n\pi}\dfrac{[e^{jn\Omega \frac{\tau}{2}}-e^{-jn\Omega \frac{\tau}{2}}]}{2j}\\
&=\dfrac{1}{n\pi}sin(n\Omega \frac{\tau}{2})\\
&=\dfrac{\Omega \tau}{2\pi}\dfrac{sin(n\Omega \frac{\tau}{2})}{n\Omega \frac{\tau}{2}}\\
&=\dfrac{\tau}{T}Sa(n\pi\dfrac{\tau}{T})\qquad n=0,\pm 1, \pm 2,\cdots
\end{align*}
$$

于是周期矩形脉冲$g_T(t)$可以分解为：

$$
g_T(t)=\sum^{\infty}_{n=-\infty}\dfrac{\tau}{T}Sa(n\pi\dfrac{\tau}{T})e^{jn\Omega t}\notag
$$

可以根据该公式绘制周期矩形脉冲的双边频谱。



## 结论

给定的周期矩形脉冲$g_T(t)$的三角函数形式级数和虚指数函数级数分别为：

$$
\begin{align*}
三角函数（余弦）形式傅里叶级数：& g_T(t) =\dfrac{\tau}{T}+\sum^{\infty}_{n=1}\dfrac{2\tau}{T}Sa(n\pi \dfrac{\tau}{T})cos(n\Omega t)\\
虚指数函数形式傅里叶级数：& g_T(t) =\sum^{\infty}_{n=-\infty}\dfrac{\tau}{T}Sa(n\pi\dfrac{\tau}{T})e^{jn\Omega t}
\end{align*}
$$