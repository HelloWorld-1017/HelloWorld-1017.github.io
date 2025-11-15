---
title: LaTeX Length `\mathsurround` --- Adjust the extra spacing between inline math environment and text
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
location: Buffalo, United States
date: 2025-11-14 20:18:40 -0500
last_modified_at: 2025-11-14 20:18:40 -0500
---

```latex
\documentclass{article}
\usepackage{lipsum}
\usepackage{amsmath}

\begin{document}

\lipsum[1][1-2] $a=b+c$ (default extra spacing, 0pt)

\setlength{\mathsurround}{30pt}
\lipsum[1][1-2] $a=b+c$ (adjusted as 10pt)

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251114203958439.png" alt="image-20251114203958364" style="width:75%;" />

<br>

**References**

- [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, p. 282.
