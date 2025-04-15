---
title: "Convex Optimization Problem: \"For a convex optimization problem, all locally optimal points are globally optima.\""
categories:
 - Mathematics
tags:
 - Matrix
 - Optimization
date: 2025-04-12 16:36:23 +0800
last_modified_at: 2025-04-15 16:05:21 +0800
---

# Convex optimization problem

A <i class="term">convex optimization problem</i> is[^1]:

$$
\begin{split}
\min\ &f(\boldsymbol{\mathrm{x}})\\
\text{s.t. } &\boldsymbol{\mathrm{x}}\in C
\end{split}\label{eq1}
$$

where $f$ is a convex function[^2], $C$ is a convex set[^3], and $\boldsymbol{\mathrm{x}}$ is the optimization variable. More specifically, it can be written as:

$$
\begin{split}
\min\ &f(\boldsymbol{\mathrm{x}})\\
\text{s.t. }
&g_i(\boldsymbol{\mathrm{x}})\le0,\quad i=1,\cdots,m\\
&h_i(\boldsymbol{\mathrm{x}})=0,\quad i=1,\cdots,p\\
\end{split}\label{eq2}
$$

where $f$ is a convex function, $g_i$ are convex functions, and $h_i$ are affine functions, and $\boldsymbol{\mathrm{x}}$ is the optimization variable.

Compared with $\eqref{eq1}$, the form $\eqref{eq2}$ explicitly defines a convex set $C$ by:

$$
\begin{split}
&g_i(\boldsymbol{\mathrm{x}})\le0,\quad i=1,\cdots,m\\
&h_i(\boldsymbol{\mathrm{x}})=0,\quad i=1,\cdots,p\\
\end{split}
$$

as for why the set $C$ defined by these constraints is convex:

- $g_i$ are convex functions, and hence their $0$-sublevel sets[^4] are convex sets, i.e., $g_i(\boldsymbol{\mathrm{x}})\le0,\forall i$ define a series of convex sets; (“... a convex function $g_i$ MUST be less than or equal to zero ... if we were to require that $g_i\ge0$ for some convex $g_i$, the feasible region would no longer be a convex set, and the algorithms we apply for solving these problems would not longer be guaranteed to find the global optimum.”[^1])
- $h_i$ are affine functions, and hence affine subspaces[^3] are convex sets, i.e., $h_i(\boldsymbol{\mathrm{x}})=0,\forall i$, define a series of convex sets; (“... only affine functions are allowed to be equality constraints. Intuitively, you can think of this as being due to the fact that an equality constraint is equivalent to the two inequalities $h_i\le0$ and $h_i\ge0$. However, these will both be valid constraints if and only if $h_i$ is both convex and concave, i.e. $h_i$ must be affine.”[^1][^2])
- therefore, the <i class="term">feasible region</i>, which is the intersection of above defined convex sets, is convex, i.e., the set $C$ is a convex set[^3].

The <i class="term">optimal value</i> of an optimization problem can be denoted as $$p^*$$ (or sometimes $$f^*$$) and is equal to the <i class="emphasize">minimum</i> possible value of the objective function in the feasible region[^1]:

$$
p^*=\min\{f(\boldsymbol{\mathrm{x}}):g_i(x)\le0,i=1,\cdots,m,\ h_i(x)=0,i=1,\cdots,p\}\notag
$$

By the way, this form better expresses such a fact that, the role of all constraints of an optimization problem is to define a domain of the objective function, and this domain is so-called the feasible region.
{: .notice--primary}

When the optimization problem is <i class="term">infeasible</i> (the feasible region is empty), $$p^*$$ will be taken as $+\infty$; when the problem is <i class="term">unbounded below</i>, $$p^*$$ will be $-\infty$ (there are feasible points such that $f(\boldsymbol{\mathrm{x}})\rightarrow-\infty$). And we can say that $\boldsymbol{\mathrm{x}}^*$ is an <i class="term">optimal point</i> if $$f(\boldsymbol{\mathrm{x}}^*)=\boldsymbol{\mathrm{p}}^*$$. Besides, there can exist more than one optimal point, even when the optimal value is finite.

