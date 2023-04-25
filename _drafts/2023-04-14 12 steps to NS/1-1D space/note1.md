

# 1-D Linear Convection Equation

在博客 [1] 中我们讨论了CFD中的连续方程：



一维对流方程：
$$
\dfrac{\partial\rho}{\partial t}+\nabla\cdot(\rho\mathrm{\boldsymbol{V}})=0
$$
在（1）一维，且（2）速度为常数$c$的情况下，可以写作：
$$
\dfrac{\partial\rho}{\partial t}+c\dfrac{\partial \rho}{\partial x}=0
$$
为了与Barba的课程保持一致 [2]，这里将密度$\rho$重新记作$u$，即：
$$
\dfrac{\partial u}{\partial t}+c\dfrac{\partial u}{\partial x}=0\label{eq1}
$$
在给定的初始条件下（可以理解为wave），这个方程表示initial wave以常数$c$传播（沿着$x$轴平移），并且波的形状不发生改变（可能是因为不涉及到压力）。但是不涉及压力，那么$u$是什么？==$u$是要研究的物理量？可能并不是连续方程的简化==

如果初始条件为：
$$
u(x,0)=u_0(x)
$$
注：表示初始条件为只和$x$相关的函数。
{: .notice--primary}

则式$\eqref{eq1}$的精确解为：
$$
u(x,t)=u_0(x-ct)
$$
注：可以带入式$\eqref{eq1}$进行简单的验证。
{: .notice--primary}

接下来，对方程$\eqref{eq1}$进行空间上和时间上的离散：对时间导数使用前向差分策略（Forward Different scheme），对空间导数使用后向差分策略（Backward Difference scheme）。于是，式$\eqref{eq1}$可以写作：
$$
\dfrac{u_{i}^{n+1}-u_i^n}{\Delta t}+c\dfrac{u_i^n-u_{i-1}^n}{\Delta x}=0\label{eq2}
$$
其中：

- $n$和$n+1$表示时间的两个前后的step；
- $i-1$和$i$表示$x$轴上的两个相邻点。

==为什么要对时间和空间做不同的差分策略？==

在初始条件给定的情况下，式$\eqref{eq2}$中唯一的未知量是$u_{i}^{n+1}$（因为$u_{-1}^0=u_0^0$），于是有：
$$
u_{i}^{n+1}=u_i^n-c\dfrac{\Delta t}{\Delta x}(u_i^n-u_{i-1}^n)\label{eq3}
$$
这个表达式意味着$n+1$时间点$u$的计算是不依赖于

下面就使用MATLAB来实现$\eqref{eq3}$的求解：

```matlab
clc,clear,close all

nx = 81;
dx = 2/(nx-1); % deta x: 0.05
nt = 25;       % nt is the number of timesteps we want to calculate
dt = .025;     % delt t: 0.025
c = 1;         % assume wavespeed of c = 1

% Set initial condition
un = nan(nt,nx);
u0 = ones(1,nx);
u0(ceil(0.5/dx):ceil(1/dx+1)) = 2;
un(1,:) = u0;

figure
axes
hold(gca,"on")
grid(gca,"on")
box(gca,"on")

for n = 2:nt
    un(n,:) = un(n-1,:);
    for i = 2:nx
        un(n,i) = un(n-1,i)-c*dt/dx*(un(n-1,i)-un(n-1,i-1));
    end
    % Plot every timestep
    plot(linspace(0,2,nx),un(n,:), ...
        'LineWidth',1,'LineStyle','-','Color',[0.5,0.5,0.5], ...
        'HandleVisibility','off')
end

% Plot the first and the last timestep
plot(linspace(0,2,nx),un(1,:), ...
    'LineWidth',1,'DisplayName','$u^{t=0}$','Color','b')
plot(linspace(0,2,nx),un(end,:), ...
    'LineWidth',1,'DisplayName','$u^{t=n}$','Color','r')
title('$u$ after advancing in time (25 timestep)','Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('u','Interpreter','latex')
legend('Interpreter','latex')
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230414132003632.png" alt="image-20230414132003632" style="zoom:50%;" />

如果将`nx`改为81，则图像变化为了：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230414131953918.png" alt="image-20230414131953918" style="zoom:50%;" />

可以看到，$x$步长对于迭代结果的输出有很大的影响。并且随着`nx`进一步增大（`nx=100`，`nx=200`），结果甚至不收敛：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230414132147681.png" alt="image-20230414132147681" style="zoom:50%;" />

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230414132247535.png" alt="image-20230414132247535" style="zoom:50%;" />

<br>

# 1-D Convection Nonlinear Equation

==google 一维对流扩散方程（Burgers方程）==

实际上，式$\eqref{eq1}$是线性的，如果是非线性对流，则方程为：
$$
\dfrac{\partial u}{\partial t}+u\dfrac{\partial u}{\partial x}=0\label{nonlinear}
$$

其中，速度不再是常数，而是和$u$保持一致，这使得该方程为一个非线性方程。于是，类比于公式$\eqref{eq3}$，可以得到：

$$
u_{i}^{n+1}=u_i^n-u_i^n\dfrac{\Delta t}{\Delta x}(u_i^n-u_{i-1}^n)
$$
同样地，我们分析一下`nx`的设置对于结果影响：

注：为了简便分析，这里将前面的过程封装成了函数，
{: .notice-primary}

```matlab
clc,clear,close all

