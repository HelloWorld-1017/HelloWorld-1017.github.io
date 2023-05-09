---
layout: single
title: Scalar Projection, Vector Projection, Scalar Rejection and Vector Rejection
date: 2023-05-09 13:36:31 +0800
categories: 
 - Mathematics
tags: 
 - Matrix
 - Geometry
---

# Definitions based on angle $\theta$

**（1）标量投影（Scalar projection）**

向量$\boldsymbol{a}$对向量$\boldsymbol{b}$的标量投影定义为：

$$
a_1=\vert\vert\boldsymbol{a}\vert\vert\cos\theta
$$

其中$\theta$为向量$\boldsymbol{a}$和向量$\boldsymbol{b}$之间的夹角。

**（2）向量投影（Vector projection）**

向量$\boldsymbol{a}$对向量$\boldsymbol{b}$的向量投影定义为：

$$
\boldsymbol{a}_1=a_1\hat{\boldsymbol{b}}=(\vert\vert\boldsymbol{a}\vert\vert\cos\theta)\hat{\boldsymbol{b}}
$$

其中，$\hat{\boldsymbol{b}}$是与向量$\boldsymbol{b}$同方向的单位向量。可以看到，标量投影是相应的向量投影的模长。

**（3）Vector rejection**

向量$\boldsymbol{a}$对向量$\boldsymbol{b}$的Vector rejection定义为：

$$
\begin{split}
\boldsymbol{a}_2&=\boldsymbol{a}-\boldsymbol{a}_1\\
&=\boldsymbol{a}-(\vert\vert\boldsymbol{a}\vert\vert\cos\theta)\hat{\boldsymbol{b}}
\end{split}
$$

**（4）Scalar rejection**

同样地，Scalar rejection定义为Vector rejection的模长：

$$
a_2=\vert\vert\boldsymbol{a}_2\vert\vert
$$

并且从几何的角度可以很容易地推导出：

$$
a_2=\vert\vert\boldsymbol{a}\vert\vert\sin\theta
$$

<br>

# Definitions in terms of $\boldsymbol{a}$ and $\boldsymbol{b}$

在有些情况下，角度$\theta$未知，我们需要基于向量$\boldsymbol{a}$和向量$\boldsymbol{b}$的计算出角度$\theta$（根据点积的定义 [2]）：

$$
\cos\theta=\dfrac{\boldsymbol{a}\cdot\boldsymbol{b}}{\vert\vert\boldsymbol{a}\vert\vert\ \vert\vert\boldsymbol{b}\vert\vert}
$$

因此，直接基于向量$\boldsymbol{a}$和向量$\boldsymbol{b}$定义上述四个量是更加方便的。

**（1）标量投影（Scalar projection）**

$$
a_1=\vert\vert\boldsymbol{a}\vert\vert\cos\theta=\dfrac{\boldsymbol{a}\cdot\boldsymbol{b}}{\vert\vert\boldsymbol{b}\vert\vert}
$$

**（2）向量投影（Vector projection）**

$$
\boldsymbol{a}_1=a_1\hat{\boldsymbol{b}}=\dfrac{\boldsymbol{a}\cdot\boldsymbol{b}}{\vert\vert\boldsymbol{b}\vert\vert}\dfrac{\boldsymbol{b}}{\vert\vert\boldsymbol{b}\vert\vert}
$$

等价于：

$$
\boldsymbol{a}_1=(\boldsymbol{a}\cdot\hat{\boldsymbol{b}})\hat{\boldsymbol{b}}
$$

或者：

$$
\boldsymbol{a}_1=\dfrac{\boldsymbol{a}\cdot\boldsymbol{b}}{\vert\vert\boldsymbol{b}\vert\vert^2}\boldsymbol{b}=\dfrac{\boldsymbol{a}\cdot\boldsymbol{b}}{\boldsymbol{b}\cdot\boldsymbol{b}}\boldsymbol{b}
$$

**（3）Scalar rejection**

记向量$\boldsymbol{b}=(b_x,b_y)$的正交向量为$\boldsymbol{b}^\perp=(-b_y,b_x)$，则Scalar rejection可以写作：

$$
a_2=\vert\vert\boldsymbol{a}\vert\vert\sin\theta=\vert\vert\boldsymbol{a}\vert\vert\dfrac{\boldsymbol{a}\cdot\boldsymbol{b}^\perp}{\vert\vert\boldsymbol{a}\vert\vert\ \vert\vert\boldsymbol{b}^\perp\vert\vert}=\dfrac{\boldsymbol{a}\cdot\boldsymbol{b}^\perp}{\vert\vert\boldsymbol{b}\vert\vert}
$$

其中，点积$\boldsymbol{a}\cdot\boldsymbol{b}^\perp$也被称作**垂直点积（perp dot product）**。

**（4）Vector rejection**

$$
\begin{split}
\boldsymbol{a}_2&=\boldsymbol{a}-\boldsymbol{a}_1\\
&=\boldsymbol{a}-\dfrac{\boldsymbol{a}\cdot\boldsymbol{b}}{\boldsymbol{b}\cdot\boldsymbol{b}}\boldsymbol{b}
\end{split}
$$

<br>

基于向量$\boldsymbol{a}$和向量$\boldsymbol{b}$的定义在编程时更方便计算。以向量$\boldsymbol{a}=(1,1)$，$\boldsymbol{b}=(0.4,1.6)$进行验证：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230509133231886.png" alt="image-20230509133231886" style="zoom:50%;" />

```matlab
clc,clear,close all

hold(gca,"on")
box(gca,"on")
grid(gca,"on")
axis(gca,"equal")
vecA = [1,1];
vecB = [0.4,1.6];
vecA1 = (vecA*vecB')/(vecB*vecB')*vecB;
vecA2 = vecA-(vecA*vecB')/(vecB*vecB')*vecB;

scatter3(0,0,0,50, ...
    'filled','o','MarkerFaceColor','k','HandleVisibility','off')
q1 = quiver(0,0,vecA(1),vecA(2), ...
    'LineWidth',1.5,'AutoScale','off','DisplayName','$a$');
q2 = quiver(0,0,vecB(1),vecB(2), ...
    'LineWidth',1.5,'AutoScale','off','DisplayName','$b$');
q3 = quiver(0,0,vecA1(1),vecA1(2), ...
    'LineWidth',1.5,'AutoScale','off','DisplayName','$a_1$');
q4 = quiver(vecA1(1),vecA1(2),vecA2(1),vecA2(2), ...
    'LineWidth',1.5,'AutoScale','off','DisplayName','$a_1$');
legend('Interpreter','latex')
```

<br>

**References**

[1] [Vector projection - Wikipedia](https://en.wikipedia.org/wiki/Vector_projection).

[2] [Geometric and Algebraic Definition of Dot Product - What a starry night~](http://whatastarrynight.com/mathematics/Geometric-and-Algebraic-Definition-of-Dot-Product/).

