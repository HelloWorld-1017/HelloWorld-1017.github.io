---
title: Matrix Calculus
categories:
 - Mathematics
tags:
 - Calculus
 - Matrix
date: 2025-04-08 16:08:26 +0800
last_modified_at: 2025-04-10 12:44:08 +0800
---

# Fundamentals

## The gradient

For a scalar function $f(\cdot)$ which takes a matrix $\boldsymbol{\mathrm{A}}\in\mathbb{R}^{m\times n}$ as input, then the <i class="term">gradient</i> of $f(\boldsymbol{\mathrm{A}})$, with respect to $\boldsymbol{\mathrm{A}}$, is defined as:

$$
\nabla_\boldsymbol{\mathrm{A}}f(\boldsymbol{\mathrm{A}})=\begin{bmatrix}
\dfrac{\partial f(\boldsymbol{\mathrm{A}})}{\partial A_{11}} & \dfrac{\partial f(\boldsymbol{\mathrm{A}})}{\partial A_{12}} & \cdots & \dfrac{\partial f(\boldsymbol{\mathrm{A}})}{\partial A_{1n}}\\
\dfrac{\partial f(\boldsymbol{\mathrm{A}})}{\partial A_{21}} & \dfrac{\partial f(\boldsymbol{\mathrm{A}})}{\partial A_{22}} & \cdots & \dfrac{\partial f(\boldsymbol{\mathrm{A}})}{\partial A_{2n}}\\
\vdots & \vdots & \ddots & \vdots \\
\dfrac{\partial f(\boldsymbol{\mathrm{A}})}{\partial A_{m1}} & \dfrac{\partial f(\boldsymbol{\mathrm{A}})}{\partial A_{m2}} & \cdots & \dfrac{\partial f(\boldsymbol{\mathrm{A}})}{\partial A_{mn}}\\
\end{bmatrix}\in\mathbb{R}^{m\times n}
$$

that is:

$$
\Big(\nabla_\boldsymbol{\mathrm{A}}f(\boldsymbol{\mathrm{A}})\Big)_{ij} = 
\dfrac{\partial f(\boldsymbol{\mathrm{A}})}{\partial A_{ij}}
$$

The definition is of course available for a vector $\boldsymbol{\mathrm{x}}\in\mathbb{R}^n$:

$$
\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}})=\begin{bmatrix}
\dfrac{\partial f(\boldsymbol{\mathrm{x}})}{\partial x_1}\\
\dfrac{\partial f(\boldsymbol{\mathrm{x}})}{\partial x_2}\\
\vdots\\
\dfrac{\partial f(\boldsymbol{\mathrm{x}})}{\partial x_n}\\
\end{bmatrix}\in\mathbb{R}^n\label{eq1}
$$

that is:

$$
\Big(\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}})\Big)_i = 
\dfrac{\partial f(\boldsymbol{\mathrm{x}})}{\partial x_i}
$$

## The Hessian matrix

For a scalar function $f(\cdot)$ which takes a vector $\boldsymbol{\mathrm{x}}\in\mathbb{R}^n$ as input, then the <i class="term">Hessian matrix</i> of $f(\boldsymbol{\mathrm{x}})$, with respect to $\boldsymbol{\mathrm{x}}$, is defined as[^9]:

$$
\nabla_\boldsymbol{\mathrm{x}}^2f(\boldsymbol{\mathrm{x}})=\begin{bmatrix}
\dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_1^2} & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_1 \partial x_2} & \cdots & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_1 \partial x_n} \\
\dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_1 \partial x_2} & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_2^2} & \cdots & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_2 \partial x_n} \\
\vdots & \vdots & \ddots & \vdots \\
\dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_1 \partial x_n} & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_2 \partial x_n} & \cdots & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_n^2}
\end{bmatrix}\in\mathbb{R}^{n\times n}\label{eq2}
$$

that is:

$$
\Big(\nabla_\boldsymbol{\mathrm{x}}^2f(\boldsymbol{\mathrm{x}})\Big)_{ij} =\dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_i\partial x_j}
$$

<div class="notice--primary" markdown="1">

The Hessian matrix is always symmetric because:

