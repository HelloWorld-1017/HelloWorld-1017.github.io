---
title: Color the Table in LaTeX Using `xcolor` Package, `tabularray` Package, and TikZ
categories:
 - LaTeX
tags:
 - LaTeX hf-tikz
 - LaTeX Table
 - LaTeX tabularray
 - LaTeX TikZ
 - LaTeX TikZ backgrounds
 - LaTeX TikZ fit
 - LaTeX TikZ matrix
 - LaTeX xcolor
date: 2025-01-16 21:00:42 +0800
last_modified_at: 2025-01-17 21:09:39 +0800
---

# Color the table using `xcolor` package

Example 1[^1]:

```latex
\documentclass[a4paper]{article}
\usepackage[table]{xcolor}
\pagestyle{empty}

\setlength{\arrayrulewidth}{0.5mm}
\setlength{\tabcolsep}{18pt}
\renewcommand{\arraystretch}{2.5}

\begin{document}
{\rowcolors{3}{green!80!yellow!50}{green!70!yellow!40}
\begin{tabular}{|p{3cm}|p{3cm}|p{3cm}|}
	\hline
	\multicolumn{3}{|c|}{Country List} \\
	\hline
	Country Name or Area Name & ISO ALPHA 2 Code & ISO ALPHA 3 \\
	\hline
	Afghanistan & AF & AFG \\
	Aland Islands & AX & ALA \\
	Albania & AL & ALB \\
	Algeria & DZ & DZA \\
	American Samoa & AS & ASM \\
	Andorra & AD & AND   \\
	Angola & AO & AGO \\ \hline
\end{tabular}}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501171009469.png" alt="image-20250117100914383" style="width:50%;" />

where[^1]:

<div class="quote--left" markdown="1">

Notice the braces right before the command `\rowcolors{3}{green!80!yellow!50}{green!70!yellow!40}` and after the `tabular` environment. The command `\rowcolors` takes three parameters each passed inside braces:

- the row to start,
- the colour for odd rows and
- the colour for even rows.

</div>

Example 2[^1]:

```latex
\documentclass[a4paper]{article}
\usepackage[table]{xcolor}
\pagestyle{empty}

\setlength{\arrayrulewidth}{1mm}
\setlength{\tabcolsep}{18pt}
\renewcommand{\arraystretch}{2.5}
\newcolumntype{s}{>{\columncolor[HTML]{AAACED}} p{3cm}}
\arrayrulecolor[HTML]{DB5800}

\begin{document}
\begin{tabular}{|s|p{3cm}|p{3cm}|}
	\hline
	\rowcolor{lightgray} \multicolumn{3}{|c|}{Country List} \\
	\hline
	Country Name or Area Name & ISO ALPHA 2 Code & ISO ALPHA 3 \\
	\hline
	Afghanistan & AF & AFG \\
	\rowcolor{gray}
	Aland Islands & AX & ALA \\
	Albania   & AL & ALB \\
	Algeria  & DZ & DZA \\
	American Samoa & AS & ASM \\
	Andorra & AD & \cellcolor[HTML]{AA0044} AND \\
	Angola & AO & AGO \\ \hline
\end{tabular}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501171009769.png" alt="image-20250117100945712" style="width:50%;" />

where[^1]:

<div class="quote--left" markdown="1">

Below is a description about how to change the colour of each element in the table:

- **Colour of the lines**. The command `\arrayrulecolor` is used for this. In the example an HTML format is used, but other formats are available too.

- **Background colour of a cell**. Use the command `\cellcolor`. You can either enter the name directly inside the braces (red, gray, green and so on) or pass a format parameter inside brackets (HTML in the example) and then set the desired colour inside the braces using the established format.

- **Background colour of a row**. In this case `\rowcolor` will accomplish that. The same observations about colour selection mentioned in the two previous commands are valid for this one.

- **Background colour of a column**. This one is a bit tricky, but the easiest way is to define a new column type. The command `\newcolumntype{s}{>{\columncolor[HTML]{AAACED}} p{3cm}}` define a column type called `s` whose alignment is `p`, the column width is `3cm` and the colour is set with HTML format to `AAACED`. This new column type is used in the  `tabular` environment.

 </div>

Example 3[^2]:

