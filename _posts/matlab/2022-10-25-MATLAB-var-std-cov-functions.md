---
layout: single
title: MATLAB `var`, `std`, and `cov` Functions
date: 2022-10-25 19:31:35 +0800
categories: 
 - MATLAB
 - Mathematics
tags:
 - MATLAB Data Import and Analysis
 - Probability Theory and Mathematical Statistics
---

# Introduction

在MATLAB中，`std`函数、`var`函数和`cov`函数都是用来计算描述样本散布特征特征的函数，分别用于计算标准差(Standard deviation)、方差(Variance)和协方差矩阵(Covariance matrix)。但是，当函数的输入是一个矩阵或者是多个向量时，它们所输出的结果比较容易混淆，本文就简单梳理一下它们的使用。

<br>

# Variance and Standard Deviation, `var` and `std` Functions

## Input is an array

首先，按照定义，标准差和方差是紧密联系的：

> 定义(**方差，Variance；标准差，Standard deviation**)
>
> 设$X$为随机变量，分布为$F$，则：
> 
> $$
> \mathrm{Var}(X)=E(X-EX)^2\label{variance}
> $$
> 
> 称为$X$(或其分布)的**方差**，其平方根$\sqrt{\mathrm{Var}(X)}$(取正值)称为$X$(或其分布)的标准差。

比如对于单个样本，我们计算方差和标准差：

```matlab
a = [2, 3, 4, 7, 9];
mu = mean(a);

var_builtin = var(a, 1);
var_custom = mean((a-mu) .* (a-mu));

std_builtin = std(a, 1);
std_custom = sqrt(mean((a-mu) .* (a-mu)));
```

```matlab
var_builtin =
    6.8000
var_custom =
    6.8000
std_builtin =
    2.6077
std_custom =
    2.6077
```

需要注意的是，在使用MATLAB的`var`和`std`函数时，都使用了`1`这个`Normalization weight`的值，这表示此时计算的结果是有偏的。**如果不设置`Normalization weight`，则`Normalization** weight`的默认值为`0`，表示计算无偏的结果**：

```matlab
a = [2, 3, 4, 7, 9];
mu = mean(a);

var_builtin = var(a);
var_custom = mean((a-mu).*(a-mu))*numel(a)/(numel(a)-1);

std_builtin = std(a);
std_custom = sqrt(mean((a-mu).*(a-mu)*numel(a))/(numel(a)-1));
```

```matlab
var_builtin =
    8.5000
var_custom =
    8.5000
std_builtin =
    2.9155
std_custom =
    2.9155
```

## Input is a matrix

当输入的向量为矩阵时，其实就是向量的推广，并且在默认情况下均认为矩阵的形状是$样本数量\times分量数量$：

此处以默认情况，即以计算无偏的量为例。
{: .notice--primary}

```matlab
A = [2, 5;
    3, 3;
    4, 2;
    7, 4;
    9, 6];

mus = mean(A);
num = height(A);

var_builtin = var(A);
var_custom = [mean((A(:, 1)-mus(1)).*(A(:, 1)-mus(1)))*num/(num-1), ...
    mean((A(:, 2)-mus(2)).*(A(:, 2)-mus(2)))*num/(num-1)
    ];


std_builtin = std(A);
std_custom = [sqrt(mean((A(:, 1)-mus(1)).*(A(:, 1)-mus(1))*num)/(num-1)), ...
    sqrt(mean((A(:, 2)-mus(2)).*(A(:, 2)-mus(2))*num)/(num-1))
    ];
```

```matlab
var_builtin =
    8.5000    2.5000
var_custom =
    8.5000    2.5000
std_builtin =
    2.9155    1.5811
std_custom =
    2.9155    1.5811
```

因此，即使输入的是矩阵，`std`和`var`函数**始终不计算分量之间的关系**，如果想要计算分量之间的关系，必须使用下面的`cov`函数。

# Covariance Matrix, `cov` Function

协方差矩阵的定义如下：

>定义(协方差矩阵，Covariance Matrix)
>
>随机向量的协方差矩阵通常表示为$\mathrm{K_{XX}}$或者$\Sigma$。假设有一随机(列)向量$X=(X_1,X_2,\cdots,X_n)^T$，其中$X_i$为单个的随机变量，则协方差矩阵$\mathrm{K_{XX}}$中每一个元素为：
>
>$$
>\mathrm{K}_{X_iX_j}=\mathrm{Cov}(X_i,X_j)=E\Big[(X_i-EX_i)(X_j-EX_j)\Big]
>$$
>
>比如，对于二维随机向量$X=(X_1,X_2)^T$，有：
>
>$$
>\mathrm{K_{XX}}=\begin{bmatrix}
>\mathrm{Cov}(X_1,X_1)&\mathrm{Cov}(X_1,X_2)\\
>\mathrm{Cov}(X_2,X_1)&\mathrm{Cov}(X_2,X_2)\\
>\end{bmatrix}\label{cov}
>$$
>
>MATLAB的`cov`函数用于计算输入的协方差矩阵，同样地，在默认情况下，`cov`函数`Normalization weight`为`0`，表示计算无偏的协方差矩阵，同样验证在默认情况下(无偏)进行验证：

