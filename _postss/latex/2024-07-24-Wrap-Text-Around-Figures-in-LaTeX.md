---
title: Wrap Text Around Figures in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Figure
date: 2024-07-24 00:16:56 +0800
last_modified_at: 2024-07-24 00:16:56 +0800
---

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}

\usepackage{lipsum}
\usepackage{graphicx,wrapfig}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\begin{document}

    \lipsum[1-2]

    \begin{wrapfigure}{l}{0.5\textwidth}
      \begin{flushleft}
        \includegraphics[width=0.4\textwidth]{Camus.jpg}
      \end{flushleft}
      \caption{Camus}
    \end{wrapfigure}

    \lipsum[3-4]

    \begin{wrapfigure}{r}{0.5\textwidth}
      \begin{flushright}
        \includegraphics[width=0.4\textwidth]{Camus.jpg}
      \end{flushright}
      \caption{Camus}
    \end{wrapfigure}

    \lipsum[5-6]
    
    \thispagestyle{empty}
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407240018783.png)

<br>

**References**

[1] [LaTeX教学篇#2  图文混排 - 技术开发局局长的文章 - 知乎](https://zhuanlan.zhihu.com/p/455318449).

[2] [Wrapping text around figures - Overleaf, Online LaTeX Editor](https://www.overleaf.com/learn/latex/Wrapping_text_around_figures).
