---
layout: single
title: Multivariate Normal Distribution and Mahalanobis Distance
date: 2022-09-07 13:26:02 +0800
categories: 
 - Mathematics
 - MATLAB
tags:
 - Matrix
 - Probability Theory and Mathematical Statistics
 - MATLAB Statistics and Machine Learning Toolbox
---

# Multivariate Normal Distribution

## Probability Density Function(PDF) and Cumulative Distribution  Function(CDF)

$d$-维多元正态函数的概率密度函数的形式为：

$$
y=f(x,\mu,\Sigma)=\dfrac1{\sqrt{\vert\Sigma\vert(2\pi)^d}}\exp\Big(-\dfrac12(x-\mu)\Sigma^{-1}(x-\mu)^T\Big)\label{eq1}
$$

其中，$x$和$\mu$是$1\times d$的向量，$\Sigma$是$d\times d$的对称定阵(symmetric definite matrix)。

多元随机变量的在$\boldsymbol{x}$处的累积分布函数定义为：

$$
P(\boldsymbol{x})=P(X_1<x_1,X_2<x_2,\cdots,X_d<x_d)\notag
$$

尽管多元正态分布的CDF没有闭式表达式，但是MATLAB中的`mvncdf`函数可以对CDF进行数值计算。

下面就以服从：

$$
\mu=[0,0],\ \Sigma=\begin{bmatrix}0.25&0.3\\0.3&1\end{bmatrix}\notag
$$

的二元正态分布为例，计算PDF和CDF，并进行可视化。

## Bivariate Normal Distribution PDF

使用`mvnpdf`函数计算二元正态分布的PDF并进行绘图：

```matlab
clc, clear, close all

% Define the parameters mu and Sigma
mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];

% Create a grid of evenly spaced points in two-dimensional space
x1 = -3:0.1:3;
x2 = -3:0.1:3;
[X1, X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

% Evaluate the PDF of the normal distribution at the grid points
y = mvnpdf(X, mu, Sigma);
y = reshape(y, length(x2), length(x1));

figure('Units', 'normalized', 'Position', [0.2164, 0.2532, 0.4328, 0.5255])
colormap("jet")
% Tile1, pdf values
nexttile
surf(x1, x2, y)
axis([-3 3 -3 3 0 0.4])
view(-22.38, 54.15)
colorbar
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')
title('surf')

% Tile2, contour
nexttile
contour(x1, x2, y)
colorbar
xlabel('x1')
ylabel('x2')
title('contour')

% Tile3, imagesc
nexttile
imagesc(x1, x2, y)
colorbar
xlabel('x1')
ylabel('x2')
title('imagesc')

% Tile 4, plot3
nexttile
plot3(x1, x2, y)
view(5.57, 24.20)
colorbar
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')
title('plot3')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220905195913743.png?raw=true" alt="image-20220905195913743" style="zoom:80%;" />

## Biviriate Normal Distribution CDF

使用`mvncdf`函数数值计算二元正态分布函数的CDF，并进行绘图：

```matlab
clc, clear, close all

% Define the mean vector mu and the covariance matrix Sigma
mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];

% Create a grid of evenly spaced points in two-dimensional space
gridSize = 50;
x1 = linspace(-3, 3, gridSize)';
x2 = linspace(-3, 3, gridSize)';
[X1, X2] = meshgrid(x1, x2);
X = [X1(:) X2(:)];

% Evaluate the cdf of the normal distribution at the grid points
p = mvncdf(X, mu, Sigma);
Z = reshape(p, gridSize, gridSize);

figure('Units', 'pixels', 'Position', [575,327.6667,1205.3333, 903.3333])
colormap("jet")
% Tile1, Plot the CDF values
nexttile
surf(X1, X2, Z)
colorbar
xlabel('x1')
ylabel('x2')
zlabel('CDF values')
title('surf')
xlim([-3, 3])
ylim([-3, 3])
zlim([0, 1])

% Tile2, contour
nexttile
contour(X1, X2, Z, LineWidth=1.5)
colorbar
xlabel('x1')
ylabel('x2')
title('contour')

% Tile3, imagesc
nexttile
imagesc(x1, x2, Z)
xlabel('x1')
ylabel('x2')
title('imagesc')
colorbar

