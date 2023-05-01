金钥匙正是欧拉寻找的用分析的语言来表述埃拉托色尼筛法的一种方式。



对于黎曼Zeta函数：
$$
\zeta(s)=1+\dfrac1{2^s}+\dfrac1{3^s}+\dfrac1{4^s}+\dfrac1{5^s}+\dfrac1{6^s}+\dfrac1{7^s}+\dfrac1{8^s}+\dfrac1{9^s}+\dfrac1{10^s}+\dfrac1{11^s}+\cdots\label{eq1}
$$
将上式两边同乘$1/2^s$可以得到：
$$
\dfrac1{2^s}\zeta(s)=\dfrac1{2^s}+\dfrac1{6^s}+\dfrac1{8^s}+\dfrac1{10^s}+\dfrac1{12^s}+\dfrac1{14^s}+\dfrac1{16^s}+\dfrac1{18^s}+\cdots\label{eq2}
$$
令式$\eqref{eq1}$减去式$\eqref{eq2}$，可以得到：
$$
(1-\dfrac1{2^s})\zeta(s)=1+\dfrac1{3^s}+\dfrac1{5^s}+\dfrac1{7^s}+\dfrac1{9^s}+\dfrac1{11^s}+\dfrac1{13^s}+\dfrac1{15^s}+\dfrac1{17^s}+\dfrac1{19^s}+\cdots\label{eq3}
$$
经过这样的操作，式子右端以$1/2^s$的倍数项都被消去了，这非常类似对于等式右边的级数做Eratosthenes筛法 [2]！

注：但有一点不同，等式右端的$1/s^2$也被筛掉了，而在Eratosthenes筛法中是需要在序列中保留这样的素数的。

因此，我们继续将这一步骤进行下去。对式$\eqref{eq3}$两端同乘$1/3^s$：
$$
\dfrac{1}{3^s}(1-\dfrac1{2^s})\zeta(s)=\dfrac1{3^s}+\dfrac1{9^s}+\dfrac1{15^s}+\dfrac1{21^s}+\dfrac1{27^s}+\cdots\label{eq4}
$$
式$\eqref{eq3}$减去$\eqref{eq4}$：
$$
(1-\dfrac{1}{3^s})(1-\dfrac1{2^s})\zeta(s)=1+\dfrac1{5^s}+\dfrac1{7^s}+\dfrac1{11^s}+\dfrac1{13^s}+\dfrac1{17^s}+\dfrac1{19^s}+\dfrac1{23^s}+\dfrac1{29^s}+\cdots
$$
同理有：
$$
\dfrac1{5^s}(1-\dfrac{1}{3^s})(1-\dfrac1{2^s})\zeta(s)=\dfrac1{5^s}+\dfrac1{25^s}+\dfrac1{35^s}+\dfrac1{55^s}+\cdots
$$

$$
(1-\dfrac1{5^s})(1-\dfrac{1}{3^s})(1-\dfrac1{2^s})\zeta(s)=1+\dfrac1{7^s}+\dfrac1{11^s}+\dfrac1{13^s}+\dfrac1{17^s}+\dfrac1{19^s}+\cdots
$$

最终，经过无穷次数的操作，可以得到：
$$
\cdots(1-\dfrac1{11^s})(1-\dfrac1{7^s})(1-\dfrac1{5^s})(1-\dfrac{1}{3^s})(1-\dfrac1{2^s})\zeta(s)=1
$$
最终$\zeta(s)$为：
$$
\zeta(s)=\dfrac1{1-\dfrac1{2^s}}\times\dfrac1{1-\dfrac1{3^s}}\times\dfrac1{1-\dfrac1{5^s}}\times\dfrac1{1-\dfrac1{7^s}}\times\cdots
$$
简写作：
$$
\zeta(s)=\prod_p(1-p^{-s})^{-1}
$$
其中，$p$取遍所有素数。另一方面，根据式Zeta函数的定义$\eqref{eq1}$：
$$
\zeta(s)=\sum_nn^{-s}
$$
我们可以得到：
$$
\sum_nn^{-s}=\prod_p(1-p^{-s})^{-1}\label{eq5}
$$
式$\eqref{eq5}$被称作**欧拉积公式（Euler product formula）**，左端的无穷和式被称作**一个迪利克雷级数（a Dirichlet series）**，右端的无穷积式被称作**一个欧拉积（an Euler product）**。

实际上，式$\eqref{eq5}$提供了另一个一个关于“素数有无穷多个”的证明。若假设素数有有限个，无论$s$的值是什么，式$\eqref{eq5}$右端就是一个有限值；而当$s=1$时，式$\eqref{eq5}$的左端就是调和级数 [3]，是发散的，不可能收敛于一个有限值，因此假设是错误的，即素数应该有无穷多个。

注：Derbyshire在书中着重说明了一点 [1]，以上的证明是来自于欧拉的原始论文。欧拉对于式$\eqref{eq5}$的证明就占了十行，非常简单且漂亮。因此，*“you can’t beat going to the original sources”*.
{: .notice--primary}

<br>

**References**

[1] Derbyshire J. Prime obsession: Bernhard Riemann and the greatest unsolved problem in mathematics[M]. Joseph Henry Press, 2003.

[2] [Sieve of Eratosthenes and MATLAB primes Function - What a starry night~](http://whatastarrynight.com/mathematics/matlab/Sieve-of-Eratosthenes-and-MATLAB-primes-Function/).
