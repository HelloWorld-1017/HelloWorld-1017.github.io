---
title: Wishart Distribution, Inverse-Wishart Distribution, Normal-Inverse-Wishart Distribution
categories: 
 - Mathematics
 - MATLAB
tags:
 - Bayesian probability
 - MATLAB Statistics and Machine Learning Toolbox
 - Probability Theory and Mathematical Statistics
date: 2022-10-22 14:29:56 +0800
last_modified_at: 2025-07-11 15:44:39 +0800
---

# Wishart Distribution

假设$G$是$p\times n$的矩阵，矩阵中的每一列独立同分布于零均值的$p$维正态分布：

$$
G_i =(g_i^1,\cdots,g_i^p)\sim \mathcal{N}_p(0,\boldsymbol{V})\notag
$$

则Wishart分布是$p\times p$的随机矩阵(random matrix)$S$的概率分布：

$$
S=GG^T=\sum_{i=1}^nG_iG_i^T\notag
$$

其中，随机矩阵$S$也称为散布矩阵(scatter matrix)。可以记作

$$
S\sim W_p(V,n)
$$

其中，正整数$n$是自由度的数量，有时也写作$W(V,p,n)$。

如果$n\ge p$，并且矩阵$V$是可逆的，那么矩阵$S$以概率1是可逆的；如果$p=V=1$，此时的概率分布就是自由度为$n$的卡方分布。

## Occurrence

Wishart分布源于来自多元正态分布的样本协方差矩阵的分布(The Wishart distribution arises as the distribution of the sample covariance matrix for a sample from a multivariate normal distribution)，经常用于多元统计分析的似然比检验(likelihood-ratio tests)中。它还出现在随机矩阵(random matrices)的谱理论(spectral theory)和多元贝叶斯分析(multivariate Bayesian analysis)中，还会在无线通信(wireless communications)中分析Rayleigh fading MIMO遇到。

## PDF

令$\mathrm{X}$是一个$p\times p$的随机变量的对称矩阵，并且是半正定的；令$\mathrm{V}$是一个$p\times p$的(固定的)对称正定矩阵。

如果$n\ge p$，并且有如下的PDF：

$$
f_{\mathrm{X}}(\mathrm X;\mathrm V, n)=\dfrac1{2^{np/2}\vert \mathrm{V}\vert ^{n/2}\Gamma_p(n/2)}\vert\mathrm{X}\vert^{(n-p-1)/2}e^{-\frac{1}2\mathrm{tr}(\mathrm{V}^{-1}\mathrm{X})}\label{Wishart}
$$

则称随机矩阵$\mathrm X$服从$n$个自由度的Wishart分布。其中，$\Gamma_p$是多元Gamma分布，定义为：

$$
\Gamma_p(\dfrac{n}2)=\pi^{p(p-1)/4}\prod_{j=1}\Gamma(\dfrac{n}2-\dfrac{j-1}{2})
$$

上述的PDF并不是随机矩阵$\mathrm X$中所有$p^2$个元素的联合概率密度(该$p^2$维的概率密度并不存在，因为对称性限制了$X_{ij}=X_{ji}$)，而是$p(p+1)/2$个元素$X_{ij}(i\le j)$的联合概率密度。并且上面的PDF公式只能应用于正定矩阵$\mathrm X$，对于其他的矩阵，概率密度恒等于0。

若随机变量矩阵$\mathrm X\sim W_p(\mathrm{I},n)$，那么$\mathrm X$的特征值$\lambda_1,\cdots,\lambda_p\ge 0$所服从联合特征值概率密度(joint-eigenvalue)：

$$
c_{n,p}e^{-\frac12\sum_i\lambda_i}\prod\lambda_i^{(n-p-1)/2}\prod_{i<j}\vert\lambda_i-\lambda_j\vert
$$

其中，$c_{n,p}$为常数。

事实上，上述的定义可以拓展到任意的实数$n>p-1$。如果$n\le p-1$，那么Wishart分布不再有密度，相反它表示在$p\times p$矩阵空间的低维子空间中取值的奇异分布(singular distribution)。

