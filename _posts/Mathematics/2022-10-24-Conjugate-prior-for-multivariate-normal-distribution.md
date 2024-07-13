---
layout: single
title: Conjugate Prior for Multivariate Normal Distribution
date: 2022-10-24 22:38:42 +0800
categories: 
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
 - Bayesian Probability
---


# Multivariate normal with known covariance matrix $\Sigma$

假设样本：

$$
X_1,\cdots,X_n\stackrel{i.i.d}{\sim}\mathrm{MVN}(\theta,\Sigma)\label{eq1}
$$

其中总体分布的协方差矩阵$\Sigma$已知，均值$\theta$的先验同样服从MVN，即

$$
\theta\sim\mathrm{MVN}(\mu, \Omega)\label{eq2}
$$

求均值$\theta$的后验估计。

首先：

$$
P(\theta\vert X,\Sigma)=\dfrac{P(X,\theta\vert\Sigma)}{P(X)}=\dfrac{P(X\vert\theta,\Sigma)P(\theta)}{P(X)}\propto P(X\vert\theta,\Sigma)P(\theta)\label{eq3}
$$

根据式$\eqref{eq2}$，有prior：

$$
\begin{split}
P(\theta)&=(2\pi)^{-p/2}\vert\Omega\vert^{-1/2}\exp\{-\frac12(\theta-\mu)^T\Omega^{-1}(\theta-\mu)\}\\
&\propto\exp\{-\frac12(\theta-\mu)^T\Omega^{-1}(\theta-\mu)\}\\
&=\exp\{-\frac12(\theta^T\Omega^{-1}\theta-\theta^T\Omega^{-1}\mu-\mu^T\Omega^{-1}\theta+\mu^T\Omega^{-1}\mu)\}\\
&\propto\exp\{-\frac12(\theta^T\Omega^{-1}\theta-2\theta^T\Omega^{-1}\mu)\}\\
&=\exp\{-\frac12(\theta^TA_0\theta-2\theta^Tb_0)\}\\
\end{split}
$$

其中：

