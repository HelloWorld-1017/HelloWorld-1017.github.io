---
title: Subtantial Derivative from *Fundamentals of Aerodynamics* by Anderson
categories: 
 - Mathematics
 - Physics
tags:
 - Mathematical Analysis
 - Computational Fluid Dynamics
date: 2023-04-19 14:31:29 +0800
last_modified_at: 2024-07-17 14:58:46 +0800
---

# Substantial Derivative

考虑一个小的流体维微团在流场中移动，如下图所示：

![image-20230418133726838](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230418133726838.png?raw=true)

速度场给定为：

$$
\boldsymbol{\mathrm{V}}=u\boldsymbol{\mathrm{i}}+v\boldsymbol{\mathrm{j}}+w\boldsymbol{\mathrm{k}}\notag
$$

其中：

$$
\begin{split}
&u=u(x,y,z,t)\\
&v=v(x,y,z,t)\\
&w=w(x,y,z,t)\\
\end{split}\notag
$$

另外，密度场给定为：

$$
\rho=\rho(x,y,z,t)\notag
$$

在时间$t_1$时，流体微团处于流场中的点1处，并且密度为：

$$
\rho_1=\rho(x_1,y_1,z_1,t_1)\notag
$$

时间$t_2$时，流体微团移动到了流场中的点2处，密度为：

$$
\rho_2=\rho(x_2,y_2,z_2,t_2)\notag
$$

由于$\rho=\rho(x,y,z,t)$，流体微团在点2处的密度$\rho_2$可以用泰勒展开式进行表达：

$$
\begin{split}
\rho_2=&\rho_1
+\Big(\dfrac{\partial\rho}{\partial x}\Big)\Big\vert_1(x_2-x_1)
+\Big(\dfrac{\partial\rho}{\partial y}\Big)\Big\vert_1(y_2-y_1)\\
&+\Big(\dfrac{\partial\rho}{\partial z}\Big)\Big\vert_1(z_2-z_1)
+\Big(\dfrac{\partial\rho}{\partial t}\Big)\Big\vert_1(t_2-t_1)+\text{high-order terms}
\end{split}\notag
$$

忽略高阶项，进一步有：

$$
\dfrac{\rho_2-\rho_1}{t_2-t_1}=
\Big(\dfrac{\partial\rho}{\partial x}\Big)\Big\vert_1\dfrac{x_2-x_1}{t_2-t_1}
+\Big(\dfrac{\partial\rho}{\partial y}\Big)\Big\vert_1\dfrac{y_2-y_1}{t_2-t_1}
+\Big(\dfrac{\partial\rho}{\partial z}\Big)\Big\vert_1\dfrac{z_2-z_1}{t_2-t_1}
+\Big(\dfrac{\partial\rho}{\partial t}\Big)\Big\vert_1\label{eq3}
$$

式中，$(\rho_2-\rho_1)/(t_2-t_1)$表示：随着流体微团从点1移动到点2，流体微团密度变化的平均（*average*）时间速率。随着时间$t_2$无限接近$t_1$，这一项可以写作：

$$
\lim_{t_2\rightarrow t_1}\dfrac{\rho_2-\rho_1}{t_2-t_1}=\dfrac{D\rho}{Dt}\notag
$$

这里，左端项$D\rho/Dt$表示：随着流体微团移动经过点1，流体微团密度变化的瞬时（*instantaneous*）时间速率。符号

$$
D/Dt\notag
$$

被定义为物质导数（substantial derivative）。

注意，$D\rho/Dt$随着一个给定流体微团（a given fluid element）穿过空间，该流体微团密度变化的时间速率。我们的视角始终锁定在这个流体微团运动，在它经过点1时，我们看到了这个流体微团的密度发生了变化。因此，它与$(\partial\rho/\partial t)_1$是不一样的，后者在物理上表示固定（fixed）点处密度变化的时间速率。对于$(\partial\rho/\partial t)_1$，我们是将视角固定在固定点1处，并且观测到由流场中的瞬态波动（transient fluctuations）而导致的密度变化。因此，$D\rho/Dt$和$(\partial\rho/\partial t)_1$在物理上（physically）和数值上（numerically）都是不同的量。

对于式$\eqref{eq3}$的右端，我们注意到有：

$$
\begin{split}
\lim_{t_2\rightarrow t_1}\dfrac{x_2-x_1}{t_2-t_1}&\equiv u\\
\lim_{t_2\rightarrow t_1}\dfrac{y_2-y_1}{t_2-t_1}&\equiv v\\
\lim_{t_2\rightarrow t_1}\dfrac{z_2-z_1}{t_2-t_1}&\equiv w\\
\end{split}\notag
$$

注：位移/时间=速度。
{: .notice--primary}

最终，当$t_2\rightarrow t_1$时，式$\eqref{eq3}$可以写作：

$$
\dfrac{D\rho}{Dt}=
u\dfrac{\partial\rho}{\partial x}+
v\dfrac{\partial\rho}{\partial y}+
w\dfrac{\partial\rho}{\partial z}+\dfrac{\partial\rho}{\partial t}\label{eq4}
$$

