---
layout: single
title: MATLAB `filloutliers` function
date: 2022-09-26 15:43:44 +0800
categories:
 - MATLAB
 - Signals and Systems
tags:
 - MATLAB Data Import and Analysis
---

# Introduction

信号数据预处理中比较常见的一个步骤是离群值（outliers）处理，MATLAB提供了相应的函数处理离群值，包括检测并移除离群值的`rmoutliers`函数，以及检测并替换离群值的`fillouliers`函数，后者应用更为广泛，因为我们通常想要保持相同类型的信号的长度是一致的，因此本文就简单整理一下`fillouliers`函数的使用和原理。

`fillouliers`函数中可供用户设置的属性主要有两大部分，分别是：异常值替换算法`fillmethod`，异常值检测算法`movemethod`。本文举出了几个常用的使用示例来进行说明。

<br>


# Examples

##  ` filloutliers(Data, "linear", "mean")`

```
[cleanedData, outlierIndices, thresholdL, thresholdH, center] = filloutliers(Data, "linear", "mean");
```

该函数：

- `fillmethod`使用的是`"linear"`，表示使用的是线性填充离群值，相当于在离群点附近的两个非离群点之间拉一条线段；
- `findmethod`使用的是`"mean"`，表示离群值的查找规则是`"mean"`，该方法认为离群值点是超过均值正负三个标准差范围的点。

示例：

```matlab
clc, clear, close all

A = [57 59 60 100 59 58 57 58 300 61 62 60 62 58 57];
[cleanedA, outlierIndices, thresholdL, thresholdH, center] = ...
    filloutliers(A, "linear", "mean");

figure, axes 
hold(gca, "on")
box(gca, "on")
grid(gca, "on")

% Plot original data
plot(A, "Color", [77 190 238]/255, "DisplayName", "Input data")
% Plot results
plot(cleanedA, "Color", [0 114 189]/255, "LineWidth", 1.5,...
    "DisplayName", "Cleaned data")
% Plot outliers
plot(find(outlierIndices), A(outlierIndices), "x", "MarkerSize", 10, ...
    "Color", [64 64 64]/255, "DisplayName", "Outliers")
% Plot filled outliers
plot(find(outlierIndices), cleanedA(outlierIndices), ".", "MarkerSize", 20,...
    "Color", [217 83 25]/255, "DisplayName", "Filled outliers")
% Plot outlier thresholds
plot([(1:numel(A))'; missing; (1:numel(A))'],...
    [thresholdH(:)*ones(numel(A), 1); missing; thresholdL(:)*ones(numel(A), 1)], ...
    "Color", [145 145 145]/255, ...
    "DisplayName", "Outlier thresholds")
% Plot outlier center
plot(center*ones(numel(A), 1), "k", "LineWidth", 1.5, "DisplayName", "Outlier center")
title("Number of outliers cleaned: " + nnz(outlierIndices))
legend('Location', 'best')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220925191239519.png?raw=true" alt="image-20220925191239519" style="zoom:67%;" />

可以验证一下离群值查找规则`"mean"`：

```matlab
>> mean(A)-3*std(A), mean(A)+3*std(A)
ans =
 -109.2459
ans =
  264.9792
  
>> thresholdL, thresholdH
thresholdL =
 -109.2459
thresholdH =
  264.9792
```

## `filloutliers(Data, "linear", "movmedian", window)`

```matlab
[cleanedData, outlierIndices, thresholdL, thresholdH, center] = filloutliers(Data, "linear", "movmedian", window);
```

该函数`findmethod`使用的是`"movmedian"`方法，该方法：Outliers are defined as elements more than **three local scaled MAD** from the local median over a window length specified by `window`. This method is also known as a *Hampel filter*.

对于具有N个observations的向量A，它的中值绝对偏差（median absolute deviation, MAD）定义为：

$$
\mathrm{MAD}=\mathrm{median}\Big(\vert A_i-\mathrm{median}(A)\vert\Big),\quad i=1,2,\cdots, N\notag
$$

scaled MAD被定义为：

$$
\mathrm{scaled\ MAD}=c\times\mathrm{median}\Big(\vert A_i-\mathrm{median}(A)\vert\Big),\quad i=1,2,\cdots, N\notag
$$

其中，`c=-1/(sqrt(2)*erfcinv(3/2))`。`erfcinv`是逆互补误差函数（Inverse complementary error function），并且有`erfcinv(erfc(x))=x`。

$x$的互补误差函数（Complementary error function，即`erfc(x)`）定义为：

$$
\mathrm{erfc}(x)=\dfrac{2}{\sqrt\pi}\int^{\infty}_xe^{-t^2}\mathrm{d}t=1-\mathrm{erf}(x)\notag
$$

`erf`为误差函数（Error function），定义为：
$$
\mathrm{erf}(x)=\dfrac{2}{\sqrt\pi}\int^{x}_0e^{-t^2}\mathrm{d}t\notag
$$

示例：

```matlab
clc, clear, close all
rng('default')