% Tile4, plot3
nexttile
plot3(X1, X2, Z, LineWidth=1.5)
colorbar
xlabel('x1')
ylabel('x2')
zlabel('CDF values')
title('plot3')
xlim([-3, 3])
ylim([-3, 3])
zlim([0, 1])
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220905195952951.png?raw=true" alt="image-20220905195952951" style="zoom:80%;" />

CDF其实就是PDF在某一区域的二元积分，比如在计算在$x,y\in[0,1]$内的CDF：

```matlab
clc, clear, close all

mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];

% Compute the probability over the unit square
p = mvncdf([0 0], [1 1], mu, Sigma);

x1 = -3:.2:3;
x2 = -3:.2:3;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];


figure('Units', 'pixels', 'Position', [581.6667, 255, 905.3333, 950])
colormap("jet")
% Tile1, PDF values
nexttile
pdf = mvnpdf(X, mu, Sigma);
pdf = reshape(pdf, length(x2), length(x1));
contour(x1, x2, pdf, [0.0001 0.001 0.01 0.05 0.15 0.25 0.35], LineWidth=1.3)
line([0 0 1 1 0], [1 0 0 1 1], 'Linestyle', '--', 'Color', 'k', LineWidth=1.7)
colormap("jet")
colorbar
xlabel('x1')
ylabel('x2')
title('PDF values')

% Tile2, CDF values
nexttile
cdf = mvncdf(X, mu, Sigma);
cdf = reshape(cdf, length(x2), length(x1));
contour(x1, x2, cdf, LineWidth=1.3)
line([0 0 1 1 0], [1 0 0 1 1], 'Linestyle', '--', 'Color', 'k', LineWidth=1.7)
colormap("jet")
colorbar
xlabel('x1')
ylabel('x2')
title('CDF values')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220905201418897.png?raw=true" alt="image-20220905201418897" style="zoom:80%;" />

可以得到：

```matlab
p =
    0.2097

err =
   1.0000e-08
