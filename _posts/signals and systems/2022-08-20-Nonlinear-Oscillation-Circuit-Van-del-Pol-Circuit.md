---
title: "Nonlinear Oscillation Circuit: Van del Pol Circuit"
categories: 
 - MATLAB
 - Signals and Systems
 - Uncertainty
tags:
 - MATLAB Animation
date: 2022-08-20 14:03:49 +0800
last_modified_at: 2024-11-11 19:19:24 +0800
---

# Nonlinear oscillation circuit

电子振荡电路一般至少含有两个储能元件和一个非线性元件。本文所介绍的<i class="term">范德坡(Van del Pol)电路</i>是一种典型的非线性振荡电路，它是由一个线性电感、一个线性电容和一个非线性电阻构成，如下图所示。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220819181910505.png?raw=true" alt="image-20220819181910505" style="zoom: 33%;" />

其中，非线性电阻为电流控制型，伏安特性为：

$$
u_R=\dfrac13i_R^3-i_R\notag
$$

该非线性电阻有一段具有负电阻性质：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220820105039909.png?raw=true" alt="image-20220820105039909" style="zoom:50%;" />

以 $u_c$  和 $i_R$ 为状态变量，则可以写出状态方程：

$$
\left\{
\begin{split}
\dfrac{\mathrm{d}u_C}{\mathrm{d}t}&=-\dfrac1Ci_L\\
\dfrac{\mathrm{d}i_L}{\mathrm{d}t}&=\dfrac1L\Big[u_C-(\dfrac13i_L^3-i_L)\Big]
\end{split}\label{raw}
\right.
$$

为了使用量纲为一的量，令 $\tau=\dfrac1{\sqrt{LC}}t$，此时 $\tau$ 为量纲一的量。于是有：

$$
\begin{split}
\dfrac{\mathrm{d}u_C}{\mathrm{d}t}&=\dfrac{\mathrm{d}u_C}{\mathrm{d}\tau}\dfrac{\mathrm{d}\tau}{\mathrm{d}t}=\dfrac1{\sqrt{LC}}\dfrac{\mathrm{d}u_C}{\mathrm{d}\tau}\\
\dfrac{\mathrm{d}i_L}{\mathrm{d}t}&=\dfrac{\mathrm{d}i_L}{\mathrm{d}\tau}\dfrac{\mathrm{d}\tau}{\mathrm{d}t}=\dfrac1{\sqrt{LC}}\dfrac{\mathrm{d}i_L}{\mathrm{d}\tau}
\end{split}\notag
$$

另外，令

$$
\varepsilon=\sqrt{\dfrac C L}\notag
$$

则式 $\eqref{raw}$ 可以改写为：

$$
\left\{
\begin{split}
\dfrac{\mathrm{d}u_C}{\mathrm{d}\tau}&=-\dfrac1\varepsilon i_L\\
\dfrac{\mathrm{d}i_L}{\mathrm{d}\tau}&=\varepsilon\Big[u_C-(\dfrac13i_L^3-i_L)\Big]
\end{split}\notag
\right.
$$

再令 $x_1=i_L$，$x_2=\dfrac{\mathrm{d}i_L}{\mathrm{d}t}$，则上式可以简化为：

注意：这里的状态变量并不是 $u_C$ 和 $i_L$。
{: .notice--warning}

$$
\left\{
\begin{split}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}&=x_2\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}&=\varepsilon(1-x_1^2)x_2-x_1
\end{split}\label{simplified}
\right.
$$

方程 $\eqref{simplified}$ 中仅有一个参数 $\varepsilon=\sqrt{\dfrac C L}$。根据不同的 $\varepsilon$ 值和初始值，可以画出该方程不同的相轨迹，就可以了解该电子振荡电路的定性性质。

<br>

# Phase trajectories under different initial conditions

下图展示了当 $\varepsilon=0.1$ ，初始条件分别为 $(0,1)$ $(0, 5)$ $(0,9) $ 时的相轨迹。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/PhaceTractories.gif?raw=true" alt="PhaceTractories" style="zoom:67%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220820133239047.png?raw=true" alt="image-20220820133239047" style="zoom:67%;" />

```matlab
clc, clear, close
gifFile = 'PhaceTractories.gif?raw=true';
if exist(gifFile, 'file')
    delete(gifFile)
end

% Figure settings
LineWidth = 1;
xyaxislimit = [-4, 6, -4, 10];
sz = 40;
numpoints = 100;

figure, axes
hold(gca, 'on')
axis(xyaxislimit)
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title('The trajectories with $\varepsilon$=0.1 and various initial points.', Interpreter="latex")


% Specify various intitial points and solve state function
y0_1 = [0; 1];
[t1, y1] = ode45(@StateFunction, [0, numpoints], y0_1);
y0_2 = [0; 5];
[t2, y2] = ode45(@StateFunction, [0, numpoints], y0_2);
y0_3 = [0; 9];
[t3, y3] = ode45(@StateFunction, [0, numpoints], y0_3);


% Plot trajectory1
scatter(y0_1(1),y0_1(2), sz, 'filled')
h1 = animatedline(gca, LineWidth=LineWidth, Color='#C85C5C');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'])
for i = 1:numel(y1(:,1))
    addpoints(h1, y1(i,1), y1(i,2))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y1(end,1), y1(end,2), 'filled');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'])

% Plot trajectory2
scatter(y0_2(1),y0_2(2), 'filled')
h2 = animatedline(gca, LineWidth=LineWidth, Color='#5CC85C');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')']);
for i = 1:numel(y2(:,1))
    addpoints(h2, y2(i,1), y2(i,2))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y2(end,1), y2(end,2), 'filled');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['End point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')']);

% Plot trajectory3
scatter(y0_3(1),y0_3(2), 'filled')
h3 = animatedline(gca, LineWidth=LineWidth, Color='#5C5CC8');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['End point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')']);
for i = 1:numel(y3(:,1))
    addpoints(h3, y3(i,1), y3(i,2))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y3(end,1), y3(end,2), 'filled');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['End point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')'], ...
    ['End point: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')']);


function dydt = StateFunction(t, y)
epsilon = 0.1;
dydt = [y(2); epsilon*(1-y(1)^2)*y(2)-y(1)];
end
```

从上面的相图可以看出，无论选取什么样的初始值，都可以看到有单一的闭合曲线存在，这种单一的或孤立的闭合曲线成为<i class="term">极限环(Limit cycle)</i>。<i class="emphasize">无论相点初值是在极限环外还是在极限环内，最终都将沿着极限环运动</i>。这说明，<i class="emphasize">**不论初始条件如何**，在该电路中最终将建立起周期性振荡</i>。这种在非线性自治电路中产生的持续振荡是一种自激振荡（自治[^2]，没有外施激励）。这与二阶RLC电路振荡过程[^1]（无阻尼的情况）是有所不同的，后者的振荡振幅是与初始条件有关的。

<br>

# Phase trajectories under different $\varepsilon$ values

当初始值固定为 $(0,5)$ 时，不同的 $\varepsilon$ 取值（0.1，0.7，3.5）所对应的相轨迹：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220820141247247.png?raw=true" alt="image-20220820141247247" style="zoom:67%;" />

```matlab
clc, clear, close
gifFile = 'PhaceTractories2.gif';
if exist(gifFile, 'file')
    delete(gifFile)
end

% Figure settings
LineWidth = 1.5;
xyaxislimit = [-4, 8, -6, 10];
sz = 40;
numpoints = 100;

figure, axes
hold(gca, 'on')
axis(xyaxislimit)
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title('The trajectories with various $\varepsilon$ values', Interpreter="latex")


% Specify various intitial points and solve state function
y0 = [0; 5];
[t1, y1] = ode45(@StateFunction1, [0, numpoints], y0);
[t2, y2] = ode45(@StateFunction2, [0, numpoints], y0);
[t3, y3] = ode45(@StateFunction3, [0, numpoints], y0);

scatter(y0(1),y0(2), sz, 'filled')
% Plot trajectory1
h1 = animatedline(gca, LineWidth=LineWidth, Color='#C85C5C');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', Interpreter="latex")
for i = 1:numel(y1(:,1))
    addpoints(h1, y1(i,1), y1(i,2))
    drawnow
%     exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y1(end,1), y1(end,2), 'filled');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', ...
    'End point: $\varepsilon$=0.1', Interpreter="latex")

% Plot trajectory2
h2 = animatedline(gca, LineWidth=LineWidth, Color='#5CC85C');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', ...
    'End point: $\varepsilon$=0.1', ...
    'Trajectory: $\varepsilon$=0.7', Interpreter="latex")
for i = 1:numel(y2(:,1))
    addpoints(h2, y2(i,1), y2(i,2))
    drawnow
%     exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y2(end,1), y2(end,2), 'filled');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', ...
    'End point: $\varepsilon$=0.1', ...
    'Trajectory: $\varepsilon$=0.7', ...
    'End point: $\varepsilon$=0.7', Interpreter="latex")

% Plot trajectory3
h3 = animatedline(gca, LineWidth=LineWidth, Color='#5C5CC8');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', ...
    'End point: $\varepsilon$=0.1', ...
    'Trajectory: $\varepsilon$=0.7', ...
    'End point: $\varepsilon$=0.7', ...
    'Trajectory: $\varepsilon$=3.5', Interpreter="latex")
for i = 1:numel(y3(:,1))
    addpoints(h3, y3(i,1), y3(i,2))
    drawnow
%     exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y3(end,1), y3(end,2), 'filled');
legend('Initial point', ...
    'Trajectory: $\varepsilon$=0.1', ...
    'End point: $\varepsilon$=0.1', ...
    'Trajectory: $\varepsilon$=0.7', ...
    'End point: $\varepsilon$=0.7', ...
    'Trajectory: $\varepsilon$=3.5', ...
    'End point: $\varepsilon$=3.5', Interpreter="latex")

function dydt = StateFunction1(t, y)
epsilon = 0.1;
dydt = [y(2); epsilon*(1-y(1)^2)*y(2)-y(1)];
end

function dydt = StateFunction2(t, y)
epsilon = 0.7;
dydt = [y(2); epsilon*(1-y(1)^2)*y(2)-y(1)];
end

function dydt = StateFunction3(t, y)
epsilon = 3.5;
dydt = [y(2); epsilon*(1-y(1)^2)*y(2)-y(1)];
end
```

从上面的相轨迹中可以看出，当选取不同的 $\varepsilon$ 值，会改变极限环的形状。

我们可以再观察一下 $\varepsilon=3.5$ 时，不同初值条件，即$(0,1)$，$(1, 5)$ ，$(5,9) $ 对应的相图：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220820143647878.png?raw=true" alt="image-20220820143647878" style="zoom:67%;" />

```matlab
clc, clear, close
gifFile = 'PhaceTractories3.gif';
if exist(gifFile, 'file')
    delete(gifFile)
end

% Figure settings
LineWidth = 1.5;
xyaxislimit = [-4, 6, -6, 15];
sz = 40;
numpoints = 50;

figure, axes
hold(gca, 'on')
axis(xyaxislimit)
xlabel("$x_1$", Interpreter="latex")
ylabel("$x_2$", Interpreter="latex")
title('The trajectories with $\varepsilon$=3.5 and various initial points.', Interpreter="latex")


% Specify various intitial points and solve state function
y0_1 = [0; 1];
[t1, y1] = ode45(@StateFunction, [0, numpoints], y0_1);
y0_2 = [1; 5];
[t2, y2] = ode45(@StateFunction, [0, numpoints], y0_2);
y0_3 = [5; 9];
[t3, y3] = ode45(@StateFunction, [0, numpoints], y0_3);


% Plot trajectory1
scatter(y0_1(1),y0_1(2), sz, 'filled')
h1 = animatedline(gca, LineWidth=LineWidth, Color='#C85C5C');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    'Location','northwest')
for i = 1:numel(y1(:,1))
    addpoints(h1, y1(i,1), y1(i,2))
    drawnow
%     exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y1(end,1), y1(end,2), 'filled');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'])

% Plot trajectory2
scatter(y0_2(1),y0_2(2), 'filled')
h2 = animatedline(gca, LineWidth=LineWidth, Color='#5CC85C');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')']);
for i = 1:numel(y2(:,1))
    addpoints(h2, y2(i,1), y2(i,2))
    drawnow
%     exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y2(end,1), y2(end,2), 'filled');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['End point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')']);

% Plot trajectory3
scatter(y0_3(1),y0_3(2), 'filled')
h3 = animatedline(gca, LineWidth=LineWidth, Color='#5C5CC8');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['End point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')']);
for i = 1:numel(y3(:,1))
    addpoints(h3, y3(i,1), y3(i,2))
    drawnow
%     exportgraphics(gcf, gifFile, 'Append', true);
end
scatter(y3(end,1), y3(end,2), 'filled');
legend(['Initial point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['End point: ', '(', num2str(y0_1(1)), ',', num2str(y0_1(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['End point: ', '(', num2str(y0_2(1)), ',', num2str(y0_2(2)), ')'], ...
    ['Initial point: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')'], ...
    ['Trajectory: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')'], ...
    ['End point: ', '(', num2str(y0_3(1)), ',', num2str(y0_3(2)), ')']);


function dydt = StateFunction(t, y)
epsilon = 3.5;
dydt = [y(2); epsilon*(1-y(1)^2)*y(2)-y(1)];
end
```

可以看到，虽然极限环的形状改变了，但是在不同的初始条件下，仍然可以建立起相同的周期振荡。

<br>

**References**

- 邱关源. 电路（第5版）.
- [Limit cycle](https://en.wikipedia.org/wiki/Limit_cycle).

[^1]: [State Function and Phase Portrait of Second-order Linear RLC Circuits](/2022-08-19/09-17-37.html).
[^2]: [Chaotic Circuit: Chua’s Circuit](/2022-08-19/15-07-21.html).
