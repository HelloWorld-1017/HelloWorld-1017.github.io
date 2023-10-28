For $n$ binary outcomes, $Y_i$(= $0$ or $1$), the non-parametric, Single-Sample Wald-Wolfowitz Runs Test can be used to test the null hypothesis that **the binary series is random**. The null hypothesis of randomness is rejected when the total number of runs of $0$ and $1$ is too many or too few. This test can be used for binary data and for numeric data that has been categorised as either above or below a reference value.

Given the 
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

To compute the exact test for a binary series, we must calculate the probabilities of obtaining given numbers of runs conditional on the number of ...

$$
\text{Pr}(R=2u)=\dfrac{2{{n_1-1} \choose {u-1}}{{n_2-1} \choose {u-1}}}{{{n} \choose {n_1}}}
$$
The probability that the total number if runs, $R$, will be equal to some odd number $2u+1$ is:
$$
\text{Pr}(R=2u+1)=\dfrac{{{n_1-1} \choose {u-1}}{{n_2-1} \choose {u-1}}+{{n_1-1}\choose u}{{n_2-1}\choose {u-1}}}{{{n} \choose {n_1}}}
$$
For the alternative hypothesis of ...
$$
\text{Pr}(R\ge r)=\sum_{v=r}^{R_{\text{max}}}\text{Pr}(R=v)
$$






<br>

**References**

[1] 