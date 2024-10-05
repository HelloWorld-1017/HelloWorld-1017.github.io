---
title: Definition and Properties of Cross Product (Vector Product) and Outer Product (Tensor Product)
categories:
 - Mathematics
tags:
 - Matrix
date: 2023-05-08 09:39:25 +0800
last_modified_at: 2024-10-05 21:30:45 +0800
---

# Cross Product

## Definition

向量$\boldsymbol{a}$和向量$\boldsymbol{b}$之间的叉积（cross product，又称为矢量积，vector product） **只**定义在三维空间，表示为：

$$
\boldsymbol{a}\times\boldsymbol{b}
$$

在物理和应用数学中，楔形符号（wedge notation）$\boldsymbol{a}\wedge\boldsymbol{b}$也经常被用于表示叉积，但是在纯数学中，$\boldsymbol{a}\wedge\boldsymbol{b}$通常用于表示矢量积抽象到$n$维空间的**Exterior product**的概念。

叉积$\boldsymbol{a}\times\boldsymbol{b}$定义了一个垂直于向量$\boldsymbol{a}$和向量$\boldsymbol{b}$的向量$\boldsymbol{c}$，矢量$\boldsymbol{c}$的方向满足右手定则：

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Right_hand_rule_cross_product.svg/1200px-Right_hand_rule_cross_product.svg.png" alt="Right hand rule cross product.svg" style="zoom: 33%;" >

而矢量$\boldsymbol{c}$的幅值等于向量$\boldsymbol{a}$和向量$\boldsymbol{b}$所张成的平行四边形的面积。

上述关系的定义式为：

$$
\boldsymbol{a}\times\boldsymbol{b}=\vert\vert\boldsymbol{a}\vert\vert\ \vert\vert\boldsymbol{b}\vert\vert\sin\theta\cdot\boldsymbol{n},\ \theta\in[0,180]
$$

其中，若向量$\boldsymbol{a}$和向量$\boldsymbol{b}$是平行的，即向量$\boldsymbol{a}$和向量$\boldsymbol{b}$之间的夹角为$0^\circ$或者$180^\circ$，则向量$\boldsymbol{a}$和向量$\boldsymbol{b}$的叉积是零向量$\boldsymbol{0}$。

另外，由于寻找向量$\boldsymbol{c}$的方向遵从右手定则，因此可以得到关系式：

$$
\boldsymbol{b}\times\boldsymbol{a}=-(\boldsymbol{a}\times\boldsymbol{b})
$$

## Cross product computation

### Computation based on matrix notation

在计算$\boldsymbol{a}\times\boldsymbol{b}$时，通常使用矩阵记法（3阶行列式）进行计算：

$$
\begin{split}
\boldsymbol{a}\times\boldsymbol{b}&=
\begin{vmatrix}
\boldsymbol{\mathrm{i}}&\boldsymbol{\mathrm{j}}&\boldsymbol{\mathrm{k}}\\
a_1&a_2&a_3\\
b_1&b_2&b_3\\
\end{vmatrix}\\
&=(a_2b_3-a_3b_2)\boldsymbol{\mathrm{i}}+(a_3b_1-a_1b_3)\boldsymbol{\mathrm{j}}+(a_1b_2-a_2b_1)\boldsymbol{\mathrm{k}}
\end{split}
$$

Cross product这个名字的也是受启发于这种3阶行列式计算方法：

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Sarrus_rule_cross_product_ab.svg/1200px-Sarrus_rule_cross_product_ab.svg.png" alt="Sarrus rule cross product ab.svg" style="zoom:33%;" >

### Computing based on coordinate notation

如果$(\boldsymbol{\mathrm{i}},\boldsymbol{\mathrm{j}},\boldsymbol{\mathrm{k}})$是一组正向正交基，则它们之间的叉积满足：

$$
\begin{split}
&\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{j}}=\boldsymbol{\mathrm{k}}\\
&\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{k}}=\boldsymbol{\mathrm{i}}\\
&\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{i}}=\boldsymbol{\mathrm{j}}\\
\end{split}
$$

$$
\begin{split}
&\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{i}}=-\boldsymbol{\mathrm{k}}\\
&\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{j}}=-\boldsymbol{\mathrm{i}}\\
&\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{k}}=-\boldsymbol{\mathrm{j}}\\
\end{split}
$$

