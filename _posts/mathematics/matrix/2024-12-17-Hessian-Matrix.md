---
title: Hessian matrix
toc: false
categories:
 - Mathematics
tags:
 - Matrix
date: 2024-12-17 20:21:18 +0800
last_modified_at: 2025-04-09 18:21:10 +0800
---

The Hessian matrix describes the local curvature of a multivariate function[^1]:

<div class="quote--left" markdown="1">

In mathematics, the <i class="term">Hessian matrix</i>, Hessian or (less commonly) <i class="term">Hesse matrix</i> is a square matrix of second-order partial derivatives of a scalar-valued function, or scalar field. <i class="emphasize">It describes the local curvature of a function of many variables.</i> The Hessian matrix was developed in the 19th century by the German mathematician Ludwig Otto Hesse and later named after him. Hesse originally used the term "functional determinants". The Hessian is sometimes denoted by $\mathrm{\boldsymbol{H}}$ or, ambiguously, by $\nabla^2$.

</div>

and it is formally defined as follows[^1]:

<div class="quote--left" markdown="1">

Suppose $f$: $\mathbb{R}^n\rightarrow\mathbb{R}$ is a function taking as input a vector $\mathrm{\boldsymbol{x}}\in\mathbb{R}^n$ and outputting a scalar $f(\mathrm{\boldsymbol{x}})\in\mathbb{R}$. If all second-order partial derivatives of $f$ exist, then the Hessian matrix $\mathrm{\boldsymbol{H}}$ of $f$ is a square $n\times n$ matrix, usually defined and arranged as:

$$
\mathrm{\boldsymbol{H}}_f=\begin{bmatrix}
\dfrac{\partial^2f}{\partial x_1^2} & \dfrac{\partial^2f}{\partial x_1\partial x_2} & \cdots & \dfrac{\partial^2f}{\partial x_1\partial x_n}\\
\dfrac{\partial^2f}{\partial x_2\partial x_1} & \dfrac{\partial^2f}{\partial x_2^2} & \cdots & \dfrac{\partial^2f}{\partial x_2\partial x_n}\\
\vdots & \vdots & \ddots & \vdots\\
\dfrac{\partial^2f}{\partial x_n\partial x_1} & \dfrac{\partial^2f}{\partial x_n\partial x_2} & \cdots & \dfrac{\partial^2f}{\partial x_n^2}\\
\end{bmatrix}\notag
$$

That is, the entry of the $i$-th row and the $j$-th column is:

$$
(\mathrm{\boldsymbol{H}}_f)_{i,j}=\dfrac{\partial^2f}{\partial x_i\partial x_j}\notag
$$

</div>

Here are some properties of it[^1]:

<div class="quote--left" markdown="1">

(1) If furthermore the second partial derivatives are all continuous, the Hessian matrix is a symmetric matrix by the symmetry of second derivatives.

(2) The determinant of the Hessian matrix is called the Hessian determinant.

(3) The Hessian matrix of a function $f$ is the transpose of the Jacobian matrix of the gradient of the function $f$:
$$
\mathrm{\boldsymbol{H}}(f(\mathrm{\boldsymbol{x}}))=\mathrm{\boldsymbol{J}}(\nabla f(\mathrm{\boldsymbol{x}}))^T\notag
$$

<div class="notice--primary" markdown="1">

Note: The transpose seems not necessary, because the Hessian matrix is symmetric. See[^2].

</div>

</div>

**References**

[^1]: [Hessian matrix](https://en.wikipedia.org/wiki/Hessian_matrix).
[^2]: [Matrix Calculus](/2025-04-08/16-08-26.html).