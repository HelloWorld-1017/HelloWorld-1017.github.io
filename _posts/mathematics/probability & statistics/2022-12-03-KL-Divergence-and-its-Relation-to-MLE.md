---
layout: single
title: KL Divergence and its Relation to MLE
date: 2022-12-03 21:33:21 +0800
categories: 
 - Mathematics
 - Machine Learning
tags:
 - Probability Theory and Mathematical Statistics
---

# Introduction

在mathematical statistics领域，Kullback–Leibler divergence(KL divergence)，也称为relative entropy和I-divergence，表示为$D_{\mathrm{KL}}(P\vert\vert Q)$是一种statistical distance，用于度量一种概率分布$P$和**参考概率分布$Q$**之间的差异程度。尽管KL divergence是一种distance，但是它并不是metric，应为它对于两个分布而言，并不是symmetric，并且不满足triangle inequality。

从information geometry的角度看，KL divergence是一种divergence，是squared distance的推广，对于某些分布(尤其是exponential family)，KL divergence满足[Pythagorean theorem](https://en.wikipedia.org/wiki/Pythagorean_theorem)(勾股定理)。

关于两个分布的KL divergence是非负的，KL divergence为0表示两个分布有着相同的信息量。KL divergence有着广泛的应用，从理论角度，它表征信息系统的relative (Shannon) entropy，表示连续时间序列的randomness，比较统计推断模型的information gain；从实践的角度，它广泛应用于应用统计学，流体力学，神经科学和生物信息学中。

<br>

# Definition

## For discrete probability distributions

对于离散型概率分布，在同一个概率空间$\mathscr{x}$中，从概率分布$P$到$Q$的KL divergence定义为：

$$
D_{\mathrm{KL}}(P\vert\vert Q)=\sum_{x\in\mathscr{x}}P(x)\log\Big(\dfrac{P(x)}{Q(x)}\Big)
$$

等价于：

$$
D_{\mathrm{KL}}(P\vert\vert Q)=-\sum_{x\in\mathscr{x}}P(x)\log\Big(\dfrac{Q(x)}{P(x)}\Big)
$$

换句话说，KL divergence是概率分布$P$和$Q$关于分布$P$的期望的对数差。

当$Q(x)=0$时，仅当$Q(x)=0$且意味着$P(x)=0$时，该定义才成立，此时KL divergence定义为0。有的地方也将此时的KL divergence定义为$+\infty$，但是当概率空间$\mathscr{x}$无限时，即使$Q(x)\ne0$处处都不成立，也有可能出现KL divergence为$+\infty$的情况。

当$P(x)=0$时，KL divergence的值为0，因为

$$
\lim_{x\rightarrow0^+}x\log x=0
$$


## For continuous probability distributions

对于连续型分布$P$和$Q$，KL divergence定义为积分：

$$
D_{\mathrm{KL}}(P\vert\vert Q)=\int_{-\infty}^{+\infty}p(x)\log\Big(\dfrac{p(x)}{q(x)}\Big)\mathrm{d}x
$$

其中，$p(x)$和$q(x)$分别表示分布$P$和$Q$的概率密度。

## For measurable space

更一般的情况，当$P$和$Q$是measurable space$\mathscr{x}$的**probability measures(概率测度)**，并且$P$关于$Q$是absolutely continuous时，则从$Q$到$P$的KL divergence定义为：

$$
D_{\mathrm{KL}}(P\vert\vert Q)=\int_{\mathscr{x}}\log\Big(\dfrac{P(\mathrm{d}x)}{Q(\mathrm{d}x)}\Big)P(\mathrm{d}x)
$$

其中，$\dfrac{P(\mathrm{d}x)}{Q(\mathrm{d}x)}$是$P$关于$Q$的Radon-Nikodym derivative。

并且，如果我们假设右端项的表达式存在，则根据链式法则，我们可以得到等价定义：

$$
D_{\mathrm{KL}}(P\vert\vert Q)=\int_{\mathscr{x}}\dfrac{P(\mathrm{d}x)}{Q(\mathrm{d}x)}\log\Big(\dfrac{P(\mathrm{d}x)}{Q(\mathrm{d}x)}\Big)Q(\mathrm{d}x)
$$

# Relation to MLE

概率分布参数$\hat{\theta}$的MLE估计，渐进等价于(asymptotically equivalent)：找到由$\hat{\theta}$定义地概率分布$Q_{\hat{\theta}}$，使得和真实的概率分布(产生数据的概率分布$P_{\theta_0}$)具有最小的KL divergence。在理想状态下，$P$和$Q$的概率分布相同，唯一未知的是定义$P$的$\theta$，但是即使他们是不同的，并且我们假设的模型是错误的，MLE仍然会在模型$Q$中找到和真实的分布$P_{\theta_0}$“最接近”的分布。

证明：

为了简便起见，我们假设概率分布$P$和$Q$相同。从分布$P_{\theta_0}$中抽取$n$个独立同分布的样本$y=(y_1,y_2,\cdots,y_n)$，之后我们进行MLE估计：

$$
\begin{split}
\hat{\theta}&=\arg\max_{\theta}\sum_{i=1}^n\log P(y_i\vert\theta)\\
&=\arg\max_{\theta}\Big(\sum_{i=1}^n\log P(y_i\vert\theta)-\sum_{i=1}^n\log P(y_i\vert\theta_0)\Big)\\
&=\arg\max_{\theta}\sum_{i=1}^n\Big(\log P(y_i\vert\theta)-\log P(y_i\vert\theta_0)\Big)\\
&=\arg\max_{\theta}\sum_{i=1}^n\Big(\log \dfrac{P(y_i\vert\theta)}{ P(y_i\vert\theta_0)}\Big)\\
&=\arg\min_{\theta}\sum_{i=1}^n\Big(\log \dfrac{P(y_i\vert\theta_0)}{ P(y_i\vert\theta)}\Big)\\
&=\arg\min_{\theta}\dfrac1n\sum_{i=1}^nh_\theta(y_i)\\
\end{split}
$$

当$n\rightarrow\infty$时，有：

$$
\arg\min_{\theta}\dfrac1n\sum_{i=1}^nh_\theta(y_i)\rightarrow\arg\min_{\theta}\mathrm{E}[h_\theta(y)]
$$

进一步有：

$$
\begin{split}
\arg\min_{\theta}\mathrm{E}[h_\theta(y)]&=\arg\min_{\theta}\int P_{\theta_0}(y)h_\theta(y)\mathrm{d}y\\
&=\arg\min_{\theta}\int P_{\theta_0}(y)\log\dfrac{P(y\vert\theta_0)}{P(y\vert\theta)}\mathrm{d}y\\
&=\arg\min_\theta D_{\mathrm{KL}}(P_{\theta_0}\vert\vert P_\theta)
\end{split}
$$

在推导的过程中，使用了$h_\theta(x)=\log \dfrac{P(x\vert\theta_0)}{P(x\vert\theta)}$，记号$h$的使用，能够更清楚地展示如何使用[law of large numbers](https://en.wikipedia.org/wiki/Law_of_large_numbers)和[law of the unconscious statistician](https://en.wikipedia.org/wiki/Law_of_the_unconscious_statistician)将$h(x)$的均值转换为它的期望。

<br>

**Reference**

[1] [Kullback–Leibler divergence - Wikipedia](https://en.wikipedia.org/wiki/Kullback%E2%80%93Leibler_divergence).

[2] [Maximum likelihood estimation § Relation to minimizing Kullback–Leibler divergence and cross entropy - Wikipedia](https://en.wikipedia.org/wiki/Maximum_likelihood_estimation#Relation_to_minimizing_Kullback–Leibler_divergence_and_cross_entropy).

