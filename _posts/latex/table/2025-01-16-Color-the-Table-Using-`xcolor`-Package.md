---
title: Color the Table in LaTeX Using `xcolor` Package
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Table
 - LaTeX xcolor
date: 2025-01-16 21:00:42 +0800
last_modified_at: 2025-01-17 10:22:56 +0800
---

The Overleaf blog[^1] provides two examples to show how to use LaTeX `xcolor` package with `table` option to color the components of a table. Here are them.

Example 1:

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

where:

<div class="quote--left" markdown="1">

Notice the braces right before the command `\rowcolors{3}{green!80!yellow!50}{green!70!yellow!40}` and after the `tabular` environment. The command `\rowcolors` takes three parameters each passed inside braces:

- the row to start,
- the colour for odd rows and
- the colour for even rows.

</div>

Example 2:

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

where:

<div class="quote--left" markdown="1">

Below is a description about how to change the colour of each element in the table:

- **Colour of the lines**. The command `\arrayrulecolor` is used for this. In the example an HTML format is used, but other formats are available too.

- **Background colour of a cell**. Use the command `\cellcolor`. You can either enter the name directly inside the braces (red, gray, green and so on) or pass a format parameter inside brackets (HTML in the example) and then set the desired colour inside the braces using the established format.

- **Background colour of a row**. In this case `\rowcolor` will accomplish that. The same observations about colour selection mentioned in the two previous commands are valid for this one.

- **Background colour of a column**. This one is a bit tricky, but the easiest way is to define a new column type. The command `\newcolumntype{s}{>{\columncolor[HTML]{AAACED}} p{3cm}}` define a column type called `s` whose alignment is `p`, the column width is `3cm` and the colour is set with HTML format to `AAACED`. This new column type is used in the  `tabular` environment.

 </div>

<br>

**References**

[^1]: [Tables: Colour alternating rows](https://www.overleaf.com/learn/latex/Tables#Colour_alternating_rows).

