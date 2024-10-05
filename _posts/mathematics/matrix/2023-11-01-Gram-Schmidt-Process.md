---
layout: single
title: Gram-Schmidt Process
date: 2023-11-01 22:00:27 +0800
categories:
 - Mathematics
 - MATLAB
tags:
 - Matrix
---

# Gram-Schmidt process 

Gram-Schmidt process (or Gram-Schmidt algorithm) is a method for orthonormalizing a set of vectors in an inner product space, most commonly the Euclidean space $\mathbb{R}^n$ equipped with the standard inner product[^1]. The Gram-Schmidt process takes a finite, linearly independent set of vectors $$S=\{\boldsymbol{v}_1,\cdots,\boldsymbol{v}_k\}$$ for $k\le n$ (NOTE WELL HERE) and generates an orthogonal set $$S'=\{\boldsymbol{u}_1,\cdots,\boldsymbol{u}_k\}$$ (and hence orthonormal set $$\{\boldsymbol{e}_1,\cdots,\boldsymbol{e}_k\}$$) that spans the same $k$-dimensional subspace of $\mathbb{R}^n$ as $S$. The whole Gram-Schmidt process shows as follows.

At first, the vector projection[^2] of a vector $\boldsymbol{v}$ on a nonzero vector $\boldsymbol{u}$ is defined as:

$$
\mathrm{proj}_\boldsymbol{u}(\boldsymbol{v})=\dfrac{\langle\boldsymbol{v},\boldsymbol{u}\rangle}{\langle\boldsymbol{u},\boldsymbol{u}\rangle}\boldsymbol{u}\label{eq1}
$$

where $\langle\boldsymbol{v},\boldsymbol{u}\rangle$ is the inner product of $\boldsymbol{u}$ and $\boldsymbol{v}$. Definition $\eqref{eq1}$ means that $$\mathrm{proj}_\boldsymbol{u}(\boldsymbol{v})$$ is the orthogonal projection of $\boldsymbol{v}$ onto the line spanned by $\boldsymbol{u}$. If $\boldsymbol{u}$ is the zero vector, then $$\mathrm{proj}_\boldsymbol{u}(\boldsymbol{v})$$ is defined as the zero vector.

Given $k$ vectors $\boldsymbol{v}_1,\cdots,\boldsymbol{v}_k$, the Gram-Schmidt process defines the vectors $\boldsymbol{u}_1,\cdots,\boldsymbol{u}_k$ as follows:

$$
\begin{split}
&\boldsymbol{u}_1=\boldsymbol{v}_1\\
&\boldsymbol{u}_2=\boldsymbol{v}_2-\mathrm{proj}_{\boldsymbol{u}_1}(\boldsymbol{\boldsymbol{v}_2})\\
&\boldsymbol{u}_3=\boldsymbol{v}_3-\mathrm{proj}_{\boldsymbol{u}_1}(\boldsymbol{\boldsymbol{v}_3})-\mathrm{proj}_{\boldsymbol{u}_2}(\boldsymbol{\boldsymbol{v}_3})\\
&\boldsymbol{u}_4=\boldsymbol{v}_4-\mathrm{proj}_{\boldsymbol{u}_1}(\boldsymbol{\boldsymbol{v}_4})-\mathrm{proj}_{\boldsymbol{u}_2}(\boldsymbol{\boldsymbol{v}_4})-\mathrm{proj}_{\boldsymbol{u}_3}(\boldsymbol{\boldsymbol{v}_4})\\
&\qquad\vdots\\
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

The vector sequence $$\boldsymbol{u}_1,\cdots,\boldsymbol{u}_k$$ is the required system of orthogonal vectors, and is known as **Gram-Schmidt orthogonalization**. The normalised vector $$\boldsymbol{e}_1,\cdots,\boldsymbol{e}_k$$ is from an orthonormal set, and known as **Gram-Schmidt orthonormalization**.

Generally, I feel that Gram-Schmidt process is a process of finding **vector rejection**[^2].

<br>

# MATLAB algorithm implementation