$$
\dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_i\partial x_j} = \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_j\partial x_i}\notag
$$

</div>

## The relation between gradient and Hessian matrix

According to Eq. $\eqref{eq1}$ and Eq. $\eqref{eq2}$, we can re-write the Hessian matrix of $f(\boldsymbol{\mathrm{x}})$ by:

$$
\nabla_\boldsymbol{\mathrm{x}}^2f(\boldsymbol{\mathrm{x}}) = \begin{bmatrix}
\nabla_\boldsymbol{\mathrm{x}}(\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}}))_1 & \nabla_\boldsymbol{\mathrm{x}}(\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}}))_2 & \cdots & \nabla_\boldsymbol{\mathrm{x}}(\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}}))_n
\end{bmatrix}\label{eq3}
$$

<div class="quote--left" markdown="1">

It is natural to think of the gradient as the analogue of the <i class="emphasize">first derivative</i> for functions of vectors, and the Hessian as the analogue of the <i class="emphasize">second derivative</i> (and the symbols we use also suggest this relation). This intuition is generally correct, ...[^1]

</div>

To take a step further. For a vector-valued function $\boldsymbol{\mathrm{f}}: \mathbb{R}^n\rightarrow\mathbb{R}^m$, which takes a vector $\boldsymbol{\mathrm{x}}\in\mathbb{R}^n$ as input and produces a vector $\boldsymbol{\mathrm{f}}(\boldsymbol{\mathrm{x}})\in\mathbb{R}^m$ as output, the <i class="term">Jacobian matrix</i> is defined as[^2][^3][^4]:

$$
\boldsymbol{\mathrm{J}}(\boldsymbol{\mathrm{f}}) = 
\begin{bmatrix}
\dfrac{\partial f_1}{\partial x_1} & \dfrac{\partial f_1}{\partial x_2}  & \cdots & \dfrac{\partial f_1}{\partial x_n} \\ 
\dfrac{\partial f_2}{\partial x_1} & \dfrac{\partial f_2}{\partial x_2}  & \cdots & \dfrac{\partial f_2}{\partial x_n} \\
\vdots & \vdots & \ddots & \vdots \\
\dfrac{\partial f_m}{\partial x_1} & \dfrac{\partial f_m}{\partial x_2}  & \cdots & \dfrac{\partial f_m}{\partial x_n}
\end{bmatrix}\in\mathbb{R}^{n\times m}
$$

So we have:

$$
\boldsymbol{\mathrm{J}}(\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}}))=\begin{bmatrix}
\dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_1^2} & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_1\partial x_2} & \cdots & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_1\partial x_n}\\
\dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_1\partial x_2} & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_2^2} & \cdots & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_2\partial x_n}\\
\vdots & \vdots & \ddots & \vdots \\
\dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_1\partial x_n} & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_2\partial x_n} & \cdots & \dfrac{\partial^2f(\boldsymbol{\mathrm{x}})}{\partial x_n^2}\\
\end{bmatrix}
$$

that is:

$$
\nabla_\boldsymbol{\mathrm{x}}^2f(\boldsymbol{\mathrm{x}}) = \boldsymbol{\mathrm{J}}(\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}}))\label{eq4}
$$

Of course, we can also deduce Eq. $\eqref{eq4}$ directly from Eq. $\eqref{eq3}$. 

<br>

# Some examples

After introducing the definitions of the gradient and the Hessian matrix, we can see some common examples.

## $\nabla_\boldsymbol{\mathrm{x}} (\boldsymbol{\mathrm{b}}^T\boldsymbol{\mathrm{x}}) = \boldsymbol{\mathrm{b}}$

For a vector $\boldsymbol{\mathrm{x}}\in\mathbb{R}^n$, consider a scalar function with a known vector $\boldsymbol{\mathrm{b}}\in\mathbb{R}^n$:

$$
f(\boldsymbol{\mathrm{x}}) = \boldsymbol{\mathrm{b}}^T\boldsymbol{\mathrm{x}} = 
\sum_i^n(b_ix_i)\notag
$$

we can get:

$$
\Big(\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}})\Big)_i = 
\dfrac{\partial f(\boldsymbol{\mathrm{x}})}{\partial x_i} = b_i\notag
$$