```latex
\documentclass[a4paper]{article}
\usepackage{amsmath}
\usepackage[table]{xcolor}
\pagestyle{empty}

\newcommand\x{\times}
\newcommand\y{\cellcolor{green!10}}

\begin{document}
\begin{equation*}\label{eq:appendrow}
\left(\begin{array}{cccc}
	\rowcolor{red!20}
	\x & \x & \x & \x \\
	0 & \x & \x & \x \\
	\rowcolor{blue!20}
	0 & 0 & \x & \x \\
	0 & 0 & 0 & \x \\
	\y a & b & \y c & d\\
	\end{array}\right)
\end{equation*}

\begin{equation*}
\left(\begin{array}{>{\columncolor{olive!20}}cc>{\columncolor{yellow!20}}cc}
	\x & \x & \x & \x \\
	0 & \x & \x & \x \\
	0 & 0 & \x & \x \\
	0 & 0 & 0 & \x \\
	a & b & c & d \\
\end{array}\right)
\end{equation*}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501172106692.png" alt="image-20250117210600564" style="width:50%;" />

<br>

# Color the table using `tabularray` package

Example 1[^3]:

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage{xcolor}
\usepackage{tabularray}
\SetTblrInner{colsep=5pt,rowsep=1pt}
\newcommand\x{\times}

\begin{document}

\begin{equation*}\label{eq:appendrow}
\left(\begin{tblr}{
	colspec = {cccc},
	row{1} = {red9},
	row{3} = {blue9},
	cell{5}{1,3} = {green9},
}
	\x & \x & \x & \x \\
	0 & \x & \x & \x \\
	0 &  0 & \x & \x \\
	0 &  0 &  0 & \x \\
	a &  b &  c &  d \\
\end{tblr}\right)
\end{equation*}

\begin{equation*}
\left(\begin{tblr}{Q[c,olive9]cQ[c,yellow9]c}
	\x & \x & \x & \x \\
	0 & \x & \x & \x \\
	0 &  0 & \x & \x \\
	0 &  0 &  0 & \x \\
	a &  b &  c &  d \\
\end{tblr}\right)
\end{equation*}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501172329005.png" alt="image-20250117232915948" style="width:50%;" />

<br>

# Color the table using TikZ

Example[^4]:

```latex
\documentclass{article}
\usepackage{amsmath}

\newcommand\x{\times}

% requires version 0.3 of the package
\usepackage[customcolors]{hf-tikz}

\tikzset{style green/.style={
		set fill color=green!50!lime!60,
		set border color=white,
	},
	style cyan/.style={
		set fill color=cyan!90!blue!60,
		set border color=white,
	},
	style orange/.style={
		set fill color=orange!80!red!60,
		set border color=white,
	},
	hor/.style={
		above left offset={-0.15,0.31},
		below right offset={0.15,-0.125},
		#1
	},
	ver/.style={
		above left offset={-0.1,0.3},
		below right offset={0.15,-0.15},
		#1
	}
}

\begin{document}

\begin{equation*}\label{eq:appendrow}
\left(\begin{array}{cccc}
	\x  & \x  & \x & \x \\
	0   & \tikzmarkin[hor=style orange]{el} \x  & \x\tikzmarkend{el} & \x \\
	0   & 0   & \x & \x \\
	0   & 0   & 0  & \x \\
	\tikzmarkin[hor=style green]{row} a  &  b  &  c &  d \tikzmarkend{row}\\
\end{array}\right)
\end{equation*}

