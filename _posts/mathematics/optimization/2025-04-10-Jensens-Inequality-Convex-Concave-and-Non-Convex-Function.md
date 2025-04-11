---
title: Jensen's Inequality, Convex Function, Concave Function, and Non-convex Function
categories:
 - Machine Learning
 - Mathematics
tags:
 - Optimization
 - Probability Theory and Mathematical Statistics
date: 2025-04-10 14:17:44 +0800
last_modified_at: 2025-04-11 20:24:28 +0800
---

# Jensen's Inequality

Jensen's inequality[^1]:

<div class="quote--left" markdown="1">

Jensen's inequality generalizes the statement that the secant line of a convex of a convex function lies above the graph of the function, which is Jensen's inequality for two points: the secant line consists of weighted means of the convex function (for $t\in[0,1]$),

$$
tf(x_1)+(1-t)f(x_2),\label{eq2}
$$

while the graph of the function is the <i class="term">convex</i> function of the weighted means,

$$
f(tx_1+(1-t)x_2).
$$

Thus, <i class="term">Jensen’s inequality</i> in this case is:

$$
f(tx_1+(1-t)x_2)\le tf(x_1)+(1-t)f(x_2).
$$

In the context of probability theory, it is generally stated in the following form: if $X$ is a random variable and $f$ is a convex function, then:

$$
f(E(X))\le E(f(X)).\label{eq1}
$$



<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504101535793.svg" style="width:50%;" />

Fig. Jensen's inequality generalizes the statement that a secant line of a convex function lies above its graph.[^3]

</div>

<div class="notice--primary" markdown="1">

<div class="quote--left" markdown="1">

Using induction[^7], this \[Eq. $\eqref{eq2}$\] can be fairly easily extended to convex combinations of more than one point,

$$
f\Big(\sum_{i=1}^k\theta_ix_i\Big)\le\sum_{i=1}^k\theta_if(x_i)\quad \text{for}\quad \sum_{i=1}^k\theta_i=1,\ \theta_i\ge0\ \forall i.\notag
$$

In fact, this can also be extended to infinite sums or integrals. In the latter case, the inequality can be written as:

$$
f\Big(\int p(x)x\mathrm{d}x\Big)\le\int p(x)f(x)\mathrm{d}x\quad \text{for}\quad \int p(x)\mathrm{d}x=1,\ p(x)\ge0\ \forall x.\notag
$$

</div>

</div>

and if the function is a <i class="term">concave</i> function, then the Jensen’s inequality is:

$$
f(tx_1+(1-t)x_2)\ge tf(x_1)+(1-t)f(x_2)
$$

and similar to Eq. $\eqref{eq1}$ there is:

$$
f(E(X))\ge E(f(X))
$$

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504101711916.png" style="zoom:50%;" />

Fig. Pictorial representation of a convex function and a concave function.[^2]

<br>

# Convex function and concave function

Actually, the definitions of “convex function” and “concave function” etc. are also based on the Jensen's inequality[^4]:

<div class="quote--left" markdown="1">

- The function $f$ is called <i class="term">convex</i> if and only if for all $0<t<1$ and all $x_1,x_2\in X$ such that $x_1\neq x_2$:

$$
f(tx_1+(1-t)x_2)\le tf(x_1)+(1-t)f(x_2)
$$

- The function $f$ is called <i class="term">strictly convex</i> if and only if for all $0<t<1$ and all $x_1,x_2\in X$ such that $x_1\neq x_2$:

$$
f(tx_1+(1-t)x_2)\le tf(x_1)+(1-t)f(x_2)
$$

- The function $f$ is said to be <i class="term">concave</i> (resp. <i class="term">strictly concave</i>) if $-f$ is <i class="term">convex</i> (resp. <i class="term">strictly convex</i>).

</div>

By the way, there is another practical method to determine if a function $f$ is convex[^2]:

<div class="quote--left" markdown="1">

A twice-differentiable function $f\text{: }I\rightarrow\mathbb{R}$ is convex if and only if $f^{\prime\prime}(x)\ge0$ for all $x\in I$.

