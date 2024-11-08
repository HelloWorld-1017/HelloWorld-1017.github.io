---
title: Add Superscripts and Subscripts for Arrows in LaTeX Equation Environment
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
date: 2023-10-05 14:59:44 +0800
last_modified_at: 2023-10-05 14:59:44 +0800
---

In LaTeX, `amsmath` [1]  and `extarrows` (extensible arrows)  [2] macro package provide a set of control sequences to realize adding text over or under the arrows [3, p254]:

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage{extarrows}

\begin{document}
	\begin{equation*}
		\begin{aligned}
			&A\xleftarrow[a+b+c+d+e]{xyz}Z\qquad & A\xrightarrow[a+b+c+d+e]{xyz}Z\\
			&A\xlongleftarrow[a+b+c+d+e]{xyz}Z\qquad & A\xlongrightarrow[a+b+c+d+e]{xyz}Z\\
			&A\xLongleftarrow[a+b+c+d+e]{xyz}Z\qquad & A\xLongrightarrow[a+b+c+d+e]{xyz}Z\\
			&A\xleftrightarrow[a+b+c+d+e]{xyz}Z\qquad & A\xLeftrightarrow[a+b+c+d+e]{xyz}Z\\
			&A\xlongleftrightarrow[a+b+c+d+e]{xyz}Z\qquad & A\xLongleftrightarrow[a+b+c+d+e]{xyz}Z\\
			&A\xlongequal[a+b+c+d+e]{xyz}Z
		\end{aligned}
	\end{equation*}
\end{document}
```

![image-20231005160240672](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231005160240672.png)

> `\xleftarrow` and `\xrightarrow` produce arrows that extend automatically to accommodate unusually wide subscripts or superscripts. [1, p15]

Note that:

(1) The control sequences `\xleftarrow` and `\xrightarrow` are from `amsmath` package, whereas the others are from `extarrows` package. Therefore, some control sequences are not available in the equation environment of `.md` files:

```latex
\begin{aligned}
    &A\xleftarrow[a+b+c+d+e]{xyz}Z & A\xrightarrow[a+b+c+d+e]{xyz}Z\\
    &A\xlongleftarrow[a+b+c+d+e]{xyz}Z & A\xlongrightarrow[a+b+c+d+e]{xyz}Z\\
    &A\xLongleftarrow[a+b+c+d+e]{xyz}Z & A\xLongrightarrow[a+b+c+d+e]{xyz}Z\\
    &A\xleftrightarrow[a+b+c+d+e]{xyz}Z & A\xLeftrightarrow[a+b+c+d+e]{xyz}Z\\
    &A\xlongleftrightarrow[a+b+c+d+e]{xyz}Z & A\xLongleftrightarrow[a+b+c+d+e]{xyz}Z\\
    &A\xlongequal[a+b+c+d+e]{xyz}Z
\end{aligned}
```

![image-20231005160738413](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231005160738413.png)

(2) The control sequences which are included with `long` or `Long` word will create long arrows compared with that without it, **when the text content over or under arrow is short**. For example: 

![image-20231005160405496](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231005160405496.png)

![image-20231005162534355](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231005162534355.png)

<br>

On the other hand, the goal could be realized by `\ce` control sequence [3, p227]:

```latex
\begin{split}
    &\ce{2H2 + O2 ->[\text{combustion}] 2H2O}\\
    &\ce{2H2O + O2 <-[\text{decomposition}] 2H2O2}\\
\end{split}
```

$$
\begin{split}
    &\ce{2H2 + O2 ->[\text{combustion}] 2H2O}\\
    &\ce{2H2O + O2 <-[\text{decomposition}] 2H2O2}\\
\end{split}
$$

However, `\ce` is from `mhchem` macro package [5], which is for typesetting professional chemical formulas or equations, so the grammar of `\ce` is kind of different compared that used in traditional equation environment. `\ce` could be directly used in the equation environment of `.md` files. 

<br>

P.S. At the beginning, I mistakenly think that the control sequences like `\overleftarrow` and `\underleftarrow` [3, p228], which are also from `amsmath` package, could realize the goal. 

```latex
\begin{split}
    &\overleftarrow{text}\\
    &\overrightarrow{text}\\
    &\overleftrightarrow{text}\\
    &\underleftarrow{text}\\
    &\underrightarrow{text}\\
    &\underleftrightarrow{text}\\
\end{split}
```

$$
\begin{split}
    &\overleftarrow{text}\\
    &\overrightarrow{text}\\
    &\overleftrightarrow{text}\\
    &\underleftarrow{text}\\
    &\underrightarrow{text}\\
    &\underleftrightarrow{text}\\
\end{split}
$$

But actually, they are just for adding arrows over or under the text content, whose role are like `\overline` and `underline`. 

```latex
a\overleftarrow{text}b,\quad a\underleftarrow{text}b
```

$$
a\overleftarrow{text}b,\quad a\underleftarrow{text}b
$$

<br>

**References**

[1] [amsldoc.pdf](http://www.ams.org/arc/tex/amsmath/amsldoc.pdf).

[2] [CTAN: /tex-archive/macros/latex/contrib/extarrows](https://ctan.org/tex-archive/macros/latex/contrib/extarrows?lang=en).

[3] 刘海洋编著. LaTeX入门. 北京: 电子工业出版社, 2013.6.

[4] [Composing and Decomposing Matter](https://manoa.hawaii.edu/exploringourfluidearth/chemical/matter/composing-and-decomposing-matter).

[5] [CTAN: Package mhchem](https://ctan.org/pkg/mhchem?lang=en). 

