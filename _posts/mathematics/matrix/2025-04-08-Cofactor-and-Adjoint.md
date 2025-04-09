---
title: Cofactor, Matrix of Cofactors, Adjoint, and Determinant of A Matrix
toc: false
categories:
 - Mathematics
tags:
 - Matrix
date: 2025-04-08 15:52:28 +0800
last_modified_at: 2025-04-09 18:03:56 +0800
---

# Cofactor, matrix of cofactors, adjoint, and determinant

The corresponding cofactor, matrix of cofactors, and adjoint matrix of a given $n\times n$ square matrix $\boldsymbol{\mathrm{A}}$ are defined as follows, respectively[^1]:

<div class="quote--left" markdown="1">

The <i class="term">submatrix</i> of a matrix $\boldsymbol{\mathrm{A}}$, denoted by $[\boldsymbol{\mathrm{A}}]_{ij}$ is a $(n-1)\times(n-1)$ matrix obtained by deleting the $i$th row and the $j$th column of $\boldsymbol{\mathrm{A}}$. The $(i,j)$ <i class="term">cofactor</i> of a matrix is defined as:

$$
\mathrm{cof}(\boldsymbol{\mathrm{A}},i,j) = (-1)^{i+j}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{ij})
$$

The <i class="term">matrix of cofactors</i> can be created from the cofactors:

$$
\mathrm{cof}(\boldsymbol{\mathrm{A}}) = \begin{bmatrix}
\mathrm{cof}(\boldsymbol{\mathrm{A}},1,1) & & \cdots & & \mathrm{cof}(\boldsymbol{\mathrm{A}},i,n)\\
& & & & \\
\vdots & & \mathrm{cof}(\boldsymbol{\mathrm{A}},i,j) & & \vdots\\
& & & & \\
\mathrm{cof}(\boldsymbol{\mathrm{A}},n,1) & & \cdots & & \mathrm{cof}(\boldsymbol{\mathrm{A}},n,n)\\
\end{bmatrix}
$$

The <i class="term">adjoint</i> matrix is the transpose of the cofactor matrix:

$$
\mathrm{adj}(\boldsymbol{\mathrm{A}}) = \Big(\mathrm{cof}(\mathrm{\boldsymbol{\mathrm{A}})}\Big)^T
$$

</div>

In some cases, $$\mathrm{det}([\boldsymbol{\mathrm{A}}]_{ij})$$ is also called as “a minor”, or “a first minor”, or specifically “$(i,j)$ minor”, and hence sometimes denoted as $$M_{ij}$$[^5]; adjoint $\mathrm{adj}(\boldsymbol{\mathrm{A}})$ is also called as “adjugate”, “classical adjoint”, or “adjunct matrix”[^2]. 

<div class="notice--primary" markdown="1">

In Chinese[^3],

- $$\mathrm{det}([\boldsymbol{\mathrm{A}}]_{ij})$$ is called “余子式”;
- $\mathrm{cof}(\boldsymbol{\mathrm{A}},i,j)$ is “代数余子式”;
- $\mathrm{cof}(\boldsymbol{\mathrm{A}})$ is “余子矩阵”, and
- $\mathrm{adj}(\boldsymbol{\mathrm{A}})$ is “伴随矩阵”.

</div>

Based on the resulting cofactors of matrix $\boldsymbol{\mathrm{A}}$, we can define the determinant of the matrix $\boldsymbol{\mathrm{A}}$[^1]:

<div class="quote--left" markdown="1">

The <i class="term">determinant</i> of a matrix $\boldsymbol{\mathrm{A}}\in\mathbb{C}^{n\times n}$ is defined as:

$$
\begin{split}
\mathrm{det}(\boldsymbol{\mathrm{A}}) &= \sum_{j=1}^n (-1)^{j+1}A_{1j}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{1j})\\
&= \sum_{j=1}^nA_{1j}\mathrm{cof}(\boldsymbol{\mathrm{A}},1,j)
\end{split}\label{eq2}
$$

</div>

For example, for a $3\times3$ square matrix $\boldsymbol{\mathrm{A}}$:

