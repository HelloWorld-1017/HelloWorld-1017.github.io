---
title: LaTeX Font Size Commands
toc: false
categories:
 - Design
 - LaTeX
tags:
 - LaTeX beamer
 - LaTeX Font
date: 2024-05-31 12:32:43 +0800
last_modified_at: 2024-11-09 16:03:40 +0800
---

LaTeX provides several commands to specify font size, such as `\normalsize` (default), `\tiny`, `\scriptsize`, `\large`, and `\huge` etc. One point should be noted is that, the specific font size specified by one command is determined by <i class="emphasize">document class</i> and <i class="emphasize">font size option</i>[^1][^2]. Like for commonly used document class `article` (and also `report`, `book`, and `letter`)[^1], font sizes corresponding to different commands are shown in the following table:

| command                                           | 10pt                            | 11pt                            | 12pt                            |
| ------------------------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- |
| `\tiny`                                           | 5 pt                            | 6 pt                            | 6 pt                            |
| `\scriptsize`                                     | 7 pt                            | 8 pt                            | 8 pt                            |
| `\footnotesize`                                   | 8 pt                            | 9 pt                            | 10 pt                           |
| `\small`                                          | 9 pt                            | 10 pt                           | 11 pt                           |
| `\normalsize` <font color="blue">(default)</font> | <font color="blue">10 pt</font> | <font color="blue">11 pt</font> | <font color="blue">12 pt</font> |
| `\large`                                          | 12 pt                           | 12 pt                           | 14 pt                           |
| `\Large`                                          | 14 pt                           | 14 pt                           | 17 pt                           |
| `\LARGE`                                          | 17 pt                           | 17 pt                           | 20 pt                           |
| `\huge`                                           | 20 pt                           | 20 pt                           | 25 pt                           |
| `\Huge`                                           | 25 pt                           | 25 pt                           | 25 pt                           |

<div class="notice--primary" markdown="1">

For Chinese font, there is also[^2]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411091524400.png" alt="image-20241109152407316" style="width:50%;" />

</div>

and for `beamer` class:

| command                                           | 8pt                            | 9pt                            | 10pt                            | 11pt                            | 12pt                            | 14pt                            | 17pt                            | 20pt                            |
| ------------------------------------------------- | ------------------------------ | ------------------------------ | ------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- |
| `\tiny`                                           | 5 pt                           | 5 pt                           | 5 pt                            | 6 pt                            | 6 pt                            | 6 pt                            | 8 pt                            | 10 pt                           |
| `\scriptsize`                                     | 5 pt                           | 6 pt                           | 7 pt                            | 8 pt                            | 8 pt                            | 8 pt                            | 10 pt                           | 12 pt                           |
| `\footnotesize`                                   | 6 pt                           | 7 pt                           | 8 pt                            | 9 pt                            | 10 pt                           | 10 pt                           | 12 pt                           | 14 pt                           |
| `\small`                                          | 7 pt                           | 8 pt                           | 9 pt                            | 10 pt                           | 11 pt                           | 12 pt                           | 14 pt                           | 17 pt                           |
| `\normalsize` <font color="blue">(default)</font> | <font color="blue">8 pt</font> | <font color="blue">9 pt</font> | <font color="blue">10 pt</font> | <font color="blue">11 pt</font> | <font color="blue">12 pt</font> | <font color="blue">14 pt</font> | <font color="blue">17 pt</font> | <font color="blue">20 pt</font> |
| `\large`                                          | 10 pt                          | 10 pt                          | 12 pt                           | 12 pt                           | 14 pt                           | 17 pt                           | 20 pt                           | 25 pt                           |
| `\Large`                                          | 11 pt                          | 11 pt                          | 14 pt                           | 14 pt                           | 17 pt                           | 20 pt                           | 25 pt                           | 29.86 pt                        |
| `\LARGE`                                          | 12 pt                          | 12 pt                          | 17 pt                           | 17 pt                           | 20 pt                           | 25 pt                           | 29.86 pt                        | 35.83 pt                        |
| `\huge`                                           | 14 pt                          | 14 pt                          | 20 pt                           | 20 pt                           | 25 pt                           | 29.86 pt                        | 35.83 pt                        | 42.99 pt                        |
| `\Huge`                                           | 17 pt                          | 17 pt                          | 25 pt                           | 25 pt                           | 25 pt                           | 35.83 pt                        | 42.99 pt                        | 51.59 pt                        |

<br>

Here are examples for `article` class:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}

\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\begin{document}
	\thispagestyle{empty}
	
	\lipsum[1][1-3]
	
	{\tiny \verb|\tiny|: \lipsum[1][1-3]}
	
	{\scriptsize \verb|\scriptsize|: \lipsum[1][1-3]}
	
	{\small \verb|\small|: \lipsum[1][1-3]}
	
	{\normalsize \verb|\normalsize|: \lipsum[1][1-3]}
	
	{\large \verb|\large|: \lipsum[1][1-3]}
	
	{\Large \verb|\Large|: \lipsum[1][1-3]}
	
	{\LARGE \verb|\LARGE|: \lipsum[1][1-3]}
	
	{\huge \verb|\huge|: \lipsum[1][1-3]}
	
	{\Huge \verb|\Huge|: \lipsum[1][1-3]}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411091550109.png" alt="png-1" style="width:100%;" />

```latex
\documentclass[a4paper,11pt]{article}
% ......
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411091549547.png" alt="png-1" style="width:100%;" />

```latex
\documentclass[a4paper,12pt]{article}
% ......
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411091548299.png" alt="png-1" style="width:100%;" />

<br>

**References**

[^1]: [LaTeX font size](https://www.sascha-frank.com/latex-font-size.html).
[^2]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 82-85.