## Use in Bayesian Statics

在贝叶斯统计中，Wishart分布是(均值已知的)MVN分布的精度矩阵$\Omega$($\Omega=\Sigma^{-1}$，$\Sigma$是协方差矩阵)的共轭先验：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221022215519013.png?raw=true" alt="image-20221022215519013" style="width:80%;" />

没有足够的信息时，自由度$n=p$的Wishart先验是一个合适的选择。由于Wishart先验的均值为$W_p(\mathrm{V},n)$为$n\mathrm{V}$，这表明矩阵$\mathrm{V}$的一个合理的选择是$n^{-1}\Sigma_0^{-1}$，其中$\Sigma_0$是协方差矩阵的猜测($\Sigma_0$is some prior guess for the covariance matrix)。

## `wishrnd` Function in MATLAB

在MATLAB的官方文档中，也提供了关于Wishart分布的一些概括和功能[^2]，其中的描述和PDF定义和Wikipedia中时一致的：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221022214757974.png?raw=true" alt="image-20221022214757974" style="width:80%;" />

只是记号有所差异。我们这里仍然沿用式$\eqref{Wishart}$中的记号，即$n$表示Wishart分布的自由度，$\Sigma$表示对称正定矩阵，这是两个Wishart分布的参数。

在MATLAB产生随机矩阵的函数是`wishrnd`[^3]。在[^2]中提供了两个使用`wishrnd`的示例：

```matlab
Sigma = [1 .5; .5 2];
df = 10; 
S1 = wishrnd(Sigma,df)/df
```

```
S1 =
       1.7959      0.64107
      0.64107       1.5496
```

```matlab
Sigma = [1 .5; .5 2];
df = 1000; 
S2 = wishrnd(Sigma,df)/df
```

```
S2 =
       0.9842      0.50158
      0.50158       2.1682
```

在这两个示例中，`wishrnd`所生成的随机矩阵都除以了自由度`df`，其原因是：This function defines the parameter `Sigma` so that the mean of the output matrix is `Sigma*df`。

上面这种形式看不出自由度对于随机矩阵有什么影响，因此下面参考文献[^1]提供的一种可视化的方式：

```matlab
clc, clear, close all

Sigma = eye(15);
dfs = [1e1, 1e2, 1e3, 1e4, 1e5, 1e6];
figure('Units', 'pixels', 'Position', [767, 409, 856, 633])
tiledlayout(2, 3, 'TileSpacing', 'tight', 'Padding', 'tight')
for i = 1:numel(dfs)
    df = dfs(i);
    S = wishrnd(Sigma, df)/df;
    nexttile
    imagesc(S)
    title(sprintf("n=%d", df))
    axis off
    colorbar
    set(gca, 'PlotBoxAspectRatio', [1, 1, 1])
end
exportgraphics(gcf, 'fig.jpg?raw=true', Resolution=300)

```

![fig](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/fig.jpg?raw=true)

可以看到，当$\Sigma$一定时(这里取15阶的单位矩阵)，自由度越大，Wishart分布所产生的随机矩阵是越“确定”的，就和先验协方差矩阵越一致。

比如，如果我们讲$\Sigma$换成别的对角矩阵：

```matlab
Sigma = diag(1:15);
...
```

得到结果：

![pic2](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/pic2.jpg?raw=true)

<br>

# Inverse-Wishart distribution

## PDF

在统计学中，inverse Wishart distribution(AKA inverted Wishart distribution)，是定义在实质正定矩阵的概率分布。在贝叶斯理论中，它常作为多元正态分布协方差矩阵的共轭先验分布。如果随机矩阵$\mathrm{X}$的逆矩阵$\mathrm{X}^{-1}$服从Wishart分布，即$\mathrm{X}^{-1}\sim \mathcal{W}(\Psi^{-1},v)$，则随机矩阵$\mathrm{X}$服从inverse Wishart分布，即$X\sim \mathcal{W}^{-1}(\Psi,v)$。