that is:

$$
\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}}) = \boldsymbol{\mathrm{b}}\notag
$$

i.e.

$$
\nabla_\boldsymbol{\mathrm{x}} (\boldsymbol{\mathrm{b}}^T\boldsymbol{\mathrm{x}}) = \boldsymbol{\mathrm{b}}\label{eq6}
$$

## $\nabla_\boldsymbol{\mathrm{x}}(\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}) = 2\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}$ ($\boldsymbol{\mathrm{A}}$ is symmetric)

For a vector $\boldsymbol{\mathrm{x}}\in\mathbb{R}^n$, consider a scalar function (quadratic function) with a known symmetric matrix $\boldsymbol{\mathrm{A}}\in\mathbb{S}^n$:

$$
f(\boldsymbol{\mathrm{x}}) = \boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}=\sum_i^n\sum_j^na_{ij}x_ix_j\label{eq5}
$$

we can calculate the gradient of vector $\boldsymbol{\mathrm{x}}$ is:

$$
\begin{split}
\Big(\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}})\Big)_k &= \dfrac{\partial}{\partial x_k}\Big(\sum_i^n\sum_j^nA_{ij}x_ix_j\Big)\\
&=2A_{kk}x_k+\sum_{i\neq k}A_{ki}x_i+\sum_{i\neq k}A_{ik}x_i\\
(\text{cause }\boldsymbol{\mathrm{A}}\text{ is symmetric})&=2A_{kk}x_k+2\sum_{i\neq k}A_{ki}x_i\\
&=2\sum_{i=1}^nA_{ki}x_i
\end{split}\notag
$$

then we have:

$$
\nabla_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}}) = 2\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}\notag
$$

that is:

$$
\nabla_\boldsymbol{\mathrm{x}}(\boldsymbol{\mathrm{x}}^TA\boldsymbol{\mathrm{x}}) = 2\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}\label{eq7}
$$

## $\nabla_\boldsymbol{\mathrm{x}}^2 (\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}) = 2\boldsymbol{\mathrm{A}}$ ($\boldsymbol{\mathrm{A}}$ is symmetric)

Also for Eq. $\eqref{eq5}$, we can calculate the Hessian matrix of vector $\boldsymbol{\mathrm{x}}$ is:

$$
\begin{split}
\Big(\nabla^2_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}})\Big)_{kl} &= \dfrac{\partial^2}{\partial x_k \partial x_l}\Big(\sum_i^n\sum_j^nA_{ij}x_ix_j\Big)\\
& = \dfrac{\partial}{\partial x_l} \Big(2\sum_{i=1}^nA_{ki}x_i\Big)\\
& = 2A_{kl}
\end{split}\notag
$$

then:

$$
\nabla^2_\boldsymbol{\mathrm{x}}f(\boldsymbol{\mathrm{x}}) = 2\boldsymbol{\mathrm{A}}\notag
$$

that is:

$$
\nabla_\boldsymbol{\mathrm{x}}^2 (\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}) = 2\boldsymbol{\mathrm{A}}
$$

## Calculate the least squares solution

To derive the least squares solution, we should minimize the function $$\vert\vert\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{b}}\vert\vert_2^2$$, where[^5][^6][^7]:

$$
\begin{split}
\vert\vert\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{b}}\vert\vert_2^2 &= (\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{b}})^T(\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{b}}) \\&= (\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}^T-\boldsymbol{\mathrm{b}}^T)(\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{b}})\\
&= \boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}^T\boldsymbol{\mathrm{b}}-\boldsymbol{\mathrm{b}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}+\boldsymbol{\mathrm{b}}^T\boldsymbol{\mathrm{b}}\\
& =\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-2\boldsymbol{\mathrm{b}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}+\boldsymbol{\mathrm{b}}^T\boldsymbol{\mathrm{b}}
\end{split}\notag
$$

based on Eq. $\eqref{eq6}$ and Eq. $\eqref{eq7}$, we have:

