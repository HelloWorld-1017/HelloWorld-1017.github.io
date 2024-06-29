---
layout: single
title: Preliminary Exploration of Complex Variable Functions
date: 2022-07-18 22:53:33 +0800
categories: 
 - Mathematics
tags: 
 - Complex Analysis
 - MATLAB Animation
last_modified_at: 2023-11-14 14:07:29 +0800
---

> 迄今为止，虚数这个引发许多纠缠不清的问题，在很大程度上可以认为是不恰当的记法系统导致的。比如，如果把 $+1$、$-1$、$\sqrt{-1}$ 称为正、逆和侧的单位，而不是正、负、虚（甚至不可能）的单位，就不有这样的麻烦了。
>
> ——高斯

# 非负数到实数到复数


正如负数的提出是为了求出 $a$ 为正数时线性方程 $x+a=0$ 的解一样，虚数的提出是为求 $a$ 为正数时二次方程 $x^2+a=0$ 的解。特别的，就像负数单位 $-1$ 被定义为方程 $x+1=0$ 的解，虚数单位 $\sqrt{-1}$ 被定义为方程 $x^2+1=0$ 的一个解（另一个为$-\sqrt{-1}$）。另一方面，要解方程 $x^2+1=0$，就意味着要找一个平方值为 $-1$ 的数，显然没有任何一个实数满足要求。因此，正如 $x+1=0$ 在正数范围内没有解一样，$x^2+1=0$ 在实数范围内没有解。

| 方程      | 解的存在域       | 解                    |
| --------- | ---------------- | --------------------- |
| $x+1=0$   | 在正数范围内无解 | $-1$，负数单位        |
| $x^2+1=0$ | 在实数范围内无解 | $\sqrt{-1}$，虚数单位 |

对于今天的我们，上面这段话显得自然而合理，但负数和复数的引入实际上经历了漫长的历史。

古希腊人并没有正确认识到负数，因为他们的主要兴趣主要是几何，以及诸如长度、面积、体积的量，完全没有使用负数的必要。印度数学家罗摩笈多（约公元前628年）使用过负数，只不过中世纪的欧洲几乎完全忽略了它们，认为它们是“虚构的”、“荒谬的”。甚至在文艺复兴时期，还有很多数学家对负数的存在感到不自在。确实，如果将减法看作是“拿走的”的动作，负数就是荒谬的。例如，人们不能从3个苹果中拿走5个。使负数最终被接受的关键一步是由拉斐尔·邦贝利（约1530年出生）完成的，拉斐尔**将数解释为线段的长度**，而**4种基本运算则表示线段的运动**，从而给出了实数的几何解释。但只有当人们意识到**减法可以解释为加法的逆运算**的时候，才有可能完全将负数融入到我们的数字体系当中。

虚数也有类似的历史演化过程。“ $a>0$ 时，方程 $x^2+a=0$ ” 的根的求解问题从几个世纪前就推动着复数的引入，然而直到19世纪初，数学家们才坦然接受复数。

两方面的发展在很大程度上推到了复数被接受的进程。首先，在1800年左右，$x+\mathrm{i}y$ 得到了简单的几何解释。如果我们将直角坐标系的 $x$ 轴和 $y$ 轴分别解释为“实轴”和“虚轴”，那么复数 $x+\mathrm{i}y$ 在坐标系中就可以用一个点 $P(x,y)$来表示，也可以用矢量线段 $OP$ 表示，这样我们就可以按照矢量的加减运算对复数进行加减运算——只需要对复数的实部和虚部分别加减即可。

第二个发展归功于爱尔兰数学家威廉·罗文·汉密尔顿爵士（1805-1865）。1835年，他**将复数看成是遵循一定运算规则的有序数对**，从而为复数给出了纯形式的定义。他将复数定义为有序数对 $(a,b)$，其中 $a$ 和 $b$ 都是实数。两个数对 $(a,b)$ 和 $(c,d)$ 当且仅当 $a=c$ 且 $b=d$ 时才会想等。之后，他给出了这些有序数对所遵从的运算规则：

1. 数乘运算法则：对于实数 $k$，有 $k(a,b)=(ka,kb)$；
2. 加法运算法则：对于两个数对 $(a,b)$ 和 $(c,d)$ ，满足：$(a,b)+(c,d)=(a+c,b+d)$；
3. 乘法运算法则：对于两个数对 $(a,b)$ 和 $(c,d)$，满足：$(a,b)\times(c,d)=(ac-bd,ad+bc)$

