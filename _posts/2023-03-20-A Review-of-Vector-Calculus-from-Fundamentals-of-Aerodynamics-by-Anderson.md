---
layout: single
title: A Review of Vector Calculus from *Fundamentals of Aerodynamics* by Anderson
date: 2023-03-20 20:43:35 +0800
categories: 
 - Mathematics
 - Computational Fluid Dynamics
tags:
 - Mathematical Analysis
---

# Gradient of a Scalar Filed (Isoline, Gradient line, Directional derivative)

对于一个在三维笛卡尔坐标系下的标量场$p$：

$$
p=p(x,y,z)\notag
$$

$p$在该空间中给定点的梯度$\nabla p$定义为：

$$
\nabla p=\dfrac{\partial p}{\partial x}\boldsymbol{\mathrm{i}}+\dfrac{\partial p}{\partial y}\boldsymbol{\mathrm{j}}+\dfrac{\partial p}{\partial z}\boldsymbol{\mathrm{k}}
$$

该向量：

1. 它的大小是在给定点处坐标空间每单位长度下$p$的最大变化率（Its magnitude is the maximum rate of change of $p$ per unit length of the coordinate space at the given point.）；
2. 它的方向是在给定的点上$p$的最大变化率。（Its direction is that of maximum rate of change of $p$ at the given point.）

例如，考虑一个二维笛卡尔空间的压力场（pressure filed），如下图所示：

![image-20230320133002363](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320133002363.png?raw=true)

实线是lines of constant pressure，即同一条实线连接了压力场中具有相同$p$值的点，这样的实线被称作**等值线**（Isolines）。

考虑在上图中的任意一个点$(x,y)$，如果我们从这个点向任意一个方向移动，通常而言，$p$值会发生变化，因为我们移动到了空间中的另一个位置。并且，如果是朝着某个方向移动，那么当在这个方向上移动a unit length，$p$值会发生最大的变化（changes the most）。于是，我们将这个方向定义为$\nabla p$的方向；而在这个方向上移动unit length所导致的$p$值的变化大小就对应$\nabla p$的大小。

