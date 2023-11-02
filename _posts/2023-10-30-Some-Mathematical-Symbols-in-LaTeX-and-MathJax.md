---
layout: single
title: Some Mathematical Symbols in LaTeX and MathJax
date: 2023-10-30 08:46:52 +0800
last_modified_at: 2023-11-02 20:29:09 +0800
categories:
 - LaTeX
tags:
 - LaTeX Equation
---

# Dot product (Inner product): `\langle` and `\rangle`

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

<br>

# Cross product (Vector product): `\times` or `\wedge`

```latex
\boldsymbol{u}\times\boldsymbol{v}
```

$$
\boldsymbol{u}\times\boldsymbol{v}\notag
$$

Or using wedge notation `\wedge` [[1](#ref-1)]:

```latex
\boldsymbol{u}\wedge\boldsymbol{v}
```

$$
\boldsymbol{u}\wedge\boldsymbol{v}\notag
$$

<br>

# Outer product: `\otimes` and other similar symbols

```latex
\boldsymbol{u}\otimes\boldsymbol{v}
```


$$
\boldsymbol{u}\otimes\boldsymbol{v}\notag
$$

Other similar symbols [[2](#ref-2)]:

```latex
\oplus, \ominus, \odot, \oslash, \bigotimes, \bigoplus, \bigodot
```

$$
\oplus,\ \ominus,\ \odot,\ \oslash,\quad\bigotimes,\ \bigoplus,\ \bigodot\notag
$$

<br>

# Combination symbol: `\choose`

```latex
{n \choose k}
```

$$
{n \choose k}\notag
$$

<br>

# "For all" and "Exist" symbol: `\forall` and `\exists`

```latex
\forall, \exists
```

$$
\forall, \exists\notag
$$

<br>

# Function mapping symbol: `\mapsto`

```latex
\mapsto
```

$$
\mapsto\notag
$$



<br>

**References**

<div id="ref-1"></div>
[1] [Cross product - Wikipedia](https://en.wikipedia.org/wiki/Cross_product).

<div id="ref-2"></div>
[2] [【Latex】数学符号-代码对照表 - 爱吃猫的小鱼干的 Blog](https://su-lemon.gitee.io/post/73a19565.html).