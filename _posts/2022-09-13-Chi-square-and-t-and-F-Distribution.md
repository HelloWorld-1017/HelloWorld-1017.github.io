---
layout: single
title: Chi-square Distribution, Student's t Distribution, and F Distribution
date: 2022-09-13 17:34:37 +0800
categories: 
 - Mathematics
 - MATLAB
tags:
 - Probability Theory and Mathematical Statistics
 - MATLAB Statistics and Machine Learning Toolbox
---

# Chi-square  Distribution

## PDF

若$n>0$，则函数：

$$
k_n(x)=\left\{\begin{split}
&\dfrac{1}{\Gamma(\dfrac{n}2)2^{n/2}}e^{-x/2}x^{(n-2)/2},\quad&x>0\\
&0,\quad&x\le0
\end{split}\right.\label{eq1}
$$


首先，该函数非负；并且：

$$
\begin{split}
&\int_{-\infty}^{+\infty}k_n(x)\mathrm{d}x=\int_{0}^{+\infty}k_n(x)\mathrm{d}x=\dfrac{1}{\Gamma(\dfrac{n}2)2^{n/2}}\int_{0}^{+\infty}e^{-x/2}x^{(n-2)/2}\mathrm{d}x
\end{split}\notag
$$

其中的积分部分可以简化为（令$x=2t$)

$$
\int_{0}^{+\infty}e^{-x/2}x^{(n-2)/2}\mathrm{d}x=2\int_{0}^{+\infty}e^{-t}(2t)^{(n-2)/2}\mathrm{d}t=2^{n/2}\int_0^{+\infty}e^{-t}t^{(n-2)/2}\mathrm{d}t=2^{n/2}\Gamma(n/2)\notag
$$

即有

$$
\int_{-\infty}^{+\infty}k_n(x)\mathrm{d}x=1\notag
$$

因此，函数$\eqref{eq1}$满足非负性且在积分区间内的积分值为1，因此是一个概率密度函数。这个概率密度函数，被称为“自由度为n的皮尔逊卡方密度”，相应的分布称为卡方分布(chi-square distribution)，记作$\chi_n^2$。

## Relation to Normal Distribution

若$X_1, \cdots, X_n$独立同分布，且服从正态分布$N(0,1)$，则$Y=X_1^2+\cdots+X_n^2$服从自由度为$n$的卡方分布$\chi_n^2$。

证明（归纳法）：

（1）当$n=1$时，有$Y=X_1^2$。

$$
\begin{split}
G(y)&=P(Y\le y)=P(X_1^2\le y)=P(-\sqrt{y}\le X_1\le \sqrt{y})\\
&=\int_{-\sqrt{y}}^{\sqrt{y}}f(x)\mathrm{d}x\\
\end{split}\notag
$$

上式两端对$y$求导：

$$
\begin{split}
g(y)&=\dfrac12y^{-1/2}[f(\sqrt{y})+f(-\sqrt{y})]\\
&=(\sqrt{2\pi y})^{-1}e^{-y/2}
\end{split}\notag
$$

对比式$\eqref{eq1}$，可以得到$g(y)=k_1(y)$。

（2）假设对于$k=n-1$均成立，即有$Z=X_1^2+\cdots+X_{n-1}^2$，$Z\sim \chi^2_{n-1}$，则$Y=Z+X_n^2$，且$X_n^2\sim\chi_1^2$。由附录C的定理1，有$Z$和$X_n^2$相互独立。于是根据附录A的公式$\eqref{aeq3}$，可以得到$Y$的密度函数为：

$$
\begin{split}
f(y)&=\int_{-\infty}^{+\infty}k_{n-1}(x)k_1(y-x)\mathrm{d}x\\
&=\Big(\Gamma(\dfrac{n-1}{2})\Gamma(\dfrac12)2^{n/2}\Big)^{-1}e^{-y/2}\int_0^yx^{(n-3)/2}(y-x)^{-1/2}\mathrm{d}x
\end{split}\label{eq2}
$$

在积分中做变量代换$x=yt$，得：

