---
title: LaTeX Commands `\definecolor` and `\colorlet` of `xcolor` Package
toc: false
categories:
 - LaTeX
tags:
 - LaTeX xcolor
date: 2025-05-19 17:10:56 +0800
last_modified_at: 2025-05-23 16:05:09 +0800
---

```latex
\documentclass{article}
\renewcommand{\baselinestretch}{2}

\usepackage[svgnames]{xcolor}
\newcommand\myfcolorbox[1]{\fcolorbox{white}{#1}{\phantom{color}} #1\quad}

\definecolor{mycolor1}{rgb}{0.858, 0.188, 0.478}
\definecolor{mycolor2}{RGB}{219, 48, 122}
\definecolor{mycolor3}{cmyk}{0, 0.7808, 0.4429, 0.1412}
\definecolor{mycolor4}{gray}{0.6}

\definecolor{mycolor5}{HTML}{00F9DE}

% Both "ForestGreen" and "NavyBlue" are built-in colors
% from the `xcolor` package with the `svgnames` option
\colorlet{mixedcolor1}{ForestGreen!70} % ForestGreen(70%)
\colorlet{mixedcolor2}{ForestGreen!50!NavyBlue}% ForestGreen(50%) + NavyBlue(50%)

\begin{document}

\noindent
\myfcolorbox{mycolor1}\\
\myfcolorbox{mycolor2}\\
\myfcolorbox{mycolor3}\\
\myfcolorbox{mycolor4}\\
\myfcolorbox{mycolor5}\\
\myfcolorbox{ForestGreen}\\
\myfcolorbox{mixedcolor1}\\
\myfcolorbox{mixedcolor2}\\

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191712871.png" alt="image-20250519171243808" style="width:50%;" />

<br>

**References**

- [Using colors in LaTeX](https://www.overleaf.com/learn/latex/Using_colors_in_LaTeX).
- [xcolor v3.02 (2024/09/29)](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/xcolor/xcolor.pdf).