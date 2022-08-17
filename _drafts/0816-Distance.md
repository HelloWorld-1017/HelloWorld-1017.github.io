距离：Wikipedia

从度量到范数

数学上范数的定义



[Metric (mathematics) - Wikipedia](https://en.wikipedia.org/wiki/Metric_(mathematics)#Notes) 

在数学上，度量(metric)或者距离方程(distance function)是用于描述集合中点对之间距离的方程。一个具有度量的集合通常称为度量空间(metric space)。度量可以在集合上引入拓扑结构，但是不是所有的拓扑结构都可以由度量生成。拓扑结构可以由度量所描述的拓扑空间(topological space)被称为可度量化空间(metrizable space)。

微分几何(differential geometry)中度量的一个重要来源是度量张量(metric tensors)，即双线性形式(bilinear forms)，它可以从可微流形(differentiable manifold)的切向量(tangent vectors)定义到标量(scalar)上。度量张量允许通过积分确定沿曲线的距离，从而确定度量。

# 度量的公理化定义

度量的定义是数学公理化应用的一个实例。

集合 $X$ 上的度量是一个方程(称为distance function 或者简称为 distance)：
$$
d:X\times X\rightarrow \mathbb{R}\notag
$$
对于所有的 $x,y,z\in X$ ，度量都满足以下公理：

（1）同一性(identity of indiscernibles)
$$
d(x,y)=0\Leftrightarrow x=y\notag
$$
（2）对称性(symmetry)
$$
d(x,y)=d(y,x)\notag
$$
（3）三角不等式(triangle inequality)
$$
d(x,z)\le d(x,y)+d(y,z)\notag
$$
由这些公理可以推导出度量的非负性。根据三角不等式有：
$$
d(x,y)+d(y,x)\ge d(x,x)\notag
$$
根据对称性有：
$$
d(x,y)+d(x,y)\ge d(x,x)\notag
$$
将上述两个式子相加并化简：
$$
2d(x,y)\ge 0\notag
$$
于是可以得到度量的非负性。

（4）非负性(non-negativity)
$$
d(x,y)\ge0\notag
$$
度量是一个非负的实值函数。这与公理（1）一起提供了分离条件(separation condition)，即不同的点或分离的点就是它们之间具有正距离的点。

以上三条公理是度量基本的定义，当对上述公理加强或者放宽限制，可以得到度量的不同性质，比如 [ultrametric](https://en.wikipedia.org/wiki/Ultrametric_space)，[intrinsic](https://en.wikipedia.org/wiki/Intrinsic_metric)，left-invariant，translation invariant 等等。

## 由范数导出的度量

每个向量空间都是一个交换加性群(commutative additive group)，实数或者复数向量空间中**由范数导出的度量**均满足平移不变性(translation invariant)。当且仅当实数或者复数向量空间 $V$ 上的度量 $d$ 满足平移不变性并且是绝对齐次性(absolutely homogeneous)，该度量 $d$ 才是由范数导出的。
$$
\begin{align*}
实数或复数向量空间V上的度量d是由范数导出的\Rightarrow 度量d满足平移不变性\\
实数或复数向量空间V上的度量d满足平移不变性和绝对齐次性\Rightarrow 度量d是由范数导出的
\end{align*}
$$
绝对齐次性意味着对于所有的标量 $s$ 和所有的 $x,y\in V$ ，均有$d(sx,sy)=\vert s\vert d(x,y)$ 成立，在这种情况下方程 $\vert\vert x \vert\vert$ 定义为 $\vert\vert x \vert\vert:=d(x,0)$ ，$\vert\vert x \vert\vert$ 定义了向量空间 $V$ 上的一个范数，由 $\vert\vert\cdot\vert\vert$ 定义的规范度量(canonical metric)等于 $d$ 。

向量空间中的范数可以导出一些特定的度量，这些度量满足齐次性和平移不变性。换句话说，任意一个范数都决定了一个度量，而一些度量都决定了同一个范数。



==to be continued==

## 度量示例

只要一个方程在空间中始终满足度量定义中的三条公理，那么这个方程就是一个度量。由此，数学家们根据不同场景和需要构造了许多度量，即距离方程。比如 [discrete metric](https://en.wikipedia.org/wiki/Discrete_space)，[Euclidean metric](https://en.wikipedia.org/wiki/Euclidean_metric)，[taxicab metric](https://en.wikipedia.org/wiki/Taxicab_geometry)（即 $L_1$ 范数），induced by a [norm](https://en.wikipedia.org/wiki/Norm_(mathematics))，[Graph metric](https://en.wikipedia.org/wiki/Graph_metric)（图论），[Hamming distance](https://en.wikipedia.org/wiki/Hamming_distance)（应用于编码理论），[Riemannian metric](https://en.wikipedia.org/wiki/Riemannian_metric)，[Fubini–Study metric](https://en.wikipedia.org/wiki/Fubini–Study_metric)，[String metrics](https://en.wikipedia.org/wiki/String_metric)，[Graph edit distance](https://en.wikipedia.org/wiki/Graph_edit_distance)，[Wasserstein metric](https://en.wikipedia.org/wiki/Wasserstein_metric)（[WGAN](https://ww2.mathworks.cn/help/deeplearning/ug/trainwasserstein-gan-with-gradient-penalty-wgan-gp.html)的损失函数），[Finsler metric](https://en.wikipedia.org/wiki/Finsler_metric)（微分几何学）



[Measure (mathematics) - Wikipedia](https://en.wikipedia.org/wiki/Measure_(mathematics)) （测度，分形）

