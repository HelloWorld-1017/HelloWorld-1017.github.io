Dyadic Product and Dyads (Rank-one Matrix) in Linear Algebra



# Dyadic product of two vectors

Consider three-dimensional Euclidean space [^1], and let:
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
\end{split}\label{eq0}
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

> N.B.: Equation $\eqref{eq1}$ is obtained from "Wikipedia: Dyadics"[^1], expressing that $\boldsymbol{a}\boldsymbol{b}$, $\boldsymbol{a}\otimes\boldsymbol{b}$, and $\boldsymbol{a}\boldsymbol{b}^T$ are equivalent when denoting the dyadic product of $\boldsymbol{a}$ and $\boldsymbol{b}$. And among which,  $\boldsymbol{a}\otimes\boldsymbol{b}$ and $\boldsymbol{a}\boldsymbol{b}^T$ are also believed to be equivalent at "Wikipedia: Outer product"[^3] when representing the outer product of $\boldsymbol{a}$ and $\boldsymbol{b}$. To my mind, $\boldsymbol{a}\boldsymbol{b}^T$ is reasonable as it is consistent with the notation of matrix multiplication. But, symbol $\otimes$ is more commonly used as Kronecker product, and according to the definition of **Kronecker product** [^4][^5], using $\boldsymbol{a}\otimes\boldsymbol{b}^T$ is more reasonable to denote dyadic product (We could use MATLAB `kron` function [^8] to verify this point). In fact, dyadic is known as vector direct product, and another reference [^6] indeed denotes the vector direct product of $\boldsymbol{a}$ and $\boldsymbol{b}$ as $\boldsymbol{a}\otimes\boldsymbol{b}^T$. As for the notation of $\boldsymbol{a}\boldsymbol{b}$, like in $\eqref{eq0}$, both references [^1][^6] point out it is right, but I contend it is kind of weird since it makes me confused if it appeared with matrix multiplication. In a word, I think the $\boldsymbol{a}\boldsymbol{b}^T$ and $\boldsymbol{a}\otimes\boldsymbol{b}^T$ are more appropriate, and in the following text, I will use the notation of $\boldsymbol{a}\otimes\boldsymbol{b}^T$ to denote dyadic product. For example, rewrite $\eqref{eq0}$ as:
> $$
> \begin{split}
> \boldsymbol{a}\otimes\boldsymbol{b}^T
> =&\quad a_1b_1(\boldsymbol{\mathrm{i}}\otimes\boldsymbol{\mathrm{i}}^T)
> +a_1b_2(\boldsymbol{\mathrm{i}}\otimes\boldsymbol{\mathrm{j}}^T)
> +a_1b_3(\boldsymbol{\mathrm{i}}\otimes\boldsymbol{\mathrm{k}}^T)\\
> &+a_2b_1(\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{i}}^T)
> +a_2b_2(\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{j}}^T)
> +a_2b_3(\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{k}}^T)\\
> &+a_3b_1(\boldsymbol{\mathrm{k}}\otimes\boldsymbol{\mathrm{i}}^T)
> +a_3b_2(\boldsymbol{\mathrm{k}}\otimes\boldsymbol{\mathrm{j}}^T)
> +a_3b_3(\boldsymbol{\mathrm{k}}\otimes\boldsymbol{\mathrm{k}}^T)\\
> \end{split}\label{eq2}
> $$

<br>

# Dyad

