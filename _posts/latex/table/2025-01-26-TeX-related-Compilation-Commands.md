---
title: TeX-related Compilation Commands for Various TeX Formats and Engines
toc: false
categories:
 - LaTeX
tags:
 - ConTeXt
 - LaTeX Box
 - LaTeX diagbox
 - LaTeX hologo
 - LaTeX multirow
 - LaTeX nicematrix
 - LaTeX Table
 - LaTeX TikZ
 - LaTeX TikZ decorations
 - LaTeX TikZ positioning
 - LaTeX TikZ tikzmark
 - LuaTeX
 - pdfTeX
 - TeX
 - XeTeX
date: 2025-01-26 20:51:36 +0800
last_modified_at: 2025-01-26 21:17:32 +0800
---

On the 31th page of the book, *Introduction to LaTeX*[^3], Haiyang Liu provides a table to conclude TeX-related compilation commands for various TeX formats and engines:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261703625.png" alt="image-20250126170300512" style="width:67%;" />

I ever mentioned this table in my blogs for several times[^1][^2]. So, for the convenience of my future use, I’d like to reproduce it, but in English, in this blog.

<br>

**Method 1: By LaTeX TikZ**

<div id="example-1"></div>

```latex
\documentclass{article}
\usepackage{multirow,diagbox,hologo}
\usepackage{tikz}
\usetikzlibrary{tikzmark,decorations.pathreplacing,positioning}

\newcommand{\mybox}[1]{\makebox[\widthof{(special parameters)}][c]{#1}}

\begin{document}
\begin{table}
	\renewcommand\arraystretch{2}
	\caption{Compilation commands for various \TeX\ formats and engines}
	\vspace{0.5em}
	\begin{tabular}{|c|c|c|c|}
		\hline
		\diagbox{\TeX\ engine}{Command}{\TeX\ format} & Plain \TeX & \LaTeX & \hologo{ConTeXt} \\ \hline
		\TeX/\hologo{eTeX} & \texttt{tex}/\texttt{etex} & & \mybox{}\tikzmarknode{a}{} \\ \hline
		\multirow{2}*{\hologo{pdfTeX}} & \texttt{tex} & \texttt{latex} & \mybox{}\tikzmarknode{b}{} \\ \cline{2-4}
		& \texttt{pdftex} & \texttt{pdflatex} & \mybox{\texttt{texexec}}\tikzmarknode{c}{}\\ \hline 
		\hologo{XeTeX} & \texttt{xetex} & \texttt{xelatex} & \mybox{(special parameters)}\\ \hline 
		\hologo{LuaTeX} & \texttt{luatex} & \texttt{lualatex} & \mybox{\texttt{context}}\tikzmarknode{d}{}\\ \hline
	\end{tabular}
\end{table}
\begin{tikzpicture}[remember picture,overlay]
	\node (aa) [above right=0.5em and 1em of a] {};
	\node (bb) [below right=0.25em and 1em of b] {};
	\node (cc) [above right=0.5em and 1em of c] {};
	\node (dd) [below right=0.25em and 1em of d] {};
	\draw[decorate,decoration={brace},semithick]
		(aa) -- node[right=3pt] {Output DVI file} (bb);
	\draw[decorate,decoration={brace},semithick]
		(cc) -- node[right=3pt] {Output PDF file} (dd);
\end{tikzpicture}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261943710.png" alt="image-20250126194342662" style="width:67%;" />

The difficulty making this table lies in how to annotate curly braces and text--“Output DVI file” and “Output PDF file”--beside the table. My solution refers to the examples[^4] and[^10] : firstly use `\tikzmarknode` to locate a node, and next use `tikzpicture` environment with options `[remember picture,overlay]` (both two options are necessary) to annotate. Among which, the curly braces are drawn using the `\draw` command with options `[decorate,decoration={brace},semithick]`[^5] (TikZ package`decorations.pathreplacing` is needed).

Another point should be noted is that, in example[^4], `++`[^6] is used to position a node having a relative distance from a given node, but seemingly it doesn’t work for the “end node”, for example:

```latex
\documentclass{article}
\usepackage{multirow,diagbox,hologo}
\usepackage{tikz}
\usetikzlibrary{tikzmark,decorations.pathreplacing,positioning}