$$
\boldsymbol{\mathrm{A}} = \begin{bmatrix}
A_{11} & A_{12} & A_{13}\\
A_{21} & A_{22} & A_{23}\\
A_{31} & A_{32} & A_{33}\\
\end{bmatrix}\notag
$$

we have:

$$
\begin{split}
\mathrm{det}(\boldsymbol{\mathrm{A}}) &= 
A_{11}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,1)+
A_{12}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,2)+
A_{13}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,3)\\
&=A_{11}\cdot\mathrm{det}\Big(
\begin{bmatrix}
A_{22} & A_{23} \\
A_{32} & A_{33} \\
\end{bmatrix}
\Big)
-A_{12}\cdot\mathrm{det}\Big(\begin{bmatrix}
A_{21} & A_{23}\\
A_{31} & A_{33}\\
\end{bmatrix}\Big)
+A_{13}\cdot\mathrm{det}\Big(\begin{bmatrix}
A_{21} & A_{22}\\
A_{31} & A_{32}\\
\end{bmatrix}\Big)\\
&=A_{11}(A_{22}A_{33}-A_{23}A_{32})
-A_{12}(A_{21}A_{33}-A_{23}A_{31})
+A_{13}(A_{21}A_{32}-A_{22}A_{31})\\
&=A_{11}A_{22}A_{33}+A_{12}A_{23}A_{31}+A_{13}A_{21}A_{32}-A_{13}A_{22}A_{31}-A_{11}A_{23}A_{32}-A_{12}A_{21}A_{33}
\end{split}\label{eq1}
$$

Note that the recursive pattern of $\det(\cdot)$ in $\eqref{eq1}$ when calculating the determinant of 3-order matrix.
{: .notice--primary}

There are two properties of cofactors should be noted.

(1) Due to the fact that if we interchange two rows of a matrix, the determinant of the new matrix will be the negative of that of the original matrix (intuitively because the orientation is reversed[^8]), if we interchange the first and second row in $\boldsymbol{\mathrm{A}}$:

$$
\boldsymbol{\mathrm{A}}^\prime = \begin{bmatrix}
A_{21} & A_{22} & A_{23}\\
A_{11} & A_{12} & A_{13}\\
A_{31} & A_{32} & A_{33}\\
\end{bmatrix}\notag
$$

then we can deduce that:

$$
\begin{split}
\mathrm{det}(\boldsymbol{\mathrm{A}}) 
&= -\mathrm{det}(\boldsymbol{\mathrm{A}}^\prime)\\
&= -\Big(
A_{21}(-1)^{(1+1)}\mathrm{det}\Big(\begin{bmatrix}
A_{12} & A_{13}\\
A_{32} & A_{33}\\
\end{bmatrix}\Big) + 
A_{22}(-1)^{(1+2)}\mathrm{det}\Big(\begin{bmatrix}
A_{11} & A_{13}\\
A_{31} & A_{33}\\
\end{bmatrix}\Big) + 
A_{23}(-1)^{(1+3)}\mathrm{det}\Big(\begin{bmatrix}
A_{11} & A_{12}\\
A_{31} & A_{32}\\
\end{bmatrix}\Big)
\Big)\\
&= A_{21}(-1)^{(2+1)}\mathrm{det}\Big(\begin{bmatrix}
A_{12} & A_{13}\\
A_{32} & A_{33}\\
\end{bmatrix}\Big) + 
A_{22}(-1)^{(2+2)}\mathrm{det}\Big(\begin{bmatrix}
A_{11} & A_{13}\\
A_{31} & A_{33}\\
\end{bmatrix}\Big) + 
A_{23}(-1)^{(2+3)}\mathrm{det}\Big(\begin{bmatrix}
A_{11} & A_{12}\\
A_{31} & A_{32}\\
\end{bmatrix}\Big) \\
&= A_{21}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},2,1)+A_{22}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},2,2)+A_{23}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},2,3)
\end{split}\notag
$$

