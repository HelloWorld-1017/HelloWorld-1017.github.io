---
title: The processing methods for ill-conditioned SCM in MATLAB `fitgimdist`, `mahal` and `mvnrnd` functions in case of extremely small sample
date: 2022-11-22 19:27:21 +0800
categories: 
 - MATLAB
 - Mathematics
tags:
 - MATLAB Warnings and Errors
 - Matrix
 - Numerical Analysis
---

# "X must have more rows than columns." error in `fitgmdist` function 

在博客[Gaussian Mixture Model(GMM)](http://whatastarrynight.com/mathematics/programming/machine%20learning/Gaussian-Mixture-Model/)讨论高斯混合模型时，我们介绍了MATLAB的高斯拟合函数`fitgmdist`，但是在实际使用该函数时，遇到了一些问题。

比如，运行下面的程序：

```matlab
clc, clear, close all

numSamples = 7;
numFeatures = 11;
features = randn(numSamples, numFeatures);

k = 3; % The number of GMM components

gmm = fitgmdist(features, 3);
```

MATLAB会报错，报错信息为：

```
Error using gmdistribution.fit
X must have more rows than columns.

Error in fitgmdist (line 135)
gm = gmdistribution.fit(X,k,varargin{:});

Error in script1 (line 9)
gmm = fitgmdist(features, 3);
```

程序停止在了：

![image-20221122144455066](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221122144455066.png?raw=true)

说明当样本的数量小于特征的数量时，无法使用`fitgmdist`，并且在判断输入参数的时候就已经报错了，不会执行运算。`fitgmdist`是基于EM算法进行迭代的，但是理论上EM算法并没有这样的前提，这是MATLAB在代码实现时所添加的限制。

为什么会有这样的限制呢？

`fitgmdist`函数的函数调用关系比较复杂，并且涉及到MATLAB的自建类，修改源代码比较麻烦。但是我们可以从另一个函数`mahal`中看到这么做的原因。

<br>

# "The number of rows of X must exceed the number of columns." error in `mahal` function

在博客[Multivariate Normal Distribution and Mahalanobis Distance](http://whatastarrynight.com/mathematics/programming/Multivariate-Normal-Distribution-and-Mahalanobis-Distance/#mahal-function-in-matlab)中，我们介绍了MATLAB用于计算马氏距离的函数`mahal`，该函数在使用的时候会发生类似的报错：

```matlab
clc, clear, close all

numSamples = 7;
numDimension = 11;
Samples = randn(numSamples, numDimension);

Y = ones(1, numDimension);

d2_mahal = mahal(Y, Samples);
```

报错：

```matlab
Error using mahal
The number of rows of X must exceed the number of columns.

Error in script2 (line 9)
d2_mahal = mahal(Y, Samples);
```

![image-20221122150530999](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221122150530999.png?raw=true)

提示用于表示样本分布$Q$的样本点$X$，样本的数量必须超过维度的数量，这和上面`fitgmdist`函数遇到的报错是类似的。但显然，在理论上也并没有这样的规定。

`mahal`函数的源代码非常简单，因此我们把源代码复制一份放在脚本文件的后面，并且把报错的部分注释掉：

```matlab
clc, clear, close all
rng("default")

numSamples = 7;
numDimension = 11;
Samples = randn(numSamples, numDimension);

Y = ones(1, numDimension);

d2_mahal = mahal(Y, Samples);

function d = mahal(Y,X)
% MAHAL Mahalanobis distance.
% Copyright 1993-2007 The MathWorks, Inc. 

[rx,cx] = size(X);
[ry,cy] = size(Y);

if cx ~= cy
   error(message('stats:mahal:InputSizeMismatch'));
end

% if rx < cx
%    error(message('stats:mahal:TooFewRows'));
% end

if any(imag(X(:))) | any(imag(Y(:)))
   error(message('stats:mahal:NoComplex'));
end

m = mean(X,1);
M = m(ones(ry,1),:);
C = X - m(ones(rx,1),:);
[Q,R] = qr(C,0);

ri = R'\(Y-M)';
d = sum(ri.*ri,1)'*(rx-1);
end
```

发现可以运行，求出的距离为：

```matlab
d2_mahal =
    4.8158
```

虽然可以运行，但是MATLAB会报警告：

```matlab
Warning: Rank deficient, rank = 6, tol =  1.331396e-14. 
> In script3>mahal (line 36)
In script3 (line 10) 
```

说明在运算的过程中，遇到了不可逆矩阵。

可能是出于数值计算稳定性的角度，MATLAB提供的`mahal`函数用到了比较多的数值计算trick，我不是很清楚。我们可以直接从马氏距离的定义出发，自己编写计算马氏距离的代码。

马氏距离的定义：
$$
d_M(\boldsymbol{x}, Q)=\sqrt{(\boldsymbol{x}-\boldsymbol{\mu})^TS^{-1}(\boldsymbol{x}-\boldsymbol{\mu})}\notag
$$
代码：

```matlab
clc, clear, close all
rng("default")

numSamples = 7;
numDimension = 11;
Samples = randn(numSamples, numDimension);

Y = ones(1, numDimension);

mu_samples = mean(Samples);
Sigma_samples = cov(Samples);

d2_selfmahal = (Y-mu_samples)*inv(Sigma_samples)*(Y-mu_samples)';
```

结果：

```matlab
d2_selfmahal =
  -1.2138e+17
```

仍然报warning：

```
Warning: Matrix is close to singular or badly scaled. Results may be inaccurate. RCOND =  1.405130e-18. 
> In scirpt4_selfmahal (line 13)
```

问题就出在`inv(Sigma_samples)`的运算上，因为此时的协方差矩阵`Sigma_samples`是非常接近奇异矩阵。

> 注意到报错信息中的`RCOND =  1.405130e-18`，这里的`RCOND`表示矩阵条件数的倒数，可以借助`cond`函数进行计算：
>
> ```matlab
> >> 1/cond(Sigma_samples)
> ans =
>    1.2620e-18
> ```
>
> 矩阵条件数的倒数非常小，即条件数非常大，远远大于1，因此协方差矩阵`Sigma_samples`是一个病态矩阵，并且病态的程度很大。

<br>

# Due to small sample

如果把样本的个数增加到100个，再使用MATLAB自建函数`mahal`和自己写的代码分别进行计算：

```matlab
clc, clear, close all
rng("default")

numSamples = 100;
numDimension = 11;
Samples = randn(numSamples, numDimension);

Y = ones(1, numDimension);

% Calculate using built-in mahal function
d2_mahal = mahal(Y, Samples);

% Calculate using custom process
mu_samples = mean(Samples);
Sigma_samples = cov(Samples);
d2_selfmahal = (Y-mu_samples)*inv(Sigma_samples)*(Y-mu_samples)';
```

```matlab
>> d2_mahal, d2_selfmahal
d2_mahal =
   14.0784
d2_selfmahal =
   14.0784
```

两个方式的计算结果是一致的，并且都没有报错。

因此，MATLAB的`fitgmdist`函数和`mahal`函数关于“样本数小于特征数”的error，可能就是为了防止小样本情况下的协方差矩阵奇异(不可逆)的情况。

实际上，样本的协方差矩阵一定是半正定的(semi-definite)，具体的证明可见：[Is a sample covariance matrix always symmetric and positive definite? - StackExchange](https://stats.stackexchange.com/questions/52976/is-a-sample-covariance-matrix-always-symmetric-and-positive-definite). 但是极小样本的情况下，更容易出现SCM非常接近不可逆的情况，即SCM是一个病态矩阵。

另外，在上面的极小样本的情况，使用MATLAB的`mahal`函数和我们自己编写的代码计算出的马氏距离的平方分别为：

```matlab
d2_mahal =
    4.8158
d2_selfmahal =
  -1.2138e+17
```

说明MATLAB所使用的数值计算trick能够改善这一问题，但是仍然会报warning。

<br>

# Cholesky factorization for semi-definite matrix in `mvnrnd` function

在博客[Train an SVM Using Generated Data by MVN-RNG, and Test with Real Data](http://whatastarrynight.com/mathematics/programming/machine%20learning/Train-An-SVM-Using-Generated-Data-by-MVN-RNG-and-Test-Using-Real-Data/)中，我们介绍了使用`mvnrnd(mu, Sigma)`的方式来生成和样本同分布(相同MVN分布)的随机数，那么在上述小样本的情况下，`mvnrnd`函数会报错吗？

我们仍然用上面的例子进行测试：

```matlab
clc, clear, close all
rng("default")

numSamples = 7;
numDimension = 11;
Samples = randn(numSamples, numDimension);

mu_samples = mean(Samples);
Sigma_samples = cov(Samples);

newSample = mvnrnd(mu_samples, Sigma_samples);
```

结果并没有报错。为什么error或者warning呢？因为根据MVN的定义：

$$
f(x;\mu,\Sigma)=\dfrac{1}{\sqrt{\vert\Sigma\vert(2\pi)^d}}\mathrm{exp}(-\dfrac12(x-\mu)\Sigma^{-1}(x-\mu)^T)\notag
$$

定义中出现了$\Sigma^{-1}$，所以为什么没有报错呢？

打开MATLAB`mvnrnd`函数的源代码：

![image-20221122164728343](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221122164728343.png?raw=true)

可以看到，编写该函数的时候已经考虑到了特征"can have perfect correlation"的情况，因而使用了Cholesky因子分解的方式将SCM分解，之后对`randn`生成的随机数进行计算等操作，从而避免了对SCM求逆的操作，是一个很好的trick。

该方法的原理如下(参考：[linear algebra - Generating multivariate normal samples - why Cholesky? - Mathematics Stack Exchange](https://math.stackexchange.com/questions/2079137/generating-multivariate-normal-samples-why-cholesky))：

假设$n$维随机变量服从多维正态分布，即$X\sim\mathcal{MVN}(\tau,\Lambda)$，其中$\tau\in\mathbb{R}^n$，$\Lambda\in\mathbb{R}^{n\times n}$，则经过仿射变换$Y=BX+b$之后，随机变量$Y$的分布为：$Y\sim\mathcal{MVN}(B\tau+b,B\Lambda B^T)$。

因此，如果我们从多维**标准**正态分布中进行采样，即$X\sim\mathcal{MVN}(0,I)$，则经过仿射变换$Y=BX+b$后有$Y\sim\mathcal{MVN}(b,BB^T)$。即若我们想要得到$Y\sim\mathcal{MVN}(\mu,\Sigma)$，则我们需要的仿射变换为$Y=BX+\mu$，其中$\Sigma=BB^T$，而是用Cholesky分解则可以很方便地将$\Sigma$分解为$BB^T$的形式。

但其实，$\Sigma=BB^T$并不保证分解的唯一性，但是Cholesky分解是一种高效的数值计算方法。

<br>
