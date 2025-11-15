---
title: Scalable Parentheses and Brackets in LaTeX Equations --- Use `\left` and `\right` before parentheses commands
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
location: Buffalo, United States
date: 2025-11-11 21:14:26 -0500
last_modified_at: 2025-11-15 13:26:53 -0500
---

In LaTeX, by adding `\left` and `\right` before the parentheses (or brackets, curly brackets, angle brackets, pipes, and double pipes etc.), we can make their size dynamically adjusted along with the inner content[^1]. For example: 

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{equation*}
	(
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	),\,
	\big(
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\big),\,
	\left(
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\right)
\end{equation*}

\begin{equation*}
	\{
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\},\,
	\big\{
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\big\},\,
	\left\{
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\right\}
\end{equation*}

\begin{equation*}
	[
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	],\,
	\big[
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\big],\,
	\left[
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\right]
\end{equation*}

\begin{equation*}
	\langle
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\rangle,\,
	\big\langle
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\big\rangle,\,
	\left\langle
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\right\rangle
\end{equation*}

\begin{equation*}
	|
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	|,\,
	\big|
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\big|,\,
	\left|
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\right|
\end{equation*}

\begin{equation*}
	\|
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\|,\,
	\big\|
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\big\|,\,
	\left\|
	\begin{bmatrix}
		1 \\ 1 \\ 1 \\
	\end{bmatrix}
	\right\|
\end{equation*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251112215215772.png" alt="image-20251112215215622" style="width:75%;" />

By the way, note that this method can't automatically adjust the parentheses that after another parentheses bigger. For example,

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}
	
\begin{equation*}
	\left(\left(\left(
	a^2
	\right)+b^2\right)+c^2\right)
\end{equation*}

\begin{equation*}
	\left\{\left\{\left\{
	a^2
	\right\}+b^2\right\}+c^2\right\}
\end{equation*}

\begin{equation*}
	\left[\left[\left[
	a^2
	\right]+b^2\right]+c^2\right]
\end{equation*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251113110750600.png" alt="image-20251113110743430" style="width:75%;" />

This is because the outer parentheses detect the same height (of the content) as the inner one. So, to make the outer one more bigger, we also need to use commands like `\bigl(`, `\Bigl(`, `\biggl(`, `\Biggl(` etc., to adjust it manually. 

<br>

**References**

[^1]: [Brackets and Parentheses](https://www.overleaf.com/learn/latex/Brackets_and_Parentheses).

