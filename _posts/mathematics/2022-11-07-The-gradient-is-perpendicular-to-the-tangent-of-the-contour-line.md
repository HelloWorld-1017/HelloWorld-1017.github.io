---
layout: single
title: The Gradient is Perpendicular to the Tangent of the Contour Line
date: 2022-11-07 11:12:11 +0800
categories: 
 - Mathematics
 - MATLAB
tags:
 - Mathematical Analysis
 - MATLAB Graphics
toc: false
---

假设有一个二元函数$F(x,y)$，从几何上看，它表示一个曲面，该平面被平面$c$($c$为常数)所截的曲线$l$的方程为：

$$
\left\{\begin{split}
&z=f(x,y)\\
&z=c\\
\end{split}\right.\notag
$$

这条曲线$l$在$xy$平面上的投影是一条平面曲线$Q$，它所对应的方程为：

$$
f(x,y)=c\notag
$$

我们称平面曲线$Q$为函数$z=f(x,y)$的等高线。

等高线$Q$上任意一点$(x,y)$的切线斜率可以使用$\dfrac{\mathrm{d}y}{\mathrm{d}x}$进行表示：

$$
\dfrac{\mathrm{d}y}{\mathrm{d}x}=-\dfrac{F_x}{F_y}\notag
$$

> 这里用到了隐函数的求导公式$^{[2]}$。
>
> 如果$R(x,y)=0$，则隐函数$y(x)$的导数可以通过下面的公式进行计算：
> 
> $$
> \dfrac{\mathrm{d}y}{\mathrm{d}x}=-\dfrac{\partial R/\partial x}{\partial R/\partial y}=-\dfrac{R_x}{R_y}\label{eq1}
> $$
> 
> 其中，$R_x$和$R_y$分别表示$R$关于$x$和$y$的偏微分。
>
> 这个公式是通过链法则推导出隐函数$R(x,y)=0$关于变量$x$的全微分(total derivative)：
> 
> $$
> \dfrac{\partial R}{\partial x}\dfrac{\mathrm{d}x}{\mathrm{d}x}+\dfrac{\partial R}{\partial y}\dfrac{\mathrm{d}y}{\mathrm{d}x}=0\notag
> $$
> 
> 因此有：
> 
> $$
> \dfrac{\partial R}{\partial x}+\dfrac{\partial R}{\partial y}\dfrac{\mathrm{d}y}{\mathrm{d}x}=0\notag
> $$
> 
> 假设$\dfrac{\partial R}{\partial y}\ne0$，化简后得到式$\eqref{eq1}$。

于是，等高线上点$(x,y)$处的法线斜率为：

$$
-\dfrac{1}{\dfrac{\mathrm{d}y}{\mathrm{d}x}}=\dfrac{F_y}{F_x}\label{eq2}
$$

又因为二元函数$F(x,y)$的梯度为：

$$
\nabla F=\dfrac{\partial F}{\partial x}\mathrm{i}+\dfrac{\partial F}{\partial y}\mathrm{j}\notag
$$

梯度的方向为：

$$
\dfrac{\partial F}{\partial y}/\dfrac{\partial F}{\partial x}=F_y/F_x\label{eq3}
$$

根据式$\eqref{eq2}$和$\eqref{eq3}$，可以看到在二维平面等高线$f(x,y)=c$上的任意一点$(x,y)$的法线与此处函数$F(x,y)$的梯度在同一条直线上，也即：梯度的方向与等高线切线垂直。

我们可以在MATLAB进行简单的验证：

```matlab
clc, clear, close all

x = -5:0.2:5;
y = x;

[X, Y] = meshgrid(x, y);
Z = X.^2+Y.^2;
[px, py] = gradient(Z);

figure("Units", "pixels", "Position", [544,390,959,347])
tiledlayout(1, 2)

nexttile
view(3)
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
colormap("jet")
surfc(X, Y, Z)

nexttile
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
colormap("jet")
axis equal
contour(X,Y,Z, LineWidth=1.5)
interval = 3;
quiver(x(1:interval:end), y(1:interval:end), ...
    px(1:interval:end, 1:interval:end), ...
    py(1:interval:end, 1:interval:end), 'k', "filled")
```

![image-20221107103323888](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221107103323888.png?raw=true)

```matlab
clc, clear, close all


[X, Y, Z] = peaks(100);
x = X(1, :);
y = Y(:, 1);
[px, py] = gradient(Z);

figure("Units", "pixels", "Position", [544,390,959,347])
tiledlayout(1, 2)

nexttile
view(3)
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
colormap("jet")
surfc(X, Y, Z)

nexttile
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
colormap("jet")
axis equal
contour(X,Y,Z, LineWidth=1.5)
interval = 3;
quiver(x(1:interval:end), y(1:interval:end), ...
    px(1:interval:end, 1:interval:end), ...
    py(1:interval:end, 1:interval:end), 'k', "filled")
```

![image-20221107103451317](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221107103451317.png?raw=true)

从上面的例子我们还可以很清楚地看出一点：等高线的切线或者法线的斜率是没有方向的，而梯度是有方向的。因此说“**梯度的方向与等高线切线垂直**”是合理的，但是说“**梯度的方向与等高线法线方向相同**”是欠妥的，准确地讲，梯度和法线是在同一条直线上的。

<br>

**Reference**

[1] [为什么梯度的方向与等高线切线方向垂直？- 知乎](https://zhuanlan.zhihu.com/p/27731819)

[2] [Implicit function - Wikipedia](https://en.wikipedia.org/wiki/Implicit_function).

