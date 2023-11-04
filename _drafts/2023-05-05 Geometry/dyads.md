Dyads (Rank-one Matrix) in Linear Algebra

Consider three-dimensional euclidean space [^1], and let:
$$
\begin{split}
&\boldsymbol{a}=a_1\boldsymbol{\mathrm{i}}+a_2\boldsymbol{\mathrm{j}}+a_3\boldsymbol{\mathrm{k}}\\
&\boldsymbol{b}=b_1\boldsymbol{\mathrm{i}}+b_2\boldsymbol{\mathrm{j}}+b_3\boldsymbol{\mathrm{k}}\\
\end{split}
$$
be two vectors, and where $\boldsymbol{\mathrm{i}}$, $\boldsymbol{\mathrm{j}}$, and $\boldsymbol{\mathrm{k}}$ are the standard basis vectors in vector space $\mathbb{R}^3$, i.e.,
$$
\boldsymbol{\mathrm{i}}=
\begin{bmatrix}
1\\0\\0
\end{bmatrix},\ 
\boldsymbol{\mathrm{j}}=
\begin{bmatrix}
0\\1\\0
\end{bmatrix},\ 
\boldsymbol{\mathrm{k}}=
\begin{bmatrix}
0\\0\\1
\end{bmatrix}
$$
The the **dyadic product** of $\boldsymbol{a}$ and $\boldsymbol{b}$ can be represented as a sum:
$$
\begin{split}
\boldsymbol{a}\boldsymbol{b}
=&\quad a_1b_1\boldsymbol{\mathrm{i}}\boldsymbol{\mathrm{i}}
+a_1b_2\boldsymbol{\mathrm{i}}\boldsymbol{\mathrm{j}}
+a_1b_3\boldsymbol{\mathrm{i}}\boldsymbol{\mathrm{k}}\\
&+a_2b_1\boldsymbol{\mathrm{j}}\boldsymbol{\mathrm{i}}
+a_2b_2\boldsymbol{\mathrm{j}}\boldsymbol{\mathrm{j}}
+a_2b_3\boldsymbol{\mathrm{j}}\boldsymbol{\mathrm{k}}\\
&+a_3b_1\boldsymbol{\mathrm{k}}\boldsymbol{\mathrm{i}}
+a_3b_2\boldsymbol{\mathrm{k}}\boldsymbol{\mathrm{j}}
+a_3b_3\boldsymbol{\mathrm{k}}\boldsymbol{\mathrm{k}}\\
\end{split}
$$
which is a $3\times3$ matrix (also the result of the outer product or tensor product of $\boldsymbol{a}$ and $\boldsymbol{b}$ [^2]), i.e.,
$$
\boldsymbol{a}\boldsymbol{b}\equiv\boldsymbol{a}\otimes\boldsymbol{b}\equiv\boldsymbol{a}\boldsymbol{b}^T=
\begin{bmatrix}
a_1\\
a_2\\
a_3\\
\end{bmatrix}
\begin{bmatrix}
b_1&
b_2&
b_3
\end{bmatrix}
=
\begin{bmatrix}
a_1b_1&a_1b_2&a_1b_3\\
a_2b_1&a_2b_2&a_2b_3\\
a_3b_1&a_3b_2&a_3b_3\\
\end{bmatrix}\label{eq1}
$$

> Note: Equation $\eqref{eq1}$ is obtained from "Wikipedia: Dyadics"[^1], expressing that $\boldsymbol{a}\boldsymbol{b}$, $\boldsymbol{a}\otimes\boldsymbol{b}$, and $\boldsymbol{a}\boldsymbol{b}^T$ are equivalent when denoting the dyadic product of $\boldsymbol{a}$ and $\boldsymbol{b}$. And among which,  $\boldsymbol{a}\otimes\boldsymbol{b}$ and $\boldsymbol{a}\boldsymbol{b}^T$ are believed to be equivalent at "Wikipedia: Outer product"[^3] when representing the outer product of $\boldsymbol{a}$ and $\boldsymbol{b}$. To my mind, $\boldsymbol{a}\boldsymbol{b}^T$ is reasonable as it is consistent with the notation of matrix multiplication. But, symbol $\otimes$ is more commonly used as Kronecker product, and according to the definition[^4][^5], using $\boldsymbol{a}\otimes\boldsymbol{b}^T$ is more reasonable when  











$\boldsymbol{a}\otimes\boldsymbol{b}^T$ is a dyadic, 











A matrix $A\in\mathbb{R}^{m\times n}$ is a dyad if it is of the form $A=\boldsymbol{u}\boldsymbol{v}^T$ for some vectors $\boldsymbol{u}\in\mathbb{R}^m$, $\boldsymbol{v}\in\mathbb{R}^n$. The dyad acts on an input vector $\boldsymbol{x}\in\mathbb{R}^n$ as follows:
$$
A\boldsymbol{x}=(\boldsymbol{u}\boldsymbol{v}^T)\boldsymbol{x}=(\boldsymbol{v}^T\boldsymbol{x})\boldsymbol{u}
$$
In terms of the associated linear map, for a dyad, the output always points in the same direction $\boldsymbol{u}$ in output space $\mathbb{R}^m$, no matter what the input $x$ is. The output is thus always a sample scaled version of $\boldsymbol{u}$. The amount of scaling depends on the vector $\boldsymbol{v}$, via the linear function $\boldsymbol{x}\rightarrow\boldsymbol{v}^T\boldsymbol{x}$.





[Dyadic -- from Wolfram MathWorld](https://mathworld.wolfram.com/Dyadic.html)

[Vector Direct Product - from Wolfram MathWorld](https://mathworld.wolfram.com/VectorDirectProduct.html)



==try other rank-one matrix, i.e., from rank-one matrix to $u$==

[Special Matrices](https://inst.eecs.berkeley.edu/~ee127/sp21/livebook/l_mats_special.html).

[vectors - What is dyadic in linear algebra? - Mathematics Stack Exchange](https://math.stackexchange.com/questions/2768530/what-is-dyadic-in-linear-algebra#:~:text=A%20dyad%20is%20a%20matrix,of%20vectors%20a%20and%20b.).

<br>

**References**

[^1]: [Dyadics - Wikipedia](https://en.wikipedia.org/wiki/Dyadics).
[^2]: [Definition and Properties of Cross Product (Vector Product) and Outer Product (Tensor Product) - What a starry night~](https://helloworld-1017.github.io/2023-05-08/09-39-25.html).
[^3]: [Outer product - Wikipedia](https://en.wikipedia.org/wiki/Outer_product).
[^4]: [Kronecker product - Wikipedia](https://en.wikipedia.org/wiki/Kronecker_product).
[^5]: [Kronecker Product - from Wolfram MathWorld](https://mathworld.wolfram.com/KroneckerProduct.html).