figure('Units','pixels', ...
    'Position',[228.33,451.67,1867.33,353.33])
tiledlayout(1,4)
nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperNonLinearCon(41)

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperNonLinearCon(81)

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperNonLinearCon(100)

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperNonLinearCon(200)

function helperNonLinearCon(nx)
dx = 2/(nx-1); % deta x: 0.05
nt = 25;       % nt is the number of timesteps we want to calculate
dt = .025;     % delt t: 0.025

% Set initial condition
un = nan(nt,nx);
u0 = ones(1,nx);
u0(ceil(0.5/dx):ceil(1/dx+1)) = 2;
un(1,:) = u0;

for n = 2:nt
    un(n,:) = un(n-1,:);
    for i = 2:nx
        un(n,i) = un(n-1,i)-un(n-1,i)*dt/dx*(un(n-1,i)-un(n-1,i-1));
    end
    % Plot every timestep
    plot(linspace(0,2,nx),un(n,:), ...
        'LineWidth',1,'LineStyle','-','Color',[0.5,0.5,0.5], ...
        'HandleVisibility','off')
end

% Plot the first and the last timestep
plot(linspace(0,2,nx),un(1,:), ...
    'LineWidth',1,'DisplayName','$u^{t=0}$','Color','b')
plot(linspace(0,2,nx),un(end,:), ...
    'LineWidth',1,'DisplayName','$u^{t=n}$','Color','r')
