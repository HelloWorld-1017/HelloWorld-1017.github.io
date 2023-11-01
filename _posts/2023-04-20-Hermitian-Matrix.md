---
layout: single
title: Hermitian Matrix
date: 2023-04-20 09:35:32 +0800
categories: 
 - Mathematics
tags:
 - Matrix
 - Prime Obsession
 - Mathematical Proofs and Derivations
toc: false
---

埃尔米特矩阵（Hermitian Matrix），由法国大数学家埃尔米特（Hermite）名字命名，它具有以下的性质：**如果第$n$列第$m$行的数为$a+b\mathrm{i}$，则第$m$列第$n$行的数就是$a-b\mathrm{i}$，即埃尔米特矩阵的每一个元素都与它关于主对角线的镜像映射互为复共轭**。记作：

$$
a_{ij}=\bar{a_{ij}}
$$

或者更间接的矩阵记法：

$$
A=\bar{A^T}=A^H
$$

其中，$A^H$表示矩阵$A$的共轭转置（conjugate transpose）。

例如，埃尔米特矩阵：

$$
H=\begin{bmatrix}
-2&8-3\mathrm{i}&4+7\mathrm{i}&-3+2\mathrm{i}\\
8+3\mathrm{i}&4&1-\mathrm{i}&-1-5\mathrm{i}\\
4-7\mathrm{i}&1+\mathrm{i}&-5&\mathrm{-6i}\\
\mathrm{-3-2i}&\mathrm{-1+5i}&\mathrm{6i}&1\\
\end{bmatrix}\label{eq1}
$$

根据定义，埃尔米特矩阵对角线上的元素都与它自己为复共轭，因此，它们只能是实数，因为只有实数才能与它自己互为复共轭。

有一个关于埃尔米特矩阵的著名定理，即：**埃尔米特矩阵的所有本征值（eigenvalue）都是实数**。

> 证 [3]：
>
> 若矩阵$A$的特征值为$\lambda$，对应的特征向量为$x$，即：
> 
> $$
> Ax=\lambda x
> $$
> 
> 上式两边取共轭转置，有：
> 
> $$
> x^HA^H=x^H\lambda^H=x^H\bar{\lambda}
> $$
> 
> 两边同乘$x$：
> 
> $$
> \begin{split}
> &x^HA^Hx=x^H\bar{\lambda}x\\
> \Rightarrow&x^HAx=\bar\lambda x^Hx\\
> \Rightarrow&x^H\lambda x=\bar\lambda x^Hx\\
> \Rightarrow&\lambda x^Hx=\bar\lambda x^Hx\\
> \end{split}
> $$
> 
> 若想使得上式左右两端成立，则一定有：
> 
> $$
> \lambda=\bar\lambda
> $$
> 
> 即，埃尔米特矩阵$A$的本征值都是实数。

我们可以计算一下式$\eqref{eq1}$的本征值，简单验证一下：

```matlab
H = [-2, 8-3*i, 4+7*i, -3+2*i;
    8+3*i, 4, 1-i, -1-5*i;
    4-7*i, 1+i, -5, -6*i;
    -3-2*i, -1+5*i, 6*i, 1];

v = eig(H)
```

```
  -16.5530
   -3.2578
    4.8573
   12.9535
```

这是非常神奇的，因为即使一个矩阵的所有元素都是实数，它的本征值仍有可能是复数。

从这个定理我们可以推出：

- **埃尔米特矩阵的特征值多项式的所有系数都是实数**（根据定义：任何矩阵的本征值都是这个矩阵的特征多项式的零点）；
- **埃尔米特矩阵的迹是实数**（根据定义：迹等于本征值的总和，等于主对角元素的和）。
- **埃尔米特矩阵的行列式是实数**（根据性质：矩阵的行列式等于其所有本征值的乘积）；

<br>

实际上，由埃尔米特矩阵的定义，我们可以意识到：

- **实对称阵是一种特殊的埃尔米特矩阵**；

根据“埃尔米特矩阵的所有本征值都是实数”这一性质，可以进一步推出另外一个常见的结论：

- **实对称矩阵的本征值都是实数**。

<br>

**References**

[1] Derbyshire J. Prime obsession: Bernhard Riemann and the greatest unsolved problem in mathematics[M]. Joseph Henry Press, 2003.

[2] [Hermitian matrix - Wikipedia](https://en.wikipedia.org/wiki/Hermitian_matrix).

[3] [怎么证明埃尔米特矩阵特征值均为实数，属于不同特征值的特征向量正交？ - 一文的回答 - 知乎](https://www.zhihu.com/question/447501623/answer/1761414959).



