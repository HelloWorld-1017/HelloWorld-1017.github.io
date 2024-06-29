---
layout: single
title: "Lagrangian Interpolation Remainder: Truncation Error Estimation Formula for n-th Degrees Interpolation Polynomials"
date: 2022-02-14 14:45:27 +0800
categories: 
 - Mathematics
tags: 
 - Numerical Analysis
toc: false
---




> 定理（$n$次插值多项式的截断误差估计式）
>
> 设$f^{(n)}(x)$在区间$[a,b]$上连续，$f^{(n+1)}(x)$在$(a,b)$内存在，插值节点$a\le x_0<x_1<\cdots<x_n\le b$，$p_n(x)$是满足插值条件$p_n(x_i)=y_i(i=0,1,\cdots ,n)$的$n$次插值多项式，则对于任意$x\in[a,b]$，存在$\xi=\xi(x)\in(a,b)$，使得截断误差（或插值余项）$R_n(x)$：
> 
> $$
> \begin{aligned}R_n(x)&=f(x)-p_n(x)\\&=\dfrac{f^{(n+1)}(\xi)}{(n+1)!}\prod \limits_{i=0}^n(x-x_i)\end{aligned}
> $$

证明：
设截断误差$R_n(x)=f(x)-p_n(x)$，则$R_n(x)$至少有$n+1$个零点：$x_0, x_1, \cdots, x_n$；于是设:

$$
R_n(x)=K(x)\prod \limits_{i=0}^n(x-x_i) \tag{1}
$$

其中$K(x)$是与$x$有关的待定函数。下面确定$K(x)$。

由于我们要考察非插值节点的误差（插值节点的误差均为0），因此固定任意的$x\in[a,b]$且$x\ne x_i(i=0,1,\cdots ,n)$，构造辅助函数$\varphi(t)$：

$$
\varphi(t)=R_n(t)-K(x)\prod \limits_{i=0}^n(t-x_i)\tag{2}
$$

于是有$\varphi(x_i)=0(i=0,1,\cdots ,n)$，$\varphi(x)=0$【因为对于固定的$x$，有式(1)成立，即式(2)的右端项为0】，即$\varphi(t)$至少具有$n+2$零点：$x_0, x_1, \cdots, x_n,x$

根据定理条件定理可知，$\varphi^{(n)}(t)$在区间$[a,b]$连续，$\varphi^{(n+1)}(t)$在区间$(a,b)$存在；根据罗尔定理，$\varphi'(t)$在两个零点之间至少存在$1$个零点，即$\varphi'(t)$在区间$[a,b]$内至少有$n+1$个零点，同理$\varphi''(t)$在区间$[a,b]$内至少有$n$个零点。反复使用罗尔定理可以得到$\varphi^{(n+1)}(t)$在区间$(a,b)$内至少存在一个零点，即至少存在一点$\xi$，使得$\varphi^{(n+1)}(\xi)=0$。

将式(2)两边同求$n+1$阶导数，再代入$\xi$可以得到：

$$
\begin{aligned}
\varphi^{(n+1)}(\xi)&=R_n^{(n+1)}(\xi)-K(x)(n+1)!\\&=f^{(n+1)}(\xi)-p_n^{(n+1)}(\xi)-K(x)(n+1)!=0
\end{aligned}
$$

于是可以求得：

$$
K(x)=\dfrac{f^{(n+1)}(\xi)}{(n+1)!},\quad \xi\in(a,b)且与x有关
$$

将 $K(x)$ 代入式(1)得到：
$$
R_n(x)=\dfrac{f^{(n+1)}(\xi)}{(n+1)!}\prod \limits_{i=0}^n(x-x_i),\quad \xi\in(a,b)\tag{3}
$$

证毕。

式(3)即为 $n$ 次插值多项式的截断误差估计式，也称为**拉格朗日插值余项**。