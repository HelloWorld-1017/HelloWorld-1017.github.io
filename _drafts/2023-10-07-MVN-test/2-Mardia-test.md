---
layout: single
title: "Hypothesis Test 5: Mardia’s test (A Multivariate Normality Test)"
date: 2023-10-13 22:43:19 +0800
categories:
 - Mathematics
 - MATLAB
tags:
 - Probability Theory and Mathematical Statistics
 - MATLAB Statistics and Machine Learning Toolbox
---

# Introduction

Mardia’s test is a multivariate normally test to examine a set of data whether follow a multivariate normal distribution, by checking the multivariate skewness and kurtosis measures are consistent with a multivariate normal distribution [[1]](#ref). The null hypothesis of Mardia’s test is that the data set is similar to the normal distribution, therefore a sufficiently small $p$-value indicates non-normal data [[2]](#ref).

Mardia's tests are affine invariant but not consistent. For example, the multivariate skewness test is *NOT consistent* against symmetric non-normal alternatives [[2]](#ref).

I found three resources in the Internet discussing Mardia’s test. However, they looks similar, but not exactly the same. So, this blog will compare and discuss about them.

<br>

# Mardia’s test obtained from Wikipedia [[2]](#ref)

For samples $\mathrm{\boldsymbol{X}}_1,\mathrm{\boldsymbol{X}}_2,\cdots,\mathrm{\boldsymbol{X}}_n$ of $k$-dimensional vectors, let $\hat{\Sigma}$ and element $m_{i,j}$ denote that:

$$
\begin{split}
&\hat{\Sigma}=\dfrac1n\sum_{j=1}^n(\mathrm{\boldsymbol{X}}_j-\bar{\mathrm{\boldsymbol{X}}})(\mathrm{\boldsymbol{X}}_j-\bar{\mathrm{\boldsymbol{X}}})^T\\
&m_{i,j}=(\mathrm{\boldsymbol{X}}_i-\bar{\mathrm{\boldsymbol{X}}})^T\hat{\Sigma}^{-1}(\mathrm{\boldsymbol{X}}_j-\bar{\mathrm{\boldsymbol{X}}})\\
\end{split}\label{eq1}
$$
N.B., Actually, $\hat{\Sigma}$ is the biased sample covariance matrix.
{: .notice--warning}

then construct test statistic $A$ and $B$ [1]:
$$
\begin{split}
&A=\dfrac1{6n}\sum_{i=1}^n\sum_{j=1}^nm_{i,j}^3\\
&B=\sqrt{\dfrac{n}{8k(k+2)}}\Big\{\dfrac1n\sum_{i=1}^nm_{i,i}^2-k(k+2)\Big\}
\end{split}
$$
Under the null hypothesis of multivariate normality, the statistic $A$ will have approximately a chi-squared distribution with $\dfrac16k(k+1)(k+2)$ degrees of freedom, and $B$ will be approximately standard normal distribution $\mathscr{N}(0,1)$, i.e., 
$$
\begin{split}
&\dfrac1{6n}\sum_{i=1}^n\sum_{j=1}^nm_{i,j}^3\sim\chi^2(\dfrac{k(k+1)(k+2)}6)\\
&\sqrt{\dfrac{n}{8k(k+2)}}\Big\{\dfrac1n\sum_{i=1}^nm_{i,i}^2-k(k+2)\Big\}\sim\mathscr{N}(0,1)
\end{split}\label{eqwiki}
$$
<br>

# Mardia's test obtained from Real Statistics [[1]](#ref)

$$
\begin{split}
&\text{skew}=\dfrac1{n^2}\sum_{i=1}^n\sum_{j=1}^nm_{i,j}^3\\
&\text{kurt}=\dfrac1n\sum_{i=1}^nm_{i,i}^2
\end{split}
$$

The "sample versions" of $\text{skew}$ and $\text{kurt}$ are: 

$$
\begin{split}
&\text{skew}^\prime=\dfrac{n}{(n-1)^3}\sum_{i=1}^n\sum_{j=1}^nm_{i,j}^3\\
&\text{kurt}^\prime=\dfrac{n}{(n-1)^2}\sum_{i=1}^nm_{i,i}^2
\end{split}
$$
For small samples (generally sample size is less than 20), the corrected statistic:

$$
\text{skew}^{\prime\prime}=\dfrac{n^2c}{6(n-1)^3}\sum_{i=1}^n\sum_{j=1}^nm_{i,j}^3\\
$$

where:
$$
c=\dfrac{(n+1)(n+3)(k+1)}{n(n+1)(k+1)-6}
$$
and:

$$
\text{kurt}^{\prime\prime}=\sqrt{\dfrac{n}{8k(k+2)}}\Big[\dfrac{n}{(n-1)^2}\sum_{i=1}^nm_{i,i}^2-k(k+2)\Big]
$$

If the samples come from a multivariate normal distribution, then:
$$
\begin{split}
&\text{skew}^{\prime\prime}\sim\chi^2(\dfrac{k(k+1)(k+2)}6)\\
&\text{kurt}^{\prime\prime}\sim\mathscr{N}(0,1)
\end{split}
$$
i.e.,
$$
\begin{split}
&\dfrac{\textcolor{red}{n^2c}}{6\textcolor{red}{(n-1)^3}}\sum_{i=1}^n\sum_{j=1}^nm_{i,j}^3\sim\chi^2(\dfrac{k(k+1)(k+2)}6)\\
&\sqrt{\dfrac{n}{8k(k+2)}}\Big[\textcolor{red}{\dfrac{n}{(n-1)^2}}\sum_{i=1}^nm_{i,i}^2-k(k+2)\Big]\sim\mathscr{N}(0,1)
\end{split}\label{eqreal}
$$
The red marks in the equation represents the coefficients that are different from equation $\eqref{eqwiki}$. As can be seen, if $n\rightarrow\infty$,  equation $\eqref{eqreal}$ is the same as $\eqref{eqwiki}$, so these could be viewed as some corrections in small sample case. I don't make a profound study for these coefficients, but I feel $n-1$ is from the correction for high sample moments, something like Bessel's correction [[4,5,6]](#ref).

<br>

# Mardia's test obtained from MATLAB official example [[3]](#ref)

MATLAB documentation provides an example to illustrate how to perform Mardia Kurtosis Test from Linear and Quadratic discriminant models [[3]](#ref) (both model are constructed using `fitcdiscr` function, some concerned content about this function could be found in blog [[7]](#ref) and official documentation [[8]](#ref)), and the test for linear model is like: 

```matlab
load fisheriris;
prednames = {'SepalLength','SepalWidth','PetalLength','PetalWidth'};

% Train a linear discriminant analysis model.
L = fitcdiscr(meas,species,'PredictorNames',prednames);

[N,D] = size(meas);

meanL = mean(mahal(L,L.X,'ClassLabels',L.Y).^2);
[~,pvalL] = ztest(meanL,D*(D+2),sqrt(8*D*(D+2)/N))
```

As can be seen:

(1) This test is just examine kurtosis, without skew. 

(2) The $z$-test is used to test kurtosis, and the null hypothesis of it is: 
$$
\dfrac1n\sum_{i=1}^nm_{i,i}^2\sim\mathscr{N}\Big(k(k+2),\sqrt{\dfrac{8k(k+2)}{n}}\Big)
$$
i.e.,
$$
\Big(\dfrac{n}{8k(k+2)}\Big)^{1/4}\Big[\dfrac1n\sum_{i=1}^nm_{i,i}^2-k(k+2)\Big]\sim\mathscr{N}(0,1)
$$
It is like the Mardia's test provided by Wikipedia (equation $\eqref{eqwiki}$), but the coefficient is $\Big(\dfrac{n}{8k(k+2)}\Big)^{1/4}$ rather than $\Big(\dfrac{n}{8k(k+2)}\Big)^{1/2}$. I tend to contend that the MATLAB example made a mistake at this aspect.

==$z$-test is not necessary, $z$-test with only one sample==

(3) This example calculates $(1/n)\sum_{i=1}^nm_{i,i}^2$ by calculating (squared) Mahalanobis distance using `mahal` function (could refer to blog [[9]](#ref)):

```matlab
meanL = mean(mahal(L,L.X,'ClassLabels',L.Y).^2);
```

It is convenient, but the results it is kind of different from the results based on equations $\eqref{eq1}$, as $\hat{\Sigma}$ in equation $\eqref{eq1}$  is biased sample covariance matrix, but `mahal` function calculate based on unbiased sample covariance matrix. We could simply make a verification:

```matlab
clc,clear,close all

load fisheriris.mat
meas = meas(1:50,:);

[n,k] = size(meas);
mu = mean(meas);

% Calculate the sum of m_ii by matrix multiplication (biased)
Sigma_biased = cov(meas,1); % biased SCM
b_biased = ((meas-mu)/Sigma_biased*(meas-mu)').^2;
b_biased = sum(b_biased.*diag(ones(1,height(b_biased))),"all")/n;

% Calculate the sum of m_ii by matrix multiplication (unbiased)
Sigma_unbiased = cov(meas,0); % deffault setting: 0, unbiased SCM
b_unbiased = ((meas-mu)/Sigma_unbiased*(meas-mu)').^2;
b_unbiased = sum(b_unbiased.*diag(ones(1,height(b_unbiased))),"all")/n;

% Calculate the sum of m_ii by `mahal` function
b_mahal= mean(mahal(meas,meas).^2);

fprintf("Calculate the sum of m_ii by matrix multiplication (biased): %.4f,\n" + ...
    "Calculate the sum of m_ii by matrix multiplication (unbiased): %.4f,\n" + ...
    "Calculate the sum of m_ii by `mahal` function: %.4f.\n", ...
    b_biased,b_unbiased,b_mahal)
```

```
Calculate the sum of m_ii by matrix multiplication (biased): 26.5377,
Calculate the sum of m_ii by matrix multiplication (unbiased): 25.4868,
Calculate the sum of m_ii by `mahal` function: 25.4868.
```

MATLAB `mahal` doesn't adopt an obvious way to calculate $(1/n)\sum_{i=1}^nm_{i,i}^2$  by directly calculating and then inversing $\hat{\Sigma}$, but relies on orthogonal-triangular decomposition:

![image-20231014161856539](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231014161856539.png)

Maybe it is a more robust numerical computation method, but I don't understand it right now, so in the following text, I still use matrix multiplication.

<br>

# Discussions

As described above, the Mardia's test from MATLAB example is not complete (as it does not test skewness), and the coefficient is not appropriate. So, I will contrast the first two calculation method, in this part.

To compared two methods, I hope the samples which to be tested indeed from a multivariate normal distribution, i.e., generated by MATLAB `mvnrnd` function. However, the parameter `Simga` put into `mvnrnd` must be positive semi-definite matrix. This is kind of strict, and should be carefully constructed. But luckily, we could prove that the sample covariance matrix is ALWAYS positive semi-definite (see [[10]](#ref)). So, I choose the features of "setosa" class from `fisheriris` data set, and use moments estimation method to estimate $\hat{\mu}$ and $\hat{\Sigma}$ of them, then based on which generate a certain amount of samples using `mvnrnd`, whose sample size is 20, 100, 1,000, or 10,000 respectively. The following verification is conducted on these generated samples. 

```matlab
clc,clear,close all

rng(1)

load fisheriris.mat
meas = meas(1:50,:);

mu = mean(meas);
Sigma = cov(meas);
numGs = [20,50,100,500,1000,1e4,2e4];

pValue_As = nan(1,numel(numGs));
pValue_Bs = nan(1,numel(numGs));
pValue_skew_correcteds = nan(1,numel(numGs));
pValue_kurt_correcteds = nan(1,numel(numGs));

for i = 1:numel(numGs)
    [pValue_As(i),pValue_Bs(i),pValue_skew_correcteds(i),pValue_kurt_correcteds(i)] = helperMardia(mu,Sigma,numGs(i));
end

figure("Position",[197,271,1553,420])
tiledlayout(1,2)
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
stem((1:numel(numGs))-0.1,pValue_As,"LineWidth",1.5,"DisplayName","Wiki version","Color","b")
stem((1:numel(numGs))+0.1,pValue_skew_correcteds,"LineWidth",1.5,"DisplayName","Real Statistics Version","Color","r")
xticklabels(numGs)
xticks(1:numel(numGs))
xlabel("Sample size")
ylabel("p-value")
legend("Location","southeast")

nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
stem((1:numel(numGs))-0.1,pValue_Bs,"LineWidth",1.5,"DisplayName","Wiki version","Color","b")
stem((1:numel(numGs))+0.1,pValue_kurt_correcteds,"LineWidth",1.5,"DisplayName","Real Statistics Version","Color","r")
xticklabels(numGs)
xticks(1:numel(numGs))
xlabel("Sample size")
ylabel("p-value")
legend("Location","southeast")

function [pValue_A,pValue_B,pValue_skew_corrected,pValue_kurt_corrected] = helperMardia(mu,Sigma,numG)
% Generate samples
data = mvnrnd(mu,Sigma,numG);

[n,k] = size(data);
Sigma_hat = cov(data,0); % biased SCM
a = sum(((data-mu)/Sigma_hat*(data-mu)').^3,"all");
b = ((data-mu)/Sigma_hat*(data-mu)').^2;
b = sum(b.*diag(ones(1,height(b))),"all");

df = (1/6)*k*(k+1)*(k+2);

% % Wikipedia version Mardia's test
A = (1/6/n)*a;
B = sqrt(n/(8*k*(k+2)))*(1/n*b-k*(k+2));
pValue_A = chi2cdf(A,df);
[~,pValue_B,~,~] = ztest(B,0,1);
% pValue_B = 2*normcdf(B,0,1)

% % Real Statistics version Mardia's test
c = (n+1)*(n+3)*(k+1)/(n*(n+1)*(k+1)-6);
skew_corrected = (n^2)*c/(6*(n-1)^3)*a;
kurt_corrected = sqrt(n/(8*k*(k+2)))*(n/((n-1)^2)*b-k*(k+2));
pValue_skew_corrected = chi2cdf(skew_corrected,df);
[~,pValue_kurt_corrected,~,~] = ztest(kurt_corrected,0,1);
% pValue_kurt_corrected = 2*normcdf(kurt_corrected,0,1)

% fprintf("Wikipedia version Mardia's test\n" + ...
%     "p-value of the test for A: %.4f,\np-value of the test for B: %.4f\n" + ...
%     "Real Statistics version Mardia's test\n" + ...
%     "p-value of the test for skewness: %.4f,\np-value of the test for kurtosis: %.4f\n", ...
%     pValue_A,pValue_B,pValue_skew_corrected,pValue_kurt_corrected);
end
```

![image-20231015141708797](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231015141708797.png)

If we further decrease the interval of sample size:

![image-20231015135144064](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231015135144064.png)

Sample size varies from 10 to 1,000, with step 10.
{: .notice--primary}

![image-20231015135842473](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231015135842473.png)

Sample size varies from 1,000 to 10,000, with step 100.
{: .notice--primary}

![image-20231015141604279](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231015141604279.png)

Sample size varies from 10,000 to 20,000, with step 200.
{: .notice--primary}



possibly come from two source:

(1) random number

(2) 

![image-20231015142414562](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231015142414562.png)

Sample size varies from 10 to 1,000, with step 10, mean $p$-value of 20 times.
{: .notice--primary}

![image-20231015153121133](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231015153121133.png)

Sample size varies from 1,000 to 10,000, with step 100, mean $p$-value of 20 times.
{: .notice--primary}

![image-20231015192811176](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231015192811176.png)

Sample size varies from 10,000 to 20,000, with step 200, mean $p$-value of 20 times.
{: .notice--primary}



<br>

The problem of `df`



<br>

<div id="ref"></div>

**References**

[1] [Mardia's Test - Real Statistics Using Excel](https://real-statistics.com/multivariate-statistics/multivariate-normal-distribution/multivariate-normality-testing/).

[2] [Multivariate normal distribution: Multivariate normality tests - Wikipedia](https://en.wikipedia.org/wiki/Multivariate_normal_distribution#Multivariate_normality_tests).

[3] [Examine the Gaussian Mixture Assumption: Mardia-Kurtosis Test for Linear and Quadratic Discriminants - MathWorks](https://ww2.mathworks.cn/help/stats/examine-the-gaussian-mixture-assumption.html#bs2r9lk).

[4] [Bessel's correction - Wikipedia](https://en.wikipedia.org/wiki/Bessel's_correction).

[5] [Estimation of covariance matrices - Wikipedia](https://en.wikipedia.org/wiki/Estimation_of_covariance_matrices).

[6] [From Sample Covariance Matrix(SCM) to Bessel’s Correction - What a starry night~](https://helloworld-1017.github.io/mathematics/From-Sample-Covariance-Matrix-to-Bessel's-Correction/).

[7] [MATLAB `fitcdiscr` Function - What a starry night~](https://helloworld-1017.github.io/matlab/mathematics/MATLAB-fitcdiscr-Function/).

[8] [`fitcdiscr`: Fit discriminant analysis classifier. - MathWorks](https://ww2.mathworks.cn/help/stats/fitcdiscr.html).

[9] [Multivariate Normal Distribution and Mahalanobis Distance - What a starry night~](https://helloworld-1017.github.io/mathematics/matlab/Multivariate-Normal-Distribution-and-Mahalanobis-Distance/#mahalanobis-distance).

[10] [Is a sample covariance matrix always symmetric and positive definite? - Stack Exchange](https://stats.stackexchange.com/questions/52976/is-a-sample-covariance-matrix-always-symmetric-and-positive-definite).



[Methods of Multivariate Analysis 2 Ed-02](https://www.ipen.br/biblioteca/slr/cel/0241), pages 112-113. 



