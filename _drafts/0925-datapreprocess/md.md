



以下是比较常用的语法：

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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220925191239519.png" alt="image-20220925191239519" style="zoom:67%;" />

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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220925210702401.png" alt="image-20220925210702401" style="zoom:67%;" />








**参考**

[1] [filloutliers - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/filloutliers.html).

[2] [median - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/median.html).

[3] [erfcinv - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/erfcinv.html).

[4] [erfc - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/erfc.html).

[5] [erf - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/erf.html).

















比较全的语法是：

```matlab
[cleanedData, outlierIndices, thresholdLow, thresholdHigh, center] = 
```





