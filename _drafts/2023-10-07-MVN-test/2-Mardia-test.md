Mardia’s test

three resources:

for samples $\mathrm{\boldsymbol{X}}_1,\mathrm{\boldsymbol{X}}_2,\cdots,\mathrm{\boldsymbol{X}}_n$ of $k$-dimensional vectors, denote that:



let $m_{i,j}$ denote
$$
\begin{split}
&\hat{\Sigma}=\dfrac1n\sum_{j=1}^n(\mathrm{\boldsymbol{X}}_j-\bar{\mathrm{\boldsymbol{X}}})(\mathrm{\boldsymbol{X}}_j-\bar{\mathrm{\boldsymbol{X}}})^T\\
&m_{i,j}=(\mathrm{\boldsymbol{X}}_i-\bar{\mathrm{\boldsymbol{X}}})^T\hat{\Sigma}^{-1}(\mathrm{\boldsymbol{X}}_j-\bar{\mathrm{\boldsymbol{X}}})\\
\end{split}
$$
then [1]:
$$
\begin{split}
&A=\dfrac1{6n}\sum_{i=1}^n\sum_{j=1}^nm_{i,j}^3\\
&B=\sqrt{\dfrac{n}{8k(k+2)}}\Big\{\dfrac1n\sum_{i=1}^nm_{i,i}^2-k(k+2)\Big\}
\end{split}
$$
Under the null hypothesis of multivariate normality, the statistic $A$ will have approximately a chi-squared distribution with $\dfrac16k(k+1)(k+2)$ degrees of freedom, and $B$ will be approximately standard normal distribution $\mathscr{N}(0,1)$.

==correct==

Mardia's tests are affine invariant but not consistent. For example, the multivariate skewness test is *NOT consistent* against symmetric non-normal alternatives.

<br>

$$
\begin{split}
&\text{skew}=\dfrac1{n^2}\sum_{i=1}^n\sum_{j=1}^nm_{i,j}^3\\
&\text{kurt}=\dfrac1n\sum_{i=1}^nm_{i,i}^2
\end{split}
$$

$$
\begin{split}
&\text{skew}^\prime=\dfrac{n}{(n-1)^3}\sum_{i=1}^n\sum_{j=1}^nm_{i,j}^3\\
&\text{kurt}^\prime=\dfrac{n}{(n-1)^2}\sum_{i=1}^nm_{i,i}^2
\end{split}
$$
<br>
$$
\text{meanKurt}=\dfrac{k}{k+2}\\
\text{varKurt}=\dfrac{8k(k+2)}{n}
$$
==first write z-test==



<br>

**References**

[1] [Multivariate normal distribution: Multivariate normality tests - Wikipedia](https://en.wikipedia.org/wiki/Multivariate_normal_distribution#Multivariate_normality_tests).

[2] [Examine the Gaussian Mixture Assumption: Mardia-Kurtosis Test for Linear and Quadratic Discriminants - MathWorks](https://ww2.mathworks.cn/help/stats/examine-the-gaussian-mixture-assumption.html#bs2r9lk).

[3] [Mardia's Test - Real Statistics Using Excel](https://real-statistics.com/multivariate-statistics/multivariate-normal-distribution/multivariate-normality-testing/).

[4] [Methods of Multivariate Analysis 2 Ed-02](https://www.ipen.br/biblioteca/slr/cel/0241), pages 112-113.