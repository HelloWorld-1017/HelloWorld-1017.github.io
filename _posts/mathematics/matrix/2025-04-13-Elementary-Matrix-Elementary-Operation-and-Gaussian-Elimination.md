---
title: Elementary Matrix, Elementary Operation, and Gaussian Elimination
toc: false
categories:
 - Mathematics
tags:
 - Matrix
date: 2025-04-13 11:15:43 +0800
last_modified_at: 2025-04-15 16:14:42 +0800
---

An elementary matrix corresponds to an elementary operation[^1]:

<div class="quote--left" markdown="1">

An <i class="term">elementary matrix</i> is a square matrix obtained from the application of a <i class="emphasize">single</i> elementary row operation to the identity matrix. ... Left multiplication (pre-multiplication) by an elementary matrix represents <i class="term">elementary row operations</i>, while right multiplication (post-multiplication) represents <i class="term">elementary column operations</i>.

</div>

Take elementary row operations as examples, there are three kinds of operations, i.e.

- row switching
- row multiplication
- row addition

The definition, corresponding elementary matrix, and properties of each operation can be found in reference[^1]. The following example compares the difference between the left multiplications (to show a series of elementary row operations) and the right multiplications (to show elementary column operations):

Left multiplications: elementary row operations

$$
\begin{split}
\begin{bmatrix}
1 & 2 & 3\\4 & 5 & 6\\7 & 8 & 9\\
\end{bmatrix}
&\rightarrow
\begin{bmatrix}
0 & 1 & 0\\1 & 0 & 0\\0 & 0 & 1\\
\end{bmatrix}
\begin{bmatrix}
1 & 0 & 0\\0 & -2 & 0\\0 & 0 & 1\\
\end{bmatrix}
\begin{bmatrix}
1 & 0 & 0\\0 & 1 & 0\\0 & 1 & 1\\
\end{bmatrix}
\begin{bmatrix}
1 & 2 & 3\\4 & 5 & 6\\7 & 8 & 9\\
\end{bmatrix}\\
(R_3+R_2\rightarrow R_3)&\rightarrow
\begin{bmatrix}
0 & 1 & 0\\1 & 0 & 0\\0 & 0 & 1\\
\end{bmatrix}
\begin{bmatrix}
1 & 0 & 0\\0 & -2 & 0\\0 & 0 & 1\\
\end{bmatrix}
\begin{bmatrix}
1 & 2 & 3\\
4 & 5 & 6\\
11 & 13 & 15
\end{bmatrix}\\
(-2R_2\rightarrow R_2)&\rightarrow
\begin{bmatrix}
0 & 1 & 0\\1 & 0 & 0\\0 & 0 & 1\\
\end{bmatrix}
\begin{bmatrix}
1 & 2 & 3\\-8 & -10 & -12\\11 & 13 & 15\\
\end{bmatrix}\\
(R_2\leftrightarrow R_1)&\rightarrow
\begin{bmatrix}
-8 & -10 & -12\\
1 & 2 & 3\\
11 & 13 & 15\\
\end{bmatrix}
\end{split}\notag
$$

Right multiplications: elementary column operations

$$
\begin{split}
\begin{bmatrix}
1 & 2 & 3\\4 & 5 & 6\\7 & 8 & 9\\
\end{bmatrix}
&\rightarrow
\begin{bmatrix}
1 & 2 & 3\\4 & 5 & 6\\7 & 8 & 9\\
\end{bmatrix}
\begin{bmatrix}
1 & 0 & 0\\0 & 1 & 0\\0 & 1 & 1\\
\end{bmatrix}
\begin{bmatrix}
1 & 0 & 0\\0 & -2 & 0\\0 & 0 & 1\\
\end{bmatrix}
\begin{bmatrix}
0 & 1 & 0\\1 & 0 & 0\\0 & 0 & 1\\
\end{bmatrix}\\
(C_3+C_2\rightarrow C_2)&\rightarrow
\begin{bmatrix}
1 & 5 & 3\\4 & 11 & 6\\7 & 17 & 9\\
\end{bmatrix}
\begin{bmatrix}
1 & 0 & 0\\0 & -2 & 0\\0 & 0 & 1\\
\end{bmatrix}
\begin{bmatrix}
0 & 1 & 0\\1 & 0 & 0\\0 & 0 & 1\\
\end{bmatrix}\\
(-2C_2\rightarrow C_2)&\rightarrow
\begin{bmatrix}
1 & -10 & 3\\
4 & -22 & 6\\
7 & -34 & 9\\
\end{bmatrix}
\begin{bmatrix}
0 & 1 & 0\\1 & 0 & 0\\0 & 0 & 1\\
\end{bmatrix}\\
(C_2\leftrightarrow C_1)&\rightarrow
\begin{bmatrix}
-10 & 1 & 3\\-22 & 4 & 6\\-34 & 7 & 9\\
\end{bmatrix}\\
\end{split}\notag
$$

<br>

Besides, there is an important theorem about elementary matrix,

<div class="quote--left" markdown="1">

A square matrix $\boldsymbol{\mathrm{A}}$ is invertible if and only if it can be written as the product of elementary matrices.[^2]

</div>

We can intuitively consider this matter--every invertible square matrix can be viewed as a result of a series of elementary operations on an identity matrix.

<br>

A practical case of applying elementary operations is using <i class="term">Gaussian elimination</i>[^3] to solve linear equations. The Wikipedia article provides[^3] a very detailed example:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504131408818.png" alt="image-20250413140802693" style="width:50%;" />

in which, the form like the matrix:

$$
\begin{bmatrix}
2 & 1 & -1\\ 0 & \dfrac12 & \dfrac12\\ 0 & 0 & -1\\
\end{bmatrix}\notag
$$

is called the <i class="term">row echelon form</i>[^4] (or <i class="term">triangular form</i>), and the elimination to get this form is called Gaussian elimination. And the form of the final resulting matrix like:

$$
\begin{bmatrix}
1 & 0 & 0\\ 0 & 1 & 0\\ 0 & 0 & 1\\
\end{bmatrix}\notag
$$

is called the <i class="term">reduced row echelon form</i>[^5], and this variant of Gaussian elimination that transforms a matrix to reduced row echelon form is sometimes called as <i class="term">Gauss–Jordan elimination</i>[^4].

By the way, when explaining this example in the article[^3], a term “<i class="term">back-substitution</i>” is used. It refers to the process that when the linear equation has been transformed into row echelon form or reduced row echelon form, the last equation should be solved first and then the next-to-last, etc.[^6]

<br>

**References**

[^1]: [Elementary matrix](https://en.wikipedia.org/wiki/Elementary_matrix).
[^2]: [linear algebra - Why is a matrix invertible if it can be written as the product of elementary matrices?](https://math.stackexchange.com/questions/2899761/why-is-a-matrix-invertible-if-it-can-be-written-as-the-product-of-elementary-mat).
[^3]: [Gaussian elimination](https://en.wikipedia.org/wiki/Gaussian_elimination).
[^4]: [Row echelon form](https://en.wikipedia.org/wiki/Row_echelon_form).
[^5]: [Reduced row echelon form](https://www.statlect.com/matrix-algebra/reduced-row-echelon-form).
[^6]: [Mathwords\: Back-Substitution](https://www.mathwords.com/b/back_substitution.htm).