$$
\begin{split}
\nabla_{\boldsymbol{\mathrm{x}}}\Big(\vert\vert\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{b}}\vert\vert_2^2\Big) &= \nabla_{\boldsymbol{\mathrm{x}}}\Big(\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}\Big) + \nabla_{\boldsymbol{\mathrm{x}}}\Big(2\boldsymbol{\mathrm{b}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}\Big) + \nabla_{\boldsymbol{\mathrm{x}}}\Big(\boldsymbol{\mathrm{b}}^T\boldsymbol{\mathrm{b}}\Big)\\
&= 2\boldsymbol{\mathrm{A}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-2\boldsymbol{\mathrm{A}}^T\boldsymbol{\mathrm{b}}
\end{split}\notag
$$

which means that the least squares solution exists where $$\nabla_{\boldsymbol{\mathrm{x}}}\Big(\vert\vert \boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-\boldsymbol{\mathrm{b}}\vert\vert_2^2\Big)=0$$, that is the solution is:

$$
\boldsymbol{\mathrm{x}} = (\boldsymbol{\mathrm{A}}^T\boldsymbol{\mathrm{A}})^{-1}\boldsymbol{\mathrm{A}}^T\boldsymbol{\mathrm{b}}
$$

## $\nabla_\boldsymbol{\mathrm{A}} (\mathrm{det}(\boldsymbol{\mathrm{A}})) = \mathrm{det}(\boldsymbol{\mathrm{A}})\boldsymbol{\mathrm{A}}^{-T}$

Consider the gradient of the determinant of a square matrix $\boldsymbol{\mathrm{A}}$.

The definition of determinant is[^8]:

$$
\mathrm{det}(\boldsymbol{\mathrm{A}}) = \sum_{j=1}^nA_{ij}\mathrm{cof}(\boldsymbol{\mathrm{A}},i,j),\ \text{for }\forall i=1,2,...n\notag
$$

so we have:

$$
\dfrac{\partial}{\partial A_{kl}}\mathrm{det}(\boldsymbol{\mathrm{A}}) = \dfrac{\partial}{\partial A_{kl}}\Big(\sum_{j=1}^nA_{ij}\mathrm{cof}(\boldsymbol{\mathrm{A}},i,j)\Big)=\mathrm{cof}(\boldsymbol{\mathrm{A}},k,l)\notag
$$

where $\mathrm{cof}(\boldsymbol{\mathrm{A}},i,j)$ is the cofactor of matrix element $\boldsymbol{\mathrm{A}}_{ij}$, see[^8]. Therefore,

$$
\dfrac{\partial}{\partial \boldsymbol{\mathrm{A}}}\mathrm{det}(\boldsymbol{\mathrm{A}}) = \mathrm{cof}(\boldsymbol{\mathrm{A}})=(\mathrm{adj}(\boldsymbol{\mathrm{A}}))^T\notag
$$

due to that[^8]:

$$
\boldsymbol{\mathrm{A}}^{-1} = \dfrac1{\mathrm{det}(\boldsymbol{\mathrm{A}})}\mathrm{adj}(\boldsymbol{\mathrm{A}})\notag
$$

so we have:

$$
\dfrac{\partial}{\partial \boldsymbol{\mathrm{A}}}\mathrm{det}(\boldsymbol{\mathrm{A}}) = \mathrm{det}(\boldsymbol{\mathrm{A}})\boldsymbol{\mathrm{A}}^{-T}\label{eq8}
$$

## $\nabla_\boldsymbol{\mathrm{A}}(\log\mathrm{det}(\boldsymbol{\mathrm{A}})) = \boldsymbol{\mathrm{A}}^{-1}$ ($\boldsymbol{\mathrm{A}}$ is symmetric)

Step further. According to Eq. $\eqref{eq8}$, we can calculate the results of $$\nabla_\boldsymbol{\mathrm{A}}(\log\mathrm{det}(\boldsymbol{\mathrm{A}}))$$:

$$
\begin{split}
\nabla_\boldsymbol{\mathrm{A}}(\log\mathrm{det}(\boldsymbol{\mathrm{A}})) &= \dfrac{\partial\Big(\log\mathrm{det}(\boldsymbol{\mathrm{A}})\Big)}{\partial\boldsymbol{\mathrm{A}}}\\
&=\dfrac{\partial\Big(\log\mathrm{det}(\boldsymbol{\mathrm{A}})\Big)}{\partial\mathrm{det}(\boldsymbol{\mathrm{A}})}\dfrac{\partial\mathrm{det}(\boldsymbol{\mathrm{A}})}{\partial\boldsymbol{\mathrm{A}}}\\
&=\dfrac1{\mathrm{det}(\boldsymbol{\mathrm{A}})}\times\mathrm{det}(\boldsymbol{\mathrm{A}})\boldsymbol{\mathrm{A}}^{-T} \\
&= \boldsymbol{\mathrm{A}}^{-T}
\end{split}\notag
$$

when $\boldsymbol{\mathrm{A}}$ is symmetric, we can drop the transpose:

$$
\nabla_\boldsymbol{\mathrm{A}}(\log\mathrm{det}(\boldsymbol{\mathrm{A}})) = \boldsymbol{\mathrm{A}}^{-1}
$$

## Maximize/minimize $\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}$ assuming $||\boldsymbol{\mathrm{x}}||_2^2=1$

Consider the following optimization problem:

$$
\max_{\boldsymbol{\mathrm{x}}\in\mathbb{R}^n} \boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}, \quad\mathrm{s.t.}\ ||\boldsymbol{\mathrm{x}}||_2^2=1\notag
$$