根据乘法运算法则，对于数对 $(0,1)$，有：$(0,1)\times(0,1)=(0\times0-1\times1,0\times1+1\times0)=(-1,0)$。如果将数对中第二部分为0的数对直接用第一部分的字母表示，并且把它看作实数，也就是认为 $(a,0)$ 与实数 $a$ 等价，那么 $(0,1)\times(0,1)$ 的结果就是 $-1$。如果将数对 $(0,1)$ 用字母 $\mathrm{i}$ 表示，那么我们就可以得到 $\mathrm{i}\times \mathrm{i}=\mathrm{i}^2=-1$，从而对于每一个数对 $(a,b)$ 都可以写成 $(a,b)=a(1,0)+b(0,1)=a+\mathrm{i}b$，这就是常见的复数。

> 范数的定义实际上也遵循着类似的思路。

汉密尔顿爵士的严格推导标志着**公理代数**的开始：从一些简单的定义（公理）以及由这些定义所导出的逻辑结果（定理）出发，一步一步推导出结论。

> 公理法应用的经典是欧几里得在《几何原本》中对于“欧氏几何”的构建，19世纪，代数学正在效仿几何学。
>
> 顺便提一句，19世纪后期，希尔伯特对《几何原本》进行了缜密的考察，梳理了欧几里得没有指出的假设，才最终建立起一套严密的几何公理。后来，希尔伯特提倡对数学的各个分支都寻找到一套严密的公理，但是在1931年，哥德尔证明了：对于数学某些部分，不管我们写出多少条公理，总会有一些正确的陈述无法从这些公理推导出。这个定理，也被称为“哥德尔不完备定理”。

<br>

# 复变量函数$w=z^2+1$ 的根在哪里？

将复数纳入代数的范畴的同时也给分析学带来了冲击。数学家们试图将微积分的战果推广到复变量函数内。根据欧拉对于函数的定义，我们可以很容易 *从形式上* 将函数的定义直接拓展到复变量的领域，我们无须改变什么，只需要允许变量和常数为复数即可。但是从几何学的角度看，这样的一种函数无法在二维直角坐标系中画出它们对应的图形，因为每个复变量都需要对应一个二维坐标系，即一个平面。因此，**如果要从几何角度来解释这样一个函数，我们必须将其看作从一个平面到另一个平面的 *映射* 或转换**。

> 欧拉对于函数的定义：关于某变量的函数，就是任何由变量、数字或常量所构成的解析表达式。

以函数 $w=z^2$ 为例，其中 $z$ 和 $w$ 都是复变量。要从几何角度描述这个函数，我们需要两个直角坐标系统，其中一个是独立变量 $z$，另一个是独立变量 $w$。如果分别将它们分别写作

$$
\begin{align*}
z&=x+\mathrm{i}y\\
w&=u+\mathrm{i}v
\end{align*}
$$

则有

$$
w=z^2=(x+\mathrm{i}y)^2=(x^2-y^2)+\mathrm{i}(2xy)=u+\mathrm{i}v
$$

即

$$
\begin{align*}
u&=x^2-y^2\\
v&=2xy
\end{align*}
$$

假设自变量 $x$ 和 $y$ 在 $z$ 平面（即 $xy$ 平面）中符合某条曲线，这将导致变量 $u$ 和 $v$ 在 $w$ 平面（即 $uv$ 平面）中遵循某一条**象曲线**。例如，如果点 $P(x,y)$ 沿着双曲线 $x^2-y^2=c$ （其中 $c$ 是一个常数）移动，那么**象点** $Q(u,v)$ 将沿着曲线 $u=c$ （即 $w$ 平面中的一条垂线）移动；如果点 $P$ 沿着双曲线 $2xy=k$ （其中 $k$ 是一个常数）移动，那么点 $Q$ 将沿着水平线 $v=k$ 移动。最终，双曲线 $x^2-y^2=c$ 和 $2xy=k$ 在 $z$ 平面内形成了两组相似的曲线，其中每条曲线都对应着一个给定的常数，它们的象曲线在 $w$ 平面内形成了由水平线及垂线构成的矩形网格。

![Mapping1](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/Mapping1.gif)

