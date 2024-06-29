---
layout: single
title: Determination of Solutions for Linear Equations
date: 2022-07-10 21:21:26 +0800
categories: 
 - Mathematics
tags: 
 - Matrix
---

# 线性方程组解的判定

假设 $A$ 是一个 $m\times n$ 矩阵，则对于**线性方程组(systems of linear equations)**

$$
A\boldsymbol{x}=\boldsymbol{b}\label{systemsoflinear equations}
$$

设增广矩阵为$B=[A,\boldsymbol{b}]$，则有解的判定

| 条件                                  | 解的判定   |
| ------------------------------------- | ---------- |
| $\mathrm{rank}(A)=\mathrm{rank}(B)$   | 有解       |
| $\mathrm{rank}(A)=\mathrm{rank}(B)=n$ | 有唯一解   |
| $\mathrm{rank}(A)=\mathrm{rank}(B)<n$ | 有无穷多解 |
| $\mathrm{rank}(A)<\mathrm{rank}(B)$   | 无解       |

<br>

#  齐次线性方程组解的判定

特别地，对于**齐次线性方程组(homogeneous linear equations)**

$$
A\boldsymbol{x}=\boldsymbol{0}\label{homogeneous}
$$

方程组一定有解（至少存在零解）。

进一步地，齐次线性方程组存在**非零解**的充要条件是：

$$
齐次线性方程组\eqref{homogeneous}有非零解\Leftrightarrow r(A)<n\notag
$$

<br>

# 非线性方程组不存在类似解的判定

秩(rank)是基于**线性方程组**定义的，因此对于非线性方程组，并不存在类似通用的判定解的条件。实际上，非线性的概念非常宽泛和复杂，只要输入输出不满足线性性质（齐次性和可加性）的函数都被称为非线性函数，比如多项式函数、带有微分项、偏微分项的函数等等。因此，判定由它们所构成构成的方程组的解的情况当然不存在类似的通用方法。

<br>

**Reference**

[1] [The Matrix Cookbook](https://www.math.uwaterloo.ca/~hwolkowi/matrixcookbook.pdf). 

[2] [Nonlinear system - Wikipedia](https://en.wikipedia.org/wiki/Nonlinear_system).
