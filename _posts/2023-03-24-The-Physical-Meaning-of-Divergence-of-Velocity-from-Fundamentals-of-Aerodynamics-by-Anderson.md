---
layout: single
title: The Physical Meaning of Divergence of Velocity from *Fundamentals of Aerodynamics* by Anderson
date: 2023-03-24 19:45:37 +0800
categories: 
 - Mathematics
 - Computational Fluid Dynamics
tags:
 - Mathematical Analysis
toc: false
---

考虑一个随流线运动的有限控制体（参考博客：[Three Different Models of the Fluid from *Fundamentals of Aerodynamics* by Anderson](http://whatastarrynight.com/mathematics/computational%20fluid%20dynamics/Three-Different-Models-of-the-Fluid-from-Fundamentals-of-Aerodynamics-by-Anderson/)）：

![image-20230322143537903](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230322143537903.png?raw=true)

该控制体是总是包含相同的流体粒子，因此它的质量是固定的，不随时间运动。然而，它的体积$V$和控制面$S$随时间变化，也就导致它的密度$\rho$随时间变化。

在某一时刻，该控制体的状态如下图所示：

![image-20230322143644076](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230322143644076.png?raw=true)

假设在该时刻，有限体的体积为$\mathcal{V}$，控制面的面积为$S$。我们首先考虑$\mathrm{d}S$（注意这是一个标量）的运动：在经过$\Delta t$的时间后，有限控制体的体积由于$\mathrm{d}S$的运动增加了$\Delta\mathcal{V}$（可以看成是相比原先的有限控制体凸起了一个柱体）：

$$
\Delta\mathcal{V} = \Delta t\cdot(\mathrm{\boldsymbol{V}}\cdot\mathrm{\boldsymbol{n}})\mathrm{d}S=(\mathrm{\boldsymbol{V}}\Delta t)\boldsymbol{\mathrm{d}S}\label{eq1}
$$

如果考虑整个控制面$S$的运动，整个控制体的体积增量可以看做是$\eqref{eq1}$在整个控制面的加和。当$\mathrm{d}S\rightarrow0$，则可以写作积分形式：

$$
\iint_S(\mathrm{\boldsymbol{V}}\Delta t)\boldsymbol{\mathrm{d}S}\label{eq2}
$$

将式$\eqref{eq2}$除以$\Delta t$，则有：

$$
\dfrac1{\Delta t}\iint_S(\mathrm{\boldsymbol{V}}\Delta t)\boldsymbol{\mathrm{d}S}=\iint_S\mathrm{\boldsymbol{V}}\cdot\boldsymbol{\mathrm{d}S}\label{eq3}
$$

式$\eqref{eq3}$在物理上就表示控制体体积变化的时间速率（time rate of change of the control volume），并记作$D\mathcal{V}/Dt$，即：

$$
\dfrac{D\mathcal{V}}{Dt}=\iint_S\mathrm{\boldsymbol{V}}\cdot\boldsymbol{\mathrm{d}S}
$$

根据散度定理（[Divergence theorem](http://whatastarrynight.com/mathematics/computational%20fluid%20dynamics/A-Review-of-Vector-Calculus-from-Fundamentals-of-Aerodynamics-by-Anderson/#divergence-theorem)），可以得到：

$$
\dfrac{D\mathcal{V}}{Dt}=\iiint_\mathcal{V} (\nabla\cdot\boldsymbol{\mathrm{V}})\mathrm{d}\mathcal{V}\label{eq5}
$$

假设上图2.15中的移动的控制体的体积收缩到一个非常小的体积$\delta \mathcal{V}$，本质上就成为了一个无限小流体微团（[Three Different Models of the Fluid from *Fundamentals of Aerodynamics* by Anderson](http://whatastarrynight.com/mathematics/computational%20fluid%20dynamics/Three-Different-Models-of-the-Fluid-from-Fundamentals-of-Aerodynamics-by-Anderson/)）

![image-20230322160445020](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230322160445020.png?raw=true)

则式$\eqref{eq5}$就可以写作：

$$
\dfrac{D(\delta\mathcal{V})}{Dt}=\iiint_{\delta\mathcal{V}}(\nabla\cdot\boldsymbol{\mathrm{V}})\mathrm{d}\mathcal{V}\notag
$$

进一步可以得到：

$$
\dfrac{D(\delta\mathcal{V})}{Dt}=(\nabla\cdot\boldsymbol{\mathrm{V}}){\delta\mathcal{V}}\notag
$$

或者记作：

$$
\nabla\cdot\boldsymbol{\mathrm{V}}=\dfrac1{\delta\mathcal{V}}
\dfrac{D(\delta\mathcal{V})}{Dt}\label{eq6}
$$

从物理角度讲，式$\eqref{eq6}$表明$\nabla\cdot\boldsymbol{\mathrm{V}}$（即速度矢量的散度）等于移动流体微团每单位体积的体积变化时间速率（*time rate of change of volume of a moving fluid element, per unit volume*）。

<br>

**References**

[1] Anderson, John. *EBOOK: Fundamentals of Aerodynamics (SI units)*. McGraw hill, 2011.