在坐标空间中，当从一个点到另一个点时，$\nabla p$的大小和方向都会发生变化。如果我们在这个二维空间中画的一条线，这条线在每个点都与$\nabla p$相切，则这条线就被定义为**梯度线**（A line drawn in this space along which $\nabla p$ is tangent at every point is defined as a gradient line.）。并且，在坐标空间中的任一给定点处，梯度线和等值线都是垂直的（The gradient line and isoline through any given point in the coordinate space are perpendicular.）（关于这一点的解释可见博客[The Gradient is Perpendicular to the Tangent of the Contour Line - What a starry night~](http://whatastarrynight.com/mathematics/matlab/The-gradient-is-perpendicular-to-the-tangent-of-the-contour-line/)）。

<br>

考虑下图中任一给定点$(x,y)$处：

![image-20230320133058879](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320133058879.png?raw=true)

任意选择一个方向$s$，令$\boldsymbol{\mathrm{n}}$为$s$方向上的单位向量，则$s$方向上的单位长度变化对应$p$的变化率为：

$$
\dfrac{\mathrm{d}p}{\mathrm{d}s}=\nabla p\cdot\boldsymbol{\mathrm{n}}\label{eq2}
$$

其中，$\mathrm{d}p/\mathrm{d}s$称为$s$方向上的**方向导数**（directional derivative）。式$\eqref{eq2}$表明$p$在任意方向上的变化率是$\nabla p$在该方向上的分量（The rate of change of $p$ in any direction is simply the component of $\nabla p$ in that direction）。

<br>

# Divergence of a Vector Field

考虑一个三维笛卡尔坐标系下的矢量场：

$$
\boldsymbol{\mathrm{V}}=\boldsymbol{\mathrm{V}}(x,y,z)=V_x\boldsymbol{\mathrm{i}}+V_y\boldsymbol{\mathrm{j}}+V_z\boldsymbol{\mathrm{k}}
$$

其散度（Divergence）$\nabla\cdot \boldsymbol{\mathrm{V}}$定义为：

$$
\nabla\cdot \boldsymbol{\mathrm{V}}=\dfrac{\partial V_x}{\partial x}+\dfrac{\partial V_y}{\partial y}+\dfrac{\partial V_z}{\partial z}
$$

注意，矢量的散度是一个标量。

<br>

# Curl of a Vector Field

同样考虑一个三维笛卡尔坐标系下的矢量场：

$$
\boldsymbol{\mathrm{V}}=\boldsymbol{\mathrm{V}}(x,y,z)=V_x\boldsymbol{\mathrm{i}}+V_y\boldsymbol{\mathrm{j}}+V_z\boldsymbol{\mathrm{k}}
$$

其旋度（Curl）$\nabla\times\boldsymbol{\mathrm{V}}$定义为：

$$
\begin{split}
\nabla\times\boldsymbol{\mathrm{V}}&=\left \vert\begin{matrix}\boldsymbol{\mathrm{i}}&\boldsymbol{\mathrm{j}}&\boldsymbol{\mathrm{k}}\\ \dfrac{\partial}{\partial x}&\dfrac{\partial}{\partial y}&\dfrac{\partial}{\partial z}\\V_x&V_y&V_z\end{matrix}\right \vert\\
&=\boldsymbol{\mathrm{i}}(\dfrac{\partial V_z}{\partial y}-\dfrac{\partial V_y}{\partial z})+\boldsymbol{\mathrm{j}}(\dfrac{\partial V_x}{\partial z}-\dfrac{\partial V_z}{\partial x})+\boldsymbol{\mathrm{k}}(\dfrac{\partial V_y}{\partial x}-\dfrac{\partial V_x}{\partial y})
\end{split}
$$

<br>

# Line Integrals

考虑一个三维笛卡尔坐标系下的向量场：

$$
\boldsymbol{\mathrm{A}}=\boldsymbol{\mathrm{A}}(x,y,z)
$$

如下图所示，空间中的一条曲线$C$连接了$a$和$b$两个点：

![image-20230320142414468](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320142414468.png?raw=true)

令$\mathrm{d}s$是曲线的长度微元（elemental length of the curve），$\boldsymbol{\mathrm{n}}$是相切于其曲线的单位向量，定义：

$$
\boldsymbol{\mathrm{d}s}=\boldsymbol{\mathrm{n}}\mathrm{d}s
$$

则向量场$\boldsymbol{\mathrm{A}}$沿着曲线$C$（从$a$到$b$）的线积分（line integral）定义为：

$$
\int_a^b\boldsymbol{\mathrm{A}}\cdot\boldsymbol{\mathrm{d}s}
$$

如果曲线$C$是闭合的，如下图所示：

![image-20230320142929312](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320142929312.png?raw=true)

则线积分表示为：

$$
\oint_C\boldsymbol{\mathrm{A}}\cdot\boldsymbol{\mathrm{d}s}
$$

其中，积分的方向为曲线$C$的逆时针方向（counterclockwise direction），该方向也被约定为为正方向（The positive direction around a closed curve is, by convention, that direction you would move such that the area enclosed by $C$ is always on your left）.

<br>

# Surface Integrals

考虑一个由闭合曲线$C$环绕的开曲面（open surface）$S$，如下图所示：

![image-20230320143437638](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320143437638.png?raw=true)

点$P$位于曲面上，令$\mathrm{d}S$为曲面的面积微元（elemental area），$\boldsymbol{\mathrm{n}}$是该面积微元的法单位向量（a unit vector normal to the surface），其方向满足右手定则（right-hand rule: Curl the fingers of your right hand in the direction of movement around $C$; your thumb will then point in the general direction of $\boldsymbol{\mathrm{n}}$）.定义矢量面积微元$\boldsymbol{\mathrm{d S}}$为：

$$
\boldsymbol{\mathrm{d S}}=\boldsymbol{\mathrm{n}}\mathrm{d}S
$$

于是，可以得到曲面$S$的曲面积分（Surface integral）的三种定义方式：

$$
\begin{split}\iint_S p\ \boldsymbol{\mathrm{dS}}=&\mathrm{surface\ integral\ of\ a\ scalar\ }p\ \mathrm{over\ the}\\&\mathrm{open\ surface\ }S\ \mathrm{(the\ result\ is\ a\ vector)}\end{split}
$$

$$
\begin{split}\iint_S \boldsymbol{\mathrm{A}}\cdot \boldsymbol{\mathrm{dS}}=&\mathrm{surface\ integral\ of\ a\ vector\ }\boldsymbol{\mathrm{A}}\ \mathrm{over\ the}\\&\mathrm{open\ surface\ }S\ \mathrm{(the\ result\ is\ a\ scalar)}\end{split}
$$

$$
\begin{split}\iint_S \boldsymbol{\mathrm{A}}\times\boldsymbol{\mathrm{dS}}=&\mathrm{surface\ integral\ of\ a\ vector\ }\boldsymbol{\mathrm{A}}\ \mathrm{over\ the}\\&\mathrm{open\ surface\ }S\ \mathrm{(the\ result\ is\ a\ vector)}\end{split}
$$

如果曲面$C$是闭合的（例如sphere或者cube的surface），如下图所示：

![image-20230320145550689](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320145550689.png?raw=true)

则曲面微元的单位向量$\boldsymbol{\mathrm{n}}$指向表面的外侧（away from the enclosed volume），则面积分分别定义为：

$$
\int\kern{-8pt}\int \kern{-23mu} \bigcirc_S\ p\ \boldsymbol{\mathrm{dS}}\quad \int\kern{-8pt}\int \kern{-23mu} \bigcirc_S\ \boldsymbol{\mathrm{A}}\cdot\boldsymbol{\mathrm{d S}}\quad\int\kern{-8pt}\int \kern{-23mu} \bigcirc_S\ \boldsymbol{\mathrm{A}}\times\boldsymbol{\mathrm{d S}}\quad
$$

<br>

# Volume Integrals

考虑空间中的一个体（volume）$V$，则它所对应的体积分（Volume integrals）定义为：

![image-20230320150340114](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320150340114.png?raw=true)

![image-20230320150346993](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320150346993.png?raw=true)

<br>

# Relations Between Line, Surface, and Volume Integrals

## Stokes' theorem

仍然考虑这样一个被闭合曲线$C$所包围的开曲面$S$：

![image-20230320143437638](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320143437638.png?raw=true)

令$\boldsymbol{\mathrm{A}}$是一个向量场，则Stokes' theorem表明，曲线$C$关于$\boldsymbol{\mathrm{A}}$的线积分与开曲面$S$上的面积分有关：

![image-20230320151000888](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320151000888.png?raw=true)

## Divergence theorem

仍然考虑一个由闭合曲面$S$包围的体$V$：

![image-20230320145550689](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320145550689.png?raw=true)

则向量场$\boldsymbol{\mathrm{A}}$的面积分和体积分由Divergence theorem联系起来：

![image-20230320151218628](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320151218628.png?raw=true)

## Gradient theorem

如果$p$表示一个标量场，则类似于Divergence theorem，则有Gradient theorem：

![image-20230320151406089](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230320151406089.png?raw=true)

<br>

**References**

[1] Anderson, John. *EBOOK: Fundamentals of Aerodynamics (SI units)*. McGraw hill, 2011.
