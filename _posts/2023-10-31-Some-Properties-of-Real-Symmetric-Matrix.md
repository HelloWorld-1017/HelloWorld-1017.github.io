---
layout: single
title: Some Properties of Real Symmetric Matrix
date: 2023-10-31 11:36:28 +0800
categories:
 - Mathematics
tags:
 - Matrix
---

# Eigenvalues and eigenvectors of real symmetric matrix

## All eigenvalues of real symmetric matrix are real.

***Theorem***: All eigenvalues of real symmetric matrix are real.

***Corollary***: All coefficients of the characteristic polynomial of real symmetric matrix are real.

***Corollary***: The trace of real symmetric matrix is real.

***Corollary***: The determinant of real symmetric matrix is real.

## Eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal [[1]](#ref-1), [[2]](#ref-2).

***Theorem***: Eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal [[1]](#ref-1), [[2]](#ref-2).

*Proof*: Supposed that $x_1$ and $x_2$ is two eigenvectors of a real symmetric matrix, and corresponding *different* eigenvalues are $\lambda_1$ and $\lambda_2$, i.e.,
$$
\begin{split}
Ax_1=\lambda_1x_1\\
Ax_2=\lambda_2x_2\\
\end{split}
$$

where

$$
\lambda_1\ne\lambda_2
$$

then we have:

$$
\textcolor{red}{x_2^TAx_1}=x_2^T\lambda_1x_1=\textcolor{red}{\lambda_1x_2^Tx_1}\label{eq1}
$$

due to that $x_2^Tx_1$ is a scalar, therefore $x_2^TAx_1$ is a scalar as well, so we have:

$$
\textcolor{red}{x_2^TAx_1}=(x_2^TAx_1)^T=x_1^TA^Tx_2=x_1^TAx_2=x_1^T\lambda_2x_2=\lambda_2(x_1^Tx_2)=\textcolor{red}{\lambda_2x_2^Tx_1}\label{eq2}
$$

N.B., If $a$ is a scalar, $a^T=a$ always holds.
{: .notice--primary}

According $\eqref{eq1}$ and $\eqref{eq2}$, we have:

$$
\lambda_1x_2^Tx_1=\lambda_2x_2^Tx_1
$$

Cause $\lambda_1\ne\lambda_2$, so we have:

$$
x_2^Tx_1=0
$$

that is $x_2$ and $x_1$ is orthogonal.

Q.E.D.

<br>

**References**

<div id="ref-1"></div>
[1] [对称矩阵 特征向量正交 - 知乎](https://zhuanlan.zhihu.com/p/83669028).

<div id="ref-2"></div>
[2] [46 Symmetric Matrices](https://staff.imsa.edu/~fogel/LinAlg/PDF/46%20Symmetric%20Matrices.pdf).