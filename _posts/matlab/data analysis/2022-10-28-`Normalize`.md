---
layout: single
title: MATLAB `Normalize` Function
date: 2022-10-28 20:50:03 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Data Import and Analysis
toc: false
---

在数据分析的时候，通常会将数据进行标准化，以消除尺度的影响。

> 定理1
>
> 1. 常数的方差为0；
> 2. 若$c$为常数，则$\mathrm{Var}(X+c)=\mathrm{Var}(X)$；
> 3. 若$c$为常数，则$\mathrm{Var}(cX)=c^2\mathrm{Var}(X)$
>
> 假设$X$为一个随机变量，且有$E(X)=a$，而$\mathrm{Var}(X)=\sigma^2$。记$Y=(X-a)/\sigma$，则容易得到$E(Y)=0$，并且按照定理1可以得到$\mathrm{Var}(Y)=1$。这样，对$X$做一个线性变换后，得到一个具有均值0、方差1的随机变量$Y$，常称为$Y$是$X$的**标准化**。

之前，在使用MATLAB实现的时候，我一般是这样做的：

```matlab
A = [1, 3, 6, 17, 7;
    8, 9, 2, 5, 8;
    7, 7, 0, 2, 5];
mu = mean(A);
sigma = std(A);

A_normalized = (A-mu)./sigma;
```

```matlab
mu =
    5.3333    6.3333    2.6667    8.0000    6.6667
    
sigma =
    3.7859    3.0551    3.0551    7.9373    1.5275

A_normalized =
   -1.1446   -1.0911    1.0911    1.1339    0.2182
    0.7044    0.8729   -0.2182   -0.3780    0.8729
    0.4402    0.2182   -0.8729   -0.7559   -1.0911
```

之后，根据`mu`和`sigma`就可以在后面进行“反标准化”。

我们可以简单验证一下：

```matlab
mean(A_normalized), var(A_normalized)
```

```matlab
ans =
   1.0e-15 *
    0.0925    0.0740         0    0.0370   -0.2220

ans =
    1.0000    1.0000    1.0000    1.0000    1.0000
```

和上面的结论是一致的。

但实际上，MATLAB本身就提供了标准化函数`Normalize`，可以使用该函数可以更简洁地得到同样的结果：

```matlab
A = [1, 3, 6, 17, 7;
    8, 9, 2, 5, 8;
    7, 7, 0, 2, 5];

[A_normalized, mu, sigma] = normalize(A);
```

```matlab
mu =
    5.3333    6.3333    2.6667    8.0000    6.6667

sigma =
    3.7859    3.0551    3.0551    7.9373    1.5275

A_normalized =
   -1.1446   -1.0911    1.0911    1.1339    0.2182
    0.7044    0.8729   -0.2182   -0.3780    0.8729
    0.4402    0.2182   -0.8729   -0.7559   -1.0911
```

上述标准化方法是`normalize`函数默认的标准化方法`zscore`，除此之外，还可以设定其的方法：

![image-20221028204619191](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221028204619191.png?raw=true)

<br>

**Reference**

[1] [normalize - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/double.normalize.html).

