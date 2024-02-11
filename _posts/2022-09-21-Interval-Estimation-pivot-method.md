---
layout: single
title: "Interval Estimation: Pivot Method"
date: 2022-09-21 19:15:11 +0800
categories: 
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
 - Hypothesis Test
last_modified_at0: 2022-09-21 19:15:11 +0800
last_modified_at1: 2023-11-11 21:45:51 +0800
last_modified_at2: 2024-02-10 23:10:52 +0800
last_modified_at: 2024-02-10 23:10:52 +0800
---

# Definition

点估计是用一个点（即一个数）去估计未知参数，而区间估计就是用一个区间去估计未知参数，即把未知参数值估计在某两个界限之内。区间估计是用一种很常用的估计形式，可以把尽可能的误差用醒目的形式标出来，人们会相信在做估计时，已把可能出现的误差考虑到了，多少跟人们以更大的信任感。

现今最流行的一种区间估计理论是原籍波兰的美国统计学家J·奈曼在20世纪30年代建立起来的，其理论的基本概念很简单。为简单计，我们假设总体分布只包含一个位置参数$\theta$，且要估计的就是$\theta$本身。如果总体分布包含着若干个未知参数$\theta, \cdots, \theta_k$，而要估计的是$g(\theta_1, \cdots, \theta_k)$，基本概念并无不同。

设$X_1,\cdots, X_n$是从该总体中抽出的样本。所谓$\theta$的区间估计，就是估计满足条件$\hat{\theta}_1(X_1, \cdots, X_n)\le \hat{\theta}_2(X_1, \cdots, X_n)$的两个统计量$\hat{\theta}_1$，$\hat{\theta}_2$为端点的区间$[\hat{\theta}_1,\hat{\theta}_2]$。一旦有了样本$X_1,\cdots, X_n$，就把$\theta$估计在区间$[\hat{\theta}_1(X_1, \cdots, X_n),\ \hat{\theta}_2(X_1, \cdots, X_n)]$之内。

N.B.: 再次强调，区间端点为统计量。
{: .notice--primary}

这里有两个要求：

（1）$\theta$要以很大的可能性落在区间$[\hat{\theta}_1,\hat{\theta}_2]$内，也就是说：

$$
P_\theta\Big(\hat{\theta}_1(X_1, \cdots, X_n)\le\theta\le\hat{\theta}_2(X_1,\cdots,X_n)\Big)\label{eq1}
$$

要尽可能大；

（2）估计的精度要尽可能高。比方说，要求区间的长度$\hat{\theta}_2-\hat{\theta}_1$尽可能小，或者某种能体现这个要求的其他准则。

比如，估计一个人的年龄在某一区间内，例如$[30,35]$内，我们要求这个估计尽可能可靠（可靠性），即这个人的年龄有很大的把我的确在这个区间内。同时，也要求区间不能太大（精度）。比如，估计一个人的年龄在10~90岁之间，当然可靠了，但是精度太差。

**但是这两个要求是相互矛盾的**。区间估计理论和方法的基本问题，就是在已有的样本资源下，怎样找出更好的估计方法，以尽量提高可靠性和精度，但最终有一定的限度。奈曼提出并为现今所广泛接受的原则是：**先保证可靠性，在这个前提下尽可能使精度提高**。为此，他引出了如下的定义：

Definition：给定一个很小的数$\alpha>0$，如果对参数$\theta$的任何值，概率$\eqref{eq1}$都等于$1-\alpha$，则称区间估计$[\hat{\theta}_1,\hat{\theta}_2]$的**置信系数**为$1-\alpha$。
{: .notice--primary}

估计区间也常称为是“置信区间”，即对该区间包含未知参数$\theta$可置信到何种程度，例如95%置信区间。