We can solve it using Lagrange multipliers, which converts the problem with equalities into the one with no constraints:

$$
\mathscr{L} (\boldsymbol{\mathrm{x}},\lambda) = \boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-\lambda\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{x}}\notag
$$

based on Eq. $\eqref{eq6}$ and $\eqref{eq7}$, we’ll have:

$$
\nabla_{\boldsymbol{\mathrm{x}}}(\mathscr{L}) = 2\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}-2\lambda\boldsymbol{\mathrm{x}}\notag
$$

so we get that, when the following equation holds:

$$
\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}=\lambda\boldsymbol{\mathrm{x}}\label{eq9}
$$

which means, when $\boldsymbol{\mathrm{x}}$ is the eigenvector of $\boldsymbol{\mathrm{A}}$, the value of $(\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}})$ is maximum, and whose value is the eigenvalue of corresponding eigenvector. 

Actually, when we try to solve the minimization:

$$
\min_{\boldsymbol{\mathrm{x}}\in\mathbb{R}^n} \boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}, \quad\mathrm{s.t.}\ ||\boldsymbol{\mathrm{x}}||_2^2=1\notag
$$

we’ll get the same solution as Eq. $\eqref{eq9}$.

So, to conclude,

<div class="quote--left" markdown="1">

... the only points which can possibly maximize (or minimize) $\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{A}}\boldsymbol{\mathrm{x}}$ assuming $\boldsymbol{\mathrm{x}}^T\boldsymbol{\mathrm{x}}$ are the eigenvectors of $\boldsymbol{\mathrm{A}}$.[^1]

</div>

<br>

**References**

[^1]: [Review Notes and Supplementary Notes CS229 Course Machine Learning Standford University](https://www.ctanujit.org/uploads/2/5/3/9/25393293/mathematics_for_machine_learning__cs229__1.pdf), chapter 1: Linear Algebra Review and Reference, pp. 16-20.
[^2]: [Jacobian matrix and determinant](https://en.wikipedia.org/wiki/Jacobian_matrix_and_determinant).
[^3]: [Solve Nonlinear Equation (System) using Iterative Method](/2022-07-12/13-45-17.html).
[^4]: [Vector Derivative](/2022-07-14/17-45-25.html).
[^5]: [View Least Square Method (LSM) from Perspectives of Curve Fitting, Parameter Estimation, and Geometry Meaning of Solving Over-determined Equations](/2022-07-07/15-36-27.html).
[^6]: [Least Square Method (LSM) with L2 Regularization and Maximum A Posteriori (MAP) Estimation](/2022-07-07/14-27-34.html).
[^7]: [Solve Overdetermined System](/2022-07-10/15-29-33.html).
[^8]: [Cofactor, Matrix of Cofactors, Adjoint, and Determinant of A Matrix](/2025-04-08/15-52-28.html).
[^9]: [Hessian matrix](/2024-12-17/20-21-18.html).
