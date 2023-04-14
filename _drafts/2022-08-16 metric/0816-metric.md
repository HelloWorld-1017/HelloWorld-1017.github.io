度量、范数、测度

# 度量

## 背景

[Metric (mathematics) - Wikipedia](https://en.wikipedia.org/wiki/Metric_(mathematics)) 

在数学上，度量(metric)或者距离方程(distance function)是用于描述集合中点对之间距离的方程。一个具有度量的集合通常称为度量空间(metric space)。度量可以在集合上引入拓扑结构，但不是所有的拓扑结构都可以由度量生成。拓扑结构可以由度量所描述的拓扑空间(topological space)被称为可度量化空间(metrizable space)。

微分几何(differential geometry)中度量的一个重要来源是度量张量(metric tensors)，即双线性形式(bilinear forms)，它可以从可微流形(differentiable manifold)的切向量(tangent vectors)定义到标量(scalar)上。度量张量允许通过积分确定沿曲线的距离，从而确定度量。

## 度量的公理化定义

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

## 度量示例

只要一个方程在空间中始终满足度量定义中的三条公理，那么这个方程就是一个度量。由此，数学家们根据不同场景和需要构造了许多度量，即距离方程。比如 [discrete metric](https://en.wikipedia.org/wiki/Discrete_space)，[Euclidean metric](https://en.wikipedia.org/wiki/Euclidean_metric)，[taxicab metric](https://en.wikipedia.org/wiki/Taxicab_geometry)（即 $L_1$ 范数），induced by a [norm](https://en.wikipedia.org/wiki/Norm_(mathematics))，[Graph metric](https://en.wikipedia.org/wiki/Graph_metric)（图论），[Hamming distance](https://en.wikipedia.org/wiki/Hamming_distance)（应用于编码理论），[Riemannian metric](https://en.wikipedia.org/wiki/Riemannian_metric)，[Fubini–Study metric](https://en.wikipedia.org/wiki/Fubini–Study_metric)，[String metrics](https://en.wikipedia.org/wiki/String_metric)，[Graph edit distance](https://en.wikipedia.org/wiki/Graph_edit_distance)，[Wasserstein metric](https://en.wikipedia.org/wiki/Wasserstein_metric)（[WGAN](https://ww2.mathworks.cn/help/deeplearning/ug/trainwasserstein-gan-with-gradient-penalty-wgan-gp.html)的损失函数），[Finsler metric](https://en.wikipedia.org/wiki/Finsler_metric)（微分几何学）

## 广义度量

==2bc==

# 度量与范数

## 范数的公理化定义

[Norm - Wikipedia](https://en.wikipedia.org/wiki/Norm_(mathematics))

给定复数 $\mathbb{C}$ 子域(subfield) $F$ 上的一个向量空间 $X$ ，范数是定义在 $X$ 上的一个实数方程(real-valued function)  $p:X\rightarrow \mathbb{R}$ ， 该实数方程具有以下性质：

**（1）次可加性/三角不等式(Subadditivity/Triangle inequality)**
$$
p(x+y)\le p(x)+p(y)\notag
$$
对于所有的 $x,y\in X$ 均成立。

**（2）绝对齐次性(Absolute honogeneity)**
$$
p(sx)=\vert s\vert p(x)\notag
$$
对于所有的 $x\in X$ 和所有的标量 $s$ 均成立。

**（3）正定性/点分离(Positive definiteness/Point-separating)**

对于所有的 $x\in X$，如果 $p(x)=0$ 则有 $x=0$。

因为性质（2）已经暗示了 $p(0)=0$ ，因此一些地方将性质（3）写作等价形式：对于任意的 $x\in X$ ，当且仅当 $x=0$ 时，$p(x)=0$。
{: .notice}

## 范数的非负性

对于任意的 $x\in X$，根据性质（1）有：
$$
p(x)+p(-x)\ge p(x-x)=p(0)=0\notag
$$
即
$$
p(x)+p(-x)\ge 0\notag
$$
又根据性质（2），有：
$$
p(x)+p(x)\ge 0\notag
$$
即可以得到**范数的非负性(Non-negativity)**：对于所有的 $x\in X$，均有 $p(x)\ge0$ 成立。

一些观点认为范数的非负性应该是范数定义的一部分，尽管这不是必需的（不能作为公理）。
{: .notice}



## 半范数

半范数(seminorm)是范数的一种推广，它比范数的要求弱。只要满足上述的性质（1）和性质（2）就是半范数，即使半范数为零的向量不一定是零向量。因此，范数一定是半范数，而半范数不一定是范数。

## 度量与范数的关系

每个向量空间都是一个交换加性群(commutative additive group)，实数或者复数向量空间中**由范数导出的度量**均满足平移不变性(translation invariant)。而当且仅当实数或者复数向量空间 $V$ 上的度量 $d$ 满足平移不变性并且是绝对齐次性(absolutely homogeneous)，该度量 $d$ 才是由范数导出的。
$$
\begin{align*}
实数或复数向量空间V上的度量d是由范数导出的\Rightarrow 度量d满足平移不变性\\
实数或复数向量空间V上的度量d满足平移不变性和绝对齐次性\Rightarrow 度量d是由范数导出的
\end{align*}
$$
向量空间中的范数可以导出一些特定的度量，这些度量满足齐次性和平移不变性。换句话说，任意一个范数都决定了一个度量，而一些度量都决定了同一个范数。

在一个赋范向量空间 $X$ 上，我们可以定义一个度量 $d$，如果满足
$$
d(x,y):=\vert\vert x-y\vert\vert\notag
$$
则称度量 $d$ 是由范数导出的(the norm induced metric)。

相反，如果定义在向量空间 $X$ 上的度量 $d$ 满足性质：

（1）平移不变性：$d(x,y)=d(x+a,y+a)$

（2）绝对齐次性：$d(\alpha x, \alpha y)=\vert\alpha\vert d(x,y)$

定义在空间 $X$ 上的范数可以定义为
$$
\vert\vert x\vert\vert:=d(x,0)\notag
$$
则称度量 $d$ 是由该范数导出的。

> 赋范向量空间(Normed vector spaces)或者简称为赋范空间(normed space)是指定义了范数的实数空间或复数空间。
>
> ![image-20220817224741580](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220817224741580.png)
>
> [Normed vector space - Wikipedia](https://en.wikipedia.org/wiki/Normed_vector_space)
>
> 数学空间(mathematical spaces)的层次结构。赋范向量空间是内积空间的超集(superset)，是度量空间的子集(subset)。

# 度量与测度

## 背景

在数学中，测度(measure)的概念是几何度量（如长度、面积、体积）和其他常见概念（如质量和事件概率）的推广和形式化。这些看似不同的的概念有许多相似之处，能够在同一个数学背景下进行对待和处理。

测度是概率理论，积分理论的基本概念，并且可以推广到负值，如电荷(electrical charge)。测度的进一步推广（如谱测度(spectral measures)和投影值测度(projection-valued measures)）被广泛应用于量子物理学(quantum physics)和一般物理学中。

测度背后的直觉见解(intuition)可以追溯到古希腊(ancient Greece)阿基米德(Archimedes) 尝试计算圆的面积。但是直到19世纪末20世纪初期，测度理论才成为数学的一个分支。 [Émile Borel](https://en.wikipedia.org/wiki/Émile_Borel)、[Henri Lebesgue](https://en.wikipedia.org/wiki/Henri_Lebesgue)、[Nikolai Luzin](https://en.wikipedia.org/wiki/Nikolai_Luzin)、[Johann Radon](https://en.wikipedia.org/wiki/Johann_Radon)、 [Constantin Carathéodory](https://en.wikipedia.org/wiki/Constantin_Carathéodory) 和 [Maurice Fréchet](https://en.wikipedia.org/wiki/Maurice_Fréchet) 等人的工作奠定了现代测度理论的基础。



## $\sigma$-代数

在数学分析(mathematical analysis)和概率论(probability theory)中， $\sigma$-代数或者称$\sigma$-场($\sigma$-algebra or  $\sigma$-field)定义为一个在集合 $X$ 上的非空子集 $\Sigma$ ，该子集满足在补集运算(complement)，可数个并集运算(unions)和可数个交集操作(intersections)下满足封闭性(closed)。$(X,\Sigma)$ 被称为可测空间(measurable space)。

$\sigma$-代数是集合代数(set algebras)的子集。集合代数只需要满足在有限多个子集的并集运算和交集运算下封闭，这是一个比较弱的条件。

$\sigma$-代数的主要用在测度的定义中，



[Measure (mathematics) - Wikipedia](https://en.wikipedia.org/wiki/Measure_(mathematics)) （测度，分形）

