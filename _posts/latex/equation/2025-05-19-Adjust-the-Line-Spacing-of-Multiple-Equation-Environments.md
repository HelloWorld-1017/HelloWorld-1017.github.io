---
title: Adjust the Line Spacing of Multiple-Equation Environments in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
date: 2025-05-19 15:29:06 +0800
last_modified_at: 2025-05-23 16:34:51 +0800
---

In LaTeX, the length `\jot` controls the line spacing between multiple equations in the multiple-equation environments, and its default value is 3.0 pt[^1]:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

The default value of \verb*|\jot| is \the\jot.

\begin{equation}
\begin{split}
a &= \dfrac12\\
b &= \dfrac34
\end{split}
\end{equation}

\begin{align}
a &= \dfrac12\\
b &= \dfrac34
\end{align}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191536120.png" alt="image-20250519153644044" style="width:67%;" />

So, we can set this kind of line spacing globally by setting `\jot` or adding length on it[^2]:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

The default value of \verb*|\jot| is \the\jot.

\setlength\jot{17pt}
%\addtolength{\jot}{17pt}

\begin{equation}
\begin{split}
a &= \dfrac12\\
b &= \dfrac34
\end{split}
\end{equation}

\begin{align}
a &= \dfrac12\\
b &= \dfrac34
\end{align}

Now, the value is \verb*|\jot| is \the\jot.

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191541673.png" alt="image-20250519154107606" style="width:67%;" />

Or, just put the setting inside of the `equation` environment to make the specification effective locally:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

The default value of \verb*|\jot| is \the\jot.

\begin{equation}
\setlength\jot{17pt}
\begin{split}
a &= \dfrac12\\
b &= \dfrac34\\
  & \text{Now, the value is \texttt{\textbackslash jot} is \the\jot.}
\end{split}
\end{equation}

Now, the value is \verb*|\jot| is \the\jot.

\begin{align}
a &= \dfrac12\\
b &= \dfrac34
\end{align}

Now, the value is \verb*|\jot| is \the\jot.

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191547154.png" alt="image-20250519154740085" style="width:67%;" />

Another way to adjust the line spacing is adding `[extra-space]` after the `\\` command, which is used to modify the line spacing for each time[^3]:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{equation}
\begin{split}
a &= \dfrac12\\
b &= \dfrac34\\
\end{split}
\end{equation}

\begin{align}
a &= \dfrac12\\
b &= \dfrac34
\end{align}

\begin{equation}
\begin{split}
a &= \dfrac12\\[1em]
b &= \dfrac34\\
\end{split}
\end{equation}

\begin{align}
a &= \dfrac12\\[3em]
b &= \dfrac34
\end{align}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191603022.png" alt="image-20250519160310942" style="width:67%;" />

<br>

**References**

[^1]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, p. 281.
[^2]: [如何调节align环境中公式的上下间距？](https://ask.latexstudio.net/ask/question/3763.html).
[^3]: [LaTeX help 1.1 - `\\`](https://emerson.emory.edu/services/latex/latex_101.html).