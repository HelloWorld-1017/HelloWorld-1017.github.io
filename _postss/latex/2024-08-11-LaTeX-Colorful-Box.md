---
title: "LaTeX Colorful Box: `\\colorbox`, `\\fcolorbox`, and `tcolorbox` environment"
toc: false
categories:
 - LaTeX
tags:
 - LaTeX beamer
date: 2024-08-11 14:26:46 +0800
last_modified_at: 2024-08-11 14:26:46 +0800
---

```latex
\documentclass[varwidth]{standalone}
\standaloneconfig{border=2em}

\usepackage{xcolor}
\usepackage[most]{tcolorbox}

\begin{document}

\colorbox{yellow}{yellow box}

\fcolorbox{black}{green}{green box with black border}

\begin{tcolorbox}[colback=red!20,
                  colframe=black,
                  width=7cm,
                  arc=1mm, auto outer arc]
red box with black round border
\end{tcolorbox}

\begin{tcolorbox}[enhanced jigsaw,
                  colback=blue!50,% background
                  colframe=black,% border color
                  drop shadow={black!50!gray!80},
                  boxrule=1pt, % border width
                  width=10cm,
                  arc=1mm, auto outer arc]
blue box with black-shadow round border
\end{tcolorbox}

\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111433151.png)

<br>

**References**

[1] [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 365.

[2] [boxes - How to change options in the fcolorbox environment - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/327323/how-to-change-options-in-the-fcolorbox-environment).

[3] [CTAN: Package `tcolorbox`](https://ctan.org/pkg/tcolorbox?lang=en), package documentation: [Manual for the tcolorbox package](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/tcolorbox/tcolorbox.pdf). This package is useful when making posters: [A Tutorial for Poster Creation with Tcolorbox](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/tcolorbox/tcolorbox-tutorial-poster.pdf).

