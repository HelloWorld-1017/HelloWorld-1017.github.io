---
layout: single
title: Fisher Information
date: 2022-10-30 17:32:31 +0800
categories: 
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
---

# What is Fisher Information?

假设一个样本$X$服从只有一个参数$\theta$的分布$f(\theta)$，我们可以得到log似然函数：

$$
L(\theta;x)=\mathrm{log}\ f(\theta;x)
$$

该log似然函数对$\theta$的导数：

$$
\dfrac{\partial L(\theta;x)}{\partial\theta}=\dfrac{\partial\ \mathrm{log}\ f(\theta;x)}{\partial\ \theta}
$$

称为score(the partial derivative with respect to $\theta$ of the natural logarithm of the likelihood function is called the score)。

通常我们令score等于零，以得到参数$\theta$的一个极大似然估计：

$$
\begin{split}
&\dfrac{\partial L(\theta;x)}{\partial\theta}=0
\Rightarrow&\ \hat{\theta}_{\mathrm{MLE}}
\end{split}
$$

但是，如何知道统计量$\hat{\theta}_{\mathrm{MLE}}$估计的准确度如何呢？似然函数在最大值附近的曲率(curvature)就提供给了我们信息。首先，一定要清楚，log似然函数是关于参数$\theta$的函数，于是从直觉上很容易理解，如果log似然函数在最大值附近是peaked，那么我们对MLE估计就很有把握；而如果其在最大值附近是flat，那么我们就不那么确定。从概率论的角度讲，**我们需要知道score附近的方差是多少**。

首先可以证明，score的期望是0：

$$
E\Big[\dfrac{\partial L(\theta;x)}{\partial\theta}\Big]=0
$$

这个式子好像是在表明无偏性。
{: .notice}


> 证明(note: non-rigorous exposition)：
>
> 假设样本所服从分布的PDF为$p(x;\theta)$，则有：
> 
> $$
> \int p(x;\theta)\mathrm{d}x=1
> $$
> 
> 上式两边对$\theta$求导，有：
> 
> $$
> \dfrac{\partial}{\partial\theta}\int p(x;\theta)\mathrm{d}x=0
> $$
> 
> 上式的左边有：
> 
> $$
> \begin{split}
> \mathrm{left}&=\dfrac{\partial}{\partial\theta}\int p(x;\theta)\mathrm{d}x\\
> &=\int \dfrac{\partial}{\partial\theta}p(x;\theta)\mathrm{d}x\\
> &=\int \dfrac{\frac{\partial p(x;\theta)}{\partial\theta}}{p(x;\theta)}p(x;\theta)\mathrm{d}x\\
> &=\int \frac{\partial\log p(x;\theta)}{\partial\theta}p(x;\theta)\mathrm{d}x\\
> &=E\Big[\dfrac{\partial L(\theta;x)}{\partial\theta}\Big]
> \end{split}
> $$
> 
> （上述过程中，将积分号和偏导符号调换计算顺序的操作应该是需要满足某种条件的，这里没有提及）
>
> 于是，可以得到：
> 
> $$
> E\Big[\dfrac{\partial L(\theta;x)}{\partial\theta}\Big]=0
> $$

即：

$$
\begin{split}
\int \frac{\partial\log p(\theta;x)}{\partial\theta}p(x;\theta)\mathrm{d}x=0
\end{split}
$$

上式两边对$\theta$求偏导：

$$
\begin{split}
&\dfrac{\partial}{\partial \theta}\int \frac{\partial L(\theta;x)}{\partial\theta}p(x;\theta)\mathrm{d}x=0\\
\Rightarrow&\int\dfrac{\partial}{\partial\theta}\Big(\frac{\partial L(\theta;x)}{\partial\theta}p(x;\theta)\mathrm{d}x\Big)=0\\
\Rightarrow&\int\dfrac{\partial^2 L(\theta;x)}{\partial\theta^2}p(x;\theta)\mathrm{d}x
+\int\dfrac{\partial L(\theta;x)}{\partial\theta}\dfrac{\partial p(x;\theta)}{\partial\theta}\mathrm{d}x=0\\
\end{split}
$$

上式左端的第二项可以化为：

$$
\begin{split}
\int\dfrac{\partial L(\theta;x)}{\partial\theta}\dfrac{\partial p(x;\theta)}{\partial\theta}\mathrm{d}x
&=\int\dfrac{\partial L(x;\theta)}{\partial\theta}\dfrac{\dfrac{\partial p(x;\theta)}{\partial\theta}}{p(x;\theta)}p(x;\theta)\mathrm{d}x\\
&=\int\Big(\dfrac{\partial L(x;\theta)}{\partial\theta}\Big)^2p(x;\theta)\mathrm{d}x\\
&=\mathrm{Var}\Big[\dfrac{\partial L(\theta;x)}{\partial\theta}\Big]
\end{split}
$$

