---
title: Bernstein Polynomial and Bézier Curve
categories: 
 - Mathematics
 - MATLAB
tags:
 - MATLAB Animation
 - MATLAB Graphics
 - Numerical Analysis
date: 2022-11-19 13:26:23 +0800
last_modified_at: 2025-05-02 17:57:20 +0800
---

# Bernstein polynomial

## Introduction

在数值分析领域，Bernstein polynomial是Bernstein基多项式(Bernstein basis polynomials)的线性组合，该多项式以[Sergei Natanovich Bernstein](https://en.wikipedia.org/wiki/Sergei_Bernstein)(1880-1968)命名。一种计算多项式Bernstein形式的数值稳定(numerical stable)的算法是使用[de Casteljau's algorith](https://en.wikipedia.org/wiki/De_Casteljau%27s_algorithm)。

Bernstein首先使用Bernstein形式的多项式，用于对斯通-魏尔施特拉斯逼近定理([Stone–Weierstrass theorem - Wikipedia](https://en.wikipedia.org/wiki/Stone%E2%80%93Weierstrass_theorem))的构造性证明中。随着计算机图形学的出现，在[0, 1]区间的Bernstein多项式，即[Bézier curves](https://en.wikipedia.org/wiki/B%C3%A9zier_curve)曲线形式变得更加重要。

## Definition

具有$n$个自由度的$n+1$阶Bernstein基多项式定义为：

$$
b_{\nu,n}(x)=\binom{n}{\nu}x^\nu(1-x)^{n-\nu},\ \nu=0,\cdots,n
$$

其中，$\binom{n}{\nu}$是二项式系数。例如，$b_{2,5}(x)=\binom{5}{\nu}x^2(1-x)^3=10x^2(1-x)^3$。

前几个Bernstein基多项式为：

$$
\begin{split}
&b_{0, 0}(x)=1, & &\\
&b_{0, 1}(x)=1-x,\ b_{1,1}(x)=x\\
&b_{0, 2}(x)=(1-x)^2,\ b_{1,2}(x)=2x(1-x),\ b_{2,2}=x^2\\
&b_{0,3}(x)=(1-x)^3,\ b_{1,3}=3x(1-x)^2,\ b_{2,3}(x)=3x^2(1-x), b_{3,3}(x)=x^3
\end{split}
$$

$n$个自由度的Bernstein基多项式构成了向量空间$\Pi_n$中的一组基，该向量空间最多为$n$次，并且具有实系数。

Bernstein基多项式的线性组合为：

$$
B_n(x)=\sum_{\nu=0}^n\beta_\nu b_{v, n}(x)
$$

$B_n(x)$称为自由度为$n$的Bernstein polynomial(AKA *polynomial in Bernstein form*)。系数$\beta_\nu$被称为Bernstein coefficients或者Bézier coefficients。

## `bernstein` function in MATLAB

### Example using `bernstein` function 

MATLAB提供了关于Bernstein多项式拟合的函数`bernstein`：[bernstein - MathWorks](https://ww2.mathworks.cn/help/symbolic/bernstein.html). 比如下面的例子就使用自由度分别为2、10和100的Bernstein多项式拟合了函数$\sin(2\pi t)$：

```matlab
clc, clear, close all

LineWidth = 1.5;
syms t

b3 = bernstein(@(t) sin(2*pi*t), 3, t);
b10 = bernstein(@(t) sin(2*pi*t), 10, t);
b100 = bernstein(@(t) sin(2*pi*t), 100, t);

hold(gca, "on")
grid(gca, "on")
box(gca, "on")
fplot(sin(2*pi*t), [0,1], LineWidth=LineWidth)
fplot(b3, [0, 1], LineWidth=LineWidth)
fplot(b10, [0,1], LineWidth=LineWidth)
fplot(b100, [0,1], LineWidth=LineWidth)
legend('sine function', ...
    '2th-degree polynomial',...
    '10th-degree polynomial',...
    '100th-degree polynomial')
title('Bernstein polynomials')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221118141900347.png?raw=true" alt="image-20221118141900347" style="zoom:50%;" />

其中：

```matlab
>> b3, b10
b3 =
(3*3^(1/2)*t*(t - 1)^2)/2 + (3*3^(1/2)*t^2*(t - 1))/2

b10 =
(105*2^(1/2)*t^4*(5 - 5^(1/2))^(1/2)*(t - 1)^6)/2 - (105*2^(1/2)*t^6*(5 - 5^(1/2))^(1/2)*(t - 1)^4)/2 - (5*2^(1/2)*t*(5 - 5^(1/2))^(1/2)*(t - 1)^9)/2 + (5*2^(1/2)*t^9*(5 - 5^(1/2))^(1/2)*(t - 1))/2 + (45*2^(1/2)*t^2*(5^(1/2) + 5)^(1/2)*(t - 1)^8)/4 - 30*2^(1/2)*t^3*(5^(1/2) + 5)^(1/2)*(t - 1)^7 + 30*2^(1/2)*t^7*(5^(1/2) + 5)^(1/2)*(t - 1)^3 - (45*2^(1/2)*t^8*(5^(1/2) + 5)^(1/2)*(t - 1)^2)/4
```

MATLAB给出了拟合函数的闭式解(`b100`同样是类似的形式，只是表达式太长，此处从略)。

### Two different `bernstein.m` in MATLAB

我想看一下`bernstein`源代码的内容，但是遇到了一些问题。

在命令行中输入`open bernstein`时，MATLAB打开的是`C:\Program Files\MATLAB\R2022a\toolbox\symbolic\symbolic\bernstein.m`文件：

```matlab
% C:\Program Files\MATLAB\R2022a\toolbox\symbolic\symbolic\bernstein.m
function b = bernstein(f, varargin)

...

% ------------------------------
% Do the de Casteljau algorithm:
% ------------------------------
for j = 1:n
f(1:n-j+1) = (1-x).*f(1:n-j+1) + x.*f(2:n-j+2);
end
b = f(1);
end
```

可以看到，除去前面的注释和对于输入参数的解析和判断以外，最重要的部分实际上就是Wikipedia中提到的[de Casteljau's algorith](https://en.wikipedia.org/wiki/De_Casteljau%27s_algorithm)，这个算法的目的就是为了求解Bernstein系数。

但是，代码在实际运行的时候，调用的是另一个文件`C:\Program Files\MATLAB\R2022a\toolbox\symbolic\symbolic\@sym\bernstein.m`：

```matlab
% C:\Program Files\MATLAB\R2022a\toolbox\symbolic\symbolic\@sym\bernstein.m
function b = bernstein(f, varargin)

...

%----------------
% replace symfuns
%----------------
issymfun = isa(f, 'symfun');
if issymfun 
fargs = argnames(f);   
% Eliminate var from the arguments of the symfun
fargs = privsubsref(fargs, logical(fargs ~= var));
f = formula(f);     
if ~isscalar(f)  
error(message('symbolic:sym:bernstein:ExpectingScalar1'));
end
end

if isempty(var)
b = mupadmex('bernstein', f.s, n.s, x.s);
else
b = mupadmex('bernstein', f.s, var.s, n.s, x.s);
end
% -------------------------
% re-vitalize symfuns
% -------------------------
if issymfun && ~isempty(fargs)
b = symfun(b, fargs);
end
```

这个函数是基于符号函数进行计算的，应该也是基于de Casteljau's算法，只是有些看不懂

个人认为，这两个代码：

- `C:\Program Files\MATLAB\R2022a\toolbox\symbolic\symbolic\bernstein.m`，主要是进行没有显示表达式的曲线拟合；
- `C:\Program Files\MATLAB\R2022a\toolbox\symbolic\symbolic\@sym\bernstein.m`，该文件位于`@sym`文件夹下，主要是拟合具有显示表达式的情况，基于符号函数进行计算。

但是官方给出的四个示例，并没有给出关于前一种的示例，都是拟合的曲线都是基于符号进行的，分别是：

```matlab
% Example 1: Approximation of Sine Function Specified as Function Handle
syms t
b10 = bernstein(@(t) sin(2*pi*t), 10, t);

% Example 2: Approximation of Exponential Function Specified as Symbolic Expression
syms x t
bernstein(exp(x), 2, t)

% Example 3: Approximation of Linear Ramp Specified as Symbolic Function
syms f(t)
f(t) = triangularPulse(1/4, 3/4, Inf, t);
p = bernstein(f, 5, t)

% Example 4: Numerical Stability of Simplified Bernstein Polynomials
f = @(x)rectangularPulse(1/4,3/4,x);
```

在计算机中进行数值计算，一定是以第一种方式为基础的，后一种基于符号函数的方式可能是为了让用户使用的时候比较方便；另一方面，在实践中，很多时候我们是不知道我们所要拟合曲线的显式表达式的。所以，理解好前一段代码，即de Casteljau's算法是很重要的。

<br>

# Bézier curve

## Definition

Bernstein多项式是Bézier curve的数学基础。Bézier curve是由P. de Casteljau和Bézier分别于1959年和1962年独立提出并发展出。

类似于Bernstein多项式，Bézier curve可以定义为：

$$
C(t)=\sum_{i=0}^n b_{i,n}(t)P_i\label{B1}
$$

其中$b_{i,j}$表示使用二项式系数所表示的Bernstein多项式：

$$
b_{i,n}(t)=\binom{n}{i}t^i(1-t)^{n-i}\label{B2}
$$

其中，$0\le t\le1$；$P_i$表示Bézier curve的控制点，控制点$P_0$到$P_n$依次连接起来可以构成一个多边形(polygons)，Bézier curve的阶数等于控制点的个数减1。

以二阶Bézier curve为例，二阶Bézier curve可以通过递归的方式进行计算：

$$
B(t)=(1-t)[(1-t)P_0+tP_1]+t[(1-t)P_1+tP_2],\ 0\le t\le1\notag
$$

将上式展开：

$$
B(t)=(1-t)^2P_0+2(1-t)tP_1+t^2P_2,\ 0\le t\le1\label{eq1}
$$

同样地，三阶Bézier curve也可以使用相同的递归方式列写出：

$$
\begin{split}
B(t)=&(1-t)\Big[(1-t)\Big((1-t)P_0+tP_1\Big)+t\Big((1-t)P_1+tP_2\Big)\Big]\\
=&t\Big[(1-t)\Big((1-t)P_1+tP_2\Big)+t\Big((1-t)P_2+tP_3\Big)\Big]\\
\end{split}\notag
$$

可以化简为：

$$
B(t)=(1-t)^3P_0+3t(1-t)^2P_1+3t^2(1-t)P_2+t^3P_3\label{eq2}
$$

可以验证，式$\eqref{eq1}$和式$\eqref{eq2}$实际上就满足式$\eqref{B1}$和式$\eqref{B2}$的计算式。

## Plot Bézier curve in MATLAB

我们可以在MATLAB中验证上面的方法，即Bézier curve的递归形式和简化形式的一致性。

注：在下面的代码中，我为了实现方便，没有编写一个通用的代码，只是针对二阶情况和三阶情况进行了编写。在编写时，参考了Aiya的工作：[Bezier Curve Plotter - MATLAB File Exchange](https://ww2.mathworks.cn/matlabcentral/fileexchange/30759-bezier-curve-plotter?s_tid=srchtitle_Bezier%20Curve%20Plotter_1)。
{: .notice--warning}

### Second Order

三个控制点的二阶Bézier curve：

```matlab
clc, clear, close all

% The number of control points
n = 3; 

% Points
P1 = [1, 1]';
P2 = [2, 1]';
P3 = [3, 3]';
P = [P1, P2, P3];

figure
LineWidth = 1.5;
colors = [7, 84, 213;
    249, 82, 107;
    167, 51, 58]/255;
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
axis(gca, "equal")

% Draw the characteristic polygon describing the bezier curve
for idx = 2:n
    p1 = P(:,idx-1);
    p2 = P(:,idx);
    x_coordinate = [p1(1), p2(1)];
    y_coordinate = [p1(2), p2(2)];
    plot(x_coordinate, y_coordinate, '--r', LineWidth=LineWidth, Color=colors(1, :))
end
scatter(P(1, :), P(2, :), "filled", MarkerEdgeColor=colors(1, :), MarkerFaceColor=colors(1, :))


% Calculte and plot movement process
points = 0:1/100:1;
values = zeros(2, numel(points));
Values = cell(n*(n-1)/2, numel(points));
for t = 1:numel(points)
    % Directly calculate 
    values(:, t) = (1-points(t))^2.*P1+2*(1-points(t))*points(t).*P2+points(t)^2.*P3;

    % Recursively calculate 
    for i = 2:n
        p1 = P(:,i-1);
        p2 = P(:, i);
        Values{i-1, t} = firstOrderfcn(points(t), p1, p2);
    end
    for i = 1:n-2
        Values{3, t} = firstOrderfcn(points(t), Values{1, t}, Values{2, t});
    end
end

% Directly calculate
plot(values(1,:), values(2, :), Color=colors(3, :), LineWidth=LineWidth)

% Recursively calculte
for t = 1:numel(points)
    h = plot([Values{1,t}(1), Values{2,t}(1)], ...
        [Values{1,t}(2), Values{2,t}(2)], ...
        LineWidth=1, LineStyle="-", Color=colors(2, :), Marker=".");
    s = scatter(Values{3, t}(1), Values{3, t}(2), 20, 'ro', "filled");
    exportgraphics(gcf, 'gif1.gif', 'Append', true);
    h.Visible = "off";
    s.Visible = "off";
end

function P_out = firstOrderfcn(t, P0, P1)
P_out = (1-t).*P0 + t.*P1;
end
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/gif1.gif?raw=true" alt="gif1" style="zoom: 67%;" />



### Third Order

四个控制点的三阶Bézier curve：

```matlab
clc, clear, close all

% The number of control points
n = 4; 

% 4 control points
P1 = [1, 1]';
P2 = [2, 0]';
P3 = [3, 4]';
P4 = [5, 2]';
P = [P1, P2, P3, P4];

figure
LineWidth = 1.5;
colors = [7, 84, 213;
    249, 82, 107;
    167, 51, 58]/255;
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
axis(gca, "equal")

% Draw the characteristic polygon describing the bezier curve
for idx = 2:n
    p1 = P(:, idx-1);
    p2 = P(:, idx);
    x_coordinate = [p1(1), p2(1)];
    y_coordinate = [p1(2), p2(2)];
    plot(x_coordinate, y_coordinate, '--r', LineWidth=LineWidth, Color=colors(1, :))
end
scatter(P(1, :), P(2, :), "filled", MarkerEdgeColor=colors(1, :), MarkerFaceColor=colors(1, :))

points = 0:1/100:1;

% Recursive calculate and plot
values = zeros(2, numel(points));
Values = cell(n*(n-1)/2, numel(points));
for t = 1:numel(points)
    % Directly calculate
    values(:, t) = (1-points(t))^3*P1+3*(1-points(t))^2*points(t).*P2+ ...
        3*(1-points(t))*points(t)^2.*P3+ points(t)^3.*P4;

    % Recursively calculate
    for i = 2:n
        p1 = P(:, i-1);
        p2 = P(:, i);
        Values{i-1, t} = firstOrderfcn(points(t), p1, p2);
    end
    for i = 2:n-1
        p1 = Values{i-1, t};
        p2 = Values{i, t};
        Values{i+2, t} = firstOrderfcn(points(t), p1, p2);
    end
    for i = n
        p1 = Values{i, t};
        p2 = Values{i+1, t};
        Values{i+2, t} = firstOrderfcn(points(t), p1, p2);
    end
end

% Directly calculate
plot(values(1,:), values(2, :), Color=colors(3, :), LineWidth=LineWidth)

% Recursively calculte
for t = 1:numel(points)
    h1 = plot([Values{1,t}(1), Values{2,t}(1)], ...
        [Values{1,t}(2), Values{2,t}(2)], ...
        LineWidth=1.5, LineStyle="-", Color=colors(2, :));
    h2 = plot([Values{2,t}(1), Values{3,t}(1)], ...
        [Values{2,t}(2), Values{3,t}(2)], ...
        LineWidth=1.5, LineStyle="-", Color=colors(2, :));
    h3 = plot([Values{4,t}(1), Values{5,t}(1)], ...
        [Values{4,t}(2), Values{5,t}(2)], ...
        LineWidth=1.5, LineStyle="-", Color=colors(2, :));
    s1 = scatter(Values{4, t}(1), Values{4, t}(2), 20, 'ko', "filled");
    s2 = scatter(Values{5, t}(1), Values{5, t}(2), 20, 'ko', "filled");
    s3 = scatter(Values{6, t}(1), Values{6, t}(2), 20, 'ko', "filled");
    exportgraphics(gcf, 'gif2.gif', 'Append', true);
    h1.Visible = "off";
    h2.Visible = "off";
    h3.Visible = "off";
    s1.Visible = "off";
    s2.Visible = "off";
    s3.Visible = "off";
end

function P_out = firstOrderfcn(t, P0, P1)
P_out = (1-t).*P0 + t.*P1;
end
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/gif2.gif?raw=true" alt="gif2" style="zoom:67%;" />

<br>

**Reference**

[1] [Bernstein polynomial - Wikipedia](https://en.wikipedia.org/wiki/Bernstein_polynomial).

[2] [De Casteljau's algorithm - Wikipedia](https://en.wikipedia.org/wiki/De_Casteljau's_algorithm).

[3] [bernstein - MathWorks](https://ww2.mathworks.cn/help/symbolic/bernstein.html)

[4] [Bezier Curve Plotter - MATLAB File Exchange](https://ww2.mathworks.cn/matlabcentral/fileexchange/30759-bezier-curve-plotter?s_tid=srchtitle_Bezier%20Curve%20Plotter_1)

[5] [https://tomrocksmaths.files.wordpress.com/2021/05/de-casteljaus-algorithm.pdf](https://tomrocksmaths.files.wordpress.com/2021/05/de-casteljaus-algorithm.pdf)

[6] [Bezier curve - JavaScript](https://javascript.info/bezier-curve).

