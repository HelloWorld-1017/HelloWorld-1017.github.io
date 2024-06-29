---
layout: single
title: Law of Large Numbers (LLN)
date: 2023-10-10 10:42:47 +0800
categories:
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
---

# The weak form of large numbers (Khinchin's law) 

If $X_1,\ X_2,\cdots,X_n,\cdots$  is an infinite sequence of independent and identically distributed (i.i.d.) Lebesgue integrable random variables with expected value $\mathbb{E}(X_1)=\mathbb{E}(X_2)=\cdots=\mu$, and variance <u>exist</u> and denoted as $\sigma^2$, the **weak law of large numbers** (also called **Khinchin's law**) states that the sample mean [1,2]:

$$
\bar{X}_n=\dfrac1n(X_1+X_2+\cdots+X_n)
$$

converges in probability towards the expected value:

$$
\bar{X}_n\xrightarrow{P}\mu,\ \text{when n}\rightarrow\infty
$$

That is, for any positive number $\varepsilon$, have:


$$
\lim_{n\rightarrow\infty}\mathrm{Pr}\Big(\vert\bar{X}_n-\mu\vert<\varepsilon\Big)=1
$$

Or rather:

$$
\lim_{n\rightarrow\infty}\mathrm{Pr}\Big(\vert\bar{X}_n-\mu\vert\ge\varepsilon\Big)=0\label{eq1}
$$

The weak law states that for any nonzero margin specified $\varepsilon$, no matter how small, with a sufficiently large sample there will be a very high probability that the average of the observations will be close to the expected value; that is, within the margin.

> Proof for equation $\eqref{eq1}$:
>
> According to Chebyshev’s inequality [2]:
> 
> $$
> \mathrm{Pr}(\vert\bar{X}_n-\mathbb{E}(\bar{X}_n)\vert\ge\varepsilon)\le\mathrm{Var}(\bar{X}_n)/\varepsilon^2\label{Chebyshev}
> $$
> 
> On the other hand, 
> 
> $$
> \mathbb{E}(\bar{X}_n)=\sum\mathbb{E}(X_i)/n=\mu
> $$
>
> $$
> \mathrm{Var}(\bar{X}_n)=\dfrac1{n^2}\sum\mathrm{Var}(X_i)=\dfrac1{n^2}n\sigma^2=\dfrac1n\sigma^2
> $$
>
> Cause $X_1,\ X_2,\cdots,X_n,\cdots$ are independent.
> {: .notice--primary}
>
> Inequality $\eqref{Chebyshev}$ could be deduced to:
> 
> $$
> \mathrm{Pr}(\vert\bar{X}_n-\mu\vert\ge\varepsilon)\le\sigma^2/(n\varepsilon^2)
> $$
> 
> when $n\rightarrow\infty$:
> 
> $$
> \lim_{n\rightarrow\infty}\mathrm{Pr}(\vert\bar{X}_n-\mu\vert\ge\varepsilon)=0
> $$
> 
> Q.E.D.

when the $X_i$ is viewed as a result of whether or not a certain event $A$ happens in a series repeated independent experiment (i.e., Bernoulli trial), thus $\bar{X}_n=\dfrac1n(X_1+X_2+\cdots+X_n)$ is called the **frequency**, and denoted as $p_n$. As a results, a special case could be derived from equation $\eqref{eq1}$, that is:

$$
\lim_{n\rightarrow\infty}\mathrm{Pr}\Big(\vert p_n-p\vert\ge\varepsilon\Big)=0 \label{Bernoulli}
$$

meaning that "**the frequency converges in probability**". The theorem $\eqref{Bernoulli}$ is the most early law of large number, which is proved by Bernoulli in his book in 1713, and thereby often called **Bernoulli’s law of large numbers** [2, p133].

<br>

# The strong form of large numbers (Kolmogorov’s law)

The **strong law of large numbers** (AKA **Kolmogorov's law**) states that the sample mean <u>converges almost surely</u> to the expected value [1]:

$$
\bar{X}_n\xrightarrow{\text{a.s.}}\mu,\quad \text{when }n\rightarrow\infty\label{strongLLN}
$$

i.e.,

$$
\mathrm{P_r}\Big(\lim_{n\rightarrow\infty}\bar{X}_n=\mu\Big)=1
$$

meaning that the probability that, as the number of trials $n$ goes to infinity, the average of the observations converges to the expected value, is equal to one. The strong law of large numbers can itself be seen as a special case of the [pointwise ergodic theorem](https://en.wikipedia.org/wiki/Ergodic_theory#Ergodic_theorems) [1]. 

Theorem $\eqref{strongLLN}$ is called the strong law because random variables which converge strongly (almost surely) are guaranteed to converge weakly (in probability). **However, the weak law is known to hold in certain conditions where the strong law does not hold and then the convergence is only weak (in probability)** [1]. 

The strong law applies to <u>independent identically distributed random variables</u> having an expected value (like the weak law). This was proved by Kolmogorov in 1930. It can also apply in other cases. Kolmogorov also showed, in 1933, that if the variables are independent and identically distributed, then for the average to converge almost surely on *something* (this can be considered another statement of the strong law), it is necessary that they have an expected value (and then of course the average will converge almost surely on that) [1]. 

If the summands are independent but not identically distributed, and provided that each $X_i$ has a finite second moment and:

$$
\sum_{k=1}^\infty\dfrac1{k^2}\mathrm{Var}[X_k]<\infty,
$$

then:

$$
\bar{X}_n-\mathbb{E}[\bar{X}_n]\xrightarrow{\text{a.s.}}0.
$$

<br>

# Conclusion

Actually, the research to law of large number could date back to a long history ago, and still active nowadays. Among which, there exist many valuable and profound results. For instance, equation $\eqref{eq1}$ also could be proved to be right without the assumption that the variance of $X_i$ exists; the $X_1,\ X_2,\cdots,X_n,\cdots$ do not have to be supposed as identically distributed samples, and even not have to be supposed as independent ones (under more restriction of course); the "converge" trend could be replaced by other more strong form, and etc [2, p133]. 

<br>

**References**

[1] [Law of large numbers - Wikipedia](https://en.wikipedia.org/wiki/Law_of_large_numbers).

[2] 概率论与数理统计. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.2(2019.8重印).

[3] [Markov’s Inequality and Chebyshev’s Inequality - What a starry night~](https://helloworld-1017.github.io/mathematics/Markovs-Inequality-and-Chebyshevs-Inequality/#chebyshevs-inequality).

