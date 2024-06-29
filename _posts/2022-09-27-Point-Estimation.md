---
layout: single
title: Point Estimation
date: 2022-09-27 18:47:31 +0800
categories: 
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
---

# Introduction

设有一个统计总体，其概率密度函数或者概率函数（分别针对连续型和离散型总体分布）$f(x;\theta_1, \cdots, \theta_k)$ 为 $f(x;\theta_1, \cdots, \theta_k)$ 。参数估计问题的一般提法是：假设从总体中抽出的样本 $X_1, \cdots, X_n$（样本为独立随机样本，即 $X_1, \cdots, X_n$ 独立同分布，且公共分布就是总体分布），要依据这些样本去对参数 $f(x;\theta_1, \cdots, \theta_k)$ 的未知值做出估计。

我们可以根据需要只估计 $\theta_1,\cdots, \theta_k$ 中的一部分，或者估计他们的某个函数 $g(\theta_1,\cdots,\theta_k)$ 。例如，为了估计 $\theta_1$ ，我们需要构造出适当的统计量 $\hat{\theta}_1=\hat{\theta}_1(X_1,\cdots,X_n)$。每当有了样本 $X_1,\cdots,X_n$ ，就代入函数 $\hat{\theta}_1(X_1,\cdots,X_n)$ 中算出一个值，用来作为 $\theta_1$ 的估计值。以这样的特定的目的而构造的统计量 $\hat{\theta}_1$ 叫做 **$\theta_1$ 的估计量**。由于未知参数 $\theta_1$ 是数轴上的一个点，用 $\hat{\theta}_1$ 去估计 $\theta_1$ ，等于用一个点去估计另一个点，所以这样的估计叫做点估计，以别于区间估计。

<br>

# Estimation Methods

## Moment Estimation

### Moments of  Random Variables

设 $X$ 为随机变量，$c$ 为常数，$k$ 为正整数，则量 $E[(X-c)^k]$ 称为 $X$ 关于 $c$ 点的 $k$ 阶矩。

比较重要的有两种情况：

（1）$c=0$，这时 $\alpha_k=E(X^k)$ 称为 $X$ 的 **$k$ 阶原点矩**；

（2）$c=E(X)$，这时 $\mu_k=E[(X-EX)^k]$ 称为 $X$ 的 **$k$ 阶中心矩**；

一阶原点矩就是期望。

一阶中心矩 $\mu_1=0$，二阶中心矩 $\mu_2=E[(X-EX)^2]$ 就是 $X$ 的方差 $\mathrm{Var}(X)$。

### Theoretical Moment and Empirical Moment

对于随机变量 $X$，我们定义了 $k$ 阶原点矩 $\alpha_k$ 和  $k$ 阶中心矩 $\mu_k$，有时称它们为**理论矩**；另一方面，对于选取的样本，我们定义了 $k$ 阶样本原点矩 $a_k$ 和  $k$ 阶样本中心矩 $m_k$，有时称它们为**经验矩**。

> 对于理论矩和经验矩的理解
>
> 设总体分布 $F$ 有理论矩 $\alpha_k$ 和 $\mu_k$，由于我们不知道  $F$ ，因此也就不知道 $\alpha_k$ 和 $\mu_k$ 的取值。现在从该总体中抽出的样本  $X_1, \cdots, X_n$ 的地位是平等的，一个合理的选择是把 $F_n$ 取成一个**离散分布**，它在每个值 $X_i$ 处各有概率 $1/n\ (i=1,\cdots,n)$ ，于是分布函数 $F_n$ 的形式可以定义为
> 
> $$
> F_n(x)=\{X_1,\cdots,X_n中不大于x的个数\}/n
> $$
> 
> 它称为样本  $X_1, \cdots, X_n$ 的**经验分布函数**。如果按照理论矩的定义计算分布 $F_n$ 的 $k$ 阶原点矩和中心矩，就可以得到 $a_k$ 和 $m_k$ 。
>
> 所以，可以说，**样本矩就是经验分布的矩**。

