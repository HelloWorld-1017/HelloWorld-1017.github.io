---
layout: single
title: Calculate Statistics in LabVIEW
date: 2022-12-28 18:55:52 +0800
categories: 
 - LabVIEW
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
---

# Introduction

本博客学习的实例来自NI官方范例：`分析，信号处理和数学\概率与统计\求各种统计量`，VI名称为`Statistics Solver.vi`。

该示例的前面板预览：

![image-20221228120020298](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228120020298.png?raw=true)

程序框图预览：

![image-20221228115945173](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228115945173.png?raw=true)

<br>

# Build Process

## `while` Loop

首先可以从程序框图中看到，整个程序是一个while循环，停止条件是点击停止按钮停止：

![image-20221228121235050](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228121235050.png?raw=true)

在前面板中创建两个双精度(DBL)的输入控件，并且简单设置一下它们的默认输入值：

![image-20221228122616560](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228122616560.png?raw=true)

注：这里方差的英文是variance，这里和接下来的几张图中写错了，后面的图像做出了纠正。
{: .notice--warning}

这两个输入控件相当于定义了$\sigma^2_X$和了$\sigma^2_Y$。之后，分别使用`创建数组` ，`平方根`和`创建特殊矩阵`函数得到对角矩阵

$$
\begin{bmatrix}
\sigma_X&0\\
0&\sigma_Y\\
\end{bmatrix}
$$

![image-20221228132821785](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228132821785.png?raw=true)

需要注意的是，在这里，`创建特殊矩阵`函数的`matrix type`输入是一个常量，并不在前面板中显示。

可以简单地检查一下结果：

![image-20221228133219919](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228133219919.png?raw=true)

在前面板中插入一个经典的水平滑动杆，用于表示变量X和Y的相关度$\rho_{XY}$，取值范围为$[-1,1]$：

![image-20221228134212483](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228134212483.png?raw=true)

之后，使用了三个`创建矩阵`函数获得矩阵：

$$
\begin{bmatrix}	
1&\rho_{XY}\\
\rho_{XY}&1\\
\end{bmatrix}
$$

![image-20221228135910373](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228135910373.png?raw=true)

需要注意的是，第三个`创建矩阵`函数需要右键将其设置为“按行添加”的模式。

之后，就是将两部分矩阵进行计算，得到协方差矩阵(covariance matrix)$\Sigma$：

$$
\Sigma=\begin{bmatrix}
\sigma_X&0\\
0&\sigma_Y\\
\end{bmatrix}\begin{bmatrix}	
1&\rho_{XY}\\
\rho_{XY}&1\\
\end{bmatrix}\begin{bmatrix}
\sigma_X&0\\
0&\sigma_Y\\
\end{bmatrix}^T=\begin{bmatrix}
\sigma_X^2&\sigma_X\sigma_Y\rho_{XY}\\
\sigma_X\sigma_Y\rho_{XY}&\sigma_Y^2\\
\end{bmatrix}
$$

![image-20221228141416337](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228141416337.png?raw=true)

根据相关系数的定义：

> 定义$\mathrm{Cov}(X,Y)/(\sigma_X\sigma_Y)$为$X$，$Y$的相关系数，并记作$\mathrm{Corr}(X,Y)$，也记作$\rho_{XY}$。

可以将上式化为：

$$
\Sigma=\begin{bmatrix}
\mathrm{Cov}(X,X)&\mathrm{Cov}(X,Y)\\
\mathrm{Cov}(Y,X)&\mathrm{Cov}(Y,Y)\\
\end{bmatrix}
$$

而这正是协方差矩阵的定义。

之后，对协方差矩阵$\Sigma$进行一系列的操作，其最终目的是将$\Sigma$分解为$AA^T$的形式：

![image-20221228155245592](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228155245592.png?raw=true)

创建三个输入控件，分别是X的平均值、Y的平均值以及种子(seed)：

![image-20221228152716928](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228152716928.png?raw=true)

之后，根据二维高斯白噪声$N(0,I)$生成随机数，并利用隧道将数据循环内部的数据传出，我们可以观察一下输出的数据：

![image-20221228160958157](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228160958157.png?raw=true)

> 注：上述生成服从多维正态分布随机数的过程可以参见博客：[The processing methods for ill-conditioned SCM in MATLAB fitgimdist, mahal and mvnrnd functions in case of extremely small sample - What a starry night~](http://whatastarrynight.com/matlab/mathematics/The-processing-method-for-ill-conditioned-SCM-in-MATLAB-fitgmdist-mahal-and-mvnrnd-functions-in-case-of-extremely-small-sample/).

这些输出的值，就可以用于计算统计量和绘制统计图像。

## Sample mean and sample variance

利用`标准差和方差`函数，分别计算X和Y的均值和方差：

![image-20221228162521348](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228162521348.png?raw=true)

## Correlation coefficient and MSE

Spearman相关系数、$R^2$相关系数、Kendall相关系数、均方差的这些值的计算都依赖于X值和Y值：

![image-20221228163102904](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228163102904.png?raw=true)

注：图像有误，右边应当有连线。
{: .notice--warning}

## Sample covariance

计算X和Y的样本协方差：

![image-20221228163424100](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228163424100.png?raw=true)

注：X和Y的样本协方差表示样本协方差矩阵右上角的那个元素。
{: .notice--warning}

## Scatter plot

散点图是这里面比较难绘制的图像，因为需要画出一条用于示意的边界线。

`斜坡信号`函数（[Ramp Pattern VI - NI](https://www.ni.com/docs/en-US/bundle/labview/page/lvanls/ramp_pattern.html)），设置该函数的采样点为20，斜坡的末端值为$2\pi$。为了看出这部分的效果，我们将整个结果更改为条件for结构，执行两次观察一下结果：

![image-20221228144345720](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228144345720.png?raw=true)

之后，将采样点输入到`正弦与余弦`函数中，并将赋值扩大3倍，观察一下结果：

![image-20221228145217547](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228145217547.png?raw=true)

将结果与协方差矩阵分解后的矩阵相乘，并与X与Y的平均值相加。将X与Y的值捆绑在一起，之后绘制出边界线。

![image-20221228164832522](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228164832522.png?raw=true)

之后，将上面的X与Y的散点绘制在同一张图中：

![image-20221228165302321](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228165302321.png?raw=true)

## X and Y plot with respect to t

X和Y的趋势图就是X和Y随t（sample number）变化的曲线：

![image-20221228170313409](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228170313409.png?raw=true)

这里需要注意的是，两个趋势图的横纵坐标的捆绑顺序。对于X的趋势图而言，是先t后X；对于Y的趋势图，是先Y后t。

## Histograms

直方图的绘制：

![image-20221228172154853](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221228172154853.png?raw=true)

<br>



