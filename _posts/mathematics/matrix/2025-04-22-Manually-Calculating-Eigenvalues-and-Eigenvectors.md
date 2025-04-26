---
title: "An Example of Manually Calculating Eigenvalues and Eigenvectors of the Square Matrix: Take A Symmetric Matrix"
toc: false
categories:
 - Mathematics
tags:
 - Matrix
date: 2025-04-22 20:38:40 +0800
last_modified_at: 2025-04-26 16:43:02 +0800
---

Consider a $3\times 3$ symmetric matrix:

$$
\boldsymbol{\mathrm{A}}=\begin{bmatrix}
-2 & 2 & 2\\
2 & 1 & 4\\
2 & 4 & 1\\
\end{bmatrix}\notag
$$

Firstly, we can calculate its eigenvalues:

$$
\begin{split}
\vert\boldsymbol{\mathrm{A}}-\lambda\boldsymbol{\mathrm{I}}\vert
=&\begin{vmatrix}
-2-\lambda & 2 & 2\\
2 & 1-\lambda & 4\\
2 & 4 & 1-\lambda\\
\end{vmatrix}\\
=&(-2-\lambda)(1-\lambda)^2+16+16\\
&-4(1-\lambda)-16(-2-\lambda)-4(1-\lambda)\\
=&-\lambda^3+27\lambda+54\\
=&(\lambda-6)(\lambda+3)^2
\end{split}
\notag
$$

Let $\vert\boldsymbol{\mathrm{A}}-\lambda\boldsymbol{\mathrm{I}}\vert$ equals to zero, we’ll have:

$$
\lambda_1=6,\ \lambda_2=\lambda_3=-3\label{eq1}
$$

(1) When $\lambda_1=6$:

$$
(\boldsymbol{\mathrm{A}}-\lambda_1\boldsymbol{\mathrm{I}})\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{0}}
\Rightarrow\begin{bmatrix}
-8 & 2 & 2\\
2 & -5 & 4\\
2 & 4 & -5\\
\end{bmatrix}\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{0}}
\Rightarrow\begin{bmatrix}
2 & 0 & -1\\
0 & -1 & 1\\
0 & 0 & 0\\
\end{bmatrix}\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{0}}\\\notag
$$

then we can get a solution:

$$
\boldsymbol{\mathrm{x}}=
k_1\begin{bmatrix}
1 \\ 2 \\ 2\\
\end{bmatrix}\notag\notag
$$

where an eigenvector is:

$$
\xi_1 =\begin{bmatrix}
1 \\ 2 \\ 2\\
\end{bmatrix}\notag
$$

Next, unitize it as:

$$
\xi_1 = \begin{bmatrix}
1/\sqrt{1+4+4} \\ 2/\sqrt{1+4+4} \\ 2/\sqrt{1+4+4}\\
\end{bmatrix}=
\begin{bmatrix}
1/3 \\ 2/3 \\ 2/3\\
\end{bmatrix}\label{eq2}
$$

(2) When $\lambda_2=\lambda_3=-3$, we have:

$$
(\boldsymbol{\mathrm{A}}-\lambda_1\boldsymbol{\mathrm{I}})\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{0}}
\Rightarrow\begin{bmatrix}
1 & 2 & 2\\
2 & 4 & 4\\
2 & 4 & 4\\
\end{bmatrix}\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{0}}
\Rightarrow\begin{bmatrix}
1 & 2 & 2\\
0 & 0 & 0\\
0 & 0 & 0\\
\end{bmatrix}\boldsymbol{\mathrm{x}}=\boldsymbol{\mathrm{0}}\\\notag
$$

whose solution is:

$$
\boldsymbol{\mathrm{x}}=k_2\xi_2+k_3\xi_3=k_2\begin{bmatrix}
-2 \\ 1 \\ 0\\
\end{bmatrix}+k_3
\begin{bmatrix}
-2 \\ 0 \\ 1\\
\end{bmatrix}
\notag
$$

At this point, we can get two eigenvectors:

$$
\xi_2 = \begin{bmatrix}
-2 \\ 1 \\ 0\\
\end{bmatrix},\ 
\xi_3 = \begin{bmatrix}
-2 \\ 0 \\ 1\\
\end{bmatrix}\notag
$$

Then, use the Gram-Schmidt algorithm[^1] to make these two eigenvectors orthonormal:

$$
\begin{split}
\xi_2^{\prime}=&\xi_2=\begin{bmatrix}
-2 \\ 1 \\ 0 \\
\end{bmatrix}\\
\xi_3^{\prime}=&
\xi_3-\dfrac{\langle\xi_3,\xi_2\rangle}{\langle\xi_2,\xi_2\rangle}\xi_2
=\begin{bmatrix}
-2 \\ 0 \\ 1\\
\end{bmatrix}-\dfrac{\langle
\begin{bmatrix}
-2 \\ 0 \\ 1\\
\end{bmatrix},
\begin{bmatrix}
-2 \\ 1 \\ 0\\
\end{bmatrix}\rangle}{\langle
\begin{bmatrix}
-2 \\ 1 \\ 0\\
\end{bmatrix},
\begin{bmatrix}
-2 \\ 1 \\ 0\\
\end{bmatrix}\rangle}
\cdot\begin{bmatrix}
-2 \\ 1 \\ 0\\
\end{bmatrix}
=\begin{bmatrix}
-2/5 \\ -4/5 \\ 1\\
\end{bmatrix}
\end{split}\notag
$$