### Insight of Method of Moments

矩估计法是 K. Pearson在十九世纪末到二十世纪初的一系列文章中引进的。这种方法的思想很简单，即：**用样本矩估计总体分布的理论矩**。

以原点矩估计为例：假设总体分布为 $f(x;\theta_1, \cdots, \theta_k)$ ，则它的原点矩（理论矩）为

$$
\alpha_m=\int_{-\infty}^{+\infty}x^mf(x;\theta_1, \cdots, \theta_k)\mathrm{d}x\quad \Big(或\ \sum_ix_i^m f(x_i;\theta_i, \cdots, \theta_k)\Big)
$$

依赖于 $\theta_1, \cdots, \theta_k$ ；另一方面，当样本大小 $n$ 较大时，$\alpha_m$ 又接近于样本的原点矩（样本矩） $a_m$，于是：

$$
\alpha_m=\alpha_m(\theta_1, \cdots, \theta_k)\approx a_m=\dfrac1n\sum_{i=1}^nX_i^m
$$

取 $m=1,\cdots, k$，并将上式的近似式改成等式，就得到了一个方程组：

$$
\alpha_m(\theta_1, \cdots, \theta_k)= a_m\quad (m=1, \cdots,k)
$$

解该方程组，得到根 $\hat{\theta}_i=\hat{\theta}_i(X_1, \cdots, X_n)\ (i=1,\cdots,k)$，就以 $\hat{\theta}_i$ 作为 $\theta_i$ 的估计 $(i=1,\cdots,k)$。如果要估计的是 $\theta_1, \cdots, \theta_k$ 的某函数 $g(\theta_1, \cdots, \theta_k)$，则用 $\hat{g}=\hat{g}(X_1,\cdots,X_n)=g(\hat{\theta}_1, \cdots, \hat{\theta}_k)$ 去估计它，这样定出的估计量就叫做**矩估计**。



## Maximum Likelihood Estimation

设有总体分布 $f(x;\theta_1, \cdots, \theta_k)$ ，$X_1, \cdots, X_n$ 为自这个总体中抽出的样本，则样本 $(X_1, \cdots, X_n)$ 的分布，即其概率密度函数或概率函数）为

$$
L(x_1, \cdots, x_n;\theta_1, \cdots, \theta_k) = f(x_1;\theta_1, \cdots, \theta_k) f(x_2;\theta_1, \cdots, \theta_k) \cdots  f(x_n;\theta_1, \cdots, \theta_k)
$$

对于函数 $L(x_1, \cdots, x_n;\theta_1, \cdots, \theta_k)$：

若将函数 $L$ 看作 $x_1, \cdots, x_n$ 的函数时，$L$ 是一个概率密度或概率函数。如果：

$$
L(Y_1, \cdots, Y_n; \theta_1, \cdots, \theta_k) \gt L(X_1, \cdots, X_n;\theta_1, \cdots, \theta_k),
$$

则表明在观察时出现 $(Y_1, \cdots, Y_n)$ 这个点的可能性比出现 $X_1, \cdots, X_n$ 这个点的可能性大；反过来看，固定  $X_1, \cdots, X_n$ 而把函数 $L$ 看作 $\theta_1, \cdots, \theta_k$ 的函数时，$L$ 被称为**似然函数（Likelihood function）**，它的大小反映了在观察结果 $(X_1, \cdots, X_n) $ 已知的条件下，$(\theta_1, \cdots, \theta_k)$的各种取值的“似然程度”。在这里，参数  $\theta_1, \cdots, \theta_k$ 有一定的值（虽然未知），并非事件或者随机变量，无概率可言，故改用“似然”这个词。

因此，**极大似然估计法(Maximum likelihood estimation method)**就是用似然程度最大的那个点$$(\theta_1^*,\cdots,\theta_k^*)$$，即满足条件 

$$
L(X_1,\cdots,X_n;\theta_1^*,\cdots,\theta_k^*)=\max \limits_{\theta_1,\cdots,\theta_k} L(X_1,\cdots,X_n;\theta_1,\cdots,\theta_k)\label{eq2}
$$