```matlab
clc, clear, close all
warning off
delete('Mapping1.gif')
warning on

% Plot settings
LineWidth = 1.5;
Interpreter = 'latex';
numPoints = 100;

fig = figure('unit', 'centimeters', 'position', [15, 7, 29, 15]);
sgtitle('Complex Mapping: $w=z^2$', Interpreter=Interpreter)
ax1 = subplot(1, 2, 1);
ax1.Parent = fig;
axis([-7, 7, -7, 7])
xlabel('x', Interpreter=Interpreter);
ylabel('y', Interpreter=Interpreter);
title('Complex')

ax2 = subplot(1, 2, 2);
ax2.Parent = fig;
axis([-7, 7, -60, 60])
xlabel('u', Interpreter=Interpreter);
ylabel('v', Interpreter=Interpreter);
title('Mapping')

% Various constants c and k
cs = [0, 1, 3, 5];
ks = [3, 7, 11, 15];

% Plot complex variable, subject to x^2 - y^2 = c, and its mapping
for i=1:numel(cs)
    textFlag = false;
    fig = MappingPlot1(cs(i), numPoints, fig, textFlag, LineWidth, Interpreter);
end

% Plot complex variable, subject to 2xy=k, and its mapping
for i=1:numel(ks)
    if i ~= numel(ks)
        textFlag = false;
    else
        textFlag = true;
    end
    fig = MappingPlot2(ks(i), numPoints, fig, textFlag, LineWidth, Interpreter);
end


% Plot complex variable, subject to x^2 - y^2 = c, and its mapping function----------------------------
function fig = MappingPlot1(c, numPoints, fig, textFlag, LineWidth, Interpreter)
% Prepare data
% Complex variable
y = linspace(-5, 5, numPoints);
x1 = sqrt(c+y.^2); % right branch
x2 = -x1;          % left branch

% Mapping of complex variable
u1 = x1.^2 - y.^2;
v1 = 2.*x1.*y;

u2 = x2.^2 - y.^2;
v2 = 2.*x2.*y;

h1_1 = animatedline(LineWidth=LineWidth); h1_1.Parent = fig.Children(2);
h1_2 = animatedline(LineWidth=LineWidth, Color='r'); h1_2.Parent = fig.Children(2);
text1 = text(-3, 6, ['$x^2 - y^2 = c$, $c= $', num2str(c)], ...
    fontsize=13, FontWeight="bold", Interpreter=Interpreter);
text1.Parent = fig.Children(2);

h2_1 = animatedline(LineWidth=LineWidth); h2_1.Parent = fig.Children(1);
h2_2 = animatedline(LineWidth=LineWidth, Color='r'); h2_2.Parent = fig.Children(1);

% Plot the right branch
for k = 1:numPoints
    addpoints(h1_1, x1(k), y(k))
    addpoints(h2_1, u1(k), v1(k))
    drawnow
    exportgraphics(gcf,'Mapping1.gif','Append',true);
end

% Plot the left branch
for k = 1:numPoints
    addpoints(h1_2, x2(k), y(k))
    addpoints(h2_2, u2(k), v2(k))
    drawnow
    exportgraphics(gcf,'Mapping1.gif','Append',true);
end

text1.Visible = textFlag;
end

% Plot complex variable, subject to 2xy = k, and its mapping function----------------------------
function fig = MappingPlot2(k, numPoints, fig, textFlag, LineWidth, Interpreter)
% Prepare data
% Complex variable
x1 = linspace(-10, -0.1, numPoints);
x2 = linspace(0.1, 10, numPoints);
y1 = k./(2*x1);
y2 = k./(2*x2);

% Mapping of complex variable
u1 = x1.^2-y1.^2;
v1 = 2*x1.*y1;

u2= x2.^2-y2.^2;
v2 = 2*x2.*y2;

% Plot complex variable
h1_1 = animatedline(LineWidth=LineWidth);  h1_1.Parent = fig.Children(2);
h1_2 = animatedline(LineWidth=LineWidth, Color='r');  h1_2.Parent = fig.Children(2);
text1 = text(-3, 6, ['$2xy = k, k= $', num2str(k)], ...
    fontsize=13, Interpreter=Interpreter);
text1.Parent = fig.Children(2);

% Plot variable's mapping
h2_1 = animatedline(LineWidth=LineWidth); h2_1.Parent = fig.Children(1);
h2_2 = animatedline(LineWidth=LineWidth, Color='r');  h2_2.Parent = fig.Children(1);


for k = 1:numPoints
    addpoints(h1_1, x1(k), y1(k))
    addpoints(h2_1, u1(k), v1(k))
    drawnow
    exportgraphics(gcf,'Mapping1.gif','Append',true);
end


for k = 1:numPoints
    addpoints(h1_2, x2(k), y2(k))
    addpoints(h2_2, u2(k), v2(k))
    drawnow
    exportgraphics(gcf, 'Mapping1.gif', 'Append',true);
end

text1.Visible = textFlag;
end
```