\newcommand{\mybox}[1]{\makebox[\widthof{(special parameters)}][c]{#1}}

\begin{document}
\begin{table}
	\renewcommand\arraystretch{2}
	\caption{Compilation commands for various \TeX\ formats and engines}
	\vspace{0.5em}
	\begin{tabular}{|c|c|c|c|}
		\hline
		\diagbox{\TeX\ engine}{Command}{\TeX\ format} & Plain \TeX & \LaTeX & \hologo{ConTeXt} \\ \hline
		\TeX/\hologo{eTeX} & \texttt{tex}/\texttt{etex} & & \mybox{}\tikzmarknode{a}{} \\ \hline
		\multirow{2}*{\hologo{pdfTeX}} & \texttt{tex} & \texttt{latex} & \mybox{}\tikzmarknode{b}{} \\ \cline{2-4}
		& \texttt{pdftex} & \texttt{pdflatex} & \mybox{\texttt{texexec}}\tikzmarknode{c}{}\\ \hline 
		\hologo{XeTeX} & \texttt{xetex} & \texttt{xelatex} & \mybox{(special parameters)}\\ \hline 
		\hologo{LuaTeX} & \texttt{luatex} & \texttt{lualatex} & \mybox{\texttt{context}}\tikzmarknode{d}{}\\ \hline
	\end{tabular}
\end{table}
\begin{tikzpicture}[remember picture,overlay]
	\draw[decorate,decoration={brace},semithick]
		(a)++(1em,0.5em) -- node[right=3pt] {Output DVI file} (b)++(1em,0.25em);
	\draw[decorate,decoration={brace},semithick]
		(c)++(1em,0.5em) -- node[right=3pt] {Output PDF file} (d)++(1em,0.25em);
\end{tikzpicture}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501262031696.png" alt="image-20250126203119598" style="width:67%;" />

I don’t know why and don’t find an available solution, so finally I adopt the above used syntax provided by TikZ package `positioning`[^7][^8].

<br>

**Method 2: By `nicematrix` package**

Another reproduction method is by using functions provided by `nicematrix` package[^9].

```latex
\documentclass{article}
\usepackage{nicematrix,hologo}

\begin{document}
\begin{table}
	\renewcommand\arraystretch{2}
	\caption{Compilation commands for various \TeX\ formats and engines}
	\vspace{0.5em}
	\centering
	\begin{NiceTabular}{wc{5cm}ccc}[hvlines,last-col,margin=2pt]
		\diagbox{\TeX\ engine}{Command}{\TeX\ format} & Plain \TeX & \LaTeX & \hologo{ConTeXt} & \\[2em]
		\TeX/\hologo{eTeX} & \texttt{tex}/\texttt{etex} & & & \Block{2-1}{\ Output DVI file}\\ 
		\Block{2-1}{\hologo{pdfTeX}} & \texttt{tex} & \texttt{latex} & & \\
		& \texttt{pdftex} & \texttt{pdflatex} & \texttt{texexec} & \Block{3-1}{\ Output PDF file}\\
		\hologo{XeTeX} & \texttt{xetex} & \texttt{xelatex} & (special parameters) & \\ 
		\hologo{LuaTeX} & \texttt{luatex} & \texttt{lualatex} & \texttt{context} & \\
	\CodeAfter
		\SubMatrix\}{2-5}{3-5}.[xshift=-.3em]
		\SubMatrix\}{4-5}{6-5}.[xshift=-.3em]
	\end{NiceTabular}
\end{table}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261945012.png" alt="image-20250126194545960" style="width:67%;" />

However, it can be seen that, the command `\diagbox` doesn’t work as expected in the `NiceTabular` environment of `nicematrix` package. As the `nicematrix` package documentation said[^11],

<div class="quote--left" markdown="1">

The command `\diagbox` (inspired by the package `diagbox`), allows, when it is used in a cell, to slash that cell diagonally downwards.

</div>

but this `\diagbox` command isn’t as functional as that of `diagbox` package like in the [first reproduction](#example-1).

Besides, in this method, the position of annotation content isn’t easily controlled with precision.

<br>

**References**

[^1]: [An XeLaTeX Compilation Error: `Undefined control sequence. \pdfglyphtounicode`](/2024-07-24/16-47-47.html).
[^2]: [Compile LaTeX File Using Command Line](/2025-01-16/16-40-21.html).
[^3]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, p. 31.
[^4]: [An Example of Annotating Equation in LaTeX Using Colored Box and TikZ Package](/2024-05-04/20-29-57.html).
[^5]: [Making Curly Braces with Tikz](https://tex.stackexchange.com/questions/230566/making-curly-braces-with-tikz).
[^6]: [TiKz dash dash plus plus](https://tex.stackexchange.com/questions/66094/tikz-dash-dash-plus-plus).
[^7]: [How can I achieve relative positioning in tikz](https://tex.stackexchange.com/questions/69439/how-can-i-achieve-relative-positioning-in-tikz).
[^8]: [Positioning groups of tikz nodes relative to their centre](https://tex.stackexchange.com/questions/460905/positioning-groups-of-tikz-nodes-relative-to-their-centre).
[^9]: [brackets - How can I do a table with curly braces on the side?](https://tex.stackexchange.com/questions/687253/how-can-i-do-a-table-with-curly-braces-on-the-side).
[^10]: [The `tikzmark` package](https://texdoc.org/serve/tikzmark/0), p. 10.
[^11]: [The package `nicematrix`](https://ctan.math.washington.edu/tex-archive/macros/latex/contrib/nicematrix/nicematrix.pdf), p. 14.