inverse Wishart分布的PDF为：

$$
f_{\mathrm{X}}(\mathrm X;\Psi,v)=\dfrac{\vert \mathrm{\Psi}\vert ^{v/2}}{2^{vp/2}\Gamma_p(v/2)}\vert\mathrm{X}\vert^{-(n+p+1)/2}e^{-\frac{1}2\mathrm{tr}(\Psi\mathrm{X}^{-1})}\label{inverseWishart}
$$

Inverse Wishart分布的均值为：
$$
\mathrm{E}(\mathrm{X})=\dfrac{\Psi}{v-p-1}
$$
在贝叶斯统计中，Inverse Wishart分布常作为(均值未知的)MVN函数的协方差矩阵的共轭先验：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221022224948742.png?raw=true" alt="image-20221022224948742" style="width:80%;" />

## `iwishrnd`  Function in MALTAB

和Wishart分布一样，MATLAB同样提供了相关的内容[^4][^5]，其PDF：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221022223732781.png?raw=true" alt="image-20221022223732781" style="width:80%;" />

与式$\eqref{inverseWishart}$是等价的。

`iwishrnd`函数的使用也是类似的：

```matlab
Tau = [1 .5; .5 2];
df = 10; S1 = iwishrnd(Tau,df)*(df-2-1)
```

```
S1 =
       1.7959      0.64107
      0.64107       1.5496
```

```matlab
Tau = [1 .5; .5 2];
df = 1000; 
S2 = iwishrnd(Tau,df)*(df-2-1)
```

```
S2 =
       0.9842      0.50158
      0.50158       2.1682
```

采用和上文同样的可视化方式：

```matlab
clc, clear, close all

Sigma = eye(15);
dfs = [5e1, 1e2, 1e3, 1e4, 1e5, 1e6];
figure('Units', 'pixels', 'Position', [767, 409, 856, 633])
tiledlayout(2, 3, 'TileSpacing', 'tight', 'Padding', 'tight')
for i = 1:numel(dfs)
    df = dfs(i);
    S = iwishrnd(Sigma, df)*(df-15-1);
    nexttile
    imagesc(S)
    title(sprintf("n=%d", df))
    axis off
    colorbar
    set(gca, 'PlotBoxAspectRatio', [1, 1, 1])
end

exportgraphics(gcf, 'pic3.jpg?raw=true', Resolution=300)
```

![pic3](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/pic3.jpg?raw=true)

```matlab
Sigma = diag(1:15);
...
```

![pic4](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/pic4.jpg?raw=true)

<br>

# Normal-Inverse-Wishart distribution

在概率论与数理统计中，Normal-inverse-Wishart distribution(AKA Gaussian-inverse-Wishart distribution)是一种四参数多维连续型概率分布。它是具有未知均值和协方差矩阵(精度矩阵的逆)多元正态分布的共轭先验。

## Definition and PDF

假设$\mu$服从均值为$\mu_0$、协方差矩阵为$\dfrac1\lambda\Sigma$的多元正态分布：

$$
\mu\vert\mu_0,\lambda,\Sigma\sim\mathcal{N}(\mu\vert\mu_0,\dfrac1\lambda\Sigma)\notag
$$

其中，$\Sigma$服从inverse Wishart分布：

$$
\Sigma\vert\Psi,v\sim\mathcal{W}^{-1}(\Sigma\vert\Psi,v)\notag
$$

则$(\mu,\Sigma)$服从normal-inverse-Wishart分布，记作：

$$
(\mu,\Sigma)\sim\mathrm{NIW}(\mu_0,\lambda,\Psi,v)\notag
$$

其概率密度函数为：

$$
f(\mu,\Sigma\vert\mu_0,\lambda,\Psi,v)=\mathcal{N}(\mu\vert\mu_0,\dfrac{1}\lambda\Sigma)\mathcal{W}^{-1}(\Sigma\vert\Psi,v)
$$

