---
title: Cross Reference for TikZ Figures in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Cross Reference
 - LaTeX Figure
 - LaTeX TikZ
date: 2025-06-06 15:56:57 +0800
last_modified_at: 2025-06-06 15:56:57 +0800
---

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\usepackage{tikz}
\usepackage{lipsum}
\usepackage[colorlinks=true]{hyperref}

\begin{document}

\lipsum[1-3]

\begin{figure}[h]
\centering
\begin{tikzpicture}
\draw[->] (0,0) -- ++(1,0);
\draw[->] (2,0) -- ++(1,0) -- ++(0,1);
\draw[->] (4,0) -- ++(1,0) -- ++(0,1) -- ++(-1,0);
\draw[->] (6,0) -- ++(1,0) -- ++(0,1) -- ++(-1,0) -- cycle;
\end{tikzpicture}
\caption{Figure 1.}
\label{tikz-1}
\end{figure}

\lipsum[4-6]

\vspace{2em}

Fig. \ref{tikz-1}.

\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506061559393.png)

<br>

**References**

- [https://tex.stackexchange.com/a/28259/306224](https://tex.stackexchange.com/a/28259/306224).