于是可以得到：

$$
\begin{split}
\mathrm{Var}\Big[\dfrac{\partial L(\theta;x)}{\partial\theta}\Big]
&=-\int\dfrac{\partial^2 L(\theta;x)}{\partial\theta^2}p(x;\theta)\mathrm{d}x\\
&=-E\Big[\dfrac{\partial^2 L(\theta;x)}{\partial\theta^2}\Big]
\end{split}\label{eq1}
$$

也就是说“score附近的方差”可以使用$-E\Big[\dfrac{\partial^2 L(\theta;x )}{\partial\theta^2}\Big]$来描述，这个值就称为Fisher information，定义为：

$$
I(\theta)=E\Big[-\dfrac{\partial^2}{\partial\theta^2}L(\theta;x)\Big]
$$

因此，Fisher information就描述了似然函数的不确定度(uncertainty, ie curvature)。从式$\eqref{eq1}$也可以看出，Fisher Information一定是非负的。

<br>

# Fisher Information for 1-dimension Normal Distribution

对于一维正态函数，我们用估计它的均值$\mu$(仍然考虑单个样本的情况)，则有：

$$
p(\mu;x)=\dfrac1{\sqrt{2\pi}\sigma}\exp(-\frac1{2\sigma^2}(x-\mu)^2)
$$

$$
L(\mu;x)=-\dfrac{1}{2}\log(2\pi\sigma^2)-\dfrac1{2\sigma^2}(x-\mu)^2
$$

$$
\dfrac{\partial}{\partial \mu}L(\mu;x)=\dfrac{1}{\sigma^2}(x-\mu)
$$

$$
\dfrac{\partial^2}{\partial \mu^2}L(\mu;x)=-\dfrac{1}{\sigma^2}\label{eq2}
$$

于是，可以得到Fisher information：

$$
I(\mu)=E\Big[-\dfrac{\partial^2}{\partial \mu^2}L(\mu;x)\Big]=\dfrac{1}{\sigma^2}
$$

这表明，单个样本的Fisher information取决于总体分布的方差$\sigma^2$，当方差越大，单个样本所提供的信息就越少，我们的估计就越不精确。

同样地，如果我们估计它的方差$\sigma^2$，则可以得到：

$$
\dfrac{\partial}{\partial \sigma^2}L(\sigma^2;x)=-\dfrac{1}{2}(\sigma^2)^{-1}+\dfrac12(x-\mu)^2(\sigma^2)^{-2}
$$

$$
\dfrac{\partial^2}{\partial (\sigma^2)^2}L(\sigma^2;x)=\dfrac12(\sigma^2)^{-2}-(x-\mu)^2(\sigma^2)^{-3}
$$

Fisher information为：

$$
\begin{split}
I(\sigma^2)&=E\Big[-\dfrac{\partial^2}{\partial (\sigma^2)^2}L(\sigma^2;x)\Big]\\
&=E\Big[(x-\mu)^2(\sigma^2)^{-3}-\dfrac12(\sigma^2)^{-2}\Big]\\
&=(\sigma^2)^{-2}-\dfrac12(\sigma^2)^{-2}\\
&=\dfrac1{2(\sigma^2)^2}
\end{split}\label{eq3}
$$

<br>

# Some Questions

- 从上面的推导过程中可以看出，Fisher信息似乎是针对MLE估计方法的(这一点我不是很确定，理解有些少)，那么针对其他方式，比如说矩估计和最大后验估计，能否使用Fisher信息呢？
- Fisher信息的大小，实际上仅仅取决于我们假定的总体分布是怎样的，与我们选择的估计统计量是没有关系的，既然如此，那么Fisher信息是如何出现在Cramér–Rao bound中的呢？
- 观察式$\eqref{eq2}$和$\eqref{eq3}$，如果总体分布$\sigma^2$未知，那么我们如何去计算Fisher信息呢？Fisher信息是不是只是用于定性描述呢？

<br>

**Reference**

[1] [Intuitive explanation of a definition of the Fisher information - StackExchange](https://math.stackexchange.com/questions/265917/intuitive-explanation-of-a-definition-of-the-fisher-information)

[2] [Fisher information - Wikipedia](https://en.wikipedia.org/wiki/Fisher_information).

