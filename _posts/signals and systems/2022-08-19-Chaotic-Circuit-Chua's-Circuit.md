---
title: "Chaotic Circuit: Chua's Circuit"
categories: 
 - MATLAB
 - Signals and Systems
 - Uncertainty
tags:
 - MATLAB Animation
date: 2022-08-19 15:07:21 +0800
last_modified_at: 2024-11-11 20:32:18 +0800
---

# Chaotic circuits

混沌是发生在<i class="emphasize">确定性系统</i>中的一种<i class="emphasize">不确定行为</i>，或者类似随机的行为。<i class="emphasize">混沌运动是一种非周期运动</i>。混沌的一个最显著特点是，状态变量的波形对状态变量的初始值极为敏感，即初始值对波形由重大影响。在一些二阶非线性非自治电路或三阶非线性自治电路中就存在着混沌现象。这类动态电路通常是二阶或三阶非线性微分方程。根据经典理论（决定论），在初始态条件确定之后，方程的解是确定的。但是人们发现在一定参数值得条件下，电路会出现很复杂的解，这种解：

1. 不是周期解，又不是<i class="term">拟周期解</i>(Quasiperiodicity[^3])，在状态平面上它的相轨道始终不会重复；

   拟周期解：拟周期解可以看作是一些具有不同频率的周期解之和，这些频率的相互比值是非有理数(即不存在最小公倍数)。总体看来，它似乎是具有“很长”的周期又接近周期解的一种解。
   {: .notice--primary}

2. 是有界的，即在一定的有界范围内具有遍历性，它对初始条件极为敏感。

<br>

# Three-oder nonlinear autonomous circuit: Chua’s circuit