From $\eqref{eq1}$, we could obtain a series of **standard basis (and unit) dyads**:
$$
\begin{split}
&\boldsymbol{\mathrm{i}}\otimes\boldsymbol{\mathrm{i}}^T=\begin{bmatrix}
1&0&0\\0&0&0\\0&0&0\\
\end{bmatrix},\ 
&\boldsymbol{\mathrm{i}}\otimes\boldsymbol{\mathrm{j}}^T=\begin{bmatrix}
0&1&0\\0&0&0\\0&0&0\\
\end{bmatrix},\ 
&\boldsymbol{\mathrm{i}}\otimes\boldsymbol{\mathrm{k}}^T=\begin{bmatrix}
0&0&1\\0&0&0\\0&0&0\\
\end{bmatrix}\\
&\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{i}}^T=\begin{bmatrix}
0&0&0\\1&0&0\\0&0&0\\
\end{bmatrix},\ 
&\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{j}}^T=\begin{bmatrix}
0&0&0\\0&1&0\\0&0&0\\
\end{bmatrix},\ 
&\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{k}}^T=\begin{bmatrix}
0&0&0\\0&0&1\\0&0&0\\
\end{bmatrix}\\
&\boldsymbol{\mathrm{k}}\otimes\boldsymbol{\mathrm{i}}^T=\begin{bmatrix}
0&0&0\\0&0&0\\1&0&0\\
\end{bmatrix},\ 
&\boldsymbol{\mathrm{k}}\otimes\boldsymbol{\mathrm{j}}^T=\begin{bmatrix}
0&0&0\\0&0&0\\0&1&0\\
\end{bmatrix},\ 
&\boldsymbol{\mathrm{k}}\otimes\boldsymbol{\mathrm{k}}^T=\begin{bmatrix}
0&0&0\\0&0&0\\0&0&1\\
\end{bmatrix} 
\end{split}\label{eq4}
$$
While a **dyad** is a component of the dyadic, i.e., the dyadic product of a pair of basis vectors scalar multiplied by a number. For example, for a matrix $A$ denoted in the standard basis:
$$
\begin{split}
A&=2\boldsymbol({\mathrm{i}}\otimes\boldsymbol{\mathrm{j}}^T)
+\dfrac{\sqrt{3}}{2}(\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{i}}^T)
-8\pi(\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{k}}^T)
+\dfrac{2\sqrt2}{3}(\mathrm{\boldsymbol{k}}\otimes\boldsymbol{\mathrm{k}}^T)\\
&=2\begin{bmatrix}
0&1&0\\0&0&0\\0&0&0\\
\end{bmatrix}
+\dfrac{\sqrt3}{2}\begin{bmatrix}
0&0&0\\1&0&0\\0&0&0\\
\end{bmatrix}
-8\pi\begin{bmatrix}
0&0&0\\0&0&1\\0&0&0\\
\end{bmatrix}
+\dfrac{2\sqrt2}{3}\begin{bmatrix}
0&0&0\\0&0&0\\0&0&1\\
\end{bmatrix}\\
&=\begin{bmatrix}
0&2&0\\
\dfrac{\sqrt3}{2}&0&-8\pi\\
0&0&\dfrac{2\sqrt2}{3}\\
\end{bmatrix}
\end{split}
$$
where $2\boldsymbol({\mathrm{i}}\otimes\boldsymbol{\mathrm{j}}^T)$ is a dyad, and so do $\dfrac{\sqrt{3}}{2}(\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{i}}^T)$, $-8\pi(\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{k}}^T)$, and $\dfrac{2\sqrt2}{3}(\mathrm{\boldsymbol{k}}\otimes\boldsymbol{\mathrm{k}}^T)$.

As can be seen, **the rank of dyad is one**. In fact, dyad is also called **rank-one matrix** [^7]. In reference [^7], the definition of dyad is: A matrix $A\in\mathbb{R}^{m\times n}$ is a **dyad** if it is of the form $A=\boldsymbol{a}\boldsymbol{b}^T$ for some vectors $\boldsymbol{a}\in\mathbb{R}^m$, $\boldsymbol{b}\in\mathbb{R}^n$. This definition is more general than above case $\eqref{eq4}$, where two vectors are both unit and the dimension are the same, equal to three. 

