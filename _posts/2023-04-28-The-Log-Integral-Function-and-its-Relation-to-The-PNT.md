---
layout: single
title: The Log Integral Function and its Relation to The PNT
date: 2023-04-28 14:53:37 +0800
categories: 
 - Mathematics
 - MATLAB
tags:
 - Prime Obsession
 - Number Theory
 - Mathematical Analysis
 - MATLAB Symbolic Math Toolbox
---

# The Log Integral Function

函数：

$$
f(t)=1/\ln t\label{eq0}
$$

的定义域为$(0,1)\cup (1,+\infty)$，部分的函数图像为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230428165358279.png?raw=true" alt="image-20230428165358279" style="zoom:50%;" />

```matlab
clc,clear,close all
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
epsilon = 1e-2;
t1 = linspace(0+epsilon,1-epsilon,100);
t2 = linspace(1+epsilon,2,100);
plot(t1,1./log(t1),'LineWidth',1.5,'Color','k')
plot(t2,1./log(t2),'LineWidth',1.5,'Color','k')
ylim([-10,50])
xlabel('$t$','Interpreter','latex')
ylabel('$\ln t$','Interpreter','latex')
```

> 或者使用`fplot`函数 [2] 进行绘制：
>
> ```matlab
> clc,clear,close all
> syms x
> hold(gca,"on")
> grid(gca,"on")
> box(gca,"on")
> fplot(1./log(x),[0 2],'LineWidth',1.5,'Color','k')
> ylim([-10,50])
> xlabel('$t$','Interpreter','latex')
> ylabel('$\ln t$','Interpreter','latex')
> ```
>
> <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230428165415562.png?raw=true" alt="image-20230428165415562" style="zoom:50%;" />

式$\eqref{eq0}$的变上限积分函数（Integrals with variable upper limit function）为：

$$
Li(x)=\int_{0}^x\dfrac1{\ln t}\mathrm{d}t\label{eq1}
$$

这个函数被称为**积分对数函数（the log integral function)**，通常被记作$Li(x)$或者$li(x)$ [3]。它被定义为上图中$(0,x]$区间上函数曲线与$x$轴所包含的面积（注意，这个面积是有正负号的）。

在MATLAB Symbolic Math Toolbox中，由专门的`logint`函数 [4] 来计算这个变上限积分，例如我们可以绘制出$Li(x)$随$x$变化的曲线：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230427233358700.png?raw=true" alt="image-20230427233358700" style="zoom:50%;" />

```matlab
clc,clear,close all
syms x
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
fplot(logint(x),[0 10],'LineWidth',1.5,'Color','k')
xlabel('$x$','Interpreter','latex')
ylabel('$li(x)$','Interpreter','latex')
```

从数学上讲，关于积分对数函数$Li(x)$有两点需要注意：

（1）$Li(x)$没有初等的原函数；

（2）$1/\ln t$在$x=1$处具有一个瑕点，因此$Li(x)$本质上是一个反常积分（improper integral）[5]；

<br>

# The Relation to The PNT

当$x$特别大时，我们可以用累加的方法来近似$Li(x)$：

$$
Li(x)\approx \dfrac1{\ln 2}+\dfrac1{\ln 3}+\dfrac1{\ln 4}+\cdots\dfrac1{\ln \lfloor x\rfloor}\label{eq2}
$$

例如，当$x=10^6$时，式$\eqref{eq2}$左端的$Li(x)$和右端的加和的值分别：

```matlab
clc,clear,close all
format long
Li = logint(1e6)
Sum = sum(1./log(2:1e6))
```

```
Li =
     7.862754915946219e+04
Sum =
     7.862734211232568e+04
```

绝对误差低于$0.21$，百分比误差为低于$0.0003\%$：

```matlab
>> Li-Sum
ans =
   0.207047136500478
   
>> (Li-Sum)/Li*100
ans =
     2.633264532773007e-04
```

进一步，根据对数观念 [6]，当$x$特别大时，我们可以将式$\eqref{eq2}$近似地写作：

$$
Li(x)\approx\dfrac{x}{\ln x}\notag
$$

即：

$$
Li(x)\sim\dfrac{x}{\ln x}\notag
$$

而根据素数定理（PNT），随着$N$的增大，有 [5]：

$$
\pi(N)\sim\dfrac{N}{\ln N}\notag
$$

由于PNT定理是成立的，因此：

$$
\pi(N)\sim Li(N)\label{eq3}
$$

一定也成立，并且$\eqref{eq3}$是素数定理PNT的一个改进的版本（Improved Version）。

并且，不仅成立，**而且比成立还成立（truer）**，即**$Li(N)$实际上比$N/\ln N$能更好地估计$\pi(N)$，$Li(N)$是一个好得多的估计**。

| $N$                   | $\pi(N)$            | $\dfrac{N}{\ln N}-\pi(N)$ | $Li(N)-\pi(N)$ |
| --------------------- | ------------------- | ------------------------- | -------------- |
| $100,000,000$         | $5,761,455$         | $-332,774$                | $754$          |
| $1,000,000,000$       | $50,847,534$        | $-2,592,592$              | $1,701$        |
| $10,000,000,000$      | $455,052,511$       | $-20,758,030$             | $3,104$        |
| $100,000,000,000$     | $4,118,054,813$     | $-169,923,160$            | $11,588$       |
| $1,000,000,000,000$   | $37,607,912,018$    | $-1,416,706,193$          | $38,263$       |
| $10,000,000,000,000$  | $346,065,536,839$   | $-11,992,858,452$         | $108,971$      |
| $100,000,000,000,000$ | $3,204,941,750,802$ | $-102,838,308,636$        | $314,890$      |

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230428143931252.png?raw=true" style="zoom:50%;" />

并且，对于表和图中显示的所有$N$值，$N/\ln N$给出了对$\pi(N)$的一个**低的**估计，而$Li(x)$给出了一个**高的**估计。

<br>

**References**

[1] Derbyshire J. Prime obsession: Bernhard Riemann and the greatest unsolved problem in mathematics[M]. Joseph Henry Press, 2003.

[2] [fplot - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/fplot.html).

[3] [Logarithmic integral function - Wikipedia](https://en.wikipedia.org/wiki/Logarithmic_integral_function).

[4] [logint - MathWorks](https://ww2.mathworks.cn/help/symbolic/sym.logint.html?s_tid=srchtitle_logint_1).

[5] [Improper integral - Wikipedia](https://en.wikipedia.org/wiki/Improper_integral).

[6] [The Prime Number Theorem (PNT) from Prime Obsession by Derbyshire - What a starry night~](http://whatastarrynight.com/mathematics/The-Prime-Number-Theorem-(PNT)-from-Prime-Obsession-by-Derbyshire/).
