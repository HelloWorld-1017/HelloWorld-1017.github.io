---
layout: single
title: Median vs. Mathematic Expectation
date: 2022-10-01 20:18:19 +0800
categories: 
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
toc: false
---

刻画一个随机变量$X$平均取值的数字特征，除了数学期望以外，最重要的是中位数。

中位数(median)：设随机变量$X$的分布函数为$F(x)$，则满足条件

$$
P(X\le m)=F(m)=\dfrac12\notag
$$

的数$m$称为$X$或分布$F$的中位数。

由于连续型随机变量取一个值的概率为$0$，即$P(X=m)=0$，因此有：

$$
P(X\le m)=P(X<m)=P(X>m)=P(X\ge m)=\dfrac12\notag
$$

也就是说，$m$这个点把$X$的分布从概率上一切两半：在$m$左边（包括点$m$与否无所谓）占一半，在$m$右边也占一半。从概率上说，$m$这个点正好居于中央，这就是“中位数”得名的由来。

在实际应用中，中位数用得很多，特别有不少社会统计资料，常拿中位数来刻画某种量的代表性数值，**有时它比数学期望更能说明问题**。和数学期望相比，中位数主要有以下两个优点：

1. 中位数受个别特大值和特小值的影响，而数学期望则不然；
2. 中位值总存在，而数学期望并不是对任何随机变量都存在；

‍♂️‍♂️‍♂️正是因为第一个优点，MATLAB中的离群值判断函数`isoutlier`、离群值移除函数`rmoutliers`、离群值替换函数`filloutliers`在默认情况下都采用median和movmedian（Hampel filter）方法来判断是否是离群值。

<br>

虽然中位数有以上这些优点，但是在概率统计中，无论是在理论上还是在应用上，数学期望的重要性还是远超数学期望的，其原因也有两个方面：

1. 数学期望具有很多优良的性质，比如“若干个随机变量之和的期望等于各变量的期望之和”、若干个独立随机变量之积的期望等于各变量的期望之积”、以及“随机变量函数的期望”等等。这些性质使得在数学上处理期望很方便，而中位数则不存在这样的性质；

2. 中位数本身所固有的一些缺点。比如，中位数可以不唯一。并且在$X$为离散型的情况下，虽然可以定义中位数，但是效果不是很理想，并不完全符合“中位”这个名词所应有的含义。比如对于概率分布


$$
P(X=1)=2/7,\ P(X=2)=4/7,\ P(X=3)=1/7\notag
$$

这时候就不存在一个点$m$，使$m$两边的概率恰好一样，只能退而求其次，找一个点$m$，使其左右两边的概率差距最小，在本例中就是2，但是很明显这不是理想的“中位数”。

<br>

**参考**

[1] 概率论与数理统计. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.2(2019.8重印).