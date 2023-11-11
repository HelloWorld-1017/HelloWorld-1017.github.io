---
layout: single
title: "xxx"
date: 2023-11-06 xx:xx:xx +0800
categories:
 - Mathematics
 - MATLAB
tags:
 - Probability Theory and Mathematical Statistics
 - Hypothesis Test
 - Mathematical Combination
---

# Introduction





<br>

# Single-sample runs test for randomness (Wald-Wolfowitz Runs Test)

For $n$ binary outcomes, $Y_i$(= $0$ or $1$), the non-parametric, Single-Sample Wald-Wolfowitz Runs Test can be used to test the null hypothesis that **the binary series is random**. The null hypothesis of randomness is rejected when the total number of runs of $0$ and $1$ is too many or too few. This test can be used for binary data and for numeric data that has been categorised as either above or below a reference value.

Given the number of $0$'s ($n_1$) and $1$'s ($n_2$) in a series, the minimum and maximum possible total number of runs are:
$$
\begin{split}
&R_{\text{min}}=2\\
&R_{\text{max}}=2\text{Min}(n_1,n_2)+1\\
\end{split}
$$
The expected number of runs, $\mathbb{E}(R)$, given $n_1$ and $n_2$ is:
$$
\mathbb{E}(R)=\dfrac{2n_1n_2}{n}+1
$$
<br>

## Exact test

To compute the exact test for a binary series, we must calculate the probabilities of obtaining given numbers of runs conditional on the number of runs conditional on the number of $0$'s ($n_1$) and $1$'s ($n_2$) in the series. If the data are random, the probability that the total number if runs, $R$, will be equal to some even number $2u$ is:

$$
\text{Pr}(R=2u)=\dfrac{2{{n_1-1} \choose {u-1}}{{n_2-1} \choose {u-1}}}{{{n} \choose {n_1}}}
$$
The probability that the total number if runs, $R$, will be equal to some odd number $2u+1$ is:
$$
\text{Pr}(R=2u+1)=\dfrac{{{n_1-1} \choose {u-1}}{{n_2-1} \choose {u-1}}+{{n_1-1}\choose u}{{n_2-1}\choose {u-1}}}{{{n} \choose {n_1}}}
$$
For the alternative hypothesis of "too many runs", the exact upper one-sided $p$-value for an observed total number of runs, $r$, is:
$$
\text{Pr}(R\ge r)=\sum_{v=r}^{R_{\text{max}}}\text{Pr}(R=v)
$$

For the alternative hypothesis of "too few runs", the exact lower one-sided $p$-value for an observed total number of runs, $r$, is:

$$
\text{Pr}(R\le r)=\sum_{v=R_{\text{min}}}^{r}\text{Pr}(R=v)
$$
The two-sided exact $p$-value for an observed total number of runs, $r$, is:
$$
\begin{split}
&\text{Pr}\Big(\vert R-\mathbb{E}(R)\vert\ge\vert r-\mathbb{E}(R)\vert\Big)\\
=&\sum_{v=R_{\text{min}}}^{\mathbb{E}(R)-\vert r-\mathbb{E}(R)\vert}\text{Pr}(R=v)+\sum_{v=\mathbb{E}(R)+\vert r-\mathbb{E}(R)\vert}^{R_{\text{max}}}\text{Pr}(R=v)
\end{split}
$$
The exact test is more accurate than the two asymptotic $z$ tests and **should always be used if available**. **The exact test is not computed for categorical data with more than two groups**.

<br>

## Asymptotic $z$-test

For large $n$, the asymptotic standard normal $z$ statistic is computed from the observed total number of runs, $r$, as:
$$
z=\dfrac{r-\mu_r}{\sigma_r}
$$
where
$$
\begin{split}
&\mu_r=\mathbb{E}(R)=\dfrac{2n_1n_2}{n}+1\\
&\sigma_r=\sqrt{\dfrac{2n_1n_2(2n_1n_2-n)}{n^2(n-1)}}
\end{split}
$$
This test is less accurate than the exact test and usually less accurate than the continuity-corrected $z$ test.