title(sprintf('$u$ after advancing in time (nx=%s)',num2str(nx)),'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('u','Interpreter','latex')
legend('Interpreter','latex')
end
```

![image-20230414185510649](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230414185510649.png)

可以看到发散的情况更加严重了。

<br>

# Courant–Friedrichs–Lewy (CFL) Condition

我们重回到一维线性对流方程的求解，并测试一下当`nx`分别取值为41，61，71和85时的求解效果：

注：此处和第一部分的代码有一处不同，此处`nt=20`。
{: .notice--primary}

```matlab
clc,clear,close all

figure('Units','pixels', ...
    'Position',[228.33,451.67,1867.33,353.33])
tiledlayout(1,4)
nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperLinearCon(41)

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperLinearCon(61)

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperLinearCon(71)

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperLinearCon(85)

function helperLinearCon(nx)
dx = 2/(nx-1); % deta x: 0.05
nt = 20;       % nt is the number of timesteps we want to calculate
dt = .025;     % delt t: 0.025
c = 1;

% Set initial condition
un = nan(nt,nx);
u0 = ones(1,nx);
u0(ceil(0.5/dx):ceil(1/dx+1)) = 2;
un(1,:) = u0;

for n = 2:nt
    un(n,:) = un(n-1,:);
    for i = 2:nx
        un(n,i) = un(n-1,i)-c*dt/dx*(un(n-1,i)-un(n-1,i-1));
    end
    % Plot every timestep
    plot(linspace(0,2,nx),un(n,:), ...
        'LineWidth',1,'LineStyle','-','Color',[0.5,0.5,0.5], ...
        'HandleVisibility','off')
end

% Plot the first and the last timestep
plot(linspace(0,2,nx),un(1,:), ...
    'LineWidth',1,'DisplayName','$u^{t=0}$','Color','b')
plot(linspace(0,2,nx),un(end,:), ...
    'LineWidth',1,'DisplayName','$u^{t=n}$','Color','r')
title(sprintf('$u$ after advancing in time (nx=%s)',num2str(nx)),'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('u','Interpreter','latex')
legend('Interpreter','latex')
end
```

![image-20230414190448689](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230414190448689.png)

可以看到，当`nx=85`时，结果并不像我们预期的样子。为什么？

为了回答这个问题，还需要从编写代码入手：在每一个time loop的迭代中，我们使用existing wave data去预测下一个time step的波速。最初，随着grid points的数量的增加，我们得到的结果变得更加准确：即数值扩散（numerical diffusion）较少，当`nx=81`时，结果比`nx=41`看起来更像方波。

每一次time loop迭代，相当于向前推进了$\Delta t$的时间，即定义的`dt=0.025`。

在`nx=85`时，在时间段$\Delta t$（即`dt`）内，波传播的距离大于`dx`；每一个grid box的长度`dx`是和`nx`相关的，因此，如果`dt`的能够根据`dx`的大小进行计算，那么就能够保证稳定性：
$$
\sigma=\dfrac{u\Delta t}{\Delta x}\le\sigma_{\mathrm{max}}
$$
其中，$u$表示波速；$\sigma$称作**库朗特数**（**Courant number**）；$\sigma_{\mathrm{max}}$的值能够确保稳定性取决于所使用的离散化（that will ensure stability depends on the discretization used）。

因此，我们可以使用CFL number根据`dx`计算合适的时间步长`dt`：

```matlab
clc,clear,close all

figure('Units','pixels', ...
    'Position',[228.33,451.67,1867.33,353.33])
tiledlayout(1,4)
nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperLinearCon(41)

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperLinearCon(81)

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperLinearCon(101)

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperLinearCon(121)

function helperLinearCon(nx)
dx = 2/(nx-1); % deta x: 0.05
nt = 20;       % nt is the number of timesteps we want to calculate
c = 1;
sigma = .5;
dt = sigma*dx;

% Set initial condition
un = nan(nt,nx);
u0 = ones(1,nx);
u0(ceil(0.5/dx):ceil(1/dx+1)) = 2;
un(1,:) = u0;

for n = 2:nt
    un(n,:) = un(n-1,:);
    for i = 2:nx
        un(n,i) = un(n-1,i)-c*dt/dx*(un(n-1,i)-un(n-1,i-1));
    end
    % Plot every timestep
    plot(linspace(0,2,nx),un(n,:), ...
        'LineWidth',1,'LineStyle','-','Color',[0.5,0.5,0.5], ...
        'HandleVisibility','off')
end

% Plot the first and the last timestep
plot(linspace(0,2,nx),un(1,:), ...
    'LineWidth',1,'DisplayName','$u^{t=0}$','Color','b')
plot(linspace(0,2,nx),un(end,:), ...
    'LineWidth',1,'DisplayName','$u^{t=n}$','Color','r')
title(sprintf('$u$ after advancing in time (nx=%s)',num2str(nx)),'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('u','Interpreter','latex')
legend('Interpreter','latex')
end
```

![image-20230415151756139](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230415151756139.png)

随着`nx`的增加，wave对流距离变得越来越短。这是因为时间迭代次数`nt=20`是不变的，但根据`nx`的值以及`dx`和`dt`的相应值，总体上仿真的时间越来越短。

<br>

# One-dimensional Diffusion Equation

一维扩散方程为（One-dimensional diffusion equation）：
$$
\dfrac{\partial u}{\partial t}=\nu\dfrac{\partial^2u}{\partial x^2}\label{diffusion_equation}
$$
其中，$\nu$为viscosity。和我们前面所研究的两个方程$\eqref{eq1}$和方程$\eqref{nonlinear}$方程所不同的是，式$\eqref{diffusion_equation}$具有二阶导数。

二阶导数可以在几何上表示为一阶导数给出的曲线的切线。我们可以使用中心差分方法（Central difference scheme）离散二阶导数：即结合前向差分和后向差分方法。

首先，我们在$u_i$处进行二阶泰勒展开，以表示$u_{i+1}$和$u_{i-1}$处的值：
$$
\begin{split}
u_{i+1}&=u_i+\Delta x\dfrac{\partial u}{\partial x}\Big\vert_i
+\dfrac1{2!}(\Delta x)^2\dfrac{\partial u^2}{\partial x^2}\Big\vert_i+\dfrac1{3!}(\Delta x)^3\dfrac{\partial u^3}{\partial x^3}\Big\vert_i+O\Big((\Delta x)^4\Big)\\
u_{i-1}&=u_i-\Delta x\dfrac{\partial u}{\partial x}\Big\vert_i
+\dfrac1{2!}(\Delta x)^2\dfrac{\partial u^2}{\partial x^2}\Big\vert_i-\dfrac1{3!}(\Delta x)^3\dfrac{\partial u^3}{\partial x^3}\Big\vert_i+O\Big((\Delta x)^4\Big)
\end{split}
$$
我们将上两式相加，则奇数次的导数项会相互抵消，并且如果忽略$O\Big((\Delta x)^4\Big)$以及更高阶的无穷小项，我们可以得到：
$$
u_{i+1}+u_{i-1}=2u_i+(\Delta x)^2\dfrac{\partial u^2}{\partial x^2}\Big\vert_i
$$
进而有：
$$
\dfrac{\partial u^2}{\partial x^2}\Big\vert_i=\dfrac{u_{i+1}-2u_i+u_{i-1}}{(\Delta x)^2}
$$
因此，式$\eqref{diffusion_equation}$可以离散为：
$$
\dfrac{u_i^{n+1}-u_i^n}{\Delta t}=\nu\dfrac{u^n_{i+1}-2u^n_i+u^n_{i-1}}{(\Delta x)^2}
$$
于是可以得到：
$$
u_i^{n+1}=u_i^n+\dfrac{\nu\Delta t}{(\Delta x)^2}(u^n_{i+1}-2u^n_i+u^n_{i-1})
$$

```matlab
clc,clear,close all

nexttile
hold(gca,"on")
grid(gca,"on")
box(gca,"on")
helperDiffusion(41)

function helperDiffusion(nx)
dx = 2/(nx-1); % deta x: 0.05
nt = 20;       % nt is the number of timesteps we want to calculate
nu = 0.3;      % the value of viscosity
sigma = 0.2;
dt = sigma*(dx)^2/nu;

% Set initial condition
un = nan(nt,nx);
u0 = ones(1,nx);
u0(ceil(0.5/dx):ceil(1/dx+1)) = 2;
un(1,:) = u0;

for n = 2:nt
    un(n,:) = un(n-1,:);
    for i = 2:nx-1
        un(n,i) = un(n-1,i)+nu*dt/(dx)^2*(un(n-1,i+1)-2*un(n-1,i)+un(n-1,i-1));
    end
    % Plot every timestep
    plot(linspace(0,2,nx),un(n,:), ...
        'LineWidth',1,'LineStyle','-','Color',[0.5,0.5,0.5], ...
        'HandleVisibility','off')
end

% Plot the first and the last timestep
plot(linspace(0,2,nx),un(1,:), ...
    'LineWidth',1,'DisplayName','$u^{t=0}$','Color','b')
plot(linspace(0,2,nx),un(end,:), ...
    'LineWidth',1,'DisplayName','$u^{t=n}$','Color','r')
title(sprintf('$u$ after advancing in time (nx=%s)',num2str(nx)),'Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('u','Interpreter','latex')
legend('Interpreter','latex')
end
```

![image-20230415161530397](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230415161530397.png)

<br>

# Burgers’ Equation

一维空间的Burger方程为：
$$
\dfrac{\partial u}{\partial t}+u\dfrac{\partial u}{\partial x}=\nu\dfrac{\partial^2u}{\partial x^2}\label{Burger}
$$
它实际上是非线性对流和扩散方程的结合。因此，它的迭代形式为：
$$
u_{i}^{n+1}=u_i^n-u_i^n\dfrac{\Delta t}{\Delta x}(u_i^n-u_{i-1}^n)+\nu\dfrac{\Delta t}{(\Delta x)^2}(u^n_{i+1}-2u^n_i+u^n_{i-1})\label{eq5}
$$
初始条件为：
$$
\begin{split}
u&=-\dfrac{2\nu}{\phi}\dfrac{\partial\phi}{\partial x}+4\\
\mathrm{where}\ \phi&=\exp(\dfrac{-x^2}{4\nu})+\exp(\dfrac{-(x-2\pi)^2}{4\nu})
\end{split}
$$
在这个初始条件下，方程$\eqref{Burger}$具有解析解：
$$
\begin{split}
u&=-\dfrac{2\nu}{\phi}\dfrac{\partial\phi}{\partial x}+4\\
\phi&=\exp(\dfrac{-(x-4t)^2}{4\nu(t+1)})+\exp(\dfrac{-(x-4t-2\pi)^2}{4\nu(t+1)})
\end{split}\label{analytical}
$$
边界条件（boundary condition）为：==？？？==
$$
u(0)=u(2\pi)
$$
准确地讲，是$u(x=0)=x(u=2\pi)$，这表现出一定的周期性，因此也被称为是**周期**（**periodic**）边界条件。但是，在下面的讨论中我们可以看到，它并不是对整个$x\in\mathbb{R}$上都是周期性的。

下面的代码进行了Burger方程的仿真，主要实现了以下三个功能：

- 计算初始条件：由于这里的初始条件比较复杂，Barba教授的课程使用了Python的`sympy`库来计算这个复杂的初始条件，我们在这里使用MATLAB的Symbolic Math Toolbox来实现这一功能；
- 在计算了初始条件之后，进行迭代计算；
- 将计算结果与解析结果$\eqref{analytical}$进行比较；

```matlab
clc,clear,close all

x_sym = sym('x');
nu_sym = sym('nu');
t_sym = sym('t');

phi_sym = (exp(-(x_sym-4*t_sym)^2/(4*nu_sym*(t_sym+1)))+...
    exp(-(x_sym-4*t_sym-2*pi)^2/(4*nu_sym*(t_sym+1))));
phiprime_sym = diff(phi_sym,x_sym,1);
u_sym = -2*nu_sym*(phiprime_sym/phi_sym)+4;

nx = 101;
nt = 100;
xrange = 2*pi;
dx = xrange/(nx-1);
nu = 0.07;
dt = dx*nu;

% Set initial condition
t = 0;
x = linspace(0,xrange,nx);
un = nan(nt,nx);
for i = 1:nx
    un(1,i) = subs(u_sym,[t_sym,x_sym,nu_sym],[t,x(i),nu]);
end

figure
axes
grid(gca,"on")
hold(gca,"on")
box(gca,"on")
xlim([0,xrange])
ylim([0,10])

for n = 2:nt
    un(n,:) = un(n-1,:);
    for i = 2:nx-1
        un(n,i) = un(n-1,i)-un(n-1,i)*dt/dx*(un(n-1,i)-un(n-1,i-1))...
            +nu*dt/(dx)^2*(un(n-1,i+1)-2*un(n-1,i)+un(n-1,i-1));
    end
    un(n,1) = un(n-1,1)-un(n-1,1)*dt/dx*(un(n-1,1)-un(n-1,end-1))... 
        +nu*dt/dx^2*(un(n-1,2)-2*un(n-1,1)+un(n-1,end-1)); % Attention n-1
    un(n,end) = un(n,1);

    % Plot every timestep
    plot(x,un(n,:), ...
        'LineWidth',1,'LineStyle','-','Color',[0.5,0.5,0.5], ...
        'HandleVisibility','off')
end

% Plot the first and the last timestep
plot(x,un(1,:), ...
    'LineWidth',1,'DisplayName','$u^{t=0}$','Color','b')
plot(x,un(end,:), ...
    'LineWidth',1,'DisplayName','$u^{t=n}$','Color','r')

% Calculate and plot analytical
un_analytical = nan(1,width(un));
for i = 1:nx
    un_analytical(i) = subs(u_sym,[t_sym,x_sym,nu_sym],[t+dt*nt,x(i),nu]);
end
plot(x,un_analytical,...
    'LineWidth',1,'DisplayName','Analytical','Color','g')
title('$u$ after advancing in time','Interpreter','latex')
xlabel('x','Interpreter','latex')
ylabel('u','Interpreter','latex')
legend('Interpreter','latex')


```

![image-20230415224135962](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230415224135962.png)

## Discussion 1: Processions for the first and the last position

实际上，在博客前面的几章中实现类似$\eqref{eq5}$的迭代公式的计算时，在迭代过程中，我们并没有对索引为`1`和索引为`nx`处的元素进行更新。对于简单的初始条件（例上文所用到的hat function），这一点是可以接受的，因为索引为`1`和索引为`nx`处的值都是1；但是对于==saw-tooth function==，忽略这一点会造成非常大的误差。因此，在上面的这段代码中，我们根据Barba教授所提供的方法对这两个元素进行了处理：

```matlab
...
for n = 2:nt
    un(n,:) = un(n-1,:);
    for i = 2:nx-1
        un(n,i) = un(n-1,i)-un(n-1,i)*dt/dx*(un(n-1,i)-un(n-1,i-1))...
            +nu*dt/(dx)^2*(un(n-1,i+1)-2*un(n-1,i)+un(n-1,i-1));
    end
    un(n,1) = un(n-1,1)-un(n-1,1)*dt/dx*(un(n-1,1)-un(n-1,end-1))... 
        +nu*dt/dx^2*(un(n-1,2)-2*un(n-1,1)+un(n-1,end-1)); % Attention n-1
    un(n,end) = un(n,1);

    % Plot every timestep
    plot(x,un(n,:), ...
        'LineWidth',1,'LineStyle','-','Color',[0.5,0.5,0.5], ...
        'HandleVisibility','off')
end
...
```

这段代码处理的逻辑是：

- 在计算第`n+1`次迭代的第一个元素时，将第`n`次迭代的最后一个元素视作`i-1`位置的值进行计算；
- 第`n+1`次迭代的最后一个元素的值与第一个元素的值保持一致

注：其实这么做，就是使得每一次迭代中（除了初始条件处）的最后一个元素和第一个元素保持一致。
{: .notice--primary}

![image-20230415223753412](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230415223753412.png)

注：一定要注意，**在计算`n+1`次迭代时，只使用了第`n`次迭代的信息**，这就是上述代码在计算`un(n,1)`是的注释`Attention n-1`所想要提示的。在最开始编写代码的时候，我并没有注意到这一点，在`un(n,1)`的计算式中使用了索引`n`，这就使用了前面第二层`for`循环迭代后的结果，是不对的。一定要注意这一点！！！
{: .notice--warning}

## Discussion 2

虽然上面的结果看起来不错，数值解与解析解的比较接近，但是如果扩大$x$的范围，可以看到结果就相差较大：

![image-20230415233313327](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230415233313327.png)

![image-20230415233243631](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230415233243631.png)

并且这个误差并不是由抛分过疏或过分导致的。

<br>

==hat function的解析解验证==



# Using array

==还要添加Burgus方程==

我们重新把一维线性对流方程、一维非线性对流方程、一维扩散方程、以及Burger方程的迭代形式写在这里：
$$
\begin{split}
&\mathrm{1D\ Linear\ Convection\ function:}\ u_{i}^{n+1}=u_i^n-c\dfrac{\Delta t}{\Delta x}(u_i^n-u_{i-1}^n)\\
&\mathrm{1D\ Nonlinear\ Convection\ function:}\ u_{i}^{n+1}=u_i^n-u_i^n\dfrac{\Delta t}{\Delta x}(u_i^n-u_{i-1}^n)\\
&\mathrm{1D\ Diffusion\ function:\ }u_i^{n+1}=u_i^n+\dfrac{\nu\Delta t}{(\Delta x)^2}(u^n_{i+1}-2u^n_i+u^n_{i-1})\\
&\mathrm{Burgers\ function}:u_{i}^{n+1}=u_i^n-u_i^n\dfrac{\Delta t}{\Delta x}(u_i^n-u_{i-1}^n)+\nu\dfrac{\Delta t}{(\Delta x)^2}(u^n_{i+1}-2u^n_i+u^n_{i-1})
\end{split}
$$
在上面的代码中，我们在计算$u_{i}^{n+1}$时，都是使用嵌套循环的方式进行计算，但实际上类似于$u_i^n-u_{i-1}^n$这样的计算，完全可以用向量化编程的思想进行解决，以加速计算的速度。

例如，有一个数组：

```matlab
u = [3,4,7,2,9];
```

求$u_i^n-u_{i-1}^n$以及求$u^n_{i+1}-2u^n_i+u^n_{i-1}$的方法为：

```matlab
% Way 1
u11 = u;
diffu11 = u11(2:end)-u11(1:end-1);
diffu11 = [u11(1),diffu11];

u22 = u;
diffu22 = u22(3:end)-2*u22(2:end-1)+u22(1:end-2);
diffu22 = [u22(1),diffu22,u22(end)];
```

```
diffu11 =
     3     1     3    -5     7
diffu22 =
     3     2    -8    12     9
```

由于求$u_i^n-u_{i-1}^n$以及$u^n_{i+1}-2u^n_i+u^n_{i-1}$分别会使数组的维度降低1维或者降低2维，因此这里采用的是**先计算后补齐**的方式。

> 注：这种方式也是Barba教授的课程所使用的方式。例如在计算二维的迭代时：
>
> ![image-20230415191718214](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230415191718214.png)
>
> 除了这种方式以外，我们还可以使用**先补齐后计算**的方式：
>
> ```matlab
> % Way 2
> u1 = [u(1),u];
> diffu1 = u1(2:end)-u1(1:end-1)
> 
> u2 = [u(1),u,u(end)];
> diffu2 = u2(3:end)-2*u2(2:end-1)+u2(1:end-2)
> ```
>
> 结果为：
>
> ```
> diffu1 =
>      0     1     3    -5     7
> diffu2 =
>      1     2    -8    12    -7
> ```
>
> 这种方式其实有些类似前面我们对于Burger方程第一个元素与最后一个元素的处理。后面我们所采用的处理方式都与Barba教授保持一致。

于是，对于上面的一维线性对流方程，我们可以改写为：

```matlab
...
for n = 2:nt
    un(n,2:end) = un(n-1,2:end)-c*dt/dx*(un(n-1,2:end)-un(n-1,1:end-1));
    un(n,1) = 1;
end
...
```

一维非线性对流方程：

```matlab
...
for n = 2:nt
    un(n,2:end) = un(n-1,2:end)-un(n-1,2:end).*dt/dx.*(un(n-1,2:end)-un(n-1,1:end-1));
    un(n,1) = 1;
end
...
```

一维扩散方程：

```matlab
...
for n = 2:nt
    un(n,2:end-1) = un(n-1,2:end-1)+...
        nu*dt/(dx)^2*(un(n-1,3:end)-2*un(n-1,2:end-1)+un(n-1,1:end-2));
    un(n,1) = 1;
    un(n,end) = 1;
end
...
```

以及Burger方程：

```matlab
...
for n = 2:nt
    un(n,2:end-1) = un(n-1,2:end-1)...
        -un(n-1,2:end-1).*dt/dx.*(un(n-1,2:end-1)-un(n-1,1:end-2))... % Attention end-1 and end-2
        +nu*dt/(dx)^2*(un(n-1,3:end)-2*un(n-1,2:end-1)+un(n-1,1:end-2));
    un(n,1) = un(n-1,1)-un(n-1,1)*dt/dx*(un(n-1,1)-un(n-1,end-1))...
        +nu*dt/dx^2*(un(n-1,2)-2*un(n-1,1)+un(n-1,end-1)); % Attetion n-1
    un(n,end) = un(n,1);
end
...
```

<br>

**References**

[1] 

 [Continuity Equations of the Fluid from Fundamentals of Aerodynamics by Anderson - What a starry night~](http://whatastarrynight.com/mathematics/computational fluid dynamics/Continuity-Equations-of-the-Fluid-from-Fundamentals-of-Aerodynamics-by-Anderson/).

[2] [CFDPython/01_Step_1.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/01_Step_1.ipynb).

[3] [CFDPython/02_Step_2.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/02_Step_2.ipynb)

[4] [CFDPython/03_CFL_Condition.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/03_CFL_Condition.ipynb)

[5] [CFDPython/04_Step_3.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/04_Step_3.ipynb).

[6] [CFDPython/05_Step_4.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/05_Step_4.ipynb)

[7] [CFDPython/06_Array_Operations_with_NumPy.ipynb at master · barbagroup/CFDPython (github.com)](https://github.com/barbagroup/CFDPython/blob/master/lessons/06_Array_Operations_with_NumPy.ipynb)









Barba, Lorena A., and Forsyth, Gilbert F. (2018). CFD Python: the 12 steps to Navier-Stokes equations. *Journal of Open Source Education*, **1**(9), 21, https://doi.org/10.21105/jose.00021.

