```

<br>

# Mahalanobis Distance

## Definition

马氏距离(Mahalanobis distance)用于度量点P到分布D的距离。马氏距离是测量点P到分布D的均值之间的标准差这一思想的多维推广。如果点P在分布D的均值处，则马氏距离为零，并且马氏距离随着沿每个主成分轴(principal component axis)远离平均值而增加。如果每个轴被重新缩放有着统一的标准差，则马氏距离对应变换空间中的欧式距离。因此，马氏距离是没有单位的(unitless)，缩放不变的(scale-invariant)，并且考虑数据集的相关性(takes into account the correlations of the data set)。

**点到分布的马氏距离**

给定在$\mathbb{R}^{N}$上的概率分布$Q$，其均值为$\boldsymbol{\mu}=(\mu_1,\mu_2,\cdots,\mu_N)$，正定协方差矩阵为$S$，则观测点$\boldsymbol{x}=(x_1, x_2, x_3, \cdots, x_N)^T$到分布$Q$的马氏距离定义为：

$$
d_M(\boldsymbol{x}, Q)=\sqrt{(\boldsymbol{x}-\boldsymbol{\mu})^TS^{-1}(\boldsymbol{x}-\boldsymbol{\mu})}\label{mahalanobisdistance}
$$

**两点之间的（关于分布的）马氏距离**

给定$\mathbb{R}^{N}$上的两个点$\boldsymbol{x}$和$\boldsymbol{y}$，它们之间关于分布$Q$的马氏距离定义为：

$$
d_M(\boldsymbol{x},\boldsymbol{y};Q)=\sqrt{(\boldsymbol{x}-\boldsymbol{y})^TS^{-1}(\boldsymbol{x}-\boldsymbol{y})}\notag
$$

这意味着$d_M(\boldsymbol{x}, Q)=d_M(\boldsymbol{x},\boldsymbol{\mu};Q)$。

由于$S$是正定的，因此$S^{-1}$也是正定的，因此平方根始终有定义。我们可以找到马氏距离平方(squared Mahalanobis distance)的有用分解(decompositions)用于解释多变量观测值外溢(outlyingness)的一些外溢，也为识别异常值提供了图形工具。

根据矩阵分析中的谱定理(spectral theorem)，$S^{-1}$可以被分解为$S^{-1}=W^TW$，于是我们可以得到马氏距离的等价定义：

$$
d_M(\boldsymbol{x}, \boldsymbol{y};Q)=\vert\vert W(\boldsymbol{x}-\boldsymbol{y})\vert\vert\label{eq2}
$$

其中，$\vert\vert\cdot\vert\vert$表示欧几里得范数。定义式$\eqref{eq2}$表明，马氏距离是白化变换(whitening transformation)后的欧氏距离。

$W$的存在是由谱定理保证的，但它并不唯一。不同的选择有不同的理论上和实践上的优点。

另外，在实际中，分布$Q$是由一些来自未知分布的独立同分布的样本点所构成的样本分布(sample distribution)，因此$\mu$实际上也可以表示样本均值，$S$表示样本协方差矩阵。

当样本的仿射跨度(affine span)不是在整个$\mathbb{R}^N$空间，则协方差矩阵可能不是正定的，这意味着上述的定义不成立。但是注意到在一般情况下，在样本仿射跨度的任何全秩仿射变换(full-rank affine transformation)下，马氏距离是保持不变的(preserved)。所以，当样本的仿射跨度不在整个$\mathbb{R}^N$空间，则可以首先将非退化地(non-degenerately)投影到$\mathbb{R}^n$，其中$n$是样本仿射跨度的维度，之后就可以像往常一样计算马氏距离。

## Intuitive explanation

假设在$N$维欧式空间中给定一些独立同分布的样本点，现在我们想要估计一个测试点属于这个样本分布的概率。首先第一步是找到样本点的质心(centroid)或中心(center)。直觉上，当测试点离中心越近，就越可能属于这个样本分布。

然而，我们还需要知道样本分布的范围，这样我们才可以较好地衡量这个**距离**。最简单的方式是估计**样本点**和样本中心点之间距离的标准偏差(standard deviation)。如果测试点到样本中心点的距离小于一个标准偏差，那么我们可以说该测试点很有可能属于这个分布，否则，测试点属于这个分布的可能性就小。

测试点与样本中心点之间的距离可以写作：

$$
\dfrac{\vert\vert x-\mu\vert\vert_2}{\sigma}\label{eq3}
$$

其含义是：

$$
\dfrac{test\ point-sample\ mean}{standard\ deviation}\notag
$$

将式$\eqref{eq3}$带入到正态分布（多元正态分布，只是多变量之间不相关）中，我们可以得到测试点属于样本分布的概率。

但是上述这个直观的方法有一个缺点，因为我们假设样本是分布在样本中心点的球形分布内的。实际上很多时候，样本是分布在一个非球形区域内的，比如分布在椭球体内，因此我们希望这个概率不仅依赖于测试点到样本中心点的**距离**，而且依赖于**方向**。在那些椭球体短轴的方向上，距离必须更小一些才能与在长轴方向上距离较大的的测试点有着同样的概率。从数学上，我们可以通过构建样本的协方差矩阵来估计最能代表样本分布的椭球体，而马氏距离是测试点到样本中心点的距离除以测试点方向上椭球体的宽度。



## `mahal` Function in MATLAB

### Fundamental  Usage

MATLAB的`mahal`函数用于计算观测点到给定样本分布的马氏距离的平方，其基本语法是：

```matlab
d2 = mahal(Y,X)
```

函数会根据输入的样本点`X`计算出样本均值$\mu$和协方差矩阵$\Sigma$从而确定分布$D$，之后根据式$\eqref{mahalanobisdistance}$计算观测点`Y`到分布$D$的马氏距离的平方。其中，函数输入`X`是一个p-by-m的矩阵，p表示样本点的数量，m表示样本点随机变量的维度；函数输入`Y`是一个n-by-m的矩阵，n为观测点的数量，m表示随机变量的维度，与输入`X`的维度保持一致。输出`d2`表示每一个点到分布$D$的马氏距离的平方，是一个n-by-1的矩阵。

```matlab
% mahal.m, source code
m = mean(X,1);
M = m(ones(ry,1),:);
C = X - m(ones(rx,1),:);
[Q,R] = qr(C,0);

ri = R'\(Y-M)';
d = sum(ri.*ri,1)'*(rx-1);
```

注意：`mahal`函数返回的是马氏距离的平方$d^2$。
{: .notice--warning}

### Explanation Example

```matlab
clc, clear, close all

% Generate a correlated bivariate sample data set
mu = [0; 0];
Sigma = [1 .9; .9 1];
rng('default') % For reproducibility
X = mvnrnd(mu, Sigma,1000); 

% Specify four observations that are equidistant from the mean of X in Euclidean distance
Y = [1 1;1 -1;-1 1;-1 -1];

