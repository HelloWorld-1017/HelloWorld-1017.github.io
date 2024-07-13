---
layout: single
title: Geometric and Algebraic Definition of Dot Product (Inner Product)
date: 2022-06-09 21:07:09 +0800
categories: 
 - Mathematics
tags: 
 - Matrix
---


# 向量点积的代数定义和几何定义

向量点积(dot product，也被称为外积，i.e.)可以从**代数角度**和**几何角度**两个角度来定义。这两种定义在欧几里得空间的笛卡尔坐标系中是等效的。

## 向量点积的代数定义
长度相等的两个向量$\boldsymbol{a}=[a_1,a_2,\cdots, a_n]$和$\boldsymbol{b}=[b_1,b_2,\cdots, b_n]$的内积可以定义为：

$$
\boldsymbol{a} \cdot \boldsymbol{b}=\sum^{n}_{i=1}a_ib_i=a_1b_1+a_2b_2+\cdots+a_nb_n
$$


并且，向量内积与顺序无关：

$$
\boldsymbol{a}\cdot \boldsymbol{b}=\boldsymbol{b}\cdot \boldsymbol{a}
$$

若向量$\boldsymbol{a}$和$\boldsymbol{b}$均为**行向量**，则向量内积可以用矩阵乘积(matrix product)来表示：

$$
\boldsymbol{a}\cdot \boldsymbol{b}=\boldsymbol{a}\boldsymbol{b}^T
$$

以二维向量为例，若向量：

$$
\boldsymbol{a}=[0,2]^T\\
\boldsymbol{b} = [2,2]^T
$$

则：

$$
\boldsymbol{a}\cdot \boldsymbol{b}=\begin{bmatrix}0\\2\end{bmatrix} \cdot \begin{bmatrix}2\\2 \end{bmatrix}=0\times2+2\times2=4
$$

## 向量点积的几何定义
在欧几里得空间，欧几里得向量(Euclidean vector)是一个既有大小又有方向的几何量。两个欧几里得向量$\boldsymbol{a}$和$\boldsymbol{b}$的点积(亦称为内积，inner product)定义为：

$$
\boldsymbol{a}\cdot \boldsymbol{b}=||\boldsymbol{a}||\ ||\boldsymbol{b}||\cos \theta\tag{1}
$$

其中$\theta$是向量$\boldsymbol{a}$和$\boldsymbol{b}$的夹角，$\vert\vert\boldsymbol{a}\vert\vert$表示向量$\boldsymbol{a}$的大小。

若定义向量$\boldsymbol{a}$在向量$\boldsymbol{b}$上的标量投影(scalar projection)：

$$
a_b =\boldsymbol{a}\cdot \hat{\boldsymbol{b}}= ||\boldsymbol{a}||\cos \theta \tag{2}
$$

则根据式(1)，向量$\boldsymbol{a}$和$\boldsymbol{b}$内积可写作：

$$
\begin{aligned}\boldsymbol{a}\cdot \boldsymbol{b}&=||\boldsymbol{a}||\ ||\boldsymbol{b}||\cos \theta \\
&=||\boldsymbol{a}||\cos \theta||\boldsymbol{b}||\\
&=||\boldsymbol{a}||b_a\\
&=a_b||\boldsymbol{b}||\\
\end{aligned} \tag{3}
$$

式(3)表明，从几何角度看，向量$\boldsymbol{a}$与$\boldsymbol{b}$的点积的结果等于向量$\boldsymbol{a}$在向量$\boldsymbol{b}$上的标量投影和$\boldsymbol{b}$模长的乘积；同理，也等于向量$\boldsymbol{b}$在向量$\boldsymbol{a}$上的标量投影和$\boldsymbol{a}$模长的乘积。

仍然以二维向量为例进行解释，令：

$$
\begin{split}
\boldsymbol{a}=[0,2]^T\\
\boldsymbol{b} = [2,2]^T
\end{split}
$$

则两个向量点积的几何解释如下图所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707232637512.png?raw=true" alt="image-20220707232637512" style="zoom: 50%;" />

(向量$\boldsymbol{a}$与$\boldsymbol{b}$的点积的结果等于向量$\boldsymbol{a}$在向量$\boldsymbol{b}$上的标量投影和$\boldsymbol{b}$模长的乘积)

$$
\begin{aligned}\boldsymbol{a}\cdot \boldsymbol{b}
&=a_b||\boldsymbol{b}||=\sqrt{2}\times2\sqrt{2}=4\\\end{aligned}
$$

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707232720063.png?raw=true" alt="image-20220707232720063" style="zoom: 50%;" />

