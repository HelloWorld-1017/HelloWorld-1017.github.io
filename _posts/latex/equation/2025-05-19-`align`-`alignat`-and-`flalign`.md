---
title: LaTeX `align`, `alignat`, and `flalign` Environments
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
date: 2025-05-19 11:01:52 +0800
last_modified_at: 2025-05-23 16:25:15 +0800
---

In LaTeX, we can use the `align` environment to align multiple equations at a certain position. However, if we want to align equations at two or more positions by parts, the resulting effects are not as we expected:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{align}
&1+2+3=6\\
&2+5=7\\
&2\times5=10
\end{align}

\begin{align}
&1+2+3    &=6\\
&2+5      &=7\\
&2\times5 &=10
\end{align}

\begin{align}
&1+ &2+3     &=6\\
&2+ &5       &=7\\
&2  &\times5 &=10
\end{align}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191131336.png" alt="image-20250519113111248" style="width:67%;" />

One reason is that we should use a pair of `&`, i.e., a left `&` and a right `&`, to create a column (except for the last column), and the aligned position is the beginning of each column. For example:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{align}
&1+2+3    & &=6\\
&2+5      & &=7\\
&2\times5 & &=10
\end{align}

\begin{align}
&1+ & &2+3     & &=6\\
&2+ & &5       & &=7\\
&2  & &\times5 & &=10
\end{align}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191131320.png" alt="image-20250519113158249" style="width:67%;" />

For example, in the second case, the first column is `&1+ &`, the second is `&2+3     &`, and the third is `&=6`. Anyway, the use of symbol `&` is kind of different from that in the `matrix` environment or the `array` environment etc.

As can be seen, things become better but there are also some blank space whose width seems not controllable. To solve this problem, we can use the `alignat` environment instead of `align` environment:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{alignat}{2}
&1+2+3    & &=6\\
&2+5      & &=7\\
&2\times5 & &=10
\end{alignat}

\begin{alignat}{3}
&1+ & &2+3     & &=6\\
&2+ & &5       & &=7\\
&2  & &\times5 & &=10
\end{alignat}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191133920.png" alt="image-20250519113357853" style="width:67%;" />

Note that, an argument of the `alignat` environment specifies the number of columns, like `{2}` and `{3}` in above examples.

Besides, at this time we can use some commands like `\quad`, `\quad`, or `\hspace` to add some blank space manually[^1]:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{alignat}{2}
&1+2+3    \quad & &=6\\
&2+5      \quad & &=7\\
&2\times5 \quad & &=10
\end{alignat}

\begin{alignat}{3}
&1+ \hspace{2em} & &2+3     \hspace{1em} & &=6\\
&2+ \hspace{2em} & &5       \hspace{1em} & &=7\\
&2  \hspace{2em} & &\times5 \hspace{1em} & &=10
\end{alignat}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191310064.png" alt="image-20250519131003983" style="width:67%;" />

In addition, the `flalign` environment is useful from time to time. It can add a flexible space between adjacent two columns to fill the whole `\textwidth`:

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage{showframe}

\begin{document}

\begin{flalign}
&1+2+3    & &=6\\
&2+5      & &=7\\
&2\times5 & &=10
\end{flalign}

\begin{flalign}
&1+ & &2+3     & &=6\\
&2+ & &5       & &=7\\
&2  & &\times5 & &=10
\end{flalign}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191152091.png" alt="image-20250519115241013" style="width:67%;" />

And it is certainly available when there are more columns:

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage{showframe}

\begin{document}

\begin{flalign}
x &= t  & & xxx & & xxx & & xxx & & x = 2 \\
y &= 2t & & xxx & & xxx & & xxx & & y = 4
\end{flalign}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191154315.png" alt="image-20250519115414254" style="width:67%;" />

<br>

**References**

- [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 265-266.

[^1]: [amsmath - Aligning equations with text with `alignat`](https://tex.stackexchange.com/questions/49014/aligning-equations-with-text-with-alignat).
