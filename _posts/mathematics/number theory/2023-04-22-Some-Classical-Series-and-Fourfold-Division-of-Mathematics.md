---
layout: single
title: Some Classical Series and Fourfold Division of Mathematics from *Prime Obsession* by Derbyshire
date: 2023-04-22 19:00:03 +0800
categories: 
 - Mathematics
tags:
 - Mathematical Analysis
 - Prime Obsession
---

# Some Classical Series

## Divergent harmonic series

Derbyshire在书中用举了一个非常意思的推扑克牌的例子引出了调和级数（harmonic series）[1]，并且图文并茂地解释了它是如何缓慢发散的：

![image-20230422185214465](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230422185214465.png?raw=true)

本博客就不再赘述。这里主要给出调和级数的定义：

$$
\sum_{n=1}^\infty\dfrac1n=1+\dfrac12+\dfrac13+\dfrac14+\dfrac15+\cdots
$$

以及一个重要的结论：调和级数的加和是无穷大，即是**发散的（divergent）**。

> 证 [2]：
>
> 关于“调和级数是发散的”这一证明有很多，但是Derbyshire认为最简洁明了、最优雅的（straightforward and elegant）证明来自于中世纪法国数学家奥雷姆（Nicole d’Oreseme）的证明。奥雷姆取这个级数的2项，然后是4项，8项，16项，等等，将这个级数分组，形成无数多段，其中每一段都可以证明大于$1/2$：
> 
> $$
> \dfrac13+\dfrac14>\dfrac14+\dfrac14=\dfrac12\notag
> $$
>
> $$
\dfrac15+\dfrac16+\dfrac17+\dfrac18>\dfrac18+\dfrac18+\dfrac18+\dfrac18=\dfrac12\notag
> $$
>
> $$
> \begin{split}
> &\dfrac19+\dfrac1{10}+\dfrac1{11}+\dfrac{1}{12}+\dfrac{1}{13}+\dfrac{1}{14}+\dfrac{1}{15}+\dfrac{1}{16}
> >\dfrac{1}{16}+\dfrac{1}{16}+\dfrac{1}{16}+\dfrac{1}{16}+\dfrac{1}{16}+\dfrac{1}{16}+\dfrac{1}{16}+\dfrac{1}{16}=\dfrac12
> \end{split}\notag
> $$
>
> 因此，整个和都是无穷的。得证。
>

Derbyshire之所以介绍这个例子，一方面是因为调和级数有它独特的魅力，另一方面是因为它位于**黎曼假设（Riemann Hypothesis）**的中心。

## Convergent series

关于级数的令人惊奇之处，**不在于某些是发散的，而在于其中是不发散的（收敛的，convergent）**（*The amazing thing about series is not that some of them are divergent, but that any of them are not.*）。同样地，Derbyshire在书中用“在尺子上移动”的例子引出了四个收敛的级数 [1]：

![image-20230422185626920](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230422185626920.png?raw=true)

这四个收敛的级数是：

$$
\sum_{n=0}^\infty\dfrac1{2^n}=1+\dfrac12+\dfrac14+\dfrac18+\dfrac1{16}+\cdots=2
$$

$$
\sum_{n=0}^\infty(-1)^n\dfrac1{2^n}=1-\dfrac12+\dfrac14-\dfrac18+\dfrac1{16}+\cdots=\dfrac23
$$

$$
\sum_{n=0}^\infty\dfrac1{3^n}=1+\dfrac13+\dfrac19+\dfrac1{27}+\dfrac1{81}+\cdots=\dfrac32
$$

$$
\sum_{n=0}^\infty(-1)^n\dfrac1{3^n}=1-\dfrac13+\dfrac19-\dfrac1{27}+\dfrac1{81}+\cdots=\dfrac34
$$

实际上，上面这三个**级数**可以看作是一个**无穷项等比数列**的和。等比数列的求和公式为：

$$
S_n=\dfrac{a_0(1-q^n)}{1-q}
$$

因此有：

$$
\lim_{n\rightarrow\infty}\dfrac{1-(1/2)^n}{1-1/2}=2,\ \lim_{n\rightarrow\infty}\dfrac{1-(-1/2)^n}{1-(-1/2)}=2/3\\
\lim_{n\rightarrow\infty}\dfrac{1-(1/3)^n}{1-1/3}=3/2,\ \lim_{n\rightarrow\infty}\dfrac{1-(-1/3)^n}{1-(-1/3)}=3/4\\
$$

<br>

# Mathematical Analysis and Traditional Mathematical Fourfold Division

在学习数学的时候，很重要的一点是知道自己正处在数学的什么地方——你正在研究的问题所处在这个广阔学科的什么领域（*When reading math, it is important to know where in math you are: what region of this vast subject you are exploring*）。这些无穷级数所处的领域，数学家们称之为**分析（数学分析，analysis）**。实际上，分析往往被认为是对无穷大（无穷的大，infinite）和无穷小（无穷的小，infinitesimal）的研究。极限的概念处于分析的核心。例如，构成了分析中的主要部分的微积分，就是建立在极限的概念之上（*The concept of a limit is at the heart of analysis. All of calculus, for example, which forms the largest part of analysis, rests on the idea of a limit.*）。

按照**传统的**分法（traditional division），数学分为以下的分支：

- **算术（Arithmetic）**：研究整数和分数。典型的定理：偶数减去一个奇数等于一个奇数。
- **几何（Geometry）**：研究空间图形，即点，直线，曲线，以及三维的对象。典型的定理：在平面上，三角形的内角和为180度；
- **代数（Algebra）**：使用抽象符号代表数学对象（数，线，矩阵，变换），并研究这些符号如何组合的规则。典型的定理：对于任意两个数$(x+y)\times(x-y)=x^2-y^2$；
- **分析（Analysis）**：研究极限。典型的定理：调和级数是发散的。

现代数学（modern mathematics）所包含的内容远比上面这些多得多。例如，它包含由乔治·康托（George Cantor）在1874年创立的集合论（set theory）；英国人乔治（George Boole）于1854年从古典逻辑（classical logic）中分离出来的，研究所有数学概念的基础逻辑的基础（“foundations”）。传统的数学范畴已经被扩大，并且许多重要的新论题也被包括进来：几何包括了拓扑学（topology）；代数吸收了博弈论（game theory）等等。许多领域之间并没有一个清晰的边界，例如三角学（trigonometry）于1595年第一次被使用是就包含了几何和代数两者的要素。

但是，上面提到的四分法（fourfold division）对于我们在数学中找到自己想要的东西，仍然是一个不错的向导。并且，这样的想要有助于我们领略到19世纪最伟大的成果之一（Derbyshire称之为“伟大的聚变”，“the great fusion”）——将算术和分析相结合，产生了一个全新的研究领域，即**解析数论（analytic number theory）**。

<br>

**References**

[1] Derbyshire J. Prime obsession: Bernhard Riemann and the greatest unsolved problem in mathematics[M]. Joseph Henry Press, 2003.

[2] [Harmonic series (mathematics) - Wikipedia](https://en.wikipedia.org/wiki/Harmonic_series_(mathematics)).

