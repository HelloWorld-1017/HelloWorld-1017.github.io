---
title: Solve Underdetermined System
categories: 
 - Mathematics
tags:
 - Matrix
 - Numerical Analysis
 - Optimization
date: 2022-10-06 12:57:41 +0800
last_modified_at: 2025-02-02 08:59:42 +0800
---

# The least norm solution of underdetermined system

假设$A$是一个$n\times m$的矩阵，若（1）$n<m$（即$Ax=b$为<i class="term">欠定方程组</i>，Underdetermined system），并且（2） $\mathrm{rank}(A)=n$（保证了有无穷多解，而不会出现无解的情况），则方程组$Ax=b$有无穷多解，其中的<i class="term">最小范数解(the least norm solution)</i>为[^1]：

$$
x_{min}=A^T(AA^T)^{-1}b\label{eq1}
$$

即在满足方程$Ax=b$的所有解中，解$x_{min}$具有最小的范数$\vert\vert x\vert\vert^2$。

证明：

求解最小范数解$x_{min}$的问题可以归结为一个<i class="emphasize">具有等式约束的优化问题</i>：

$$
\begin{split}
\min&\  \vert\vert x\vert\vert^2\\
\mathrm{subject\ to.}&\ Ax-b=0
\end{split}\notag
$$

使用拉格朗日乘子法(Lagrange multipliers)解决上述优化问题：

$$
\begin{split}
&F(x,\lambda)=x^Tx+\lambda(Ax-b)\\
&\left\{\begin{split}
&\dfrac{\partial F}{\partial x}=2x+A^T\lambda^T=0\\
&\dfrac{\partial F}{\partial \lambda}=Ax-b=0
\end{split}\right.
\end{split}\notag
$$

求解上述方程组，可以得到：

$$
\begin{split}
\lambda^T&=-2(AA^T)^{-1}b\\
x&=A^T(AA^T)^{-1}b
\end{split}\notag
$$

Q.E.D.

<br>

# Fit a quadratic curve using two given points

## From the perspective of curve fitting

给定平面上的两个点，$(1,1)$和$(2,-2)$，想要确定一条过这两点的二次曲线。假设二次曲线的方程为$y=ax^2+bx+c$，则将两个点代入方程可以得到：

$$
\left\{\begin{split}
a+b+c&=1\\
4a+2b+c&=-2\\
\end{split}\right.
$$

将方程组写作矩阵形式：

$$
\begin{bmatrix}
1&1&1\\
4&2&1
\end{bmatrix}
\begin{bmatrix}
a\\
b\\
c
\end{bmatrix}=
\begin{bmatrix}
1\\
-2
\end{bmatrix}\label{eq2}
$$

可以看到，所对应的方程组为欠定方程组，并且$\mathrm{Rank}(A)=2$，解的个数有无穷多个，即<i class="emphasize">有无数条二次曲线经过这两点</i>（或者说，这两点可以确定无数条二次曲线）。我们可以使用公式$\eqref{eq1}$求出其最小范数解：

```matlab
A = [1, 1, 1;
    4, 2, 1];
b = [1;-2];
x = A'*inv(A*A')*b;
```

```
x =
   -1.2143
    0.6429
    1.5714
```

并绘制出数据点和最小范数解对应的拟合曲线：

```matlab
xdata = linspace(0, 3, 100);
ydata = x(1)*xdata.^2+x(2)*xdata+x(3);

figure, axes
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
scatter([1, 2], [1, -2], 'filled', DisplayName='Data')
plot(xdata, ydata, LineWidth=1.5, DisplayName='Fitting curve')
title(['y=', num2str(x(1)), '$x^2$+', num2str(x(2)), '$x+$', num2str(x(3))], Interpreter='latex')
legend
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221005151641074.png?raw=true" alt="image-20221005151641074" style="zoom:67%;" />

## From the perspective of geometry

若从几何的角度看待式$\eqref{eq2}$，可以将其看作有无数个三维向量$x$可以经过线性变换$A$得到二维向量$b$，<i class="emphasize">最小范数解对应的三维向量$x_{min}$具有最小的模长$\vert\vert x\vert\vert^2$</i>。

<br>

# Another fitting method

上述的拟合是从优化的角度出发的，在数值分析领域，我们认为如果要用两个点去拟合一个二次曲线，是缺少信息的，因此我们可以添加一个额外的信息，找到一条特殊的拟合曲线。例如，令曲线在其中一个端点处的导数值为零，比如$f'(1)=0$或者$f'(2)=0$，从而构成一个具有一个解的恰定方程组：

$$
\left\{\begin{split}
&f(1)=a+b+c=1\\
&f(2)=4a+2b+c=-2\\
&f'(1)=2a+b=0
\end{split}\right.\quad\mathrm{or}\quad
\left\{\begin{split}
&f(1)=a+b+c=1\\
&f(2)=4a+2b+c=-2\\
&f'(2)=4a+b=0
\end{split}\right.\notag
$$

之后，就可以使用Cramer’s rule进行求解：

```matlab
clc, clear, close all

A1 = [1, 1, 1;
    4, 2, 1;
    2, 1, 0];
b1 = [1;-2;0];
x1 = inv(A1)*b1;

A2 = [1, 1, 1;
    4, 2, 1;
    4, 1, 0];
b2 = [1;-2;0];
x2 = inv(A2)*b2;

xdata = linspace(0, 3, 100);
ydata1 = x1(1)*xdata.^2+x1(2)*xdata+x1(3);
ydata2 = x2(1)*xdata.^2+x2(2)*xdata+x2(3);

figure
tiledlayout(1, 2)

nexttile
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
scatter([1, 2], [1, -2], 'filled', DisplayName='Data')
plot(xdata, ydata1, LineWidth=1.5, DisplayName='Fitting curve')
title(['y=', num2str(x1(1)), '$x^2$+', num2str(x1(2)), '$x+$', num2str(x1(3))], Interpreter='latex')
legend

nexttile
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
scatter([1, 2], [1, -2], 'filled', DisplayName='Data')
plot(xdata, ydata2, LineWidth=1.5, DisplayName='Fitting curve')
title(['y=', num2str(x2(1)), '$x^2$+', num2str(x2(2)), '$x+$', num2str(x2(3))], Interpreter='latex')
legend
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221006125349323.png?raw=true" alt="image-20221006125349323" style="zoom:80%;" />

<br>

**Reference**

[^1]: [Matrix Cookbook](https://www.math.uwaterloo.ca/~hwolkowi/matrixcookbook.pdf), p. 29.