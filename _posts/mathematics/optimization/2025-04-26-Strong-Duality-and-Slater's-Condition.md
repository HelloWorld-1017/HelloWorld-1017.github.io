---
title: Strong Duality and Slater's Condition
categories:
 - Mathematics
tags:
 - Optimization
date: 2025-04-26 21:30:32 +0800
last_modified_at: 2025-04-30 11:40:18 +0800
---

# Duality gap and strong duality

Blog[^3] introduces the weak duality in optimization: let $$p^*$$ and $$d^*$$ denote the optimal value of the primal optimization problem (minimization) and dual optimization problem (maximization), respectively, then the <i class="term">weak duality</i> expresses such a fact:

$$
d^*\le p^*\notag
$$

which inequality *always* holds for any any primal/dual optimization problems[^2], and the difference between the primal and dual optimal values, i.e., $$p^*-d^*\ge0$$, is sometimes called as <i class="term">duality gap</i>[^4][^5].

Furthermore, for some special optimization problems, the duality gap is zero, i.e., 

$$
d^*=p^*\notag
$$

which means the <i class="term">strong duality</i> holds (i.e., the duality gap is zero iff. strong duality holds).

<br>

# Slater’s condition and Slater’s theorem

Next, a very natural question is, what kind of conditions guarantee the strong duality?

The following text, we’ll discuss those conditions for <i class="emphasize">convex</i> optimization problems. Consider a convex optimization problem[^6]:

$$
\begin{split}
\min\ &f(\boldsymbol{\mathrm{x}})\\
\text{s.t. }
&g_i(\boldsymbol{\mathrm{x}})\le0,\quad i=1,\cdots,m\\
&h_i(\boldsymbol{\mathrm{x}})=0,\quad i=1,\cdots,p\\
\end{split}\label{eq1}
$$

Those conditions that guarantee strong duality *for convex optimization problems* are called as <i class="term">constraint qualifications</i>[^2], and one of constraint qualifications is <i class="term">Salter’s theorem</i>[^2][^7][^8] (or rather, Slater's condition is a specific example of a constraint qualification[^1]).

Firstly, for optimization $\eqref{eq1}$, the Slater’s condition is that[^2]:

<div class="quote--left" markdown="1">
There exists a primal feasible $\boldsymbol{\mathrm{x}}$ for which each inequality constraint is strictly satisfied, i.e., 

$$
g_i(\boldsymbol{\mathrm{x}})<0,\ \forall i
$$

</div>

In another word, Slater’s condition states that, there exists a feasible $\boldsymbol{\mathrm{x}}$ for which each inequality constraint is <i class="emphasize">not active</i>. For example, the following case satisfies the Slater’s condition:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504301134794.png" alt="image-20250430113403643" style="width:50%;" />

The opposite of Slater’s condition is, there isn’t any feasible solution that can strictly satisfied each inequality constraint, or, for all feasible solutions, we have $g_i(\boldsymbol{\mathrm{x}})=0$ for some $g_i$. For example, the following case doesn’t meet the Slater’s condition:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504301134312.png" alt="image-20250430113427140" style="width:50%;" />

Then, based on the Slater’s condition, we have Slater’s theorem[^7]:

<div class="quote--left" markdown="1">

If the problem is convex and Slater’s condition is satisfied, then strong duality holds.

</div>

And based on which we can also get that, if for all feasible solutions, $g_i(\boldsymbol{\mathrm{x}})=0$ for some $i$ (there always some constraints are active), then the strong duality doesn’t always hold (possibly holds or possibly not). So, the Slater’s condition is a <i class="emphasize">sufficient condition</i> of strong duality of convex optimization problems. 

Here is an example. For the optimization,

$$
\begin{split}
\min_{x}\ &x^2\\
\text{s.t. }\ &
\left\{
\begin{split}
&2-x\le0\\
&x-4\le0
\end{split}\right.
\end{split}\notag
$$

it is a convex optimization, and when $x=3$ we have $g_1(x)<0$ and $g_2(x)<0$, which therefore satisfies the Slater’s condition. As a result, we can say the strong duality holds for this optimization.

<br>

**References**

[^1]: [Slater's condition](https://en.wikipedia.org/wiki/Slater%27s_condition).
[^2]: [Review Notes and Supplementary Notes CS229 Course Machine Learning Standford University](https://www.ctanujit.org/uploads/2/5/3/9/25393293/mathematics_for_machine_learning__cs229__1.pdf), Convex Optimization Overview (cnt’d), Chuong B. Do, October 26, 2007, pp. 5-6.
[^3]: [Weak Duality in Optimization](/2025-04-22/10-13-58.html).
[^4]: [Duality (optimization)](https://en.wikipedia.org/wiki/Duality_(optimization)).
[^5]: [Duality gap](https://en.wikipedia.org/wiki/Duality_gap).
[^6]: [Convex Optimization Problem: “For a convex optimization problem, all locally optimal points are globally optima.”](/2025-04-12/16-36-23.html).
[^7]: [Note9.pdf](https://www.math.cuhk.edu.hk/course_builder/1920/math4230/Note9.pdf).
[^8]: [Slater's condition](https://en.wikipedia.org/wiki/Slater%27s_condition).