% Compute the Mahalanobis distance of each observation in Y to the reference samples in X.
d2_mahal = mahal(Y, X);

% Compute the squared Euclidean distance of each observation in Y from the mean of X .
meanX = mean(X);
d2_Euclidean = sum((Y-meanX).^2, 2);


% Plot schematics
figure('Units', 'pixels', 'Position', [381, 314, 1059, 442])
tiledlayout(1, 2)
colormap("jet")
% Plot sample in Euclidean space
nexttile
hold(gca, "on")
scatter(X(:,1), X(:,2), 5, 'filled') % Scatter plot with points of size 10
scatter(Y(:,1), Y(:,2), 100, d2_mahal, 'o', 'filled')
scatter(meanX(1), meanX(2), 100, 'ko', 'filled')
hb1 = colorbar;
ylabel(hb1, 'Mahalanobis Distance')
xlabel('x1')
ylabel('x2')
legend('X', 'Y', 'Sample mean', 'Location', 'best')
title('(a) Mahalanobis Distance in Euclidean Space')
box on
grid on

% Calculate the the inverse of the Sigma
Sigma_inv = inv(Sigma);

% Operate Cholesky factorization for the Sigma^{-1}
% Sigma_inv = W*W^T;
W = chol(Sigma_inv, "lower");

% Transform Euclidean disatance
d_Euclidean = Y-meanX;   % d_Euclidean = x-mu
d_mahal = d_Euclidean*W; % d_mahal = (x-mu)W
d2_mahal_cal = sum(d_mahal.^2, 2); % d2_mahal_cal = [(x-mu)W][W^T(x-mu)^T]

% Transform sample
X_trans = X*W;
d2_mahal_trans = mahal(Y, X_trans);
meanX_trans = mean(X_trans);
d2_Euclidean_trans = sum((Y-meanX_trans).^2, 2);

% Plot samples in transformed space
nexttile
hold(gca, "on")
scatter(X_trans(:, 1), X_trans(:, 2), 5, 'filled')
scatter(Y(:,1), Y(:,2), 100, d2_mahal_trans, 'o', 'filled')
scatter(meanX_trans(1), meanX_trans(2), 100, 'ko', 'filled')
hb2 = colorbar;
ylabel(hb2, 'Euclidean Disatance in Transfored Space')
xlabel('x1')
ylabel('x2')
legend('X', 'Y', 'Sample mean', 'Location', 'best')
title('(b) Mahalanobis Distance in Transformed Space')
box on
grid on
```

![image-20220906151214957](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220906151214957.png?raw=true)

在上面的示例中，首先使用`mvnrnd`函数生成服从二维正态分布的样本`X`，之后使用`mahal`函数计算观测点`Y`到样本点的马氏距离，并进行比较：

```matlab
% Calculate the the inverse of the Sigma
Sigma_inv = inv(Sigma);

% Operate Cholesky factorization for the Sigma^{-1}
% Sigma_inv = W*W^T;
W = chol(Sigma_inv, "lower");

% Compute the Mahalanobis distance of each observation in Y to the reference samples in X.
d2_mahal = mahal(Y, X);

% Compute the squared Euclidean distance of each observation in Y from the mean of X .
meanX = mean(X);
d2_Euclidean = sum((Y-meanX).^2, 2);
```

```matlab
d2_Euclidean =
    2.0931
    2.0399
    1.9625
    1.9094
    
d2_mahal =
    1.1095
   20.3632
   19.5939
    1.0137
```

从数值结果和图(a)都可以看出，虽然观测点`Y = [1 1;1 -1;-1 1;-1 -1];`到样本中心的欧式距离`d2_Euclidean`很接近（因为计算的时候使用的是样本均值，所以欧式距离仍有所差异，随着样本点的数量的增加，**样本均值会逐渐接近经验均值**，即`mu = [0; 0]`，这个差异会越来越小），但是它们的马氏距离差异很大，因此马氏距离能够更好地表征点到一个分布的距离。

‍♂️‍♂️‍♂️

上文提到马氏距离的一个等价定义式$\eqref{eq2}$，即马氏距离是欧式距离的一个线性变换，线性变换矩阵为$W$，并且有$S^{-1}=W^TW$，于是我们可以利用Cholesky分解将$S^{-1}$分解为$W^TW$的形式，并且与使用`mahal`函数计算出的马氏距离的平方`d2_mahal`作比较以验证公式$\eqref{eq2}$的正确性：

```matlab
% Transform Euclidean disatance
d_Euclidean = Y-meanX;   % d_Euclidean = x-mu
d_mahal = d_Euclidean*W; % d_mahal = (x-mu)W
d2_mahal_cal = sum(d_mahal.^2, 2); % d2_mahal_cal = [(x-mu)W][W^T(x-mu)^T]
```

```matlab
d2_mahal_cal =
    1.1034
   20.3894
   19.6155
    1.0067

