---
title: Plot Circle Based on Parametric Equation
toc: false
categories: 
 - MATLAB
 - Mathematics
tags: 
 - MATLAB Graphics
 - MATLAB Animation
 - Geometry
date: 2022-07-19 23:53:23 +0800
last_modified_at: 2023-11-14 14:08:17 +0800
---

根据圆形的一般方程

$$
(x-a)^2+(y-b)^2=r^2\notag
$$

可以得到圆形的参数方程

$$
\left\{
\begin{align*}
x&=r\cos\theta+a\\
b&=r\sin\theta+b
\end{align*}
\right.
$$

只需要令 $\theta$ 取遍 $[0,2\pi)$ 中的值，就可绘制出圆的图形。以圆方程 $(x-3)^2+(y-4)^2=5^2$ 为例绘制图像： 

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/Circle1.gif?raw=true" alt="Circle1" style="zoom:50%;" />

```matlab
% Plot circle function (x-3)^2+(y-4)^2 = 5^2
clc, clear, close all

Interpreter = 'latex';
gifFile = 'Circle1.gif';
if exist(gifFile, 'file')
    delete(gifFile)
end

numPoints = 100;

r = 5;
theta = linspace(0, 2*pi, numPoints);
x = r*cos(theta)+3;
y = r*sin(theta) +4;

fig = figure();
ax = axes(); ax.Parent = fig;
scatter(3, 4, 'filled')
text(3, 4, '(3,4)', FontSize=11)
axis([-3, 9, -2, 10])
xlabel('x', Interpreter=Interpreter), ylabel('y', Interpreter=Interpreter)
title('$(x-3)^2+(y-4)^2=5^2$', Interpreter=Interpreter)
set(gca, 'PlotBoxAspectRatio', [1 1 1])

h = animatedline(LineWidth=1.5, Color='r');  h.Parent = ax;

for i = 1: numPoints
    addpoints(h, x(i), y(i))
    drawnow
    exportgraphics(gcf, gifFile, 'Append',true);
end
```

同理，只需要改变 $\theta$ 的取值范围就可以圆绘制的“方向”：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/Circle2.gif?raw=true" alt="Circle2" style="zoom:50%;" />

```matlab
......
theta = linspace(pi, -pi, numPoints);
......
```

进一步地，根据圆的参数方程，可以很简单地通过循环来绘制圆上等间隔分布的点与圆心之间的连接线：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/Circle3.gif?raw=true" alt="Circle3" style="zoom:50%;" />

```matlab
% Plot circle function (x-3)^2+(y-4)^2 = 5^2, 
% and link between the center of the circle and the pionts equally spaced on a circle
clc, clear, close all

Interpreter = 'latex';
gifFile = 'Circle3.gif';
if exist(gifFile, 'file')
    delete(gifFile)
end

r = 5;
a = 3;
b = 4;
theta = linspace(0, 2*pi, 1000);
x = r*cos(theta)+a;
y = r*sin(theta) +b;

fig = figure();
ax = axes(); ax.Parent = fig;
scatter(3, 4, 'filled'), hold on
plot(x, y, LineWidth=1.5, Color='k', LineStyle='--'), hold on
text(3, 4, '(3,4)', FontSize=11)
axis([-3, 9, -2, 10])
xlabel('x', Interpreter=Interpreter), ylabel('y', Interpreter=Interpreter)
title('$(x-3)^2+(y-4)^2=5^2$', Interpreter=Interpreter)
set(gca, 'PlotBoxAspectRatio', [1 1 1])

interval = pi/6;
numPoints = 10;
for k = 0 : interval : 2*pi - interval
    xk = r*cos(k) + a;
    yk = r*sin(k) +b;
    m = linspace(xk, a, numPoints);
    n = (yk-b)/(xk-a) * (m-a) + b;
    fig = PlotLink(fig, m, n, numPoints, gifFile);
end

function fig = PlotLink(fig, m, n, numPoints, gifFile)
h = animatedline(LineWidth=1.5, Color='r');  h.Parent = fig.Children(1);
for i = 1: numPoints
    addpoints(h, m(i), n(i))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end
end
```

⚠️⚠️⚠️**注意**：上述代码虽然能够运行，但是却有不合理的地方，即`for`循环中的

```matlab
......
n = (yk-b)/(xk-a) * (m-a) + b;
......
```

从解析上看，当变量 $k$ 取 3 和 9 （即弧度为 $\pi/2$ 和 $3\pi/2$ 时），$xk-a=0$，即此时圆上的点刚好位于圆心的正上方和正下方，此时斜率 $(yk-b)/(xk-a)$ 的取值是 $\infty$ ，理论上代码应当报错；但是计算机在计算的时候，$xk$ 和 $a$ 之间始终有个很小的误差，如果我们输出 $k$ 取 3 时 $xk-a$ 和 $(yk-b)/(xk-a)$ 的值，可以看到：

```matlab
>> xk-a
ans =
   4.4409e-16
>> (yk-b)/(xk-a)
ans =
   1.1259e+16
```

在圆心正上方和正下方的点表现得和其他点没有什么不同，只是这条连接线的斜率非常非常大，这也是代码没有报错的原因。但是这在动图上仍有所表现：如果仔细观察上面的动图， 可以看到两条垂直连接线的绘制表现出明显的“顿挫感”，这正是计算量过大所导致的。

因此，在实际编写代码时需要对上述情况加以考虑，需要在循环中分类讨论：

```matlab
......
epsilon = 1e-13;
for k = 0 : interval : 2*pi - interval
    xk = r*cos(k) + a;
    yk = r*sin(k) +b;
    if abs(xk - a) <= epsilon
        n = linspace(yk, b, numPoints);
        m = a*ones(1, numel(n));
    elseif abs(xk - a) > epsilon
        m = linspace(xk, a, numPoints);
        n = (yk-b)/(xk-a) * (m-a) + b;
    end
    fig = PlotLink(fig, m, n, numPoints, gifFile);
end
......
```

这时所绘制动图中的垂直连接线就与其他连接线一样顺滑：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/Circle4.gif?raw=true" alt="Circle4" style="zoom:50%;" />

完整代码如下：

```matlab
% Plot circle function (x-3)^2+(y-4)^2 = 5^2, 
% and link between the center of the circle and the pionts equally spaced on a circle
clc, clear, close all

Interpreter = 'latex';
gifFile = 'Circle4.gif';
if exist(gifFile, 'file')
    delete(gifFile)
end

r = 5;
a = 3;
b = 4;
theta = linspace(0, 2*pi, 1000);
x = r*cos(theta)+a;
y = r*sin(theta) +b;

fig = figure();
ax = axes(); ax.Parent = fig;
scatter(3, 4, 'filled'), hold on
plot(x, y, LineWidth=1.5, Color='k', LineStyle='--'), hold on
text(3, 4, '(3,4)', FontSize=11)
axis([-3, 9, -2, 10])
xlabel('x', Interpreter=Interpreter), ylabel('y', Interpreter=Interpreter)
title('$(x-3)^2+(y-4)^2=5^2$', Interpreter=Interpreter)
set(gca, 'PlotBoxAspectRatio', [1 1 1])

interval = pi/6;
numPoints = 10;
epsilon = 1e-13;
for k = 0 : interval : 2*pi - interval
    xk = r*cos(k) + a;
    yk = r*sin(k) +b;
    if abs(xk - a) <= epsilon
        n = linspace(yk, b, numPoints);
        m = a*ones(1, numel(n));
    elseif abs(xk - a) > epsilon
        m = linspace(xk, a, numPoints);
        n = (yk-b)/(xk-a) * (m-a) + b;
    end
    fig = PlotLink(fig, m, n, numPoints, gifFile);
end

function fig = PlotLink(fig, m, n, numPoints, gifFile)
h = animatedline(LineWidth=1.5, Color='r');  h.Parent = fig.Children(1);
for i = 1: numPoints
    addpoints(h, m(i), n(i))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end
end
```

<br>