which means actually the determinant of $\boldsymbol{\mathrm{A}}$ can not only be calculated using the elements in the *first row* and their cofactors, but also other rows, that is, Eq. $\eqref{eq2}$ can be generalized as[^5]:

$$
\mathrm{det}(\boldsymbol{\mathrm{A}}) = \sum_{j=1}^nA_{kj}\mathrm{cof}(\boldsymbol{\mathrm{A}},k,j),\ \text{for }\forall k=1,2,...n\label{eq5}
$$

or based on column elements[^9]:

$$
\mathrm{det}(\boldsymbol{\mathrm{A}}) = \sum_{i=1}^nA_{ik}\mathrm{cof}(\boldsymbol{\mathrm{A}},i,k),\ \text{for }\forall k=1,2,...n
$$

(2) For matrix $\boldsymbol{\mathrm{A}}$, adding one row into another doesn’t change its determinant. As a result, adding the second row into the first row:

$$
\boldsymbol{\mathrm{A}}^{\prime\prime} = \begin{bmatrix}
A_{11}+A_{21} & A_{12}+A_{22} & A_{13}+A_{23}\\
A_{21} & A_{22} & A_{23}\\
A_{31} & A_{32} & A_{33}\\
\end{bmatrix}\notag
$$

then we have:

$$
\begin{split}
\mathrm{det}(\boldsymbol{\mathrm{A}})
&= \mathrm{det}(\boldsymbol{\mathrm{A}}^{\prime\prime})\\
&= (A_{11}+A_{21})\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,1) + (A_{12}+A_{22})\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,2) + (A_{13}+A_{23})\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,3)\\
&= \mathrm{det}(\boldsymbol{\mathrm{A}})+A_{21}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,1)+A_{22}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,2)+A_{23}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,3)
\end{split}\notag
$$

that is[^4]:

$$
A_{21}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,1)+A_{22}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,2)+A_{23}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},1,3) = 0\notag
$$

so we can get another property, i.e. the result of multiplying the elements in one row with cofactors of those elements of another row is zero[^6][^7]:

$$
\sum_{j=1}^nA_{kj}\cdot\mathrm{cof}(\boldsymbol{\mathrm{A}},l,j) = 0,\ \forall k\neq l\label{eq6}
$$

<br>

Based on above two properties $\eqref{eq5}$ and $\eqref{eq6}$, we’ll have:

$$
\begin{split}
\boldsymbol{\mathrm{A}}\cdot\mathrm{adj}(\boldsymbol{\mathrm{A}}) 
&= \begin{bmatrix}
A_{11} & A_{12} & A_{13}\\
A_{21} & A_{22} & A_{23}\\
A_{31} & A_{32} & A_{33}\\
\end{bmatrix}\cdot\begin{bmatrix}
\mathrm{cof}(\boldsymbol{\mathrm{A}},1,1) & \mathrm{cof}(\boldsymbol{\mathrm{A}},2,1) & \mathrm{cof}(\boldsymbol{\mathrm{A}},3,1)\\
\mathrm{cof}(\boldsymbol{\mathrm{A}},1,2) & \mathrm{cof}(\boldsymbol{\mathrm{A}},2,2) & \mathrm{cof}(\boldsymbol{\mathrm{A}},3,2)\\
\mathrm{cof}(\boldsymbol{\mathrm{A}},1,3) & \mathrm{cof}(\boldsymbol{\mathrm{A}},2,3) & \mathrm{cof}(\boldsymbol{\mathrm{A}},3,3)\\
\end{bmatrix}\\
&= \begin{bmatrix}
\mathrm{det}(A) & 0 & 0 \\
0 & \mathrm{det}(A) & 0 \\
0 & 0 & \mathrm{det}(A)\\
\end{bmatrix} = \mathrm{det}(A)\cdot\boldsymbol{\mathrm{I}}
\end{split}\notag
$$

i.e. 

$$
\boldsymbol{\mathrm{A}}^{-1} = \dfrac1{\mathrm{det}(\boldsymbol{\mathrm{A}})}\mathrm{adj}(\boldsymbol{\mathrm{A}})\label{eq4}
$$

