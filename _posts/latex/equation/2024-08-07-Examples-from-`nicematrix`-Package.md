---
title: Table and Matrix Examples Using LaTeX `nicematrix` Package
categories:
 - LaTeX
tags:
 - LaTeX Equation
 - LaTeX Table
 - LaTeX TikZ
 - LaTeX TikZ fit
 - LaTeX nicematrix
date: 2024-08-07 12:11:38 +0800
last_modified_at: 2025-05-25 22:50:12 +0800
---

# Examples from the official `nicematrix` documentation

Here are some examples from the official documentation of LaTeX package `nicematrix` [^1].

## pp. 4

```latex
\documentclass{article}
\usepackage{nicematrix}
 
\begin{document}
	\NiceMatrixOptions{cell-space-limits=1pt}
	$A=\begin{pNiceArray}{cc|cc}[baseline=line-3]
	\dfrac{1}{A} & \dfrac{1}{B} & 0 & 0 \\
	\dfrac{1}{C} & \dfrac{1}{D} & 0 & 0 \\
	\hline
	0 & 0 & A & B \\
	0 & 0 & D & D \\
	\end{pNiceArray}$
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071150091.png" alt="image-20240807115003974" style="zoom:67%;" />

```latex
\documentclass{article}
\usepackage{nicematrix}
 
\begin{document}
	$\begin{bNiceArray}{cw{c}{1cm}c|c}[margin]
	\Block{3-3}{A} & & & 0 \\
	& & & \Vdots \\
	& & & 0 \\
	\hline
	0 & \Cdots& 0 & 0
	\end{bNiceArray}$
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071148061.png" alt="image-20240807114829970" style="zoom:67%;" />

## pp. 7-8

```latex
\documentclass{article}
\usepackage{nicematrix}
\usepackage{booktabs}

\begin{document}
	\begin{NiceTabular}{@{}c!{\qquad}ccc!{\qquad}ccc@{}}
	\toprule
	Rank & \Block{1-3}{First group} & & & \Block{1-3}{Second group} \\
	 & 1A & 1B & 1C & 2A & 2B & 2C \\
	\midrule
	 1 & 0.657 & 0.913 & 0.733 & 0.830 & 0.387 & 0.893\\
	 2 & 0.343 & 0.537 & 0.655 & 0.690 & 0.471 & 0.333\\
	 3 & 0.783 & 0.885 & 0.015 & 0.306 & 0.643 & 0.263\\
	 4 & 0.161 & 0.708 & 0.386 & 0.257 & 0.074 & 0.336\\
	\bottomrule
	\end{NiceTabular}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071154324.png" alt="image-20240807115417267" style="zoom:67%;" />

## pp. 13

```latex
\documentclass{article}
\usepackage{nicematrix}

\begin{document}
	$\begin{NiceArray}{c||ccccc}[hlines,vlines]
	 & a & b & c & d & e \\ \Hline\Hline
	x & 0 & 0 & 0 & 0 & 0 \\
	y & 0 & 0 & 0 & 0 & 0 \\
	z & 0 & 0 & 0 & 0 & 0 \\
	\end{NiceArray}$
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071158080.png" alt="image-20240807115811943" style="zoom:67%;" />

```latex
\documentclass{article}
\usepackage{nicematrix}

\begin{document}
	\setlength{\arrayrulewidth}{1pt}
	\begin{NiceTabular}{cccc}[hvlines,rules/color=blue]
	rose & tulipe & marguerite & dahlia \\
	violette & \Block[draw=red]{2-2}{\LARGE fleurs} & & souci \\
	pervenche & & & lys \\
	arum & iris & jacinthe & muguet
	\end{NiceTabular}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071157320.png" alt="image-20240807115706272" style="zoom:67%;" />

## pp. 14

```latex
\documentclass{article}
\usepackage{nicematrix}

\begin{document}
	$\begin{NiceArray}{*{5}{c}}[hvlines]
	\diagbox{x}{y} & e & a & b & c \\
	e & e & a & b & c \\
	a & a & e & c & b \\
	b & b & c & e & a \\
	c & c & b & a & e
	\end{NiceArray}$
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071159415.png" alt="image-20240807115952293" style="zoom: 67%;" />

## pp. 19

```latex
\documentclass{article}
\usepackage{nicematrix,xcolor}

\begin{document}
	\begin{NiceTabular}{ccc}[hvlines]
	\CodeBefore
	 \cellcolor[HTML]{FFFF88}{3-1,2-2,-3}
	\Body
	a & b & c \\
	e & f & g \\
	h & i & j \\
	\end{NiceTabular}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071201457.png" alt="image-20240807120112407" style="zoom:67%;" />

```latex
\documentclass{article}
\usepackage{nicematrix,xcolor}
 
\begin{document}
	\begin{NiceTabular}{ccc}[hvlines]
	\CodeBefore
	 \rectanglecolor{blue!15}{2-2}{3-3}
	\Body
	a & b & c \\
	e & f & g \\
	h & i & j \\
	\end{NiceTabular}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071145996.png" alt="image-20240807114514434" style="zoom:67%;" />

