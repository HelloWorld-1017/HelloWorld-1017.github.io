---
layout: single
title: Matrix and its Relation to Linear Transformation
date: 2022-06-11 17:06:09 +0800
categories: 
 - Mathematics
tags: 
 - Matrix
toc: false
last_modified_at: 2023-12-02 20:57:13 +0800
---

变换(transformation)实际上可以看作是一种函数(function)，它接收一个向量，对其进行运算后输出一个向量。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/schematic1.png?raw=true" alt="schematic1" style="zoom: 33%;" />



但是，“变换(transformation)”这个词隐含着“运动(movement)”的含义。可以想象在空间中的一个向量经过线性变换后移动到了另一个位置。

而线性变换(linear transformation)则是一种特殊类型的变换，这种变换具有以下两条性质：

1. Lines remain lines：直线在变换后仍然是直线，不能有所弯曲；
2. Origin remains fixed：原点必须保持固定（例如仿射变换(Affine Transformation)不满足这个要求）；

即，线性变换就是“保持网格线平行且等距分布(Grid lines remain parallel and evenly spaced)”的变换，并且在变换过程中原点的位置保持不动。

实际上，线性变换具有的“网格线在变换前后保持平行且等距分布”的特性有一个重要的推论：

**向量$\vec{v}$可以由空间中的一组基的线性组合来表示；线性变换改变了基向量的位置，但是并不改变基的线性组合。**

以二维向量为例，设在标准正交基$\hat{i}=(1,0)$和$\hat{j}=(0,1)$下，向量$\vec{v}$的坐标为$(2,3)$，即

$$
\vec{v}=2\times(1,0)+3\times(0,1)=(2,3)
$$

假设有一个线性变换使得基底$\hat{i}$和$\hat{j}$变换为$$\hat{i}_{transformed}=(1,0)$$ 和 $$\hat{j}_{transformed}=(-1,1)$$，则变换后的向量

$$
\vec{v}_{transformed}=2\times(1,0)+3\times(-1,1)=(-1,3)
$$

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220708093439970.png?raw=true" alt="image-20220708093439970" style="zoom:50%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220708093503305.png?raw=true" alt="image-20220708093503305" style="zoom:50%;" />

也就是说，我们只需要根据变换后的 $$\hat{i}_{transformed}$$ 和 $$\hat{j}_{transformed}$$，就能推断出变换后 $$\vec{v}_{transformed}$$ 的位置。

因此，一个二维线性变换仅由四个数字完全确定，即变换后的$\hat{i}$的两个坐标和变换后的$\hat{j}$的两个坐标。我们将这些基向量的坐标以列的形式放入到一个2 $\times$ 2的格子中，就得到了一个**2 $\times$ 2矩阵**。

$$
A =\begin{bmatrix}
1&-1\\
0&1\\
\end{bmatrix}
$$

而矩阵A与原向量$\vec{v}$相乘，按照矩阵乘法的定义

$$
A \vec{v}=\begin{bmatrix}
1&-1\\
0&1\\
\end{bmatrix}
\begin{bmatrix}
2\\
3
\end{bmatrix}=
2\times\begin{bmatrix}
1\\
0
\end{bmatrix}+
3\times\begin{bmatrix}
-1\\
1
\end{bmatrix}
=\begin{bmatrix}
-1\\
3
\end{bmatrix}\tag{1}
$$

得到的结果与对向量$\vec{v}$线性变换的结果是一致的。而式(1)中的计算过程也体现了线性变换“先缩放基向量后相加”的思想。

所以，矩阵这个记号，实际上包含了描述一个线性变换的所有的信息，它的每一列就是线性变换后基向量的坐标，而矩阵向量乘法就表示这些基向量的线性组合。

同样地，从一个矩阵出发，我们也可以想象出它所对应的线性变换是什么样子的。

<br>

**Conclusion**

（1）线性变换就是操纵空间的一种手段，它保持网格线平行且等距分布，且保持坐标原点不动；

（2）矩阵是描述线性变换的一种方式，矩阵的列向量就是变换后的基向量的坐标，矩阵向量乘法就表示这些基向量的线性组合；

（3）矩阵向量乘法就是计算特定线性变换作用于给定向量的一种途径；

（4）每看到一个矩阵，都可以把它解读为对空间的一种特定的线性变换。

<br>

**References**

[1] [Linear transformations and matrices - Chapter 3, Essence of linear algebra - YouTube](https://www.youtube.com/watch?v=kYB8IZa5AuE&list=PLZHQObOWTQDPD3MizzM2xVFitgF8hE_ab&index=5).