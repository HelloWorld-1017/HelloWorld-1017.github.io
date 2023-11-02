Some Properties of Orthogonally Diagonalizable Matrix

Matrix

Mathematics

Spectral Theorem



# Definitions

## Definition-1: Orthogonal matrix (or Orthonormal matrix)

***Definition-1 (Orthogonal matrix, or Orthonormal matrix)*** [[5](#ref-5)]: An orthogonal matrix, or orthonormal matrix is a real square matrix whose columns and rows are orthonormal vectors. One way to express this is:
$$
Q^TQ=QQ^T=I
$$
Another equivalent characterization: a matrix $Q$ is orthogonal if its transpose is equal to its inverse, i.e.,
$$
Q^T=Q^{-1}
$$

## Definition-2: Orthogonally diagonalizable

***Definition-2 (orthogonally diagonalizable)*** [[3](#ref-3)]: An $n\times n$ matrix $A$ is called *orthogonally diagonalizable* if there is an orthogonal matrix $U$ and a diagonal matrix $D$ for which $A=UDU^{-1}$ ($=UDU^T$).

<br>

# Theorems

## Theorem-4: A product of orthogonal matrices is orthogonal.

<div id="theorem-4"></div>

***Theorem-4***: A product of orthogonal matrices is orthogonal.

*Proof*:

Suppose that $P_1$ and $P_2$ are both orthogonal matrices, i.e.,
$$
\begin{split}
&P_1^T = P_1^{-1}\\
&P_2^T = P_2^{-1}\\
\end{split}
$$
then:
$$
(P_1P_2)^T=P_2^TP_1^T=P_2^{-1}P_1^{-1}=(P_1P_2)^{-1}
$$
i.e., matrix $P_1P_2$ is an orthogonal matrix.

The proof could be extended to the case of product of $n$ matrices:
$$
\begin{split}
&P_1^T = P_1^{-1}\\
&P_2^T = P_2^{-1}\\
&\qquad\vdots\\
&P_n^T = P_n^{-1}\\
\end{split}
$$
similarly:
$$
(P_1P_2\cdots P_n)^T=(P_n^T\cdots P_2^TP_1^T)=(P_n^{-1}\cdots P_2^{-1}P_1^{-1})=(P_1P_2\cdots P_n)^{-1}
$$
i.e., matrix $P_1P_2\cdots P_n$ is orthogonal.

Q.E.D.





## Theorem-1: If $A$ is orthogonally diagonalizable, then $A$ must be symmetric.

<div id="theorem-1"></div>

***Theorem-1***: If $A$ is orthogonally diagonalizable, then $A$ must be symmetric [[3](#ref-3)].

*Proof*: Suppose that $D$ is diagonal, $U$ is orthogonal matrix, we have:
$$
A=UDU^{-1}=UDU^T
$$
then:
$$
A^T=(UDU^T)^T=UDU^T=A
$$
Q.E.D.

## Theorem-2: A real $n\times n$ symmetric matrix $A$ is orthogonally diagonalizable.

<div id="theorem-2"></div>

***Theorem-2***: A real $n\times n$ symmetric matrix $A$ is orthogonally diagonalizable [[3](#ref-3)].

The finite-dimensional spectral theorem says that any symmetric matrix whose entries are real can be diagonalized by orthogonal matrix. More explicitly: for every real symmetric matrix $A$, there exists a real orthogonal matrix $Q$ such that $D=Q^TAQ$ is a diagonal matrix [[1](#ref-1)].
{: .notice--primary}

Proof [[2](#ref-2), [3](#ref-3)] (using mathematical induction method):

(I) If $A$ is $1\times1$, i.e., $A=[a]$, then:
$$
A=[1][a][1]=UAU^T
$$
where $A$ is diagonal, and $U$ is orthogonal.

(II) Now, assume that:
$$
\text{every }(n-1)\times(n-1)\text{ symmetric matrix is orthogonally diagonalizable.}\label{eq2023-11-02-01}
$$
Next, we will prove that $n\times n$ symmetric matrix is orthogonally diagonalizable under the case of assumption $\eqref{eq2023-11-02-01}$ is true.

Given an $n\times n$ symmetric matrix $A$ where $n>1$, we could find a real eigenvalue $\lambda_1$ of $A$, and its corresponding eigenvector $\boldsymbol{v}_1$. $\boldsymbol{v}_1$ could be normalized to a unit eigenvector (i.e., $\vert\vert\boldsymbol{v}_1\vert\vert=1$), and for sake of simplicity we also denote this unit eigenvector as $\boldsymbol{v}_1$. Afterwards, we could add some vectors to extend $$\{\boldsymbol{v}_1\}$$ to a complete orthornormal basis, $$\mathcal{B}=\{\boldsymbol{v}_1,\cdots,\boldsymbol{v}_n\}$$, in vector space $\mathbb{R}^n$ by Gram-Schmidt process (could refer to [[4](#ref-4)]), and denote it as orthonormal matrix $P$, i.e.,
$$
P=P_{\mathcal{B}}=[\boldsymbol{v}_1\ \boldsymbol{v}_2\ \cdots\ \boldsymbol{v}_n]
$$
$P$ is orthogonal, which means that:
$$
P^{-1}=P^T
$$
For matrix $P^{-1}AP$, we have:

(1) $P^{-1}AP$ is symmetric. Since:
$$
(P^{-1}AP)^T=P^TA^T(P^{-1})^T=P^{-1}AP.
$$
(2) The first column of $P^{-1}AP$, i.e., $P^{-1}AP\boldsymbol{e}_1$, is $[\lambda_1\ 0\ \cdots\ 0]^T$. Since:
$$
P^{-1}AP\boldsymbol{e}_1=P^{-1}A\boldsymbol{v}_1=\lambda_1 P^{-1}\boldsymbol{v}_1=\lambda_1P^T\boldsymbol{v}_1
$$
going further, we have:
$$
\begin{split}
P^{-1}AP\boldsymbol{e}_1&=\lambda_1P^T\boldsymbol{v}_1\\
&=\lambda_1\begin{bmatrix}
\boldsymbol{v}_1^T\\
\boldsymbol{v}_2^T\\
\cdots\\
\boldsymbol{v}_n^T\\
\end{bmatrix}\boldsymbol{v}_1=\begin{bmatrix}
\lambda_1\\
0\\
\vdots\\
0
\end{bmatrix}
\end{split}
$$
Based on above two facts, $P^{-1}AP$ could be partitioned and denoted using block matrix:
$$
P^{-1}AP=\begin{bmatrix}
\lambda_1&\boldsymbol{0}\\
\boldsymbol{0}&B\\
\end{bmatrix}
$$
where $\boldsymbol{0}$ is a block with $n-1$ zeros, and $B$ is a symmetric matrix. 

> Why $B$ is symmetric matrix?
>
> For $j$-th ($j\ne1$) column of $P^{-1}AP$, we have:
> $$
> P^{-1}AP\boldsymbol{e}_j=\textcolor{red}{P^{-1}Av_j}
> $$
> For $j$-th ($j\ne1$) row of $P^{-1}AP$, have:
> $$
> \boldsymbol{e}_j^TP^{-1}AP
> =\boldsymbol{e}_j^TP^TAP
> =(P\boldsymbol{e}_j)^TAP
> =\boldsymbol{v}_j^TAP
> =(P^TA\boldsymbol{v}_j)^T
> =\textcolor{red}{(P^{-1}A\boldsymbol{v}_j)^T}
> $$
> i.e.,
> $$
> (P^{-1}AP\boldsymbol{e}_j)^T=\boldsymbol{e}_j^TP^{-1}AP
> $$

Therefore, according to assumption $\eqref{eq2023-11-02-01}$, symmetric matrix $B$ is orthogonally diagonalizable, i.e., there is a diagonal matrix $D^\prime$, and an $(n-1)\times(n-1)$ orthogonal matrix $Q$:
$$
B=QD^\prime Q^{-1}\Leftrightarrow Q^{-1}BQ=D^\prime 
$$
Afterwards, we could define an $n\times n$ block matrix $R$:
$$
R=\begin{bmatrix}
1&\boldsymbol{0}\\
\boldsymbol{0}&Q\\
\end{bmatrix}
$$
Since
$$
\begin{bmatrix}
1&\boldsymbol{0}\\
\boldsymbol{0}&Q\\
\end{bmatrix}
\begin{bmatrix}
1&\boldsymbol{0}\\
\boldsymbol{0}&Q^{-1}\\
\end{bmatrix}=
\begin{bmatrix}
1&\boldsymbol{0}\\
\boldsymbol{0}&I\\
\end{bmatrix}
$$
we have:
$$
R^{-1}=\begin{bmatrix}
1&\boldsymbol{0}\\
\boldsymbol{0}&Q^{-1}\\
\end{bmatrix}
$$
Next, let:
$$
U=PR
$$
and $U$ is orthogonal as a product of two orthonormal matrices is orthogonal according to [Theorem-4](#theorem-4). Then, we have:
$$
\begin{split}
U^{-1}AU&=(R^{-1}P^{-1})A(PR)\\
&=R^{-1}\begin{bmatrix}
\lambda_1&\boldsymbol{0}\\
\boldsymbol{0}&B\\
\end{bmatrix}R\\
&=\begin{bmatrix}
1&\boldsymbol{0}\\
\boldsymbol{0}&Q^{-1}\\
\end{bmatrix}
\begin{bmatrix}
\lambda_1&\boldsymbol{0}\\
\boldsymbol{0}&B\\
\end{bmatrix}
\begin{bmatrix}
1&\boldsymbol{0}\\
\boldsymbol{0}&Q\\
\end{bmatrix}\\
&=\begin{bmatrix}
\lambda_1&\boldsymbol{0}\\
\boldsymbol{0}&Q^{-1}BQ\\
\end{bmatrix}\\
&=\begin{bmatrix}
\lambda_1&\boldsymbol{0}\\
\boldsymbol{0}&D^\prime\\
\end{bmatrix}
\end{split}
$$
So
$$
A=U\begin{bmatrix}
\lambda_1&\boldsymbol{0}\\
\boldsymbol{0}&D^\prime\\
\end{bmatrix}U^{-1}
$$
as described above, $D^\prime$ is diagonal matrix and $U$ is orthogonal matrix, therefore, assumption $\eqref{eq2023-11-02-01}$ still holds for $n\times n$ matrix.

Q.E.D.

## Theorem-3 (The Spectral Theorem): A (real) $n\times n$ matrix $A$ is orthogonally diagonalizable if and only if $A$ is symmetric.

<div id="theorem-3"></div>

***Theorem-3 (The Spectral Theorem)***: A (real) $n\times n$ matrix $A$ is orthogonally diagonalizable if and only if $A$ is symmetric.

*Proof*: [Theorem-2](#theorem-2) proves the necessity and [Theorem-1](#theorem-1) proves the sufficiency.

Q.E.D. 

<br>



# The spectral decomposition of a real symmetric matrix

According to the proof of [Theorem-2](#theorem-2), if $A$ is a real $n\times n$ symmetric matrix, then we could orthogonally diagonalize:
$$
A=UDU^T=U\begin{bmatrix}
\lambda_1&0&\cdots&0\\
0&\lambda_2&\cdots&0\\
\vdots&\vdots&\ddots&\vdots\\
0&0&\cdots&\lambda_n\\
\end{bmatrix}U^T
$$
where
$$
U=[\boldsymbol{u}_1\ \boldsymbol{u}_2\ \cdots\ \boldsymbol{u}_n]
$$
is an orthogonal matrix and $\boldsymbol{u}_i$ is the eigenvector corresponding to eigenvalue $\lambda_j$. So, we have:
$$
\begin{split}
A&=
\begin{bmatrix}
\boldsymbol{u}_1&
\boldsymbol{u}_2&
\cdots&
\boldsymbol{u}_n\\
\end{bmatrix}
\begin{bmatrix}
\lambda_1&0&\cdots&0\\
0&\lambda_2&\cdots&0\\
\vdots&\vdots&\ddots&\vdots\\
0&0&\cdots&\lambda_n\\
\end{bmatrix}
\begin{bmatrix}
\boldsymbol{u}_1^T\\
\boldsymbol{u}_2^T\\
\vdots\\
\boldsymbol{u}_n^T\\
\end{bmatrix}\\
&=\lambda_1\boldsymbol{u}_1\boldsymbol{u}_1^T+\lambda_2\boldsymbol{u}_2\boldsymbol{u}_2^T+\cdots+\lambda_n\boldsymbol{u}_n\boldsymbol{u}_n^T
\end{split}\label{eq2023-11-02-02}
$$
The subspaces $$\mathrm{Span}\{\boldsymbol{u}_i\}$$ are orthogonal straight lines through $\boldsymbol{0}$ in $\mathbb{R}^n$, each $n\times n$ matrix $$\boldsymbol{u}_i\boldsymbol{u}_i^T$$ is the projection of $\mathbb{R}^n$ (the column space of $A$) onto  $$\mathrm{Span}\{\boldsymbol{u}_i\}$$.

Specifically, equation $\eqref{eq2023-11-02-02}$ illustrates that $A$ can be written as a linear combination of projections onto $n$ orthogonal “axes” in $\mathbb{R}^n$. This linear combination uses all eigenvalues (the spectrum) of $A$ as weights, so $\eqref{eq2023-11-02-02}$ is called spectral decomposition of $A$.

If applying $\eqref{eq2023-11-02-02}$ to a point $x$ in $\mathbb{R}^n$, we could get:
$$
\begin{split}
A\boldsymbol{x}
&=\lambda_1\boldsymbol{u}_1\boldsymbol{u}_1^T\boldsymbol{x}
+\lambda_2\boldsymbol{u}_2\boldsymbol{u}_2^T\boldsymbol{x}
+\cdots
+\lambda_n\boldsymbol{u}_n\boldsymbol{u}_n^T\boldsymbol{x}\\
&=\lambda_1\boldsymbol{u}_1\langle\boldsymbol{u}_1,\boldsymbol{x}\rangle
+\lambda_2\boldsymbol{u}_2\langle\boldsymbol{u}_2,\boldsymbol{x}\rangle
+\cdots
+\lambda_n\boldsymbol{u}_n\langle\boldsymbol{u}_n,\boldsymbol{x}\rangle\\
&=\lambda_1\dfrac{\langle\boldsymbol{u}_1,\boldsymbol{x}\rangle}{\langle\boldsymbol{u}_1,\boldsymbol{u}_1\rangle}\boldsymbol{u}_1
+\lambda_2\dfrac{\langle\boldsymbol{u}_2,\boldsymbol{x}\rangle}{\langle\boldsymbol{u}_2,\boldsymbol{u}_2\rangle}\boldsymbol{u}_2
+\cdots
+\lambda_n\dfrac{\langle\boldsymbol{u}_n,\boldsymbol{x}\rangle}{\langle\boldsymbol{u}_n,\boldsymbol{u}_n\rangle}\boldsymbol{u}_n\\
&=\lambda_1\mathrm{proj}_{\boldsymbol{u}_1}(\boldsymbol{x})
+\lambda_2\mathrm{proj}_{\boldsymbol{u}_2}(\boldsymbol{x})
+\cdots
+\lambda_n\mathrm{proj}_{\boldsymbol{u}_n}(\boldsymbol{x})
\end{split}
$$
where $\mathrm{proj}_{\boldsymbol{u}}(\boldsymbol{v})$ is the vector projection of vector $\boldsymbol{v}$ on a nonzero vector $\boldsymbol{u}$ (could see references [[4](#ref-4), [6](#ref-6)]). 















From 






$$
(\boldsymbol{u}_1\boldsymbol{u}_1^T)A=\lambda_1\boldsymbol{u}_1\boldsymbol{u}_1^T\boldsymbol{u}_1\boldsymbol{u}_1^T=\lambda_1\boldsymbol{u}_1\boldsymbol{u}_1^T
$$

$$
(\boldsymbol{u}_1\boldsymbol{u}_1^T)(A-\lambda_1\boldsymbol{u}_1\boldsymbol{u}_1^T)=\boldsymbol{0}
$$

$$
\mathrm{Rank}(\boldsymbol{u}_1\boldsymbol{u}_1^T)=1
$$












==what is spectral of matrix==

<br>

**References**

<div id="ref-1"></div>
[1] [Symmetric matrix - Wikipedia](https://en.wikipedia.org/wiki/Symmetric_matrix).

<div id="ref-2"></div>
[2] [Orthogonal Diagonalization Proof](https://people.math.carleton.ca/~kcheung/math/notes/MATH1107/wk10/10_orthogonal_diagonalization_proof.html).

<div id="ref-3"></div>
[3] [Orthogonally Diagonalizable Matrices](https://www.math.wustl.edu/~freiwald/309orthogdiag.pdf).

<div id="ref-4"></div>
[4] [Gram-Schmidt Process - What a starry night~](https://helloworld-1017.github.io/2023-11-01/22-00-27.html).

<div id="ref-5"></div>
[5] [Orthogonal matrix - Wikipedia](https://en.wikipedia.org/wiki/Orthogonal_matrix).

<div id="ref-6"></div>
[6] [Scalar Projection, Vector Projection, Scalar Rejection and Vector Rejection - What a starry night~](https://helloworld-1017.github.io/2023-05-09/13-36-31.html).