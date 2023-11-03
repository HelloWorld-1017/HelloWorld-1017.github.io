

Dyads (Rank-one Matrix) in Linear Algebra



A matrix $A\in\mathbb{R}^{m\times n}$ is a dyad if it is of the form $A=\boldsymbol{u}\boldsymbol{v}^T$ for some vectors $\boldsymbol{u}\in\mathbb{R}^m$, $\boldsymbol{v}\in\mathbb{R}^n$. The dyad acts on an input vector $\boldsymbol{x}\in\mathbb{R}^n$ as follows:
$$
A\boldsymbol{x}=(\boldsymbol{u}\boldsymbol{v}^T)\boldsymbol{x}=(\boldsymbol{v}^T\boldsymbol{x})\boldsymbol{u}
$$
In terms of the associated linear map, for a dyad, the output always points in the same direction $\boldsymbol{u}$ in output space $\mathbb{R}^m$, no matter what the input $x$ is. The output is thus always a sample scaled version of $\boldsymbol{u}$. The amount of scaling depends on the vector $\boldsymbol{v}$, via the linear function $\boldsymbol{x}\rightarrow\boldsymbol{v}^T\boldsymbol{x}$.



[Dyadics - Wikipedia](https://en.wikipedia.org/wiki/Dyadics).

[Dyadic -- from Wolfram MathWorld](https://mathworld.wolfram.com/Dyadic.html)

[Vector Direct Product - from Wolfram MathWorld](https://mathworld.wolfram.com/VectorDirectProduct.html)



[Kronecker Product - from Wolfram MathWorld](https://mathworld.wolfram.com/KroneckerProduct.html)

[Kronecker product - Wikipedia](https://en.wikipedia.org/wiki/Kronecker_product).



==try other rank-one matrix, i.e., from rank-one matrix to $u$==



<br>

**References**

[Special Matrices](https://inst.eecs.berkeley.edu/~ee127/sp21/livebook/l_mats_special.html).

[vectors - What is dyadic in linear algebra? - Mathematics Stack Exchange](https://math.stackexchange.com/questions/2768530/what-is-dyadic-in-linear-algebra#:~:text=A%20dyad%20is%20a%20matrix,of%20vectors%20a%20and%20b.).