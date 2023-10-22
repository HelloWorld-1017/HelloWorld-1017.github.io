---
layout: single
title: The Definition and Properties of Gamma and Beta Function
date: 2022-07-07 07:49:51 +0800
categories: 
 - Mathematics
tags: 
 - Probability Theory and Mathematical Statistics
---

# Gamma Function

$\Gamma$ 函数（读作Gamma函数）$\Gamma(x)$，通过积分

$$
\Gamma(x)=\int^{\infty}_0e^{-t}t^{x-1}\mathrm{d}t\qquad (x\gt0)\tag{1-1}
$$

来定义。该积分在 $x\gt0$ 时有意义。

（Ⅰ）根据定义式(1-1)，有 $\Gamma(1)=\int^{\infty}_0e^{-t}t^{0}\mathrm{d}t=1$；

（Ⅱ）令 $t=u^2$，则 

$$
\begin{aligned}
\Gamma(\dfrac12)
&=\int^{\infty}_0e^{-u^2}(u^2)^{-1/2}(2u\mathrm{d}u)\\
&=\int^{\infty}_02e^{-u^2}\mathrm{d}u\\
&=\int^{\infty}_{-\infty}e^{-u^2}\mathrm{d}u
\end{aligned}
$$

再令 $u=v/\sqrt{2}$，可以得到

$$
\begin{aligned}
\Gamma(\dfrac12)
&=\dfrac1{\sqrt{2}}\int^{\infty}_{-\infty}e^{-(v^2/2)}\mathrm{d}v\\
&=\sqrt{\pi}\dfrac{1}{\sqrt{2\pi}}\int^{\infty}_{-\infty}e^{-(v^2/2)}\mathrm{d}v\\ \label{gamma12}
\end{aligned}
$$

上式中 $(1/\sqrt{2\pi})\int^{\infty}_{-\infty}e^{-(v^2/2)}\mathrm{d}v$ 是 $v\sim N(0,1)$ 密度函数在整个实数域的积分，其值为1，故可以得到 $\Gamma(1/2)=\sqrt{\pi}$。

（Ⅲ）根据定义式(1-1)，以及函数分部积分公式，有

$$
\begin{aligned}
\Gamma(x+1)&=\int^{\infty}_0e^{-t}t^{x}\mathrm{d}t=-\int^{\infty}_0t^{x}\mathrm{d}e^{-t}\\
&=t^{x}e^{-t}\Big|_0^{\infty}+x\int^{\infty}_0e^{-t}t^{x-1}\mathrm{d}t=0+x\Gamma(x)\\
&=x\Gamma(x)
\end{aligned}
$$

于是，可以得到 $\Gamma$ 函数重要的递推公式：$\Gamma(x+1)=x\Gamma(x).$ 



根据计算出的 $\Gamma(1)$ 和 $\Gamma(1/2)$ 的值，可以得出当 $n$ 为正整数时 $\Gamma(n)$ 和 $\Gamma(n/2)$ 的值，分别为

$$
\begin{aligned}
\Gamma(n)&=(n-1)!\qquad &n为正整数\\
\Gamma(n/2)&=1\cdot3\cdot5\cdots(n-2)2^{-(n-1)/2}\sqrt{\pi} &n为奇数\\
\end{aligned}
$$

<br>

# Beta Function
$\mathrm{B}$ 函数（读作Beta函数）$\mathrm{B}(x,y)$，通过积分

$$
\mathrm{B}(x,y)=\int_0^1t^{x-1}(1-t)^{y-1}\mathrm{d}t\qquad(x\gt0,y\gt0)
$$

来定义。此积分在 $x\gt0$ 且 $y\gt0$ 时有意义。

<br>

$\Gamma$ 函数与 $\mathrm{B}$ 函数之间有着重要的关系式：

$$
\mathrm{B}(x,y)=\dfrac{\Gamma(x)\Gamma(y)}{\Gamma(x+y)}
$$

<br>

**Reference**

[1] 概率论与数理统计. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.2(2019.8重印).