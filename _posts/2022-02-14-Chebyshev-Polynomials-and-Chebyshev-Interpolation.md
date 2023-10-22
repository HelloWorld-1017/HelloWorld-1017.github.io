---
layout: single
title: Chebyshev Polynomials and Chebyshev Interpolation
date: 2022-02-14 10:01:10 +0800
categories: 
 - Mathematics
tags: 
 - Numerical Analysis
---



## Chebyshev polynomials

定义$n$阶切比雪夫多项式$T_n(x)=\cos(n\arccos x)$。$n$取不同的值对应着不同的关于$x$的多项式。例如：

当$n=0$时，$T_0(x)=\cos(0)=1$;

当$n=1$时，$T_1(x)=\cos(\arccos x)=x$;

当$n=2$时，$T_2(x)=\cos(2\arccos x)$，令$y=\arccos x$，则有：

$$
T_2(x)=\cos(2y)=2\cos^2(y)-1=2x^2-1
$$

同理，一般地有：

$$
\begin{aligned}
 T_{n+1}(x)&=\cos[(n+1)\arccos x]=\cos[(n+1)y]=\cos(ny)\cos(y)-\sin(ny)\sin(y)\\
 T_{n-1}(x)&=\cos[(n-1)\arccos x]=\cos[(n-1)y]=\cos(ny)\cos(y)+\sin(ny)\sin(y)
 \end{aligned}
$$

进一步可以得到：

$$
\begin{aligned}
 T_{n+1}(x)+ T_{n-1}(x)=2\cos(ny)\cos(y)=2xT_n(x)
\end{aligned}
$$

即：

$$
T_{n+1}(x)=2xT_n(x)-T_{n-1}(x)\tag{1}
$$

式(1)即为切比雪夫的三项递推关系式。在已知 $T_0(x)=1$，$T_1(x)=x$的条件下，通过式(1)可以计算出任意第$n$个切比雪夫多项式。如：

$$
\begin{aligned}T_2(x)&=2xT_1(x)-T_0(x)=2x^2-1\\
T_3(x)&=2xT_2(x)-T_1(x)=4x^3-3x
\end{aligned}
$$

## The properties of Chebyshev polynomials

在 $x\in [-1,1]$区间观察切比雪夫多项式，可以得到以下几个性质：

>性质1：
>$T_n(x)$是最高此项为$2^{(n-1)}x^n$的$n$次多项式，并且$T_{2n}$只含$x$的偶次幂，$T_{2n+1}$只含$x$的奇次幂



>性质2：
>$T_n(x)$在区间$[-1, 1]$上有$n$个零点
>
>$$
>x_i=\cos(\dfrac{2i+1}{2n}\pi),\quad i=0,1,\cdots,n-1
>$$
>
>证明：
>
>$$
>\begin{aligned}
>&T_n(x)=\cos(n\arccos x)=0\\
>\Rightarrow&n\arccos x=\dfrac{\pi}{2}+i\pi,,\quad i=0,1,\cdots,n-1\\
>\Rightarrow&x_i=\cos(\dfrac{2i+1}{2n}\pi),\quad i=0,1,\cdots,n-1
>\end{aligned}
>$$
>



> 性质3：
> $T_n(1)=1$，$T_n(-1)=(-1)^n$.
>
> 
>
> 证明：
> 二者对于 $n=0,1,2$ 时显然成立。一般地，根据式(1)切比雪夫的三项递推关系式，可以使用数学归纳法来证明两个关系式成立 。 



>性质4：
>在区间$[-1,1]$上，$|T_n(x)|\le1$，在$n+1$个最值点$x_i=cos(\dfrac{i\pi}{n})\ (i=0,1,\cdots,n)$处，$T_n(x)$依次交替地取最大值$1$和最小值$-1$。
>
>证明：
>根据$T_n(x)=cosy$的形式，$|T_n(x)|\le1$显然成立；
>另一方面
>
>$$
>\begin{aligned}
>T_n(x)&=\cos(n\arccos x)\\T'_n(x)&=\sin(n\arccos x)\dfrac{n}{\sqrt{1-x^2}}=0\\ &\Rightarrow x_i=\cos(\dfrac{i\pi}{n}),i=1,2\cdots,n-1\\
>T''_n(x)&=\cos(n\arccos x)\dfrac{-n^2}{1-x^2}+\sin(n\arccos x)(nx)(1-x^2)^{-\frac{3}{2}}\\ &\Rightarrow T''_n(x_i)=\cos(i\pi)\dfrac{-n^2}{1-x^2}=(-1)^{i+1}\dfrac{n^2}{1-x^2}\end{aligned}
>$$
>
>即$T_n(x)$在$x_i=cos(\dfrac{i\pi}{n})\ (i=1,2,\cdots,n-1)$处的一阶导数等于零，二阶导数不等于零，因此$T_n(x)$在$x_i$处取得极值：
>
>$$T_n(x_i)=\cos(i\pi)=(-1)^i,\ (i=1,2,\cdots,n-1)$$
>
>又$\vert T_n(x)\vert\le 1$，因此这$n-1$个极值均为函数$T_n(x)$的最值。
>
>根据性质3，当$x=1$，即$x=cos(\dfrac{0\pi}{n})$时，$T_n(1)=1=(-1)^0$；当$x=-1$，即$x=cos(\dfrac{n\pi}{n})$时，$T_n(-1)=(-1)^n$。
>
>综上所述，函数$T_n(x)$具有$n+1$个最值点：$x_i=cos(\dfrac{i\pi}{n})\ (i=0,1,\cdots,n)$，并且$T_n(x_i)=(-1)^i$.
>
>QED



