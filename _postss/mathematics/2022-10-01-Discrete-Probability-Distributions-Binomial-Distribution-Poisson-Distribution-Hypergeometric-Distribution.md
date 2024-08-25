---
layout: single
title: Discrete Probability Distributions(Binomial Distribution, Poisson Distribution, Hypergeometric Distribution)
date: 2022-10-01 18:38:39 +0800
categories: 
 - Mathematics
 - MATLAB
tags:
 - Probability Theory and Mathematical Statistics
 - MATLAB Statistics and Machine Learning Toolbox
---

# Binomial Distribution

## Deduction

假设某事件$A$在一次试验中发生的概率为$p$，现把这个试验独立地重复$n$次，以$X$记$A$在这$n$次试验中发生地次数，则$X$可取$0,1,\cdots,n$等值，则有：

$$
P(X=i)=C_n^i\cdot p^i\cdot(1-p)^{n-i}\label{eq1}
$$

此时，定义$X$遵从的概率分布$\eqref{eq1}$为**二项分布(Binomial Distribution)**，并记作$X\sim B(n,p)$。

二项分布时最重要的离散型概率分布之一。变量$X$服从二项分布有两个重要条件：

1. 各次试验的条件是稳定的，这保证了事件$A$的概率$p$在各次试验中保持不变；
2. 保证各次试验的独立性；

现实生活中有许多现象不同程度地符合这些条件，而不一定分厘不差。

例如，某厂每天生产$n$个产品，若原材料质量、机器设备、工人操作水平等在一段时期内大体保持稳定（满足第一个条件），并且每件产品的合格与否与其他产品合格与否无显著关联（满足第二个条件），则**每天的废品数**$X$大体上服从二项分布。

又比如，一大批产品$N$个，其废品率为$p$。从其中有**放回地逐一抽取**产品，检验其是否为废品，共抽$n$个。由于每次抽出检验后又放回，因此保证了每次抽取时每个产品有同等的$1/N$的机会被抽出，则这$n$个产品中所包含的废品数$X$就相当理想地服从二项分布$B(n,p)$。

注：如果每次抽出一个检验后**不放回**，则下一次抽取时，废品率就发生了变化，这时$X$就不再服从二项分布。但是如果$N$远大于$n$，即使不放回，对废品率影响也绩效。这时，$X$仍可近似地作为二项分布来处理。
{: .notice--primary}

## Mathematic Expectation and Variance

### Mathematic Expectation

假设$X\sim B(n,p)$，则$X$表示$n$次独立试验中事件$A$发生的**次数**，且在每次试验中事件$A$发生的概率为$p$，因此引进随机变量$X_1,\cdots,X_n$，其中：