Reference [^7] points out that, the dyad acts on an input vector $\boldsymbol{x}\in\mathbb{R}^n$ as follows:
$$
A\boldsymbol{x}=(\boldsymbol{a}\otimes\boldsymbol{b}^T)\boldsymbol{x}=(\boldsymbol{b}^T\boldsymbol{x})\boldsymbol{a}\label{eq5}
$$
This is easy to understand and to prove, as $\boldsymbol{b}^T\boldsymbol{x}$ is scalar. But equation $\eqref{eq5}$ reflects an important fact: the output of a dyad acting on a vector $\boldsymbol{x}$ always points in the same direction $\boldsymbol{a}$ in output space $\mathbb{R}^m$, no matter what the input $\boldsymbol{x}$ is; and the amount of scaling just depends on the vector $\boldsymbol{b}$, via the linear function $\boldsymbol{x}\rightarrow\boldsymbol{b}^T\boldsymbol{x}$.

For example, we could select a vector $\boldsymbol{a}\in\mathbb{R}^3$, a vector $\boldsymbol{b}\in\mathbb{R}^2$, and some vectors from $\boldsymbol{x}_i\in\mathbb{R}^2$, and construct a linear transformation $A=\boldsymbol{a}\otimes\boldsymbol{b}^T$, and at last, plot  $\boldsymbol{x}_i$ and $A\boldsymbol{x}_i$ in the vector space:

<div id="script-1"></div>

```matlab
clc,clear,close all

rng(17)

a = rand(3,1);
b = rand(2,1);

x1 = rand(2,1);
x2 = rand(2,1);
x3 = rand(2,1);

x11 = kron(a,b)*x1; % x11 = a*b'*x1;
x22 = kron(a,b)*x2; % x22 = a*b'*x2;
x33 = kron(a,b)*x3; % x33 = a*b'*x3;

colors = [1,0,0;
    0,0.545,0;
    0,0,1];

figure("Position",[925,453,560,420])
ax = axes;
view(ax,40.30,34.80)
lineWidth = 1.5;
markerSize = 20;
hold(ax,"on"),box(ax,"on"),grid(ax,"on")
plot3([0,a(1)],[0,a(2)],[0,a(3)], ...
    "LineWidth",lineWidth+0.5,"Marker",".","MarkerSize",markerSize, ...
    "Color","k","DisplayName","$a$")

plot3([0,x1(1)],[0,x1(2)],[0,0], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "LineStyle","-.","Color",colors(1,:),"DisplayName","$x_1$")
plot3([0,x2(1)],[0,x2(2)],[0,0], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "LineStyle","-.","Color",colors(2,:),"DisplayName","$x_2$")
plot3([0,x3(1)],[0,x3(2)],[0,0], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "LineStyle","-.","Color",colors(3,:),"DisplayName","$x_3$")

plot3([0,x11(1)],[0,x11(2)],[0,x11(3)], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "Color",colors(1,:),"DisplayName","$ab^Tx_1$")
plot3([0,x22(1)],[0,x22(2)],[0,x22(3)], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "Color",colors(2,:),"DisplayName","$ab^Tx_2$")
plot3([0,x33(1)],[0,x33(2)],[0,x33(3)], ...
    "LineWidth",lineWidth,"Marker",".","MarkerSize",markerSize, ...
    "Color",colors(3,:),"DisplayName","$ab^Tx_3$")
legend("Location","east","Interpreter","latex")
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311042357622.png" alt="image-20231104235700562" style="zoom: 67%;" />

As can be seen, $A\boldsymbol{x}_i$ always has the same direction as $\boldsymbol{a}$. And what's more, we could verify the following facts:

(1) $\mathrm{Rank}(A)=1$:

```
>> a*b'
ans =
    0.0200    0.2319
    0.0360    0.4176
    0.0130    0.1507