<br>

# Global optimality of convex optimizations

The locally optimal point and globally optimal point of the optimization problem are formally defined as follows, respectively[^1]:

<div class="quote--left" markdown="1">

A point $\boldsymbol{\mathrm{x}}$ is <i class="term">locally optimal</i> if it is feasible (i.e., it satisfies the constraints of the optimization problem) and if there exists some $R>0$ such that ALL feasible points $\boldsymbol{\mathrm{z}}$ with $\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{z}}\vert\vert_2\le R$, satisfy $f(\boldsymbol{\mathrm{x}})\le f(\boldsymbol{\mathrm{z}})$.

</div>

This definition resembles the epsilon-delta language when defining the “limit”.[^5][^6]
{: .notice--primary}

<div class="quote--left" markdown="1">

A point $\boldsymbol{\mathrm{x}}$ is <i class="term">globally optimal</i> if it is feasible and for all feasible points $\boldsymbol{\mathrm{z}}$, $f(\boldsymbol{\mathrm{x}})\le f(\boldsymbol{\mathrm{z}})$.

</div>

One of the most important features of convex optimization problem is that[^1],

<div class="quote--left" markdown="1">

For a convex optimization problem, all locally optimal points are globally optima.

</div>

and here is a proof:

Suppose that, point $\boldsymbol{\mathrm{x}}$ is a locally optimal point but not globally optimal of a convex optimization, i.e., there is a feasible point $\boldsymbol{\mathrm{y}}$, which is a global optimal point, that satisfies $f(\boldsymbol{\mathrm{y}})<f(\boldsymbol{\mathrm{x}})$. Then, according to the definition of local optimality, there exists <i class="emphasize">no</i> feasible points $\boldsymbol{\mathrm{z}}$ such that $\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{z}}\vert\vert_2\le R$ (where $R>0$) and <i class="emphasize">satisfy $f(\boldsymbol{\mathrm{x}})>f(\boldsymbol{\mathrm{z}})$</i>.

But on the other hand, if we let:

$$
\boldsymbol{\mathrm{z}} = \theta\boldsymbol{\mathrm{y}}+(1-\theta)\boldsymbol{\mathrm{x}}\quad\text{where}\quad\theta=\dfrac{R}{2\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{y}}\vert\vert_2}>0\notag
$$

then due to that the feasible set is convex and both $\boldsymbol{\mathrm{x}}$ and $\boldsymbol{\mathrm{y}}$ are both feasible, and hence $\boldsymbol{\mathrm{z}}$ is also feasible, and we have:

$$
\begin{split}
\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{z}}\vert\vert_2
&=\Big\vert\Big\vert\boldsymbol{\mathrm{x}}-\Big(\dfrac{R}{2\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{y}}\vert\vert_2}\boldsymbol{\mathrm{y}}+(1-\dfrac{R}{2\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{y}}\vert\vert_2})\boldsymbol{\mathrm{x}}\Big)\Big\vert\Big\vert_2\\
&=\Big\vert\Big\vert\dfrac{R}{2\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{y}}\vert\vert_2}(\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{y}})\Big\vert\Big\vert_2\\
&=\dfrac{R}{2\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{y}}\vert\vert_2}\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{y}}\vert\vert_2\\
&=\dfrac{R}2\\
&<R
\end{split}\notag
$$

(where the last step is based on $R>0$) i.e.

$$
\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{z}}\vert\vert_2<R\notag
$$

However, due to that $f$ is a convex function, we have:

$$
\begin{split}
f(\boldsymbol{\mathrm{z}})
&=f(\theta\boldsymbol{\mathrm{y}}+(1-\theta)\boldsymbol{\mathrm{x}})\\
&\le\theta f(\boldsymbol{\mathrm{y}})+(1-\theta)f(\boldsymbol{\mathrm{x}})\\
&=f(\boldsymbol{\mathrm{x}})+\theta\big(f(\boldsymbol{\mathrm{y}})-f(\boldsymbol{\mathrm{x}})\big)\\
&<f(\boldsymbol{\mathrm{x}})
\end{split}\notag
$$

(where the last step holds true because $\theta>0$ and $f(\boldsymbol{\mathrm{y}})-f(\boldsymbol{\mathrm{x}})<0$) i.e.

$$
f(\boldsymbol{\mathrm{z}})<f(\boldsymbol{\mathrm{x}})\notag
$$

At last, we can conclude that, “we have a feasible point $\boldsymbol{\mathrm{z}}$ that satisfies $\vert\vert\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{z}}\vert\vert_2<R$ and $f(\boldsymbol{\mathrm{z}})<f(\boldsymbol{\mathrm{x}})$”, which contradicts our assumption.

<br>

# Examples of convex optimizations

Here are some examples of convex optimization problem[^1].

## Linear programming (LP)

A convex optimization problem is a <i class="term">linear programming (LP)</i> if both the objective $f$ and inequality constraints $g_i$ are affine functions, i.e.

$$
\begin{split}
\min\ &\boldsymbol{\mathrm{c}}^T\boldsymbol{\mathrm{x}}+d\\
\text{s.t. }
&\boldsymbol{\mathrm{G}}\boldsymbol{\mathrm{x}}\preceq\boldsymbol{\mathrm{h}}\\
&\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{b}}\\
\end{split}\label{eq3}
$$

where $\boldsymbol{\mathrm{x}}\in\mathbb{R}^n$ is the optimization variable, $\boldsymbol{\mathrm{c}}\in\mathbb{R}^n$, $d\in\mathbb{R}$, $\boldsymbol{\mathrm{G}}\in\mathbb{R}^{m\times n}$, $\boldsymbol{\mathrm{h}}\in\mathbb{R}^m$, $\boldsymbol{\mathrm{A}}\in\mathbb{R}^{p\times n}$, and $\boldsymbol{\mathrm{b}}\in\mathbb{R}^p$, and “$\preceq$” denotes elementwise inequality[^7].

## Quadratic programming (QP)

A convex optimization problem is a <i class="term">quadratic programming (QP)</i> if the inequality constraints $g_i$ are affine functions, and the objective function $f$ is a convex quadratic function, i.e.

$$
\begin{split}
\min\ &\frac12\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{P}}\boldsymbol{\mathrm{x}}+\boldsymbol{\mathrm{c}}^T\boldsymbol{\mathrm{x}}+d\\
\text{s.t. }
&\boldsymbol{\mathrm{G}}\boldsymbol{\mathrm{x}}\preceq\boldsymbol{\mathrm{h}}\\
&\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{b}}\\
\end{split}\label{eq4}
$$

where $\boldsymbol{\mathrm{x}}\in\mathbb{R}^n$ is the optimization variable, $\boldsymbol{\mathrm{c}}\in\mathbb{R}^n$, $d\in\mathbb{R}$, $\boldsymbol{\mathrm{G}}\in\mathbb{R}^{m\times n}$, $\boldsymbol{\mathrm{h}}\in\mathbb{R}^m$, $\boldsymbol{\mathrm{A}}\in\mathbb{R}^{p\times n}$, $\boldsymbol{\mathrm{b}}\in\mathbb{R}^p$, and symmetric positive semidefinite matrix $\boldsymbol{\mathrm{P}}\in\mathbb{S}^n_+$.

## Quadratically constrained quadratic programming (QCQP)

A convex optimization problem is a <i class="term">quadratically constrained quadratic programing (QCQP)</i> if both the objective $f$ and the inequality constraints $g_i$ are convex quadratic functions, i.e.