并且有：

$$
\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{i}}=\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{j}}=\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{k}}=\boldsymbol{0}
$$

因此：

$$
\begin{split}
\boldsymbol{a}\times\boldsymbol{b}=&(a_1\boldsymbol{\mathrm{i}}+a_2\boldsymbol{\mathrm{j}}+a_3\boldsymbol{\mathrm{k}})\times(b_1\boldsymbol{\mathrm{i}}+b_2\boldsymbol{\mathrm{j}}+b_3\boldsymbol{\mathrm{k}})\\
=&a_1b_1(\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{i}})+a_1b_2(\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{j}})+a_1b_3(\boldsymbol{\mathrm{i}}\times\boldsymbol{\mathrm{k}})+\\
&a_2b_1(\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{i}})+a_2b_2(\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{j}})+a_2b_3(\boldsymbol{\mathrm{j}}\times\boldsymbol{\mathrm{k}})+\\
&a_3b_1(\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{i}})+a_3b_2(\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{j}})+a_3b_3(\boldsymbol{\mathrm{k}}\times\boldsymbol{\mathrm{k}})\\
=&(a_2b_3-a_3b_2)\boldsymbol{\mathrm{i}}+(a_3b_1-a_1b_3)\boldsymbol{\mathrm{j}}+(a_1b_2-a_2b_1)\boldsymbol{\mathrm{k}}
\end{split}
$$

使用列向量的方式表示计算的结果，有：

$$
\begin{split}
\begin{bmatrix}
c_1\\
c_2\\
c_3
\end{bmatrix}=
\begin{bmatrix}
a_2b_3-a_3b_2\\
a_3b_1-a_1b_3\\
a_1b_2-a_2b_1
\end{bmatrix}
\end{split}\label{eq3}
$$

向量记法计算的结果与矩阵记法计算的结果是一致的，但是之前总是看到矩阵记法的叉积计算公式，第一次看到这种向量记法的计算式，觉得还是挺有意思的~

## Scalar triple product

正如前文提到过的，向量$\boldsymbol{a}$和向量$\boldsymbol{b}$的叉积等于两个向量所张成的平行四边形的正面积：

$$
\vert\vert\boldsymbol{a}\times\boldsymbol{b}\vert\vert=\vert\vert\boldsymbol{a}\vert\vert\ \vert\vert\boldsymbol{b}\vert\vert\ \vert\sin\theta\vert
$$

<img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/Cross_product_parallelogram.svg" alt="Cross product parallelogram.svg" height="375" width="480" style="zoom: 50%;" >

进一步地，以向量$\boldsymbol{a}$，$\boldsymbol{b}$和$\boldsymbol{c}$作为边的平行六面体（parallelepiped）的面积可以通过叉积和点积[^3]的组合（称为scalar triple product，即标量三重积）进行计算：

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Parallelepiped_volume.svg/1200px-Parallelepiped_volume.svg.png" alt="Parallelepiped volume.svg" style="zoom: 33%;" >

$$
\boldsymbol{a}\cdot(\boldsymbol{b}\times\boldsymbol{c})=
\boldsymbol{b}\cdot(\boldsymbol{c}\times\boldsymbol{a})=
\boldsymbol{c}\cdot(\boldsymbol{a}\times\boldsymbol{b})
$$

由于标量三重积的结果可能是负值，因此平行六面体体的体积可以使用其绝对值进行表示：

$$
V=\vert\boldsymbol{a}\cdot(\boldsymbol{b}\times\boldsymbol{c})\vert
$$

## Cross product vs. Dot product

对比叉积和内积的定义式[^3]：

$$
\begin{split}
&\text{Cross product}: \boldsymbol{a}\times\boldsymbol{b}=\vert\vert\boldsymbol{a}\vert\vert\ \vert\vert\boldsymbol{b}\vert\vert\sin\theta\cdot\boldsymbol{n}\\
&\text{Dot product}: \boldsymbol{a}\cdot\boldsymbol{b}=\vert\vert\boldsymbol{a}\vert\vert\ \vert\vert\boldsymbol{b}\vert\vert\cos\theta\\
\end{split}
$$

