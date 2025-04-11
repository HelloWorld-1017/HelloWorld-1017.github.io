---
title: Convex Set
toc: false
categories:
 - Mathematics
tags:
 - Matrix
 - Optimization
date: 2025-04-11 10:01:29 +0800
last_modified_at: 2025-04-11 14:55:17 +0800
---

The convex set is[^1]:

<div class="quote--left" markdown="1">

A set $C$ is <i class="term">convex</i> if, for any $x,y\in C$ and $\theta\in\mathbb{R}$ with $0\le\theta\le1$,

$$
\theta x+(1-\theta)y\in C.\label{eq1}
$$

Intuitively, this means that if we take any two elements in $C$, and draw a line segment between these two elements, then every point on that line segment also belongs to $C$. Figure 1 shows an example of one convex and one non-convex set. The point $\theta x+(1-\theta)y$ is called a <i class="term">convex combination</i> of the points $x$ and $y$.

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504111019500.png" alt="image-20250411101913406" style="width:67%;" />

</div>

Here is a property of the convex set $C$:

Given $k$ points $x_1,x_2,\cdots,x_k$ in the convex set $C$, and $k$ non-negative numbers $\theta_1,\theta_2,\cdots,\theta_k$ (i.e. $\theta_k\ge0$ for all $i=1,\cdots,k$) such that $\theta_1+\theta_2+\cdots+\theta_k=1$, then the affine combination

$$
x=\sum_{i=1}^k\theta_kx_k,\notag
$$

a.k.a. a convex combination, also belongs to $C$[^2].Furthermore,

- when $k=2$, the combination is actually the definition of convex set $\eqref{eq1}$.
- it can also be said that, a set is convex if and only if it contains every convex combination of its points[^3].

There are some classic convex sets[^1]:

**(1) All of $\mathbb{R}^n$**

For any $\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{y}}\in\mathbb{R}^n$, $0\le\theta\le1$:

$$
\theta \boldsymbol{\mathrm{x}}+(1-\theta)\boldsymbol{\mathrm{y}}\in\mathbb{R}^n\notag
$$

<br>

**(2) The non-negative orthant, $\mathbb{R}_{+}^n$.**

The non-negative orthant consists of all vectors in $\mathbb{R}^n$ whose elements are all non-negative, i.e. $$\mathbb{R}_{+}^n=\{\boldsymbol{\mathrm{x}}: x_i\ge0,\forall i=1,\cdots,n\}$$. For any $$\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{y}}\in\mathbb{R}^n_{+}$$ and $0\le\theta\le1$, we have:

$$
\big(\theta\boldsymbol{\mathrm{x}}+(1-\theta)\boldsymbol{\mathrm{y}}\big)_i = \theta x_i+(1-\theta)y_i\ge0, \forall i\notag
$$

because $x_i,y_i,\theta,(1-\theta)$ are all greater than or equal to zero. Therefore, we can say:

$$
\big(\theta\boldsymbol{\mathrm{x}}+(1-\theta)\boldsymbol{\mathrm{y}}\big)\in\mathbb{R}_{+}^n\notag
$$

And similarly, we can prove that the non-positive orthant is also a convex set.

<br>

**(3) Norm balls[^5]**

The set $$\{\boldsymbol{\mathrm{x}}:\vert\vert\boldsymbol{\mathrm{x}}\vert\vert\le1\}$$, where $\vert\vert\cdot\vert\vert$ is a norm, is a convex set. Let any $\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{y}}\in\mathbb{R}^n$, with $\vert\vert\boldsymbol{\mathrm{x}}\vert\vert\le1$, $\vert\vert\boldsymbol{\mathrm{y}}\vert\vert\le1$, and $0\le\theta\le1$, then we have:

$$
\vert\vert\theta\boldsymbol{\mathrm{x}}+(1-\theta)\boldsymbol{\mathrm{y}}\vert\vert\le
\vert\vert\theta\boldsymbol{\mathrm{x}}\vert\vert+\vert\vert(1-\theta)\boldsymbol{\mathrm{y}}\vert\vert
=\theta\vert\vert\boldsymbol{\mathrm{x}}\vert\vert+(1-\theta)\vert\vert\boldsymbol{\mathrm{y}}\vert\vert
\le1\notag
$$

This proof relies on the “triangle inequality” and “absolute homogeneity” of norms[^4].  Similarly, we can make a generalization that, the set $$\{\boldsymbol{\mathrm{x}}:\vert\vert\boldsymbol{\mathrm{x}}\vert\vert\le k\}$$, where $k\ge0$, is a convex set.

<br>

**(4) Affine subspaces and polyhedra**

Given a matrix $\boldsymbol{\mathrm{A}}\in\mathbb{R}^{m\times n}$ and a vector $\boldsymbol{\mathrm{b}}\in\mathbb{R}^m$, an <i class="term">affine subspace</i> is the set $$\{\boldsymbol{\mathrm{x}}\in\mathbb{R}^n:\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{b}}\}$$ (the set can be empty, if $\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{b}}$ has no solution from the perspective of solving equation system). Similarly, a <i class="term">polyhedron</i> is the set $$\{\boldsymbol{\mathrm{x}}\in\mathbb{R}^n:\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}\preceq\boldsymbol{\mathrm{b}}\}$$ (again, the set can be empty), where “$\preceq$” denotes component-wise inequality (i.e. each element of $\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}$ is less than or equal to the corresponding element in $\boldsymbol{\mathrm{b}}$)[^6]. We can prove that, affine subspaces and polyhedra are convex set.