有时，我们无法证明概率$\eqref{eq1}$对一切$\theta$都恰好等于$1-\alpha$，但是知道它不会小于$1-\alpha$，则称$1-\alpha$为$[\hat{\theta}_1,\hat{\theta}_2]$的**置信水平**。因此，置信水平不是唯一的数，因为若概率$\eqref{eq1}$总不小于0.8，那么它也总不小于0.7，0.6，…也就是说，若$\beta$为置信水平，那么小于$\beta$的数也是置信水平，置信系数是置信水平中的最大者。但是在实践中，人们并不总是将这两个术语严加区别，这要看各人习惯。

定义中的$\alpha$也成为显著性水平，一般取0.05最多，还有取0.01，0.10，甚至0.001等，视情况需要使用。这几个数字本身并无特殊含义，主要是标准化后造表方便。

<br>

# Pivot Method

## Example 0: Normal Distribution, Interval Estimation of  $\mu$ with Known $\sigma^2$

假设$X_1,\cdots, X_n$抽自正态总体$N(\mu,\sigma^2)$的样本，$\sigma^2$已知，求$\mu$的区间估计。

解：

**首先选择一个$\mu$的良好的点估计**，这里选择样本均值$\overline{X}$。由总体分布为正态分布可以得到：

$$
\sqrt{n}(\overline{X}-\mu)/\sigma\sim N(0,1)=\Phi(x)\label{eq2}
$$

定义$u_\beta$为分布$N(0,1)$的**上$\beta$分位点**，其含义是$N(0,1)$分布中大于$u_\beta$的那部分的概率就是$\beta$。

N.B.: 上$\beta$分位点的概念可以推广到任何分布$F$：满足$F(v_\beta)=1-\beta$的点$v_\beta$就是分布函数$F$的上$\beta$分位点。在数理统计学中，除了正态分布外，“统计三大分布”的上分位点很常用。
{: .notice--primary}

因此，根据公式$\eqref{eq2}$和上$\beta$分位点的定义，并且对于标准正态分布有：$\Phi(-x)=1-\Phi(x)$，于是可以得到：

$$
P(-u_{\alpha/2}\le\sqrt{n}(\overline{X}-\mu)/\sigma\le u_{\alpha/2})=\Phi(u_{\alpha/2})-\Phi(-u_{\alpha/2})=(1-\alpha/2)-\alpha/2=1-\alpha\notag
$$

这个式子可以改写为：

$$
P(\overline{X}-\sigma u_{\alpha/2}/\sqrt{n}\le\mu\le \overline{X}+\sigma u_{\alpha/2}/\sqrt{n})=1-\alpha\notag
$$

该式表明：

$$
[\hat{\theta}_1,\hat{\theta}_2]=[\overline{X}-\sigma u_{\alpha/2}/\sqrt{n},\ \overline{X}+\sigma u_{\alpha/2}/\sqrt{n}]\label{eq0}
$$

可作为$\mu$的区间估计，置信系数为$1-\alpha$。

由这个例子，我们可以发现一种找区间估计的一半方法，可总结为：

1. 找出一个与要顾及的参数$g(\theta)$有关的统计量$T$，一般是找其一个良好的点估计（此例中$T$为$\overline{X}$）；
2. 设法找出$T$和$g(\theta)$的某一函数$S(T,g(\theta))$，其分布$F$与$\theta$无关，S称为**轴枢变量**（在此例中，$S(T,g(\theta))$为$\sqrt{n}(\overline{X}-\mu)/\sigma$，分布$F$就是$\Phi(x)$）；
3. 对任何常数$a<b$，不等式$a\le S(T,g(\theta))\le b$要能改写为等价的形式$A\le g(\theta)\le B$，其中，$A$和$B$只与$T$，$a$，$b$有关，而与$\theta$无关；
4. 一般$B$和$A$取为分布$F$的上$\alpha/2$分位点$w_{\alpha/2}$和上$1-\alpha/2$分位点$w_{1-\alpha/2}$，则有$F(w_{\alpha/2})-F(w_{1-\alpha/2})=1-\alpha$，因此有$P(w_{1-\alpha/2}\le S(T,g(\theta))\le w_{\alpha/2})=1-\alpha$。根据第3条，不等式$w_{1-\alpha/2}\le S(T,g(\theta))\le w_{\alpha/2}$可改写为$A\le g(\theta)\le B$的形式，$A$，$B$均与$T$有关，因而与样本有关。$[A, B]$就是$g(\theta)$的一个置信度为$1-\alpha$的区间估计。

