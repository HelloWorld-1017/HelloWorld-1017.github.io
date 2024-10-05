---
title: Geometric significance of Solving Linear Equations
categories: 
 - Mathematics
tags: 
  - Matrix
date: 2022-06-14 19:21:23 +0800
last_modified_at: 2024-10-05 21:17:30 +0800
---


# 线性方程组（一致方程组）求解的几何意义
线性方程组（Linear system of equations）和矩阵向量乘法（matrix-vector multiplication）非常相似。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707235705577.png?raw=true" alt="image-20220707235705577" style="zoom:50%;" />

其中，$A$被称为系数矩阵（coefficients），$\boldsymbol{x}$被称为变量（variables），$\boldsymbol{v}$称为常数向量（constants）。从几何上看，求解这个方程组意味着我们**去寻找一个向量$\boldsymbol{x}$，使得它在经过线性变换$A$后与向量$\boldsymbol{v}$重合**。设有二维线性方程组

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707235626269.png?raw=true" alt="image-20220707235626269" style="zoom:50%;" />

这个方程解的形式依赖于矩阵A所代表的变换是**将空间挤压到一条直线或点等低维空间**，还是**像初始状态一样的完整的二维空间**。根据行列式所代表的含义[^3]，上述两种情况分别对应：$A$ 的行列式为零和 $A$ 的行列式不为零。

## 矩阵的行列式不等于零（矩阵的逆存在）
当 $\det (A)\neq0$ 时，此时空间并未被挤压为零面积面积的区域，在这种情况下，有且仅有一个向量在变换后与v重合，并且可以通过逆向进行变换找到这个向量。

当进行逆向变换时，它实际上对应了另一个线性变换，通常称为**A的逆（the inverse of A）**，记作$A^{-1}$。

$A^{-1}$是满足以下性质的唯一变换：对某一向量首先应用$A$代表的线性变换，再应用$A^{-1}$代表的线性变换，就会回到原始状态。

两个变换相继作用的效果在代数上体现为矩阵乘法，因此A逆的核心性质在于，$A^{-1}A$表示一个“什么都不做”的矩阵，这个变换被称为恒等变换（identity transformation）。$A^{-1}A$所对应的线性变换“什么都不做”，代表矩阵$A^{-1}A$的$\hat{i}$和$\hat{j}$不变，即$A^{-1}A$ 的两列就是(1, 0)和(0,1)：

$$
A^{-1}A=
\begin{bmatrix}
1&0\\
0&1\\
\end{bmatrix}
$$

线性方程组的两端同乘$A^{-1}$，可以得到

$$
\begin{align}
A^{-1}A\boldsymbol{x}&=A^{-1}\boldsymbol{v}\\
\boldsymbol{x}&=A^{-1}\boldsymbol{v}\\ 
\end{align}
$$


求解上式就可以得到向量$\boldsymbol{v}$在经过矩阵$A$线性变换前的位置$\boldsymbol{x}$。

## 矩阵的行列式等于零（矩阵的逆不存在）
当$\det (A) = 0$时，表明与这个方程组相关的线性变换将空间压缩到更低的维度上，此时就无法找到线性变换$A$所对应的逆变换$A^{-1}$使得$A^{-1}A$为恒等变换，因为我们不可能将一个低维的信息**精确地**解压缩为高维信息。

仍以二维空间为例。我们之前提到过，高维空间投影到数轴上操作实际上是一种线性变换[^4]。假设线性变换$A$使得某一向量投影在一维空间的数轴$x_3$，变换后的向量记作$\boldsymbol{v}$。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707235738340.png?raw=true" alt="image-20220707235738340" style="zoom:50%;" />

由上图所示，我们想要找到精确的变换前的向量$\boldsymbol{v}$是不可能的，因为在直线$L$上有无数个向量经过不同的线性变换后得到向量$\boldsymbol{x}$。甚至没有一个函数（function）能够做到将$\boldsymbol{x}$精确还原（因为函数只能将输入变换为**一个**输出），因此就不存在$A^{-1}$使得$A^{-1}A$为恒等变换，也就意味着矩阵$A$不存在逆矩阵。

事实上，矩阵可逆和矩阵的行列式不为零是充要条件

$$
A^{-1} \text{ exist } \Leftrightarrow \det(A)\neq 0
$$

