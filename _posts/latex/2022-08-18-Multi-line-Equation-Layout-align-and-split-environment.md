---
layout: single
title: "Multi-line Equation Layout: `align` and `split` environment"
categories:
 - LaTeX
tags:
 - Markdown
 - LaTeX Equation
date: 2022-08-18 19:01:37 +0800
last_modified_at: 2024-06-20 13:00:34 +0800
modification_history:
 - 2022-08-18 19:01:37 +0800
 - 2023-11-04 14:56:54 +0800
 - 2024-06-20 13:00:34 +0800
---

# `align` environment

```latex
\left\{
\begin{align}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\label{eq1}\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\label{eq2}\\
\end{align}\right.
```

$$
\left\{
\begin{align}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\label{eq1}\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\label{eq2}\\
\end{align}\right.
$$

`align` 环境可以给多行公式添加编号，并且可以分别引用：公式 $\eqref{eq1}$ 和公式 $\eqref{eq2}$。

如果不想添加编号，那么可以使用 `\notag` 命令：

```latex
\left\{
\begin{align}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\notag\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\notag\\
\end{align}\right.
```


$$
\left\{
\begin{align}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\notag\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\notag\\
\end{align}\right.
$$

或者直接使用 `align*` 环境。

```latex
\left\{
\begin{align*}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\\
\end{align*}\right.
```

$$
\left\{
\begin{align*}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\\
\end{align*}\right.
$$

# `split` environment

从上面可以看到，在 Markdown 文件中添加编号的 `align` 环境与左大括号的兼容性不太好。并且不能将整个公式作为一个整体，在多行的居中位置添加编号。而 `split` 环境可以有效解决这两个问题。

```latex
\left\{
\begin{split}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\\
\end{split}\right.
```

$$
\left\{
\begin{split}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\\
\end{split}\right.
$$

如果不想添加编号，则在整个公式后面添加 `\notag`：

```latex
\left\{
\begin{split}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\\
\end{split}\right.\notag
```

$$
\left\{
\begin{split}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}=f_1(x_1,x_2,t)\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}=f_2(x_1,x_2,t)\\
\end{split}\right.\notag
$$

BTW，并不存在 `split*` 环境。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220818190050788.png?raw=true" alt="image-20220818190050788" style="zoom:50%;" />





