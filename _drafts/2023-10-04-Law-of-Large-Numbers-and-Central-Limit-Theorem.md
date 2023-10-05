---
layout: single
title: Law of Large Numbers (LLN) and Central Limit Theorem
date: 2023-10-04 19:45:38 +0800
categories:
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
---

# Law of Large Numbers

## The weak form of large numbers (Khinchin's law)

If $X_1,\ X_2,\cdots,X_n,\cdots$  is an infinite sequence of independent and identically distributed (i.i.d.) Lebesgue integrable random variables with expected value $\mathbb{E}(X_1)=\mathbb{E}(X_2)=\cdots=\mu$, and variance $\sigma^2$, the **weak law of large numbers** (also called **Khinchin's law**) states that the sample average:
$$
\bar{X}_n=\dfrac1n(X_1+X_2+\cdots+X_n)
$$
converges in probability towards the expected value:
$$
\bar{X}_n\xrightarrow{P}\mu,\ \text{when n}\rightarrow\infty
$$
That is, for any positive number $\varepsilon$:


$$
\lim_{n\rightarrow\infty}\mathrm{Pr}\Big(\vert\bar{X}_n-\mu\vert<\varepsilon\Big)=1
$$

Or rather:
$$
\lim_{n\rightarrow\infty}\mathrm{Pr}\Big(\vert\bar{X}_n-\mu\vert\ge\varepsilon\Big)=0
$$
Interpreting this result, the weak law states that for any nonzero margin specified $\varepsilon$, no matter how small, with a sufficiently large sample there will be a very high probability that the average of the observations will be close to the expected value; that is, within the margin.

<br>





<br>

**References**

[Law of large numbers - Wikipedia](https://en.wikipedia.org/wiki/Law_of_large_numbers).

[Central limit theorem - Wikipedia](https://en.wikipedia.org/wiki/Central_limit_theorem).