## pp. 20

```latex
\documentclass{article}
\usepackage{nicematrix,xcolor}
 
\begin{document}
	\begin{NiceTabular}{lr}[hvlines]
	\CodeBefore
	 \rowcolors{1}{blue!10}{}[respect-blocks]
	\Body
	\Block{2-1}{John} & 12 \\
	 & 13 \\
	Steph & 8 \\
	\Block{3-1}{Sarah} & 18 \\
	 & 17 \\
	 & 15 \\
	Ashley & 20 \\
	Henry & 14 \\
	\Block{2-1}{Madison} & 15 \\
	 & 19
	\end{NiceTabular}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071203327.png" alt="image-20240807120322268" style="zoom:67%;" />

## pp. 31

```latex
\documentclass{article}
\usepackage{nicematrix,xcolor}
 
\begin{document}
\begin{equation*}
	\begin{bNiceMatrix}
	C[a_1,a_1] & \Cdots & C[a_1,a_n]
	 & \hspace*{20mm} & C[a_1,a_1^{(p)}] & \Cdots & C[a_1,a_n^{(p)}] \\
	\Vdots & \Ddots & \Vdots
	 & \Hdotsfor{1} & \Vdots & \Ddots & \Vdots \\
	C[a_n,a_1] & \Cdots & C[a_n,a_n]
	 & & C[a_n,a_1^{(p)}] & \Cdots & C[a_n,a_n^{(p)}] \\
	\rule{0pt}{15mm}\NotEmpty & \Vdotsfor{1} & & \Ddots & & \Vdotsfor{1} \\
	C[a_1^{(p)},a_1] & \Cdots & C[a_1^{(p)},a_n]
	 & & C[a_1^{(p)},a_1^{(p)}] & \Cdots & C[a_1^{(p)},a_n^{(p)}] \\
	\Vdots & \Ddots & \Vdots
	 & \Hdotsfor{1} & \Vdots & \Ddots & \Vdots \\
	C[a_n^{(p)},a_1] & \Cdots & C[a_n^{(p)},a_n]
	 & & C[a_n^{(p)},a_1^{(p)}] & \Cdots & C[a_n^{(p)},a_n^{(p)}]
	\end{bNiceMatrix}
\end{equation*}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071205250.png" alt="image-20240807120527157" style="zoom:67%;" />

## pp. 39-40

```latex
\documentclass{article}
\usepackage{nicematrix}
 
\begin{document}
	\begin{equation*}
		\begin{pNiceMatrix}
		1 & 2 & 3 & 4 & 5 & 6 \\
		11 & 12 & 13 & 14 & 15 & 16 \\
		\CodeAfter
		 \OverBrace[shorten,yshift=3pt]{1-1}{2-3}{A}
		 \OverBrace[shorten,yshift=3pt]{1-4}{2-6}{B}
		\end{pNiceMatrix}
	\end{equation*}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071208023.png" alt="image-20240807120759958" style="zoom:67%;" />

## pp. 68

```latex
\documentclass{article}
\usepackage{nicematrix}
\usepackage{tikz}
\usetikzlibrary{fit}
 
