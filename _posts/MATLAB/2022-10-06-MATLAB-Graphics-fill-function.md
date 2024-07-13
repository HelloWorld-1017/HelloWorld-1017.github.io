---
layout: single
title: MATLAB `fill` function, Fill the Interval Area Between Two curves
date: 2022-10-06 17:22:29 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Graphics
toc: false
---

MATLAB的`fill`函数可以用于填充两个曲线之间的interval，比如填充$y=x-1$和$y=x+1$之间的interval：

这种方法在绘制置信区间的时候很常用。
{: .notice--primary}

```matlab
clc, clear, close all

xdata = linspace(0, 10, 10);
ydata1 = xdata + 1;
ydata2 = xdata - 1;

figure, axes
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
plot(xdata, ydata1, LineWidth=1.5)
plot(xdata, ydata2, LineWidth=1.5)
fill([xdata, fliplr(xdata)], [ydata1, fliplr(ydata2)], ...
    'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none')
legend("y=x+1", "y=x-1", "Location", "best")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221006172812753.png?raw=true" alt="image-20221006172812753" style="zoom: 67%;" />

需要注意的是，其中的变量`xdata`，`ydata1`和`ydata2`都是行向量，因此在绘图函数中使用了`fliplr`函数。如果是列向量，那么则需要使用`flipud`函数，并且中间需要使用分号`;`间隔，在实际使用的时候一定要注意这一点！

```matlab
...
xdata = linspace(0, 10, 10)';
ydata1 = xdata + 1;
ydata2 = xdata - 1;
...
fill([xdata; flipud(xdata)], [ydata1; flipud(ydata2)], ...
    'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221006173312755.png?raw=true" alt="image-20221006173312755" style="zoom:67%;" />

两种方式的绘制效果是完全一致的。

<br>

**Reference**

[1] [fill - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/fill.html).