的$$(\theta_1^*,\cdots,\theta_k^*)$$作为$$(\theta_1,\cdots,\theta_k)$$的估计值，因为在已得样本$$X_1,\cdots,X_n$$的条件下，这个**看起来最像**是真参数值。这个估计$$(\theta_1^*,\cdots,\theta_k^*)$$就叫做$$(\theta_1,\cdots,\theta_k)$$的极大似然估计。

令

$$
\ln L=\sum_{i=1}^n\ln(X_i;\theta_1,\cdots,\theta_l)\label{lnlikelihood}
$$

为了使 $L$ 达到最大，只需要 $\ln L$ 达到最大，故在 $f$ 对 $\theta_1,\cdots,\theta_k$ 存在连续的偏导数时，可建立方程组（称为似然方程组）

$$
\dfrac{\partial \ln L}{\theta_i}=0,\quad (i=1,\cdots,k)\label{eq3}
$$

如果（1）这个方程组有唯一解，（2）又能验证它是一个极大值点，则它必是使 $L$ 达到最大的点，即极大似然估计。

> 在几个常见的重要例子中，这一点不难验证，但是在比较复杂的场合，方程组$\eqref{eq3}$可能：
>
> （1）不止有一组解，求出这些解很费计算，且不容易判定哪一个使 $L$ 达到最大；
>
> （2）有时，函数 $f$ 并不对 $\theta_1,\cdots,\theta_k$ 可导，甚至 $f$ 本身也不连续，这时方程组$\eqref{eq3}$就无法应用，必须回到原始的定义$\eqref{eq2}$，来用数值解法尝试求解函数的全局最大值点（或者找出局部最大值点，进行比较）。



## Bayesian Estimation

对于矩估计、极大似然估计而言，未知参数（待估计参数） $\theta$ 就是一个简单的未知数，在抽样之前，我们对 $\theta$ 没有任何了解，所有的信息都来自于样本。而贝叶斯派则不然，他们的出发点是：**在进行抽样之前，我们已经对 $\theta$ 有了一定的知识，叫做先验知识**。并且，贝叶斯学派进一步要求：这种先验知识必须用 $\theta$ 的某种概率分布表达出来。

贝叶斯派的观点是：在估计未知参数时，应当对该参数的先验知识加以使用，而不是视而不见。这种思想与我们日常处理事物的习惯符合：当我们面临一个问题时，除了考虑当前的情况外，往往还需要注意以前的先例和经验。

那么，当我们没有关于未知参数的先验知识，即先验密度 $h(\theta)$ 怎么办呢？怎样去获得先验密度 $h(\theta)$ 呢？

贝叶斯统计的一个基本要求是：**你必须设法去确定这样一个 $h(\theta)$ ，甚至出于你自己的主观认识也可以（也就是说，可以使用主观概率），这要成为问题中一个必备的要素**。

当确定了先验密度之后，接下来就是得出参数 $\theta$ 的估计。

> 设二维随机变量 $X=(X_1,X_2)$ 有概率密度函数 $f(x_1,x_2)$，$X_2$ 的边缘分布的密度函数 $f_2$ 
>
> $$
> f_2(x_2)=\int^{+\infty}_{-\infty}f(x_1,x_2)\ \mathrm{d}x_1\notag
> $$
>
> 则可以证明
>
> $$
> f(x_1, x_2)=f_2(x_2)f_1(x_1\vert x_2)\label{eq1}
> $$
>
> 上式表明：两个随机变量 $X_1$ 和 $X_2$ 的联合概率密度，等于其中一个变量的概率密度乘以在给定这一变量之下另一个变量的条件概率密度。

假设总体有概率密度 $f(X,\theta)$ ，从这个总体中抽取 $X_1, \cdots, X_n$，则这组样本的密度为 $f(X_1,\theta)\cdots f(X_n,\theta)$，该密度可以视为在给定 $\theta$ 时 $(X_1, \cdots, X_n)$ 的密度，即