从式$\eqref{eq4}$中，我们可以得到在笛卡尔坐标系下物质导数的定义：

$$
\dfrac{D}{Dt}\equiv
u\dfrac{\partial}{\partial x}+
v\dfrac{\partial}{\partial y}+
w\dfrac{\partial}{\partial z}+\dfrac{\partial}{\partial t}\label{eq5}
$$

进一步地，在笛卡尔坐标系下，向量算子（vector operator）定义为：

$$
\nabla\equiv\boldsymbol{\mathrm{i}}\dfrac{\partial}{\partial x}+\boldsymbol{\mathrm{j}}\dfrac{\partial}{\partial y}+\boldsymbol{\mathrm{k}}\dfrac{\partial}{\partial z}
$$

注：算子$\nabla$也被称为是哈密顿算子（Hamilton operator）。
{: .notice--primary}

因此，式$\eqref{eq5}$也可以写作：

$$
\dfrac{D}{Dt}\equiv\dfrac{\partial}{\partial t}+(\boldsymbol{\mathrm{V}}\cdot\nabla)\label{eq6}
$$

式$\eqref{eq6}$是以向量形式表达的物质导数的定义，因此，它适用于各种坐标系统。

再次强调，式$\eqref{eq6}$中：

- $D/Dt$是物质导数（substantial derivative），在物理上表示的是随移动流体微团变化的时间速率（which is physically the time rate of change following a moving fluid element）;
- $\partial/\partial t$被称作局部导数（local derivative），在物理上表示在一个固定点处变化的时间速率（which is physically the time rate of change at a fixed point）；
- $\boldsymbol{\mathrm{V}}\cdot\nabla$被称作对流导数（convective derivative），在物理上表示由于流体微团从流场中的一个点到另外一个另一个点（这两个点在空间中的流场性质不同）的运动而变化的时间速率（which is physically the time rate of change due to the movement of the fluid element from one location to another in the flow field where the flow properties are spatially different）。

物质导数可以应用于任何的流场变量（e.g., $Dp/Dt,\ DT/Dt,\ Du/Dt$），例如对于温度$T$有：

$$
\dfrac{DT}{Dt}\equiv\dfrac{\partial T}{\partial t}+(\boldsymbol{\mathrm{V}}\cdot\nabla)T\equiv
\dfrac{\partial T}{\partial t}+
u\dfrac{\partial T}{\partial x}+
v\dfrac{\partial T}{\partial y}+
w\dfrac{\partial T}{\partial z}\label{eq7}
$$

式$\eqref{eq7}$在物理上表明：当流体微团扫过流中的一个点时，流体微团的温度正在变化，一是因为在该点处流场温度本身可能随时间波动（局部导数），二是因为流体微团只是在去往流场中温度不同的另一个点的路上（对流导数）。

> Again, Equation $\eqref{eq7}$ states physically that the temperature of the fluid element is changing as the element sweeps past a point in the flow because at that point the flow-field temperature itself may be fluctuating with time (the local derivative) and because the fluid element is simply on its way to another point in the flow field where the temperature is different (the convective derivative).）

想象这样一个场景可能会帮助我们来理解物质导数的含义：假如我们正在山上徒步，此时我们准备进入一个山洞。山洞内部的温度比外面更低。因此，当我们穿过洞口时，我们会感到温度的降低——这类似于对流导数；另一方面，想象与此同时，一个朋友向我们丢了一个雪球，并且当我们经过洞口的瞬间雪球刚好砸中我们。当雪球击中我们时，我们会感受到一个额外的、瞬间的温度降低——这类似于局部导数。因此，当我们经过洞口时所感受到的净温度降低（net temperature drop）是这两个影响的共同作用：（1）进入洞穴；（2）与此同时被雪球击中——这个净温度降低就类似于物质导数。

> Consider an example that will help to reinforce the physical meaning of the substantial derivative. Imagine that you are hiking in the mountains, and you are about to enter a cave. The temperature inside the cave is cooler than outside. Thus, as you walk through the mouth of the cave, you feel a temperature decrease—this is analogous to the convective derivative. However, imagine that, at the same time, a friend throws a snowball at you such that the snowball hits you just at the same instant you pass through the mouth of the cave. You will feel an additional, but momentary, temperature drop when the snowball hits you—this is analogous to the local derivative. The net temperature drop you feel as you walk through the mouth of the cave is therefore a combination of both the act of moving into the cave, where it is cooler, and being struck by the snowball at the same instant—this net temperature drop is analogous to the substantial derivative.

<br>

# Fundamental Equations in Terms of the Substantial Derivative

向量恒等式：

$$
\nabla\cdot(\rho\boldsymbol{\mathrm{V}})\equiv\rho\nabla\cdot\boldsymbol{\mathrm{V}}+\boldsymbol{\mathrm{V}}\cdot\nabla\rho\label{eq8}
$$

这个恒等式表明：变量和向量的乘积的散度等于标量乘向量的散度加上向量和标量散度的点积。

## Continuity equation

