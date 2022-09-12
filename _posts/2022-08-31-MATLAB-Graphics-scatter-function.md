---
layout: single
title: 【MATLAB Graphics】`scatter` function
date: 2022-08-31 11:09:01 +0800
categories: 
 - Programming
tags:
 - MATLAB
 - MATLAB Graphics
---

# 基本语法

`scatter`绘图函数示例：

```matlab
clc, clear, close

% Points
data = randn(1,20);

% Plot
figure, axes
hold(gca, "on")
scatter(1:numel(data), data, 200, 'rx', LineWidth=2)
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220831101149145.png" alt="image-20220831101149145" style="zoom:67%;" />

其中：

（1）`1:numel(data)`和`data`分别表示数据点的x-coordinates和y-coordinates；

（2）`200`表示marker的大小，**必须直接**跟在数据点之后；

（3）`'rx'`：其中`r`表示marker的颜色，`x`表示marker的形状；

（4）`LineWidth=2`表示marker的粗细；

<br>

# `'filled'`参数

当使用类似`x`这样只有只有face没有edges的marker，使用`filled`参数将会什么也绘制。

```matlab
clc, clear, close

% Points
data = randn(1,20);

% Plot
figure, axes
hold(gca, "on")
scatter(1:numel(data), data, 200, 'filled', 'rx', LineWidth=2)
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220831120750565.png" alt="image-20220831120750565" style="zoom:50%;" />

There's noting，而且也不报错。类似marker还有：`'+'`, `'*'`, `'.'`。

<br>

**参考**

[1] [Scatter plot - MATLAB scatter - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/scatter.html)