注：投影在数轴上表示线性变换所对应矩阵$A$的列向量共线。设某个线性变换将向量变换到$\boldsymbol{v}$的位置，如果线性变换后基的位置是$\boldsymbol{i}_1$和$\boldsymbol{j}_1$，那么向量$\boldsymbol{v}$实际上是空间中的一个二维向量，线性方程组的解存在；如果线性变换后基的位置是$\boldsymbol{i}_2$和$\boldsymbol{j}_2$，那么向量$\boldsymbol{v}$代表数轴$x_3$上的一个数，线性方程组的解不存在（准确地讲，是不存在唯一解）。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707235850944.png?raw=true" alt="image-20220707235850944" style="zoom:50%;" />

## 秩与列空间

一些零行列式的情况比其他的更加严格，比如一个$3\times 3$的矩阵，当它将空间压缩为一条**直线**时，与压缩为**平面**相比，解存在的难度更高了，即使它们的行列式均为零。

当变换的结果为一维时，也就是说结果是一维的，我们称这个变换的**秩（rank）**为1，如果变换后的向量落在某个二维平面上，我们称这个变换的秩为2，所说的“秩”代表**变换后空间的维数**。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220708000000727.png?raw=true" alt="image-20220708000000727" style="zoom:50%;" />

比如，对于$2\times 2$的矩阵，它的秩最大为2，意味着基向量仍能张成整个二维空间，并且行列式不为零；对于$3\times 3$的矩阵，秩为2意味着空间被压缩了，但和秩为1的情况相比，压缩并不是那么严重；如果三维变换的行列式不为零，变换结果仍旧充满整个三维空间，那么它的秩为3。

不管是一条直线、一个平面还是三维空间，所有可能的变换结果的集合，被称为矩阵的“列空间”。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220708000019419.png?raw=true" alt="image-20220708000019419" style="zoom:50%;" />

矩阵的列告诉我们基向量变换后的位置，这些变换后的基向量所张成的空间就是所有可能的变换结果。换句话说，**列空间就是矩阵的列所张成的空间**。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220708000034821.png?raw=true" alt="image-20220708000034821" style="zoom:50%;" />

所以更精确的**秩的定义是列空间的维数**。当秩达到最大值时，意味着秩与列数相等，我们称之为“满秩（full rank）”。

## 零空间（核）
零向量一定会被包含在列空间中，因为线性变换必须保持原点位置不变。对于一个满秩变换来说，唯一能在变换后落在原点的就是零向量本身；但是对一个非满秩的矩阵来说，它将空间压缩到一个更低的维度上，也就是说会有一系列向量在变换后成为零向量。比如，如果一个二维线性变换将空间压缩到一维数轴$x_3$上，那么沿**某个**不同方向上的所有向量就被压缩到原点。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220708000105771.png?raw=true" alt="image-20220708000105771" style="zoom:50%;" />

如果一个三维线性变换将空间压缩到一个平面上，同样会有一整条直线上的向量在变换后落在原点；如果一个三维线性变换将空间压缩到一条直线上，那么就有一整个平面上的向量在变换后落在原点。变换后落在原点的向量的集合，被称为矩阵的“零空间（null space）”或“核（kernel）”。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220708000132963.png?raw=true" alt="image-20220708000132963" style="zoom:50%;" />

对线性方程组来说，当向量$\boldsymbol{v}$恰好为零向量时，零空间给出的就是这个向量方程所有可能的解。零空间的概念有助于我们理解所有可能的解的集合是什么样的。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220708000151762.png?raw=true" alt="image-20220708000151762" style="zoom:50%;" />

假设已知线性变换后的核（kernel），一个空间中的向量在经过变换后落在了$\boldsymbol{x}_1$处，则该“向量”线性变换前所有可能的向量都落在直线$L_1$上；同理一个空间中的向量在经过变换后落在了$\boldsymbol{x}_2$处，则该“向量”线性变换前所有可能的向量都落在直线$L_2$上。直线$L_1$和直线$L_2$均与和核平行。

<br>


# 超定方程组(不一致方程组)求解的几何意义、最小二乘法
上面介绍的线性方程组都是方程个数等于未知数个数的方程组，对应的系数矩阵是方阵，即**一致方程组**。对于线性方程组$A\boldsymbol{x}=\boldsymbol{b}$，如果方程个数$m$和未知变量个数$n$满足$m>n$，则称该线性方程组为**超定方程组**，也称为**不一致方程组**。由于在实际工程中收集数据时常常存在误差，系数矩阵$A$和向量$\boldsymbol{b}$的值不够精确，导致超定方程组非常常见。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220708000224838.png?raw=true" alt="image-20220708000224838" style="zoom:50%;" />