## Example 1: Normal Distribution, Interval Estimation of $\mu$ with Unknown $\sigma^2$

从正态分布$N(\mu,\sigma^2)$中抽取样本$X_1,\cdots, X_n$，$\mu$和$\sigma^2$都未知，求$\mu$的区间估计。

解：

$\mu$的点估计仍取为样本方差$\overline{X}$，但是$\sqrt{n}(\overline{X}-\mu)/\sigma$不能再作为轴枢变量，因为$\sigma$是未知量，条件3无法满足。因此需要把$\sigma$修改为样本标准差。因为$\sqrt{n}(\overline{X}-\mu)/S$服从自由度为$n-1$的t分布，与参数无关。于是有：

$$
P\Big(t_{n-1}(1-\alpha/2)\le\sqrt{n}(\overline{X}-\mu)/S\le t_{n-1}(\alpha/2)\Big)=1-\alpha\notag
$$

又因为$t$分布的PDF关于$x=0$对称，即$t_{n-1}(1-\alpha/2)=-t_{n-1}(\alpha/2)$，于是上式可化为：

$$
P\Big(-t_{n-1}(\alpha/2)\le\sqrt{n}(\overline{X}-\mu)/S\le t_{n-1}(\alpha/2)\Big)=1-\alpha\notag
$$

于是可以得到：

$$
P(\overline{X}-St_{n-1}(\alpha/2)/\sqrt{n}\le\mu\le\overline{X}+St_{n-1}(\alpha/2)/\sqrt{n})=1-\alpha\notag
$$

即，$\mu$的置信度为$1-\alpha$的一个区间估计为：

$$
[\overline{X}-St_{n-1}(\alpha/2)/\sqrt{n},\ \overline{X}+St_{n-1}(\alpha/2)/\sqrt{n}]\label{eq3}
$$

例如，为估计一件物体的重量$\mu$，把它在天平上重复称了5次， 得结果为（单位为克）：5.52，5.48，5.64，5.51，5.43。假设该天平无系统误差，且随机误差服从正态分布，则总体分布为$N(\mu,\sigma^2)$，$\mu$为未知的要估计的重量，方差$\sigma^2$未知，可以算出：

$$
\begin{align*}
&\overline{X}=(5.52+\cdots+5.43)/5=5.516\\
&S=\sqrt{\dfrac1{5-1}[(5.52-5.516)^2+\cdots+(5.43-5.516)^2]}=0.0777
\end{align*}
$$

> MATLAB代码：
>
> ```matlab
> [lowerCI, upperCI] = helperGetCI([5.52, 5.48, 5.64,5.51,5.43], 0.95)
> 
> function [lowerCI, upperCI] = helperGetCI(X, alpha)
> num = numel(X);
> X_bar = mean(X);
> S = std(X);
> t_nminus1 = tinv((1-alpha)/2, num-1);
> 
> lowerCI = X_bar-S*t_nminus1/sqrt(num);
> upperCI = X_bar+S*t_nminus1/sqrt(num);
> end
> ```
>
> ```matlab
> lowerCI =
>     5.6124
> 
> upperCI =
>     5.4196
> ```

查“t分布上侧分位点$t_n(\alpha)$表”，可以得到$t_4(0.025)=2.776$，将这些数值代入到$\eqref{eq3}$可以得到$\mu$的置信度为0.95的区间估计为$[5.4195, 5.6125]$。

