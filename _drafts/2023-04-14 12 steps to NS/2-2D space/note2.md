在博客XX中，

我们讨论了一维空间中的。。。，。。。，。。。

在接下来的内容中，将介绍Barba教授课程中拓展到二维的内容。

# Finite-difference Formulas in 2D Space

在二维空间中，矩形网格（rectangular grid，A.K.A. uniform grid）由**坐标系**（coordinate）中的点所定义（区别于一维情况下由**数轴**上的点定义）：
$$
\begin{split}
x_i&=x_0+i\Delta x\\
y_i&=y_0+i\Delta y
\end{split}
$$
我们定义：
$$
u_{i,j}=u(x_i,y_j)
$$
并将有限差分公式（finite-difference formulas）应用于变量$x$和变量$y$，分别作用于索引$i$和$j$。所有的导数都基于$u_{i,j}$附近的mesh point value的**二维**泰勒展开。

因此，对于在$x$和$y$方向上的一阶偏导数，有限差分公式分别为：
$$
\begin{split}
&\dfrac{\partial u}{\partial x}\Big\vert_{i,j}=\dfrac{u_{i+1,j}-u_{i,j}}{\Delta x}+O(\Delta x)\\
&\dfrac{\partial u}{\partial y}\Big\vert_{i,j}=\dfrac{u_{i,j+1}-u_{i,j}}{\Delta y}+O(\Delta y)\\
\end{split}\label{eq1}
$$

# 2-D Linear Convection

