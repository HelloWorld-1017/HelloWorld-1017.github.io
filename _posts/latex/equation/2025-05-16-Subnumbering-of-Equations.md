---
title: Subnumbering of Equations in LaTeX --- `align` environment and `subequations` environment 
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
date: 2025-05-16 13:19:35 +0800
last_modified_at: 2025-05-16 14:02:48 +0800
---

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage[colorlinks, linkcolor=blue]{hyperref}

\begin{document}

\begin{align}
x &= t+\cos t +1 \label{eq1-1}\\
y &= 2\sin t \label{eq1-2}
\end{align}
Sub-equations $\eqref{eq1-1}$ and $\eqref{eq1-2}$.

\begin{subequations}\label{eq2}
\begin{align}
x &= t+\cos t +1 \label{eq2-1}\\
y &= 2\sin t \label{eq2-2}
\end{align}
\end{subequations}
Equation $\eqref{eq2}$ includes sub-equations $\eqref{eq2-1}$ and $\eqref{eq2-2}$.

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505161324916.png" alt="image-20250516132448783" style="width:67%;" />

Besides, if we want to change the subnumbering format, for the convenience of use we can define a new environment `mysubeq`, because the subnumbering format should be set internally in the `subequations` environment. For example:

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage[colorlinks, linkcolor=blue]{hyperref}

\newenvironment{mysubeqn}%
	{\begin{subequations}
	\renewcommand\theequation{\theparentequation-\roman{equation}}}%
	{\end{subequations}}

\begin{document}

\begin{align}
x &= t+\cos t +1 \label{eq1-1}\\
y &= 2\sin t \label{eq1-2}
\end{align}
Sub-equations $\eqref{eq1-1}$ and $\eqref{eq1-2}$.

\begin{subequations}\label{eq2}
\begin{align}
x &= t+\cos t +1 \label{eq2-1}\\
y &= 2\sin t \label{eq2-2}
\end{align}
\end{subequations}
Equation $\eqref{eq2}$ includes sub-equations $\eqref{eq2-1}$ and $\eqref{eq2-2}$.

\begin{mysubeqn}\label{eq3}
\begin{align}
x &= t+\cos t +1 \label{eq3-1}\\
y &= 2\sin t \label{eq3-2}
\end{align}
\end{mysubeqn}
Equation $\eqref{eq3}$ includes sub-equations $\eqref{eq3-1}$ and $\eqref{eq3-2}$.

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505161402553.png" alt="image-20250516140227484" style="width:67%;" />

<br>

**References**

- [LaTeX入门](https://yun.weicheng.men/Book/LaTeX%E5%85%A5%E9%97%A8.pdf), 刘海洋编著, pp. 265-267, p. 275.
- [Subnumbering of equations](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/subeqn/subeqn.pdf).
- [Subequations (LaTeX environment)](https://latex-programming.fandom.com/wiki/Subequations_\(LaTeX_environment\)).