$$
f(X_1,\cdots,X_n\vert \theta)=f(X_1,\theta)\cdots f(X_n,\theta)
$$

 则根据式 $\eqref{eq1}$ ，可以得到 $(\theta,X_1, \cdots, X_n)$ 的联合密度为

$$
f(\theta,X_1, \cdots, X_n)=h(\theta)f(X_1,\theta)\cdots f(X_n,\theta)
$$

由此，可以算出 $(X_1, \cdots, X_n)$ 的边缘密度为

$$
p(X_1,\cdots,X_n)=\int h(\theta)f(X_1,\theta)\cdots f(X_n,\theta)\ \mathrm{d}\theta\label{eq4}
$$

积分的范围，要看参数 $\theta$ 的范围而定。之后，在给定 $(X_1, \cdots, X_n)$ 分布的条件下，$\theta$ 的条件密度为

$$
h(\theta\vert X_1,\cdots,X_n)=\dfrac{h(\theta)f(X_1,\theta)\cdots f(X_n,\theta)}{\int h(\theta)f(X_1,\theta)\cdots f(X_n,\theta)\ \mathrm{d}\theta}=h(\theta)f(X_1,\theta)\cdots f(X_n,\theta)/P(X_1,\cdots,X_n)\label{MAP}
$$

按照贝叶斯学派的观点，这个条件密度代表了我们在取得样本 $X_1, \cdots, X_n$ 后对 $\theta$ 的知识，它综合了 $\theta$ 的先验知识（以 $h(\theta)$ 反映）与由样本带来的信息。通常我们把式称为 $\theta$ 的后验密度，因为它是在做了试验后取得的。

在得出后验分布式$\eqref{MAP}$后，对参数 $\theta$ 的任何统计推断都只能基于这个后验分布。至于具体如何使用它，可以结合某种准则一起去进行，统计学家也有一定的自由度。对于此处的点估计问题，一个常用的方法是：取后验分布式$\eqref{MAP}$的均值作为$\theta$的估计。

注：按照上文所述，$h(\theta)$ 必须是一个密度函数，即必须满足 $h(\theta)\ge 0$，$\int h(\theta)\mathrm{d}\theta = 1$ 两个条件。但在某些情况下，$h(\theta)\ge 0$，但$\int h(\theta)\ \mathrm{d}\theta$ 不为1，甚至为 $\infty$ ，不过积分式$\eqref{eq4}$仍然有限，这时，由$\eqref{MAP}$定义的 $h(\theta\vert X_1,\cdots,X_n)$ 作为 $\theta$ 的函数，仍满足密度函数的条件。也就是说，即使是这样的 $h(\theta)$ 取为先验函数也无妨。当然，由于 $\int h(\theta)\ \mathrm{d}\theta$ 不为1，它也失去了密度函数的通常的概率意义。这样的 $h(\theta)$ 通常称为**广义先验密度**。
{: .notice--warning}

<br>

# Examples

## Normal Distribution

设 $X_1,\cdots,X_n$ 是从正态总体 $N(\mu,\sigma^2)$ 中抽出的样本，估计 $\mu$ 和 $\sigma^2$ 。

### Method of Moments

$\mu$ 是总体的一阶原点矩，可用一阶样本原点矩$a_1$，即样本均值 $\overline{X}$ 估计；$\sigma^2$ 总体方差 ，即总体的二阶中心矩，可用样本的二阶中心矩 $m_2$ 去估计。但是一般在估计方差的时候，经常用样本方差 $S^2$，而不用$m_2$ ，即**对矩估计做了一定的修正，这是因为样本方差具有无偏性**。

因此可以得到 $\mu$ 和 $\sigma^2$ 的估计量分别为：

$$
\begin{align*}
&\hat{\mu}=\overline{X}=\dfrac1n\sum_{i=1}^n X_i\\
&\hat{\sigma^2}=S^2=\dfrac1{n-1}\sum_{i=1}^n(\overline{X}-X_i)^2
\end{align*}
$$