>> rank(a*b')
ans =
     1
```

(2) The scalar proportion of $\vert\vert A\boldsymbol{x}_i\vert\vert_2/\vert\vert\boldsymbol{b}^T\boldsymbol{x}_i\vert\vert_2$ is the same:

```
>> norm(x11)/norm(b'*x1), norm(x22)/norm(b'*x2), norm(x33)/norm(b'*x3)
ans =
    0.6364
ans =
    0.6364
ans =
    0.6364
```

This result is same as the length of $\boldsymbol{a}$: ==?==

```
>> norm(a)
ans =
    0.6364
```

Similarly, if select vectors $\boldsymbol{a}\in\mathbb{R}^2$, $\boldsymbol{b}\in\mathbb{R}^3$, $\boldsymbol{x}_i\in\mathbb{R}^3$, we could get:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311060853412.png" alt="image-20231106085256267" style="zoom:67%;" />

==try other rank-one matrix, i.e., from rank-one matrix to $u$==

<br>

# Normalized dyads [^7]

We could always normalize the dyad, by assuming that both $\boldsymbol{a}$, $\boldsymbol{b}$ are of unit (Euclidean) norm, and using a factor to capture their scale. That is, any dyad can be written in normalized form:
$$
A=\boldsymbol{a}\otimes\boldsymbol{b}^T=(\vert\vert\boldsymbol{a}\vert\vert_2\cdot\vert\vert\boldsymbol{b}\vert\vert_2)(\dfrac{\boldsymbol{a}}{\vert\vert\boldsymbol{a}\vert\vert_2})\otimes(\dfrac{\boldsymbol{b}}{\vert\vert\boldsymbol{b}\vert\vert_2})^T=\sigma\tilde{\boldsymbol{a}}\tilde{\boldsymbol{b}}^T
$$
where $\sigma>0$, and $\vert\vert\boldsymbol{a}\vert\vert_2\cdot\vert\vert\boldsymbol{b}\vert\vert_2=1$.

<br>

# Unit dyadic [^1]

As described above, equation $\eqref{eq4}$ shows nine unit *dyads* in $\mathbb{R}^3$. Similarly, we could define unit *dyadic* $\boldsymbol{I}$: For any vector $\boldsymbol{a}$, if:
$$
I\cdot\boldsymbol{a}=\boldsymbol{a}\cdot\boldsymbol{I}=\boldsymbol{a}
$$
then $I$ is a unit dyadic.

From $\eqref{eq4}$, we could obtain the unit dyadic in three-dimension vector space $\mathbb{R}^3$ (or rather, Cartesian coordinates [^9]): 
$$
I=
(\boldsymbol{\mathrm{i}}\otimes\boldsymbol{\mathrm{i}}^T)
+(\boldsymbol{\mathrm{j}}\otimes\boldsymbol{\mathrm{j}}^T)
+(\boldsymbol{\mathrm{k}}\otimes\boldsymbol{\mathrm{k}}^T)
$$

i.e.,
$$
I=\begin{bmatrix}
1&0&0\\
0&1&0\\
0&0&1\\
\end{bmatrix}
$$
<br>

# Conclusion







<br>

**References**

[^1]: [Dyadics - Wikipedia](https://en.wikipedia.org/wiki/Dyadics).
[^2]: [Definition and Properties of Cross Product (Vector Product) and Outer Product (Tensor Product) - What a starry night~](https://helloworld-1017.github.io/2023-05-08/09-39-25.html).
[^3]: [Outer product - Wikipedia](https://en.wikipedia.org/wiki/Outer_product).
[^4]: [Kronecker product - Wikipedia](https://en.wikipedia.org/wiki/Kronecker_product).
[^5]: [Kronecker Product - from Wolfram MathWorld](https://mathworld.wolfram.com/KroneckerProduct.html).
[^6]: [Vector Direct Product - from Wolfram MathWorld](https://mathworld.wolfram.com/VectorDirectProduct.html).
[^7]: [Special Matrices](https://inst.eecs.berkeley.edu/~ee127/sp21/livebook/l_mats_special.html).
[^8]: [`kron`: Kronecker tensor product - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/kron.html).
[^9]: [Dyadic - from Wolfram MathWorld](https://mathworld.wolfram.com/Dyadic.html).