\begin{equation*}\label{eq:appendcol}
\left(\begin{array}{cccc}
	\tikzmarkin[ver=style cyan]{col 1}\x  & \x  & \tikzmarkin[ver=style green]{col 2} \x & \x \\
	0   & \x  & \x & \x \\
	0   & 0   & \x & \x \\
	0   & 0   & 0  & \x \\
	a \tikzmarkend{col 1}  &  b  &  c  \tikzmarkend{col 2} &  d \\
\end{array}\right)
\end{equation*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501172314006.png" alt="image-20250117231403912" style="width:50%;" />

Example 2[^5][^6]:

```latex
\documentclass{article}
\usepackage{tikz}
\usetikzlibrary{matrix,fit}
\usetikzlibrary{backgrounds}
\newcommand\x{\times}

\begin{document}
\hfill
\begin{tikzpicture}
\matrix[matrix of math nodes,
		row sep=.5ex,
		column sep=.5ex,
		left delimiter=(,right delimiter=),
		nodes={text width=.75em, text height=1.75ex, text depth=.5ex, align=center}
		](m) 
	{
		\x & \x & \x & \x \\
		0  & \x & \x & \x \\
		0  & 0  & \x & \x \\
		0  & 0  & 0  & \x \\
		1  & 1  & 1  & 1 \\
	};
\begin{scope}[on background layer]
	\node[fit=(m-2-1)(m-2-4), draw=green!30, fill=green!30, rounded corners] {};
	\node[fit=(m-1-3)(m-5-3), draw=green!30, fill=green!30, rounded corners] {};
	\node[fit=(m-2-3), fill=green] {};
\end{scope} 
\end{tikzpicture}
\hfill
\begin{tikzpicture}
\matrix[matrix of math nodes,
			nodes={rectangle, minimum size=1.2em, text depth=0.25ex,
			inner sep=0pt, outer sep=0pt,
			anchor=center},
		column sep=-0.5\pgflinewidth,
		row sep=-0.5\pgflinewidth,
		inner sep=0pt,
		left delimiter=(, right delimiter=),
		row 2 column 2/.append style={nodes={draw=cyan,fill=cyan}},
		](m)
	{
		a_1 & \x & a_3 \\
		a_4 & \x & a_6 \\
		a_7 & \x & a_9 \\
	};
\begin{scope}[on background layer]
	\filldraw[cyan!50, rounded corners] (m-2-1.north west) -- 
		(m-2-1.south west) -- (m-2-3.south east)-- (m-2-3.north east)-- cycle;
	\filldraw[cyan!50, rounded corners] (m-1-2.north west) -- 
		(m-3-2.south west) -- (m-3-2.south east)-- (m-1-2.north east)-- cycle;
\end{scope} 
\end{tikzpicture}
\vspace{3em}

\hfill
\begin{tikzpicture}
\matrix[matrix of math nodes,
		nodes={rectangle, %draw, very thin,
			minimum size=1.2em, text depth=0.25ex,
			inner sep=0pt, outer sep=0pt,
			fill opacity=0.5, text opacity=1,
			anchor=center},
		column sep=-0.5\pgflinewidth,
		row sep=-0.5\pgflinewidth,
		column 2/.append style = {nodes={fill=cyan!50}},
		row 2/.append style = {nodes={fill=cyan!50}},
		row 2 column 2/.append style={nodes={fill=cyan}},
		inner sep=0pt,
		left delimiter=(, right delimiter=),
		]
	{
		a_1 & \x & a_3 \\
		a_4 & \x & a_6 \\
		a_7 & \x & a_9 \\
	};
\end{tikzpicture}
\hfill
\begin{tikzpicture}
\matrix[matrix of math nodes,
		nodes={rectangle,
			minimum size=1.5em, text depth=0.25ex,
			inner sep=0pt, outer sep=0pt,
			anchor=center},
		row 2/.append style = {nodes={preaction={fill=cyan!30}}},
		column 2/.append style = {nodes={fill=red!60},fill opacity=0.5, text opacity=1},
		inner sep=0pt,
		left delimiter=(, right delimiter=),
		]
	{
		a_1 & \x & a_3 \\
		a_4 & \x & a_6 \\
		a_7 & \x & a_9 \\
	};
\end{tikzpicture}
\hfill
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501172314024.png" alt="image-20250117231453897" style="width:50%;" />

<br>

**References**

[^1]: [Tables: Colour alternating rows](https://www.overleaf.com/learn/latex/Tables#Colour_alternating_rows).
[^2]: [https://tex.stackexchange.com/a/69714/306224](https://tex.stackexchange.com/a/69714/306224).
[^3]: [https://tex.stackexchange.com/a/614559/306224](https://tex.stackexchange.com/a/614559/306224).
[^4]: [https://tex.stackexchange.com/a/69770/306224](https://tex.stackexchange.com/a/69770/306224).
[^5]: [https://tex.stackexchange.com/a/415864/306224](https://tex.stackexchange.com/a/415864/306224).
[^6]: [https://tex.stackexchange.com/a/415891/306224](https://tex.stackexchange.com/a/415891/306224).
