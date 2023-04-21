二维的拉普拉斯方程（Laplace’s equation in 2D）：
$$
\dfrac{\partial^2p}{\partial x^2}+\dfrac{\partial^2p}{\partial y^2}=0\label{eq1}
$$
使用中心差分公式可以得到：
$$
\dfrac{p_{i+1,j}^n-2p_{i,j}^n-p_{i-1,j}^n}{(\Delta x)^2}+\dfrac{p_{i,j+1}^n-2p_{i,j}^n-p_{i,j-1}^n}{(\Delta y)^2}=0\label{eq2}
$$
需要注意的是，Laplace方程不依赖于时间$t$，即没有$p^{n+1}$这个变量。拉普拉斯方程不是通过时间跟踪波，而是计算系统在所提供的边界条件下的平衡状态，实际上，Laplace方程是一个稳定状态热方程（steady-state heat equation）。

对于Laplace方程，我们需要迭代求解$p_{i,j}^n$，直到它满足了我们指定的条件。只有在迭代的次数趋近于无穷时，系统才能到达稳定状态（equilibrium），但我们当一次迭代和下一次迭代之间的变化很小时，我们就可以近似认为系统处于了稳定状态。

根据式$\eqref{eq2}$，我们可以求解出$p_{i,j}^n$：
$$
p_{i,j}^n=\dfrac{(\Delta y)^2(p_{i+1,j}^n+p_{i-1,j}^n)+(\Delta x)^2(p_{i,j+1}^n+p_{i,j-1}^n)}{2\Big((\Delta x)^2+(\Delta y)^2\Big)}
$$
在两个方向上使用二阶中心差分格式是拉普拉斯算子（五点差分运算符，five-point different operator）应用最广泛的方法。

我们的边界条件设置为：
$$
\begin{split}
&p=0\ \text{at } x=0\\
&p=y\ \text{at } x=2\\
&\dfrac{\partial p}{\partial y}=0\ \text{at } y=0,1
\end{split}
$$
在这样的初始条件下，Laplace方程具有解析解：
$$
p(x,y)=\dfrac{x}{4}-4\sum_{n=1,\text{odd}}^{\infty}\dfrac1{(n\pi)^2\sinh(2n\pi)}\sinh(n\pi x)\ \cos(n\pi x)
$$


```matlab
clc,clear,close all

nx = 31;
ny = 31;
c = 1;
dx = 2/(nx-1);
dy = 2/(ny-1);

p = zeros(nx,ny);
x = linspace(0,2,nx);
y = linspace(0,1,ny);

p(1,:) = 0;              % p = 0 at x = 0
p(end,:) = y;            % p = y at x = 2
p(:,1) = p(:,2);         % dp/dy = 0 at y = 0
p(:,end) = p(:,end-1);   % dp/dy = 0 at y = 1

figure('Units','pixels', ...
    'Position',[728.33,386.33,940.67,369.99])
tiledlayout(1,2)
nexttile
box(gca,"on")
grid(gca,"on")
[X,Y] = meshgrid(x,y);
surf(X,Y,p,'EdgeColor','none')
colormap("jet")
colorbar
title("Initial condition",'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$p_{i,j}$','Interpreter','latex')

l1norm_target = 1e-4;
l1norm = 1;

numIteration = 0;
while l1norm > l1norm_target
    pn = p;
    p(2:end-1,2:end-1) = (dy^2*(pn(3:end,2:end-1)+pn(1:end-2,2:end-1))...
        +dx^2*(pn(2:end-1,3:end)+pn(2:end-1,1:end-2)))...
        ./(2*dx^2+2*dy^2);
    p(1,:) = 0;              % p = 0 at x = 0
    p(end,:) = y;            % p = y at x = 2
    p(:,1) = p(:,2);         % dp/dy = 0 at y = 0
    p(:,end) = p(:,end-1);   % dp/dy = 0 at y = 1

    l1norm = sum(abs(p(:))-abs(pn(:)),'all')/sum(abs(pn(:)),'all');
    numIteration = numIteration+1;
end

nexttile
box(gca,"on")
grid(gca,"on")
surf(X,Y,p,'EdgeColor','none')
colormap("jet")
colorbar
title(sprintf("After %s-times iterations",num2str(numIteration)), ...
    'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$p_{i,j}$','Interpreter','latex')
```

![image-20230417231332138](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230417231332138.png)

注：初始条件的绘制是不太准确的，$p(x=\text{end})$处是有值的，但是不太清楚在这里的绘图中没有以颜色的形式表达出来。
{: .notice--primary}

<br>

# 2D Poisson Equation（lesson 13）