## MATLAB implementation



<br>

## Asymptotic $z$-test with continuity correction

For large $n$, the asymptotic continuity-corrected standard normal $z$ statistic is computed from the observed number of runs, $r$, as:
$$
\begin{equation}
z_{cc}=\left\{
\begin{split}
&\dfrac{r-\mu_r-0.5}{\sigma_r},\ \text{if }r\ge\mu_r\\
&\dfrac{r-\mu_r+0.5}{\sigma_r},\ \text{if }r<\mu_r\\
\end{split}\right.
\end{equation}
$$
where
$$
\begin{split}
&\mu_r=\mathbb{E}(R)=\dfrac{2n_1n_2}{n}+1\\
&\sigma_r=\sqrt{\dfrac{2n_1n_2(2n_1n_2-n)}{n^2(n-1)}}
\end{split}
$$
==this is the same as equation xxx==

This test is less accurate than the exact test but usually more accurate than the regular $z$ test.

<br>

# $k$-category extension of the single-sample runs test for randomness

For $n$ categorical outcomes, $Y_i$, the non-parametric $k$-category single-sample runs test can be used to test **the null hypothesis that the series is random**. The null hypothesis of randomness is rejected when the total number of runs is too many or too few. This test is used for categorical data.

The minimum possible total number of runs given $n_j,j=1,\cdots,k$ is:
$$
R_{\text{min}}=k
$$
The maximum possible total number of runs is calculated using an algorithm that counts the total possible arrangements given $n_j$.

The expected number of runs, $\mathbb{E}_k(R)$, given the $n_j$'s is:
$$
\mathbb{E}_k(R)=\dfrac{n(n+1)-\sum n_j^2}{n}
$$
## Asymptotic $z$-test

For large $n$, the asymptotic standard normal $z$ statistic is computed from the observed total number of runs, $r$, as:
$$
z=\dfrac{r-\mu_r}{\sigma_r}
$$
where
$$
\begin{split}
&\mu_r=\mathbb{E}_k(R)=\dfrac{n(n+1)-\sum n_j^2}{n}\\
&\sigma_r=\sqrt{\dfrac{\sum n_j^2[\sum n_j^2+n(n+1)]-2n\sum n_j^3-n^3}{n^2(n-1)}}
\end{split}
$$
This test is usually less accurate than the continuity-corrected $z$ test.

## Asymptotic $z$-test with continuity correction

For large $n$, the asymptotic continuity-corrected standard normal $z$ statistic is computed from the observed total number of runs, $r$, as:
$$
\begin{equation}
z_{cc}=\left\{
\begin{split}
&\dfrac{r-\mu_r-0.5}{\sigma_r},\ \text{if }r\ge\mu_r\\
&\dfrac{r-\mu_r+0.5}{\sigma_r},\ \text{if }r<\mu_r\\
\end{split}\right.
\end{equation}
$$
where:
$$
\begin{split}
&\mu_r=\mathbb{E}_k(R)=\dfrac{n(n+1)-\sum n_j^2}{n}\\
&\sigma_r=\sqrt{\dfrac{\sum n_j^2[\sum n_j^2+n(n+1)]-2n\sum n_j^3-n^3}{n^2(n-1)}}
\end{split}
$$
This test is usually more accurate than the regular $z$-test.

<br>

# Single-Sample Runs Test for Serial Randomness

For $n$ numeric outcomes, $Y_i$, the non-parametric, Single-Sample Runs Test for Serial Randomness can be used to test **the null hypothesis that the numeric series is random**. The null hypothesis of randomness is rejected when the total number of runs up (+) and down (-) is too many or too few. **This test can be applied only to numeric data.**

The minimum and maximum possible total number of runs are:
$$
\begin{split}
&R_{{\pm}_{\text{min}}}=1\\
&R_{{\pm}_{\text{max}}}=n-1\\
\end{split}
$$
The expected number of runs, $\mathbb{E}(R_{\pm})$, is:
$$
\mathbb{E}(R_{\pm})=\dfrac{2n-1}{3}
$$

## Exact test

The required probabilities for the exact runs test for serial randomness are given with precision of four  decimal places in Table X on page 363 of Bradley (1968) for $n\le25$. NCSS simply uses these table values in the probability calculations for the exact test.

For the alternative hypothesis of "too many runs", the exact upper one-sided $p$-value for an observed total number of runs up and down, $r_{\pm}$, is:
$$
\text{Pr}(R_\pm\ge r_\pm)=\sum_{v=r_\pm}^{R_{\pm_{\text{max}}}}\text{Pr}(R_\pm=v)
$$
For the alternative hypothesis of “too few runs”, the exact lower one-sided p-value for an observed total number of runs up and down,  $r_{\pm}$, is:
$$
\text{Pr}(R_\pm\le r_\pm)=\sum_{v=R_{\pm_{\text{min}}}}^{r_\pm}\text{Pr}(R_\pm=v)
$$
The two-sided exact $p$-value for an observed total number of runs up and down, $r_{\pm}$, is:
$$
\begin{split}
&\text{Pr}\Big(\vert R_\pm-\mathbb{E}(R_\pm)\vert\ge\vert r_\pm-\mathbb{E}(R_\pm)\vert\Big)\\
=&\sum_{v=R_{\pm_{\text{min}}}}^{\mathbb{E}(R_\pm)-\vert r_\pm-\mathbb{E}(R_\pm)\vert}\text{Pr}(R_\pm=v)+\sum_{v=\mathbb{E}(R_\pm)+\vert r_\pm-\mathbb{E}(R_\pm)\vert}^{R_{\pm_{\text{max}}}}\text{Pr}(R_\pm=v)
\end{split}
$$
The exact test is only calculated for $n\le25$. For large $n$, an asymptotic $z$-test should be used. The exact test is more accurate than the two asymptotic $z$ tests and should always be used if available.

## Asymptotic $z$ test

For large $n$, the asymptotic standard normal $z$ statistic is computed from the observed total number of runs, $r_\pm$, as:
$$
z=\dfrac{r_\pm-\mu_{r_\pm}}{\sigma_{r_\pm}}
$$
where:
$$
\begin{split}
&\mu_{r_\pm}=\mathbb{E}(R_\pm)=\dfrac{2n-1}{3}\\
&\sigma_{r_\pm}=\sqrt{\dfrac{16n-29}{90}}
\end{split}
$$
This test is less accurate than the exact test and usually less accurate than the continuity-corrected $z$-test.

## Asymptotic $z$-test with continuity correction

For large $n$, the asymptotic continuity-corrected standard normal $z$ statistic is computed from the observed total number of runs, $r_\pm$, as
$$
\begin{equation}
z_{cc}=\left\{
\begin{split}
&\dfrac{r_\pm-\mu_{r_\pm}-0.5}{\sigma_{r_\pm}},\ \text{if }r_\pm\ge\mu_{r_\pm}\\
&\dfrac{r_\pm-\mu_{r_\pm}+0.5}{\sigma_{r_\pm}},\ \text{if }r_\pm<\mu_{r_\pm}\\
\end{split}\right.
\end{equation}
$$
where:
$$
\begin{split}
&\mu_{r_\pm}=\mathbb{E}(R_\pm)=\dfrac{2n-1}{3}\\
&\sigma_{r_\pm}=\sqrt{\dfrac{16n-29}{90}}
\end{split}
$$
This test is less accurate than the exact test but usually more accurate than the regular $z$ test.

<br>

<div id="ref"></div>

**References**

[1] [NCSS Analysis of Runs](https://www.ncss.com/wp-content/themes/ncss/pdf/Procedures/NCSS/Analysis_of_Runs.pdf).

https://www.itl.nist.gov/div898/handbook/eda/section3/eda35d.htm