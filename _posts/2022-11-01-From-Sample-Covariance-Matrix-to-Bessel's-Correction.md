---
layout: single
title: From Sample Covariance Matrix(SCM) to Bessel's Correction
date: 2022-11-01 18:37:31 +0800
categories: 
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
---

# Introduction

在博客[Maximum Likelihood Estimation for Multivariate Normal Distribution - What a starry night ~](http://whatastarrynight.com/mathematics/maximum-likelihood-estimation-for-multivariate-normal-distribution/)中，我们推导出MVN的MLE估计形式为：

$$
\begin{split}
&\hat{\mu}_{\mathrm{MLE}}=\dfrac1n\sum_{i=1}^nX_i\\
&\hat{\Sigma}_{\mathrm{MLE}}=\dfrac1n\sum_{i=1}^n(X_i-\hat{\mu})(X_i-\hat{\mu})^T
\end{split}\label{eq1}
$$

推导的过程中使用到了矩阵迹的相关运算。Wikipedia的Estimation of covariance matrices词条([Estimation of covariance matrices - Wikipedia](https://en.wikipedia.org/wiki/Estimation_of_covariance_matrices))提供了另外一种推导思路，使用的是线性几何的谱理论(详见：[Maximum-likelihood estimation for the multivariate normal distribution](https://en.wikipedia.org/wiki/Estimation_of_covariance_matrices#Maximum-likelihood_estimation_for_the_multivariate_normal_distribution))。但是，这种推导方法并不是本文关注的重点，本文关注的是该词条关于无偏估计的描述。

<br>

# Sample covariance matrix, SCM

> 定义1(**Sample covariance matrix, SCM**): Given a sample consisting of $n$ independent observations $x_1,\cdots,x_n$ of a *p*-dimensional random vector $X\in \mathbb{R}^{p×1}$ (a *p*×1 column-vector), an unbiased estimator of the ($p\times p$) covariance matrix
> 
> $$
> \Sigma=\mathrm{E}\Big[(X-\mathrm{E}[X])(X-\mathrm{E}[X])^T\Big]\notag
> $$
> 
> is the sample covariance matrix(SCM)
> 
> $$
> S=\dfrac1{n-1}\sum_{i=1}^n(X_i-\bar{X})(X_i-\bar{X})^T\label{eq2}
> $$
> 
> where $x_i$  is the i-th observation of the p-dimensional random vector, and the vector
> 
> $$
> \bar{X}=\dfrac1n\sum_{i=1}^nX_i\notag
> $$
> 
> is the sample mean.

在假设理论均值和理论协方差存在的情况下，**我们可以使用SCM作为协方差矩阵的无偏估计，而不论样本的总体分布是怎样的**。这里使用了$n-1$的系数而不是$n$，其原因与样本方差和样本协方差的无偏估计是一样的，是因为理论均值未知，使用了样本均值进行替代(详见下面所介绍的Bessel's correction)。

假如我们假设随机变量$x$服从某一个确定的分布族，那么我们可以从这个假设中推导出其他的估计式。比较著名的就是MLE，就是我们之前推导出的式$\eqref{eq1}$，这里记作$S_n$：

$$
S_n=\dfrac1n\sum_{i=1}^n(X_i-\hat{\mu})(X_i-\hat{\mu})^T\label{eq3}
$$

式$\eqref{eq3}$与式$\eqref{eq2}$的差别就在于系数不同，当$n$特别大时，两者计算的结果差异很小。我们使用由MLE推导出的式$\eqref{eq1}$去估计协方差矩阵并没有错，但是我们可以对这个结果进行修正，使它成为一个无偏估计。

<br>

# Bessel's Correction

在统计学中，Bessel's correction指的是使用$n-1$而不是$n$作为样本方差和样本标准差计算公式的系数(其中，$n$为样本的个数)，在有些文献中将系数$n/(n-1)$称为Bessel's correction。这种方法矫正了样本方差和样本标准差估计的有偏性，然而，这种矫正也经常会增加估计的mean squared error。

注意：这里只是说Bessel's correction可以**矫正**样本方差和样本标准差估计的有偏性，但并不意味着就一定能够使估计成为无偏估计。事实上，在下面我们也可以看到，Bessel's correction可以使样本方差的估计成为无偏估计，但是不能使样本标准差的估计成为无偏估计，只能在一定程度上改善。
{: .notice--warning}

我们可以从degrees of freedom的角度来理解Bessel's correction。残差向量(residuals vector, note: residuals, not errors, because the population mean is unknown)：

$$
(X_1-\bar{X},X_2-\bar{X},\cdots,X_n-\bar{X})\ (\bar{X}\mathrm{\ is\ the\ sample\ mean)}\label{residuals}
$$

仅有$n-1$个独立的residuals(因为它们加和为0)，这表明residuals vector的自由度为$n-1$，因此计算方差的时候，需要除以的系数是$n-1$。

通常，Bessel's correction是一种**减小**因样本量有限(finite sample size)而产生的偏差的方法（注：是减小而不是消除）。对于其他总体矩的估计，诸如skew和kurtosis，同样需要这种有限样本偏差矫正，但是在这些情况下不准确度通常会更大(but in these the inaccuracies are often significantly larger)。为了完全**消除**这种(有限样本所导致的)偏差，我们必须进行更复杂的多参数估计。比如，对于标准差的正确矫正依赖于kurtosis(ie normalized central 4th moment， 归一化四阶中心矩)，但是kurtosis同样会受到finite sample bias的影响，它依赖于标准差，也就说，标准差和kurtosis的矫正必须合并。

## Caveats

关于Bessel's correction，有三点需要注意的地方。

### Caveat 1: Does not yield an **unbiased estimator of standard deviation**.

> It does not yield an **unbiased estimator of standard deviation**.

在经过Bessel's correction之后，我们可以得到关于总体方差的一个无偏估计量，即样本方差(sample variance)：

$$
S=\dfrac1{n-1}\sum_{i=1}^n(X_i-\hat{\mu})(X_i-\hat{\mu})^T
$$

但是，正如前面所述，样本方差的平方根，即样本标准差(Sample standard deviation)：

$$
\sqrt{S}=\sqrt{\dfrac1{n-1}\sum_{i=1}^n(X_i-\hat{\mu})(X_i-\hat{\mu})^T}\label{eq4}
$$

并不是总体标准差的一个无偏估计，Bessel's correction只能减小一些偏差，但是不能完全消除，因此$\sqrt{S}$仍然是一个有偏估计，这是因为平方根是一个凹函数(concave function)，根据Jensen不等式，偏差是凹向原点的(downward)。这就导致了没有一个通用的公式用于计算总体标准差的无偏估计量。但是对于特定的分布，我们可以得到一些特定的矫正因子，比如对于正态分布，一种精确矫正的**近似**是在公式中使用矫正系数$n-1.5$：偏差以二次衰减(decays quadratically)，而不是像在未矫正形式(uncorrected form)和Bessel's corrected form中一样线性衰减(linearly)。

虽然对于使用式$\eqref{eq4}$去估计总体标准差，只是减小并非消除bias，但是这并不影响它的实践意义，比如MATLAB的`std`函数在默认情况下就使用式$\eqref{eq4}$去计算样本标准差：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221101183130171.png?raw=true" alt="image-20221101183130171" style="zoom:50%;" />

### Caveat 2: The corrected estimator often has a higher mean squared error

> The corrected estimator often has a higher mean squared error (MSE) than the uncorrected estimator. Furthermore, there is no population distribution for which it has the minimum MSE because a different scale factor can always be chosen to minimize MSE.

无偏估计量并不意味着最小均方误差，并且通常比未矫正的估计量具有更差的MSE，这随超峰度(excess kurtosis)而变化。我们可以通过使用不同的系数最小化MSE，最优值的选择依赖于超峰度（详见[mean squared error: variance](https://en.wikipedia.org/wiki/Bessel%27s_correction))。对于正态分布而言，最优系数是$n+1$，而不是$n-1$或者$n$。

### Caveat 3: Only necessary when the population mean is unknown

> It is **only necessary** when the population mean is unknown (and estimated as the sample mean). In practice, this generally happens.

**Bessel's correction仅仅在总体均值未知的情况下才是必要的**，比如我们需要根据给定样本估计同时总体均值和总体方差。在这种情况下，$n$个样本点具有$n$个自由度，“公式估计均值和方差”意味着我们使用1个自由度用于计算样本均值，以估计总体均值；使用剩下的$n-1$个自由度计算样本方差，以估计总体方差。然而，如果总体均值已知，那么由总体均值所计算的样本偏差就有$n$个自由度(因为不用总体均值，偏差(deviation)并不是residuals，而是errors，参考式$\eqref{residuals}$)，因此就不需要使用Bessel's correction。

## Source of bias

那么，我们为什么要矫正bias呢？我们考虑一种极端情况。

假设有总体：

$$
(0,0,0,1,2,9)\notag
$$

则很容易得到，总体均值为$2$，总体方差为$31/3$。

假设我们在总体中抽取了$n=1$个样本，该样本是$X_1=0$。那么我们对于总体均值的最优估计是：$\bar{X}=X_1/n=0$。并且如果我们使用有偏的统计量估计总体方差，可以得到$(X_1-\bar{X})^2/n=(0-0)/1=0$，即样本方差为0，并且对于任意总体，我们都只抽取一个样本，都会计算得到总体方差的估计为0。导致这样的结果的原因就在于，我们使用样本均值估计总体均值的过程，已经使我们对总体均值的估计非常接近我们采样的值，对于$n=1$的情况，两者甚至是一致的。在$n=1$的情况下，我们就无法估计出方差，因为在样本中本身就没有变化。

考虑$n=2$的情况，假如我们在总体中抽出的样本为$(0, 2)$，那么$\bar{X}=1$，并且有$[(X_1-\bar{X})^2+(X_2-\bar{X})^2]/n=(1+1)/2=1$，由Bessel's correction矫正后的样本方差(即总体方差的无偏估计)为$[(X_1-\bar{X})^2+(X_2-\bar{X})^2]/n=(1+1)/(2-1)=2$。如果选取抽取样本的数量固定为2个(即$n=2$)考虑所有可能的情况，可以得到样本方差的平均估计为12.4，该值与直接计算总体的无偏方差得到的结果是一致的(并且$n=2,\cdots,6$都可以得到相同的结果)；但是，假如我们使用有偏的公式计算样本方差的平均值，得到的结果就会有所差异。下面的代码就对比了这两种情况：

```matlab
clc, clear, close all

population = [0, 0, 0, 1, 2, 9];
for i = 2:6
    % Sample number
    n = i;

    % Calculate average of sample variance
    samples = nchoosek(population, n);
    means = mean(samples, 2);
    % Unbiased
    UnbiasedVars = sum((samples-means).^2/(n-1), 2);
    averageUnBiasedSampleVar = mean(UnbiasedVars);
    % Biased
    BiasedVars = sum((samples-means).^2/n, 2);
    averageBiasedSampleVar = mean(BiasedVars);

    % Calculate population variance
    % Unbiased
    UnBiasedPopulationVar = var(population, 0);
    % Biased
    BiasedPopulationVar = var(population, 1);

    % Print result
    disp(sprintf("Sample number n = %d\n" + ...
        "Avarege of unbiased sample variance:%.4f\n" + ...
        "Unbiased population variance:%.4f\n"+ ...
        "Biased population variance:%.4f\n"+...
        "Avarege of biased sample variance:%.4f\n", ...
        n, averageUnBiasedSampleVar, UnBiasedPopulationVar, averageBiasedSampleVar, BiasedPopulationVar));
end
```

```matlab
Sample number n = 2
Avarege of unbiased sample variance:12.4000
Unbiased population variance:12.4000
Biased population variance:6.2000
Avarege of biased sample variance:10.3333

Sample number n = 3
Avarege of unbiased sample variance:12.4000
Unbiased population variance:12.4000
Biased population variance:8.2667
Avarege of biased sample variance:10.3333

Sample number n = 4
Avarege of unbiased sample variance:12.4000
Unbiased population variance:12.4000
Biased population variance:9.3000
Avarege of biased sample variance:10.3333

Sample number n = 5
Avarege of unbiased sample variance:12.4000
Unbiased population variance:12.4000
Biased population variance:9.9200
Avarege of biased sample variance:10.3333

Sample number n = 6
Avarege of unbiased sample variance:12.4000
Unbiased population variance:12.4000
Biased population variance:10.3333
Avarege of biased sample variance:10.3333
```

这就体现出了无偏性的价值。**这实际上就是估计量所要求的无偏性所要求的内容**。

再考虑另外一个例子，假设一个总体，其总体均值为$\mu=2050$，但是统计学家并不知道这一点，因此必须从总体中进行随机抽样以进行估计，假设抽出来的样本为：

$$
2051,2053,2055,2050,2051\notag
$$

样本均值为：

$$
\bar{X}=\dfrac15(2051+2053+2055+2050+2051)=2052\notag
$$

假设我们在知道总体均值的情况下进行计算样本方差：

$$
\begin{split}
\dfrac15[&(2051-2050)^2+(2053-2050)^2+\\
&(2055-2050)^2+(2050-2050)^2+(2051-2050)^2]=7.2
\end{split}\notag
$$

我们在并不知道总体均值的情况下，基于估计的样本均值计算**无偏的**样本方差$S$：

$$
\begin{split}
S=\dfrac1{5-1}[&(2051-2052)^2+(2053-2052)^2+\\
&(2055-2052)^2+(2050-2052)^2+(2051-2052)^2]=4.375
\end{split}\notag
$$

基于估计的样本均值计算**有偏的**样本方差$S_n$：

$$
\begin{split}
S_n=\dfrac15[&(2051-2052)^2+(2053-2052)^2+\\
&(2055-2052)^2+(2050-2052)^2+(2051-2052)^2]=3.2
\end{split}\notag
$$

可以看到，$S$和$S_n$比真实的样本方差小，但是$S_n$小得更多。

我们可以证明(见Appendix A)，**当使用样本平均值$\bar{X}$的平方距离之和计算时，与使用总体均值$\mu$的距离之和相比，方差几乎总是更小**。唯一的例外是样本均值和总体均值相等的情况，在这种情况下，两种方式计算出的方差是一致的。也就是说，偏差总是存在的，并且符号是非负的。这一定论还表明，基于样本平均值计算得偏差平方和太小，以至于尽管找到了这些平方的平均值(见上述的MATLAB的程序)，也无法给出总体方差的无偏估计。并且，**样本数量越小，样本方差和总体方差之间的差别就越大**，而以Bessel’s 为典型的矫正方法就能够有效缓解甚至消除这之间的差异。

<br>

# Appendix A

前文提到：样本到总体均值的距离平方的加和大于样本到样本均值距离平方的加和，唯一的例外是样本均值和总体均值相等的情况，在这种情况下，两种方式计算出的方差是一致的。

我们使用代数中的二项式定理来证明这一点：

$$
(a+b)^2=a^2+2ab+b^2\notag
$$

式中，$a$表示单个样本相对样本均值的偏离，$b$表示样本均值相对总体均值的偏离。这里，我们简单地将单个样本相对(未知的)总体均值的偏离分解为两个部分：

- 单个样本相对样本均值的偏离，这一部分我们是可以计算的；
- 样本均值相对总体均值的偏离，这一部分我们无法计算，因为我们假设总体均值是未知的。

以本例中的第2个样本为例解释这一点：

![image-20221101164301724](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221101164301724.png?raw=true)

如果我们对所有的5个样本应用这种分解，可以得到：

![image-20221101180155502](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221101180155502.png?raw=true)

很明显，上图中的中间列的加和为0。剩余部分：

- 第一列$a^2$的加和等于样本到样本均值的平方距离之和；
- 最后一列$b^2$的加和等于样本均值到总体均值的平方距离之和；
- 每一行包含两个部分：$a^2$——有偏的，因为使用了样本均值；和$b^2$——bias的矫正，因为它考虑了“真实”总体均值和不准确的样本均值之间的差异。因此，第一列和最后一列所有元素的加和现在就表示了正确的方差，因为它考虑到了样本和样本均值之间平方距离的加和；
- $a^2$列和$b^2$列的加和一定大于$a^2$列，因为$b^2$列的值都是正数(更一般的情况是非负的)

至此，我们可以就证明了结论。

<br>

**Reference**

[1] [Estimation of covariance matrices - Wikipedia](https://en.wikipedia.org/wiki/Estimation_of_covariance_matrices)

[2] [Bessel's correction - Wikipedia](https://en.wikipedia.org/wiki/Bessel%27s_correction).