在二维Laplace方程的右端添加一个源项（source term），可以得到二维的泊松方程：
$$
\dfrac{\partial^2p}{\partial x^2}+\dfrac{\partial^2p}{\partial y^2}=b
$$
最终可以得到：
$$
p_{i,j}^n=\dfrac{(\Delta y)^2(p_{i+1,j}^n+p_{i-1,j}^n)+(\Delta x)^2(p_{i,j+1}^n+p_{i,j-1}^n)-b_{i,j}^n\Delta x^2\Delta y^2}{2\Big((\Delta x)^2+(\Delta y)^2\Big)}
$$
我们假设初始条件为：
$$
p=0\ \text{everywhere}
$$
边界条件为：
$$
p=0\ \text{at }x=0,2\ \text{and}\ y=0,1
$$
源项包含两个initial spikes：
$$
\begin{split}
&b_{i,j}=100\ \text{at}\ i=\frac14nx,j=\dfrac14ny\\
&b_{i,j}=-100\ \text{at}\ i=\frac34nx,j=\dfrac34ny\\
&b_{i,j}=0\ \text{everywhere\ else}
\end{split}
$$
迭代将在伪时间（pseudo-time）内进行，以放松初始尖峰。泊松方程下的松弛随着它们的进展而变得越来越慢。为什么？

```matlab
clc,clear,close all

nx = 50;
ny = 50;
nt = 100;
xmin = 0;
xmax = 2;
ymin = 0;
ymax = 1;

dx = (xmax-xmin)/(nx-1);
dy = (ymax-ymin)/(ny-1);

p = zeros(nx,ny);
pd = zeros(nx,ny);
b = zeros(nx,ny);
x = linspace(xmin,xmax,nx);
y = linspace(xmin,xmax,ny);

% Source term
b(floor(ny/4),floor(nx/4)) = 100;
b(floor(3*ny/4),floor(3*nx/4)) = -100;

figure('Units','pixels', ...
    'Position',[728.33,386.33,940.67,369.99])
tiledlayout(1,2)
nexttile
box(gca,"on")
grid(gca,"on")
[X,Y] = meshgrid(x,y);
surf(X,Y,p+b,'EdgeColor','none')
colormap("jet")
colorbar
title("The combination of initial condition and initial spikes",'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$p_{i,j}+b_{i,j}$','Interpreter','latex')

l1norm_target = 1e-4;
l1norm = 1;
numIteration = 0;
while l1norm > l1norm_target
    pd = p;
    p(2:end-1,2:end-1) = (dy^2*(pd(3:end,2:end-1)+pd(1:end-2,2:end-1))...
        +dx^2*(pd(2:end-1,3:end)+pd(2:end-1,1:end-2))...
        +b(2:end-1,2:end-1)*dx^2*dy^2)...
        ./(2*dx^2+2*dy^2);
    p(1,:) = 0;
    p(end,:) = 0;
    p(:,1) = 0;
    p(:,end) = 0;

    l1norm = sum(abs(p(:))-abs(pd(:)),'all')/sum(abs(pd(:)),'all');
    numIteration = numIteration+1;
end

nexttile
box(gca,"on")
grid(gca,"on")
surf(X,Y,p,'EdgeColor','none')
colormap("jet")
colorbar
title(sprintf("After %s-times iterations",num2str(numIteration)), ...
    'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('y','Interpreter','latex')
zlabel('$p_{i,j}$','Interpreter','latex')   
```

![image-20230420101711496](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230420101711496.png)

<br>





对于不可压缩流体，二维的NS方程为：
$$
\begin{split}
\nabla\cdot\vec{v}&=0\\
\dfrac{\partial\vec{v}}{\partial t}+(\vec{v}\cdot\nabla)\vec{v}&=-\dfrac1\rho\nabla p+\nu\nabla^2\vec{v}
\end{split}
$$
其中$\vec{v}$表示速度场。第一个方程表示恒定密度下的质量守恒；第二个方程是动量守恒的表达式（==如何等效？==）。但是出现的一个问题是：不可压缩流体的连续方程没有一个控制变量（dominant variable），因此没有一种显而易见的方式来耦合速度和压强。在可压缩流体中，质量连续性（mass continuity）能够提供密度$\rho$的演化方程，与$\rho$和$p$相关的状态方程相耦合。

对于不可压缩流体，连续方程$\nabla\cdot\vec{v}=0$提供了运动约束，该约束需要压强场演化以使得膨胀率（rate of expansion）$\Delta\cdot\vec{v}$在每一处消失。解决这一困难的方法是构建一个保证连续性得到满足的压强场；这样的关系可以通过**动量方程的散度（divergence of the momentum equation）**来获得。在这个过程中，就出现了压强的泊松方程（Poisson equation）。

