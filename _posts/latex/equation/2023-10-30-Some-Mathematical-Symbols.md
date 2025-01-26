---
title: Some Mathematical Symbols and Environments in LaTeX and MathJax
categories:
 - LaTeX
tags:
 - LaTeX Equation
 - Markdown
date: 2023-10-30 08:46:52 +0800
last_modified_at: 2024-11-08 22:32:07 +0800
---

# Mathematical operators

## Dot product (Inner product)

```latex
\langle\boldsymbol{u},\boldsymbol{v}\rangle=\boldsymbol{u}^T\boldsymbol{v}
```

$$
\langle\boldsymbol{u},\boldsymbol{v}\rangle=\boldsymbol{u}^T\boldsymbol{v}\notag
$$

Note that, the appearance of inputing `<` and `>` directly is very different from that using `\langle` and `\rangle`:

```latex
<\boldsymbol{u},\boldsymbol{v}>=\boldsymbol{u}^T\boldsymbol{v}
```

$$
<\boldsymbol{u},\boldsymbol{v}>=\boldsymbol{u}^T\boldsymbol{v}\notag
$$

## Cross product (Vector product)

```latex
\boldsymbol{u}\times\boldsymbol{v}
```

$$
\boldsymbol{u}\times\boldsymbol{v}\notag
$$

Or using wedge notation `\wedge` [^1]:

```latex
\boldsymbol{u}\wedge\boldsymbol{v}
```

$$
\boldsymbol{u}\wedge\boldsymbol{v}\notag
$$

## Kronecker product (Tensor product, Outer product) and other similar operators

Kronecker product (or tensor product): 

```latex
A\otimes B
```


$$
A\otimes B\notag
$$

or denote outer product of vectors:

```latex
\boldsymbol{u}\otimes\boldsymbol{v}^T
```

$$
\boldsymbol{u}\otimes\boldsymbol{v}^T\notag
$$


and some other similar symbols [^2]:

```latex
\oplus, \ominus, \odot, \oslash, \bigotimes, \bigoplus, \bigodot
```

$$
\oplus,\ \ominus,\ \odot,\ \oslash,\quad\bigotimes,\ \bigoplus,\ \bigodot\notag
$$

## Combination symbol

```latex
{n \choose k}
```

$$
{n \choose k}\notag
$$

<br>

# Mathematical symbols

## "For all" and "Exist" symbol

```latex
\forall, \exists
```

$$
\forall, \exists\notag
$$

## Function mapping symbol

```latex
\mapsto
```

$$
\mapsto\notag
$$

<br>

# Matrix environments [^3]

## `matrix` environment

```latex
\begin{matrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{matrix}
```

$$
\begin{matrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{matrix}\notag
$$

## `bmatrix` environment

```latex
\begin{bmatrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{bmatrix}
```

$$
\begin{bmatrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{bmatrix}\notag
$$

## `vmatrix` environment

```latex
\begin{vmatrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{vmatrix}
```

$$
\begin{vmatrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{vmatrix}\notag
$$

## `pmatrix` environment

```latex
\begin{pmatrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{pmatrix}
```

$$
\begin{pmatrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{pmatrix}\notag
$$

## `Bmatrix` envrionment

```latex
\begin{Bmatrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{Bmatrix}
```

$$
\begin{Bmatrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{Bmatrix}\notag
$$

## `Vmatrix` environment

```latex
\begin{Vmatrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{Vmatrix}
```

$$
\begin{Vmatrix}
a&b&c\\
d&e&f\\
g&h&i\\
\end{Vmatrix}\notag
$$

## Block matrix

```latex
\begin{pmatrix}
\begin{matrix}
1&0\\
0&1\\
\end{matrix}&0\\
0&\begin{matrix}
1&0\\
0&-1\\
\end{matrix}
\end{pmatrix}
```

$$
\begin{pmatrix}
\begin{matrix}
1&0\\
0&1\\
\end{matrix}&0\\
0&\begin{matrix}
1&0\\
0&-1\\
\end{matrix}
\end{pmatrix}\notag
$$

```latex
\begin{bmatrix}
\begin{pmatrix}
1&0\\
0&1\\
\end{pmatrix}&0\\
0&\begin{pmatrix}
1&0\\
0&-1\\
\end{pmatrix}
\end{bmatrix}
```

$$
\begin{bmatrix}
\begin{pmatrix}
1&0\\
0&1\\
\end{pmatrix}&0\\
0&\begin{pmatrix}
1&0\\
0&-1\\
\end{pmatrix}
\end{bmatrix}\notag
$$

## `bordermatrix` environment

```latex
\begin{equation}
\bordermatrix{
  & 1 & 2 & 3 \cr
1 & A & B & C \cr
2 & D & E & F \cr} 
\end{equation}
```

![image-20231109220042440](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311092202616.png)

Note that here, `bordermatrix` environment is not available in Markdown MathJax.

<br>

**References**

[^1]: [Cross product - Wikipedia](https://en.wikipedia.org/wiki/Cross_product).
[^2]: [【Latex】数学符号-代码对照表 - 爱吃猫的小鱼干的 Blog](https://su-lemon.gitee.io/post/73a19565.html).
[^3]: 刘海洋编著. LaTeX入门. 北京: 电子工业出版社, 2013.6, **pages 234-236**, available at: [Microsoft Word - 扉页.doc](https://yun.weicheng.men/Book/LaTeX%E5%85%A5%E9%97%A8.pdf) 