>性质5（切比雪夫多项式的极性）：
>
>设$p_n(x)$是最高次项系数为1的$n$次多项式，则：
>
>$$
>\max \limits_{-1\le x\le1}|p_n(x)|\ge \max \limits_{-1\le x\le1}|2^{1-n}T_n(x)|=2^{1-n}
>$$
>
>
>
>证明：
>
>反证法。假设存在最高次项系数为1的$n$次多项式 $\overline{p}_n(x)$，使得：
>
>$$
>\max \limits_{-1\le x\le1}|\overline{p}_n(x)|< \max \limits_{-1\le x\le1}|2^{1-n}T_n(x)|=2^{1-n}\tag{2}
>$$
>
>令 $E(x)=2^{1-n}T_n(x)-\overline{p}_n(x)$。根据性质1，多项式 $2^{1-n}T_n(x)$ 的最高次项的系数为$1$，因此$E(x)$是不超过$n-1$次的多项式。根据式(2)，有：$$-2^{1-n}<\overline{p}_n(x)<2^{1-n}$$ 因此，在 $T_n(x)$ 的 $n+1$ 个极值点$x_i(i=0,1,\cdots,n)$处，有：
>
>$$
>\begin{aligned}
>E(x_0)&=2^{1-n}-\overline{p}_n(x_0)>0\\
>E(x_1)&=-2^{1-n}-\overline{p}_n(x_0)<0\\
>E(x_2)&=2^{1-n}-\overline{p}_n(x_0)>0\\
>\cdots\\
>E(x_n)&=(-1)^n2^{1-n}-\overline{p}_n(x_n)\left\{ \begin{aligned}>0,\ n是偶数\\<0, n是奇数\end{aligned}\right. 
>\end{aligned}
>$$
>
>于是，根据连续函数的零点存在定理可知，方程$E(x)=0$在区间$[-1,1]$上有$n$个根；而另一方面，$E(x)$是不超过$n-1$次的多项式，$E(x)=0$最多有$n-1$个根，得到矛盾，假设不成立。
>
>QED


## Chebyshev interpolation

根据$n$次插值多项式的截断误差估计式 [[1]](#ref)：

$$
\begin{aligned}R_n(x)&=f(x)-p_n(x)\\&=\dfrac{f^{(n+1)}(\xi)}{(n+1)!}\prod \limits_{i=0}^n(x-x_i)\end{aligned}\quad \xi\in(a,b)\tag{3}
$$

式中，$x_i$表示插值节点，且满足$a\le x_0<x_1<\cdots<x_n\le b$。

式(3)的$\prod \limits_{i=0}^n(x-x_i)$部分表明，插值节点$x_i$的选择对于插值余项的上界有着很大的影响，那么我们**是否能够找到特定的插值节点，使得插值余项的上界尽可能得小呢**？这是一个关于插值误差的**极大极小问题**，切比雪夫的性质5给出了答案。

切比雪夫多项式的性质5表明，如果我们将区间固定到$[-1,1]$（其他的一般区间，可以通过变量的线性代换得到），选择$n$次切比雪夫多项式$T_n(x)$的$n+1$最值点作为$n$次插值多项式的插值节点，可以使得$n+1$次多项式$\prod \limits_{i=0}^{n}(x-x_i)$的上界最小，这个最小的上界是$\dfrac{1}{2^n}$。

代入式(3)，可以得到$n$次插值多项式插值余项的最小上界（即使用切比雪夫插值节点得到的插值多项式的误差上界）：

$$
|R_n(x)|\le \dfrac{f^{(n+1)}(\xi)}{2^n(n+1)!}\quad \xi\in(a,b)
$$

插值节点为 $x_i=cos(\dfrac{i\pi}{n})\ (i=0,1,\cdots,n)$。

> 对于一般区间$[a,b]$，选取$x_i=\dfrac{a+b}{2}+\dfrac{b-a}{2}cos(\dfrac{2i+1}{2n+2}\pi)\ (i=0,...,n)$作为插值节点得到插值多项式$P_n(x)$，余项$R_n(x)=\dfrac{f^{(n+1)}(\xi)}{(n+1)!}\dfrac{(b-a)^{n+1}}{2^{2n+1}}T_{n+1}(t)$有最小上界$\dfrac{f^{(n+1)}(\xi)}{(n+1)!}\dfrac{(b-a)^{n+1}}{2^{2n+1}},\ \xi\in(a,b)$。

<br>

<div id="ref"></div>

**References**

[1] [Lagrangian Interpolation Remainder: Truncation Error Estimation Formula for n-th Degrees Interpolation Polynomials - What a starry night~](https://helloworld-1017.github.io/2022-02-14/14-45-27.html).