解上述方程组，写成 $\hat{\theta}_i=\hat{\theta}_i(X_1,\cdots,X_n)$ 的形式 ，可以得到：

$$
\begin{align*}
&\hat{\mu}=\overline{X}=\dfrac1n\sum_{i=1}^n X_i\\
&\hat{\sigma^2}=S^2=\dfrac1{n-1}\sum_{i=1}^n\big[(\dfrac1n\sum_{j=1}^n X_j)-X_i\big]^2
\end{align*}
$$

假如要估计的是总体的标准差 $\sigma$ （即要估计一个总体参数的函数），则由 $\sigma=\sqrt{\sigma^2}$ ，按照矩估计法，可以用 $\sqrt{m_2}$ 来估计，但是和上面一样，我们一般用  $\sqrt{S^2}=S$ 去估计，或者**还做点修正**。假如要估计总体的变异系数 $\sigma/\mu$（变异系数是以均值为单位去衡量总体的标准差），则使用矩估计法可用 $\sqrt{m_2}/\overline{X}$ ，一般用 $S/\overline{X}$ 。
{: .notice--primary}

### MLE

根据MLE法，可以得到 $\log$ 似然函数为：

$$
\begin{align}
\ln\ L&=\ln \prod_{i=1}^n\Big[(\sqrt{2\pi\sigma^2})^{-1}\exp \big( -\dfrac{(X_i-\mu)^2}{2\sigma^2}\big)\Big]\notag \\
&=-\dfrac{n}{2}\ln(2\pi\sigma^2)-\dfrac1{2\sigma^2}\sum_{i=1}^n(X_i-\mu)^2 \label{normlnlikelihood}
\end{align}
$$

于是可以得到方程组