$$
\begin{split}
\xi_2^{\prime}&=\begin{bmatrix}
-2/\sqrt{4+1}\\
1/\sqrt{4+1}\\
0\\
\end{bmatrix}=\begin{bmatrix}
-2/\sqrt5\\
1/\sqrt5\\
0\\
\end{bmatrix}\\
\xi_3^{\prime}&=
\begin{bmatrix}
(-2/5)/(\sqrt{4/25+16/25+1})\\
(-4/5)/(\sqrt{4/25+16/25+1})\\
1/(\sqrt{4/25+16/25+1})\\
\end{bmatrix}=\begin{bmatrix}
-2/3\sqrt5\\
-4/3\sqrt5\\
5/3\sqrt5\\
\end{bmatrix}
\end{split}\notag
$$

Finally, we can get two eigenvectors:

$$
\xi_2 = \begin{bmatrix}
-2/\sqrt5 \\ 1/\sqrt5 \\ 0\\
\end{bmatrix},\ 
\xi_3 = \begin{bmatrix}
-2/3\sqrt5 \\ -4/3\sqrt5 \\ 5/3\sqrt5\\
\end{bmatrix}\label{eq3}
$$

<br>

After obtaining all eigenvalues and eigenvectors, we can define one matrix:

$$
\boldsymbol{\mathrm{U}} = 
\begin{bmatrix}
\xi_1 & \xi_2 & \xi_3\\
\end{bmatrix}
=\begin{bmatrix}
1/3 & -2/\sqrt5 & -2/3\sqrt5\\ 2/3 & 1/\sqrt5 & -4/3\sqrt5\\ 2/3 & 0 & 5/3\sqrt5\\
\end{bmatrix}\label{eq4}
$$

and a diagonal matrix:

$$
\boldsymbol{\Lambda}=
\begin{bmatrix}
\lambda_1 & 0 & 0\\
0 & \lambda_2 & 0\\
0 & 0 & \lambda_3\\
\end{bmatrix}=
\begin{bmatrix}
6 & 0 & 0\\
0 & -3 & 0\\
0 & 0 & -3\\
\end{bmatrix}\notag
$$

then we can get:

$$
\boldsymbol{\mathrm{U}}\boldsymbol{\Lambda}\boldsymbol{\mathrm{U}}^T=
\begin{bmatrix}
1/3 & -2/\sqrt5 & -2/3\sqrt5\\
2/3 & 1/\sqrt5 & -4/3\sqrt5\\
2/3 & 0 & 5/3\sqrt5\\
\end{bmatrix}
\begin{bmatrix}
6 & 0 & 0\\
0 & -3 & 0\\
0 & 0 & -3
\end{bmatrix}
\begin{bmatrix}
1/3 & 2/3 & 2/3\\
-2/\sqrt5 & 1/\sqrt5 & 0\\
-2/3\sqrt5 & -4/3\sqrt5 & 5/3\sqrt5
\end{bmatrix}=\boldsymbol{\mathrm{A}}\label{eq5}
$$

<div class="notice--primary" markdown="1">

For the sake of simplicity, we can compute it in MATLAB:

```matlab
clc, clear, close all

U = [1/3, -2/sqrt(5), -2/(3*sqrt(5));
    2/3, 1/sqrt(5), -4/(3*sqrt(5));
    2/3, 0, 5/(3*sqrt(5))];
Lambda = diag([6, -3, -3]);

disp(U*Lambda*U')
```

```
   -2.0000    2.0000    2.0000
    2.0000    1.0000    4.0000
    2.0000    4.0000    1.0000
```

</div>

On the basis of this example, we can also verify some properties about eigenvalues and eigenvectors of a symmetric matrix:

1. According to $\eqref{eq1}$, we can verify that, $n\times n$ symmetric matrix has $n$ real eigenvalues (counted by their multiplicities), and for each eigenvalue, a real eigenvector is associated with it (so, when $\lambda=-3$, we can find two eigenvectors, see $\eqref{eq3}$).[^2]
2. From $\eqref{eq2}$ and $\eqref{eq3}$, we have $\langle\xi_1,\xi_2\rangle=0$ and $\langle\xi_1,\xi_3\rangle=0$, which is because “eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal.”[^2]
3. Besides $\langle\xi_1,\xi_2\rangle=0$ and $\langle\xi_1,\xi_3\rangle=0$, due to that we made a Gram-Schmidt process, we can see $\langle\xi_2,\xi_3\rangle=0$ from $\eqref{eq3}$. As a result, matrix $\boldsymbol{\mathrm{U}}$ in $\eqref{eq4}$ is  an orthonormal matrix[^3], i.e. $\boldsymbol{\mathrm{U}}^T\boldsymbol{\mathrm{U}}=\boldsymbol{\mathrm{U}}\boldsymbol{\mathrm{U}}^T=\boldsymbol{\mathrm{I}}$, or rather, $\boldsymbol{\mathrm{U}}^T=\boldsymbol{\mathrm{U}}^{-1}$. Furthermore, based on $\eqref{eq5}$ we can verify that, “real symmetric matrices are diagonalizable by orthogonal matrices”.[^4]

<br>

**Reference**

[^1]: [Gram-Schmidt Process](/2023-11-01/22-00-27.html).
[^2]: [Some Properties of Eigenvalues and Eigenvectors](/2023-10-31/11-19-07.html).
[^3]: [Orthogonal matrix](https://en.wikipedia.org/wiki/Orthogonal_matrix).
[^4]: [Diagonalizable matrix](https://en.wikipedia.org/wiki/Diagonalizable_matrix).