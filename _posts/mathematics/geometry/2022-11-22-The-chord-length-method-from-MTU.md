---
title: The Chord Length Method(Chord-length Parameterization) from MTU
date: 2022-11-22 20:31 +0800
categories: 
 - Mathematics
tags:
 - Geometry
 - Numerical Analysis
---

# Introduction

首先需要明确一点，无论是chord-length method(AKA chord-length parameterization)，还是在[Discussion of Continuity and Parameterization in BREP From MTU](http://whatastarrynight.com/mathematics/discussions-of-continuity-and-parameterization-in-BREP-from-MTU/)中提到的arc-length parameterization或者其他的参数化方法，它们的本质都是**PARAMETERIZATION**。尽管采用了不同的手段，它们的目的都是为了将数据点(比如X-Y平面内的数据点)与t-value(即parameter value)联系起来，它的作用仅仅是相当于在t space中找到插值节点。如果我们想要得到一条在某种意义上与给定数据点非常接近的曲线(即找到一条parametric curve。我们可以寻找一些特定的函数类型，比如B-spline curve，或者简单的Bezier curve，详见[MTU CS3621: Introduction to Computing with Geometry Notes](https://pages.mtu.edu/~shene/COURSES/cs3621/NOTES/))，那么还需要再使用插值方法或者其他拟合方法。一定要弄清楚这一点。

<br>

如果一条数据点的内插曲线(interpolating curve)非常接近data polygon，那么在两个相邻数据点之间的内插曲线段的长度将非常接近这两个数据点之间chord的长度，并且内插曲线的总长度也将非常接近data polygon的总长度。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221121212640561.png?raw=true" alt="image-20221121212640561" style="zoom: 50%;" />

在上图中，内插曲线的每一个curve segment都和supporting chord非常接近。因此，按照弦长分布细分区域，插值参数就是[arc-length parameterization](http://whatastarrynight.com/mathematics/discussions-of-continuity-and-parameterization-in-BREP-from-MTU/#arc-length-parameterization)的近似值，这就是chord length(ie. chordal method)的优点。

<br>

# Chord Length Method

假设数据点为$D_0,D_1,\cdots,D_n$，那么数据点$D_{i-1}$和$D_i$之间的长度就是$\vert D_i-D_{i-1}\vert$，data polygon的长度$L$就是这些弦长的加和，即：

$$
L=\sum_{i=1}^n\vert D_i-D_{i-1}\vert\notag
$$

数据点$D_0$到数据点$D_k$的弦长与data polygon长度之比$L_k$为：

$$
L_k=\dfrac{\sum_{i=1}^k\vert D_i-D_{i-1}\vert}{L}\notag
$$

因此，如果我们想要得到内插曲线的arc-length parameterization，则必须根据比例$L_k$划分区域。更准确地讲，如果域为$[0,1]$，那么参数$t_k$应该位于$L_k$值处，即：

$$
\begin{split}
t_0&=0\\
t_k&=\dfrac1L(\sum_{i=1}^k\vert D_i-D_{i-1}\vert)\\
t_n&=1\\
\end{split}\notag
$$

其中，$L$为data polygon的总长度。通过这种方式，将参数域划分为弦长的比率。

我们看一个例子。

假设我们有四个数据点($n=3,\ i=0,1,2,3$)：

$$
D_0=(0,0),\ D_1=(1,2),\ D_2=(3,4),\ D_3=(4,0)\notag
$$

则每一个chord的长度分别为：

$$
\begin{split}
\vert D_1-D_0\vert&=\sqrt5\approx2.2361\\ 
\vert D_2-D_1\vert&=2\sqrt2\approx2.8284\\
\vert D_3-D_2\vert&=\sqrt{17}\approx4.1231\\
\end{split}\notag
$$

总长度为：

$$
L=\sqrt5+2\sqrt2+\sqrt{17}\approx9.1876\notag
$$

最后，我们得到相应的参数：

$$
\begin{split}
t_0 &= 0\\
t_1 &= \dfrac{\vert D_1-D_0\vert}{L}\approx0.2434\\
t_2 &= \dfrac{\vert D_1-D_0\vert+\vert D_2-D_1\vert}{L}\approx0.5512\\
t_3 &= 1
\end{split}\notag
$$

如下图所示，采用chord length method会改变parameter distribution：

![image-20221122084104148](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221122084104148.png?raw=true)

其中，uniformly spaced是将四个数据点中间的三条线段分别作为三个等长的区间。

如果参数域不是$[0,1]$，对于更一般的区间$[a,b]$，我们可以根据chord length将区间分割为：

$$
\begin{split}
t_0&=a\\
t_k&=a+L_k\times(b-a)\\
t_n&=b\\
\end{split}
$$

chord length method应用广泛，并且通常表现良好。多项式曲线不能参数化为具有单位速度(即弧长参数化)(由R. Farouki证明，常见于几何学)，因此chord length是一个很好的近似。

<br>

# Discussion

## Discussion 1: A longer chord may cause its curve segment to have a bulge bigger than necessary

有时，一个长的chord length会导致它所对应的curve segment有比较大的凸起，这一点在使用chord length方法的时候很常见。在下图中，黑色的曲线和蓝色的曲线都内插了7个数据点，其中黑色曲线采用了uniformly spaced方法，蓝色曲线采用了chord length方法。

![image-20221122085940053](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221122085940053.png?raw=true)

我们可以看到，两种方法得到的内插曲线有着比较相似的形状，除了最后一个curve segment。chord length方法得到的插值曲线摆动的幅度更大一些。

## Discussion 2: A better approximation

Schneider P J.所撰写的论文"An algorithm for automatically fitting digitized curves" [2] 提到，上文所述的chord length参数化方法其实是一种非常rough的，我们可以使用其他的拟合曲线的方法避免recursive processing，比如使用Newton-Raphson方法得到一个更好的$t$ value。



## Discussion 3:  (Maybe) Relates to Chebyshev interpolation

上面uniformly spaced方法与chord length方法的比较，使我联想到了切比雪夫多项式插值方法(见博客：[切比雪夫多项式及切比雪夫插值](http://whatastarrynight.com/mathematics/Chebyshev-polynomials/))。切比雪夫插值方法就采取了一组比较特殊的插值节点，从而得到插值余项的最小上界。与等距节点的插值方法相比，切比雪夫插值方法可以有效抑制龙格现象。并且虽然插值节点在x轴方向上并不是等距的，但是将其投影到单位圆上，它们中间的弧长是等距的。

![image-20221122201629455](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221122201632148.png?raw=true)

*（图片来自Sauer《数值分析》）*[3]

因此，切比雪夫节点和arc length method和chord length method也许有着一定的联系。但不同的是，切比雪夫插值并不是对于参数的插值，仍然是在XY平面内插值。

<br>

**Reference**

[1] [Michigan Technological University Informative Technology: The Chord Length Method](https://pages.mtu.edu/~shene/COURSES/cs3621/NOTES/INT-APP/PARA-chord-length.html).

[2] Schneider P J. An algorithm for automatically fitting digitized curves[J]. Graphics gems, 1990, 1: 612-626.

[3] Sauer T. 数值分析(原书第2版). 北京: 机械工业出版社, 2014.10(2021.1重印).







