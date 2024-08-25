---
title: Momentum Equations of the Fluid from *Fundamentals of Aerodynamics* by Anderson
categories: 
 - Mathematics
 - Physics
tags:
 - Mathematical Analysis
 - Computational Fluid Dynamics
date: 2023-03-31 15:00:01 +0800
last_modified_at: 2024-07-17 14:58:21 +0800
---

# Introduction

牛顿第二定律可以写作：

$$
\boldsymbol{\mathrm{F}}=m\boldsymbol{\mathrm{a}}\label{eq1}
$$

其中，$\boldsymbol{\mathrm{F}}$是施加在质量体$m$上的力，$\boldsymbol{\mathrm{a}}$是加速度。式$\eqref{eq1}$的另一种更通用的表达式是：

$$
\boldsymbol{\mathrm{F}}=\dfrac{\mathrm{d}}{\mathrm{d}t}(m\boldsymbol{\mathrm{V}})\label{eq2}
$$

其中，$m\boldsymbol{\mathrm{V}}$称作质量体$m$的动量（momentum）。式$\eqref{eq2}$体现了理论流体动力学的第二基本原理：

$$
\mathrm{Force\ =time\ rate\ of\ change\ of\ momentum}\notag
$$

将这一原理，即式$\eqref{eq2}$，应用到一个空间位置固定的有限控制体上（如下图所示），就可以得到流体动量方程（Momentum equations）的表达式。

![image-20230329231542103](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230329231542103.png?raw=true)

<br>

# Force

首先关注式$\eqref{eq2}$的左端项$\boldsymbol{\mathrm{F}}$，它是当流体流过控制体时施加在流体上的力（which is the force exerted on the fluid as it flows through the control volume）。这个力有两个来源：

- 体积力（Body forces）：包括重力（gravity），电磁力（electromagnetic forces），或者或任何其他“远距离作用”于体积$\mathcal{V}$内部的流体的力（or any other forces which "act at distance" on the fluid inside inside $\mathcal{V}$）.
- 表面力（Surface forces）：施加在控制面$S$上的压力（pressure）和剪切力（shear stress）；

## Body forces

令$\boldsymbol{\mathrm{f}}$表示每**单位质量**施加在控制体$\mathcal{V}$内部的流体上的净体积力，则施加在体微元$\mathrm{d}\mathcal{V}$上的体积力（密度$\times$体积$\times$力）可以表示为：

$$
\rho\boldsymbol{\mathrm{f}}\mathrm{d}\mathcal{V}\notag
$$

则施加在整个控制体上的体积力可以表示为：

$$
\mathrm{Body\ force}=\iiint_\mathcal{V}\rho\boldsymbol{\mathrm{f}}\mathrm{d}\mathcal{V}
$$

## Pressure

由于压力施加在面积微元$\mathrm{d}S$上的表面力微元为：

$$
-p\boldsymbol{\mathrm{dS}}\notag
$$

其中负号表示压力施加的方向与$\boldsymbol{\mathrm{dS}}$的方向相反，即控制面所承受的压力方向指向控制体的内部。因此，施加在整个控制面上的表面力可以表示为：

$$
\mathrm{Pressure\ force}=-\iint_Sp\boldsymbol{\mathrm{dS}}
$$

## Viscous stress

在粘性流体中（viscous flow），剪切力（shear stress）和法向粘性力（normal viscous）同样施加在粘性流体的表面。粘性力（viscous stresses）的分析非常复杂，分为很多种情况，为了简化分析，在这里将施加在控制面上的总体的粘性力概括表示为

$$
\boldsymbol{\mathrm{F}}_{viscous}
$$

## Conclusion

综上，我们可以得到“流体穿过空间位置的控制体时所受的合力（the total force experienced by the fluid as it is sweeping through the fixed control volume）”，即式$\eqref{eq2}$的左端项，表示为：

$$
\boldsymbol{\mathrm{F}}=\iiint_\mathcal{V}\rho\boldsymbol{\mathrm{f}}\mathrm{d}\mathcal{V}-\iint_Sp\boldsymbol{\mathrm{dS}}+\boldsymbol{\mathrm{F}}_{viscous}\label{left}
$$

<br>

# Time Rate of Change of Momentum of the Fluid

现在考虑$\eqref{eq2}$的右端项。流体穿过位置空间固定的控制体时动量的时间变化率可以表示为两项的总和：