$$
\left\{  
\begin{split} &\dfrac{\partial \ln L}{\partial \mu}=\dfrac{1}{\sigma^2}\sum_{i=1}^n(X_i-\mu)=0\notag \\ 
&\dfrac{\partial \ln L}{\partial \sigma^2}=-\dfrac{n}{2\sigma^2}+\dfrac1{2\sigma^4}\sum_{i=1}^n(X_i-\mu)^2=0 
\end{split}\label{MLEsystem1}
\right.
$$

解上述方程组，写成 $\hat{\theta}_i=\hat{\theta}_i(X_1,\cdots,X_n)$ 的形式，可以得到：

$$
\begin{align*}
&\hat{\mu}=\dfrac1n\sum_{i=1}^n X_i\\
&\hat{\sigma^2}=\dfrac1n\sum_{i=1}^n\Big[X_i-\big(\dfrac1n\sum^{n}_{j=1}X_j \big) \Big]^2
\end{align*}
$$

接下来，还需要证明，我们找到的$$(\hat{\mu},\hat{\sigma^2})$$就是$$\log$$似然函数 $$\eqref{normlnlikelihood}$$的最大值。

首先，方程组$$\eqref{MLEsystem1}$$中的两个方程并不具备线性关系，因此该方程组只有唯一的根$$(\mu^*, {\sigma^*}^2)$$。又由表达式$$\eqref{normlnlikelihood}$$可知，当$$\vert \mu \vert \rightarrow \infty$$ 或 $$\sigma^2 \rightarrow 0$$时，$$\ln L\rightarrow -\infty$$，$$L\rightarrow 0$$，而作为似然度函数$$L>0$$总成立，因此，$$(\mu^*, {\sigma^*}^2)$$不可能是极小值点，必然是极大值点。作为唯一的一个极大值点，必然是最大值点。QED。

### MAP

假设样本来自正态总体 $N(\theta, 1)$ ，且 $\theta$ 的先验分布为 $N(\mu, \sigma^2)$ ，求 $\theta$ 的贝叶斯估计。

根据已知条件可以知道，总体的分布为

$$
f(x,\theta)=(\sqrt{2\pi})^{-1}\exp \Big[-\dfrac12(x-\theta)^2\Big]
$$

$\theta$ 的先验分布为

$$
h(\theta)=(\sqrt{2\pi}\sigma)^{-1}\exp \Big[-\dfrac1{2\sigma^2}(x-\mu)^2\Big]
$$

则根据公式 $\eqref{MAP}$ ，有

$$
\begin{align}
h(\theta\vert X_1,\cdots,X_n)&=\dfrac{h(\theta)f(X_1,\theta)\cdots f(X_n,\theta)}{\int h(\theta)f(X_1,\theta)\cdots f(X_n,\theta)\ \mathrm{d}\theta}\notag \\
&=\exp\Big[-\dfrac1{2\sigma^2}(\theta-\mu)^2-\dfrac12\sum_{i=1}^n(X_i-\theta)^2 \Big]/I\label{eq6}
\end{align}
$$

$I$ 作为一个整体，与 $\theta$ 无关。

在公式 $\eqref{eq6}$ 中，可以计算出

$$
-\dfrac1{2\sigma^2}(\theta-\mu)^2-\dfrac12\sum_{i=1}^n(X_i-\theta)^2=-\dfrac1{2\eta^2}(\theta-t)^2+J\notag
$$

其中

$$
\begin{align*}
t&=\Big(n\overline{X}+\mu/\sigma^2\Big)/(n+1/\sigma^2)\\
\eta^2&=1/(n+1/\sigma^2)
\end{align*}
$$

而 $J$ 与 $\theta$ 无关。

于是，公式 $\eqref{eq6}$ 可以进一步简化为

$$
h(\theta\vert X_1,\cdots,X_n)=I_1\exp\Big[-\dfrac1{2\eta^2}(\theta-t)^2 \Big]\notag
$$

由于 $h(\theta\vert X_1,\cdots,X_n)$ 是一个概率密度函数，则它一定满足

$$
\int_{-\infty}^{+\infty}h(\theta\vert X_1,\cdots,X_n)\mathrm{d}\theta = 1\notag
$$

因此一定有 $I_1=(\sqrt{2\pi}\eta)^{-1}$ ，$\theta$ 的后验分布同样是一个后验分布 $\tilde{\theta} \sim N(t,\eta^2)$ ，其均值 $t$ 就是 $\theta$ 的贝叶斯估计 $\tilde{\theta}$ 

$$
\tilde{\theta}=t=\dfrac{n}{n+1/\sigma^2}\overline{X}+\dfrac{1/\sigma^2}{n+1/\sigma^2}\mu\label{eq5}
$$

$\tilde{\theta}$ 的表达式 $\eqref{eq5}$ 传达出这样的信息：考虑两种极端情况，

（1）假如我们只有样本信息而毫无先验信息，则 $\sigma^2\rightarrow \infty$ ，此时 $\tilde{\theta}=\overline{X}$ ，这和 $\theta$ 矩估计和极大似然估计法的结果是一致的；

（2）加入我们只有先验信息，而毫无样本信息，则 $n\rightarrow 0$ ，则 $\tilde{\theta}=\mu$，即用先验分布的均值 $\mu$ 去作为 $\theta$ 的估计；

因此，从式 $\eqref{eq5}$ 可以看出，当先验信息和样本信息都存在时， $\theta$ 的估计为二者的折衷。从形式上看，式 $\eqref{eq5}$ 上述两种极端情况的下估计 $\overline{X}$ 和 $\mu$ 的加权平均，权重之比为 $n:(1/\sigma^2)$ 。这个比值很合理：样本数目 $n$ 越大，表示样本信息越多，$\overline{X}$ 的权就越大；另一方面，$\sigma^2$ 越大，表示先验信息越不确定，$\sigma^2$ 越小，表示根据已有的先验信息，已经有很大的把握肯定 $\theta$ 就在 $\mu$ 附近不远处，因此，$\mu$ 的权重与 $\sigma^2$ 成反比。

<br>

**References**

[1] 概率论与数理统计. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.2(2019.8重印).