Eq. $\eqref{eq4}$ is a way to calculate the inverse of a matrix, if the matrix is invertable.

<br>

# An example


Take a matrix for example[^2]: 

$$
\boldsymbol{\mathrm{A}} = \begin{bmatrix}
-3 & 2 & -5\\
-1 & 0 & -2\\
3 & -4 & 1\\
\end{bmatrix}\notag
$$

each $[\boldsymbol{\mathrm{A}}]_{ij}$ is:

$$
\begin{split}
[\boldsymbol{\mathrm{A}}]_{11} = \begin{bmatrix}
0 & -2\\
-4 & 1\\
\end{bmatrix},\ &[\boldsymbol{\mathrm{A}}]_{12} = \begin{bmatrix}
-1 & -2\\
3 & 1\\
\end{bmatrix},\ &[\boldsymbol{\mathrm{A}}]_{13} = \begin{bmatrix}
-1 & 0\\
3 & -4\\
\end{bmatrix}\\
[\boldsymbol{\mathrm{A}}]_{21} = \begin{bmatrix}
2 & -5\\
-4 & 1\\
\end{bmatrix},\ &[\boldsymbol{\mathrm{A}}]_{22} = \begin{bmatrix}
-3 & -5\\
3 & 1\\
\end{bmatrix},\ &[\boldsymbol{\mathrm{A}}]_{23} = \begin{bmatrix}
-3 & 2\\
3 & -4\\
\end{bmatrix}\\
[\boldsymbol{\mathrm{A}}]_{31} = \begin{bmatrix}
2 & -5\\
0 & -2\\
\end{bmatrix},\ &[\boldsymbol{\mathrm{A}}]_{32} = \begin{bmatrix}
-3 & -5\\
-1 & -2\\
\end{bmatrix},\ &[\boldsymbol{\mathrm{A}}]_{33} = \begin{bmatrix}
-3 & 2\\
-1 & 0\\
\end{bmatrix}\\
\end{split}\notag
$$

and the cofactor of each matrix element is:

$$
\begin{split}
\mathrm{cof}(\boldsymbol{\mathrm{A}},1,1) &= (-1)^{(1+1)}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{11})=\mathrm{det}\Big(\begin{bmatrix}
0 & -2\\
-4 & 1\\
\end{bmatrix}\Big) = -8\\
\mathrm{cof}(\boldsymbol{\mathrm{A}},1,2) &= (-1)^{(1+2)}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{12})=-\mathrm{det}\Big(\begin{bmatrix}
-1 & -2\\
3 & 1\\
\end{bmatrix}\Big) = -5\\
\mathrm{cof}(\boldsymbol{\mathrm{A}},1,3) &= (-1)^{(1+3)}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{13})=\mathrm{det}\Big(\begin{bmatrix}
-1 & 0\\
3 & -4\\
\end{bmatrix}\Big) = 4\\
\mathrm{cof}(\boldsymbol{\mathrm{A}},2,1) &= (-1)^{(2+1)}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{21})=-\mathrm{det}\Big(\begin{bmatrix}
2 & -5\\
-4 & 1\\
\end{bmatrix}\Big) = 18\\
\mathrm{cof}(\boldsymbol{\mathrm{A}},2,2) &= (-1)^{(2+2)}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{22})=\mathrm{det}\Big(\begin{bmatrix}
-3 & -5\\
3 & 1\\
\end{bmatrix}\Big) = 12\\
\mathrm{cof}(\boldsymbol{\mathrm{A}},2,3) &= (-1)^{(2+3)}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{23})=-\mathrm{det}\Big(\begin{bmatrix}
-3 & 2\\
3 & -4\\
\end{bmatrix}\Big) = -6\\
\mathrm{cof}(\boldsymbol{\mathrm{A}},3,1) &= (-1)^{(3+1)}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{31})=\mathrm{det}\Big(\begin{bmatrix}
2 & -5\\
0 & -2\\
\end{bmatrix}\Big) = -4\\
\mathrm{cof}(\boldsymbol{\mathrm{A}},3,2) &= (-1)^{(3+2)}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{32})=-\mathrm{det}\Big(\begin{bmatrix}
-3 & -5\\
-1 & -2\\
\end{bmatrix}\Big) = -1\\
\mathrm{cof}(\boldsymbol{\mathrm{A}},3,3) &= (-1)^{(3+3)}\mathrm{det}([\boldsymbol{\mathrm{A}}]_{33})=\mathrm{det}\Big(\begin{bmatrix}
-3 & 2\\
-1 & 0\\
\end{bmatrix}\Big) = 2\\
\end{split}\notag
$$

