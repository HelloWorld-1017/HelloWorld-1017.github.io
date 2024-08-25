---
layout: single
title: Some Properties of Real Symmetric Matrix
date: 2023-10-31 11:36:28 +0800
categories:
 - Mathematics
tags:
 - Matrix
 - Mathematical Proofs and Derivations
---

# Basic Properties

## Necessary and sufficient condition

### An $n\times n$ matrix $A$ is symmetric if and only if $A\boldsymbol{x}\cdot\boldsymbol{y}=\boldsymbol{x}\cdot A\boldsymbol{y}$ for all vectors $\boldsymbol{x}$ and $\boldsymbol{y}$ in $\mathbb{R}^n$.

***Theorem-3***: An $n\times n$ matrix $A$ is symmetric if and only if $A\boldsymbol{x}\cdot\boldsymbol{y}=\boldsymbol{x}\cdot A\boldsymbol{y}$ for all vectors $\boldsymbol{x}$ and $\boldsymbol{y}$ in $\mathbb{R}^n$ [[5](#ref-5)].

*Proof*:

(1) Necessity (If $A$ is symmetric): Let $\boldsymbol{x}$ and $\boldsymbol{y}$ be in $\mathbb{R}^n$. For any $n\times n$ matrix $A$:

$$
\textcolor{red}{A\boldsymbol{x}\cdot\boldsymbol{y}}=(A\boldsymbol{x})^T\boldsymbol{y}=\boldsymbol{x}^TA^T\boldsymbol{y}=\boldsymbol{x}\cdot A^T\boldsymbol{y}=\textcolor{red}{\boldsymbol{x}\cdot A\boldsymbol{y}}
$$

(2) Sufficiency (If $A\boldsymbol{x}\cdot\boldsymbol{y}=\boldsymbol{x}\cdot A\boldsymbol{y}$ is valid for all vectors $\boldsymbol{x}$ and $\boldsymbol{y}$ in $\mathbb{R}^n$): Let $\boldsymbol{a}_i$ denote $i$-th column of $A$, $e_i$ is the $i$-th base vector of $\boldsymbol{R}^n$. Then for all $1\le i,j\le n$:

$$
\begin{split}
A\boldsymbol{e}_i\cdot\boldsymbol{e}_j=\boldsymbol{a}_i\cdot\boldsymbol{e}_j=a_{ji}\ \text{(the }(j,i)\text{ entry in }A)\\
\boldsymbol{e}_i\cdot A\boldsymbol{e}_j=\boldsymbol{e}_i\cdot\boldsymbol{a}_j=a_{ij}\ \text{(the }(i,j)\text{ entry in }A)\\
\end{split}
$$

i.e.,

$$
a_{ji}=a_{i,j}
$$

Q.E.D.

We could simply verify its necessity using MATLAB:

```matlab
rng("default")
A = [1,3;3,3];
x = randn(2,1);
y = randn(2,1);

dot(A*x,y) % (A*x)'*y
dot(x,A*y) % x'*(A*y)
```

```
ans =
   -7.5078
ans =
   -7.5078
```

<br>

# Eigenvalues and eigenvectors of real symmetric matrix

## All eigenvalues of real symmetric matrix are real.

<div id="theorem-1"></div>

***Theorem-1***: All eigenvalues of real symmetric matrix are real (could refer [[3](#ref-3), [4](#ref-4)]).

***Corollary-1-1***: All coefficients of the characteristic polynomial of real symmetric matrix are real.

***Corollary-1-2***: The trace of real symmetric matrix is real.

***Corollary-1-3***: The determinant of real symmetric matrix is real.



## If $A$ is a real $n\times n$ symmetric matrix, the $A$ has $n$ real eigenvalues (counted by their multiplicities). And for each eigenvalue, we can find a real eigenvector associated with it.

<div id="theorem-4"></div>

***Theorem-4***: If $A$ is a real $n\times n$ symmetric matrix, the $A$ has $n$ real eigenvalues (counted by their multiplicities). And for each eigenvalue, we can find a real eigenvector associated with it [[5](#ref-5)]. 

*Proof*: [Theorem-1](#theorem-1) says that all the eigenvalues of real symmetric matrix are real (p.s., reference [[5](#ref-5)] provides another way to prove [Theorem-1](#theorem-1), and is kind of complicated than proof in blog [[4](#ref-4)]). And on another hand, fundamental theorem of algebra [[6](#ref-6), [7](#ref-7)] tell us "*every non-zero, single-variable, degree $n$ polynomial with complex coefficients has, counted with multiplicity, exactly $n $complex roots*". So, the $n$-order characteristic polynomial $\vert A-\lambda I\vert=0$ has $n$ real roots, i.e., $A$ has $n$ real eigenvalues (counted by their multiplicities) .

Since each $\lambda_i$ is real, $A-\lambda_iI$ is a real matrix and $\vert A-\lambda_iI\vert=0$ cause $\lambda_i$ is an eigenvalue. So, the real matrix equation

$$
(A-\lambda_iI)\boldsymbol{x} = \boldsymbol{0}
$$

has nonzero real solutions $\boldsymbol{x}$ [[8](#ref-8)], i.e., there are **real eigenvectors** for eigenvalue $\lambda_i$.

## Eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal.

<div id="theorem-2"></div>

***Theorem-2***: Eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal [[1](#ref-1), [2](#ref-2)].

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

<div id="ref-3"></div>
[3] [Some Properties of Eigenvalues and Eigenvectors - What a starry night~](https://helloworld-1017.github.io/2023-10-31/11-19-07.html).

<div id="ref-4"></div>
[4] [Hermitian Matrix - What a starry night~](https://helloworld-1017.github.io/2023-04-20/09-35-32.html).

<div id="ref-5"></div>
[5] [Orthogonally Diagonalizable Matrices](https://www.math.wustl.edu/~freiwald/309orthogdiag.pdf).

<div id="ref-6"></div>
[6] [Fundamental theorem of algebra - Wikipedia](https://en.wikipedia.org/wiki/Fundamental_theorem_of_algebra).

<div id="ref-7"></div>
[7] [Fundamental Theorem of Algebra - What a starry night~](https://helloworld-1017.github.io/2022-07-21/11-17-55.html).

<div id="ref-8"></div>
[8] [Determination of Solutions for Linear Equations - What a starry night~](https://helloworld-1017.github.io/2022-07-10/21-21-26.html).