控制二维线性对流的PDE方程可以写作：
$$
\dfrac{\partial u}{\partial t}+c\dfrac{\partial u}{\partial x}+c\dfrac{\partial u}{\partial y}=0\label{2DLinConvection}
$$
根据有限差分公式$\eqref{eq1}$，分别对时间和空间使用前向差分和后向差分可以将式$\eqref{2DLinConvection}$离散化为：
$$
\dfrac{u^{n+1}_{i,j}-u^n_{i,j}}{\Delta t}+c\dfrac{u^n_{i,j}-u^n_{i-1,j}}{\Delta x}+c\dfrac{u^n_{i,j}-u^n_{i,j-1}}{\Delta y}=0\\ \notag
$$
进而可以得到$u^{n+1}_{i,j}$的计算公式：
$$
u^{n+1}_{i,j}=u^{n}_{i,j}-c\dfrac{\Delta t}{\Delta x}(u^n_{i,j}-u^n_{i-1,j})-c\dfrac{\Delta t}{\Delta y}(u^n_{i,j}-u^n_{i,j-1})
$$
初始条件设置为：
$$
u(x,y)=
\left\{
\begin{split}
2\quad &\mathrm{if}\ x,y\in(0.5,1)\times(0.5,1)\\
1\quad &\mathrm{everywhere\ else}
\end{split}
\right.
$$
边界条件为：
$$
u=1\ \mathrm{for}
\left\{
\begin{split}
&x=0,2\\
&y=0,2\\
\end{split}
\right.
$$

```matlab
clc,clear,close all

nx = 81;
ny = 81;
nt = 100;
c = 1;
dx = 2/(nx-1);
dy = 2/(ny-1);
sigma = 0.2;
dt = sigma*dx;

x = linspace(0,2,nx);
y = linspace(0,2,ny);

u = ones(ny,nx);
un = ones(ny,nx);

u(floor(.5/dy):floor(1/dy+1),floor(.5/dx):floor(1/dx+1)) = 2;

figure('Units','pixels','Position',[661,412.33,1240,419.99])
tiledlayout(1,2)
nexttile
box(gca,"on")
grid(gca,"on")
[X,Y] = meshgrid(x,y);
surf(X,Y,u,'EdgeColor','none')
colormap("jet")
colorbar
title("Initial interations")

for i = 2:nt
    un = u;
    u(2:end,2:end) = un(2:end,2:end)...
        -(c*dt/dx)*(un(2:end,2:end)-un(2:end,1:end-1))...
        -(c*dt/dy)*(un(2:end,2:end)-un(1:end-1,2:end));
    u(1,:) = 1;
    u(end,:) = 1;
    u(:,1) = 1;
    u(:,end) = 1;
end

nexttile
box(gca,"on")
grid(gca,"on")
surf(X,Y,u,'EdgeColor','none')
colormap("jet")
colorbar
title("After simulation")
```

![image-20230416142037270](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230416142037270.png)

<br>

# 2-D Nonlinear Convection

二维空间中的非线性对流方程可以表示为：
$$
\begin{split}
\dfrac{\partial u}{\partial t}+u\dfrac{\partial u}{\partial x}+v\dfrac{\partial u}{\partial y}=0\\
\dfrac{\partial v}{\partial t}+u\dfrac{\partial v}{\partial x}+v\dfrac{\partial v}{\partial y}=0\\
\end{split}
$$
离散时间和空间变量后：
$$
\begin{split}
\dfrac{u^{n+1}_{i,j}-u^{n}_{i,j}}{\Delta t}+u^{n}_{i,j}\dfrac{u^{n}_{i,j}-u^{n}_{i-1,j}}{\Delta x}+v^{n}_{i,j}\dfrac{u^{n}_{i,j}-u^{n}_{i,j-1}}{\Delta y}=0\\
\dfrac{v^{n+1}_{i,j}-v^{n}_{i,j}}{\Delta t}+u^{n}_{i,j}\dfrac{v^{n}_{i,j}-v^{n}_{i-1,j}}{\Delta x}+v^{n}_{i,j}\dfrac{v^{n}_{i,j}-v^{n}_{i,j-1}}{\Delta y}=0\\
\end{split}
$$
于是可以得到：
$$
\begin{split}
&u^{n+1}_{i,j}=u^{n}_{i,j}-u^{n}_{i,j}\dfrac{\Delta t}{\Delta x}(u^{n}_{i,j}-u^{n}_{i-1,j})-v^{n}_{i,j}\dfrac{\Delta t}{\Delta y}(u^{n}_{i,j}-u^{n}_{i,j-1})\\
&v^{n+1}_{i,j}=v^{n}_{i,j}-u^{n}_{i,j}\dfrac{\Delta t}{\Delta x}(v^{n}_{i,j}-v^{n}_{i-1,j})-v^{n}_{i,j}\dfrac{\Delta t}{\Delta y}(v^{n}_{i,j}-v^{n}_{i,j-1})\\
\end{split}
$$
初始条件为：
$$
u,v=
\left\{
\begin{split}
2\quad &\mathrm{if}\ x,y\in(0.5,1)\times(0.5,1)\\
1\quad &\mathrm{everywhere\ else}
\end{split}
\right.
$$
边界条件为：
$$
u=1,v=1\ \mathrm{for}
\left\{
\begin{split}
&x=0,2\\
&y=0,2\\
\end{split}
\right.
$$












<br>

**References**

[1] Barba, Lorena A., and Forsyth, Gilbert F. (2018). CFD Python: the 12 steps to Navier-Stokes equations. *Journal of Open Source Education*, **1**(9), 21, https://doi.org/10.21105/jose.00021.

[2] [CFDPython/07_Step_5.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/07_Step_5.ipynb).

[3] [CFDPython/08_Step_6.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/08_Step_6.ipynb)

[4] [CFDPython/09_Step_7.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/09_Step_7.ipynb).

[5] [CFDPython/10_Step_8.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/10_Step_8.ipynb).

[6] [CFDPython/12_Step_9.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/12_Step_9.ipynb).

[7] [CFDPython/13_Step_10.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/13_Step_10.ipynb).（2D Poisson Equation）

[8] [CFDPython/14_Step_11.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/14_Step_11.ipynb). （Cavity Flow with Navier–Stokes）

[9] [CFDPython/15_Step_12.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/15_Step_12.ipynb). （Channel Flow with Navier–Stokes）