```matlab
A = [2, 5;
    3, 3;
    4, 2;
    7, 4;
    9, 6];
mus = mean(A);
num = height(A);

cov11 = mean( (A(:, 1)-mus(1)) .* (A(:, 1)-mus(1)) )*num/(num-1);
cov12 = mean( (A(:, 1)-mus(1)) .* (A(:, 2)-mus(2)) )*num/(num-1);
cov21 = mean( (A(:, 2)-mus(2)) .* (A(:, 1)-mus(1)) )*num/(num-1);
cov22 = mean( (A(:, 2)-mus(2)) .* (A(:, 2)-mus(2)) )*num/(num-1);

cov_custom = [cov11, cov12; cov21, cov22];
cov_bultin = cov(A);
```

```matlab
cov_custom =
    8.5000    2.2500
    2.2500    2.5000
cov_bultin =
    8.5000    2.2500
    2.2500    2.5000
```

从上面也可以看到，对于同一个矩阵`A`，`var`函数计算了协方差矩阵主对角线上的元素：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221025183855051.png?raw=true" alt="image-20221025183855051" style="zoom:50%;" />

那么，假如我只想计算$\mathrm{Cov}(X_1,X_2)$或者$\mathrm{Cov}(X_2,X_1)$呢？MATLAB不提供仅计算这些scalar的函数，仅能从`cov`函数计算得到的协方差矩阵中获得。其实这么做也很合理，因为一个scalar本身就无法完全描述多个分量之间的散布程度。

另外，公式$\eqref{cov}$是按照“变量”的角度进行计算的，每次计算计算协方差矩阵中的一个元素，除此之外，还有另外一种计算协方差矩阵的方式，是从“样本”的角度出发，最后加和算出协方差矩阵：

$$
\mathrm{Cov(X)}=\dfrac1{n-1}\sum_{i=1}^n(X_i-\mu)^T(X_i-\mu)\label{eq3}
$$

其中，$n$为样本的数量，$X_i$表示第$i$个样本，$\mu$为样本均值，$X_i$和$\mu$均为$p\times1$的向量。还是以上面的矩阵`A`举例：

```matlab
A = [2, 5;
    3, 3;
    4, 2;
    7, 4;
    9, 6];
mu = mean(A);
```

此时，公式$\eqref{eq3}$就代表5个$2\times2$的矩阵相加，得到最后的协方差矩阵，我们可以验证一下：

```matlab
COV = ((A(1, :)-mu)'*(A(1, :)-mu)+...
    (A(2, :)-mu)'*(A(2, :)-mu)+...
    (A(3, :)-mu)'*(A(3, :)-mu)+...
    (A(4, :)-mu)'*(A(4, :)-mu)+...
    (A(5, :)-mu)'*(A(5, :)-mu))/(height(A)-1);
```

```matlab
COV =
    8.5000    2.2500
    2.2500    2.5000
```

可以看到，和上面的结果是一致的。

我们可以以二维为例，简单推导以下是如何从式$\eqref{cov}$到$\eqref{eq3}$的：

$$
\begin{split}
\mathrm{Cov}(X)&=\begin{bmatrix}
E\Big((X_1-EX_1)(X_1-EX_1)\Big)&E\Big((X_1-EX_1)(X_2-EX_2)\Big)\\
E\Big((X_2-EX_2)(X_1-EX_1)\Big)&E\Big((X_2-EX_2)(X_2-EX_2)\Big)\\
\end{bmatrix}\\
&=E\begin{bmatrix}
(X_1-EX_1)(X_1-EX_1)&(X_1-EX_1)(X_2-EX_2)\\
(X_2-EX_2)(X_1-EX_1)&(X_2-EX_2)(X_2-EX_2)\\
\end{bmatrix}\\
&=E\Big(\begin{bmatrix}
X_1-EX_1\\
X_2-EX_2\\
\end{bmatrix}
\begin{bmatrix}
X_1-EX_1&
X_2-EX_2\\
\end{bmatrix}\Big)\\
&=E\Big((X-EX)^T(X-EX)\Big)
\end{split}
$$

QED.

<br>

[1] [var - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/var.html).

[2] [std - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/var.html).

[3] [cov - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/cov.html).





