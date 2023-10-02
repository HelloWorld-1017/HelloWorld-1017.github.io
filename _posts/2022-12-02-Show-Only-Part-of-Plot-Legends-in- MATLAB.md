---
layout: single
title: Show Only Part of Plot Legends in MATLAB
date: 2022-12-02 12:50:47 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Graphics
toc: false
---

在使用MATLAB进行绘图时，很多时候我们都不需要展示所有绘图的图例，只需要展示部分数据的图例即可。

在网上找了一些实现方法，方法很多很杂，其中我认为比较适用、比较自然的方式是设置绘图的`"handlevisibility"`属性。例如，在下面的例子中，我们不显示中间曲线(即绿色曲线的legend)：

```matlab
clc, clear, close all

rng("default")

x = 1:20;
y1 = randn(1, 20);
y2 = randn(1, 20);
y3 = randn(1, 20);

figure
nexttile
hold(gca, "on")
box(gca, "on")
LineWidth = 1.5;
plot(x, y1, "LineWidth", LineWidth, "Color", 'r')
plot(x, y2, "LineWidth", LineWidth, "Color", 'g', "handlevisibility", 'off')
plot(x, y3, "LineWidth", LineWidth, "Color", 'b')
legend("y1", "y3")
```

![image-20221202125241693](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221202125241693.png?raw=true)

<br>