$$
\begin{split}
\min\ &\frac12\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{P}}\boldsymbol{\mathrm{x}}+\boldsymbol{\mathrm{c}}^T\boldsymbol{\mathrm{x}}+d\\
\text{s.t. }
&\frac12\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{Q}}_i\boldsymbol{\mathrm{x}}+\boldsymbol{\mathrm{r}}_i^T\boldsymbol{\mathrm{x}}+s_i\le0,\quad i=1,\cdots,m\\
&\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{b}}\\
\end{split}\label{eq5}
$$

where $\boldsymbol{\mathrm{x}}\in\mathbb{R}^n$ is the optimization variable, $\boldsymbol{\mathrm{c}}\in\mathbb{R}^n$, $d\in\mathbb{R}$, $\boldsymbol{\mathrm{A}}\in\mathbb{R}^{p\times n}$, $\boldsymbol{\mathrm{b}}\in\mathbb{R}^p$, $\boldsymbol{\mathrm{P}}\in\mathbb{S}^n_+$, and $$\boldsymbol{\mathrm{Q}}_i\in\mathbb{S}^n_+$$, $$\boldsymbol{\mathrm{r}}_i\in\mathbb{R}^n$$, $$s_i\in\mathbb{R}$$, for $i=1,\cdots,m$.

## Semidefinite programming (SDP)

A convex optimization problem is a <i class="term">semidefinite programming (SDP)</i> if it is of the form:

$$
\begin{split}
\min\ &\mathrm{tr}(\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{X}})\\
\text{s.t. }
&\mathrm{tr}(\boldsymbol{\mathrm{A}}_i\boldsymbol{\mathrm{X}})=b_i,\quad i=1,\cdots,p\\
&\boldsymbol{\mathrm{X}}\succeq0\\
\end{split}\label{eq6}
$$

where the symmetric matrix $\boldsymbol{\mathrm{X}}\in\mathbb{S}^n$ is the <i class="emphasize">optimization variable</i>, the symmetric matrices $\boldsymbol{\mathrm{C}},\boldsymbol{\mathrm{A}}_1,\cdots,\boldsymbol{\mathrm{A}}_p\in\mathbb{S}^n$, and $\boldsymbol{\mathrm{X}}\succeq0$ means that $\boldsymbol{\mathrm{X}}$ should be positive semidefinite[^7].

## Discussions

We can see that,

- LP $\eqref{eq3}$ is a special case of QP $\eqref{eq4}$, when $\boldsymbol{\mathrm{P}}=\boldsymbol{\mathrm{0}}$,
- QP $\eqref{eq4}$ is a special case of QCQP $\eqref{eq5}$, when each $\boldsymbol{\mathrm{Q}}_i=0$,

which are very obvious, and actually we also have,

- any QCQP (and hence QP or LP) can be expressed as a SDP $\eqref{eq6}$.

although it looks not that obvious (even confusing), it’s a very important and useful conclusion.

<br>

**References**

[^1]: [Review Notes and Supplementary Notes CS229 Course Machine Learning Standford University](https://www.ctanujit.org/uploads/2/5/3/9/25393293/mathematics_for_machine_learning__cs229__1.pdf), Convex Optimization Overview, pp. 7-10.
[^2]: [Jensen’s Inequality, Convex Function, Concave Function, and Non-convex Function](/2025-04-10/14-17-44.html).
[^3]: [Convex Set](/2025-04-11/10-01-29.html).
[^4]: [The $\alpha$-sublevel Set of Convex Function](/2025-04-11/22-09-31.html).
[^5]: [Limit (mathematics)](https://en.wikipedia.org/wiki/Limit_(mathematics)).
[^6]: [Limit of a function](https://en.wikipedia.org/wiki/Limit_of_a_function#(%CE%B5,_%CE%B4)-definition_of_limit).
[^7]: [LaTeX Component-wise Inequality Symbols: $\preceq$ and $\succeq$ etc.](/2025-04-11/13-04-11.html)