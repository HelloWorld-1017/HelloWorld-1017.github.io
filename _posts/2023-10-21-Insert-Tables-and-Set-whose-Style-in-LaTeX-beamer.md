---
layout: single
title: Insert Tables and Set whose Style in LaTeX beamer
date: 2023-10-21 22:53:28 +0800
categories:
 - LaTeX
tag: 
 - LaTeX beamer
 - LaTeX Table
toc: false
---

Inserting tables in LaTeX `beamer` class is similar to that in LaTeX `article` class:

```latex
\documentclass{beamer}
\usepackage{xcolor}
\newcommand\myfcolorbox[1]{\fcolorbox{black}{#1}{\phantom{\tiny{color}}} \textbf{#1}\quad}

\begin{document}
\begin{frame}
	\begin{columns}
		\begin{column}{0.25\textwidth}
			This is an introduction to xcolor package basic color names.
		\end{column}
		
		\begin{column}{0.75\textwidth}
			\begin{table}
				\caption{xcolor package basic color names.}
				\begin{tabular}{|l|l|l|}
					\hline
					\myfcolorbox{black} & \myfcolorbox{darkgray} & \myfcolorbox{lime} \\
					\hline
					\myfcolorbox{pink} & \myfcolorbox{violet} & \myfcolorbox{blue} \\
					\hline
					\myfcolorbox{gray} & \myfcolorbox{magenta} & \myfcolorbox{purple} \\
					\hline
					\myfcolorbox{white} & \myfcolorbox{brown} & \myfcolorbox{green} \\
					\hline
					\myfcolorbox{olive} & \myfcolorbox{red} & \myfcolorbox{yellow} \\ 
					\hline
					\myfcolorbox{cyan} & \myfcolorbox{lightgray} & \myfcolorbox{orange} \\
					\hline
					\myfcolorbox{teal}& & \\
					\hline 
				\end{tabular}
			\end{table}
		\end{column}
	\end{columns}
\end{frame}

\end{document}
```

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310212244385.png)

And like inserting figures in LaTeX beamer [[1]](#ref), we could add:

```latex
\setbeamertemplate{caption}[numbered]
```

in the preamble area to specify to show table number:

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310212243902.png)

<br>

<div id="ref"></div>

**References**

[1] [Insert Figures and Set whose Style in LaTeX beamer - What a starry night~](https://helloworld-1017.github.io/2023-10-20/23-34-45.html).

[2] [Beamer Table - Full guide with examples](https://latex-beamer.com/tutorials/beamer-table/).