$$
X_i=\left\{
\begin{split}
&1,\ \mathrm{若在第i次试验时事件A发生}\\
&0,\ \mathrm{若在第i次试验时事件A不发生}
\end{split}\right.\notag
$$

并且$X_1,\cdots,X_n$相互独立，且有：

$$
X=X_1+X_2+\cdots+X_n\label{eq4}
$$

根据期望的定理有：

定理1：若干个随机变量之和的期望等于各变量的期望的和，即：$E(X_1+X_2+\cdots X_n)=E(X_1)+E(X_2)+\cdots E(X_n)$，这里假定各变量$X_i$的期望都存在。
{: .notice--primary}

$$
E(X)=E(X_1)+E(X_2)+\cdots E(X_n)\notag
$$

并且有$P(X_i=1)=p$，$P(X_i=0)=1-p$，因此$E(X_i)=p$。综上可以得到：

$$
E(X)=np
$$

注意到，虽然$X_1,\cdots,X_n$相互独立，但是在上述的推导过程中没有用到这一事实，因为定理1的使用并不依赖于这个条件。
{: .notice--warning}

### Variance

定理2：独立随机变量之和的方差等于各变量的方差之和，即：$\mathrm{Var}(X_1+X_2+\cdots X_n)=\mathrm{Var}(X_1)+\mathrm{Var}(X_2)\cdots+\mathrm{Var}(X_n)$。
{: .notice--primary}

根据式$\eqref{eq4}$和定理2方差的性质，可以得到，对于二项分布$X\sim B(n,p)$：

$$
\mathrm{Var}(X)=\mathrm{Var}(X_1)+\mathrm{Var}(X_2)\cdots+\mathrm{Var}(X_n)=n\mathrm{Var}(X_i)\notag
$$

又因为：

$$
\mathrm{Var}(X_i)=E(X_i^2)-(EX_i)^2=p-p^2\notag
$$

于是可以得到：

$$
\mathrm{Var}(X)=np(1-p)
$$

## `binopdf` and `binocdf` function in MATLAB

```matlab
clc, clear, close all

x = 0:10;

figure
nexttile
bar(x, binopdf(x, 10, 0.5), 1)
xlabel('Observation')
ylabel('PMF')
grid on

nexttile
stairs(x, binocdf(x,10, 0.5), LineWidth=1.5)
xlabel('Observation')
ylabel('CDF')
grid on
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220930175825620.png?raw=true" alt="image-20220930175825620" style="zoom:67%;" />

## Compare Binomial and Normal Distribution PDFs

假设$p$不是太大或者不是太小，若$n$很大，则二项分布$B(n,p)$可以使用正态分布$N(np,np(1-p))$进行近似：

```matlab
clc, clear, close all

N = 50;
p = 0.6;
x1 = 0:N;
y1 = binopdf(x1, N, p);

mu = N*p;
sigma = sqrt(N*p*(1-p));
x2 = 0:0.1:N;
y2 = normpdf(x2, mu, sigma);

figure
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
bar(x1, y1, 1)
plot(x2, y2, 'LineWidth',2)
xlabel('Observation')
ylabel('Probability')
title('Binomial and Normal pdfs')
legend('Binomial Distribution','Normal Distribution','location','northwest')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221001183201007.png?raw=true" alt="image-20221001183201007" style="zoom: 67%;" />

<br>

# Poisson Distribution

## Deduction

考虑这样一个问题：在一定时间内，某交通路口所发生的事故的数量服从什么分布？

假设所观察的这段时间为$[0, 1)$，取一个很大的自然数$n$，把时间段$[0,1)$分为等长的$n$段：

$$
l_1=[0,\dfrac1n),\ l_2=[\dfrac1n, \dfrac2n),\cdots,l_i=[\dfrac{i-1}{n},\dfrac{i}n),\cdots,l_n=[\dfrac{n-1}n,1).\notag
$$

并假设：

1. 在时间段$l_i$内，恰发生一次事故的概率，**近似地**与这段时间的长$1/n$成正比，即$\lambda/n\ (\lambda>0)$。又假定在$n$很大，因而时长$1/n$很小，那么在短暂的一段时间内，发生两次或更多的事故是不可能的。因此，在$l_i$时段内，不发生事故的概率为$1-\lambda/n$；
2. $l_1,\cdots,l_n$各段是否发生事故是独立的。

在上述假定下，在$[0,1)$时段内发生的事故的数量$X$可视作$n$个小的时段$l_1,\cdots,l_n$内有事故的时段的数量，则此时$X$应当服从二项分布$B(n,\lambda/n)$，于是有：

$$
P(X=i)=C_n^i\cdot (\lambda/n)^i\cdot (1-\lambda/n)^{n-i}\label{eq2}
$$

注：严格地讲，上式只是近似成立，并非严格等式，因为在假定1中，只是将每个时段内发生一次事故地概率近似地认为是$\lambda/n$。
{: .notice--primary}

当$n\rightarrow\infty$时，式$\eqref{eq2}$中：

$$
\lim_{n\rightarrow\infty}\dfrac{C_n^i}{n^i}=\dfrac1{i!},\quad\lim_{n\rightarrow\infty}(1-\dfrac\lambda{n})^n=e^{-\lambda}\notag
$$

于是可以得到：

$$
P(X=i)=e^{-\lambda}\lambda^i/i!\label{eq3}
$$

式$\eqref{eq3}$所代表的分布，称为泊松分布(Poisson distribution)，记作$X\sim P(\lambda)$。

**泊松分布多出现在当$X$表示在一定的时间或空间内出现的事件个数的场合**。

从上述推导过程也可以看出：**泊松分布可以作为二项分布的极限而得到**。一般而言，若$X\sim B(n,p)$，其中（1）$n$很大，（2）$p$很小，而（3）$np=\lambda$不太大时，则$X$的分布接近于泊松分布$P(\lambda)$。当二项分布很难计算且满足上述三个条件时，可以将其转换为泊松分布进行计算。

## Mathematic Expectation and Variance

### Mathematic Expectation

$$
E(X)=\sum_{i=0}^\infty i\dfrac{\lambda^i}{i!}e^{-\lambda}=\lambda e^{-\lambda}\sum_{i=0}^\infty \dfrac{\lambda^{i-1}}{(i-1)!}=\lambda e^{-\lambda}e^\lambda=\lambda
$$

### Variance

首先计算$E(X^2)$：

$$
\begin{split}
E(X^2)&=\sum_{i=0}^\infty i^2\dfrac{e^{-\lambda}\lambda^i}{i!}=\sum_{i=0}^\infty(i(i-1)+i)\dfrac{e^{-\lambda}\lambda^i}{i!}\\
&=\lambda+\sum_{i=0}^\infty i(i-1)\dfrac{e^{-\lambda}\lambda^i}{i!}\\
&=\lambda+\sum_{i=2}^\infty \dfrac{e^{-\lambda}\lambda^i}{(i-2)!}\\
&=\lambda+\lambda^2\sum_{i=2}^\infty \dfrac{e^{-\lambda}\lambda^{(i-2)}}{(i-2)!}\\
&=\lambda+e^{-\lambda}\lambda^2\sum_{i=0}^\infty \dfrac{\lambda^{i}}{i!}\\
&=\lambda^2+\lambda
\end{split}\notag
$$

于是可以得到泊松分布的方差：

$$
\mathrm{Var}(X)=E(X^2)-(EX)^2=\lambda
$$

## `poisspdf` and `poisscdf` function in MATLAB

```matlab
clc, clear, close all

x = 0:10;

figure
nexttile
bar(x, poisspdf(x, 2), 1)
xlabel('Observation')
ylabel('PMF')
grid on

nexttile
stairs(x, poisscdf(x, 2), LineWidth=1.5)
xlabel('Observation')
ylabel('CDF')
grid on
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221001181613946.png?raw=true" alt="image-20221001181613946" style="zoom: 67%;" />

### Compare Binomial and Poisson Distribution PDFs

前面提到，若$X\sim B(n,p)$，其中（1）$n$很大，（2）$p$很小，而（3）$np=\lambda$不太大时，则$X$的分布接近于泊松分布$P(np)$：

```matlab
clc, clear, close all

N = 20;
p = 0.05;
x = 0:N;
y1 = binopdf(x, N, p);

mu = N*p;
y2 = poisspdf(x, mu);

figure
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
bar(x, [y1; y2])
xlabel('Observation')
ylabel('Probability')
title('Binomial and Poisson pdfs')
legend('Binomial Distribution', 'Poisson Distribution', ...
    'location','northeast')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221001183604855.png?raw=true" alt="image-20221001183604855" style="zoom: 67%;" />

<br>

# Hypergeometric distribution

## Deduction

假设一批产品共有$N$个，其中废品有$M$个。现从中随机抽取出$n$个，问“事件$A$：其中恰好有$m$个废品”的概率是多少？

从$N$个产品中抽取$n$，一共有$C_N^n$个取法，使事件$A$发生的取法一共有$C_M^mC_{N-M}^{n-m}$种，故事件$A$的概率可以记作：

$$
P(X=m)=\dfrac{C_M^mC_{N-M}^{n-m}}{C_N^n},\ (0\le m\le M, n-M\le N-M)
$$

上式称为**超几何分布(Hypergeometric distribution)**，因为其形式与“超几何函数”的级数展开式的系数有关。

这个分布在涉及抽样的问题中常用，因为通常在抽样时，大多是像本例中这样“无放回”的，即已抽出的个体不再放回去以供再次抽出的机会，这就与把$n$个同时抽出效果是一样的。

如果一个一个地抽而抽出地仍有放回，则结果就是二项分布。在前面也曾指出，若$n/N$很小，则放回与不放回差别不大，由此可见，在这种情况下，超几何分布与二项分布很接近。确切地说，若$X$服从超几何分布，则当$n$（即抽出的产品的数量）固定时，$M/N=p$（即废品率）固定，$N\rightarrow\infty$时，$X$近似地服从二项分布$B(n,p)$。

## `hygepdf` and `hygecdf` function in MATLAB

`hygepdf`函数用于计算泊松分布的PDF，`hygecdf`用于计算CDF，它们的基本语法如下所示：

```matlab
Ypdf = hygepdf(X, M, K, N);
Ycdf = hygecdf(x, M, K, N);
```

其中：

- 参数`X`为随机变量
- 参数`M`为size of population
- 参数`K`为desired characteristic in the population
- 参数`N`为number of sample drawn

例如：

```matlab
clc, clear, close all

x = 0:10;
M = 10;
K = 5;
N = 5;

figure
nexttile
bar(x, hygepdf(x, M, K, N), 1)
xlabel('Observation')
ylabel('PMF')
grid on

nexttile
stairs(x, hygecdf(x, M, K, N), LineWidth=1.5)
xlabel('Observation')
ylabel('CDF')
grid on
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221001182442400.png?raw=true" alt="image-20221001182442400" style="zoom: 67%;" />

<br>

**参考**

[1] 概率论与数理统计. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.2(2019.8重印).

[2] [Binomial Distribution - MathWorks](https://ww2.mathworks.cn/help/stats/binomial-distribution.html).

[3] [Poisson Distribution - MathWorks](https://ww2.mathworks.cn/help/stats/poisson-distribution.html).

[4] [Hypergeometric Distribution - MathWorks](https://ww2.mathworks.cn/help/stats/hypergeometric-distribution.html).