<br>

# Cavity Flow with NS Equation（lesson 14）

微分方程系统：两个方程用于求解速度分量$u$和$u$，一个方程用于求解pressure：
$$
\begin{split}
&\dfrac{\partial u}{\partial t}+u\dfrac{\partial u}{\partial x}+v\dfrac{\partial u}{\partial y}=-\dfrac1\rho\dfrac{\partial p}{\partial x}+\nu(\dfrac{\partial^2u}{\partial x^2}+\dfrac{\partial^2u}{\partial y^2})\\
&\dfrac{\partial v}{\partial t}+u\dfrac{\partial v}{\partial x}+v\dfrac{\partial v}{\partial y}=-\dfrac1\rho\dfrac{\partial p}{\partial x}+\nu(\dfrac{\partial^2v}{\partial x^2}+\dfrac{\partial^2v}{\partial y^2})\\
&\dfrac{\partial^2p}{\partial x^2}+\dfrac{\partial^2p}{\partial y^2}=-\rho(\dfrac{\partial u}{\partial x}\dfrac{\partial u}{\partial x}+2\dfrac{\partial u}{\partial y}\dfrac{\partial v}{\partial x}+\dfrac{\partial v}{\partial y}\dfrac{\partial v}{\partial y})
\end{split}
$$

$u$-动量方程的离散化形式为：


$$
\begin{split}
&\dfrac{u_{i,j}^{n+1}-u_{i,j}^{n}}{\Delta t}+u_{i,j}^n\dfrac{u_{i,j}^n-u_{i-1,j}^n}{\Delta x}+v_{i,j}^n\dfrac{u_{i,j}^n-u_{i,j-1}^n}{\Delta y}\\
=&-\dfrac1\rho\Big(\dfrac{p_{\textcolor{red}{i+1},j}^n-p_{\textcolor{red}{i-1},j}^n}{\textcolor{red}{2\Delta x}}\Big)
+\nu\Big(\dfrac{u_{i+1,j}^n-2u_{i,j}^n+u_{i-1,j}^n}{(\Delta x)^2}+\dfrac{u_{i,j+1}^n-2u_{i,j}^n+u_{i,j-1}^n}{(\Delta y)^2}\Big)
\end{split}
$$
$v$-动量方程的离散化形式为：
$$
\begin{split}
&\dfrac{v_{i,j}^{n+1}-v_{i,j}^{n}}{\Delta t}+u_{i,j}^n\dfrac{v_{i,j}^n-v_{i-1,j}^n}{\Delta x}+v_{i,j}^n\dfrac{v_{i,j}^n-v_{i,j-1}^n}{\Delta y}\\
=&-\dfrac1\rho\Big(
\dfrac{p_{i,\textcolor{red}{j+1}}^n-p_{i,\textcolor{red}{j-1}}^n}{\textcolor{red}{2\Delta y}}
\Big)
+\nu\Big(\dfrac{v_{i+1,j}^n-2v_{i,j}^n+v_{i-1,j}^n}{(\Delta x)^2}+\dfrac{v_{i,j+1}^n-2v_{i,j}^n+v_{i,j-1}^n}{(\Delta y)^2}\Big)
\end{split}
$$
注：==红色部分==

以及离散化的pressure-Poisson方程：
$$
\begin{split}
&\dfrac{p_{i+1,j}^n-2p_{i,j}^n+p_{i-1,j}^n}{(\Delta x)^2}+\dfrac{p_{i,j+1}^n-2p_{i,j}^n+p_{i,j-1}^n}{(\Delta y)^2}\\
=&\rho\Big[\textcolor{red}{\dfrac1{\Delta t}\Big(\dfrac{u_{i+1,j}-u_{i-1,j}}{2\Delta x}+\dfrac{v_{i,j+1}-v_{i,j-1}}{2\Delta y}\Big)}-\dfrac{u_{i+1,j}-u_{i-1,j}}{2\Delta x}\dfrac{u_{i+1,j}-u_{i-1,j}}{2\Delta x}\\
-&2\dfrac{u_{i,j+1}-u_{i,j-1}}{2\Delta y}\dfrac{v_{i+1,j}-v_{i-1,j}}{2\Delta x}
-\dfrac{v_{i,j+1}-v_{i,j-1}}{2\Delta y}\dfrac{v_{i,j+1}-v_{i,j-1}}{2\Delta y}
\Big]
\end{split}
$$
注：==红色部分==，==第三个方程如何离散化？Delta t从哪里来的？==