\begin{document}
	\tikzset{highlight/.style={rectangle,
	 fill=red!15,
	 rounded corners = 0.5 mm,
	 inner sep=1pt,
	 fit=#1}}
	 
	 $\begin{bNiceMatrix}
	 \CodeBefore [create-cell-nodes]
	  \tikz \node [highlight = (2-1) (2-3)] {} ;
	 \Body
	 0 & \Cdots & 0 \\
	 1 & \Cdots & 1 \\
	 0 & \Cdots & 0 \\
	 \end{bNiceMatrix}$
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071208582.png" alt="image-20240807120823772" style="zoom:67%;" />

```latex
\documentclass{article}
\usepackage{nicematrix}
\usepackage{tikz}
\usetikzlibrary{fit}
 
\begin{document}
	\tikzset{highlight/.style={rectangle,
	 fill=red!15,
	 rounded corners = 0.5 mm,
	 inner sep=1pt,
	 fit=#1}}
	$\begin{pNiceArray}{ccc}[last-col, margin = 2pt, create-medium-nodes]
	\CodeBefore [create-cell-nodes]
	 \begin{tikzpicture} [name suffix = -medium]
		 \node [highlight = (1-2) (1-3)] {} ;
		 \node [highlight = (2-1) (2-3)] {} ;
		 \node [highlight = (3-1) (3-3)] {} ;
	 \end{tikzpicture}
	 \Body
	 a & a + b & a + b + c & L_1 \\
	 a & a & a + b & L_2 \\
	 a & a & a & L_3
	 \end{pNiceArray}$
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071209239.png" alt="image-20240807120947169" style="zoom:67%;" />

<div class="notice--primary" markdown="1">


A more complicated case:

```latex
\documentclass{article}
\usepackage{nicematrix}
\usepackage{tikz}
\usetikzlibrary{fit}
 
\begin{document}
	\tikzset{highlight/.style={rectangle,
	 fill=red!15,
	 opacity=0.8,
	 rounded corners = 0.5 mm,
	 inner sep=1pt,
	 fit=#1},
	 highlight2/.style={rectangle,
	 	 fill=blue!15,
	 	 opacity=0.5,
	 	 rounded corners = 0.5 mm,
	 	 inner sep=1pt,
	 	 fit=#1}
	 	 }
	$\begin{pNiceArray}{ccc}[last-col, margin = 2pt, create-medium-nodes]
	\CodeBefore [create-cell-nodes]
	 \begin{tikzpicture} [name suffix = -medium]
		 \node [highlight = (1-2) (2-3)] {} ;
		 \node [highlight = (3-1) (3-2)] {} ;
		 \node [highlight2 = (2-2) (3-3)] {} ;
	 \end{tikzpicture}
	 \Body
	 a & a + b & a + b + c & L_1 \\
	 a & a & a + b & L_2 \\
	 a & a & a & L_3
	 \end{pNiceArray}$
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071226236.png" alt="image-20240807122533648" style="zoom:67%;" />

</div>

## Keys `cell-space-limits`, `cell-space-bottom-limit`, and `cell-space-top-limit`

Based on the above example, we’ll show the function of the keys `cell-space-limits`, `cell-space-bottom-limit`, and `cell-space-top-limit`, respectively (see p. 2 and p. 26):

```latex
\documentclass{article}
\usepackage{nicematrix}
\usepackage{tikz}
\usetikzlibrary{fit}
 
\begin{document}
\tikzset{highlight/.style={rectangle,
	fill=red!15,
	rounded corners = 0.5 mm,
	inner sep=1pt,
	fit=#1}}
\begin{equation*}
\begin{pNiceArray}{ccc}[last-col, margin = 2pt, create-medium-nodes]
	\CodeBefore [create-cell-nodes]
	 \begin{tikzpicture} [name suffix = -medium]
		 \node [highlight = (1-2) (1-3)] {} ;
		 \node [highlight = (2-1) (2-3)] {} ;
		 \node [highlight = (3-1) (3-3)] {} ;
	 \end{tikzpicture}
	 \Body
	 a & a + b & a + b + c & L_1 \\
	 a & a & a + b & L_2 \\
	 a & a & a & L_3
\end{pNiceArray}
\begin{pNiceArray}{ccc}[last-col, margin = 2pt, create-medium-nodes,
	cell-space-limits=20pt]
	\CodeBefore [create-cell-nodes]
	\begin{tikzpicture} [name suffix = -medium]
		\node [highlight = (1-2) (1-3)] {} ;
		\node [highlight = (2-1) (2-3)] {} ;
		\node [highlight = (3-1) (3-3)] {} ;
\end{tikzpicture}
\Body
	a & a + b & a + b + c & L_1 \\
	a & a & a + b & L_2 \\
	a & a & a & L_3
\end{pNiceArray}
\begin{pNiceArray}{ccc}[last-col, margin = 2pt, create-medium-nodes,
	cell-space-bottom-limit=20pt]
	\CodeBefore [create-cell-nodes]
	\begin{tikzpicture} [name suffix = -medium]
		\node [highlight = (1-2) (1-3)] {} ;
		\node [highlight = (2-1) (2-3)] {} ;
		\node [highlight = (3-1) (3-3)] {} ;
\end{tikzpicture}
\Body
	a & a + b & a + b + c & L_1 \\
	a & a & a + b & L_2 \\
	a & a & a & L_3
\end{pNiceArray}
\begin{pNiceArray}{ccc}[last-col, margin = 2pt, create-medium-nodes,
	cell-space-top-limit=20pt]
	\CodeBefore [create-cell-nodes]
	\begin{tikzpicture} [name suffix = -medium]
		\node [highlight = (1-2) (1-3)] {} ;
		\node [highlight = (2-1) (2-3)] {} ;
		\node [highlight = (3-1) (3-3)] {} ;
\end{tikzpicture}
\Body
	a & a + b & a + b + c & L_1 \\
	a & a & a + b & L_2 \\
	a & a & a & L_3
\end{pNiceArray}
\end{equation*}

\end{document}
```

![image-20250525224801677](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505252248930.png)

<br>

# Examples from other references

Example 1[^2]:

```latex
\documentclass{article}
\usepackage{nicematrix}

\begin{document}

$\begin{pNiceMatrix}[margin]
	a & b & c & d \\
	\Block[fill=red!15,rounded-corners]{1-4}{}
	a & b & c & d \\
	a & b & c & d \\
	a & b & \Block[draw,fill=blue!15,rounded-corners]{2-2}{}
	        c & d \\
	a & b & c & d \\
\end{pNiceMatrix}$

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501172116935.png" alt="image-20250117211644838" style="width:50%;" />

<br>

**References**

[^1]: [CTAN: Package `nicematrix`](https://ctan.org/pkg/nicematrix?lang=en).
[^2]: [https://tex.stackexchange.com/a/588227/306224](https://tex.stackexchange.com/a/588227/306224).