A = ceil(randn(100, 1)*10); A(20) = 200;
[cleanedA, outlierIndices, thresholdL, thresholdH, center] = ...
    filloutliers(A, "linear", "movmedian",  15);

figure, axes 
hold(gca, "on")
box(gca, "on")
grid(gca, "on")

% Plot original data
plot(A, "Color", [77 190 238]/255, "DisplayName", "Input data")
% Plot results
plot(cleanedA, "Color", [0 114 189]/255, "LineWidth", 1.5,...
    "DisplayName", "Cleaned data")
% Plot outliers
plot(find(outlierIndices), A(outlierIndices), "x", "MarkerSize", 10, ...
    "Color", [64 64 64]/255, "DisplayName", "Outliers")
% Plot filled outliers
plot(find(outlierIndices), cleanedA(outlierIndices), ".", "MarkerSize", 20,...
    "Color", [217 83 25]/255, "DisplayName", "Filled outliers")
% Plot outlier thresholds
plot([(1:numel(A))'; missing; (1:numel(A))'],...
    [thresholdH(:); missing; thresholdL(:)], ...
    "Color", [145 145 145]/255, ...
    "DisplayName", "Outlier thresholds")
% Plot outlier center
plot(center, "k", "LineWidth", 1.5, "DisplayName", "Outlier center")
title("Number of outliers cleaned: " + nnz(outlierIndices))
legend('Location', 'best')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220925210702401.png?raw=true" alt="image-20220925210702401" style="zoom:67%;" />

验证一下算法原理：

```matlab
contrast1 = movmedian(A, 15) == center;
c = -1/(sqrt(2)*erfcinv(3/2));
contrast2 = center+3*c*movmedian(abs(A - movmedian(A, 15)), 15)-thresholdH;
contrast3 = center-3*c*movmedian(abs(A - movmedian(A, 15)), 15)-thresholdL;
nnz(contrast1), nnz(contrast2), nnz(contrast3)
```

```matlab
ans =
   100
ans =
    72
ans =
    72
```

可以看到，根据算法原理计算出的值和函数输出的`center`是完全一致的，但是上下限只有72个点是一致的，其余28个点有偏差，这里的问题不清楚出在了哪里。

## `filloutliers(Data, "clip")`

```matlab
[cleanedData, outlierIndices, thresholdL, thresholdH, center] = filloutliers(Data, "clip");
```

另一种比较常用的`fillmethod`是`"clip"`方法：

```matlab
clc, clear, close all

A = [60 59 49 49 58 100 61 57 48 58];
[cleanedA, outlierIndices, thresholdL, thresholdH, center] = ...
    filloutliers(A, "clip");

figure, axes 
hold(gca, "on")
box(gca, "on")

% Plot original data
plot(A, "Color", [77 190 238]/255)
% Plot results
plot(cleanedA, "Color", [0 114 189]/255, "LineWidth", 1.5)
% Plot outliers
plot(find(outlierIndices), A(outlierIndices), "x", "MarkerSize", 10, ...
    "Color", [64 64 64]/255)
% Plot filled outliers
plot(find(outlierIndices), cleanedA(outlierIndices), ".", "MarkerSize", 20,...
    "Color", [217 83 25]/255)
% Plot lower thrshold, upper threshold, and center
yline([thresholdL thresholdH center], ":", ["Lower Threshold","Upper Threshold","Center Value"])
title("Number of outliers cleaned: " + nnz(outlierIndices))
legend("Input data", "Cleaned data", "Outliers", "Filled outliers", "", "", "", ...
    "Location", "best")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220926152540973.png?raw=true" alt="image-20220926152540973" style="zoom:67%;" />

<br>


**参考**

[1] [filloutliers - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/filloutliers.html).

[2] [median - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/median.html).

[3] [erfcinv - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/erfcinv.html).

[4] [erfc - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/erfc.html).

[5] [erf - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/erf.html).

[6] [rmoutliers - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/rmoutliers.html).

