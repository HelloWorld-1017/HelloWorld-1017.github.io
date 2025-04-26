---
title: Schur Complement
categories:
 - Mathematics
tags:
 - Matrix
 - Numerical Analysis
 - Optimization
date: 2025-04-21 09:56:25 +0800
last_modified_at: 2025-04-26 09:41:17 +0800
---

# Schur complement

The <i class="term">Schur complement</i> is defined as follows[^1]:

<div class="quote--left" markdown="1">

It \[the Schur complement\] is defined for a block matrix. Suppose $p$, $q$ are nonnegative integers such that $p+q>0$, and suppose $\boldsymbol{\mathrm{A}}$, $\boldsymbol{\mathrm{B}}$, $\boldsymbol{\mathrm{C}}$, $\boldsymbol{\mathrm{D}}$ are respectively $p\times p$, $p\times q$, $q\times p$, and $q\times q$ matrices of complex numbers. Let

$$
\boldsymbol{\mathrm{M}}=\begin{bmatrix}
\boldsymbol{\mathrm{A}} & \boldsymbol{\mathrm{B}}\\
\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}
$$

so that $\boldsymbol{\mathrm{M}}$ is a $(p+q)\times(p+q)$ matrix.

If $\boldsymbol{\mathrm{D}}$ is invertible, then the Schur complement of the block $\boldsymbol{\mathrm{D}}$ of the matrix $\boldsymbol{\mathrm{M}}$ is the $p\times p$ matrix defined by:

$$
\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{D}}:=\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}}\label{eq2}
$$

If $\boldsymbol{\mathrm{A}}$ is invertible, the Schur complement of the block $\boldsymbol{\mathrm{A}}$ of the matrix $\boldsymbol{\mathrm{M}}$ is the $q\times q$ matrix defined by:

$$
\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{A}}:=\boldsymbol{\mathrm{D}}-\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}\label{eq3}
$$

In the case that $\boldsymbol{\mathrm{A}}$ or $\boldsymbol{\mathrm{D}}$ is singular, substituting a generalized inverse for the inverses on $\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{A}}$ and $\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{D}}$ yields the generalized Schur complement.

</div>

The Schur complement is gotten when performing a block Gaussian elimination[^2] on the matrix $\boldsymbol{\mathrm{M}}$:

$$
\begin{bmatrix}
\boldsymbol{\mathrm{A}} & \boldsymbol{\mathrm{B}}\\
\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{I}}_p\\
\end{bmatrix}\\
=\begin{bmatrix}
\textcolor{blue}{\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}}} & \boldsymbol{\mathrm{B}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}\label{eq4}
$$

we can see the Schur complement of the block $\boldsymbol{\mathrm{D}}$ of the matrix $\boldsymbol{\mathrm{M}}$, i.e. $\eqref{eq2}$. Similarly we have:

$$
\begin{bmatrix}
\boldsymbol{\mathrm{A}} & \boldsymbol{\mathrm{B}}\\
\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}\\
=
\begin{bmatrix}
\boldsymbol{\mathrm{A}} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{C}} & \textcolor{blue}{\boldsymbol{\mathrm{D}}-\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}}
\end{bmatrix}\label{eq7}
$$

we can get the Schur complement of the block $\boldsymbol{\mathrm{A}}$ of the matrix $\boldsymbol{\mathrm{M}}$, i.e. $\eqref{eq3}$.

<br>

# LDU decomposition and inverse by Schur complement

To step further.

## For $\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{D}}$

For the resulting block upper triangular matrix in $\eqref{eq4}$, we can multiply some elementary matrices on the left, represented as a matrix in the following equation, to get a block diagonal matrix:

$$
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{B}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}\\
=
\begin{bmatrix}
\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}\label{eq6}
$$

combine Eq. $\eqref{eq4}$ and $\eqref{eq6}$, we’ll have:

$$
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
\boldsymbol{\mathrm{M}}\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{I}}_p\\
\end{bmatrix} = 
\begin{bmatrix}
\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}
$$

Note: This process is also called Gauss–Jordan elimination[^2].
{: .notice--primary}

This process will lead to an <i class="term">LDU decomposition</i> of matrix $\boldsymbol{\mathrm{M}}$, that is (by inversing block diagonal matrix[^3]):

$$
\begin{split}
\boldsymbol{\mathrm{M}} &= 
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}^{-1}
\begin{bmatrix}
\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}^{-1}\\
&=
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
\end{split}\label{eq8}
$$

and based on which, we can calculate the inverse of $\boldsymbol{\mathrm{M}}$ (assuming the inverse exists):

$$
\begin{split}
\boldsymbol{\mathrm{M}}^{-1}
&=
\Big(\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}^{-1}
\begin{bmatrix}
\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}^{-1}\Big)^{-1}\\
&=
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}\\
\end{bmatrix}^{-1}\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}\\
&=
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
\begin{bmatrix}
(\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}})^{-1} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}^{-1}\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}\\
\end{split}
$$