For $\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{y}}\in\mathbb{R}^n$ such that $\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{y}}=\boldsymbol{\mathrm{b}}$, then for $0\le\theta\le1$:

$$
\boldsymbol{\mathrm{A}}\big(\theta\boldsymbol{\mathrm{x}}+(1-\theta)\boldsymbol{\mathrm{y}}\big)
=\theta\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}+(1-\theta)\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{y}} = \theta\boldsymbol{\mathrm{b}}+(1-\theta)\boldsymbol{\mathrm{b}} = \boldsymbol{\mathrm{b}}\notag
$$

i.e.

$$
\boldsymbol{\mathrm{A}}\big(\theta\boldsymbol{\mathrm{x}}+(1-\theta)\boldsymbol{\mathrm{y}}\big)=\boldsymbol{\mathrm{b}}\notag
$$

And similarly for $\boldsymbol{\mathrm{x}},\boldsymbol{\mathrm{y}}\in\mathbb{R}^n$ such that $\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}\preceq\boldsymbol{\mathrm{b}}$, $\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{y}}\preceq\boldsymbol{\mathrm{b}}$, and $0\le\theta\le1$:

$$
\boldsymbol{\mathrm{A}}\big(\theta\boldsymbol{\mathrm{x}}+(1-\theta)\boldsymbol{\mathrm{y}}\big)
=\theta\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}+(1-\theta)\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{y}}\preceq\theta\boldsymbol{\mathrm{b}}+(1-\theta)\boldsymbol{\mathrm{b}} = \boldsymbol{\mathrm{b}}\notag
$$

i.e.

$$
\boldsymbol{\mathrm{A}}\big(\theta\boldsymbol{\mathrm{x}}+(1-\theta)\boldsymbol{\mathrm{y}}\big)\preceq\boldsymbol{\mathrm{b}}\notag
$$

<br>

**(5) Intersections of convex sets**

Suppose that $C_1,C_2,\cdots,C_k$ are convex sets, then their <i class="term">intersection</i>

$$
\bigcap_{i=1}^kC_i=\{\boldsymbol{\mathrm{x}}:\boldsymbol{\mathrm{x}}\in C_i,\forall i=1,\cdots,k\}\notag
$$

is also a convex set. It’s obvious. But it should be noted that, the <i class="term">union</i> of several convex sets is not necessarily a convex set.

<br>

**(6) Positive semidefinite matrices**

The set of all symmetric positive semidefinite (PSD) matrices, a.k.a. <i class="term">positive semidefinite cone</i> $\mathbb{S}_{+}^n$[^7], is a convex set.  Consider two symmetric positive semidefinite matrices $$\boldsymbol{\mathrm{A}},\boldsymbol{\mathrm{B}}\in\mathbb{S}_{+}^n$$ and $$0\le\theta\le1$$, then for any $\boldsymbol{\mathrm{x}}\in\mathbb{R}^n$ we have:

$$
\boldsymbol{\mathrm{x}}(\theta\boldsymbol{\mathrm{A}}+(1-\theta)\boldsymbol{\mathrm{B}})\boldsymbol{\mathrm{x}}^T=\theta\boldsymbol{\mathrm{x}}\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}^T+(1-\theta)\boldsymbol{\mathrm{x}}\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{x}}^T\ge0\notag
$$

i.e.

$$
\boldsymbol{\mathrm{x}}(\theta\boldsymbol{\mathrm{A}}+(1-\theta)\boldsymbol{\mathrm{B}})\boldsymbol{\mathrm{x}}^T\ge0\notag
$$

In the same way, we can prove that, the sets of all positive definite (PD) $\mathbb{S}_{++}^n$, negative definite (ND) , and negative semidefinite (NSD) matrices are also convex.

<br>

**References**

[^1]: [Review Notes and Supplementary Notes CS229 Course Machine Learning Standford University](https://www.ctanujit.org/uploads/2/5/3/9/25393293/mathematics_for_machine_learning__cs229__1.pdf), Convex Optimization Overview, pp. 1-3.
[^2]: [Convex set](https://en.wikipedia.org/wiki/Convex_set).
[^3]: [Convex Sets](https://byjus.com/maths/convex-sets/).
[^4]: [Norm (mathematics)](https://en.wikipedia.org/wiki/Norm_\(mathematics\)).
[^5]: [p-norm ball](https://www.geogebra.org/m/pyxfvyyk).
[^6]: [LaTeX Component-wise Inequality Symbols: $\preceq$ and $\succeq$ etc.](/2025-04-11/13-04-11.html)
[^7]: In general, $\mathbb{S}^n\subset\mathbb{R}^{n\times n}$ denotes the set of $n\times n$ symmetric matrices.