---
layout: single
title: "Hypothesis Test: $t$-test and $z$-test"
date: 2023-10-13 22:12:05 +0800
categories:
 - Mathematics
 - MATLAB
tags:
 - Probability Theory and Mathematical Statistics
 - Hypothesis Test
 - MATLAB Statistics and Machine Learning Toolbox
---

# t-test

## One-sample $t$-test

The one-sample $t$-test is a parametric test of the location parameter <u>when the population standard deviation is UNKNOWN</u> [[1]](#ref). In the one-sample $t$-test, the null hypothesis is that **the sample mean is equal to specified value $\mu_0$** [[2]](#ref), and the test statistic is:

**Parametric statistics** is a branch of statistics which assumes that sample data comes from a population that can be adequately modeled by a probability distribution that has a fixed set of parameters. Conversely a **non-parametric model** does not assume an explicit (finite-parametric) mathematical form for the distribution when modeling the data. However, it may make some assumptions about that distribution, such as continuity or symmetry. [[3]](#ref)
{: .notice--primary}

In statistics, a **location parameter** of a probability distribution is a scalar- or vector-valued parameter $x_0$, which determines the "location" or shift of the distribution. [[4]](#ref)
{: .notice--primary}


$$
t=\dfrac{\bar{x}-\mu_0}{s/\sqrt{n}}\label{eq1}
$$

where $\bar{x}$ is the sample mean, $\mu_0$ is the hypothesised population mean, $s$ is the sample standard deviation, and $n$ is the sample size. Under the null hypothesis, the test statistic has Student's $t$ distribution [[5]](#ref) with $n-1$ degrees of freedom:

$$
t\sim t_{n-1}
$$

Although the parent population does not need to be normally distributed, the distribution of sample mean $\bar{x}$ is assumed to be normal [[2]](#ref).

### Two-side test

MATLAB Statistics and Machine Learning Toolbox provides a function `ttest` to realise one-sample $t$-test [[1]](#ref), we could refer to an official example to learn the usage of it.

At default settings, `ttest` conduct a two-side one-sample $t$-test:

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

In this one-sample $t$-test, the $\mu_0$ in null hypothesis is $75$, the default significance value of `ttest` function is $5\%$, and `h=0` represents accepting null hypothesis at the $5\%$ significance level. Besides, `p = 0.9917` is $p$-value, `ci` is confidence interval of sample mean $\bar{x}$. 

Actually, we could calculate these results by following way:

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

N.B., The way of calculating confidence interval of sample mean $\bar{x}$ could be found in blog [[6]](#ref), and it is based on the assumption that the samples are from normal distribution $\mathscr{N}(\mu,\sigma^2)$, where $\sigma^2$ is unknown.
{: .notice--warning}

### One-side test

Similarly, the results and verification of one-side $t$-test are showing as follows:

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
u_lowAlpha = abs(tinv(significance_level,t_degrees));
interval = [mean(x)-std(x)*u_lowAlpha/sqrt(n), Inf]

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

The two-sample $t$-test is a parametric test that compares the location parameter of two independent data samples. The null hypothesis is that the data from samples $x$ and $y$ comes from normal distributions with **equal means** and equal-but-unknown variances [[7]](#ref). The test statistic is:

$$
t=\dfrac{\bar{x}-\bar{y}}{\sqrt{\dfrac{s_x^2}{n}+\dfrac{s_y^2}{m}}}
$$

where $\bar{x}$ and $\bar{y}$ are the sample means, $s_x$ and $s_y$ are the sample standard deviations, and $n$ and $m$ are the sample sizes.

In the case where it is assumed that the two samples are from populations **with equal variances**, the test statistic under the null hypothesis has Student's $t$ distribution with $n+m-2$ degrees of freedom, i.e.,

$$
t\sim t_{n+m-2}
$$

and the sample standard deviations are replaced by the **pooled standard deviation**:

$$
s=\sqrt{\dfrac{(n-1)s_x^2+(m-1)s_y^2}{n+m-2}}
$$

In the case where it is not assumed that the two data samples are from populations with equal variances, the test statistic under the null hypothesis has an approximate Student's $t$ distribution with a number of degrees of freedom given by **Satterthwaite's approximation**. This test is sometimes called **Welch’s t-test** [[7]](#ref).

### Two-side test

MATLAB Statistics and Machine Learning Toolbox provides a function `ttest2` to realise two-sample $t$-test [[7]](#ref):

```matlab
load examgrades
x = grades(:,1);
y = grades(:,2);

[h,p,ci,stats] = ttest2(x,y)
```

```
h =
     0
p =
    0.9867
ci =
   -1.9438
    1.9771
stats = 
  struct with fields:
    tstat: 0.0167
       df: 238
       sd: 7.7084
```

and the self-calculated version is: 

```matlab
clc,clear,close all

% load data set
load examgrades
x = grades(:,1);
y = grades(:,2);

n = numel(x);
m = numel(y);

t_degrees = n+m-2;
sx = std(x);
sy = std(y);
s = sqrt(((n-1)*sx^2+(m-1)*sy^2)/t_degrees);

% Construct test statistic
t = (mean(x)-mean(y))/(sqrt((std(x)^2/n)+(std(y)^2/n)))

significance_level = 0.05;

% Interval estimation for \bar{x}-\bar{y}, using pivot method
u_lowAlphaDiv2 = abs(tinv(significance_level/2,t_degrees));
interval = [mean(x)-mean(y)-s*u_lowAlphaDiv2*sqrt((n+m)/(n*m)),...
    mean(x)-mean(y)+s*u_lowAlphaDiv2*sqrt((n+m)/(n*m))]

% Calculate p-value
pValue = 2*tcdf(-abs(t),t_degrees)

% Test null hypothesis
if pValue < significance_level
    h = 1
else
    h = 0
end
```

```
t =
    0.0167
interval =
   -1.9438    1.9771
pValue =
    0.9867
h =
     0
```

N.B., It can be seen that, the confidence interval is calculated for $\bar{x}-\bar{y}$, and as before, the calculation method could be found in [[8]](#ref). The basic assumption is the $x_i$ and $y_i$ are respectively from two normal distribution $\mathscr{N}(\mu_1,\sigma^2)$ and $\mathscr{N}(\mu_2,\sigma^2)$, and the common variance $\sigma^2$ is unknown.
{: .notice--warning}

### One-side test

Similarly, use `ttest2` function to carry out a one-side two-sample $t$-test by specifying `"tail"` property:

```matlab
load examgrades
x = grades(:,1);
y = grades(:,2);

[h,p,ci,stats] = ttest2(x,y,"tail","right")
```

```
h =
     0
p =
    0.4933
ci =
   -1.6266
       Inf
stats = 
  struct with fields:
    tstat: 0.0167
       df: 238
       sd: 7.7084
```

and the corresponding self-calculated version is: 

```matlab
...
% Interval estimation for \bar{x}-\bar{y}, using pivot method
u_lowAlpha= abs(tinv(significance_level,t_degrees));
interval = [mean(x)-mean(y)-s*u_lowAlpha*sqrt((n+m)/(n*m)),Inf]

% Calculate p-value
pValue = tcdf(-abs(t),t_degrees)
...
```

```
t =
    0.0167
interval =
   -1.6266       Inf
pValue =
    0.4933
h =
     0
```

<br>

# Z-test

The $z$​-test is a parametric hypothesis test used to determine whether a sample data set comes from a population with a particular mean. The test assumes that the sample data comes from a population with a normal distribution and a known standard deviation [[10]](#ref). The standardised test statistic is:

$$
z=\dfrac{\bar{x}-\mu_0}{\sigma/\sqrt{n}}\label{eq2}
$$

where $\bar{x}$ is the sample mean, $\mu_0$ is the population mean, $\sigma$ is the population standard deviation, and $n$ is the sample size. Under the null hypothesis, the set statistics has a standard normal distribution:

$$
z\sim\mathscr{N}(0,1)
$$

It is important to highlight here that, although the test statistic of one-sample $t$-test $\eqref{eq1}$ and $z$-test $\eqref{eq2}$ looks similar, there exist a significant different, that $\sigma$ in $\eqref{eq2}$ is population standard deviation, meaning it is KNOWN. But actually, it could be approximated by sample standard deviation $s$:

$$
\sigma\approx s
$$

At this case, the test statistic of one-sample $t$-test and $z$-test is the same (the distribution used for test is different however). 

Actually, $z$-test is rarely used in practice because the population deviation is difficult to determine [[9]](#ref).  And for each significance level in the confidence interval, the $z$-test has a single critical value (for example, 1.96 for 5% two tailed) which makes it more convenient than the one-sample $t$-test whose critical values are defined by the sample size (through the corresponding degrees of freedom) [[9]](#ref). 

And **$z$-test is used when sample size is large ($n>50$), or the population variance is known. $t$-test is used when sample size is small ($n<50$) and population variance is unknown.**

## Two-side test

MATLAB Statistics and Machine Learning Toolbox provides a function `ztest` to realise $z$-test [[10]](#ref).

```matlab
% Load data set
load examgrades
x = grades(:,1);

mu = 65;
s = 10;
[h,p,ci,zval] = ztest(x,mu,s)
```

```
h =
     1
p =
   5.7191e-28
ci =
   73.2191
   76.7975
zval =
   10.9636
```

the corresponding self-calculated version is: 

```matlab
clc,clear,close all

% Load data set
load examgrades
x = grades(:,1);

mu = 65;
sigma = 10;
n = numel(x);
z_degrees = n-1;

% Construct test statistic
z = (mean(x)-mu)/(sigma/sqrt(n))

significance_level = 0.05;

% Interval estimation for \bar{x}, using pivot
u_lowAlphaDiv2 = abs(norminv(significance_level/2,0,1));
interval = [mean(x)-sigma*u_lowAlphaDiv2/sqrt(n),...
    mean(x)+sigma*u_lowAlphaDiv2/sqrt(n)]

% Calculate p-value
pValue = 2*normcdf(-abs(z),0,1)

% Test null hypothesis
if pValue < significance_level
    h = 1
else
    h = 0
end

% % Plot schematics
% figure
% hold(gca,"on"),box(gca,"on"),grid(gca,"on")
% xx = -10:0.01:10;
% plot(xx,normpdf(xx,0,1))
% legend()
% 
% stem([norminv(pValue/2,0,1),-norminv(pValue/2,0,1)],...
%     normpdf([norminv(pValue/2,0,1),-norminv(pValue/2,0,1)],0,1),"filled")
```

```
z =
   10.9636
interval =
   73.2191   76.7975
pValue =
   5.7191e-28
h =
     1
```

N.B., The way of calculating confidence interval of sample mean $\bar{x}$ is similar to one-sample $t$-test, but the difference is that here, the assumption is the sample are from rom normal distribution $\mathscr{N}(\mu,\sigma^2)$, where $\sigma^2$ is KNOWN [[11]](#ref).
{: .notice--warning}

## One-side test

Similarly, use `ztest` function to carry out a one-side $z$-test by specifying `"tail"` property:

```matlab
% Load data set
load examgrades
x = grades(:,1);

mu = 65;
s = 10;
[h,p,ci,zval] = ztest(x,mu,s,"tail","right")
```

```
h =
     1
p =
   2.8596e-28
ci =
   73.5068
       Inf
zval =
   10.9636
```

the corresponding self-calculated version is: 

```matlab
...
% Interval estimation for \bar{x}, using pivot
u_lowAlpha = abs(norminv(significance_level,0,1));
interval = [mean(x)-sigma*u_lowAlpha/sqrt(n), Inf]

% Calculate p-value
pValue = normcdf(-abs(z),0,1)
...
```

```
z =
   10.9636
interval =
   73.5068       Inf
pValue =
   2.8596e-28
h =
     1
```

<br>

<div id="ref"></div>

**References**

[1] [`ttest`: One-sample and paired-sample $t$-test. - MathWorks](https://ww2.mathworks.cn/help/stats/ttest.html).

[2] [Student's t-test - Wikipedia](https://en.wikipedia.org/wiki/Student's_t-test).

[3] [Parametric statistics - Wikipedia](https://en.wikipedia.org/wiki/Parametric_statistics).

[4] [Location parameter - Wikipedia](https://en.wikipedia.org/wiki/Location_parameter)

[5] [Chi-square Distribution, Student’s t Distribution, and F Distribution - What a starry night~](https://helloworld-1017.github.io/mathematics/matlab/Chi-square-and-t-and-F-Distribution/#students-t-distribution).

[6] [Interval Estimation – Pivot Method:  Normal Distribution, Interval Estimation of $\mu$ with Unknown $\sigma^2$- What a starry night~](https://helloworld-1017.github.io/mathematics/Interval-Estimation-pivot-method/#example-1-normal-distribution-interval-estimation-of-mu-with-unknown-sigma2).

[7] [`ttest2`: Two-sample $t$-test. - MathWorks](https://ww2.mathworks.cn/help/stats/ttest2.html).

[8] [Interval Estimation – Pivot Method: Normal Distribution, Interval Estimation of $\mu_1-\mu_2$ - What a starry night~ ](https://helloworld-1017.github.io/mathematics/Interval-Estimation-pivot-method/#example-2-normal-distribution-interval-estimation-of--mu_1-mu_2).

[9] [Z-test - Wikipedia](https://en.wikipedia.org/wiki/Z-test).

[10] [z-test: $z$-test. - MathWorks](https://ww2.mathworks.cn/help/stats/ztest.html).

[11] [Interval Estimation – Pivot Method: Normal Distribution, Interval Estimation of $\mu$ with known $\sigma^2$- What a starry night~](https://helloworld-1017.github.io/mathematics/Interval-Estimation-pivot-method/#example-0-normal-distribution-interval-estimation-of--mu-with-known-sigma2).
