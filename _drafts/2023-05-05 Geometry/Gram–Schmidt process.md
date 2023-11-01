Gram–Schmidt process





The vector projection [[2](#ref-2)] of a vector $\boldsymbol{v}$ on a nonzero vector $\boldsymbol{u}$ is defined as:
$$
\mathrm{proj}_\boldsymbol{u}(\boldsymbol{v})=\dfrac{\langle\boldsymbol{v},\boldsymbol{u}\rangle}{\langle\boldsymbol{u},\boldsymbol{u}\rangle}\boldsymbol{u}\label{eq1}
$$
where $\langle\boldsymbol{v},\boldsymbol{u}\rangle$ is the inner product of $\boldsymbol{u}$ and $\boldsymbol{v}$. Definition $\eqref{eq1}$ means that $\mathrm{proj}_\boldsymbol{u}(\boldsymbol{v})$ is the orthogonal projection of $\boldsymbol{v}$ onto the line spanned by $\boldsymbol{u}$. If $\boldsymbol{u}$ is the zero vector, then $\mathrm{proj}_\boldsymbol{u}(\boldsymbol{v})$ is defined as the zero vector.

Given $k$ vectors $\boldsymbol{v}_1,\cdots,\boldsymbol{v}_k$, the Gram-Schmidt process defines the vectors $\boldsymbol{u}_1,\cdots,\boldsymbol{u}_k$ as follows:
$$
\begin{split}
&\boldsymbol{u}_1=\boldsymbol{v}_1\\
&\boldsymbol{u}_2=\boldsymbol{v}_2-\mathrm{proj}_{\boldsymbol{u}_1}(\boldsymbol{\boldsymbol{v}_2})\\
&\boldsymbol{u}_3=\boldsymbol{v}_3-\mathrm{proj}_{\boldsymbol{u}_1}(\boldsymbol{\boldsymbol{v}_3})-\mathrm{proj}_{\boldsymbol{u}_2}(\boldsymbol{\boldsymbol{v}_3})\\
&\boldsymbol{u}_4=\boldsymbol{v}_4-\mathrm{proj}_{\boldsymbol{u}_1}(\boldsymbol{\boldsymbol{v}_4})-\mathrm{proj}_{\boldsymbol{u}_2}(\boldsymbol{\boldsymbol{v}_4})-\mathrm{proj}_{\boldsymbol{u}_3}(\boldsymbol{\boldsymbol{v}_4})\\
&\quad\vdots\\
&\boldsymbol{u}_k=\boldsymbol{v}_k-\sum_{i=1}^{k-1}\mathrm{proj}_{\boldsymbol{u}_i}(\boldsymbol{\boldsymbol{v}_k})\\
\end{split}
$$
and
$$
\begin{split}
&\boldsymbol{e}_1=\dfrac{\boldsymbol{u}_1}{\vert\vert\boldsymbol{u}_1\vert\vert}\\
&\boldsymbol{e}_2=\dfrac{\boldsymbol{u}_2}{\vert\vert\boldsymbol{u}_2\vert\vert}\\
&\boldsymbol{e}_3=\dfrac{\boldsymbol{u}_3}{\vert\vert\boldsymbol{u}_3\vert\vert}\\
&\boldsymbol{e}_4=\dfrac{\boldsymbol{u}_4}{\vert\vert\boldsymbol{u}_4\vert\vert}\\
&\quad\vdots\\
&\boldsymbol{e}_k=\dfrac{\boldsymbol{u}_k}{\vert\vert\boldsymbol{u}_k\vert\vert}\\
\end{split}
$$
The vector sequence 



是一组正交向量，但是如果$k$大于$n$呢？





<br>

**References**

<div id="ref-1"></div>
[1] [Gram–Schmidt process - Wikipedia](https://en.wikipedia.org/wiki/Gram%E2%80%93Schmidt_process).

<div id="ref-2"></div>
[2] [Scalar Projection, Vector Projection, Scalar Rejection and Vector Rejection - What a starry night~](https://helloworld-1017.github.io/2023-05-09/13-36-31.html).

<div id="ref-3"></div>
[3] [Gram-Schmidt in 9 Lines of MATLAB - MIT](https://web.mit.edu/18.06/www/Essays/gramschmidtmat.pdf).

[Gram–Schmidt process - Wikipedia](https://en.wikipedia.org/wiki/Gram%E2%80%93Schmidt_process#Algorithm)