考虑微分形式的连续方程 [2]：

$$
\dfrac{\partial p}{\partial t}+\nabla\cdot(\rho\boldsymbol{\mathrm{V}})=0\label{eq10}
$$

使用向量恒等式$\eqref{eq8}$可以将其改写为：

$$
\dfrac{\partial p}{\partial t}+\rho\nabla\cdot\boldsymbol{\mathrm{V}}+\boldsymbol{\mathrm{V}}\cdot\nabla\rho=0\notag
$$

进而有：

$$
\dfrac{D\rho}{Dt}+\rho\nabla\cdot\boldsymbol{\mathrm{V}}=0\label{eq9}
$$

式$\eqref{eq9}$就是使用物质导数形式所表达的连续方程。

<br>

## Momentum equation

考虑微分形式的动量方程（$x$分量）：

$$
\dfrac{\partial({\rho u)}}{\partial t}+\nabla\cdot(\rho u\boldsymbol{\mathrm{V}})=-\dfrac{\partial p}{\partial x}+\rho f_x+\boldsymbol({\mathcal{F}_x})_{viscous}\label{NSx}
$$

左端第一项可以展开为：

$$
\dfrac{\partial({\rho u)}}{\partial t}=\rho\dfrac{\partial u}{\partial t}+u\dfrac{\partial\rho}{\partial t}\notag
$$

对于第二项，我们可以将$u$视作标量，而将$\rho\boldsymbol{\mathrm{V}}$视作向量，因此根据向量恒等式$\eqref{eq8}$可以将其改写为：

$$
\nabla\cdot(\rho u\boldsymbol{\mathrm{V}})=u\nabla\cdot(\rho\boldsymbol{\mathrm{V}})+(\rho\boldsymbol{\mathrm{V}})\cdot\nabla u\notag
$$

因此，式$\eqref{NSx}$可以改写为：

$$
\rho\dfrac{\partial u}{\partial t}+u\Big[\dfrac{\partial\rho}{\partial t}+\nabla\cdot(\rho\boldsymbol{\mathrm{V}})\Big]+(\rho\boldsymbol{\mathrm{V}})\cdot\nabla u=-\dfrac{\partial p}{\partial x}+\rho f_x+\boldsymbol({\mathcal{F}_x})_{viscous}\notag
$$

式子左段方括号的部分正是连续方程$\eqref{eq10}$，因此有：

$$
\rho\Big(\dfrac{\partial u}{\partial t}+\boldsymbol{\mathrm{V}}\cdot\nabla u\Big)=-\dfrac{\partial p}{\partial x}+\rho f_x+\boldsymbol({\mathcal{F}_x})_{viscous}\notag
$$

使用向量恒等式$\eqref{eq8}$最终可以将其改写为：

$$
\rho\dfrac{Du}{Dt}=-\dfrac{\partial p}{\partial x}+\rho f_x+\boldsymbol({\mathcal{F}_x})_{viscous}\label{DNSx}
$$

同理，对于$y$分量和$z$分量的动量方程有：

$$
\rho\dfrac{Dv}{Dt}=-\dfrac{\partial p}{\partial y}+\rho f_y+\boldsymbol({\mathcal{F}_y})_{viscous}\label{DNSy}
$$

$$
\rho\dfrac{Dw}{Dt}=-\dfrac{\partial p}{\partial z}+\rho f_z+\boldsymbol({\mathcal{F}_z})_{viscous}\label{DNSz}
$$

式$\eqref{DNSx}$-$\eqref{DNSz}$就是使用物质导数形式所表达的动量方程。

在现代空气动力学当中，通常称式$\eqref{eq10}$和式$\eqref{NSx}$为基本方程的守恒形式（conservation form）（有时候也被称为是散度形式，divergence form，因为左端项的散度项）；相反，式$\eqref{eq9}$、式$\eqref{DNSx}$-式$\eqref{DNSz}$被称作非守恒形式（nonconservation form），因为左端项具有物质导数。这两种形式都是基本方程的有效描述，在大多数情况下，没有特别的理由选择一种形式而不是另一种形式。非守恒形式频繁地出现在教科书和动力学理论中；然而，对于一些空气动力学理论的数值求解方法，守恒形式有时会得到更加精确的结果。因此，守恒形式和非守恒形式之间的区别在现代计算流体动力学学科中变得很重要。

<br>

References

[1] Anderson, John. *EBOOK: Fundamentals of Aerodynamics (SI units)*. McGraw hill, 2011.

[2] [Continuity Equations of the Fluid from Fundamentals of Aerodynamics by Anderson - What a starry night~](http://whatastarrynight.com/mathematics/computational fluid dynamics/Continuity-Equations-of-the-Fluid-from-Fundamentals-of-Aerodynamics-by-Anderson/).

[3] [Momentum Equations of the Fluid from Fundamentals of Aerodynamics by Anderson - What a starry night~](http://whatastarrynight.com/mathematics/computational fluid dynamics/Momentum-Equations-of-the-Fluid-from-Fundamentals-of-Aerodynamics-by-Anderson/)。



