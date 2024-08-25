---
layout: single
title: Matrix Determinant
date: 2022-06-13 19:57:32 +0800
categories: 
 - Mathematics
tags: 
 - Matrix
last_modified_at: 2023-12-02 20:46:28 +0800
---


# Definition of matrix determinant

有的线性变换会将空间向外拉伸，有的则将空间内挤压，那么**如何测量某特定线性变换对一块给定区域的缩放比例呢？**[^1]

由“线性变换使网格线保持平行分布且等距” [^2] 这一事实可以推断出，在二维空间内，我们只需要知道单位正方形面积变化的比例，就可以知道其他任何区域的面积变化比例，这个比例是相同的，因为无论单位方格如何变化，其他大小的方格也会有相同变化。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707175427242.png?raw=true" alt="image-20220707175427242" style="zoom:67%;" />

而对于不是方格的不规则形状，可以用很多方格进行近似，只要使用的方格足够小，近似就能足够好。由于所有小方格都进行了一个比例的缩放，所以整个形状也进行了同样比例的缩放。

线性变换所改变面积的缩放比例被称为这个线性变换的**行列式(determinant)**，记作$\det(A)$ 。

在二维空间中，如果一个线性变换的行列式是3，表明它将一个区域的面积增加为原来的3倍；如果一个线性变换的行列式是0.5，则它将一个区域的面积减小一半。而一个(二维)线性变换的行列式为0，说明它将整个平面压缩到一条直线上，甚至是一个点上。

而当线性变换的行列式为负值时，则说明这样的变换改变(reverse)了空间的**定向(orientation)**，从直观上看，这个线性变换像是将空间翻转了；从基向量的相对位置上来看，线性变换的行列式为负值表明基向量的相对位置发生了变化。比如在初始状态时，$\hat{j}$在$\hat{i}$的左边，而在线性变换之后，$\hat{j}$在$\hat{i}$的右边：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707175444530.png?raw=true" alt="image-20220707175444530" style="zoom: 67%;" />

但是行列式的绝对值依然表示区域面积的缩放比例。

而在三维空间，行列式的值表示变换前后的**体积**缩放比例，行列式为0则意味着整个空间被压缩为零体积的东西，也就是一个平面或一条直线，或者一个点。而行列式为负数，同样也说明线性变换改变了三维空间的定向。有一种方法来描述三维空间的定向，就是“**右手定则**”。

比如，在进行线性变换前，用右手食指指向$\hat{i}$的方向，中指指向$\hat{j}$的方向，大拇指指向$\hat{k}$的方向，如果在变换后仍然可以这么做，那么三维空间的定向就没有发生变化，行列式为正数；否则，如果在变换后只能用左手这么做，则说明定向发生了变化，行列式为负数。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707175459078.png?raw=true" alt="image-20220707175459078" style="zoom:67%;" />

<br>

# Calculation of matrix determinant
以二维空间中的线性变换为例，设矩阵

$$
A=
\begin{bmatrix}
a&b\\
c&d\\
\end{bmatrix}
$$

则根据矩阵和线性变换的关系，可以得到下图

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707175603082.png?raw=true" alt="image-20220707175603082" style="zoom:67%;" />

进而根据平行四边形的性质可以得到

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707175630187.png?raw=true" alt="image-20220707175630187" style="zoom:67%;" />

因此

$$
\det (A)=\dfrac{S}{S^\prime}
=(a+b)(c+d)-ac-bd-2bc
=ad-bc
$$


即

$$
\det (A)=ad-bc
$$

<br>

**Reference**

[^1]: [3Blue1Brown线性代数系列视频](https://www.bilibili.com/video/BV1ys411472E?p=1&vd_source=f209f402a13cd84c99ed077bf0b9afb9).
[^2]: [Matrix and its Relation to Linear Transformation - What a starry night~](https://helloworld-1017.github.io/2022-06-11/17-06-09.html).