可以看到，点积能够反映向量$\boldsymbol{a}$和向量$\boldsymbol{b}$之间的夹角的cosine关系，而叉积可以反映夹角的sine关系。因此，点积可以看作是对于垂直性（perpendicularity）的一种度量，而叉积可以看作是对于平行性（parallelism）的一种度量：给定两个单位向量，如果它们是相互垂直的，则叉积的幅值为1；如果相互是相互平行的，则叉积的幅值为0；而点积的结果刚好相反，即如果两个向量是垂直的，则点积为0；如果两个向量是平行的，则点积为1。

## Conversion to matrix multiplication

叉积可以表示为斜对称矩阵（Skew-symmetric matrix）[^5][^6]和一个向量的矩阵乘法（根据式$\eqref{eq3}$）：

$$
\begin{split}
&\boldsymbol{a}\times\boldsymbol{b}=[\boldsymbol{a}]_{\times}\boldsymbol{b}=
\begin{bmatrix}
0&-a_3&a_2\\
a_3&0&-a_1\\
-a_2&a_1&0\\
\end{bmatrix}
\begin{bmatrix}
b_1\\
b_2\\
b_3\\
\end{bmatrix}\\
&\boldsymbol{a}\times\boldsymbol{b}=[\boldsymbol{b}]_{\times}^T\boldsymbol{a}=
\begin{bmatrix}
0&b_3&-b_2\\
-b_3&0&b_1\\
b_2&-b_1&0\\
\end{bmatrix}
\begin{bmatrix}
a_1\\
a_2\\
a_3\\
\end{bmatrix}\\
\end{split}
$$

其中，$[\boldsymbol{a}]_{\times}$定义为：

$$
[\boldsymbol{a}]_{\times}:=\begin{bmatrix}
0&-a_3&a_2\\
a_3&0&-a_1\\
-a_2&a_1&0\\
\end{bmatrix}
$$

它是一个斜对称矩阵，并且可以通过计算向量$\boldsymbol{a}$与单位向量的叉积得到：

$$
[\boldsymbol{a}]_{\times,i}=\boldsymbol{a}\times\hat{\boldsymbol{e}}_i,\ i\in{1,2,3}
$$

或者：

$$
[\boldsymbol{a}]_{\times}=\sum_{i=1}^3(\boldsymbol{a}\times\hat{\boldsymbol{e}}_i)\otimes\hat{\boldsymbol{e}}_i
$$

其中，$\otimes$是**外积**的符号（外积的定义见后文）。

另外，如果$\boldsymbol{a}$能够由向量$\boldsymbol{b}$和向量$\boldsymbol{c}$的叉积表示：

$$
\boldsymbol{a}=\boldsymbol{c}\times\boldsymbol{d}
$$

则有：

$$
[\boldsymbol{a}]_{\times}=\boldsymbol{b}\boldsymbol{c}^T-\boldsymbol{c}\boldsymbol{d}^T
$$

## Cross product in MATLAB

在MATLAB中，可以使用`cross`函数[^4]计算两个向量的叉积：

```
>> cross([1,0,0],[0,1,0])
ans =
     0     0     1
```

<br>

# Outer Product

在线性代数中，两个坐标向量的外积（outer product）是一个矩阵。例如，如果两个向量的维度分别是$n$和$m$，则它们的外积是一个$n\times m$的矩阵。更一般地，给定两个张量（tensor）的外积也是一个张量。张量的外积也被称为张量的张量积（tensor product），并且能够用于定义张量代数（tensor algebra）。

## Definition

给定两个向量，形状分别为$m\times1$和$n\times1$：

$$
\boldsymbol{u}=
\begin{bmatrix}
u_1\\
u_2\\
\vdots\\
u_m
\end{bmatrix},\ 
\boldsymbol{v}=
\begin{bmatrix}
v_1\\
v_2\\
\vdots\\
v_n
\end{bmatrix}
$$

它们的张量积可以表示为$\boldsymbol{u}\otimes\boldsymbol{v}$：

$$
\boldsymbol{u}\otimes\boldsymbol{v}=
\begin{bmatrix}
u_1v_1&u_1v_2&\cdots&u_1v_n\\
u_2v_1&u_2v_2&\cdots&u_2v_n\\
\vdots&\vdots&\ddots&\vdots\\
u_mv_1&u_mv_2&\cdots&u_mv_n\\
\end{bmatrix}\label{eq4}
$$