</div>

There are two points should be specially mentioned:

(1) Strictly speaking, the domain of function $f$, $X$, also sometimes denoted as $\mathscr{D}(f)$, should be a convex set[^8], to technically guarantee that $f\big(\theta x_1+(1-\theta)x_2\big)$ is well defined.[^7]

(2) Although the notations (e.g. $x_1$ and $x_2$) and figures we used above make the input variables of the function $f$ look like scalars in $\mathbb{R}$ (which helps us better understand those notions), they actually refer to $n$-dimensional vectors more commonly, and the function $f$ is defined $\mathbb{R}^n\rightarrow\mathbb{R}$. Correspondingly, the above necessary and sufficient condition, i.e. $f$ is convex iff. $f^{\prime\prime}(x)\ge0$ for all $x\in I$, can be expressed more reasonably, which will be discussed in the later section of this post. See Eq. $\eqref{eq3}$.

<br>

# Non-convex function

In addition to “convex function” and “concave function”, there is another commonly used term, “<i class="term">non-convex</i> function”, where “non-convex” literally means “not convex”:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504101618514.jpg" style="width:33%;" />

Fig. Convex vs. Not convex.[^5]

A non-convex function can be concave, but it seem that this therm more frequently refers to those functions neither convex nor concave, i.e. there is no a certain relation between $tf(x_1)+(1-t)f(x_2)$ and $f(tx_1+(1-t)x_2)$ for all $x_1$ and $x_2$ in the range.

One of the most significant differences between convex and non-convex functions is that, the convex function has only one global minimum, while non-convex function has both local minima and global minima[^6]:

<div class="quote--left" markdown="1"> 

When selecting an optimization algorithm, it is essential to consider whether the loss function is convex or non-convex. <i class="emphasize">A convex loss function has only one global minimum and no local minima, making it easier to solve with a simpler optimization algorithm</i>. However, <i class="emphasize">a non-convex loss function has both local and global minima</i> and requires an advanced optimization algorithm to find the global minimum.

...

Convex functions are particularly important because they have a unique global minimum. This means that if we want to optimize a convex function, we can be sure that we will always find the best solution by searching for the minimum value of the function. This makes optimization easier and more reliable.

...

A function is said to be non-convex if it is not convex. Geometrically, a non-convex function is one that curves downwards or has multiple peaks and valleys. Looks something like this:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504101651619.png" alt="image-20250410165138506" style="width:33%;" />

The challenge with non-convex functions is that they can have multiple local minima, which are points where the function has a lower value than all neighboring points.

This means that if we try to optimize a non-convex function, we may get stuck in a local minimum and miss the global minimum, which is the optimal solution we are looking for.

</div>

# Conditions for convexity

## First order condition for convexity

The first order condition for convexity is[^7]:

<div class="quote--left" markdown="1">

Suppose a function $f:\mathbb{R}^n\rightarrow\mathbb{R}$ is differentiable (i.e., the gradient[^9] $\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}})$ exists at all points $\boldsymbol{\mathrm{x}}$ in the domain of $f$). Then $f$ is convex if and only if $\mathscr{D}(f)$ is a convex set and for all $\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{y}}\in\mathscr{D}(f)$,

$$
f(\boldsymbol{\mathrm{y}})\ge f(\boldsymbol{\mathrm{x}})+\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}})^T(\boldsymbol{\mathrm{y}}-\boldsymbol{\mathrm{x}})\notag
$$

The function $$f(\boldsymbol{\mathrm{x}})+\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}})^T(\boldsymbol{\mathrm{y}}-\boldsymbol{\mathrm{x}})$$ is also called the <i class="term">first-order approximation</i> to the function $f$ at the point $\boldsymbol{\mathrm{x}}$. Intuitively, this can be thought of as approximating $f$ with its tangent line at the point $\boldsymbol{\mathrm{x}}$. The first order condition for convexity says that <i class="emphasize">$f$ is convex if and only if the tangent line is a global underestimator of the function $f$</i>.  In other words, <i class="emphasize">if we take our function and draw a tangent line at any point, then every point on this line will lie below the corresponding point on $f$</i>.

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504111909330.png" alt="image-20250411190955203" style="width:67%;" />

