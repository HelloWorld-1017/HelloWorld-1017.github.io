---
layout: single
title: "Hypothesis Test 6: Friedman-Rafsky-Smith-Jain test (A Multivariate Normality Test)"
date: 2023-10-23 xx:xx:xx +0800
categories:
 - Mathematics
 - MATLAB
tags:
 - Probability Theory and Mathematical Statistics
 - MATLAB Statistics and Machine Learning Toolbox
---



# Introduction to Friedman-Rafsky-Smith-Jain test (FRSJ test)

Let the $N$ data points in one sample be labeled $X$ and the $M$ data points in the other sample be labeled $Y$. The MST of the pooled samples is computed. The number of edges in the MST linking a point labeled $X$ to a point labeled $Y$ is found. Denote this $X$-to-$Y$ join count as $T$. Under the null hypothesis that $X$ and $Y$ are independent random samples from the same distribution, Friedman and Rafsky show that as $M,N\rightarrow\infty$ with $M/N$ bounded away from $0$ and $\infty$, the distribution of:
$$
T'=\dfrac{T-\mathbb{E}(T)}{\sqrt{\mathrm{Var}(T\vert C)}}
$$
approaches the standard normal distribution for MST's computed using the Euclidean distance metric, where $C$ is the number of edge pairs in the realised MST which share a common node, and:
$$
\begin{split}
\mathbb{E}(T)=&\dfrac{2MN}{L}\\
\mathrm{Var}(T\vert C)=&\dfrac{2MN}{L(L-1)}\Big(\dfrac{2MN-L}{L}\\
&+\dfrac{C-L+2}{(L-2)(L-3)}[L(L-1)-4MN+2]\Big)
\end{split}
$$
where $L=M+N$.



The sample of $N$ points to be tested for normality is labeled $X$. The mean vector $V_x$ and 



Results:

```
numG = 1e3;
W = 2e3;
alpha = 0.05;

Accept! p-value: 0.1365
Accept! p-value: 0.5015
Accept! p-value: 0.2110
```

```
numG = 50; % 1e3
W = 2e3;
alpha = 0.05;

Accept! p-value: 0.5390
Accept! p-value: 0.4890
Accept! p-value: 0.3350
```

```
numG = 100; % 1e3
W = 2e3;
alpha = 0.05;

Accept! p-value: 0.8495
Accept! p-value: 0.2550
Accept! p-value: 0.0540
```



<br>

**References**

[1] J. H. Friedman and L. C. Rafsky, "Multivariate generalizations of the Wald-Wolfowitz and Smirnov two-sample tests," *Ann. Stat.*, (1979): 697-717.

[2] S. P. Smith and A. K. Jain, "A test to determine the multivariate normality of a data set," *IEEE Trans. Pattern Anal. Mach. Intell.*, 10.5 (1988): 757-761.

[3] [Friedman-Rafsky Test - Real Statistics Using Excel](https://real-statistics.com/multivariate-statistics/multivariate-normal-distribution/friedman-rafsky-test/).

[4] [FRSJ Multivariate Normality - Real Statistics Using Excel](https://real-statistics.com/multivariate-statistics/multivariate-normal-distribution/multivariate-normality-testing-frsj/).