**Note added on Nov. 3, 2023**: Definition $\eqref{eq4}$ as well that in the following text, that is the way of denoting the outer product of $\boldsymbol{u}$ and $\boldsymbol{v}$ as $\boldsymbol{u}\otimes\boldsymbol{v}$ is from Wikipedia[^1]. However, symbol $\otimes$ is more commonly used to denote Kronecker product. So, according to the definition of **Kronecker product**[^7][^8], it is more reasonable to denote the outer product of $\boldsymbol{u}$ and $\boldsymbol{v}$ as $\boldsymbol{u}\otimes\boldsymbol{v}^T$[^9].
{: .notice--warning}

或者使用索引记法：
$$
(\boldsymbol{u}\otimes\boldsymbol{v})_{ij}=u_iv_j
$$

## Properties

（1）给定一个$n\times1$的向量$\boldsymbol{w}$，则有：

$$
(\boldsymbol{u}\otimes\boldsymbol{v})\boldsymbol{w}=(\boldsymbol{v}\cdot\boldsymbol{w})\boldsymbol{u}
$$

（2）给定一个$1\times m$的向量$\boldsymbol{x}$，则有：

$$
\boldsymbol{x}(\boldsymbol{u}\otimes\boldsymbol{v})=(\boldsymbol{x}\cdot\boldsymbol{u})\boldsymbol{v}^T
$$

（3）如果向量$\boldsymbol{u}$和$\boldsymbol{v}$是同维度的向量，并且它们的维度都大于1，则有：

$$
\mathrm{det}(\boldsymbol{u}\otimes\boldsymbol{v})=0
$$

（4）**根据外积的定义式$\eqref{eq4}$，外积$\boldsymbol{u}\otimes\boldsymbol{v}$等价于矩阵乘法**：

$$
\boldsymbol{u}\otimes\boldsymbol{v}=\boldsymbol{u}\boldsymbol{v}^T
$$

对于复向量，则有：

$$
\boldsymbol{u}\otimes\boldsymbol{v}=\boldsymbol{u}\boldsymbol{v}^\dagger=\boldsymbol{u}(\boldsymbol{v}^T)^*
$$

## The dot product is the trace of the outer product

两个相同维度的向量$\boldsymbol{u}$和$\boldsymbol{v}$的点积定义为[^3]：

$$
\langle\boldsymbol{u},\boldsymbol{v}\rangle=\boldsymbol{u}^T\boldsymbol{v}
$$

也被称作是欧几里得空间标准的内积（inner product）。

向量内积与向量外积的关系是：**向量点积是向量外积的得到的矩阵的迹**：

$$
\langle\boldsymbol{u},\boldsymbol{v}\rangle=\mathrm{Tr}(\boldsymbol{u}\otimes\boldsymbol{v})
$$

并且，向量$\boldsymbol{w}$与矩阵$\boldsymbol{u}\otimes\boldsymbol{v}$的乘积可以写作内积的形式：

$$
(\boldsymbol{u}\otimes\boldsymbol{v})\boldsymbol{w}=\boldsymbol{u}\langle\boldsymbol{v},\boldsymbol{w}\rangle
$$

<br>

**References**

- [Cross product](https://en.wikipedia.org/wiki/Cross_product).

[^1]: [Outer product](https://en.wikipedia.org/wiki/Outer_product).
[^3]: [Geometric and Algebraic Definition of Dot Product (Inner Product)](https://helloworld-1017.github.io/2022-06-09/21-07-09.html).
[^4]: [`cross`: Cross product.](https://ww2.mathworks.cn/help/matlab/ref/cross.html)
[^5]: [Skew-symmetric matrix](https://en.wikipedia.org/wiki/Skew-symmetric_matrix).
[^6]: [Skew-Symmetric Matrix and its Properties](https://helloworld-1017.github.io/2023-05-09/14-54-27.html).
[^7]: [Kronecker Product](https://mathworld.wolfram.com/KroneckerProduct.html).
[^8]: [Kronecker product](https://en.wikipedia.org/wiki/Kronecker_product).
[^9]: [Vector Direct Product](https://mathworld.wolfram.com/VectorDirectProduct.html).
