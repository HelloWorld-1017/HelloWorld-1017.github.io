

## Orthogonally diagonalizable

***Definition-1 (orthogonally diagonalizable)***: An $n\times n$ matrix $A$ is called *orthogonally diagonalizable* if there is an orthogonal matrix $U$ and a diagonal matrix $D$ for which $A=UDU^{-1}$ ($=UDU^T$) [[3](#ref-3)].

## If $A$ is orthogonally diagonalizable, then $A$ must be symmetric.

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

# A real $n\times n$ symmetric matrix $A$ is orthogonally diagonalizable.

***Theorem-2***: A real $n\times n$ symmetric matrix $A$ is orthogonally diagonalizable.

Proof:

(1) If $A$ is $1\times1$, i.e., $A=[a]$, then:
$$
A=[1][a][1]=UAU^T
$$
where $A$ is diagonal, and $U$ is orthogonal.

(2) Now, assume that:
$$
\text{every }(n-1)\times(n-1)\text{ symmetric matrix is orthogonally diagnoalizable.}
$$
Consider an $n\times n$ symmetric matrix $A$ where $n>1$.















The finite-dimensional spectral theorem says that any symmetric matrix whose entries are real can be diagonalised by orthogonal matrix. More explicitly: for every real symmetric matrix $A$ there exists a real orthogonal matrix $Q$ such that $D=Q^TAQ$ is a diagonal matrix. 



Every real symmetric matrix is thus, up to choice of an orthonormal basis, a diagonal matrix. 



Let $A$ be an $n\times n$ real symmetric matrix. 

Clearly, if $A$ is $1\times1$, we could simply get $U=[1]$ and $D=A$.

For the induction hypothesis, assume that every $(n-1)\times(n-1)$ real symmetric matrix is orthogonally diagonalisable.

Consider an $n\times n$ real symmetric matrix $A$. Let 

<div id="ref"></div>

**References**

[1] [Symmetric matrix - Wikipedia](https://en.wikipedia.org/wiki/Symmetric_matrix).

[2] [Orthogonal Diagonalization Proof](https://people.math.carleton.ca/~kcheung/math/notes/MATH1107/wk10/10_orthogonal_diagonalization_proof.html).

[3] [Orthogonally Diagonalizable Matrices](https://www.math.wustl.edu/~freiwald/309orthogdiag.pdf).