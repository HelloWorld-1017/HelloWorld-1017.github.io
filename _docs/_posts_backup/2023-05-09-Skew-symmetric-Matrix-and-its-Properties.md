---
layout: single
title: Skew-Symmetric Matrix and its Properties
date: 2023-05-09 14:54:27 +0800
categories: 
 - Mathematics
 - MATLAB
tags: 
 - Matrix
 - MATLAB Mathematics
---

# Skew-symmetric Matrix

**斜对称矩阵（skew-symmetric matrix）**，或者称为反对称矩阵（antisymmetric or antimetric matrix）定义为 [1]：

$$
A\text{ is skew-wymmetric}\iff A^T=-A
$$

例如，矩阵：

$$
A=
\begin{bmatrix}
0&2&-45\\
-2&0&-4\\
45&4&0\\
\end{bmatrix}
$$

就是一个斜对称矩阵。

在MATLAB中，可以通过`issymmetric`函数判断矩阵是否为斜对称矩阵：

```matlab
A = [0,2,-45;
    -2,0,-4;
    45,4,0];
issymmetric(A,'skew')
```

```
ans =
  logical
   1
```

<br>

# The Properties of Skew-symmetric Matrix

斜对称矩阵具有以下的性质：

（1）两个斜对称矩阵的和仍然是斜对称矩阵；

（2）标量乘以斜对称矩阵仍然是斜对称矩阵；

（3）斜对称矩阵的对角线元素均为0（因为要满足定义），因此斜对称矩阵的迹等于0；

（4）如果矩阵$A$是实斜对称矩阵，并且$\lambda$是一个实特征值，则$\lambda=0$，即：**一个斜对称矩阵的非零特征值一定是非实数（nonzero eigenvalues of a skew-symmetric matrix are non-real）**；

（5）如果矩阵$A$是实斜对称矩阵，则矩阵$I+A$一定可逆；

（6）如果矩阵$A$是斜对称矩阵，则$A^2$是一个对称负半定矩阵（symmetric negative semi-definite matrix）；

<br>

**References**

[1] [Skew-symmetric matrix - Wikipedia](https://en.wikipedia.org/wiki/Skew-symmetric_matrix).

[2] [issymmetric - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/issymmetric.html).