Wikipedia also provides a MATLAB function `gramschmidt` [[1: Algorithm](https://en.wikipedia.org/wiki/Gram%E2%80%93Schmidt_process#Algorithm)] to conduct Gram–Schmidt algorithm:

```matlab
function U = gramschmidt(V)
[n,k] = size(V);
U = zeros(n,k);
U(:,1) = V(:,1)/norm(V(:,1));
for i = 2:k
    U(:,i) = V(:,i);
    for j = 1:i-1
        U(:,i) = U(:,i)-(U(:,j)'*U(:,i))*U(:,j);
    end
    U(:,i) = U(:,i)/norm(U(:,i));
end
end
```

It view as each column of input variable `V` as $\boldsymbol{v}_i$, and each column of output variable `U` corresponds to orthonormalized $\boldsymbol{e}_i$. In the following text, I would use this function to analyse Gram-Schmidt process.

## Case $n=k$

If $k$, the number of given vector set $$S=\{\boldsymbol{v}_1,\cdots,\boldsymbol{v}_k\}$$, is equal to the dimension of vector space $\mathbb{R}^n$, i.e., $k=n$, Gram-Schmidt process will find a *complete* orthonormal basis set. For example, for a random vector set $$S=\{\boldsymbol{v}_1,\boldsymbol{v}_2,\boldsymbol{v}_3\}\in\mathbb{R}^3$$:

```matlab
clc,clear,close all

rng("default")

n = 3;
k = 3;
A = rand(n,k);
U = gramschmidt(A);

idxCombinations = nchoosek(1:k,2);
for i = 1:height(idxCombinations)
    idx = idxCombinations(i,:);
    fprintf("<e%s,e%s>: %.4f\n", ...
        num2str(idx(1)),num2str(idx(2)),dot(U(:,idx(1)),U(:,idx(2))));
end

figure("Position",[817.67,580.33,973.33,486.67])
hold(gca,"on"),grid(gca,"on"),box(gca,"on")
view(26.499999959417345,41.611284029194252)
markerSize = 20;
colors = [
    0.2314,0.2863,0.5725;
    0.9333,0,0;
    0,0.5451,0.2706;
    0.3882,0.0941,0.4745;
    0,0.5098,0.5020];

for i = 1:width(U)
    p1 = plot3([0,A(1,i)],[0,A(2,i)],[0,A(3,i)], ...
        "LineWidth",1.5,"Color",colors(i,:),"Marker",".","MarkerSize",markerSize, ...
        "DisplayName",sprintf("Random vector, v%s",num2str(i)));
    p2 = plot3([0,U(1,i)],[0,U(2,i)],[0,U(3,i)], ...
        "LineWidth",1.5,"Color",colors(i,:),"Marker",".","MarkerSize",markerSize, ...
        "DisplayName",sprintf("Gram-Schmidt orthonormalization, e%s",num2str(i)), ...
        "LineStyle","--");
end
legend("Location","westoutside")

function U = gramschmidt(V)
[n,k] = size(V);
U = zeros(n,k);
U(:,1) = V(:,1)/norm(V(:,1));
for i = 2:k
    U(:,i) = V(:,i);
    for j = 1:i-1
        U(:,i) = U(:,i)-(U(:,j)'*U(:,i))*U(:,j);
    end
    U(:,i) = U(:,i)/norm(U(:,i));
end
end
```

```
U =
    0.6651    0.7463   -0.0256
    0.7395   -0.6631   -0.1162
    0.1037   -0.0583    0.9929
```

The $$S=\{\boldsymbol{v}_1,\boldsymbol{v}_2,\boldsymbol{v}_3\}$$ and $$S'=\{\boldsymbol{e}_1,\boldsymbol{e}_2,\boldsymbol{e}_3\}$$ shows as follows:

![image-20231101212229019](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311012122127.png)

It shows the orthonormal relation between $\boldsymbol{e}_1$, $\boldsymbol{e}_2$, and $\boldsymbol{e}_3$, and we could verify this point from the perspective of the results of dot product:

```
<e1,e2>: -0.0000
<e1,e3>: -0.0000
<e2,e3>: 0.0000
```

## Case $n>k$

If $n>k$, Gram-Schmidt process will find an *incomplete* orthonormal basis set in the subspace of $\mathbb{R}^n$ where $$\boldsymbol{v}_1,\cdots, \boldsymbol{v}_k$$ span. For example, for $n=3$ and $k=2$:

```matlab
rng("default")

n = 3;
k = 2;
A = rand(n,k);
U = gramschmidt(A);
...
```

```
U =
    0.6651    0.7463
    0.7395   -0.6631
    0.1037   -0.0583
```

![image-20231101213205656](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311012132698.png)

```
<e1,e2>: -0.0000
```

## Case $n<k$

At the case of $n>k$, Gram-Schmidt process will find a *complete* orthonormal basis set in $\mathbb{R}^n$, and besides that, $k-n$ redundant vectors will be generated as well. For example, for $n=3$ and $k=5$:

```matlab
rng("default")

n = 3;
k = 5;
A = rand(n,k);
U = gramschmidt(A);
...
```

```
U =
    0.6651    0.7463   -0.0256    0.6757    0.0057
    0.7395   -0.6631   -0.1162    0.7372   -0.0052
    0.1037   -0.0583    0.9929         0    1.0000
```

<div id="fig-1"></div>

![image-20231101213621375](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311012136420.png)

We could find that, $$S'=\{\boldsymbol{e}_1,\boldsymbol{e}_2,\boldsymbol{e}_3\}$$ is actually the complete orthonormal basis set what we want to get, and $\boldsymbol{e}_4$ and $\boldsymbol{e}_5$ are redundant:

```
<e1,e2>: -0.0000
<e1,e3>: -0.0000
<e1,e4>: 0.9946
<e1,e5>: 0.1036
<e2,e3>: 0.0000
<e2,e4>: 0.0155
<e2,e5>: -0.0507
<e3,e4>: -0.1029
<e3,e5>: 0.9933
<e4,e5>: 0.0000
```

Actually, [Fig. 1](#fig-1) shows the results of Gram-Schmidt process for ONLY three vectors of $$S=\{\boldsymbol{v}_1,\boldsymbol{v}_2,\boldsymbol{v}_3\}$$. We could verity this point:

```matlab
rng("default")

n = 3;
k = 5;
A = rand(n,k);
k = 3;
A = A(:,1:k);
U = gramschmidt(A);
...
```

```
U =
    0.6651    0.7463   -0.0256
    0.7395   -0.6631   -0.1162
    0.1037   -0.0583    0.9929
```

![image-20231101214330722](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311012143765.png)

If we choose another three vectors, like $$S=\{\boldsymbol{v}_2,\boldsymbol{v}_3,\boldsymbol{v}_5\}$$, Gram-Schmidt process will give another $S'$:

```matlab
rng("default")

n = 3;
k = 5;
A = rand(n,k);
A = A(:,[2,3,5]);
k = 3;
U = gramschmidt(A);
...
```

```
U =
    0.8190   -0.2425    0.5200
    0.5670    0.2040   -0.7980
    0.0875    0.9485    0.3046
```

![image-20231101214930097](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311012149143.png)

<br>

**References**

[^1]: [Gram-Schmidt process](https://en.wikipedia.org/wiki/Gram%E2%80%93Schmidt_process).
[^2]: [Scalar Projection, Vector Projection, Scalar Rejection and Vector Rejection](https://helloworld-1017.github.io/2023-05-09/13-36-31.html).