$[5.4195, 5.6125]$是一个具体的区间，说这个区间的置信系数为0.95，其确切含义是：**它是根据所有的数据，用一个置信系数为0.95的方法做出的**。因此，“置信系数”这个词是针对方法的，用这个方法做出的区间估计，平均100次有95次地区包含所有估计的值。**一旦算出具体区间，就不能再说它有95%的机会包含要估计的值了**。这一点意义上的理解必须分清，正如说一个人擅长挑西瓜，他挑的瓜平均100个有95个好的。某天他给你挑了一个，结果或好或坏，必居其一，而不是95%地好。但是，考虑到他挑瓜地技术，我对他挑的瓜比较放心（也是对他挑瓜的技术比较放心），这就是置信系数。

区间$\eqref{eq3}$叫做**一样本t区间估计**，“一样本”是指这里只有一个总体，因而只有一组样本，以区别与下例。

## Example 2: Normal Distribution, Interval Estimation of  $\mu_1-\mu_2$

设有两个正态分布，其分布分别为$N(\mu_1,\sigma^2)$和$N(\mu_2,\sigma^2)$（注意方差相同）。设$\mu_1$，$\mu_2$，$\sigma^2$都未知。现从这两个总体中分别抽出样本$X_1,\cdots,X_n$和$Y_1,\cdots,Y_m$，求$\mu_1-\mu_2$的区间估计。

解：