d2_mahal =
    1.1095
   20.3632
   19.5939
    1.0137
```

‍♂️‍♂️‍♂️

上面所述的方式是将样本点保持在欧式空间，对欧式空间中的欧式距离做线性变换$W$得到马氏距离，而上文还提到如果对整个空间进行线性变换（还是相同的线性变换矩阵$W$），即对样本点`X`进行线性变换，则样本点表现出各向同性，图(b)就体现出这一点；另一方面，图(b)还体现出在变换空间内，样本点`Y`的马氏距离非常接近，而且就等于变换空间内的欧式距离：

```matlab
% Transform sample
X_trans = X*W;
d2_mahal_trans = mahal(Y, X_trans);
meanX_trans = mean(X_trans);
d2_Euclidean_trans = sum((Y-meanX_trans).^2, 2);
```

```matlab
d2_mahal_trans =
    2.1159
    2.0876
    1.9516
    1.8748

d2_Euclidean_trans =
    2.1239
    2.0707
    1.9341
    1.8810
```

‍♂️‍♂️‍♂️

另外，上文还提到，$S^{-1}=W^TW$的分解（可能）是不唯一的，上述使用的分解方式是使用Cholesky分解得到下三角阵和上三角阵的乘积。我并不清楚是否还存在其他分解方式。如果分解不唯一，那么样本点`X`经历其他线性变换后，是否会保持各向同性？还有，分解不唯一是一定的吗？还是在一定条件下，分解就唯一了呢？

<br>

# Regard Multivariate Normal Distribution PDF from perspective of Mahalanobis Distance

多元正态分布函数$\eqref{eq1}$中指数函数的指数部分实际上是包含着一个随机向量到均值的马氏距离。所以从另一个角度看，多元正态的PDF像是从马氏距离出发，构造出的一个满足PDF定义的函数。将马氏距离带入到多元正态分布函数$\eqref{eq1}$中进行计算，就可以得到点$x$属于给定分布的概率。

如果是从欧式距离出发，构造出的函数就是多元正态分布函数随机向量不相关（即独立）的情形：

```matlab
clc, clear, close all

% Define the parameters mu and Sigma
mu_1 = [0 0];
Sigma_1 = [0.25 0.3; 0.3 1];

mu_2 = [0, 0];
Sigma_2 = [1, 0; 0, 1];

% Create a grid of evenly spaced points in two-dimensional space
x1 = -3:0.1:3;
x2 = -3:0.1:3;
[X1, X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

% Evaluate the PDF of the normal distribution at the grid points
y_1 = mvnpdf(X, mu_1, Sigma_1);
y_1 = reshape(y_1, length(x2), length(x1));

y_2 = mvnpdf(X, mu_2, Sigma_2);
y_2 = reshape(y_2, length(x2), length(x1));

t = tiledlayout(1, 2);
colormap("jet")
% Tile1, contour
nexttile
contour(x1, x2, y_1)
colorbar
axis equal
xlabel('x1')
ylabel('x2')
title('$\mu$ = [0, 0], $\Sigma$ = [0.25 0.3; 0.3 1]', Interpreter='latex')


% Tile1, contour
nexttile
contour(x1, x2, y_2)
colorbar
axis equal
xlabel('x1')
ylabel('x2')
title('$\mu$ = [0, 0], $\Sigma$ = [1, 0; 0, 1]', Interpreter='latex')
```

![image-20220907131256149](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220907131256149.png?raw=true)

<br>

**参考**

[1] [Multivariate Normal Distribution - MathWorks](https://ww2.mathworks.cn/help/stats/multivariate-normal-distribution.html).

[2] [Mahalanobis distance - Wikipedia](https://en.wikipedia.org/wiki/Mahalanobis_distance).

[3] [mahal - MathWorks](https://ww2.mathworks.cn/help/stats/mahal.html).

[4] [Covariance matrix - Wikipedia](https://en.wikipedia.org/wiki/Covariance_matrix).