因此，再看函数 $w=z^2+1$，虽然它在实数域内没有根，但是在复数域内有根。

$$
w=z^2+1=(x+\mathrm{i}y)^2+1=(x^2-y^2+1)+\mathrm{i}(2xy)\notag
$$

令 $w=0$，则有

$$
\left\{
\begin{align*}
&x^2-y^2+1=0\\
&2xy=0
\end{align*}
\right.
$$

该方程组在复数域（$xy$ 平面）内有两个根：$(0,-1)$ 和 $(0, 1)$。在 $xy$ 平面绘制出几条经过上述两个点的轨迹：$x=y^2-1$，$x=0$，$x=1-y^2$，$x^2+y^2=1$，可以看到在经过 $xy$ 平面的 $(0,-1)$ 和 $(0, 1)$ 时，复数映射都会经过 $w$ 平面的原点 $(0,0)$。

![Mapping2](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/Mapping2.gif?raw=true)

```matlab
clc, clear, close all

LineWidth = 1.5;
Interpreter = 'latex';
numPoints = 30;

fig = figure('unit', 'centimeters', 'position', [15, 7, 29, 15]);
sgtitle('Complex Mapping: $w=z^2+1$', Interpreter=Interpreter)
ax1 = subplot(1, 2, 1); ax1.Parent = fig;
scatter([0, 0], [-1, 1], 'filled')
axis([-4, 4, -5, 5])
xlabel('x', Interpreter=Interpreter);
ylabel('y', Interpreter=Interpreter);
title('Complex')

ax2 = subplot(1, 2, 2); ax2.Parent = fig;
scatter(0, 0, 'filled');
axis([-18, 10, -15, 15])
xlabel('u', Interpreter=Interpreter);
ylabel('v', Interpreter=Interpreter);
title('Mapping')

% Trajectory at x-y plain, x=y^2-1
y = linspace(-2, 2, numPoints);
x = y.^2 - 1;
fig = MappingPlot(numPoints, x, y, fig, '$x=y^2-1$', false, LineWidth, Interpreter);
% Trajectory at x-y plain, x=0
y = linspace(-4, 4, numPoints);
x = zeros(1, numel(y));
fig = MappingPlot(numPoints, x, y, fig, '$x=0$', false, LineWidth, Interpreter);
% Trajectory at x-y plain, x=1-y^2
y = linspace(-2, 2, numPoints);
x = -(y.^2 - 1);
fig = MappingPlot(numPoints, x, y, fig, '$x=1-y^2$', false , LineWidth, Interpreter, 'b');
% Trajectory at x-y plain, x^2+y^2=1
y = linspace(-1, 1, numPoints);
x = sqrt(1 - y.^2) ;
fig = MappingPlot(numPoints, x, y, fig, '$x^2+y^2=1$', false , LineWidth, Interpreter);
y = -linspace(-1, 1, numPoints);
x = -sqrt(1 - y.^2) ;
fig = MappingPlot(numPoints, x, y, fig, '$x^2+y^2=1$', true , LineWidth, Interpreter, 'g');

function fig = MappingPlot(numPoints, x, y, fig, TEXT, textFlag, LineWidth, Interpreter, c)
if(~exist('c','var'))
    c = 'r';  
end
u = x.^2 - y.^2 + 1;
v = 2*x.*y;

h1 = animatedline(LineWidth=LineWidth); h1.Parent = fig.Children(2);
h2 = animatedline(LineWidth=LineWidth, Color=c); h2.Parent = fig.Children(1);
text1 = text(-1, 4.5, TEXT , fontsize=13, Interpreter=Interpreter); text1.Parent = fig.Children(2);

for k = 1:numPoints
    addpoints(h1, x(k), y(k))
    addpoints(h2, u(k), v(k))
    drawnow
    exportgraphics(gcf,'Mapping2.gif','Append',true);
end
text1.Visible = textFlag;
end
```

<br>

# 复变量函数 $w=f(z)$ 可以进行微分计算吗？

**对于变量 $z$ 和 $w$ 都是复数的复变函数 $w=f(z)$，我们可以像对待实变量 $x$ 和 $y$ 所构成的实变函数 $y=f(x)$ 那样对其进行微分运算吗？**答案是肯定的，但需要满足一定的条件。

由上文所述，复变函数的函数实际上是一个平面到另一个平面的映射，因此我们无法像对待实变函数那样，将复变函数的求导解释为函数切线的斜率。现在，假设我们不考虑几何含义，仅仅只是从形式上对复变函数进行微分运算。在实变函数中，函数的导数可以定义为 

$$
f^{\prime}(x_0)=\lim \limits_{\Delta x\rightarrow 0}\dfrac{\Delta f(x)}{\Delta x}=\lim \limits_{\Delta x\rightarrow 0}\dfrac{f(x_0+\Delta x)-f(x_0)}{\Delta x}\notag
$$

如果我们直接将其拓展到复变函数中，可以得到：

$$
w^{\prime}(z_0)=\lim \limits_{\Delta z\rightarrow 0}\dfrac{\Delta w(z)}{\Delta z}=\lim \limits_{\Delta z\rightarrow 0}\dfrac{w(z_0+\Delta z)-f(z_0)}{\Delta z}\notag
$$

但是，极限的概念中实际上隐含着一点假设：无论变量以哪一种方式接近它的极限值，极限运算的结果是相同的。例如，对于实变函数 $f(x)=\vert x\vert$ 而言，$f^{\prime}(0)$ 就不满足极限定义的这个性质，因此实变函数 $f(x)=\vert x\vert$ 在 $x=0$ 处并不存在导数。类似的，对于实变函数，同样存在这样的问题，**如果我们说 $\Delta z \rightarrow 0$ 时极限 $\Delta w/\Delta z$ 存在，就必须保证该极限与 $z\rightarrow z_0$ 的方向无关**。

这种形式上的要求为复变函数带来了一对最为重要的微分方程——柯西黎曼方程。对于实变函数 $w=f(z)$ ，其中 $z=x+\mathrm{i}y$，$w=u+\mathrm{i}v$ ，则有 $w=u(x,y)+\mathrm{i}v(x,y)$。柯西黎曼表明，如果一个复变函数 $w=f(z)$ 可微（即可导），那么它在复平面内任一点应当满足：

$$
\dfrac{\partial u}{\partial x}=\dfrac{\partial v}{\partial y},\ \dfrac{\partial u}{\partial y}=-\dfrac{\partial v}{\partial x}\label{eq1}
$$

比如对于上面提到的复变函数 $w=z^2$，有 $u=x^2-y^2$ 和 $v=2xy$，则$\partial u/\partial x=2x$，$\partial u/\partial y=-2y$，$\partial v/\partial y=2x$，$\partial v/\partial x=2y$，就满足柯西-黎曼方程 $\eqref{eq1}$，因此复变函数$w=z^2$ 在复平面上的每一点 $z$ 都是可微的，形式上可以写成 $\mathrm{d}w/\mathrm{d}z=2z$ 。尽管柯西-黎曼方程并不涉及直接的导数计算，但是它提供了复变函数在某点**存在**导数的必要条件，而且，稍微改变一下假设条件，它也是充分条件。

如果一个复变函数 $w=f(z)$ 在复平面上的某一点 $z$ 处可微，我们就称 $f(z)$ 在 $z$ 点是**解析**的。很明显，对于实数域的可微而言，解析是一个更为严格的条件。但是一旦一个复变函数被证明是解析的，那么它就符合类似于实数域规则的求导规则。例如，两个函数的和以及积的微分公式、链式法则，还有诸如 $\mathrm{d}(x^n)/\mathrm{d}x=nx^{n-1}$ 的公式，所有这些对实变量函数都成立的法则对复变量函数依然成立。我们称函数 $y=f(x)$ 的性质**移植到了复数域中**。

<br>

# 验证复变函数 $w=z^2+1$ 的解析性质

柯西-黎曼方程的证明比较困难，但是当我们根据柯西黎曼方程证明一个复变函数 $w=f(z)$ 是解析的，就可以从几何上考察一下：当 $z$ 以不同的方式趋近一个点时，复数映射会发生什么，并且验证实变函数 $y=f(x)$ 的性质是否移植到了复数域中。

假设对于复变函数 $w=z^2+1$ ，并且在 $z$ 平面上存在一点 $z_0=(0.5,0)$。现在我们在以 $P$ 为圆心，半径为0.5的圆形邻域边界上等间隔地选取12个点，使它们以直线的方式逼近点 $z_0$ 。下图就展示了在逼近的过程中，$z$ 平面中的直线轨迹以及所对应的 $w$ 平面中的轨迹。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/Mapping3.gif?raw=true" alt="Mapping3" style="zoom:50%;" />

从程序上讲，如果对于 $z$ 平面中每一条逼近的直线我们都取5000个点，那么倒数第二个点和最后一个点之间的复数差值我们就可以认为是一个很小的 $\Delta z$，与之对应的是 $w$ 平面中的 $\Delta w$。对于每一条直线轨迹都计算一下 $\Delta w/\Delta z$，可以得到：

```matlab
>> derivates
derivates =
   0.9999 - 0.0000i
   0.9999 - 0.0001i
   0.9999 - 0.0001i
   1.0000 - 0.0001i
   1.0001 - 0.0001i
   1.0001 - 0.0001i
   1.0001 + 0.0000i
   1.0001 + 0.0001i
   1.0001 + 0.0001i
   1.0000 + 0.0001i
   0.9999 + 0.0001i
   0.9999 + 0.0001i
```

可以看到，这些值都是非常接近的，并且接近$2\times z_0=1$ ，这就验证了 $\dfrac{\mathrm{d}w}{\mathrm{d}z}=2z$ 的解析性质。

（上述绘图及分析过程代码）

```matlab
clc, clear, close all

Interpreter = 'latex';
gifFile = 'Mapping3.gif';
if exist(gifFile, 'file')
    delete(gifFile)
end
LineWidth = 1.5;
numPoints = 5000;
rng(42)

fig = figure('unit', 'centimeters', 'position', [15, 7, 29, 15]);
sgtitle('Complex Mapping: $w=z^2+1$', Interpreter=Interpreter)

ax1 = subplot(1, 2, 1); ax1.Parent = fig;
theta = linspace(-pi, pi, numPoints);
a = 0.5;
b = 0;
r = 0.5;
x = r*cos(theta) + a;
y = r*sin(theta);

plot(x, y, LineWidth=LineWidth, Color='k', LineStyle='--'), hold on
scatter(0.5, 0, 'filled')
axis([-0.5, 1.5, -1, 1])
xlabel('x', Interpreter=Interpreter);
ylabel('y', Interpreter=Interpreter);
title('Complex')
set(gca, 'DataAspectRatio', [1 1 1])

ax2 = subplot(1, 2, 2); ax2.Parent = fig;
scatter(0, 0, 'filled');
axis([0.5, 2, -1, 1])
xlabel('u', Interpreter=Interpreter);
ylabel('v', Interpreter=Interpreter);
title('Mapping')
set(gca, 'DataAspectRatio', [1.5 2 1])

interval = pi/6;
epsilon = 1e-13;
numLines = (2*pi)/interval;
zs = zeros(numLines, 1);
ws = zeros(numLines, 1);
idx = 1;
for k = -pi : interval : pi - interval
    xk = r*cos(k) + a;
    yk = r*sin(k) +b;
    if abs(xk - a) <= epsilon
        n = linspace(yk, b, numPoints);
        m = a*ones(1, numel(n));
    elseif abs(xk - a) > epsilon
        m = linspace(xk, a, numPoints);
        n = (yk-b)/(xk-a) * (m-a) + b;
    end
    [fig, u, v] = MappingLink(fig, m, n, numPoints, gifFile, LineWidth);
    z = complex(m(end-1), n(end-1));
    w = complex(u(end-1), v(end-1));
    zs(idx) = z;
    ws(idx) = w;
    idx = idx + 1;
end
deltazs = zs - complex(m(end), n(end));
deltaws = ws - complex(u(end), n(end));
derivates = deltaws./deltazs;

function [fig, u, v] = MappingLink(fig, x, y, numPoints, gifFile, LineWidth)
u = x.^2 - y.^2 + 1;
v = 2*x.*y;

Color = [rand(), rand(), rand()];
h1 = animatedline(LineWidth=LineWidth, Color=Color); h1.Parent = fig.Children(2);
h2 = animatedline(LineWidth=LineWidth, Color=Color); h2.Parent = fig.Children(1);

for i = 1: numPoints
    addpoints(h1, x(i), y(i))
    addpoints(h2, u(i), v(i))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end
end
```

<br>

# 复变函数的增量 $\mathrm{d}w$ 在几何上如何体现？

在实变函数领域，如果实变函数 $y=f(x)$ 可微，则有：$\mathrm{d}y=f'(x)\mathrm{d}x$，对于指定的一点$x_0$，有$\mathrm{d}y\vert_{x=x_0}=f'(x_0)\mathrm{d}x$，从几何角度看，这表示在 $x_0$ 处增加一个极小量 $\mathrm{d}x$ ，函数值增加 $\mathrm{d}y$。例如，对于实变函数 $y=x^2$，有：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220720143426716.png?raw=true" alt="image-20220720143426716" style="zoom:50%;" />

```matlab
clc, clear, close all

Interpreter = 'latex';
LineWidth = 1.5;
FontSize = 13;
numPoints = 100;

fig = figure();
ax = axes;
f = @(x) x.^2;
tangent = @(x) 2*(x-1) + 1;
x = linspace(-2, 2, numPoints);
deltax = linspace(0, 2, numPoints);
deltay = tangent(deltax);
dx = linspace(1, 1.05, numPoints);
dy = linspace(f(1), tangent(1.05), numPoints);

scatter(1, f(1), 'filled'), hold on
plot(x, f(x), LineWidth=LineWidth, Color='b'), hold on
plot(deltax, deltay, LineWidth=LineWidth, Color='r'), hold on
plot(dx, ones(1, numel(dx)), LineWidth=LineWidth, LineStyle = '--', Color='k'), hold on
plot(1.05*ones(1, numel(dx)), dy, LineWidth=LineWidth, LineStyle='--', Color='k')
text(0.97, 1.05, '$f^{\prime}(1)=2$', Interpreter=Interpreter, FontSize=FontSize)
text(1.02, 0.99, '$\mathrm{d}x$', Interpreter=Interpreter, FontSize=FontSize)
text(1.053, 1.047, '$\mathrm{d}y$', Interpreter=Interpreter, FontSize=FontSize)
legend('', '$y=x^2$','tangent at (1, y(1))', Interpreter=Interpreter, Location='northwest')


axis([0.92, 1.18, 0.94, 1.20])
title('$y=x^2$', Interpreter=Interpreter)
xlabel('x', Interpreter=Interpreter)
ylabel('y', Interpreter=Interpreter)
```

实变函数的增量过程在几何上比较容易理解。但是复变函数的增量 $\mathrm{d}w$ 怎么理解呢？在复变函数领域，如果复变函数 $w=f(z)$ 是解析的，同样有 $\mathrm{d}w=f'(z)\mathrm{d}z$，**这个表达式在几何上如何体现？**

假设函数 $w=f(z)$ 是一个解析的复变函数，则 $f'(z)$ 同样是一个复变函数，则 $f'(z)$ 在 $z=z_0$ 处的值 $f'(z_0)$ （当固定了 $z_0$ 后 $f'(z_0)$ 就是一个复数），总可以写作如下形式：

$$
f'(z_0)=a+\mathrm{i}b=B+Ae^{\mathrm{i}\theta}\notag
$$

其中 $B$ 和 $A$ 都是实数。因此有

$$
\mathrm{d}w\vert_{z=z_0}=(B+Ae^{\mathrm{i}\theta})\mathrm{d}z=B\mathrm{d}z+Ae^{\mathrm{i}\theta}\mathrm{d}z\notag
$$

其中：

- $B\mathrm{d}z$ 表示将复数 $\mathrm{d}z$ 缩放 $B$ 倍；
- $Ae^{\mathrm{i}\theta}\mathrm{d}z$ 表示先将复数 $\mathrm{d}z$ 旋转 $\theta$ 角度，再将复数缩放 $A$ 倍；

最终，复数增量 $\mathrm{d}w$ 表现为上述两个复数的相加。

又因为复变函数 $w=f(z)$ 是解析的，因此在 $z_0$ 的复平面领域内，无论 $z$ 以什么样的方式接近 $z_0$，即无论 $\mathrm{d}z$ 如何取值，$\mathrm{d}w\vert_{z=z_0}=f'(z_0)\mathrm{d}z$ 均成立。所以，**复数增量 $\mathrm{d}w\vert_{z=z_0}$ 的几何含义就是将 $z_0$ 附近的一部分小区域旋转并缩放**。

为了验证这个想法，还是针对上一部分复变函数 $w=z^2+1$ 的例子，我们改变编程的方式：改变之前基于解析表达式绘制复数映射的方式，而是使用**基于增量** $\mathrm{d}w$ 的方式来绘制复数映射：

```matlab
% ----------------------------------------
...
function [fig, u, v] = MappingLink(fig, x, y, numPoints, gifFile, LineWidth)
% Base on anylytic expression
u = x.^2 - y.^2 + 1;
v = 2*x.*y;
...

% ----------------------------------------
...
function fig = MappingLink(fig, x, y, numPoints, gifFile, LineWidth)
% Base on incremental value dw
z0 = complex(x, y);
w0 = z0.^2 + 1;
dz = [diff(z0), 0];
dw = 2*z0.*dz;
w = w0+dw;
u = real(w);
v = imag(w);
...
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/Mapping5.gif?raw=true" alt="Mapping5" style="zoom:50%;" />

可以看到两种的绘制方式结果是一致的！

并且从上图可以看到 $\mathrm{d}w_0=2z_0\mathrm{d}z_0$  中的复数 $2z_0$ 对于**线段 $\mathrm{d}z_0$** 的旋转和缩放。

基于增量 $\mathrm{d}w$ 编程的完整代码如下：

```matlab
clc, clear, close all

Interpreter = 'latex';
gifFile = 'Mapping5.gif';
if exist(gifFile, 'file')
    delete(gifFile)
end
LineWidth = 1.5;
numPoints = 50;
rng(42)

fig = figure('unit', 'centimeters', 'position', [15, 7, 29, 15]);
sgtitle('Complex Mapping: $w=z^2+1$', Interpreter=Interpreter)

ax1 = subplot(1, 2, 1); ax1.Parent = fig;
theta = linspace(-pi, pi, numPoints);
a = 0.5;
b = 0;
r = 0.5;
x = r*cos(theta) + a;
y = r*sin(theta);

plot(x, y, LineWidth=LineWidth, Color='k', LineStyle='--'), hold on
scatter(0.5, 0, 'filled')
axis([-0.5, 1.5, -1, 1])
xlabel('x', Interpreter=Interpreter);
ylabel('y', Interpreter=Interpreter);
title('Complex')
set(gca, 'DataAspectRatio', [1 1 1])

ax2 = subplot(1, 2, 2); ax2.Parent = fig;
scatter(0, 0, 'filled');
axis([0.5, 2, -1, 1])
box on
xlabel('u', Interpreter=Interpreter);
ylabel('v', Interpreter=Interpreter);
title('Mapping')
set(gca, 'DataAspectRatio', [1.5 2 1])

interval = pi/6;
epsilon = 1e-13;
for k = -pi : interval : pi - interval
    xk = r*cos(k) + a;
    yk = r*sin(k) +b;
    if abs(xk - a) <= epsilon
        n = linspace(yk, b, numPoints);
        m = a*ones(1, numel(n));
    elseif abs(xk - a) > epsilon
        m = linspace(xk, a, numPoints);
        n = (yk-b)/(xk-a) * (m-a) + b;
    end
    fig = MappingLink(fig, m, n, numPoints, gifFile, LineWidth);
end


function fig = MappingLink(fig, x, y, numPoints, gifFile, LineWidth)
% Base on incremental value dw
z0 = complex(x, y);
w0 = z0.^2 + 1;
dz = [diff(z0), 0];
dw = 2*z0.*dz;
w = w0+dw;
u = real(w);
v = imag(w);

Color = [rand(), rand(), rand()];
h1 = animatedline(LineWidth=LineWidth, Color=Color); h1.Parent = fig.Children(2);
h2 = animatedline(LineWidth=LineWidth, Color=Color); h2.Parent = fig.Children(1); 

for i = 1: numPoints
    addpoints(h1, x(i), y(i))
    addpoints(h2, u(i), v(i))
    drawnow
    exportgraphics(gcf, gifFile, 'Append', true);
end
end
```

<br>

**References**

[1] 伊莱·马奥尔(Eli Maor). e的故事：一个常数的传奇(第2版). 周昌智，毛兆安译. 北京：人民邮电出版社，2018.11.
