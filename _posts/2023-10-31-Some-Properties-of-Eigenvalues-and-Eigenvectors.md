---
layout: single
title: Some Properties of Eigenvalues and Eigenvectors
date: 2023-10-31 11:19:07 +0800
categories:
 - Mathematics
tags:
 - Matrix
---

# Any matrix

## Any matrix $A$ has the same eigenvalues as its transpose $A^T$

***Theorem***: Any matrix $A$ has the same eigenvalues as its transpose $A^T$ [[2]](#ref-2). 

*Proof* [[3]](#ref-3), [[4]](#ref-4):

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

[lamda1,v1] = eig(A)
[lamda2,v2] = eig(A')
```

```
lamda1 =

   -0.9094   -0.5658
    0.4160   -0.8246

v1 =

   -0.3723         0
         0    5.3723

lamda2 =

   -0.8246   -0.4160
    0.5658   -0.9094
    
v2 =

   -0.3723         0
         0    5.3723
```

And actually at some special cases, the probability that $A$ and $A^T$ have *no* common eigenvector is $1$ [[5]](#ref-5). 

<br>

# Hermitian matrix

## All eigenvalues of Hermitian matrix are real.

***Theorem***: All eigenvalues of Hermitian matrix are real.

*Proof*: The proof of this theorem could be found in [[6]](#ref-6).

We could obtain the following corollaries from this theorem:

***Corollary***: All coefficients of the characteristic polynomial of Hermitian matrix are real [[6]](#ref-6).

***Corollary***: The trace of Hermitian matrix is real [[6]](#ref-6).

***Corollary***: The determinant of Hermitian matrix is real [[6]](#ref-6).

<br>

# Real symmetric matrix (A special Hermitian matrix)  [[6]](#ref-6)

## All eigenvalues of real symmetric matrix are real.

***Theorem***: All eigenvalues of real symmetric matrix are real.

*Proof*: According to the definition of Hermitian matrix, real symmetric matrix is a special case of Hermitian matrix [[6]](#ref-6).

Similar to Hermitian matrix, these corollaries are also true:

***Corollary***: All coefficients of the characteristic polynomial of real symmetric matrix are real.

***Corollary***: The trace of real symmetric matrix is real.

***Corollary***: The determinant of real symmetric matrix is real.

## Eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal

***Theorem***: Eigenvectors corresponding to different eigenvalues of a real symmetric matrix are orthogonal.

Proof

<br>

**References**

<div id="ref-1"></div>
[1] [Eigenvalues and eigenvectors - Wikipedia](https://en.wikipedia.org/wiki/Eigenvalues_and_eigenvectors).

<div id="ref-2"></div>
[2] [Linear Algebra - in a Nutshell](https://pi.math.cornell.edu/~mec/Winter2009/RalucaRemus/Lecture1/lecture1.html).

<div id="ref-3"></div>
[3] [linear algebra - A matrix and its transpose have the same set of eigenvalues/other version: $A$ and $A^T$ have the same spectrum - Mathematics Stack Exchange](https://math.stackexchange.com/questions/123923/a-matrix-and-its-transpose-have-the-same-set-of-eigenvalues-other-version-a-a).

<div id="ref-4"></div>
[4] [[Solved] Which of the given options best describes the truthfulness of the following statements - testbook](https://testbook.com/question-answer/which-of-the-given-options-best-describes-the-trut--61a5cd1f1a84334be6d0298d).

<div id="ref-5"></div>
[5] [https://math.stackexchange.com/a/2664902](https://math.stackexchange.com/a/2664902).

<div id="ref-6"></div>
[6] [Hermitian Matrix - What a starry night~](https://helloworld-1017.github.io/2023-04-20/09-35-32.html).