---
title: Jensen's Inequality, Convex Function, Concave Function, and Non-convex Function
categories:
 - Machine Learning
 - Mathematics
tags:
 - Optimization
 - Probability Theory and Mathematical Statistics
date: 2025-04-10 14:17:44 +0800
last_modified_at: 2025-04-10 17:41:59 +0800
---

# Jensen's Inequality

Jensen's inequality[^1]:

<div class="quote--left" markdown="1">

Jensen's inequality generalizes the statement that the secant line of a convex of a convex function lies above the graph of the function, which is Jensen's inequality for two points: the secant line consists of weighted means of the convex function (for $t\in[0,1]$),

$$
tf(x_1)+(1-t)f(x_2),
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

A twice-differentiable function $g\text{: }I\rightarrow\mathbb{R}$ is convex if and only if $f^{\prime\prime}(x)\ge0$ for all $x\in I$.

</div>

# Non-convex function

In addition to “convex function” and “concave function”, there is another commonly used term, “<i class="term">non-convex</i> function”, where “non-convex” literally means “not convex”:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504101618514.jpg" style="width:33%;" />

Fig. Convex vs. Not convex.[^5]

A non-convex function can be concave, but it seem that this therm more frequently refers to those functions neither convex nor concave, i.e. there is no a certain relation between $tf(x_1)+(1-t)f(x_2)$ and $f(tx_1+(1-t)x_2)$ for all $x_1$ and $x_2$ in the range.

One of the most significant differences between convex and non-convex functions is that, the convex function has only one global minimum, while non-convex function has both local minima and global minima[^6]:

<div class="quote--left" markdown="1"> 

When selecting an optimization algorithm, it is essential to consider whether the loss function is convex or non-convex. A convex loss function has only one global minimum and no local minima, making it easier to solve with a simpler optimization algorithm. However, a non-convex loss function has both local and global minima and requires an advanced optimization algorithm to find the global minimum.

...

Convex functions are particularly important because they have a unique global minimum. This means that if we want to optimize a convex function, we can be sure that we will always find the best solution by searching for the minimum value of the function. This makes optimization easier and more reliable.

...

A function is said to be non-convex if it is not convex. Geometrically, a non-convex function is one that curves downwards or has multiple peaks and valleys. Looks something like this:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504101651619.png" alt="image-20250410165138506" style="width:33%;" />

The challenge with non-convex functions is that they can have multiple local minima, which are points where the function has a lower value than all neighboring points.

This means that if we try to optimize a non-convex function, we may get stuck in a local minimum and miss the global minimum, which is the optimal solution we are looking for.

</div>

<br>

**References**

[^1]: [Jensen's inequality](https://en.wikipedia.org/wiki/Jensen%27s_inequality).
[^2]: [Jensen's Inequality](https://www.probabilitycourse.com/chapter6/6_2_5_jensen's_inequality.php).
[^3]: [ConvexFunction - Jensen's inequality](https://en.wikipedia.org/wiki/Jensen's_inequality#/media/File:ConvexFunction.svg).
[^4]: [Convex function](https://en.wikipedia.org/wiki/Convex_function).
[^5]: [Convex vs. Not-convex - Convex function](https://en.wikipedia.org/wiki/Convex_function#/media/File:Convex_vs._Not-convex.jpg).
[^6]: [Convex vs. Non-Convex Functions: Why it Matters in Optimization for Machine Learning](https://rumn.medium.com/convex-vs-non-convex-functions-why-it-matters-in-optimization-for-machine-learning-39cd9427dfcc).