Similar to the definition of convexity, $f$ will be strictly convex if this holds with strict inequality, concave if the inequality is reversed, and strictly concave if the reverse inequality is strict.

</div>

## Second order condition for convexity

The second order condition for convexity is[^7]:

<div class="quote--left" markdown="1">

Suppose a function $f:\mathbb{R}^n\rightarrow\mathbb{R}$ is twice differentiable (i.e., the Hessian[^9] $\nabla_{\boldsymbol{\mathrm{x}}}^2f(\boldsymbol{\mathrm{x}})$ is defined for all points $\boldsymbol{\mathrm{x}}$ in the domain of $f$). Then $f$ is convex if and only if $\mathscr{D}(f)$ is a convex set and its Hessian is positive semidefinite: i.e., for any $\boldsymbol{\mathrm{x}}\in\mathscr{D}(f)$,[^7]

$$
\nabla_{\boldsymbol{\mathrm{x}}}^2f(\boldsymbol{\mathrm{x}})\succeq0.\label{eq3}
$$

Here, the notation ‘$\succeq$’ when used in conjunction with matrices refers to positive semidefiniteness, rather than componentwise inequality[^8][^10].[^11] In one dimension, this is equivalent to the condition that the second derivative $f^{\prime\prime}(x)$ always be positive (i.e., the function always has positive curvature).

Again analogous to both the definition and first order conditions for convexity, $f$ is strictly convex if its Hessian is positive definite, concave if the Hessian is negative semidefinite, and strictly concave if the Hessian is negative definite.

</div>

<br>

**References**

[^1]: [Jensen's inequality](https://en.wikipedia.org/wiki/Jensen%27s_inequality).
[^2]: [Jensen's Inequality](https://www.probabilitycourse.com/chapter6/6_2_5_jensen's_inequality.php).
[^3]: [ConvexFunction - Jensen's inequality](https://en.wikipedia.org/wiki/Jensen's_inequality#/media/File:ConvexFunction.svg).
[^4]: [Convex function](https://en.wikipedia.org/wiki/Convex_function).
[^5]: [Convex vs. Not-convex - Convex function](https://en.wikipedia.org/wiki/Convex_function#/media/File:Convex_vs._Not-convex.jpg).
[^6]: [Convex vs. Non-Convex Functions: Why it Matters in Optimization for Machine Learning](https://rumn.medium.com/convex-vs-non-convex-functions-why-it-matters-in-optimization-for-machine-learning-39cd9427dfcc).
[^7]: [Review Notes and Supplementary Notes CS229 Course Machine Learning Standford University](https://www.ctanujit.org/uploads/2/5/3/9/25393293/mathematics_for_machine_learning__cs229__1.pdf), Convex Optimization Overview, pp. 3-5.
[^8]: [Convex Set](/2025-04-11/10-01-29.html).
[^9]: [Matrix Calculus](/2025-04-08/16-08-26.html).
[^10]: [LaTeX Component-wise Inequality Symbols: $\preceq$ and $\succeq$ etc.](/2025-04-11/13-04-11.html)
[^11]: “Similarly, for a symmetric matrix $\boldsymbol{\mathrm{X}}\in\mathbb{S}^n$, $\boldsymbol{\mathrm{X}}\preceq0$ denotes that $\boldsymbol{\mathrm{X}}$ is negative semidefinite. As with vector inequalities, ‘$\le$’ and ‘$\ge$’ are sometimes used in place of ‘$\preceq$’ and ‘$\succeq$’.  Despite their notational similarity to vector inequalities, these concepts are very different; in particular, $\boldsymbol{\mathrm{X}}\succeq0$ does not imply that $X_{ij}\ge0$ for all $i$ and $j$.”  