$$
\begin{split}
\int_0^yx^{(n-3)/2}(y-x)^{-1/2}\mathrm{d}x&=y^{(n-2)/2}\int_0^1t^{(n-1)/2-1}(1-t)^{-1/2}\mathrm{d}t\\
&=y^{(n-2)/2}\mathrm{B}(\dfrac{n-1}{2},\dfrac12)\\
&=y^{(n-2)/2}\Gamma(\dfrac{n-1}{2})\Gamma(\dfrac12)/\Gamma(\dfrac{n}2)
\end{split}\label{eq3}
$$

其中，$\mathrm{B}$为Beta函数，它与$\Gamma$函数的关系见：[Gamma函数和Beta函数的定义及性质 - What a starry night~](http://whatastarrynight.com/mathematics/GammaAndBetaFunction/)。

将式$\eqref{eq3}$带入式$\eqref{eq2}$，可以得到：

$$
f(y)=\dfrac{1}{\Gamma(\dfrac{n}{2})2^{n/2}}e^{-y/2}y^{(n-2)/2}\notag
$$

上式与$\eqref{eq1}$一致，即对于$k=n$成立，QED。

## Properties of Chi-square Distribution

**性质1**：设$X_1$，$X_2$独立，$X_1\sim\chi_m^2$，$X_2\sim\chi_n^2$，则$X_1+X_2\sim\chi_{m+n}^2$。

**性质2**：若$X_1,\cdots,X_n$独立，且都服从指数分布，则：

$$
X=2\lambda(X_1+\cdots+X_n)\sim\chi_{2n}^2\notag
$$



<br>

## `chi2pdf` and `chi2cdf` in MATLAB

$t_4(x)$的PDF和CDF：

```matlab
clc, clear, close all

% Compute the pdf of a chi-square distribution with 4 degrees of freedom.
x = 0:0.2:15;
chi2p = chi2pdf(x, 4);

figure('Units', 'pixels', 'Position', [335, 352, 886, 669])
LineWidth = 1;
% Plot the PDF
nexttile
plot(x, chi2p, LineWidth=LineWidth)
xlabel('Observation')
ylabel('Probability Density')
grid on
box on
% The chi-square distribution is skewed to the right, especially for few degrees of freedom.

% Compute the cdf of a chi-square distribution with 4 degrees of freedom.
chi2c = chi2cdf(x, 4);
% Plot the CDF
nexttile
plot(x, chi2c, LineWidth=LineWidth)
xlabel('Observation')
ylabel('Cumulative Probability')
grid on
box on
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918144328163.png?raw=true" alt="image-20220918144328163" style="zoom:50%;" />

<br>

# Student’s t Distribution

## PDF

设$X_1$，$X_2$独立，$X_1\sim\chi_n^2$，$X_2\sim N(0,1)$，而$Y=X_2/\sqrt{X_1/n}$，求$Y$的概率密度函数。

解：

记$Z=\sqrt{X_1/n}$，则：

$$
F(z)=P(X\le z)=P(\sqrt{X_1/n}\le z)=P(X_1\le nz^2)=\int_0^{nz^2}k_n(x)\mathrm{d}x\notag
$$

其中，$k_n(x)$为卡方分布的概率密度函数。上式两边对$z$求导，得到：

$$
f(z)=2nzk_n(nz^2)=2nz\Big(\Gamma(n/2)2^{n/2}\Big)^{-1}e^{-nz^2/2}(nz^2)^{(n-2)/2}\notag
$$

根据式附录B的$\eqref{ceq2}$，可以得到：

$$
f(y)=(\sqrt{2\pi})^{-1}\Big(2^{n/2}\Gamma(n/2)\Big)^{-1}2n^{n/2}\int_0^\infty x_1^n\exp\Big[-\dfrac12(nx_1+x_1^2y^2)\Big]\notag
$$

令$x_1=\sqrt{2/(n+y^2)}\sqrt{t}$，则上式的积分部分为：

$$
\dfrac12(\dfrac2{n+y^2})^{(n+1)/2}\int_0^\infty e^{-t}t^{(n-1)/2}\mathrm{d}t=\dfrac12(\dfrac2{n+y^2})^{(n+1)/2}\Gamma(\dfrac{n+1}2)\notag
$$

于是：

$$
f(y)=\dfrac{\Gamma((n+1)/2)}{\sqrt{n\pi}\Gamma(n/2)}(1+\dfrac{y^2}{n})^{-(n+1)/2}\label{ceq3}
$$

式$\eqref{ceq3}$就是**自由度为$n$的$t$分布**的概率密度函数，常记为$t_n$，即$Y\sim t_n$。这个分布是英国统计学家W·哥色特在1907年以“Student”的笔名首次发表。由概率密度函数可以看出，**该概率密度函数关于原点对称**。当自由度$n$很大时，$t$分布接近于标准正态分布。

## `tpdf` and  `tcdf` in MATLAB

```matlab
clc, clear, close all

% Compute the pdf of a Student's t distribution 
% with degrees of freedom equal to 5, 10, and 50.
x = -5:.1:5;
tp1 = tpdf(x, 5);
tp2 = tpdf(x, 10);
tp3 = tpdf(x, 50);
% Compute the pdf of standard normal dist.
tpn = normpdf(x,0,1);

figure('Units', 'pixels', 'Position', [335, 352, 886, 669])
LineWidth = 1;
% Plot the pdf for all three choices n, and standard normal dist. on the same axis.
nexttile
hold on
plot(x, tp1, 'Color', 'green', 'LineStyle', '-', LineWidth=LineWidth)
plot(x, tp2, 'Color', 'red', 'LineStyle','-.', LineWidth=LineWidth)
plot(x, tp3, 'Color', 'blue', 'LineStyle','--', LineWidth=LineWidth)
plot(x, tpn, 'Color', 'black', 'LineStyle','-', LineWidth=LineWidth)
xlabel('Observation')
ylabel('Probability Density')
legend({'n = 5', 'n = 10', 'n = 50', 'Standard norm'})
grid on
box on

% Compute the cdf of a Student's t distribution 
% with degrees of freedom equal to 5, 10, and 50.
tc1 = tcdf(x, 5);
tc2 = tcdf(x,10);
tc3 = tcdf(x, 50);
% Compute CDF of standard normal dist.
tcn = normcdf(x, 0, 1);

% Plot the cdf for all three choices of nu, and standard normal dist. on the same axis.
nexttile
hold on
plot(x, tc1, 'Color', 'green', 'LineStyle', '-', LineWidth=LineWidth)
plot(x, tc2, 'Color', 'red', 'LineStyle', '-.', LineWidth=LineWidth)
plot(x, tc3, 'Color', 'blue', 'LineStyle', '--', LineWidth=LineWidth)
plot(x, tcn, 'Color', 'black', 'LineStyle', '--', LineWidth=LineWidth)
xlabel('Observation')
ylabel('Cumulative Probability')
legend({'n = 5','n = 10','n = 50', 'Standard norm'})
grid on
box on
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918124835599.png?raw=true" alt="image-20220918124835599" style="zoom:50%;" />

<br>

# F Distribution

## PDF

设$X_1$，$X_2$相互独立，$X_1\sim\chi_n^2$，$X_2\sim\chi_m^2$，而$Y=m^{-1}X_2/n^{-1}X_1$，求$Y$的概率密度函数。

解：

因为$X_1$，$X_2$相互独立，根据附录C，$n^{-1}X_1$和$m^{-1}X_2$也独立。

令$Z=n^{-1}X_1$，则：

$$
F(z)=P(n^{-1}X_1\le z)=P(X_1\le nz)=K_n(nz)\notag
$$

两端对$z$求导，可以得到：

$$
f(z)=nk_n(nz)\notag
$$

即$n^{-1}X_1$的PDF为$nk_n(nx_1)$，同理$m^{-1}X_2$的PDF为$mk_n(mx_2)$，根据附录B的公式$\eqref{ceq2}$，可以得到：

$$
\begin{split}
f_{mn}(y)=&\int_0^\infty x_1nk_n(nx_1)\cdot mk_m(mx_1y)\mathrm{d}x_1\\
=&\Big[2^{(m+n)/2}\Gamma{(m/2)}\Gamma{(n/2)}\Big]^{-1}m^{m/2}n^{n/2}y^{m/2-1}\\
&\cdot\int_0^\infty e^{-(my+n)x_1/2}x_1^{(m+n)/2-1}\mathrm{d}x_1
\end{split}\notag
$$

做变量代换$t=(my+n)x_1/2$，则上式的积分部分可以化为：

$$
\begin{split}
&\int_0^\infty e^{-(my+n)x_1/2}x_1^{(m+n)/2-1}\mathrm{d}x_1\\
=&2^{(m+n)/2}(my+n)^{-(m+n)/2}\int_0^{\infty}e^{-t}t^{(m+n)/2-1}\mathrm{d}t\\
=&2^{(m+n)/2}(my+n)^{-(m+n)/2}\Gamma(\dfrac{m+n}2)
\end{split}\notag
$$

最终，可以得到：

$$
f_{mn}(y)=m^{m/2}n^{n/2}\dfrac{\Gamma(\dfrac{m+n}2)}{\Gamma(\dfrac{m}2)\Gamma(\dfrac{n}2)}y^{m/2-1}(my+n)^{-(m+n)/2}\quad (y>0)
$$

当$y\le 0$时$f_{mn}(y)=0$，因为$Y$只取正值。

这个分布称为“自由度为$(m,n)$的F分布”（注意，分子的自由度在前），常记作$F_{mn}$，即$Y\sim F_{mn}$。

## `fpdf` and `fcdf` in MATLAB

$y\sim F(5, 3)$的PDF和CDF：

```matlab
% Compute the pdf and cdf of an F distribution 
% with 5 numerator degrees of freedom and 3 denominator degrees of freedom.
x = 0:0.01:10;
fp = fpdf(x, 5, 3);
fc = fcdf(x, 5, 3);

figure('Units', 'pixels', 'Position', [335, 352, 886, 669])
LineWidth = 1;
% Plot the PDF
nexttile
plot(x, fp, LineWidth=LineWidth)
xlabel('Observation')
ylabel('Probability Density')
grid on
box on
% The plot shows that the F distribution exists on positive real numbers and is skewed to the right.

% Plot the CDF
nexttile
plot(x, fc, LineWidth=LineWidth)
xlabel('Observation')
ylabel('Cumulative Probability')
grid on
box on
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918140922103.png?raw=true" alt="image-20220918140922103" style="zoom:50%;" />



<br>

# Chi-square Distribution, Student’s t Distribution, F Distribution

人们有时把$\chi^2$，$t$和$F$这三个分布合称为“统计上的三大分布”，就是因为它们在统计学上有广泛的应用。这些应用的相当大一部分根由，在于以下几条重要性质。

**性质1**：设$X_1$，$\cdots$，$X_n$独立同分布，并服从公共的正态分布$N(\mu, \sigma^2)$，记$\overline{X}=(X_1+\cdots+X_n)/n$，$S^2=\sum_i^n(X_i-\overline{X})^2/(n-1)$，则：

$$
(n-1)S^2/\sigma^2=\sum^n_{i=1}(X_i-\overline{X})^2/\sigma^2\sim\chi_{n-1}^2
$$

**性质2**：设$X_1$，$\cdots$，$X_n$的假定同性质1，则：

$$
\sqrt{n}(\overline{X}-\mu)/S\sim t_{n-1}
$$

**性质3**：设$X_1$，$\cdots$，$X_n$，$Y_1$，$\cdots$，$Y_m$独立，$X_i$各有分布$N(\mu_1,\sigma_1^2)$，$Y_j$各有分布$N(\mu_2,\sigma_2^2)$，则：

$$
\Big[\sum_{j=1}^m(Y_j-\overline{Y})^2/(\sigma_2^2(m-1))\Big]/\Big[\sum_{i=1}^n(X_i-\overline{X})^2/(\sigma_1^2(n-1))\Big]\sim F_{m-1,n-1}
$$

若$\sigma_1^2=\sigma_2^2$，则：

$$
\sqrt{\dfrac{nm(n+m-2)}{n+m}}[(\overline{X}-\overline{Y})-(\mu_1-\mu_2)]/\Big[\sum_{i=1}^n(X_i-\overline{X})^2+\sum_{j=1}^m(Y_j-\overline{Y})^2\Big]^{1/2}\sim t_{n+m-2}
$$

<br>


# Appendix

## A: Proof 1, Distribution of Sum of Random Variables

设$(X_1, X_2)$的联合概率密度函数为$f(x_1, x_2)$，求$Y=X_1+X_2$的概率密度。

解：

$$
F(y)=P(Y\le Y)=P(X_1+X_2\le y)\notag
$$

从几何角度上看，这个概率是$X_1$-$X_2$平面中直线$X_1+X_2\le y$下面积所对应的概率密度的二重积分

$$
F(y)=\iint_S f(x_1,x_2)\mathrm{d}S\notag
$$

将二重积分化为累计积分

$$
F(y)=\int_{-\infty}^{+\infty}\Big(\int_{-\infty}^{y-x_1}f(x_1,x_2)\mathrm{d}x_2\Big)\mathrm{d}x_1\notag
$$

两端对$y$求导

$$
\begin{split}
f(y)&=\int_{-\infty}^{+\infty}f(x_1,y-x_1)-f(x_1,-\infty)\mathrm{d}x_1\\
&=\int_{-\infty}^{+\infty}f(x_1,y-x_1)\mathrm{d}x_1\\
\end{split}\notag
$$

即

$$
f(y)=\int_{-\infty}^{+\infty}f(x,y-x)\mathrm{d}x\label{aeq1}
$$

并且等价于

$$
f(y)=\int_{-\infty}^{+\infty}f(y-x,x)\mathrm{d}x\label{aeq2}
$$

若$X_1$，$X_2$相互独立，则$f(x_1,x_2)=f_1(x)f_2(x)$，这时式$\eqref{aeq1}$和$\eqref{aeq2}$可以转化为如下的形式

$$
f(y)=\int_{-\infty}^{+\infty}f_1(x)f_2(y-x)\mathrm{d}x=\int_{-\infty}^{+\infty}f_1(y-x)f_2(x)\mathrm{d}x\label{aeq3}
$$

## B: Proof 2, Distribution of Quotients of Random Variables

设$(X_1, X_2)$有联合概率密度函数$f(x_1,x_2)$，$Y=X_2/X_1$，求$Y$的概率密度函数。为简单计，限制$X_1$只取正值。

解：

$$
F(y)=P(Y\le y)=P(X_2\le X_1y)\notag
$$

该值等于下图所示面积的二元积分：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918110212576.png?raw=true" alt="image-20220918110212576" style="zoom:50%;" />

计算二重积分，并将其转换为累次积分：

$$
\begin{split}
F(y)=P(Y\le y)&=\iint_Bf(x_1,x_2)\mathrm{d}x_1\mathrm{d}x_2\\
&=\int_0^\infty\Big[\int_{-\infty}^{x_1y}f(x_1,x_2)\mathrm{d}x_2\Big]\mathrm{d}x_1
\end{split}\notag
$$

上式两端同时对$y$求导，有：

$$
f(y)=\int_0^\infty x_1f(x_1,x_1y)\mathrm{d}x_1\label{ceq1}
$$

若$X_1$，$X_2$独立，则$f(x_1,x_2)=f_1(x_1)f_2(x_2)$，则上式可写为：

$$
f(y)=\int_0^\infty x_1f_1(x_1)f_2(x_1y)\mathrm{d}x_1\label{ceq2}
$$


## C: Theorem 1

若$X_1,\cdots, X_n$相互独立，而$Y_1=g_1(X_1,\cdots,X_m)$，$Y_2=g_2(X_{m+1},\cdots,X_n)$，则$Y_1$和$Y_2$相互独立。

显然成立。

<br>

**参考**

[1] 概率论与数理统计. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.2(2019.8重印).

[2] [Chi-Square Distribution - MathWorks](https://ww2.mathworks.cn/help/stats/chi-square-distribution.html).

[3] [Student's t Distribution - MathWorks](https://ww2.mathworks.cn/help/stats/students-t-distribution.html).

[4] [F Distribution - MathWorks](https://ww2.mathworks.cn/help/stats/f-distribution.html).