and the corresponding matrix of cofactors is:

$$
\mathrm{cof}(\boldsymbol{\mathrm{A}}) = \begin{bmatrix}
-8 & -5 & 4 \\
18 & 12 & -6 \\
-4 & -1 & 2
\end{bmatrix}\notag
$$

and the adjoint is:

$$
\mathrm{adj}(\boldsymbol{\mathrm{A}}) = \Big(\mathrm{cof}(\mathrm{\boldsymbol{\mathrm{A}})}\Big)^T = 
\begin{bmatrix}
-8 & 18 & -4 \\
-5 & 12 & -1 \\
4 & -6 & 2
\end{bmatrix}\notag
$$

We can verify the results according to Eq. $\eqref{eq4}$ in MATLAB:

```matlab
clc, clear, close all

A = [-3, 2, -5; -1, 0, -2; 3, -4, 1];
adjofA = [-8, 18, -4; -5, 12, -1; 4, -6, 2];

det(A)
inv(A) - 1/det(A)*adjofA
```

```
ans =
   -6.0000

ans =
   1.0e-15 *
    0.2220         0    0.1110
   -0.1110         0    0.0278
    0.1110         0    0.0555
```

and verify Eq. $\eqref{eq2}$:

$$
\begin{split}
\mathrm{det}(\boldsymbol{\mathrm{A}}) &= \mathrm{det}\Big(\begin{bmatrix}
-3 & 2 & -5\\
-1 & 0 & -2\\
3 & -4 & 1\\
\end{bmatrix}\Big)\\
&= (-3)\times\mathrm{cof}(\boldsymbol{\mathrm{A}},1,1)+2\times\mathrm{cof}(\boldsymbol{\mathrm{A}},1,2)+(-5)\times\mathrm{cof}(\boldsymbol{\mathrm{A}},1,3)\\
&= (-3)\times(-8)+2\times(-5)+(-5)\times4\\
&=-6
\end{split}\notag
$$

<br>

**References**

[^1]: Petersen & Pedersen, The Matrix Cookbook, Version: November 15, 2012, p. 17.
[^2]: [Adjugate matrix](https://en.wikipedia.org/wiki/Adjugate_matrix).
[^3]: [伴随矩阵](https://zh.wikipedia.org/zh-hans/%E4%BC%B4%E9%9A%8F%E7%9F%A9%E9%98%B5).
[^4]: [证明：行列式的某行元素与另一行对应元素的代数余子式乘积之和为0\_代数余子式乘以别的行(列)之和为零](https://blog.csdn.net/sunny_happy/article/details/8003340).
[^5]: [Minor (linear algebra)](https://en.wikipedia.org/wiki/Minor_(linear_algebra)).
[^6]: [matrices - Cofactor multiplied with another row](https://math.stackexchange.com/questions/1563742/cofactor-multiplied-with-another-row).
[^7]: [Prove that the sum of product of any row or column with corresponding co-factors of some other row or column in a matrix is zero.](https://www.vedantu.com/question-answer/prove-that-the-sum-of-product-of-any-row-or-class-10-maths-cbse-5f37c156df4e9873eee4e7b1)
[^8]: [The Geometric Meaning of the Determinant of A Matrix](/2022-06-13/19-57-32.html).
[^9]: [Review Notes and Supplementary Notes CS229 Course Machine Learning Standford University](https://www.ctanujit.org/uploads/2/5/3/9/25393293/mathematics_for_machine_learning__cs229__1.pdf), p. 11.
