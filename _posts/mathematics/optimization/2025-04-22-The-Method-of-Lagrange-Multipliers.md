---
title: The Method of Lagrange Multipliers
categories:
 - Mathematics
 - MATLAB
tags: 
 - Calculus
 - MATLAB Graphics
 - Optimization
date: 2025-04-22 15:40:09 +0800
last_modified_at: 2025-04-30 15:14:01 +0800
---

# The method of Lagrange multipliers

The method of Lagrange multipliers in optimization is[^1]: 

<div class="quote--left" markdown="1">

In mathematical optimization, <i class="term">the method of Lagrange multipliers</i> is a strategy for finding the local maxima and minima of a function <i class="emphasize">subject to equation constraints</i> (i.e., subject to the condition that one or more equations have to be satisfied exactly by the chosen values of the variables). It is named after the mathematician Joseph-Louis Lagrange.

...

The basic idea is to convert a constrained problem into a form such that the <i class="emphasize">derivative test</i> of an unconstrained problem can still be applied. The relationship between the gradient of the function and gradients of the constraints rather naturally leads to a reformulation of the original problem, known as the <i class="term">Lagrangian function</i> or <i class="term">Lagrangian</i>. In the general case, the Lagrangian is defined as:

$$
\mathcal{L}(\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{\lambda}})\equiv f(\boldsymbol{\mathrm{x}})+\langle\boldsymbol{\mathrm{\lambda}},\boldsymbol{\mathrm{g}}(\boldsymbol{\mathrm{x}})\rangle\notag
$$

for functions $f$, $\boldsymbol{\mathrm{g}}$; the notation $\langle\cdot,\cdot\rangle$ denotes an inner product. The value $\boldsymbol{\mathrm{\lambda}}$ is called the <i class="term">Lagrange multiplier</i>.

In simple cases, where the inner product is defined as the dot product, the Lagrangian is:

$$
\mathcal{L}(\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{\lambda}})\equiv f(\boldsymbol{\mathrm{x}})+\boldsymbol{\mathrm{\lambda}}\cdot\boldsymbol{\mathrm{g}}(\boldsymbol{\mathrm{x}})\notag
$$

The method can be summarized as follows: in order to find the maximum or minimum of a function $\boldsymbol{\mathrm{f}}$ subject to the equality constraint $\boldsymbol{\mathrm{g}}(\boldsymbol{\mathrm{x}})=\boldsymbol{0}$, find the <i class="term">stationary points</i> of $\mathcal{L}$ considered as a function of $\boldsymbol{\mathrm{x}}$ and the Lagrange multiplier $\boldsymbol{\mathrm{\lambda}}$. This means that all partial derivatives should be zero, including the partial derivative with respect to $\boldsymbol{\mathrm{\lambda}}$:

