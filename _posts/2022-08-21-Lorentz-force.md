---
layout: single
title: Lorentz force
date: 2022-08-21 21:34:01 +0800
categories: 
 - Electromagnetism
---

# 背景

在电磁场领域，洛伦兹力(Lorentz force, or electromagnetic force)是指带电点电荷(point charge)在电磁场中受到的电场力(electric force)和磁场力(magnetic force)的合力。

一个电荷量为 $q$ 的带电粒子，以速度 $\boldsymbol{\mathrm{v}}$ 在电场 $\boldsymbol{\mathrm{E}}$ 和磁场 $\boldsymbol{\mathrm{B}}$ 内运动，它所受到力为：

$$
\boldsymbol{\mathrm{F}}=q\boldsymbol{\mathrm{E}}+q\boldsymbol{\mathrm{v}}\times\boldsymbol{\mathrm{B}}\notag
$$

这表明电荷量为 $q$ 的带电粒子受到了电场力和磁场力的合力，其中电场力的方向和电场 $\boldsymbol{\mathrm{E}}$ 的方向相同，磁场力垂直于速度 $\boldsymbol{\mathrm{v}}$ 和磁场 $\boldsymbol{\mathrm{B}}$ 所构成的平面。

这个基本公式有一些变种形式，它们描述了载流导线受到的电磁力（有时也被称作 Laplace force）、在磁场中运动的导线回路中所产生的电动势(electromotive force)（作为法拉第电磁感应定律(Faraday’s law of induction)的一个方面）以及移动带电粒子所收到的力。
<br>

# 用洛伦兹力定义电场和磁场

在许多经典的电磁场理论的教材中，洛伦兹力被用于 **定义** 电场 $\boldsymbol{\mathrm{E}}$ 和磁场 $\boldsymbol{\mathrm{B}}$。

洛伦兹力被理解为下面这种经验陈述：

在给定位置和时间，**测试电荷(test charge)**所受到的电磁力 $\boldsymbol{\mathrm{F}}$ 是其电荷 $q$ 和速度 $\boldsymbol{\mathrm{v}}$ 的特定方程，这个方程包含 $\boldsymbol{\mathrm{E}}$ 和 $\boldsymbol{\mathrm{B}}$ 两个参数，即

$$
\boldsymbol{\mathrm{F}}(q,\boldsymbol{\mathrm{v}})=q(\boldsymbol{\mathrm{E}}+\boldsymbol{\mathrm{v}}\times\boldsymbol{\mathrm{B}})\label{eq1}
$$

即使是对于接近光速的带电粒子，公式 $\eqref{eq1}$ 都是有效的。
{: .notice--primary}

公式 $\eqref{eq1}$ 中向量 $\boldsymbol{\mathrm{E}}$ 和 $\boldsymbol{\mathrm{B}}$ 在整个空间和时间上被定义为**电场(electric field)**和**磁场(magnetic field)**。电场和磁场用于描述测试电荷受到的力，而与测试电荷是否存在无关。

另外，电场和磁场一般是关于位置和时间的函数，因此式 $\eqref{eq1}$ 可以写作：

$$
\boldsymbol{\mathrm{F}}(\boldsymbol{\mathrm{r}},\dot{\boldsymbol{\mathrm{r}}},t,q)=q\Big[\boldsymbol{\mathrm{E}}(\boldsymbol{\mathrm{r}},t)+\dot{\boldsymbol{\mathrm{r}}}\times\boldsymbol{\mathrm{B}}(\boldsymbol{\mathrm{r}},t)\Big]\label{eq2}
$$

其中，$\boldsymbol{\mathrm{r}}$ 是带电粒子的位置向量，$\dot{\boldsymbol{\mathrm{r}}}$ 是位置向量对于时间的导数。
<br>

# 洛伦兹力的定义依赖于测试电荷

洛伦兹力对于作为电场 $\boldsymbol{\mathrm{E}}$ 和磁场 $\boldsymbol{\mathrm{B}}$ 的定义只是原则上的一个定义，因为洛伦兹力的定义是基于测试电荷的概念，而理想的测试电荷假定其物理性质（如大小、质量、电荷量等）相对于要研究的性质（比如在这里用于定义电场和磁场）是可以忽略的。在实际中：

（1）一个真正的带电粒子同样会产生它自己的有限电场和磁场，从而改变它所受到的电磁力。

（2）另外，如果电荷正在加速，被迫沿着曲线运动，它就会发射出辐射，从而导致动能(kinetic energy)损失。这些影响以直接的方式（称为 radiation reaction force）和间接的方式（通过影响附近电荷的运动和电流）产生。
<br>

# 连续电荷分布

对于运动的连续 电荷分布，洛伦兹力方程可以写作：

$$
\mathrm{d}\boldsymbol{\mathrm{F}}=\mathrm{d}q(\boldsymbol{\mathrm{E}}+\boldsymbol{\mathrm{v}}\times\boldsymbol{\mathrm{B}})\label{eq3}
$$

其中，$\mathrm{d}\boldsymbol{\mathrm{F}}$ 为连续电荷分布中的带电量为 $\mathrm{d}q$ 的微元所受到的力。如果将公式 $\eqref{eq3}$ 两边同时除以体积微元 $\mathrm{d}V$，则可以改写为：

$$
\boldsymbol{\mathrm{f}}=\rho(\boldsymbol{\mathrm{E}}+\boldsymbol{\mathrm{v}}\times\boldsymbol{\mathrm{B}})\label{eq4}
$$

其中，$\boldsymbol{\mathrm{f}}$ 为力密度(force density, force per unit volume)，$\rho$ 是电荷密度(charge density, charge per unit volume)。之后，将电荷连续体(charge continuum)的运动定义为**电流密度(current density)** $\boldsymbol{\mathrm{J}}$ ：

$$
\boldsymbol{\mathrm{J}}=\rho\boldsymbol{\mathrm{v}}\notag
$$

则式 $\eqref{eq4}$ 可以改写为：

$$
\boldsymbol{\mathrm{f}}=\rho\boldsymbol{\mathrm{E}}+\boldsymbol{\mathrm{J}}\times\boldsymbol{\mathrm{B}}
$$

 于是整个电荷分布的体积积分就是其所受到的力：

$$
\boldsymbol{\mathrm{F}}=\iiint(\rho\boldsymbol{\mathrm{E}}+\boldsymbol{\mathrm{J}}\times\boldsymbol{\mathrm{B}})\mathrm{d}V
$$

<br>

**References**

[1] [Lorentz force - Wikipedia](https://en.wikipedia.org/wiki/Lorentz_force#Lorentz_force_law_as_the_definition_of_E_and_B).

[2] [Test particle - Wikipedia](https://en.wikipedia.org/wiki/Test_particle#test_charge)