$$
\left\{\begin{split}
A_0&=\Omega^{-1}\\
b_0&=\Omega^{-1}\mu
\end{split}
\right.\label{eq4}
$$

根据式$\eqref{eq1}$，有Likelihood：

$$
\begin{split}
P(X\vert\theta,\Sigma)&=\prod_{i=1}^n\Big\{(2\pi)^{-p/2}\vert\Sigma\vert^{-1/2}\mathrm{exp}(-\frac12(X_i-\theta)^T\Sigma^{-1}(X_i-\theta))\Big\}\\
&\propto\mathrm{exp}(-\frac12\sum_{i=1}^n[(X_i-\theta)^T\Sigma^{-1}(X_i-\theta)])\\
&=\mathrm{exp}(-\frac12\sum_{i=1}^n[X_i^T\Sigma^{-1}X_i-X_i^T\Sigma^{-1}\theta-\theta^T\Sigma^{-1}X_i+\theta^T\Sigma^{-1}\theta])\\
&\propto\mathrm{exp}(-\frac12\sum_{i=1}^n[-2\theta^T\Sigma^{-1}X_i+\theta^T\Sigma^{-1}\theta])\\
&=\mathrm{exp}(-\frac12[-2\theta^T\Sigma^{-1}n\overline{X}+n\theta^T\Sigma^{-1}\theta])\\
&=\mathrm{exp}(-\frac12[\theta^Tn\Sigma^{-1}\theta-2\theta^Tn\Sigma^{-1}\overline{X}])\\
&=\mathrm{exp}(-\frac12[\theta^TA_1\theta-2\theta^Tb_1])\\
\end{split}
$$

其中：

$$
\left\{\begin{split}
A_1&=n\Sigma^{-1}\\
b_0&=n\Sigma^{-1}\overline{X}
\end{split}
\right.
$$

根据式$\eqref{eq3}$，有：

$$
\begin{split}
P(\theta\vert X,\Sigma)&\propto\mathrm{exp}\Big\{-\frac12\Big[\theta^T(A_0+A_1)\theta-2\theta^T(b_0+b_1)\Big]\Big\}\\
&=\mathrm{exp}\Big\{-\frac12\Big[\theta^TA_n\theta-2\theta^Tb_n\Big]\Big\}\\
\end{split}
$$

则有：

$$
\left\{\begin{split}
A_n&=\Omega^{-1}+n\Sigma^{-1}\\
b_n&=\Omega^{-1}\mu+n\Sigma^{-1}\overline{X}
\end{split}
\right.
$$

参照式$\eqref{eq4}$的关系，有：

$$
\left\{\begin{split}
\mu_n&=A_n^{-1}b_n=(\Omega^{-1}+n\Sigma^{-1})^{-1}(\Omega^{-1}\mu+n\Sigma^{-1}\overline{X})\\
\Sigma_n&=A_n^{-1}=(\Omega^{-1}+n\Sigma^{-1})^{-1}
\end{split}
\right.
$$

因此，$\theta$的后验估计也服从MVN，具体形式为：$\theta\sim \mathrm{MVN}(\mu_n,\Omega_n)$。

<br>

# Multivariate normal with known mean $\theta$

假设样本：

$$
X_1,\cdots,X_n\stackrel{i.i.d}{\sim}\mathrm{MVN}(\theta,\Sigma)
$$

其中总体分布的均值$\theta$已知，协方差矩阵$\Sigma$服从Inverse Wishart分布(见博客：[Wishart Distribution, Inverse-Wishart Distribution, Normal-Inverse-Wishart Distribution - What a starry night ~](http://whatastarrynight.com/mathematics/programming/Wishart-distributions/#inverse-wishart-distribution))，即$\Sigma\sim \mathrm{IW}(\nu_0,S_0^{-1})$

首先：

$$
P(\Sigma\vert\theta, X)=\dfrac{P(X,\Sigma\vert\theta)}{P(X)}=\dfrac{P(X\vert\Sigma,\theta)P(\Sigma)}{P(X)}\propto P(X\vert\Sigma,\theta)P(\Sigma)\label{eq5}
$$

由于$\Sigma\sim\mathrm{IW}(\nu_0,S_0^{-1})$，因此有：

$$
P(\Sigma)\propto \vert\Sigma\vert^{-(\nu_0+p+1)/2}\mathrm{exp}\{-\frac12\mathrm{tr}(S_0\Sigma^{-1})\}
$$

似然函数为：

$$
\begin{split}
P(X\vert\Sigma,\mu) &\propto \vert\Sigma\vert^{-n/2}\mathrm{exp}\{-\frac12\sum_i(X_i-\theta)^T\Sigma^{-1}(X_i-\theta)\}\\
&\propto \vert\Sigma\vert^{-n/2}\mathrm{exp}\{-\frac12\mathrm{tr}(S_\theta\Sigma^{-1})\}
\end{split}
$$

于是，根据式$\eqref{eq5}$可以得到：

$$
\begin{split}
P(\Sigma\vert\theta,X)\propto\vert\Sigma\vert^{-(n+\nu_0+p+1)/2}\mathrm{exp}\{-\frac12\mathrm{tr}((S_0+S_\theta)\Sigma^{-1})\}
\end{split}
$$

这表明，$\Sigma$的后验分布仍然是IW分布，即：

$$
\Sigma\vert X,\theta\sim\mathrm{IW}(\nu_n,S_n^{-1})
$$

其中：

$$
\left\{\begin{split}
\nu_n&=\nu_0+n\\
S_n&=(S_0+S_\theta)^{-1}
\end{split}
\right.
$$

这个后验是没有闭式解的，需要用到Gibbs采样：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221024222602877.png?raw=true" alt="image-20221024222602877" style="zoom: 67%;" />

<br>

**Reference**

[1] Rebecca C. Steorts. [The Multivariate Distributions: Normal and inverse Wishart](http://www2.stat.duke.edu/~rcs46/lecturesModernBayes/601-module10-multivariate-normal/multivariate-normal.pdf). Bayesian Methods and Modern Statistics: STA 360/601.

[2] Conjugate Prior - Wikipedia.

[3] [https://math.stackexchange.com/questions/2228398/trace-trick-for-expectations-of-quadratic-forms](https://math.stackexchange.com/questions/2228398/trace-trick-for-expectations-of-quadratic-forms).

[4] [https://en.wikipedia.org/wiki/Trace_(linear_algebra)#Cyclic_property](https://en.wikipedia.org/wiki/Trace_(linear_algebra)#Cyclic_property).

