MATLAB Statistics and Machine Learning Toolbox



Z-test is a kind of statistical test that tests whether a set of data come from a certain **normal distribution**, 

testing the mean of a distribution [1]. 

The null hypothesis of Z-test is that  









For each [significance level](https://en.wikipedia.org/wiki/Statistical_significance) in the [confidence interval](https://en.wikipedia.org/wiki/Confidence_intervals), the *Z*-test has a single critical value (for example, 1.96 for 5% two tailed) which makes it more convenient than the [Student's *t*-test](https://en.wikipedia.org/wiki/Student's_t-test) whose critical values are defined by the sample size (through the corresponding [degrees of freedom](https://en.wikipedia.org/wiki/Degrees_of_freedom_(statistics))). [1] 



However, the z-test is rarely used in practice because the population deviation is difficult to determine. [1]



standardized test statistic:
$$
Z=\dfrac{\bar{X}-\mu_0}{s}
$$
The $s$ is either known or approximated by:
$$
s=\dfrac\sigma{\sqrt{n}}
$$


​	





<br>

**References**

[1] [Z-test - Wikipedia](https://en.wikipedia.org/wiki/Z-test).

[p-value - Wikipedia](https://en.wikipedia.org/wiki/P-value).

[2] [z-test - MathWorks](https://ww2.mathworks.cn/help/stats/ztest.html).

[5] [One-sample and paired-sample t-test - MATLAB ttest - MathWorks China](https://ww2.mathworks.cn/help/stats/ttest.html).