and furthermore we can express it by $\boldsymbol{\mathrm{D}}^{-1}$ and the inverse of the Schur complement of the block $\boldsymbol{\mathrm{D}}$ of matrix $\boldsymbol{\mathrm{M}}$:

$$
\begin{split}
\boldsymbol{\mathrm{M}}^{-1}
&=
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
\begin{bmatrix}
(\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}})^{-1} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}^{-1}\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}\\
&=
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
\begin{bmatrix}
(\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{D}})^{-1} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}^{-1}\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}\\
&=
\begin{bmatrix}
(\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{D}})^{-1} & -(\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{D}})^{-1}\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\\
-\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}}(\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{D}})^{-1} & \boldsymbol{\mathrm{D}}^{-1}+\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}}(\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{D}})^{-1}\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}
\end{bmatrix}
\end{split}\label{eq10}
$$

## For $\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{A}}$

Similarly, based on $\eqref{eq7}$, we can also get another LDU decomposition:

$$
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1} & \boldsymbol{\mathrm{I}}_q
\end{bmatrix}
\boldsymbol{\mathrm{M}}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
=
\begin{bmatrix}
\boldsymbol{\mathrm{A}} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}-\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}
\end{bmatrix}
$$

therefore, the matrix $\boldsymbol{\mathrm{M}}$ can be also expressed as:

$$
\boldsymbol{\mathrm{M}}=
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1} & \boldsymbol{\mathrm{I}}_q
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{A}} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{D}}-\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
$$

and its inverse can be calculated by:

$$
\begin{split}
\boldsymbol{\mathrm{M}}^{-1}
&=
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{A}}^{-1} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & (\boldsymbol{\mathrm{D}}-\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}})^{-1}
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1} & \boldsymbol{\mathrm{I}}_q
\end{bmatrix}\\
&=
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & -\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}\\
\boldsymbol{\mathrm{0}} & \boldsymbol{\mathrm{I}}_q\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{A}}^{-1} & \boldsymbol{\mathrm{0}}\\
\boldsymbol{\mathrm{0}} & (\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{A}})^{-1}
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{\mathrm{I}}_p & \boldsymbol{\mathrm{0}}\\
-\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1} & \boldsymbol{\mathrm{I}}_q
\end{bmatrix}\\
&=
\begin{bmatrix}
\boldsymbol{\mathrm{A}}^{-1}+\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}(\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{A}})^{-1}\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1} & -\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}(\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{A}})^{-1}\\
-(\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{A}})^{-1}\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1} & (\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{A}})^{-1}
\end{bmatrix}
\end{split}\label{eq13}
$$

<br>

# Matrix inversion lemma

By comparing Eq. $\eqref{eq10}$ and $\eqref{eq13}$, we can get that:

$$
(\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{D}})^{-1} = \boldsymbol{\mathrm{A}}^{-1}+\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}(\boldsymbol{\mathrm{M}}/\boldsymbol{\mathrm{A}})^{-1}\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1}
$$

i.e.:

$$
(\boldsymbol{\mathrm{A}}-\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{D}}^{-1}\boldsymbol{\mathrm{C}})^{-1}=\boldsymbol{\mathrm{A}}^{-1}+\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}(\boldsymbol{\mathrm{D}}-\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}})^{-1}\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1}
$$

when $\boldsymbol{\mathrm{D}}=\boldsymbol{\mathrm{I}}_q$ and replace $\boldsymbol{\mathrm{B}}$ with $-\boldsymbol{\mathrm{B}}$, we’ll have:

$$
(\boldsymbol{\mathrm{A}}+\boldsymbol{\mathrm{B}}\boldsymbol{\mathrm{C}})^{-1}=\boldsymbol{\mathrm{A}}^{-1}-\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}}(\boldsymbol{\mathrm{I}}_q+\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1}\boldsymbol{\mathrm{B}})^{-1}\boldsymbol{\mathrm{C}}\boldsymbol{\mathrm{A}}^{-1}
$$

which is the <i class="term">matrix inversion lemma</i>[^4][^5].

<br>

**References**

[^1]: [Schur complement](https://en.wikipedia.org/wiki/Schur_complement).
[^2]: [Elementary Matrix, Elementary Operation, and Gaussian Elimination](/2025-04-13/11-15-43.html).
[^3]: Petersen & Pedersen, The Matrix Cookbook, Version: November 15, 2012, Page 46.
[^4]: [The Schur Complement and Symmetric Positive Semidefinite (and Definite) Matrices](https://www.cis.upenn.edu/~jean/schur-comp.pdf), Jean Gallier, August 24, 2019, p. 3.
[^5]: [Woodbury matrix identity](https://en.wikipedia.org/wiki/Woodbury_matrix_identity).