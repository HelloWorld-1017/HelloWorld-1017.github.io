---
layout: single
title: Three Different Models of the Fluid from *Fundamentals of Aerodynamics* by Anderson
date: 2023-03-20 20:53:27 +0800
categories: 
 - Mathematics
 - Computational Fluid Dynamics
tags:
 - Mathematical Analysis
---

# Introduction

在推导流体动力学的基本方程之前，首先需要了解构建这些方程的哲学。主要包含三个方面：

（1）利用人类对自然的微观观察中获得的根深蒂固的三个基本物理原理，即：

1. 质量守恒（Mass is conserved, i.e., mass can be neither created nor destroyed）；
2. 牛顿第二定律（Newton’s second law: force = mass $\times$ acceleration）；
3. 能量守恒（Energy is conserved; it can only change from one from to another）；

（2）确定一个合适的流体模型（model of fluid）。流体是一种黏性物质（fluid is a squishy substance），因此通常描述流体比描述well-defined solid body更加困难。因此我们必须采用一个合理的模型，并且将（1）中的基本原理应用在该模型中；

（3）将（1）中的基本物理规则应用在（2）中所构建的模型以获得能够合适地描述流体物理的数学方程。反过来，使用这些基本方程来分析人们所感兴趣的流体力学问题。

<br>

针对（2）流体模型有这样几个问题：

- 什么是合适的流体模型？
- 如何可视化这种黏性物质，以应用三个基本物理原理？

这些问题的回答并不唯一，在流体动力学当中主要有三种不同的模型得到了成功的应用，即（1）有限控制体模型（finite control volume）；（2）无限小流体微团（infinitesimal fluid element）和（3）分子模型（molecular），下面就简单介绍一下这三个模型。

<br>

# Finite Control Volume Approach

考虑如下图所示的由流线（streamline）所表示的一般流场（general flow field）：

![image-20230320195903811](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230320195903811.png?raw=true)

想象这样一个闭合体（closed volume）取自流体的一个有限区域。这个闭合体就定义为控制体（Control Volume）$V$，控制面（Control Surface）$S$ 就定义为限制控制体的闭合曲面（closed surface）。

控制体可以在空间固定（fixed in space），流体会流动经过这个控制体（如上图的左图所示），这种控制体也称为**空间位置固定的有限控制体**。另外，控制体也可以随着流体移动（moving with the fluid）（如上图的右图所示），这种控制体内始终包含着相同的流体粒子（the same fluid particles are always inside it），这种控制体也称为**随流线运动的有限控制体**。

无论是哪一种情况，控制体都可以视作是流体中一个相当大的有限的区域（reasonably large, finite region of the flow）。基本物理原理都可以应用于控制体内部的流体（fluid inside the control volume），以及穿过控制面的流体（the fluid crossing the control surface）（如果控制体在空间固定）。因此，在分析流体时，并不会将目光停留在整个流场中，而是通过有限控制体模型，聚焦于一个有限的区域内。

<br>

# Infinitesimal Fluid Element Approach

考虑如下图所示的由流线所表示的一般流场：

![image-20230320201630532](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230320201630532.png?raw=true)

想象一个流体中的无穷小流体微团（infinitesimal fluid element in the flow），具有体积微元（differential volume）$\mathrm{d}V$。这个流体微团是无穷小的，如同微积分学中所定义的那样，但是另一方面，它有足够大，能够包含大量分子以至于它可以被视作连续介质（continuous medium）。这个流体微团可以在空间固定（如上图左图所示），也可以随流线以速度$\boldsymbol{\mathrm{V}}$运动，与流速保持一致（如上图右图所示）。

<br>

# Molecular Approach

实际上，流体的运动是流体中原子和分子的平均运动的结果（a ramification of the mean motion of its atoms and molecules）。因此，流体的第三种模型是一种微观方法（microscopic approach），是将自然界的基本原理直接应用于原子和分子，使用合适的统计平均方法（suitable statistical averaging）来定义流体的性质。这种方法是动力学理论的范畴（purview of kinetic theory），并且是一种非常优雅的方法，从长远来看有很多优点（which is a very elegant method with many advantages in the long run）.

<br>

# Conclusion

总之，尽管不同的书籍和资料会使用许多不同的方式来推导描述流体的一般方程，但是流体模型通常一般可以划分为上述三种模型的其中一种。

<br>

**References**

[1] Anderson, John. *EBOOK: Fundamentals of Aerodynamics (SI units)*. McGraw hill, 2011.