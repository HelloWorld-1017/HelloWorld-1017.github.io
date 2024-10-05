---
title: Saddle Surface and Saddle Point
categories: 
 - Mathematics
 - Machine Learning
 - MATLAB
tags:
 - Optimization
 - MATLAB Graphics
 - Geometry
date: 2023-04-08 16:13:11 +0800
last_modified_at: 2023-04-08 16:13:11 +0800
---

# Saddle Surface

马鞍面是一种双曲抛物面（[hyperbolic paraboloid](https://en.wikipedia.org/wiki/Paraboloid#Hyperbolic_paraboloid)），其方程为：

$$
z(x,y) = x^2-y^2\label{SaddleSurface}
$$

是一种特殊的非凸也非凹的曲面 [1]，它的图像如下所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230407225340939.png?raw=true" alt="image-20230407225340939" style="zoom:50%;" />

注：绘图脚本见文末附录A。
{: .notice--primary}

**马鞍面可以看作是*“顶点在曲线上的抛物线挂在抛物线上移动形成的”*** [2]。例如，固定住上图中上方的抛物线（蓝色曲线：$z=x^2+y^2,\ y=0$），移动下方的抛物线（红色曲线），可以形成一个马鞍面：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230408153520466.png?raw=true" alt="image-20230408153520466" style="zoom:50%;" />

注：绘图脚本见文末附录B。
{: .notice--primary}

同样地，也可以看作是固定下方的抛物线（红色曲线，$z=x^2+y^2,\ x=0$），移动上方的抛物线（蓝色曲线），形成一个马鞍面：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230408153746354.png?raw=true" alt="image-20230408153746354" style="zoom:50%;" />

注：绘图脚本见文末附录C。
{: .notice--primary}

以及综合上述两种视角得到的图像：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230408154007028.png?raw=true" alt="image-20230408154007028" style="zoom:50%;" />

注：绘图脚本见文末附录D。
{: .notice--primary}

<br>

# Saddle Point

对于这样一个马鞍面，它有一个很特殊的点$(0,0,0)$，被称为鞍点（[Saddle point](https://en.wikipedia.org/wiki/Saddle_point)）。鞍点也被称作**minimax point**（这一称呼在机器学习领域也比较常用）；在鞍点处，方程在正交方向的斜率（导数）都是零，即是一个驻点（critical point），但是它并不是函数的局部极值。（*... where the slopes (derivatives) in **orthogonal directions** are all zero (a **critical point**), but which is **not** a **local extremum** of the function*）。

鞍点的一个典型的情况是：鞍点的一个例子是当存在一个驻点时，该驻点沿着一个轴向方向（峰值之间）具有相对最小值，并且沿着交叉轴具有相对最大值（An example of a saddle point is when there is a critical point with a relative minimum along one axial direction (between peaks) and at a relative maximum along the crossing axis.）。马鞍面的鞍点就是这样的情况。我们对函数$\eqref{SaddleSurface}$分别对$x$分量和$y$分量求导，可以得到：

$$
\begin{split}
&z'_x=2x\\
&z'_y=-2y
\end{split}
$$

易分析出(0,0)是一个驻点，并且函数在$x$方向上先减小后增大，$(0,0,0)$是$x$方向上的极小值；而函数在$y$方向上先增大后减小，$(0,0,0)$是$y$方向的极大值。

简单地讲，**驻点并不一定是极值点，马鞍面的鞍点就是一个非常典型的例子**。

注：极值点也不一定数驻点。例如对于函数$y=\vert x\vert$而言，它的极值点就不是驻点，因为在其极值点处不可导。
{: .notice--warning}

从图像上我们可以很容易地看出$(0,0,0)$并不是一个极值点，而且在数学上，我们也可以通过二元函数极值点的充分条件判断出这个它不是极值点 [4], [5]。但是对于利用梯度信息进行优化的优化算法而言，它们是无法判断出这一点的。例如，我们在博客 [6] 中提到过，在深度学习领域，人们通常GD算法来解决损失函数的优化问题；如果损失函数关于权重的函数是类似于一个马鞍面的函数，那么当损失值优化到鞍点时，GD算法会因为梯度消失而认为鞍点处就是最优值（或者是局部最优值）而停止优化。这显然是不合理的。因此，鞍点问题，或者是梯度消失的问题，是神经网络训练中着重关注的一个问题。

<br>

# Appendix

## Appendix A

```matlab
clc,clear,close all

figure('Units','pixels','Position',[717.67,170.33,1364.67,953.33])
tiledlayout(2,2,'TileSpacing','compact')

% 3-D view
nexttile
view(3)
helperPlotSaddle

% z-y plane
nexttile
view(90,0)
helperPlotSaddle

% z-x plane
nexttile
view(180,0)
helperPlotSaddle

% y-x plane
nexttile
view(2)
helperPlotSaddle


function helperPlotSaddle
x = -7:0.2:7;
y = -7:0.2:7;
func = @(x,y) x.^2-y.^2;
[X,Y] = meshgrid(x,y);
Z = func(X,Y);

box(gca,"on")
grid(gca,"on")
hold(gca,"on")

LineWidth = 3;
% Plot saddle surface
surf(X,Y,Z,...
    'DisplayName','Saddle surface',...
    'FaceAlpha',0.5,'EdgeColor','none');

% Plot z = x^2-y^2, x=0
x0 = zeros(1,numel(y));
plot3(x0,y,func(x0,y), ...
    'LineWidth',LineWidth,'Color','r', ...
    'DisplayName','$z = x^2-y^2, x=0$')

% Plot z = x^2-y^2, y=0
y0 = zeros(1,numel(x));
plot3(x,y0,func(x,y0), ...
    'LineWidth',LineWidth,'Color','b',...
    'DisplayName','$z = x^2-y^2, y=0$')

% Plog saddle point
scatter3(0,0,func(0,0),200, ...
    'filled','MarkerFaceColor','k',...
    'DisplayName','Saddle point','Marker','hexagram');
legend('Interpreter','latex','Location','best')

xlim([-7,7])
ylim([-7,7])
colorbar

set(gca,'FontSize',13)
title("Saddle surface")
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
zlabel("$z$","Interpreter","latex")
end
```

## Appendix B

```matlab
clc,clear,close all

figure('Units','pixels','Position',[717.67,170.33,1364.67,953.33])
tiledlayout(2,2,'TileSpacing','compact')

% 3-D view
nexttile
view(3)
helperPlotSaddle

% z-y plane
nexttile
view(90,0)
helperPlotSaddle

% z-x plane
nexttile
view(180,0)
helperPlotSaddle

% y-x plane
nexttile
view(2)
helperPlotSaddle

function helperPlotSaddle
x = -7:0.2:7;
y = -7:0.2:7;
func = @(x,y) x.^2-y.^2;
[X,Y] = meshgrid(x,y);
Z = func(X,Y);


box(gca,"on")
grid(gca,"on")
hold(gca,"on")

LineWidth = 1.5;
% Plot saddle surface
surf(X,Y,Z,...
    'DisplayName','Saddle surface',...
    'FaceAlpha',0.5,'EdgeColor','none');

% Plot z = x^2-y^2, y=0
y0 = zeros(1,numel(x));
plot3(x,y0,func(x,y0), ...
    'LineWidth',LineWidth,'Color','b',...
    'DisplayName','$z = x^2-y^2, y=0$')

for i = -7:1:7
    x0 = i*ones(1,numel(y));
    plot3(x0,y,func(x0,y), ...
        'LineWidth',LineWidth,'Color','r',...
        "handlevisibility", 'off')
end

% Plog saddle point
scatter3(0,0,func(0,0),200, ...
    'filled','MarkerFaceColor','k',...
    'DisplayName','Saddle point','Marker','hexagram');
legend('Interpreter','latex','Location','best')

xlim([-7,7])
ylim([-7,7])
colorbar

set(gca,'FontSize',13)
title("Saddle surface")
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
zlabel("$z$","Interpreter","latex")
end
```

## Appendix C

```matlab
clc,clear,close all

figure('Units','pixels','Position',[717.67,170.33,1364.67,953.33])
tiledlayout(2,2,'TileSpacing','compact')

% 3-D view
nexttile
view(3)
helperPlotSaddle

% z-y plane
nexttile
view(90,0)
helperPlotSaddle

% z-x plane
nexttile
view(180,0)
helperPlotSaddle

% y-x plane
nexttile
view(2)
helperPlotSaddle

function helperPlotSaddle
x = -7:0.2:7;
y = -7:0.2:7;
func = @(x,y) x.^2-y.^2;
[X,Y] = meshgrid(x,y);
Z = func(X,Y);

box(gca,"on")
grid(gca,"on")
hold(gca,"on")

LineWidth = 1.5;
% Plot saddle surface
surf(X,Y,Z,...
    'DisplayName','Saddle surface',...
    'FaceAlpha',0.5,'EdgeColor','none');

% Plot z = x^2-y^2, x=0
x0 = zeros(1,numel(y));
plot3(x0,y,func(x0,y), ...
    'LineWidth',LineWidth,'Color','r',...
    'DisplayName','$z = x^2-y^2, x=0$')

for i = -7:1:7
    y0 = i*ones(1,numel(x));
    plot3(x,y0,func(x,y0), ...
        'LineWidth',LineWidth,'Color','b',...
        "handlevisibility", 'off')
end

% Plog saddle point
scatter3(0,0,func(0,0),200, ...
    'filled','MarkerFaceColor','k',...
    'DisplayName','Saddle point','Marker','hexagram');
legend('Interpreter','latex','Location','best')

xlim([-7,7])
ylim([-7,7])
colorbar

set(gca,'FontSize',13)
title("Saddle surface")
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
zlabel("$z$","Interpreter","latex")
end
```

## Appendix D

```matlab
clc,clear,close all

figure('Units','pixels','Position',[717.67,170.33,1364.67,953.33])
tiledlayout(2,2,'TileSpacing','compact')

% 3-D view
nexttile
view(3)
helperPlotSaddle

% z-y plane
nexttile
view(90,0)
helperPlotSaddle

% z-x plane
nexttile
view(180,0)
helperPlotSaddle

% y-x plane
nexttile
view(2)
helperPlotSaddle


function helperPlotSaddle
x = -7:0.2:7;
y = -7:0.2:7;
func = @(x,y) x.^2-y.^2;
[X,Y] = meshgrid(x,y);
Z = func(X,Y);

box(gca,"on")
grid(gca,"on")
hold(gca,"on")

LineWidth = 1.5;
% Plot saddle surface
surf(X,Y,Z,...
    'DisplayName','Saddle surface',...
    'FaceAlpha',0.5,'EdgeColor','none');

for i = -7:1:7
    x0 = i*ones(1,numel(y));
    plot3(x0,y,func(x0,y), ...
        'LineWidth',LineWidth,'Color','r',...
        "handlevisibility", 'off')
end

for i = -7:1:7
    y0 = i*ones(1,numel(x));
    plot3(x,y0,func(x,y0), ...
        'LineWidth',LineWidth,'Color','b',...
        "handlevisibility", 'off')
end

% Plog saddle point
scatter3(0,0,func(0,0),200, ...
    'filled','MarkerFaceColor','k',...
    'DisplayName','Saddle point','Marker','hexagram');
legend('Interpreter','latex','Location','best')

xlim([-7,7])
ylim([-7,7])
colorbar

set(gca,'FontSize',13)
title("Saddle surface")
xlabel("$x$","Interpreter","latex")
ylabel("$y$","Interpreter","latex")
zlabel("$z$","Interpreter","latex")
end
```



<br>

**References**

[1] [马鞍面中心是凹面还是凸面，凹面和凸面又是怎样定义的呢？ - 知乎](https://www.zhihu.com/question/493026073#:~:text=马鞍面：是一种特殊的非凸也非凹的曲面，表达式为 f (x%2Cy)%3Dfrac {x^2},{a^2}-frac {y^2} {b^2}\ 存在微分为0且不是极值的点。 鞍点：微分为0的非极值点。).

[2] [马鞍面的方程是什么? - 郑剑锋的回答 - 知乎](https://www.zhihu.com/question/22067463/answer/128409415) 

[3] [Saddle point - Wikipedia](https://en.wikipedia.org/wiki/Saddle_point).

[4] [两种方法证明二元函数极值取得的充分性 - 知乎](https://zhuanlan.zhihu.com/p/362415195).

[5] [Extrema of functions of two variables: necessary and sufficient conditions - Mathematics Stack Exchange](https://math.stackexchange.com/questions/1280588/extrema-of-functions-of-two-variables-necessary-and-sufficient-conditions).

[6] [Simple Gradient Descend (GD) and Stochastic Gradient Descend (SGD) Methods Selecting Optimum Weight of Linear Model](http://whatastarrynight.com/machine learning/operation research/python/Simple-Gradient-Descend-(GD)-and-Stochastic-Gradient-Descend-(SGD)-Methods-Selecting-Optimum-Weight-of-Linear-Model/#local-minimum-and-saddle-point).
