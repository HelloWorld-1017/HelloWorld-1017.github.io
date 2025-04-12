---
title: The $\alpha$-sublevel Set of Convex Function
toc: false
categories:
 - Mathematics
tags:
 - Optimization
date: 2025-04-11 22:09:31 +0800
last_modified_at: 2025-04-11 22:09:31 +0800
---

The $\alpha$-sublevel set of convex function is defined as[^1]:

<div class="quote--left" markdown="1">
Convex functions[^2] give rise to a particularly important type of convex set called an $\alpha$-sublevel set. Given a convex function $f:\mathbb{R}^n\rightarrow\mathbb{R}$ and a real number $\alpha\in\mathbb{R}$, the $\alpha$-sublevel set is defined as:

$$
C_{\alpha}=\{\boldsymbol{\mathrm{x}}\in\mathscr{D}(f):f(\boldsymbol{\mathrm{x}})\le\alpha\}\notag
$$

In other words, the $\alpha$-sublevel set is the set of ALL points $\boldsymbol{\mathrm{x}}$ such that $f(\boldsymbol{\mathrm{x}})\le\alpha$.

</div>

Due to the fact that $f$ is a convex function, now consider $\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{y}}\in C_\alpha$ (hence also $\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{y}}\in\mathscr{D}(f)$) such that $f(\boldsymbol{\mathrm{x}})\le\alpha$ and $f(\boldsymbol{\mathrm{y}})\le\alpha$, for $0\le\theta\le1$ we have :

$$
f(\theta\boldsymbol{\boldsymbol{\mathrm{x}}}+(1-\theta)\boldsymbol{\boldsymbol{\mathrm{y}}})\le\theta f(\boldsymbol{\boldsymbol{\mathrm{x}}})+(1-\theta)f(\boldsymbol{\boldsymbol{\mathrm{y}}})\le\theta\alpha+(1-\theta)\alpha=\alpha\notag
$$

i.e.

$$
f(\theta\boldsymbol{\boldsymbol{\mathrm{x}}}+(1-\theta)\boldsymbol{\boldsymbol{\mathrm{y}}})\le\alpha\notag
$$

which means that

$$
\theta\boldsymbol{\boldsymbol{\mathrm{x}}}+(1-\theta)\boldsymbol{\mathrm{y}}\in C_\alpha\notag
$$

In conclusion, $\boldsymbol{\mathrm{x}}$ and $\boldsymbol{\mathrm{y}}$ belong to $C_\alpha$, and $(\theta\boldsymbol{\boldsymbol{\mathrm{x}}}+(1-\theta)\boldsymbol{\mathrm{y}})$ also belongs to $C_\alpha$, so $C_\alpha$ is a convex set[^3]. To put it more concisely, “the $\alpha$-sublevel set of a convex function is convex”. Here is a one-dimensional case[^4].

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504121027156.png" alt="image-20250412102705069" style="width:33%;" />

And on the other hand, non-convex functions can also have convex $\alpha$-sublevel sets[^4]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504121030076.png" alt="image-20250412103011965" style="width:67%;" />

<br>

**References**

[^1]: [Review Notes and Supplementary Notes CS229 Course Machine Learning Standford University](https://www.ctanujit.org/uploads/2/5/3/9/25393293/mathematics_for_machine_learning__cs229__1.pdf), Convex Optimization Overview, p. 6.
[^2]: [Jensen’s Inequality, Convex Function, Concave Function, and Non-convex Function](/2025-04-10/14-17-44.html).
[^3]: [Convex Set](/2025-04-11/10-01-29.html).
[^4]: [CS257 Linear and Convex Optimization - Lecture 5](https://jhc.sjtu.edu.cn/public/courses/CS257/2020/slides/lec5.pdf).