最终根据$u$-动量方程可以得到：
$$
\begin{split}
u_{i,j}^{n+1}=&u_{i,j}^n-u_{i,j}^n\dfrac{\Delta t}{\Delta x}(u_{i,j}^n-u_{i-1,j}^n)-v_{i,j}^n\dfrac{\Delta t}{\Delta y}(u_{i,j}^n-u_{i,j-1}^n)\\
&-\dfrac{\Delta t}{2\rho\Delta x}(p_{i+1,j}^n-p_{i-1,j}^n)\\
&+\nu\Big[\dfrac{\Delta t}{(\Delta x)^2}\Big(u_{i+1,j}^n-2u_{i,j}^n+u_{i-1,j}^n\Big)
+\dfrac{\Delta t}{(\Delta y)^2}\Big(u_{i,j+1}^n-2u_{i,j}^n+u_{i,j-1}^n
\Big)\Big]
\end{split}
$$
根据$v$-动量方程可以得到：
$$
\begin{split}
v_{i,j}^{n+1}=&v_{i,j}^n-u_{i,j}^n\dfrac{\Delta t}{\Delta x}(v_{i,j}^n-v_{i-1,j}^n)-v_{i,j}^n\dfrac{\Delta t}{\Delta y}(u_{i,j}^n-u_{i,j-1}^n)\\
&-\dfrac{\Delta t}{2\rho\Delta y}(p_{i,j+1}^n-p_{i,j-1}^n)\\
&+\nu\Big[\dfrac{\Delta t}{(\Delta x)^2}\Big(v_{i+1,j}^n-2v_{i,j}^n+v_{i-1,j}^n\Big)
+\dfrac{\Delta t}{(\Delta y)^2}\Big(v_{i,j+1}^n-2v_{i,j}^n+v_{i,j-1}^n
\Big)\Big]
\end{split}
$$
根据pressure-Poisson方程可以的得到：
$$
\begin{split}
p_{i,j}=&\dfrac12\dfrac{(p_{i+1,j}^n+p_{i-1,j}^n)(\Delta y)^2+(p_{i,j+1}^n+p_{i,j-1}^n)(\Delta x)^2}{(\Delta x)^2+(\Delta y)^2}\\
&-\dfrac12\dfrac{\rho(\Delta x)^2(\Delta y)^2}{(\Delta x)^2+(\Delta y)^2}\\
&\times\Big[\dfrac1{\Delta t}\Big(\dfrac{u_{i+1,j}-u_{i-1,j}}{2\Delta x}+\dfrac{v_{i,j+1}-v_{i,j-1}}{2\Delta y}\Big)-\dfrac{u_{i+1,j}-u_{i-1,j}}{2\Delta x}\dfrac{u_{i+1,j}-u_{i-1,j}}{2\Delta x}\\
&-2\dfrac{u_{i,j+1}-u_{i,j-1}}{2\Delta y}\dfrac{v_{i+1,j}-v_{i-1,j}}{2\Delta x}
-\dfrac{v_{i,j+1}-v_{i,j-1}}{2\Delta y}\dfrac{v_{i,j+1}-v_{i,j-1}}{2\Delta y}
\Big]
\end{split}
$$
初始条件为：

$$
u,v,p=0\ \text{everywhere}
$$
边界条件为：
$$
\begin{split}
&u=1\ \text{at}\ y=2\\
&u,v=0\ \text{on the other boundaries}\\
&\dfrac{\partial p}{\partial y}=0\ \text{at}\ y=0\\
&p=0\ \text{at}\ y=2\\
&\dfrac{\partial p}{\partial x}=0\ \text{at}\ x=0,2
\end{split}
$$


















<br>

**References**

[1] Barba, Lorena A., and Forsyth, Gilbert F. (2018). CFD Python: the 12 steps to Navier-Stokes equations. *Journal of Open Source Education*, **1**(9), 21, https://doi.org/10.21105/jose.00021.

[2] [CFDPython/12_Step_9.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/12_Step_9.ipynb). （2D Laplace Equation）

[3] [CFDPython/13_Step_10.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/13_Step_10.ipynb).（2D Poisson Equation）

[XX] [CFDPython/14_Step_11.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/14_Step_11.ipynb). （Cavity Flow with Navier–Stokes）

[9] [CFDPython/15_Step_12.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/15_Step_12.ipynb). （Channel Flow with Navier–Stokes）

[Momentum Equations of the Fluid from Fundamentals of Aerodynamics by Anderson - What a starry night~](http://whatastarrynight.com/mathematics/computational fluid dynamics/Momentum-Equations-of-the-Fluid-from-Fundamentals-of-Aerodynamics-by-Anderson/)











