---
title: An Option Clash When Using LaTeX Packages `xcolor` and `showframe` Simultaneously
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Package Clash
 - LaTeX showframe
 - LaTeX xcolor
date: 2025-01-05 10:31:45 +0800
last_modified_at: 2025-01-05 10:31:45 +0800
---

If we import  `\usepackage{showframe}` first and then `\usepackage[x11names]{xcolor}`:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{lipsum}

\usepackage{showframe}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\begin{document}
\vspace*{\fill}

\lipsum[1-2]

\vspace*{\fill}
\end{document}
```

an option clash error will occur:

```
line 7: Option clash for package xcolor. \pagecolor
line 7: Package xcolor Error: Undefined color `AntiqueWhite1'. \pagecolor{AntiqueWhite1}
```

This error is caused by the `x11names` option of `xcolor` package.

Conversely, if we change the order of the both:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\usepackage{showframe}
\pagecolor{AntiqueWhite1}

\begin{document}
\vspace*{\fill}

\lipsum[1-2]

\vspace*{\fill}
\end{document}
```

the file will be compiled normally:

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501051036341.png)

