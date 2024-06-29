---
layout: single
title: Maximum Likelihood Estimation for Multivariate Normal Distribution
date: 2022-10-25 19:42:27 +0800
categories: 
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
toc: false
---

$p$-维多元正态函数的概率密度函数的形式为：

$$
x\sim\mathcal{MVN}(\mu,\Sigma)=f(x,\mu,\Sigma)=(2\pi)^{-p/2}\vert\Sigma\vert^{-1/2}
\exp\Big\{-\dfrac12(x-\mu)^T\Sigma^{-1}(x-\mu)\Big\}\label{eq1}
$$

其中，$x$和$\mu$是$p\times1$的向量，$\Sigma$是$p\times p$的对称定阵(symmetric definite matrix)。

假设$n$个样本$X_1,\cdots,X_n$独立同分布于MVN，即有：

$$
X_1,\cdots,X_n\stackrel{i.i.d}{\sim}\mathcal{MVN}(\mu,\Sigma)
$$
求参数$\mu$和$\Sigma$的极大似然估计形式。

<br>

首先写出log似然函数：

$$
\begin{split}
\log\ L_n(\mu, \Sigma\vert X_1,\cdots,X_n)&=\log\ \prod_{i=1}^n(2\pi)^{-p/2}\vert\Sigma\vert^{-1/2}\mathrm{exp}\Big\{-\dfrac12(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)\Big\}\\
&=-\dfrac{np}{2}\log2\pi-\dfrac{n}2\log\vert\Sigma\vert-\dfrac12\sum_{i=1}^n(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)\\
\end{split}\label{likelihood}
$$

之后，得到极大似然方程组：

$$
\left\{\begin{split}
&\dfrac{\partial\log L_n}{\partial\mu}=0\\
&\dfrac{\partial\log L_n}{\partial\Sigma^{-1}}=0\\
\end{split}
\right.
$$

这里写作对$\Sigma^{-1}$求偏导，是为了后面计算方便。
{: .notice--warning}

首先，对于均值$\mu$，有：

> 注：
>
> 如果$w$不依赖与矩阵$A$，并且矩阵$A$是对称的，则有：$\dfrac{\partial w^TAw}{\partial w}=2Aw$

$$
\begin{split}
&\dfrac{\partial \log\ L_n(\mu, \Sigma\vert X_1,\cdots,X_n)}{\partial\mu}=0\\
\Rightarrow&\sum_{i=1}^n\Sigma^{-1}(X_i-\mu)=0\\
\Rightarrow&\hat{\mu}=\dfrac1n\sum_{i=1}^nX_i
\end{split}\label{MU}
$$

其次，对于协方差矩阵$\Sigma$：

> 注：
>
> (1) 迹在矩阵乘法的循环置换(cyclic permutations)下是不变的(invariant)：$\mathrm{tr}[ABC]=\mathrm{tr}[CBA]=\mathrm{tr}[BCA]$；
>
> (2) 如果$x^TAx$为标量，则有：$x^TAx=\mathrm{tr}(x^TAx)=\mathrm{tr}(xx^TA)$；
>
> (3) $\dfrac{\partial}{\partial A}\mathrm{tr}(AB)=B^T$；
>
> (4) $\dfrac{\partial}{\partial A}\log\vert A\vert=(A^{-1})^T=(A^T)^{-1}$；
>
> (5) 若矩阵$A$可逆，则有：$\vert A\vert=\dfrac{1}{\vert A^{-1}\vert}$；
>
> (6) 根据运算法则(2)和(3)，有：
>
> $$
> \dfrac{\partial}{\partial A}x^TAx=\dfrac{\partial}{\partial A}\mathrm{tr}(xx^TA)=(xx^T)^T=xx^T
> $$
>
> 即结果等于向量$x$与自身的外积(outer product)。
>

根据以上的运算法则，将式$\eqref{likelihood}$的log似然函数化简为：

$$
\begin{split}
\log\ L_n
&=C+\dfrac{n}2\log\vert\Sigma^{-1}\vert-\dfrac12\sum_{i=1}^n(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)\\
\end{split}
$$

于是有：

$$
\begin{split}
&\dfrac{\partial\log L_n}{\partial \Sigma^{-1}}=0\\
\Rightarrow&\dfrac{\partial\Big(C+\dfrac{n}2\log\vert\Sigma^{-1}\vert-\dfrac12\sum_{i=1}^n(X_i-\mu)^T\Sigma^{-1}(X_i-\mu)\Big)}{\partial\Sigma^{-1}}=0\\
\Rightarrow&\dfrac{n}{2}\Sigma-\dfrac{1}{2}\sum_{i=1}^n(X_i-\mu)(X_i-\mu)^T=0\ (\mathrm{Since}\ \Sigma^T=\Sigma)\\
\Rightarrow&\hat{\Sigma}=\dfrac1n\sum_{i=1}^n(X_i-\hat{\mu})(X_i-\hat{\mu})^T
\end{split}\label{SIGMA}
$$

总结式$\eqref{MU}$和$\eqref{SIGMA}$，可以得到MVN的均值$\mu$和$\Sigma$的MLE估计形式：

$$
\begin{split}
&\hat{\mu}_{\mathrm{MLE}}=\dfrac1n\sum_{i=1}^nX_i\\
&\hat{\Sigma}_{\mathrm{MLE}}=\dfrac1n\sum_{i=1}^n(X_i-\hat{\mu})(X_i-\hat{\mu})^T
\end{split}
$$

该形式与博客 [2] 中推导的一维正态函数的极大似然估计形式是类似的，即：使用样本均值估计总体分布的均值，使用样本协方差矩阵估计总体分布的协方差矩阵。

<br>

**Reference**

[1] [Maximum Likelihood Estimators - Multivariate Gaussian](https://stats.stackexchange.com/questions/351549/maximum-likelihood-estimators-multivariate-gaussian).

[2] [Point Estimation - What a starry night ~](http://whatastarrynight.com/mathematics/Point-Estimation/#mle).