<i class="term">蔡氏电路(Chua's circuit)</i>的电路结构如下图所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220819130711336.png?raw=true" alt="image-20220819130711336" style="zoom:50%;" />

该电路是由两个线性电容、一个线性电感、一个线性电阻和一个非线性电阻构成的三阶<i class="term">自治(autonomous)</i>动态电路。非线性电阻的伏安特性是 $i_R=g(u_R)$ ，是一个<i class="term">电压控制型非线性电阻</i>，它所对应的伏安特性曲线是一个分段线性曲线。

<div class="quote--left" markdown="1">

Autonomous circuit[^2][^4]: An autonomous circuit in analogue electronics is a circuit that produces a time-varying output without having a time-varying input (i.e., it has only DC power as an input).

</div>

设电压电容 $u_{C1}$、$u_{C2}$ 和电感电流 $i_L$ 为状态变量，根据基尔霍夫定律可以得到电路的状态方程：

$$
\left\{
\begin{split}
C_1\dfrac{\mathrm{d}u_{C1}}{\mathrm{d}t}&=\dfrac1{R_0}(u_{C2}-u_{C1})-g(u_R)\\
C_2\dfrac{\mathrm{d}u_{C2}}{\mathrm{d}t}&=\dfrac1{R_0}(u_{C1}-u_{C2})+i_L\\
L\dfrac{\mathrm{d}i_L}{\mathrm{d}t}&=-u_{C2}
\end{split}
\right.\notag
$$

为了简化表示，我们令：$u_{C1}=x$ ，$u_{C2}=y$，$i_L=z$，则有：

$$
\left\{
\begin{split}
\dfrac{\mathrm{d}x}{\mathrm{d}t}&=\alpha(y-x-f(x))\\
R_0C_2\dfrac{\mathrm{d}y}{\mathrm{d}t}&=(x-y)+R_0z\\
\dfrac{\mathrm{d}z}{\mathrm{d}t}&=-\beta y
\end{split}
\right.\label{chua1}
$$

其中，$\alpha=\dfrac1{R_0C_1}$ ，$f=\dfrac1{C_1}g$，$\beta=\dfrac1L$。

这是一个三阶非线性自治方程组。蔡氏电路在不同的参数条件下会发生丰富多样的自激励震荡过程，并有混沌出现，同时其所对应的方程 $\eqref{chua1}$ 的解对初始条件非常敏感。根据不同的参数值和不同的初始条件，根据方程 $\eqref{chua1}$ 可以计算出以 $x$， $y$， $z$  为坐标的状态空间的相轨道和它们的时域波形。

<br>

# Numerical simulation for Chua’s circuit

网站[^1]提供了其中一种情形的蔡氏电路： $\alpha=15.6$ ，$\beta=28$，$R_0=1$，$C_2=1$ ，非线性电阻的伏安特性曲线为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220819142621984.png?raw=true" alt="image-20220819142621984" style="zoom: 67%;" />

```matlab
% The voltage-current profile of the nonlinear resistance
x = -2:0.01:2;

m0 = -1.143;
m1 = -0.714;

h = m1*x+0.5*(m0-m1)*(abs(x+1)-abs(x-1));
f = @(x)m1*x+0.5*(m0-m1)*(abs(x+1)-abs(x-1));

figure, axes
hold(gca, 'on')
plot(x, h, LineWidth=1.7);
scatter(0, 0, 'filled')
scatter(-1, f(-1), 'filled');
scatter(1, f(1), 'filled');
xlabel('$u_R$', Interpreter='latex')
ylabel('$i_R$', Interpreter='latex')
title('The voltage-current profile of the nonlinear resistance')
```

其相轨迹为：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220819142832191.png?raw=true" alt="image-20220819142832191" style="zoom:67%;" />

```matlab
[t,y] = ode45(@chua,[0 100],[0.7 0 0]);
plot3(y(:,1),y(:,2),y(:,3))
grid

function out = chua(t,in)

x = in(1);
y = in(2);
z = in(3);

alpha  = 15.6;
beta   = 28; 
m0     = -1.143;
m1     = -0.714;

h = m1*x+0.5*(m0-m1)*(abs(x+1)-abs(x-1));

xdot = alpha*(y-x-h);
ydot = x - y+ z;
zdot  = -beta*y;

out = [xdot ydot zdot]';
end
```

观察它的相轨迹绘制过程：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/Chua1.gif?raw=true" alt="Chua1" style="zoom: 67%;" />

```matlab
gifFile = 'Chua1.gif';
if exist(gifFile, 'file')
    delete(gifFile)
end

figure, axes, view(-6.9,37.1)
xlabel('x'), ylabel('y'), zlabel('z')
axis([-3, 3, -0.4, 0.4, -4, 4])
h = animatedline(gca, LineWidth=1.3);
grid

[t,y] = ode45(@chua,[0 100],[0.7 0 0]);

for i = 1:numel(y(:,1))
    addpoints(h, y(i,1), y(i,2), y(i,3))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end

function out = chua(t,in)
x = in(1);
y = in(2);
z = in(3);

alpha  = 15.6;
beta   = 28;
m0     = -1.143;
m1     = -0.714;

h = m1*x+0.5*(m0-m1)*(abs(x+1)-abs(x-1));

xdot = alpha*(y-x-h);
ydot = x - y+ z;
zdot  = -beta*y;

out = [xdot ydot zdot]';
end
```

整个相轨迹呈现出“双涡卷”形状，因此也有称这个蔡氏电路为<i class="term">“双涡卷”电路</i>，它的相轨道永远也不会重复，表现为混沌振荡的非周期性。

由于非线性电路中混沌解的特殊性，分析研究混沌的主要方法有：

1. 使用计算机对非线性电路进行数值计算，从得到的相图和频域波形等来判断混沌特征的信息；
2. 对电路直接进行实验，在实验中对混沌现象进行观察和分析。

<br>

**References**

- 邱关源. 电路（第5版）.
- [Chua's circuit](https://en.wikipedia.org/wiki/Chua%27s_circuit).

[^1]: [Matlab simulation code for Chua's circuit](https://www.chuacircuits.com/matlabsim.php).
[^2]: [Autonomous circuit](https://en.wikipedia.org/wiki/Autonomous_circuit).
[^3]: [Quasiperiodicity](https://en.wikipedia.org/wiki/Quasiperiodicity).
[^4]: [Nonlinear Oscillation Circuit: Van del Pol Circuit](/2022-08-20/14-03-49.html).

