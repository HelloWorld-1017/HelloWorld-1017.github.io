---
layout: single
title: Markov's Inequality and Chebyshev's Inequality
date: 2023-10-05 20:22:09 +0800
categories:
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
---

# Markov's inequality

In probability theory, Markov's inequality gives <u>an upper bound</u> for the probability that a <u>non-negative</u> function of a random variable is greater than or equal to some positive constant [1]. 

Provided that $X$ is a nonnegative random variable and $\varepsilon > 0$, then the probability that $X$ is at least  $\varepsilon$ is at most the expectation of $X$ divided by $\varepsilon$:

$$
P(X\ge\varepsilon)\le\mathbb{E}(X)/\varepsilon \label{Markov}
$$

Inequality $\eqref{Markov}$ is **Markov's inequality**, and proof of which is described as follows.

We suppose that $X$ is continuous random variable and whose PDF is $f(x)$. Then, $f(x)=0$ if $x<0$ as $X$ is nonnegative. Thus:

$$
\mathbb{E}(X)=\int_0^\infty xf(x)\mathrm{d}x\ge\int_\varepsilon^\infty xf(x)\mathrm{d}x
$$

On the other hand, in the integral interval $x\in[\varepsilon,\infty)$, the $\varepsilon\le x$ always holds [2], thus:

$$
\mathbb{E}(X)\ge\int_\varepsilon^\infty xf(x)\mathrm{d}x\ge\int_\varepsilon^\infty\varepsilon f(x)\mathrm{d}x=\varepsilon P(X\ge\varepsilon)
$$

i.e., 

$$
\mathbb{E}(X)\ge\varepsilon P(X\ge\varepsilon)\Rightarrow P(X\ge\varepsilon)\le\mathbb{E}(X)/\varepsilon
$$


Q.E.D.  The similar derivation could be applied for discrete probability distribution as well.

<br>

# Chebyshev's inequality

In Markov's inequality $\eqref{Markov}$, we could construct another random variable $Y=(X-\mathbb{E}(X))^2$ and replace $\varepsilon$ with $\varepsilon^2$, and then we have:

$$
\begin{split}
&P((X-\mathbb{E}(X))^2\ge\varepsilon^2)\le\mathbb{E}((X-\mathbb{E}(X))^2)/\varepsilon^2\\
\Rightarrow&P(\vert X-\mathbb{E}(X)\vert\ge\varepsilon)\le(\mathbb{E}(X^2)-\mathbb{E}(X)^2)/\varepsilon^2
\end{split}
$$

Let $\mu$ denote $\mathbb{E}(X)$, and **in the case where $\mathrm{Var}(X)=\sigma^2$ does exist**, then:

$$
P(\vert X-\mu\vert\ge\varepsilon)\le\sigma^2/\varepsilon^2\label{Chebyshev}
$$

Inequality $\eqref{Chebyshev}$ is **Chebyshev's inequality**, and equivalent to:

$$
P(\vert X-\mu\vert\ge k\varepsilon)\le\sigma^2/k^2\varepsilon^2
$$

which guarantees that, "for a wide class of probability distributions, no more than a certain fraction of values can be more than a certain distance from the mean." [3]

Chebyshev's inequality could be "be applied to completely arbitrary distributions provided they have a known finite mean and variance, the inequality generally gives a poor bound compared to what might be deduced if more aspects are known about the distribution involved." [3]

<br>

**References**

[1] [Markov's inequality - Wikipedia](https://en.wikipedia.org/wiki/Markov's_inequality).

[2] [马尔可夫不等式的证明过程(在连续型随机变量条件下的证明) - bilibili](https://www.bilibili.com/video/BV1HT4y177YN/?vd_source=8aeddead7f39b0189fff9b14fa090a75).

[3] [Chebyshev's inequality - Wikipedia](https://en.wikipedia.org/wiki/Chebyshev's_inequality).

[4] 概率论与数理统计. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.2(2019.8重印), p132.