$$
\mathrm{Net\ flow\ of\ momentum\ }out\ \mathrm{of\ control\ volume\ across\ surface}\ S\equiv\boldsymbol{\mathrm{G}}\label{eq3}
$$

以及：

$$
\mathrm{Time\ rate\ of\ change\ of\ momentum\ due\ to\ unsteady\ fluctuations\ of\ flow\ properties\ inside}\ \mathcal{V}\equiv\boldsymbol{\mathrm{H}}\label{eq4}
$$

## Net flow of momentum *out* of control volume

首先考虑式$\eqref{eq3}$表示的$\boldsymbol{\mathrm{G}}$。流体在进入控制体中有一个确定的动量，并且通常而言，随着它离开控制体，它的动量会发生变化（部分是因为随着它经过控制体$\mathcal{V}$，施加在流体上的力$\boldsymbol{\mathrm{F}}$）。通过控制面$S$流出控制体的动量的净流量可以简单地表示为通过控制面的动量净出量减去动量净入量。根据博客[Continuity Equations of the Fluid from Fundamentals of Aerodynamics by Anderson: The Definitions of Mass Flow and Mass Flux](http://whatastarrynight.com/mathematics/computational fluid dynamics/Continuity-Equations-of-the-Fluid-from-Fundamentals-of-Aerodynamics-by-Anderson/#the-definitions-of-mass-flow-and-mass-flux)中整理的内容：通过面积微元$\mathrm{d}S$的质量流量（mass flow，kg/s，每秒穿过面微元$\boldsymbol{\mathrm{d}S}$的质量）可以表示为$\rho\boldsymbol{\mathrm{V\cdot dS}}$。因此，每秒穿过$\mathrm{d}S$的动量通量可以写作：

$$
(\rho\boldsymbol{\mathrm{V\cdot dS}})\boldsymbol{\mathrm{V}}\notag
$$

因此，可以得到通过$S$流出控制体的动量流量$\boldsymbol{\mathrm{G}}$为：

$$
\boldsymbol{\mathrm{G}}=\iint_S(\rho\boldsymbol{\mathrm{V\cdot dS}})\boldsymbol{\mathrm{V}}\label{G}
$$

注：由于质量流量的正方向与动量净流量out的方向是一致的，因此这里没有负号。
{: .notice--warning}

## Time rate of change of momentum due to unsteady fluctuations of flow properties inside control volume

接下来考虑式$\eqref{eq4}$表示的$\boldsymbol{\mathrm{H}}$。在体微元$\mathrm{d}\mathcal{V}$中的流体的动量可以表示为：

$$
(\rho\mathrm{d}\mathcal{V})\boldsymbol{\mathrm{V}}\notag
$$

因此，在任意时刻控制体内部的动量可以表示为：

$$
\iiint_\mathcal{V}\rho\boldsymbol{\mathrm{V}}\mathrm{d}\mathcal{V}\notag
$$

最终，由于不稳定流体波动（unsteady flow fluctuations）而导致的动量的时间变化率$\boldsymbol{\mathrm{H}}$可以表示为：

$$
\boldsymbol{\mathrm{H}}=\dfrac{\partial}{\partial t}\iiint_\mathcal{V}\rho\boldsymbol{\mathrm{V}}\mathrm{d}\mathcal{V}\label{H}
$$

结合式$\eqref{G}$和式$\eqref{H}$，可以获得流体穿过空间位置固定的控制体时其动量的时间变换率，即式$\eqref{eq2}$的右端项为：

$$
\dfrac{\mathrm{d}}{\mathrm{d}t}(m\boldsymbol{V})=\boldsymbol{\mathrm{G}}+\boldsymbol{\mathrm{H}}=\iint_S(\rho\boldsymbol{\mathrm{V\cdot dS}})\boldsymbol{\mathrm{V}}+\dfrac{\partial}{\partial t}\iiint_\mathcal{V}\rho\boldsymbol{\mathrm{V}}\mathrm{d}\mathcal{V}\label{right}
$$

<br>

# Momentum Equations in Integral and Partial Differential Forms

结合式$\eqref{left}$和式$\eqref{right}$，可以得到式$\eqref{eq2}$的具体表达形式：

$$
\dfrac{\partial}{\partial t}\iiint_\mathcal{V}\rho\boldsymbol{\mathrm{V}}\mathrm{d}\mathcal{V}+\iint_S(\rho\boldsymbol{\mathrm{V\cdot dS}})\boldsymbol{\mathrm{V}}=-\iint_Sp\boldsymbol{\mathrm{dS}}+\iiint_\mathcal{V}\rho\boldsymbol{\mathrm{f}}\mathrm{d}\mathcal{V}+\boldsymbol{\mathrm{F}}_{viscous}\label{integral}
$$

式$\eqref{integral}$是动量方程（momentum equation）的积分形式，注意这是一个向量方程。类似在博客[Continuity Equations of the Fluid from Fundamentals of Aerodynamics by Anderson: Continuity Function in Integral Form](http://whatastarrynight.com/mathematics/computational fluid dynamics/Continuity-Equations-of-the-Fluid-from-Fundamentals-of-Aerodynamics-by-Anderson/#continuity-function-in-integral-form)中提到的连续方程的积分形式，式$\eqref{integral}$的优点是从整个有限空间区域的观点解释流体力学的现象，而不需要关注流体中某个点的细节。

根据式$\eqref{integral}$，我们可以推导出动量方程的偏微分形式，从空间中的某个点解释流场的性质。根据梯度定理（[A Review of Vector Calculus from Fundamentals of Aerodynamics by Anderson: Gradient theorem](http://whatastarrynight.com/mathematics/computational fluid dynamics/A-Review-of-Vector-Calculus-from-Fundamentals-of-Aerodynamics-by-Anderson/#gradient-theorem)），式$\eqref{integral}$右端的第一项可以改写为：

$$
-\iint_Sp\boldsymbol{\mathrm{dS}}=-\iiint_\mathcal{V}\nabla p\ \mathrm{d}\mathcal{V}\notag
$$

并且，由于控制体是固定的，式$\eqref{integral}$的时间导数可以放在积分号的内部，因此，$\eqref{integral}$最终可以写作：

$$
\iiint_\mathcal{V}\dfrac{\partial({\rho\boldsymbol{\mathrm{V}})}}{\partial t}\mathrm{d}\mathcal{V}+\iint_S(\rho\boldsymbol{\mathrm{V\cdot dS}})\boldsymbol{\mathrm{V}}=-\iiint_\mathcal{V}\nabla p\ \mathrm{d}\mathcal{V}+\iiint_\mathcal{V}\rho\boldsymbol{\mathrm{f}}\mathrm{d}\mathcal{V}+\boldsymbol{\mathrm{F}}_{viscous}
$$

再次强调，式$\eqref{integral}$是一个向量方程，在三维笛卡尔坐标系下，速度可以写作：

$$
\boldsymbol{\mathrm{V}}=u\boldsymbol{\mathrm{i}}+v\boldsymbol{\mathrm{j}}+w\boldsymbol{\mathrm{k}}\notag
$$

为了简化分析，这里仅针对$x$分量推导微分形式的动量方程，$y$分量和$z$分量的推导是类似的。

$$
\iiint_\mathcal{V}\dfrac{\partial({\rho u)}}{\partial t}\mathrm{d}\mathcal{V}+\iint_S(\rho\boldsymbol{\mathrm{V\cdot dS}})u=-\iiint_\mathcal{V}\dfrac{\partial p}{\partial x}\ \mathrm{d}\mathcal{V}+\iiint_\mathcal{V}\rho f_x\mathrm{d}\mathcal{V}+\boldsymbol({\mathrm{F}_x})_{viscous}\label{eq5}
$$

注：式$\eqref{eq5}$中，乘积$(\rho\boldsymbol{\mathrm{V\cdot dS}})$是一个标量，不是向量，并没有分量。
{: .notice--warning}

对于式$\eqref{eq5}$中的左端第二项应用散度定理，有：

$$
\iint_S(\rho\boldsymbol{\mathrm{V\cdot dS}})u=\iiint_\mathcal{V}\nabla\cdot(\rho u\boldsymbol{\mathrm{V}})\mathrm{d}\mathcal{V}\notag
$$

最终，式$\eqref{eq5}$可以改写为：

$$
\iiint_\mathcal{V}\Big[\dfrac{\partial({\rho u)}}{\partial t}+\nabla\cdot(\rho u\boldsymbol{\mathrm{V}})+\dfrac{\partial p}{\partial x}\ -\rho f_x-\boldsymbol({\mathcal{F}_x})_{viscous}\Big]\mathrm{d}\mathcal{V}=0
$$

要想使得上式的积分对于任意一个控制体都成立，则积分内部的表达式的值始终为0：

$$
\dfrac{\partial({\rho u)}}{\partial t}+\nabla\cdot(\rho u\boldsymbol{\mathrm{V}})=-\dfrac{\partial p}{\partial x}+\rho f_x+\boldsymbol({\mathcal{F}_x})_{viscous}\label{NSx}
$$

同理，对于$y$分量和$z$分量，有类似的微分形式的动量方程：

$$
\dfrac{\partial({\rho v)}}{\partial t}+\nabla\cdot(\rho v\boldsymbol{\mathrm{V}})=-\dfrac{\partial p}{\partial y}+\rho f_y+\boldsymbol({\mathcal{F}_y})_{viscous}\label{NSy}
$$

$$
\dfrac{\partial({\rho w)}}{\partial t}+\nabla\cdot(\rho w\boldsymbol{\mathrm{V}})=-\dfrac{\partial p}{\partial z}+\rho f_z+\boldsymbol({\mathcal{F}_z})_{viscous}\label{NSz}
$$

将方程$\eqref{NSx}$到$\eqref{NSz}$可以用矢量表示法写作 [2]：

$$
\dfrac{\partial}{\partial t}(\rho\boldsymbol{\mathrm{V}})+\nabla\cdot(\rho\boldsymbol{\mathrm{V}}\otimes\boldsymbol{\mathrm{V}})=-\nabla p+\rho\boldsymbol{f}+{\boldsymbol{\mathcal{F}}}_{viscous}\label{NSvec}
$$

注：其中，$\otimes$表示外积（outer product） [3]，有：$\boldsymbol{\mathrm{V}}\otimes\boldsymbol{\mathrm{V}}=\boldsymbol{\mathrm{V}}\boldsymbol{\mathrm{V}}^{T}$，在有些地方为了简便表示，甚至会直接写作$\boldsymbol{\mathrm{V}}\boldsymbol{\mathrm{V}}$，即：$\boldsymbol{\mathrm{V}}\otimes\boldsymbol{\mathrm{V}}=\boldsymbol{\mathrm{V}}\boldsymbol{\mathrm{V}}^{T}=\boldsymbol{\mathrm{V}}\boldsymbol{\mathrm{V}}$。
{: .notice--primary}

<br>

# NS Equations and Euler Equations

式$\eqref{integral}$以及式$\eqref{NSx}$到$\eqref{NSz}$可以应用于三维的、不稳定的任何流体，无论是可压缩、不可压缩，还是粘性、非粘性的流体。

对于稳定的（$\partial/\partial t\equiv0$）（稳态系统），非粘性（$\boldsymbol{\mathrm{F}}_{viscous}$）的，不考虑体积力（$\boldsymbol{\mathrm{f}}=0$）的流体而言，这些方程可以分别可以简化为：

$$
\iint_S(\rho\boldsymbol{\mathrm{V\cdot dS}})\boldsymbol{\mathrm{V}}=-\iint_Sp\boldsymbol{\mathrm{dS}}
$$

$$
\begin{split}
&\nabla\cdot(\rho u\boldsymbol{\mathrm{V}})=-\dfrac{\partial p}{\partial x}\\
&\nabla\cdot(\rho v\boldsymbol{\mathrm{V}})=-\dfrac{\partial p}{\partial y}\\
&\nabla\cdot(\rho w\boldsymbol{\mathrm{V}})=-\dfrac{\partial p}{\partial z}\\
\end{split}\label{Euler}
$$

其微分形式的矢量表示形式为：

$$
\nabla\cdot(\rho\boldsymbol{\mathrm{V}}\otimes\boldsymbol{\mathrm{V}})=-\nabla p\label{Eulervec}
$$

最后需要指出的是，非粘性流体的动量方程（式$\eqref{Euler}$以及对应的$\eqref{Eulervec}$）被称作欧拉方程（Euler equations）；粘性流体的动量方程（式$\eqref{NSx}$-$\eqref{NSz}$以及相对应的$\eqref{NSvec}$）则被称为Navier-Stokes方程（NS equations）。

<br>

**References**

[1] Anderson, John. *EBOOK: Fundamentals of Aerodynamics (SI units)*. McGraw hill, 2011.

[2] [Navier–Stokes equations - Wikipedia](https://en.wikipedia.org/wiki/Navier–Stokes_equations).

[3] [Outer product - Wikipedia](https://en.wikipedia.org/wiki/Outer_product).