根据文章[Chi-square Distribution, Student’s t Distribution, and F Distribution](http://whatastarrynight.com/mathematics/programming/Chi-square-and-t-and-F-Distribution/#chi-square-distribution-students-t-distribution-f-distribution)提到的t分布的性质（性质3），令：

$$
S=\Big[\sum^n_{i=1}(X_i-\overline{X})^2+\sum_{j=1}^m(Y_j-\overline{Y})^2\Big]^{1/2}/\sqrt{n+m-2}\notag
$$

则有分布：

$$
T=\sqrt{\dfrac{mn}{m+n}}\Big[(\overline{X}-\overline{Y})-(\mu_1-\mu_2)\Big]/S\sim t_{n+m-2}\notag
$$

分布$T$不依赖于参数$\mu_1,\mu_2,\sigma^2$，它适合于作为轴枢变量的条件。因此有：

$$
P\Big(-t_{n+m-2}(\alpha/2)\le\sqrt{\dfrac{mn}{m+n}}\Big[(\overline{X}-\overline{Y})-(\mu_1-\mu_2)\Big]/S\le t_{n+m-2}(\alpha/2)\Big)=1-\alpha\notag
$$

最终，得到$\mu_1-\mu_2$的置信度为$1-\alpha$区间估计为：

$$
\Big[(\overline{X}-\overline{Y})-St_{n+m-2}(\alpha/2)\sqrt{\dfrac{n+m}{nm}},\ (\overline{X}-\overline{Y})+St_{n+m-2}(\alpha/2)\sqrt{\dfrac{n+m}{nm}}\Big]\label{eq4}
$$

这个区间称为**两样本t区间估计**，是应用上常用的区间估计之一。

还是针对上面天平称物体的例子，假设有另外一个物体，其重量$\mu_2$也未知。在这同一架天平上称4次，得到结果为：5.45，5.40，5.34，5.51。则有：

$$
\begin{align*}
&\overline{X}=5.516\\
&\sum_{i=1}^n(X_i-\overline{X})^2=(5.52-5.516)^2+\cdots+(5.43-5.516)^2=0.0241\\
&\overline{Y}=(5.45+\cdots+5.51)/4=5.425\\
&\sum_{j=1}^m(Y_j-\overline{Y})^2=(5.45-5.425)^2+\cdots+(5.51-5.425)^2=0.01570\\
&\overline{X}-\overline{Y}=0.091\\
&S=\sqrt{0.0241+0.01570}/\sqrt{5+4-2}=0.0754
\end{align*}
$$

查表有$t_7(0.025) = 2.365$，代入相关数值可以得到$\mu_1-\mu_2$置信系数为0.95的区间估计为：$[-0.2106, 0.0286]$。

<br>

如果我们单独对第二件物体的质量$\mu_2$做一样本t区间估计。

首先有$\overline{Y}=5.425$，$S_y=\sqrt{\dfrac1{4-1}\sum_{j=1}^m(Y_j-\overline{Y})^2}=\sqrt{1/3\times0.01570}=0.0723$，$t_3(0.025)=3.182$，代入公式$\eqref{eq3}$可以得到$\mu_2$的置信系数为0.95的区间估计为：$[5.3100, 5.5400]$。

综上，物体一的质量$\mu_1$的置信系数为95%的区间估计是：$[5.4195, 5.6125]$，物体二的质量$\mu_2$的置信系数为95%的区间估计是$[5.3100, 5.5400]$，而$\mu_1-\mu_2$的置信系数为95%的区间估计是$[-0.2106, 0.0286]$，它们之间并不是区间端点直接加减的关系。

另外，需要说明的是，在实际问题中，两个总体方差相等的假定往往只是近似成立，当方差之比接近1时，使用$\eqref{eq4}$产生的误差不大（这里的误差是指实际的置信系数与名义的置信系数$1-\alpha$有出入。如果差别较大，则必须假定两个正态分布总体分别有方差$\sigma_1^2$和$\sigma_1^2$，$\sigma_1^2$和$\sigma_1^2$都未知。在这样的假定下，求$\mu_1-\mu_2$的区间估计问题，是数理统计学上一个著名的问题，称为**贝伦斯—费歇尔问题**，因为这两位学者分别在1929年和1930年研究过这个问题，他们以及后来的研究者提出过一些解法，但还没有一个被公认为是最满意的。

我觉得可能是因为在这种情况下$\mu_1-\mu_2$太难构造出来了。
{: .notice--primary}

## Example 3: Normal Distribution, Interval Estimation of $\sigma^2$

假设从正态分布$N(\mu,\sigma^2)$中抽取样本$X_1,\cdots, X_n$，$\mu$和$\sigma^2$都未知，求$\sigma^2$的区间估计。

解：

根据文章[Chi-square Distribution, Student’s t Distribution, and F Distribution](http://whatastarrynight.com/mathematics/programming/Chi-square-and-t-and-F-Distribution/#chi-square-distribution-students-t-distribution-f-distribution)提到的卡方分布的性质（性质1），有：

$$
(n-1)S^2/\sigma^2\sim \chi_{n-1}^2\notag
$$

因此，根据轴枢变量法，$\sigma^2$的置信系数为$1-\alpha$的区间估计为：

$$
[(n-1)S^2/\chi_{n-1}^2(\alpha/2),\ (n-1)S^2/\chi_{n-1}^2(1-\alpha/2)]\label{eq5}
$$

## Example 4: Normal Distribution $\sigma_1^2/\sigma_2^2$

假设从正态分布$N(\mu_1,\sigma_1^2)$中抽取样本$X_1,\cdots, X_n$，从分布$N(\mu_2, \sigma_2^2)$从中抽出样本$Y_1,\cdots,Y_m$，要做方差比$\sigma_1^2/\sigma_2^2$的区间估计。

解：

记$S_1^2$和$S_2^2$分别为$X_1,\cdots,X_n$和$Y_1,\cdots,Y_n$的样本方差，根据文章[Chi-square Distribution, Student’s t Distribution, and F Distribution - What a starry night~](https://helloworld-1017.github.io/mathematics/matlab/Chi-square-and-t-and-F-Distribution/#chi-square-distribution-students-t-distribution-f-distribution)提到的F分布的性质（性质3），有：

$$
(S_2^2/\sigma_1^2)/(S_1^2/\sigma_2^2)\sim F_{m-1,n-1}\notag
$$

则$\sigma_1^2/\sigma_2^2$的置信系数为$1-\alpha$的区间估计为：

$$
[(S_1^2/S_2^2)F_{m-1,n-1}(1-\alpha/2),\ (S_1^2/S_2^2)F_{m-1,n-1}(\alpha/2)]\label{eq6}
$$

## Example 5: Exponential Distribution, $\lambda$

设$X_1,\cdots,X_n$为抽自指数分布总体的样本，要求其参数$\lambda$的区间估计。

解：

根据文章[Chi-square Distribution, Student’s t Distribution, and F Distribution - What a starry night~](https://helloworld-1017.github.io/mathematics/matlab/Chi-square-and-t-and-F-Distribution/#properties-of-chi-square-distribution)提到的卡方分布的性质（性质2），有：

$$
2n\lambda\overline{X}\sim\chi_{2n}^2\notag
$$

因此$2n\lambda\overline{X}$可以做轴枢变量，于是得到参数$\lambda$的置信系数为$1-\alpha$的区间估计为：

$$
[\chi_{2n}^2(1-\alpha/2)(2n\overline{X}),\ \chi_{2n}^2(\alpha/2)(2n\overline{X})]
$$

## Precision

在讲述区间估计基本概念的时候提到过，一个好的区间估计既要考虑到可靠性，还要考虑到精度。根据奈曼的思想，我们首先需要尽可能得保证可靠性，之后再尽可能地提高精度。上面这些例子，就是只考虑到可靠性，而没有考虑精度。

在使用中，除了指定地置信系数之外，往往还对**区间估计的长度**，或者**其他某种反映其精度的量**，有一定的要求。在某些情况下这个问题比较好处理。比如：

（1）对于例子1的式子$\eqref{eq0}$，其区间的长度为$2\sigma u_{\alpha/2}/\sqrt{n}$，要使这个区间长度不超过指定的$L>0$：

$$
\begin{align*}
&2\sigma u_{\alpha/2}/\sqrt{n}<L\\
\Rightarrow&n>(2\sigma u_{\alpha/2}/L)^2
\end{align*}
$$

即只需取$n$为不小于$(2\sigma u_{\alpha/2}/L)^2$的最小整数即可。

（2）对于式$\eqref{eq5}$和式$\eqref{eq6}$对于正态分布方差或方差比的估计，由于方差本身的意义，在实际问题中，我们通常考虑估计值与它相差多少倍，而不是考虑估计值与其差的绝对值。这就要求，式$\eqref{eq5}$的右端不超过左端的$L$倍（$L>1$），即：

$$
\chi_{n-1}^2(\alpha/2)/\chi_{n-1}^2(1-\alpha/2)\le L\notag
$$

在给定了$L$后，可以查$\chi^2$分布表，找一个最小的$n$使得上式成立即可。

（3）但是有些情况就比较复杂。比如对于$t$区间估计，一样本$t$区间估计式$\eqref{eq3}$的区间长度为$2St_{n-1}(\alpha/2)/\sqrt{n}$与$S$有关，而$S$与样本有关，因此无法确定这样一个$n$，使得在任何情况下都有$2St_{n-1}(\alpha/2)/\sqrt{n}\le L$。于是，就需要使用更加复杂的区间估计方法，比如1945年美国统计学家斯泰因提出的“两阶段抽样”的方法。

<br>

# Conclusion

从以上这些例子中可以看出“轴枢变量法”这个名称的由来，该变量起到了一个“轴心”的作用，把一个变量介于某两个界限之间的不等式轻轻一转，就成为未知参数介于某两个界限之间的不等式。

对离散型变量来说，轴枢变量法不易使用。不仅由于满足轴枢变量法的轴枢变量$S(T,g(\theta))$大多不存在，即使存在，由于其分布$F$为离散的，对指定的$\beta$，一般也不存在确切的上$\beta$分位点。对离散型总体的参数去找指定的置信系数的区间估计方法，需要使用高阶数理统计学的知识。比如，对二项分布和泊松分布的参数的区间估计，可以使用一种基于极限的方法——大样本法。

<br>

**References**

[1] 概率论与数理统计. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.2(2019.8重印).