(向量$\boldsymbol{a}$与$\boldsymbol{b}$的点积的结果等于向量$\boldsymbol{b}$在向量$\boldsymbol{a}$上的标量投影和$\boldsymbol{a}$模长的乘积)

$$
\begin{aligned}\boldsymbol{a}\cdot \boldsymbol{b}
&=b_a||\boldsymbol{a}||=2\times2=4\\\end{aligned}
$$

<br>

# 两种定义之间的联系

**矩阵对应着一种线性变换，并且矩阵的每一列是线性变换后基向量的坐标**，因此高维空间到一维空间的线性变换对应着一个行向量。比如，将二维空间中的向量变换到一维空间中的线性变换就对应一个1行2列的向量。

假设二维空间的向量经过一个线性变换都变换到了数轴$x_3$上，设$\hat{u}$是刚好落在该数轴上的“单位向量”。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707232759737.png?raw=true" style="zoom: 50%;" />

在二维空间中，如果将二维向量直接**投影**在数轴$x_3$上，实际上，我们就是定义了一个从二维向量到数的函数，并且这个函数是线性的，因为它通过了线性检验，即在二维空间中的任意一条直线上等距分布的点在投影到数轴上仍然是等距分布的。总之，这个投影操作实际上是一个从二维向量到数的线性变换，所以我们能够找到描述这个变换的$1\times2$矩阵，即$\hat{i}$和$\hat{j}$变换后的位置。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707232844852.png?raw=true" alt="image-20220707232844852" style="zoom:50%;" />

由上图，$\hat{i}$和$\hat{u}$的长度都为$1$，它们关于对称线对称，因此$\hat{i}$投影(线性变换)后落在数轴的$u_x$的位置处；同理，$\hat{j}$投影后落在数轴的$u_y$的位置处。所以投影变换对应的$1\times 2$矩阵的两列就是$\hat{u}$在二维空间的两个坐标。
$$
A=[u_x,u_y]
$$
空间中任意向量$\vec{v}$经过投影变换，就是这个投影矩阵$A$与向量$\vec{v}$相乘

$$
A\vec{v} = [u_x, u_y]\begin{bmatrix}x\\y\end{bmatrix}=u_x\cdot x+u_y\cdot y
$$

这个结果$\hat{u}$与$\vec{v}$点积代数定义的计算结果完全相同。

这就是为什么**向量与单位向量的点积可以解读为将向量投影到单位向量所在直线所得到的投影长度**；
而向量$\vec{v}$ 在非单位向量 $\hat{u}$上的投影类似的推导过程，只是投影矩阵需要乘上缩放系数。这也就是为什么**向量与给定非单位向量的点积可以解读为向量首先朝非单位向量上投影，然后将投影的值与该非单位向量的长度相乘**。

> 总结上述的推导过程
> 1. 将空间中的向量投影到给定数轴上的过程实际上是个线性变换，而每个线性变换都对应一个矩阵，并且矩阵的列向量是空间基底变换后的位置，因此投影操作可以由一个行向量来描述；
> 2. 表征投影操作的行向量与空间列向量相乘的计算结果(几何定义)，与向量点积的结果一致(代数定义)；

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707232940777.png?raw=true" style="zoom:50%;" />



> "在任何时候看到一个线性变换，它的输出空间是一维数轴，无论它是怎么定义的，空间中会存在唯一的向量$\hat{u}$与之相关，将向量$\vec{v}$线性变换到$\hat{u}$所在数轴的操作与$\hat{u}$和$\vec{v}$做点积是一样的。"

<br>

# 对偶性
投影变换必然会与某个二维向量相关，这实际上是数学中**“对偶性(duality)”**的一个实例。对偶性贯穿数学始终，在多个方面均有体现，而实际定义对偶性却很难，直观地讲，对偶性是指两种数学事物之间自然而又出乎意料的对应关系(Natural-but-surprising correspondence)。

一个向量的对偶是由它定义的线性变换(vector lineat transformation that it encodes)；一个多维空间到一维空间的线性变换的对偶是多维空间中的某个特定向量。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707233025264.png?raw=true"/>

**“所以有时你会意识到，不把向量看作空间中的箭头，而是把它看作线性变换的物质载体，会更容易理解向量，这时候，向量就仿佛是一个特定变换的概念性记号。”**

<br>

**Reference**

[1]  [Dot product - Wikipedia](https://en.wikipedia.org/wiki/Dot_product).

[2]  [3Blue1Brown线性代数系列视频](https://www.bilibili.com/video/BV1ys411472E?p=1&vd_source=f209f402a13cd84c99ed077bf0b9afb9).