$$
\left\{
\begin{split}
\dfrac{\partial\mathcal{L}}{\partial\boldsymbol{\mathrm{x}}}=\boldsymbol{\mathrm{0}}\\
\dfrac{\partial\mathcal{L}}{\partial\boldsymbol{\mathrm{\lambda}}}=\boldsymbol{\mathrm{0}}\\
\end{split}\right.
$$

or equivalently:

$$
\left\{
\begin{split}
&\dfrac{\partial f(\boldsymbol{\mathrm{x}})}{\partial \boldsymbol{\mathrm{x}}}+\boldsymbol{\mathrm{\lambda}}\cdot\dfrac{\partial\boldsymbol{\mathrm{g}}(\boldsymbol{\mathrm{x}})}{\partial \boldsymbol{\mathrm{x}}}&=\boldsymbol{\mathrm{0}}\\
&\dfrac{\partial\mathcal{L}}{\partial\boldsymbol{\mathrm{\lambda}}}=\boldsymbol{\mathrm{0}}\\
\end{split}\right.\label{eq3}
$$

The great advantage of this method is that it allows the optimization to be solved <i class="emphasize">without explicit parameterization in terms of the constraints</i>. As a result, the method of Lagrange multipliers is widely used <i class="emphasize">to solve challenging constrained optimization problems</i>. Further, the method of Lagrange multipliers is generalized by the <i class="term">Karush–Kuhn–Tucker conditions</i>, which can also take into account <i class="emphasize">inequality constraints</i> of the form $\boldsymbol{\mathrm{h}}(\boldsymbol{\mathrm{x}})\le\boldsymbol{\mathrm{c}}$ for a given constant $\boldsymbol{\mathrm{c}}$.

</div>

## Single constraint (with two variables)

Firstly, let’s take the case of only including one equality constraint and two variables:

$$
\begin{split}
\max_{x,y}\ &f(x,y)\\
\text{s.t.}\ &g(x,y)=0\\
\end{split}\label{eq1}
$$

whose Lagrange function can be expressed as:

$$
\mathcal{L}(x,y,\lambda)=f(x,y)+\lambda\cdot g(x,y)\notag
$$

In this two-dimensional case, the objective function $f(x,y)$ represents a surface, and the constraint $g(x,y)=0$ represents a curve (in another words, the feasible region of this case is a curve).

Then, if a point is a maximum (or a minimum, or using “optimality” to incorporate these two cases) of optimization $\eqref{eq1}$, it will have either characteristic of following two.

**Case 1**: We can view the process of finding the maximum of $\eqref{eq1}$ as such: the point $(x,y)$ move along the constraint curve $g(x,y)=0$ (<i class="emphasize">along the tangent line for each point on the curve</i>), and for each point $(x,y)$ on the curve we can calculate the corresponding function value $f(x,y)$, and finally find the maximum $f(x,y)$ and hence whose variable values $(x,y)$. 

On the other hand, for the objective function $f(x,y)$, on its each contour, denoted as $f(x,y)=d_i$, all possible $(x,y)$ have the same function value $f(x,y)$ by the definition of the contour. Therefore, we can conclude that <i class="emphasize">when the tangent line of $g(x,y)=0$ and the tangent line of $f(x,y)=d_i$ are parallel at the same point $(x_0,y_0)$ (i.e. $g(x,y)=0$ and $f(x,y)=d_i$ are tangent at $(x_0,y_0)$), the point $(x_0,y_0)$ is probably a maximum</i>. It is because that, at this point, the above mentioned movement of $(x,y)$ walking along the curve $g(x,y)=0$ can be viewed as a movement walking along the contour $f(x,y)=d_i$ in an infinitely small segment, and walking along the contour doesn’t change the function value, so $(x_0,y_0)$ might be a maximum.

<div class="notice--primary" markdown="1">

Like in this example[^1], point A might be a maximum, but B is definitely not.

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504231747766.png" alt="image-20250423174750587" style="width:50%;" />

</div>

Next, due to the fact that the gradient of a function is perpendicular to the tangent line of the contour (at each point on the each contour)[^2], aforementioned “the tangent line of $g(x,y)=0$ and the tangent line of $f(x,y)=d_i$ are parallel at the same point $(x_0,y_0)$” can be equivalently expressed as “<i class="emphasize">the gradient of $f(x,y)$ and the gradient of $g(x,y)$ (note, here is not $g(x,y)=0$!) are parallel at the point $(x_0,y_0)$</i>”, which is at the point $(x_0,y_0)$ we have:

$$
\begin{bmatrix}
\dfrac{\partial f(x,y)}{\partial x}\Big\vert_{(x_0,y_0)}\\
\dfrac{\partial f(x,y)}{\partial y}\Big\vert_{(x_0,y_0)}\\
\end{bmatrix}
=\lambda
\begin{bmatrix}
\dfrac{\partial g(x,y)}{\partial x}\Big\vert_{(x_0,y_0)}\\
\dfrac{\partial g(x,y)}{\partial y}\Big\vert_{(x_0,y_0)}\\
\end{bmatrix}\notag
$$

i.e.,

$$
\nabla_{x,y}f(x,y)\Big\vert_{(x_0,y_0)} = \lambda\nabla_{x,y}g(x,y)\Big\vert_{(x_0,y_0)}\label{eq2}
$$

The constant $\lambda$ is needed because the magnitudes of these two gradient vectors are not generally equal.

**Case 2**: For a $f(x,y)$, if in a small area around $(x_0,y_0)$, $f$ is level, then these points also might be maxima. And at this point, we have:

$$
\nabla_{x,y}f(x,y)\Big\vert_{(x_0,y_0)}=0\notag
$$

For example, consider the optimization:

$$
\begin{split}
\max_{x,y}\ &1\\
\text{s.t.}\ & x^2+y^2=1\\
\end{split}\notag
$$

We can know that, all points, denoted as $(x_0,y_0)$, on $x^2+y^2=1$ are optimal and they have the same maximum value, $1$. And we also have:

$$
\left\{
\begin{split}
&\nabla_{x,y}f(x,y)\Big\vert_{(x_0,y_0)} = \boldsymbol{\mathrm{0}}\\
&\nabla_{x,y}g(x,y)\Big\vert_{(x_0,y_0)} = \begin{bmatrix}
2x_0\\
2y_0\\
\end{bmatrix}\\
\end{split}\right.\notag
$$

Therefore, as can be seen, this kind of case, i.e., $f(x,y)$ is level, is also can be depicted using Eq. $\eqref{eq2}$ by setting $\lambda=0$. 

Finally, we can get that, <i class="emphasize">to find maxima of $f(x,y)$ constrained by $g(x,y)=0$, we could look for those points on $g(x,y)=0$ that satisfy $\nabla_{x,y}f(x,y) = \lambda\nabla_{x,y}g(x,y)$, and they may be maxima</i> (the reason why we use “may” here is that the method of Lagrange multipliers only yields a necessary, not sufficient, condition for maxima. See below.) So, we can construct a auxiliary function:

$$
\mathcal{L}(x,y,\lambda)\equiv f(x,y)+\lambda\cdot g(x,y)\notag
$$

and make each partial derivative of $\mathcal{L}$ with respect to $x$, $y$, and $\lambda$, equal to zero, respectively:

$$
\left\{
\begin{split}
&\dfrac{\partial\mathcal{L}}{\partial x}=0\\
&\dfrac{\partial\mathcal{L}}{\partial y}=0\\
&\dfrac{\partial\mathcal{L}}{\partial \lambda}=0\\
\end{split}\right.
\quad\Rightarrow\quad\left\{
\begin{split}
&\dfrac{\partial f(x,y)}{\partial x}+\lambda\dfrac{\partial f(x,y)}{\partial x}=0\\
&\dfrac{\partial f(x,y)}{\partial y}+\lambda\dfrac{\partial f(x,y)}{\partial y}=0\\
&g(x,y)=0
\end{split}\right.\label{eq4}
$$

By solving this equation system, we can find those points! Actually, $\eqref{eq4}$ is the two-dimensional case of $\eqref{eq3}$.

Besides, it should highlight that, <i class="emphasize">the method of Lagrange multipliers only yields a necessary condition for optimality in constrained problems</i>, that is, other than maxima, there are also other points that satisfy $\eqref{eq4}$, such as minima (see below [Example 1](#example-1), [Example 2](#example-2), and [Example 3](#example-3)), or ones neither maxima nor minima (see [Example 3](#example-3)).

## Multiple constraints

When there are multiple constraints, the method of Lagrange multipliers is also available. We can write Lagrange function like:

$$
\mathcal{L}(\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{\lambda}})\equiv f(\boldsymbol{\mathrm{x}})+\boldsymbol{\mathrm{\lambda}}\cdot\boldsymbol{\mathrm{g}}(\boldsymbol{\mathrm{x}})\notag
$$

and based on $\eqref{eq3}$, we’ll get:

$$
\left\{
\begin{split}
&\nabla f(\boldsymbol{\mathrm{x}})+\sum_{k=1}^M\lambda_k\nabla g_k(\boldsymbol{\mathrm{x}})=0\\
&g_1(\boldsymbol{\mathrm{x}})=\cdots=g_M(\boldsymbol{\mathrm{x}})=0
\end{split}\right.\notag
$$

where note that the first equation denotes such a geometric meaning[^1]:

<div class="quote--left" markdown="1">
... In the case of multiple constraints, that will be what we seek in general: The method of Lagrange seeks points not at which the gradient of $f$ is a multiple of any single constraint's gradient necessarily, <i class="emphasize">but in which it is a linear combination of all the constraints' gradients</i>.
</div>
<br>

# Examples

The Wikipedia article[^1] also provides some specific examples, and in the following text, I’d like to reproduce some of them.

## Example 1

<div id="example-1"></div>

Consider the maximization:

$$
\begin{split}
\max_{x,y}\ &f(x,y)=x+y\\
\mathrm{s.t.}\ &x^2+y^2=1
\end{split}\notag
$$

we can write its Lagrange function is:

$$
\mathcal{L}(x,y,\lambda)=(x+y)+\lambda(x^2+y^2-1)\notag
$$

then we have:

$$
\left\{
\begin{split}
&\dfrac{\partial\mathcal{L}}{\partial x}=0\\
&\dfrac{\partial\mathcal{L}}{\partial y}=0\\
&\dfrac{\partial\mathcal{L}}{\partial \lambda}=0\\
\end{split}\right.
\quad\Rightarrow\quad\left\{
\begin{split}
&1+2\lambda x=0\\
&1+2\lambda y=0\\
&x^2+y^2-1=0\\
\end{split}\right.\notag
$$

we can get two solutions:

$$
\left\{
\begin{split}
&\lambda_1=\dfrac{\sqrt2}{2}\\
&x_1=-\dfrac{\sqrt2}{2}\\
&y_1=-\dfrac{\sqrt2}{2}\\
\end{split}\right.,\quad
\left\{\begin{split}
&\lambda_2=-\dfrac{\sqrt2}{2}\\
&x_2=\dfrac{\sqrt2}{2}\\
&y_2=\dfrac{\sqrt2}{2}\\
\end{split}\right.\notag
$$

and their function values are:

$$
f(x_1,y_1)=-\sqrt2,\ f(x_2,y_2)=\sqrt2\notag
$$

Finally, we can see that, $f(x_2,y_2)$ is the maximum and $f(x_1,y_1)$ is the minimum.

<br>

![fig1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504301449521.jpg)

```matlab
clc, clear, close all

fig = figure("Color", "w", "Position", [303,521.66,1900,564.66]);
tiledlayout(1,3)

nexttile
view([32.89,11.58])
sc1 = helperPlot;

nexttile
view([90,0])
helperPlot;

nexttile
view([0,90])
sc2 = helperPlot;
sc2(1).FaceAlpha = 0;

exportgraphics(fig, "fig1.jpg", "Resolution", 600)

function sc = helperPlot
x = -1.5:0.05:1.5;
y = -1.5:0.05:1.5;
[X, Y] = meshgrid(x, y);
fnc = @(x,y) (x+y);

theta = 0:0.01:2*pi;
xx = cos(theta);
yy = sin(theta);
f = fnc(X, Y);
g = xx+yy;

hold(gca, "on")
box(gca, "on")
grid(gca, "on")
sc = surfc(X, Y, f, "EdgeColor", "none");
sc(1).FaceAlpha = 0.7;
sc(2).LineWidth = 1.5;
sc(2).LevelList = min(f,[],"all"):0.2:max(f,[],"all");
plot3(xx, yy, g, "LineWidth", 1.5, "Color", "k")
level = min(min(f))-3;
plot3(xx, yy, level*ones(size(xx)), "LineWidth", 1.5, "Color", "k")

x1 = -sqrt(2)/2;
y1 = -sqrt(2)/2;
fnc1 = fnc(x1, y1);

x2 = sqrt(2)/2;
y2 = sqrt(2)/2;
fnc2 = fnc(x2,y2);

scatter3([x1, x2], [y1, y2], [fnc1, fnc2], 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
scatter3([x1, x2], [y1, y2], [level, level], 20, "filled", "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
plot3([x1, x1], [y1, y1], [level, fnc1], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x2, x2], [y2, y2], [level, fnc2], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
text(x1, y1, fnc1+0.5, "$(-\sqrt{2}/2,-\sqrt{2}/2,-\sqrt{2})$", "Interpreter", "latex", "FontSize", 12)
text(x2, y2, fnc2+0.5, "$(\sqrt{2}/2,\sqrt{2}/2,\sqrt{2})$", "Interpreter", "latex", "FontSize", 12)

xlabel("$x$", "Interpreter", "latex", "FontSize", 20)
ylabel("$y$", "Interpreter", "latex", "FontSize", 20)
zlabel("$f$", "Interpreter", "latex", "FontSize", 20)
end
```

## Example 2

<div id="example-2"></div>

Consider the maximization:

$$
\begin{split}
\max_{x,y}\ &f(x,y)=(x+y)^2\\
\mathrm{s.t.}\ &x^2+y^2=1
\end{split}\notag
$$

whose Lagrange function is:

$$
\mathcal{L}(x,y,\lambda)=(x+y)^2+\lambda(x^2+y^2-1)\notag
$$

then:

$$
\left\{
\begin{split}
&\dfrac{\partial\mathcal{L}}{\partial x}=0\\
&\dfrac{\partial\mathcal{L}}{\partial y}=0\\
&\dfrac{\partial\mathcal{L}}{\partial \lambda}=0\\
\end{split}\right.
\quad\Rightarrow\quad\left\{
\begin{split}
&(1+\lambda)x+y=0\\
&x+(1+\lambda)y=0\\
&x^2+y^2-1=0\\
\end{split}\right.\notag
$$

and:

$$
\left\{
\begin{split}
&\lambda_1=-2\\
&x_1=\dfrac{\sqrt2}{2}\\
&y_1=\dfrac{\sqrt2}{2}\\
\end{split}\right.,\quad
\left\{\begin{split}
&\lambda_2=-2\\
&x_2=-\dfrac{\sqrt2}{2}\\
&y_2=-\dfrac{\sqrt2}{2}\\
\end{split}\right.,\quad
\left\{
\begin{split}
&\lambda_3=0\\
&x_3=-\dfrac{\sqrt2}{2}\\
&y_3=\dfrac{\sqrt2}{2}\\
\end{split}\right.,\quad
\left\{\begin{split}
&\lambda_4=0\\
&x_4=\dfrac{\sqrt2}{2}\\
&y_4=-\dfrac{\sqrt2}{2}\\
\end{split}\right.\notag
$$

i.e.

$$
\begin{split}
&f(\lambda_1,x_1,y_1)=2\\
&f(\lambda_2,x_2,y_2)=2\\
&f(\lambda_3,x_3,y_3)=0\\
&f(\lambda_4,x_4,y_4)=0\\
\end{split}\notag
$$

where $f(x_1,y_1)$ and $f(x_2,y_2)$ are maxima, whereas $f(x_3,y_3)$ and $f(x_4,y_4)$ are minima.

<br>

![fig2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504301449875.jpg)

```matlab
clc, clear, close all

fig = figure("Color", "w", "Position", [303,521.66,1900,564.66]);
tiledlayout(1,3)

nexttile
view([32.89,11.58])
sc1 = helperPlot;

nexttile
view([90,0])
helperPlot;

nexttile
view([0,90])
sc2 = helperPlot;
sc2(1).FaceAlpha = 0;

exportgraphics(fig, "fig2.jpg", "Resolution", 600)

function sc = helperPlot
x = -1.5:0.05:1.5;
y = -1.5:0.05:1.5;
[X, Y] = meshgrid(x, y);
fnc = @(x,y) (x+y).^2;
f = fnc(X,Y);

theta = 0:0.01:2*pi;
xx = cos(theta);
yy = sin(theta);
g = fnc(xx,yy);

hold(gca, "on")
box(gca, "on")
grid(gca, "on")
sc = surfc(X, Y, f, "EdgeColor", "none");
sc(1).FaceAlpha = 0.7;
sc(2).LineWidth = 1.5;
sc(2).LevelList = min(f,[],"all"):0.2:max(f,[],"all");
plot3(xx, yy, g, "LineWidth", 1.5, "Color", "k")
level = min(min(f))-3;
plot3(xx, yy, level*ones(size(xx)), "LineWidth", 1.5, "Color", "k")

x1 = sqrt(2)/2;
y1 = sqrt(2)/2;
fnc1 = fnc(x1,y1);

x2 = -sqrt(2)/2;
y2 = -sqrt(2)/2;
fnc2 = fnc(x2,y2);

x3 = -sqrt(2)/2;
y3 = sqrt(2)/2;
fnc3 = fnc(x3,y3);

x4 = sqrt(2)/2;
y4 = -sqrt(2)/2;
fnc4 = fnc(x4,y4);

scatter3([x1, x2, x3, x4], [y1, y2, y3, y4], [fnc1, fnc2, fnc3, fnc4], 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
scatter3([x1, x2, x3, x4], [y1, y2, y3, y4], [level, level, level, level], 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
plot3([x1, x1], [y1, y1], [level, fnc1], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x2, x2], [y2, y2], [level, fnc2], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x3, x3], [y3, y3], [level, fnc3], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x4, x4], [y4, y4], [level, fnc4], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
text(x1, y1, fnc1+0.5, "$(\sqrt{2}/2,\sqrt{2}/2,2)$", "Interpreter", "latex", "FontSize", 12)
text(x2, y2, fnc2+0.5, "$(-\sqrt{2}/2,-\sqrt{2}/2,2)$", "Interpreter", "latex", "FontSize", 12)
text(x3, y3, fnc1+0.5, "$(-\sqrt{2}/2,\sqrt{2}/2,0)$", "Interpreter", "latex", "FontSize", 12)
text(x4, y4, fnc1+0.5, "$(\sqrt{2}/2,-\sqrt{2}/2,0)$", "Interpreter", "latex", "FontSize", 12)

xlabel("$x$", "Interpreter", "latex", "FontSize", 20)
ylabel("$y$", "Interpreter", "latex", "FontSize", 20)
zlabel("$f$", "Interpreter", "latex", "FontSize", 20)
end
```

## Example 3

<div id="example-3"></div>

Consider the maximization:

$$
\begin{split}
\max_{x,y}\ &f(x,y)=xy^2\\
\mathrm{s.t.}\ &x^2+y^2=3
\end{split}\notag
$$

whose Lagrange function is:

$$
\mathcal{L}(x,y,\lambda)=xy^2+\lambda(x^2+y^2-3)
$$

then:

$$
\left\{
\begin{split}
&\dfrac{\partial\mathcal{L}}{\partial x}=0\\
&\dfrac{\partial\mathcal{L}}{\partial y}=0\\
&\dfrac{\partial\mathcal{L}}{\partial \lambda}=0\\
\end{split}\right.
\quad\Rightarrow\quad\left\{
\begin{split}
&y^2+2\lambda x=0\\
&xy+\lambda y=0\\
&x^2+y^2-3=0\\
\end{split}\right.\notag
$$

then we’ll get six critical points:

$$
\left\{
\begin{split}
&\lambda_1=0\\
&x_1=\sqrt3\\
&y_1=0\\
\end{split}\right.,\quad
\left\{\begin{split}
&\lambda_2=0\\
&x_2=-\sqrt3\\
&y_2=0\\
\end{split}\right.\\
\left\{
\begin{split}
&\lambda_3=-1\\
&x_3=1\\
&y_3=\sqrt2\\
\end{split}\right.,\quad
\left\{\begin{split}
&\lambda_4=-1\\
&x_4=1\\
&y_4=-\sqrt2\\
\end{split}\right.\\
\left\{\begin{split}
&\lambda_5=1\\
&x_5=-1\\
&y_5=\sqrt2\\
\end{split}\right.,\quad
\left\{\begin{split}
&\lambda_6=1\\
&x_6=-1\\
&y_6=-\sqrt2\\
\end{split}\right.\notag
$$

and their function values are:

$$
\begin{split}
&f(\lambda_1,x_1,y_1)=0\\
&f(\lambda_2,x_2,y_2)=0\\
&f(\lambda_3,x_3,y_3)=2\\
&f(\lambda_4,x_4,y_4)=2\\
&f(\lambda_5,x_5,y_5)=-2\\
&f(\lambda_6,x_6,y_6)=-2\\
\end{split}\notag
$$

As can be seen in this case, $f(x_5,y_5)$ and $f(x_6,y_6)$ are minima, $f(x_3,y_3)$ and $f(x_4,y_4)$ are maxima, and $f(x_1,y_1)$ and $f(x_2,y_2)$ are neither minima nor maxima.

<br>

![fig3](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504301450392.jpg)

```matlab
clc, clear, close all

fig = figure("Color", "w", "Position", [303,521.66,1900,564.66]);
tiledlayout(1,3)

nexttile
view([32.89,11.58])
sc1 = helperPlot;

nexttile
view([90,0])
helperPlot;

nexttile
view([0,90])
sc2 = helperPlot;
sc2(1).FaceAlpha = 0;

exportgraphics(fig, "fig3.jpg", "Resolution", 600)

function sc = helperPlot
x = -3:0.05:3;
y = -3:0.05:3;
[X, Y] = meshgrid(x, y);
fnc = @(x,y) x.*y.^2;
f = fnc(X,Y);
theta = 0:0.01:2*pi;
xx = sqrt(3)*cos(theta);
yy = sqrt(3)*sin(theta);
g = fnc(xx,yy);

hold(gca, "on")
box(gca, "on")
grid(gca, "on")
colormap("jet")
sc = surfc(X, Y, f, "EdgeColor", "none");
sc(1).FaceAlpha = 0.7;
sc(2).LevelList = min(f,[],"all"):0.4:max(f,[],"all");
sc(2).LineWidth = 1.5;
plot3(xx, yy, g, "LineWidth", 1.5, "Color", "k")
level = min(min(f))-3;
plot3(xx, yy, level*ones(size(xx)), "LineWidth", 1.5, "Color", "k")

x1 = sqrt(3);
y1 = 0;
fnc1 = fnc(x1,y1);

x2 = -sqrt(3);
y2 = 0;
fnc2 = fnc(x2,y2);

x3 = 1;
y3 = sqrt(2);
fnc3 = fnc(x3,y3);

x4 = 1;
y4 = -sqrt(2);
fnc4 = fnc(x4,y4);

x5 = -1;
y5 = sqrt(2);
fnc5 = fnc(x5,y5);

x6 = -1;
y6 = -sqrt(2);
fnc6 = fnc(x6,y6);

scatter3([x1, x2, x3, x4, x5, x6], [y1, y2, y3, y4, y5, y6], [fnc1, fnc2, fnc3, fnc4, fnc5, fnc6], 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
scatter3([x1, x2, x3, x4, x5, x6], [y1, y2, y3, y4, y5, y6], [level, level, level, level, level, level], 20, "filled", ...
    "MarkerEdgeColor", "k", "MarkerFaceColor", "k")
plot3([x1, x1], [y1, y1], [level, fnc1], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x2, x2], [y2, y2], [level, fnc2], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x3, x3], [y3, y3], [level, fnc3], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x4, x4], [y4, y4], [level, fnc4], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x5, x5], [y5, y5], [level, fnc5], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
plot3([x6, x6], [y6, y6], [level, fnc6], "LineWidth", 1.5, "LineStyle", "--", "Color", "k")
text(x1, y1, fnc1+0.5, "$(\sqrt{3},0,0)$", "Interpreter", "latex", "FontSize", 12)
text(x2, y2, fnc2+0.5, "$(-\sqrt{3},0,0)$", "Interpreter", "latex", "FontSize", 12)
text(x3, y3, fnc3+0.5, "$(1,\sqrt2,2)$", "Interpreter", "latex", "FontSize", 12)
text(x4, y4, fnc4+0.5, "$(1,-\sqrt2,2)$", "Interpreter", "latex", "FontSize", 12)
text(x5, y5, fnc5+0.5, "$(-1,\sqrt2,-2)$", "Interpreter", "latex", "FontSize", 12)
text(x6, y6, fnc6+0.5, "$(-1,-\sqrt2,-2)$", "Interpreter", "latex", "FontSize", 12)

xlabel("$x$", "Interpreter", "latex", "FontSize", 20)
ylabel("$y$", "Interpreter", "latex", "FontSize", 20)
zlabel("$f$", "Interpreter", "latex", "FontSize", 20)
end
```

<br>

**References**

[^1]: [Lagrange multiplier](https://en.wikipedia.org/wiki/Lagrange_multiplier).
[^2]: [The Gradient is Perpendicular to the Tangent of the Contour Line](/2022-11-07/11-12-11.html).
