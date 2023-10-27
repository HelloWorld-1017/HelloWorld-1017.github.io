Recently, I read a previous blog [[1]](https://helloworld-1017.github.io/2023-04-21/18-44-31.html), which shows the eigenvalue interval pattern of random Hermitian matrix. On another hand, sample covariance matrix is always a real symmetric matrix, that is a special Hermitian matrix. Therefore, in this blog, I want to observe whether the eigenvalue of sample mean matrix have a similar interval pattern with that of *RANDOM* Hermitian ones.

Due to the number of eigenvalues of a $n$-order matrix is $n$ (including repeated ones), we should select the samples with high dimensions to get a covariance matrix which has a large shape, and thereby obtain sufficient eigenvalue points, to observe whose pattern. Therefore, I chose 










$$
\begin{split}
\text{Cond}(A)=&\vert\vert A\vert\vert\cdot\vert\vert A^{-1}\vert\vert\\
=&\sqrt{\max(\text{eig}(A^TA))}\cdot\sqrt{\max(\text{eig}((A^{-1})^TA^{-1}))}\\
\end{split}
$$
depends on 



<br>

<div id="ref"></div>

**References**

[1] [The Eigenvalue Interval Pattern of Random Hermitian Matrix - What a starry night~](https://helloworld-1017.github.io/2023-04-21/18-44-31.html).