从几何上看，超定方程组试图寻找一个二维向量，使其经过给定线性变换后等于三维空间中给定的一个三维向量。我们知道，线性变换所对应矩阵的的列向量是经过变换后基向量的坐标，矩阵乘法就表示基向量的线性组合[^5]。因此经过矩阵$A$所对应的线性变换后的空间中只具有两个基向量$\hat{i}=[a,b,c]$和$\hat{j}=[d,e,f]$，两个基向量只能张成一个二维空间。因此我们通常无法找到一个精确的二维向量，在经过给定的线性变换后和给定的三维向量重合，也就是说，超定方程组没有精确解。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220708000242704.png?raw=true" alt="image-20220708000242704" style="zoom:50%;" />

但是可以**最小二乘法**得到一个近似解。从上图可以看到，我们可以在二维空间（紫色平面）中找到一个向量$\boldsymbol{x}$，使其经过线性变换$A$后最接近空间中给定的向量 $\boldsymbol{b}$。即向量 $A\boldsymbol{x}$ 具有以下特点：余项 $\boldsymbol{b}-A\boldsymbol{x}$ 和平面$\{A\boldsymbol{\hat{x}} \vert \boldsymbol{\hat{x}}\in \mathbb{R}^{n}\}$垂直，即：

$$
(\boldsymbol{b}-A\boldsymbol{x})\bot \{A\boldsymbol{x}\vert\boldsymbol{x}\in \mathbb{R}^{n}\}
$$

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220708000318504.png?raw=true" alt="image-20220708000318504" style="zoom:50%;" />

写成矩阵乘法有：

$$
\begin{aligned}
&(A\boldsymbol{x})^T(\boldsymbol{b}-A\boldsymbol{x})=0 \\
\Rightarrow & \boldsymbol{x}^TA^T (\boldsymbol{b}-A\boldsymbol{x})=0
\end{aligned}\tag{2}
$$

式(2)表明$n$维向量 $A^T (\boldsymbol{b}-A\boldsymbol{x})$ 和 $\mathbb{R}^{n}$ 中的其他的$n$维向量都垂直，也包含它自身（因为 $\boldsymbol{x}$ 是未知量，可任意取值），则只有一种可能的情况：

$$
A^T (\boldsymbol{b}-A\boldsymbol{x})=0
$$
即：

$$
A^TA\boldsymbol{x}=A^T\boldsymbol{b} \label{eq3}
$$

式(3)所定义的方程组有解，它的解 $\boldsymbol{x}$ 即是原方程组 $A\boldsymbol{x}=\boldsymbol{b}$ 的**最小二乘解**。式$\eqref{eq3}$也被被称为原超定方程的**法线方程**。因此只要利用其他求解一致方程组的方法来求解该法线方程就得到解$\boldsymbol{x}$即可。

定义最小二乘解的余项为 $\boldsymbol{r}=\boldsymbol{b}-A\boldsymbol{x}$ ，该余项的大小，可以通过它的二范数来定义：

$$
||\boldsymbol{r}||_2=\sqrt{r_1^2+\cdots +r_m^2} \tag{4}
$$

式(4)就衡量了近似解 $\boldsymbol{x}$ 和精确解 $\boldsymbol{x}$ 之间的误差大小。

<br>

# 总结
1. 每个方程组都有一个线性变换与之联系，当逆变换存在时，就能用这个逆变换求解方程组；如果该线性变换的逆变换不存在，则该线性方程组有无数个解；
2. 列空间的概念让我们清楚什么时候存在唯一解，什么时候不存在；
3. 零空间的概念有助于理解所有可能的解的集合是什么样的；
4. 超定方程组（不一致方程组）没有精确解，但是可以使用最小二乘法求最接近原超定方程的最小二乘解。

<br>

**References**

[^3]: [Matrix Determinant - What a starry night~](https://helloworld-1017.github.io/2022-06-13/19-57-32.html).

[^4]: [Matrix and its Relation to Linear Transformation - What a starry night~](https://helloworld-1017.github.io/2022-06-11/17-06-09.html).

[^5]: [Matrix and its Relation to Linear Transformation - What a starry night~](https://helloworld-1017.github.io/2022-06-11/17-06-09.html).

[1] [3Blue1Brown线性代数系列视频](https://www.bilibili.com/video/BV1ys411472E?p=8&vd_source=8aeddead7f39b0189fff9b14fa090a75).

[2] Timothy Sauer. 数值分析(原书第2版). 裴玉茹, 马赓宇, 译. 北京：机械工业出版社，2014.10.

