Basel Problem

寻找以下无穷级数的一个闭型：
$$
\sum_{i=1}^\infty\dfrac1{n^2}=1+\dfrac1{2^2}+\dfrac1{3^2}+\dfrac1{4^2}+\dfrac1{5^2}+\cdots
$$



欧拉的证法：

函数$\sin x$的泰勒展开式为：
$$
\sin x = x-\dfrac{x^3}{3!}+\dfrac{x^5}{5!}-\dfrac{x^7}{7!}+\cdots
$$
两边同除$x$：
$$
\dfrac{\sin x}{x}=1-\dfrac{x^2}{3!}+\dfrac{x^4}{5!}-\dfrac{x^6}{7!}+\cdots\label{eq1}
$$
另一方面，由于函数$\sin x/x$（即信号与系统中所讲的Sa函数，抽样函数）具有零点$\pm\pi$，$\pm2\pi$，$\pm3\pi$，$\pm4\pi$，$\cdots$，函数$\sin x/x$可以写作：
$$
\dfrac{\sin x}{x}=A(x-\pi)(x+\pi)(x-2\pi)(x+2\pi)\cdots=A\prod_{n=1}^\infty(x^2-n^2\pi^2)\label{eq2}
$$
根据式$\eqref{eq1}$和式$\eqref{eq2}$可以得到：
$$
1-\dfrac{x^2}{3!}+\dfrac{x^4}{5!}-\dfrac{x^6}{7!}+\cdots=A\prod_{n=1}^\infty(x^2-n^2\pi^2)\label{eq3}
$$
当$x=0$时，有：
$$
1=A\prod_{n=1}^\infty(-n^2\pi^2)
$$
因此：
$$
A=\dfrac1{\prod_{n=1}^\infty(-n^2\pi^2)}\label{eq4}
$$
将$\eqref{eq4}$代入到$\eqref{eq3}$中：
$$
1-\dfrac{x^2}{3!}+\dfrac{x^4}{5!}-\dfrac{x^6}{7!}+\cdots=\prod_{n=1}^\infty(1-\dfrac{x^2}{n^2\pi^2})=(1-\frac{x^2}{\pi^2})(1-\frac{x^2}{2^2\pi^2})\cdots
$$
对比两端的二次项系数可以得到：
$$
-\dfrac{x^2}{3!}=-\frac{x^2}{\pi^2}-\frac{x^2}{2^2\pi^2}-\frac{x^2}{3^2\pi^2}\cdots=-\sum_{n=1}^\infty\dfrac{x^2}{n^2\pi^2}
$$

$$
-\dfrac{1}{3!}=-\sum_{n=1}^\infty\dfrac1{n^2\pi^2}
$$

即：
$$
\sum_{n=1}^\infty\dfrac1{n^2}=\dfrac{\pi^2}6
$$

> 注 [2]：欧拉最初的这种推导方式中，将函数$\sin x/x$展开成无穷项连乘积（式$\eqref{eq2}$）的方式并不严谨，因为对于**有限个**根的函数可以这么做，但是这里$\sin x/x$有**无限个**根。在100多年后，Karl Weierstrass给出了**Weierstrass分解定理（Weierstrass factorization theorem）**，才证明了这一步骤是有效的，因为对于一般的$P(x)$，并不能保证这样的分解一定是有效的。



黎曼$\zeta$函数：
$$
\zeta(s)=\sum_{n=1}^\infty n^{-s}
$$
即：$s$的$\zeta$函数定义为$n$的负$s$次幂的取遍所有正整数$n$的和。

当$s=1$时，这个级数就是调和级数 [4] ，它是发散的，即$\zeta(1)$没有值；

当$s=2$时，这个级数对应的就是Basel问题，即$\zeta(2)=\pi^2/6$，除此之外，欧拉对于$s$为偶数，即$\zeta(4)$，$\zeta(6)$，$\cdots$，均以闭型的方式给出了无穷级数的精确解。

> $\zeta(4)=\pi^2/90$，$\zeta(6)=\pi^2/945$.

当$s$为奇数时，欧拉并没有给出结果，甚至在后来的260多年来没有任何结果，甚至对于$\zeta(3)$的闭型没有任何线索（即使有，也不能等效地适用于任何其他的奇数）。人们仅仅知道它们是**收敛的**。直到1978年，$\zeta(3)$才被证明是无理数（由希腊-法国数学家阿佩里给出）。

实际上，我们可以证明：**对于$\forall s>1$，$\zeta(s)$都是收敛的**。==证明==

当$s$非常接近于1时，$\zeta$函数引人注目地（remarkably）表现得像是$1/(s-1)$。

当$s<0$时，则$-s>0$，因此



Zeta函数只有当$s>1$时才具有值（即，是收敛的）。











<br>

**References**

[1] Derbyshire J. Prime obsession: Bernhard Riemann and the greatest unsolved problem in mathematics[M]. Joseph Henry Press, 2003.

[2] [Basel problem - Wikipedia](https://en.wikipedia.org/wiki/Basel_problem).

[3] [从巴塞尔问题(Basel problem)的证明到黎曼猜想 - 知乎](https://zhuanlan.zhihu.com/p/126675259).

[4] [Some Classical Series and Fourfold Division of Mathematics from Prime Obsession by Derbyshire - What a starry night~](http://whatastarrynight.com/mathematics/Some-Classical-Series-and-Fourfold-Division-of-Mathematics-from-Prime-Obsession-by-Derbyshire/#divergent-harmonic-series).





