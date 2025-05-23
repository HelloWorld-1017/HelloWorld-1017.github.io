---
title: Option Clash Errors of LaTeX `xcolor` Package Caused by Simultaneously Importing `xcolor` Package and Other Packages
categories:
 - LaTeX
tags:
 - LaTeX Package Clash
 - LaTeX showframe
 - LaTeX TikZ
 - LaTeX xcolor
date: 2025-01-05 10:31:45 +0800
last_modified_at: 2025-05-23 16:02:50 +0800
---

# Import `xcolor` package and `showframe` package

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

<br>

# Import `xcolor` package and `tikz` package

Similarly, in the preamble if we import `tikz` package first and then `xcolor` package with the `svgnames` option, an option clash will occur, for example:

```latex
\documentclass{article}
\usepackage{tikz}
\usepackage[svgnames]{xcolor}

\begin{document}

$\colorbox{DarkOrchid}{text}$

\end{document}
```

```
...

! LaTeX Error: Option clash for package xcolor.

See the LaTeX manual or LaTeX Companion for explanation.
Type  H <return>  for immediate help.
 ...                                              
                                                  
l.4 
    
The package xcolor has already been loaded with options:
  []
There has now been an attempt to load it with options
  [svgnames]
Adding the global options:
  ,svgnames
to your \documentclass declaration may fix this.
Try typing  <return>  to proceed.

...
```

As can be seen from the log, it is because that the `tikz` package has incorporated the `xcolor` package with no option.

So, interchanging the order will solve this problem:

```latex
\documentclass{article}
\usepackage[svgnames]{xcolor}
\usepackage{tikz}

\begin{document}

$\colorbox{DarkOrchid}{text}$

\end{document}
```

and at this time those built-in colors created by the `svgnames` option are available.

<br>
