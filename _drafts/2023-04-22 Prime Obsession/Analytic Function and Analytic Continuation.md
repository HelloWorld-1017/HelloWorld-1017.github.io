Analytic Function and Analytic Continuation



Prime Obsession

# Analytic Function

**解析函数（Analytic function）** [1] 是由收敛的幂级数局部给出的函数（locally given by convergent power series）。解析函数两种类型：实解析函数（real analytic functions）和复解析函数（complex analytic functions）。两种类型的解析函数都具有**无限可微（infinitely differentiable）**的特性，但是复解析函数所表现出来的性质通常对于实解析函数是不成立的。函数$f(z)$在$D$内是解析的一个充要条件是：$f(z)$在$D$内任一点$z_0$的邻域可展开为$z-z_0$的泰勒级数 [2]。

正式地讲，在实数轴（real line）中的一个开集（open set）$D$上，对于任意的$x_0\in D$，函数$f$都可以写作：
$$
f(x)=\sum_{n=0}^\infty a_n(x-x_0)^n=a_0+a_1(x-x_0)+a_2(x-x_0)^2+\cdots
$$
其中，系数$a_0,a_1,\cdots$都是实数；并且该级数对于$x_0$邻域内的任何$x$值都收敛于$f(x)$，我们就称函数$f$在开集$D$上是实解析的（real analytic）。

或者，在$D$上的任一点$x_0$的邻域内的任何$x$值都收敛于泰勒级数：
$$
T(x)=\sum_{n=0}^\infty\dfrac{f^{n}(x_0)}{n!}(x-x_0)^n
$$
都收敛于$f(x)$，我们就称这是一个实解析函数，或者称它是一个**无限可微函数（infinitely differentiable function）**。在给定集合$D$上的所有实解析函数的集合通常被记为$\mathcal{C}^\omega(D)$。

复解析函数的定义是类似的，只需要将上述定义中的“real”替换为“complex”，“real line”替换为“complex plane”。一个函数是复解析的充要条件是该函数是**全纯的（holomorphic）**，即该函数是**复可微的（complex differentiable）**。也因此，对于复解析的函数，术语“holomorphic”和“analytic”可以相互替换。

<br>

# Analytic Continuation

在复分析（complex analysis）领域，解析延拓（analytic continuation）是一种用于拓展给定解析函数定义域的技术 [3]。



经典的两个例子；





<br>

# A Example of Analytic Continuation

<br>

**References**

[1] [Analytic function - Wikipedia](https://en.wikipedia.org/wiki/Analytic_function).

[2] [解析函数的若干等价条件 - 知乎](https://zhuanlan.zhihu.com/p/392296168).

[3] [Analytic continuation - Wikipedia](https://en.wikipedia.org/wiki/Analytic_continuation).







