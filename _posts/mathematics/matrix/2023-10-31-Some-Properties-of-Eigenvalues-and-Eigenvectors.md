---
title: Some Properties of Eigenvalues and Eigenvectors
categories:
 - Mathematics
tags:
 - Matrix
date: 2023-10-31 11:19:07 +0800
last_modified_at: 2025-04-07 11:37:36 +0800
---

# Any matrix

## Any matrix $A$ has the same eigenvalues as its transpose $A^T$

Theorem-1: Any matrix $A$ has the same eigenvalues as its transpose $A^T$[^2]. 

Proof [^3][^4]:

If $A$ is a square matrix, then its eigenvalues are equal to the eigenvalues of it transpose since they share the same characteristic polynomial.

The characteristic polynomial of $A$ is: 

$$
\text{left}=\vert A-\lambda I\vert
$$

and for $A^T$:

$$
\text{right}=\vert A^T-\lambda I\vert=\vert(A-\lambda I)^T\vert=\vert A-\lambda I\vert
$$

Since $\vert A^T\vert=\vert A\vert$.
{: .notice--primary}

Q.E.D

But, it is important to highlight that, the eigenvalues of $A$ and $A^T$ are not the same, we could simply verify this point using MATLAB:

```matlab
A = [1,3;2,4];

[v1,lamda1] = eig(A)
[v2,lamda2] = eig(A')
```

```
v1 =
   -0.9094   -0.5658
    0.4160   -0.8246

lamda1 =
   -0.3723         0
         0    5.3723

v2 =
   -0.8246   -0.4160
    0.5658   -0.9094

lamda2 =
   -0.3723         0
         0    5.3723
```

And actually at some special cases, the probability that $A$ and $A^T$ have *no* common eigenvector is $1$[^5]. 

<br>

# Hermitian matrix

## All eigenvalues of Hermitian matrix are real.

Theorem-2: All eigenvalues of Hermitian matrix are real.

Proof: The proof of this theorem could be found in[^6].

We could obtain the following corollaries from this theorem:

<div id="corollary-2-1"></div>
Corollary-2-1: All coefficients of the characteristic polynomial of Hermitian matrix are real[^6].

<div id="corollary-2-2"></div>
Corollary-2-2: The trace of Hermitian matrix is real[^6].

<div id="corollary-2-3"></div>
Corollary-2-3: The determinant of Hermitian matrix is real[^6].

<br>

# Real symmetric matrix (A special Hermitian matrix)[^6]

## All eigenvalues of real symmetric matrix are real.

***Theorem-3***: All eigenvalues of real symmetric matrix are real.

*Proof*: According to the definition of Hermitian matrix, real symmetric matrix is a special case of Hermitian matrix[^6].

Similar to [Corollary-2-1](#corollary-2-1), [Corollary-2-2](#corollary-2-2), and [Corollary-2-3](#corollary-2-3) of Hermitian matrix, these corollaries are also true:

Corollary-3-1: All coefficients of the characteristic polynomial of real symmetric matrix are real.

Corollary-3-2: The trace of real symmetric matrix is real.

Corollary-3-3: The determinant of real symmetric matrix is real.

## If $A$ is a real $n\times n$ symmetric matrix, the $A$ has $n$ real eigenvalues (counted by their multiplicities). And for each eigenvalue, we can find a real eigenvector associated with it.

Theorem-5: If $A$ is a real $n\times n$ symmetric matrix, the $A$ has $n$ real eigenvalues (counted by their multiplicities). And for each eigenvalue, we can find a real eigenvector associated with it.

Proof: Refer to[^7].

## Eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal.

Theorem-4: Eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal.

Proof: The detailed proof could be found in[^7].

<br>

**References**

- [Eigenvalues and eigenvectors](https://en.wikipedia.org/wiki/Eigenvalues_and_eigenvectors).

[^2]: [Linear Algebra](https://pi.math.cornell.edu/~mec/Winter2009/RalucaRemus/Lecture1/lecture1.html).
[^3]: [linear algebra - A matrix and its transpose have the same set of eigenvalues/other version: $A$ and $A^T$ have the same spectrum](https://math.stackexchange.com/questions/123923/a-matrix-and-its-transpose-have-the-same-set-of-eigenvalues-other-version-a-a).
[^4]: [[Solved] Which of the given options best describes the truthfulness of the following statements](https://testbook.com/question-answer/which-of-the-given-options-best-describes-the-trut--61a5cd1f1a84334be6d0298d).
[^5]: [https://math.stackexchange.com/a/2664902](https://math.stackexchange.com/a/2664902).
[^6]: [Hermitian Matrix](/2023-04-20/09-35-32.html).
[^7]: [Some Properties of Real Symmetric Matrix](https://helloworld-1017.github.io/2023-10-31/11-36-28.html).