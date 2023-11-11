# Introduction

在之前的博客[Conjugate Prior for Multivariate Normal Distribution](http://whatastarrynight.com/mathematics/Conjugate-prior-for-multivariate-normal-distribution/)和[Wishart Distribution, Inverse-Wishart Distribution, Normal-Inverse-Wishart Distribution](http://whatastarrynight.com/mathematics/programming/Wishart-distributions/#inverse-wishart-distribution)中，我们都谈到了inverse Wishart函数可以作为均值已知的多维正态分布的协方差矩阵的共轭先验函数。今天看到了一篇论文——[A note on Wishart and Inverse Wishart Priors for Covariance Matrix](https://isdsa.org/_media/jbds/v1n2/v1n2p2.pdf) [1] ——对此进行了更为详细的讨论，本博客记录一下对于这篇论文思想的学习和代码实现。

<br>

Inverse-Wishart分布$\mathcal{IW}(\Sigma\vert V, m)$的PDF为：
$$
p(\Sigma)=\dfrac{\vert V\vert^{m/2}}{2^{mp/2}\Gamma_p(m/2)}\vert\Sigma\vert^{-(m+p+1)/2}\mathrm{exp}[-\mathrm{tr(V\Sigma^{-1})/2}]
$$
Inverse-Wishart分布是Inverse-Gamma分布的多维推广。其中：

- $\Sigma$是$p\times p$的随机矩阵(variance-covariance matrix)；

  注：“具体地说，Wishart分布是所有半正定矩阵的分布。合适的协方差矩阵是正定的，因此Wishart分布是一个协方差矩阵的适当的先验。” [3]
  {: .notice--warning}

- $V$是$p\times p$的scale matrix；

- $m$是degrees of freedom；

随机矩阵$\Sigma$的均值是：
$$
E(\Sigma)=\dfrac{V}{m-p-1}\label{eqEprior}
$$
随机矩阵$\Sigma$中的每一个元素$\sigma_{ij}$的方差为：
$$
\mathrm{Var}(\sigma_{ij})=\dfrac{(m-p+1)v_{ij}^2+(m-p-1)v_{ii}v_{jj}}{(m-p)(m-p-1)^2(m-p-3)}
$$
特别地，有：
$$
\mathrm{Var}(\sigma_{ij})=\dfrac{2v_{ii}^2}{(m-p-1)^2(m-p-3)}
$$
<br>

假设协方差矩阵服从Inverse-Wishart先验分布，即$\mathcal{IW}(V_0,m_0)$，则其后验分布形式为：
$$
\mathcal{IW}(nS+V_0, n+m_0)=\mathcal{IW}(V_1,m_1)\label{posterior}
$$
其中：

- $S$是**biased sample covariance matrix**；
- $n$是sample size；

对于式$\eqref{posterior}$的后验分布，其均值为：
$$
\begin{split}
\mathrm{E}(\Sigma\vert D)&=\dfrac{nS+V_0}{n+m_0-p-1}\\
&=\dfrac{n}{n+m_0-p-1}S+(1-\dfrac{n}{n+m_0-p-1})\dfrac{V_0}{m_0-p-1}
\end{split}\label{eqPosterior}
$$
这表明，posterior mean $\eqref{eqPosterior}$ 是sample covariance matrix $S$ 和prior mean $V_0/(m_0-p-1)$的加权平均。当$n\rightarrow\infty$时，posterior mean $\eqref{eqPosterior}$ 接近于$S$，即

并且，设置先验可以和数据的信息联系在一起。例如，如果我们设定先验分布为：$\mathcal{IW}(V_0, m_0)$，其中$V_0=n_0S$，并且$m_0=n_0$，那么在先验中的信息可以认为是样本中的$n_0$个participants；如果我们设置为$V_0=(m_0-p-1)S$，则$E(\Sigma\vert D)=S$，这意味着posterior mean和sample covariance matrix是一致的。

<br>

# Examples













<br>

**Reference**

[1] Zhang Z. A Note on Wishart and Inverse Wishart Priors for Covariance Matrix[J]. Journal of Behavioral Data Science, 2021, 1(2): 119-126.

[2] [Inverse-Wishart distribution - Wikipedia](https://en.wikipedia.org/wiki/Inverse-Wishart_distribution).

[3] Allen B. Downey. 贝叶斯思维: 统计建模的Python学习法. 北京: 人民邮电出版社, 2014.4(2019.5重印).