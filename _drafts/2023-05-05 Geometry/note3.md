Some Properties of Real Symmetric Matrix





[Linear Algebra - in a Nutshell](https://pi.math.cornell.edu/~mec/Winter2009/RalucaRemus/Lecture1/lecture1.html).



[linear algebra - Can the same vector be an eigenvector of both $A$ and $A^T$? - Mathematics Stack Exchange](https://math.stackexchange.com/questions/1899110/can-the-same-vector-be-an-eigenvector-of-both-a-and-at).





<br>

# Eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal [[3, 4]](#ref)

Eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal [[3, 4]](#ref). 

Proof:

Supposed that $x_1$ and $x_2$ is two eigenvectors of a real symmetric matrix, and corresponding *different* eigenvalues are $\lambda_1$ and $\lambda_2$, i.e.,
$$
\begin{split}
Ax_1=\lambda_1x_1\\
Ax_2=\lambda_2x_2\\
\end{split}
$$
and
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

















A real square matrix $A$ is orthogonally diagonalisable.



> The finite-dimensional spectral theorem says that any symmetric matrix whose entries are real can be diagonalised by orthogonal matrix. More explicitly: for every real symmetric matrix $A$ there exists a real orthogonal matrix $Q$ such that $D=Q^TAQ$ is a diagonal matrix. 







Every real symmetric matrix is thus, up to choice of an orthonormal basis, a diagonal matrix. 





Let $A$ be an $n\times n$ real symmetric matrix. 

Clearly, if $A$ is $1\times1$, we could simply get $U=[1]$ and $D=A$.

For the induction hypothesis, assume that every $(n-1)\times(n-1)$ real symmetric matrix is orthogonally diagonalisable.

Consider an $n\times n$ real symmetric matrix $A$. Let 

<br>

<div id="ref"></div>

**References**

[1] [Symmetric matrix - Wikipedia](https://en.wikipedia.org/wiki/Symmetric_matrix).

[2] [Orthogonal Diagonalization Proof](https://people.math.carleton.ca/~kcheung/math/notes/MATH1107/wk10/10_orthogonal_diagonalization_proof.html).

[3] [对称矩阵 特征向量正交 - 知乎](https://zhuanlan.zhihu.com/p/83669028).

[4] [46 Symmetric Matrices](https://staff.imsa.edu/~fogel/LinAlg/PDF/46%20Symmetric%20Matrices.pdf).