PDF的展开形式为：

$$
f(\mu,\Sigma\vert\delta,\gamma,\Psi,\alpha)=\dfrac{\gamma^{D/2}\vert\Psi\vert^{\alpha/2}\vert\Sigma\vert^{-\frac{\alpha+D+2}{2}}}{(2\pi)^{D/2}2^{\frac{\alpha D}2}\Gamma_D(\alpha/2)}\mathrm{exp}\Big\{-\dfrac12Tr(\Psi\Sigma^{-1})-\dfrac{\gamma}2(\mu-\delta)^T\Sigma^{-1}(\mu-\delta)\Big\}
$$

其中，$\Gamma_D[\cdot]$是多元Gamma函数，$Tr(\Psi)$是给定矩阵的迹。

## Posterior distribution of the parameters

假设样本$Y_i$采样自多元正态分布：

$$
Y_i\vert\mu,\Sigma\sim\mathcal{N}_p(\mu,\Sigma)\notag
$$

其中，$Y$是一个$n\times p$的矩阵，$n$为样本数量，$p$为样本维度，$Y_i$为其中一个样本，即矩阵的第$i$行，长度为$p$。并且该多元正态分布的均值$\mu$和协方差矩阵$\Sigma$均是未知的，那么我们可以使用Normal-Inverse-Wishart分布：

$$
(\mu,\Sigma)\sim \mathrm{NIW}(\mu_0,\lambda,\Psi,v)\notag
$$

作为该多元正态函数的先验分布。则均值和协方差矩阵的后验分布同样服从NIW：

$$
(\mu,\Sigma\vert y)\sim \mathrm{NIW}(\mu_n,\lambda_n,\Psi_n,v_n)
$$

其中：

$$
\begin{split}
&\mu_n=\dfrac{\lambda \mu_0+n\overline{Y}}{\lambda+n}\\
&\lambda_n=\lambda+n\\
&v_n=v+n\\
&\Psi_n=\Psi+S+\dfrac{\lambda n}{\lambda+n}(\overline{Y}-\mu_0)(\overline{Y}-\mu_0)^T\\
&\mathrm{with}\ \overline{Y}= \dfrac1n\sum_{i=1}^nY_i,\
S=\sum_{i=1}^n(Y_i-\overline{Y})(Y_i-\overline{Y})^T
\end{split}
$$

为了从$(\mu,\Sigma)$的联合后验中抽样，一种简单的方式是先从$\Sigma\vert Y\sim\mathcal{W}^{-1}(\Psi_n,v_n)$中抽样，再从$\mu\vert\Sigma\sim\mathcal{N}_p(\mu_n,\Sigma/\lambda_n)$中抽样，之后基于已经得到的$\mu$和$\Sigma$值，从分布$\tilde{y}\vert,\Sigma,y\sim\mathcal{N}_p(\mu,\Sigma)$中抽取新的样本观察值。

<br>

**Reference**

- [Wishart distribution](https://en.wikipedia.org/wiki/Wishart_distribution).
- [Inverse-Wishart distribution](https://en.wikipedia.org/wiki/Inverse-Wishart_distribution).
- [Normal-inverse-Wishart distribution](https://en.wikipedia.org/wiki/Normal-inverse-Wishart_distribution).

[^1]: Cameron Davidson-Pilon. 贝叶斯方法: 概率编程与贝叶斯推断. 北京: 人民邮电出版社, 2017.1.
[^2]: [Wishart Distribution](https://ww2.mathworks.cn/help/stats/wishart-distribution.html).
[^3]: [MATLAB `wishrnd`: Wishart random numbers](https://ww2.mathworks.cn/help/stats/wishrnd.html).
[^4]: [Inverse Wishart Distribution](https://ww2.mathworks.cn/help/stats/inverse-wishart-distribution.html).
[^5]: [MATLAB `iwishrnd`: Inverse Wishart random numbers](https://ww2.mathworks.cn/help/stats/iwishrnd.html).
