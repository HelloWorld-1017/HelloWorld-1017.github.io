---
layout: single
title: Hypothesis Test 4: $t$-test and Z-test
date: 2023-10-12 18:53:50 +0800
categories:
 - Mathematics
 - MATLAB
tags:
 - Probability Theory and Mathematical Statistics
 - MATLAB Statistics and Machine Learning Toolbox
---

# t-test

## One-sample $t$-test

The one-sample $t$-test is a parametric test of the location parameter when the population standard deviation is unknown ==[xxx]==. In the one-sample $t$-test, the null hypothesis is that **the sample mean is equal to specified value $\mu_0$**, and the test statistic is:

==what is parametric test? what is location parameter?==
$$
t=\dfrac{\bar{x}-\mu_0}{s/\sqrt{n}}
$$
where $\bar{x}$ is the sample mean, $s$ is the sample standard deviation, and $n$ is the sample size. Under the null hypothesis, the test statistic has Student's $t$ distribution ==[xxx]== with $n-1$ degrees of freedom:
$$
t\sim t_{n-1}
$$
Although the parent population does not need to be normally distributed, the distribution of sample mean $\bar{x}$ is assumed to be normal.

## MATLAB `ttest` function

MATLAB Statistics and Machine Learning Toolbox provides a function `ttest` to realise one-sample $t$-test ==[xxx]==, we could refer to an official example to learn the usage of it:

```matlab
% Load data set
load examgrades
x = grades(:,1);
[h,p,ci,stats] = ttest(x,75)
```

```
h =
     0
p =
    0.9917
ci =
   73.4321
   76.5846
stats = 	
  struct with fields:
    tstat: 0.0105
       df: 119
       sd: 8.7202
```

In this one-sample $t$-test, the $\mu_0$ in null hypothesis is $75$, the default significance value of `ttest` function is $5\%$, and `h=0` represents accepting null hypothesis at the $5\%$ significance level. Besides, `p = 0.9917` is $p$-value, `ci` is confidence interval of sample mean $\bar{x}$.  By the way, this is a two-sided test in default case.

We could calculate these results by following way:

```matlab
clc,clear,close all

% Load data set
load examgrades
x = grades(:,1);

n = numel(x);

% Construct test statistic
t = (mean(x)-75)/(std(x)/sqrt(n))
t_degrees = n-1;
significance_level = 0.05;

% Interval estimation for \bar{x}, using pivot method
u_lowAlphaDiv2 = abs(tinv(significance_level/2,t_degrees));
interval = [mean(x)-std(x)*u_lowAlphaDiv2/sqrt(n),...
    mean(x)+std(x)*u_lowAlphaDiv2/sqrt(n)]

% Calculate p-value
pValue = 2*tcdf(-abs(t),t_degrees)

% Test null hypothesis
if pValue < significance_level
    h = 1
else
    h = 0
end

% % Plot schematics
% xx = -70:0.01:80;
% figure
% hold(gca,"on"),box(gca,"on"),grid(gca,"on")
% plot(xx,tpdf(xx,t_degrees))
% stem([tinv(pValue/2,t_degrees),-tinv(pValue/2,t_degrees)],...
%     tpdf([tinv(pValue/2,t_degrees),-tinv(pValue/2,t_degrees)],t_degrees))
```

```
t =
    0.0105
interval =
   73.4321   76.5846
pValue =
    0.9917
h =
     0
```

N.B.: The way of calculating confidence interval of sample mean $\bar{x}$ could be found in ==[xxx]==, and it is based on the assumption that the samples are normal distributed.
{: .notice--primary}

The results and verification of one-side $t$-test are showing as follows:

```matlab
% Load data set
load examgrades
x = grades(:,1);

[h,p,ci,stats] = ttest(x,75,"tail","right")
```

```
h =
     0
p =
    0.4958
ci =
   73.6887
       Inf
stats = 
  struct with fields:
    tstat: 0.0105
       df: 119
       sd: 8.7202
```

```matlab
...
% Interval estimation for \bar{x}, using pivot method
u_lowAlphaDiv2 = abs(tinv(significance_level,t_degrees));
interval = [mean(x)-std(x)*u_lowAlphaDiv2/sqrt(n), Inf]

% Calculate p-value
pValue = tcdf(-abs(t),t_degrees)
...
```

```
t =
    0.0105
interval =
   73.6887       Inf
pValue =
    0.4958
h =
     0
```

## Two-sample $t$-test

The two-sample $t$-test is a parametric test that compares the location parameter of two independent data samples ==[xxx]==.

==null hypothesis?==

The test statistic is:
$$
t=\dfrac{\bar{x}-\bar{y}}{\sqrt{\dfrac{s_x^2}{n}+\dfrac{s_y^2}{m}}}
$$
whre $\bar{x}$ and $\bar{y}$ are the sample means, $s_x$ and $s_y$ are the sample standard deviations, and $n$ and $m$ are the sample sizes.

In the case where it is assumed that the two samples are from populations **with equal variances**, the test statistic under the null hypothesis has Student's $t$ distribution with $n+m-2$ degrees of freedom, i.e.,
$$
t\sim t_{n+m-2}
$$
and the sample standard deviations are replaced by the **pooled standard deviation**:
$$
s=\sqrt{\dfrac{(n-1)s_x^2+(m-1)s_y^2}{n+m-2}}
$$
In the case where it is not assumed that the two data samples are from populations with equal variances, the test statistic under the null hypothesis has an approximate Student's $t$ distribution with a number of degrees of freedom given by Satterthwaite's approximation. This test is sometimes called **Welch’s t-test**.





N.B.: ==similar to interval estimation [xxx]==







## MATLAB `ttest2` function



<br>

# Z-test

Z-test is a kind of statistical test that tests whether a set of data come from a certain **normal distribution**, by testing the mean (test statistic) of a distribution [1].

The null hypothesis of Z-test is that 

the data in the vector $x$ comes from a normal distribution with mean $m$ and a standard deviation



For each significance level in the confidence interval, the *Z*-test has a single critical value (for example, 1.96 for 5% two tailed) which makes it more convenient than the **Student's *t*-test** whose critical values are defined by the sample size (through the corresponding degrees of freedom). [1] 



However, the z-test is rarely used in practice because the population deviation is difficult to determine. [1]



standardized test statistic:
$$
Z=\dfrac{\bar{X}-\mu_0}{s}
$$
The $s$ is either known or approximated by:
$$
s=\dfrac\sigma{\sqrt{n}}
$$



<br>

<div id="ref"></div>

**References**

[Student's t-test - Wikipedia](https://en.wikipedia.org/wiki/Student's_t-test). 

[Chi-square Distribution, Student’s t Distribution, and F Distribution - What a starry night~](https://helloworld-1017.github.io/mathematics/matlab/Chi-square-and-t-and-F-Distribution/#students-t-distribution).

[Interval Estimation – Pivot Method - What a starry night~](https://helloworld-1017.github.io/mathematics/Interval-Estimation-pivot-method/#example-1-normal-distribution-interval-estimation-of-mu-with-unknown-sigma2).

[ttest - MathWorks](https://ww2.mathworks.cn/help/stats/ttest.html).

[ttest2 - MathWorks](https://ww2.mathworks.cn/help/stats/ttest2.html).

[Z-test - Wikipedia](https://en.wikipedia.org/wiki/Z-test).

[z-test - MathWorks](https://ww2.mathworks.cn/help/stats/ztest.html).

