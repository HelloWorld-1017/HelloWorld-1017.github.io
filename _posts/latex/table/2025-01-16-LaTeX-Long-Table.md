---
title: LaTeX Long Table
toc: false
categories:
 - LaTeX
tags:
 - LaTeX forloop
 - LaTeX longtable
 - LaTeX Table
date: 2025-01-16 20:12:11 +0800
last_modified_at: 2025-01-16 20:12:11 +0800
gallery:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501162015973.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501162015624.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501162016745.png
---

```latex
\documentclass[a4paper]{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\pagestyle{empty}
\usepackage{longtable}
\usepackage{forloop}

\begin{document}
\newcounter{x}
\begin{longtable}[c]{|c|c|c|}
	\caption{Long table caption.\label{long}}\\
	\hline
	\multicolumn{3}{|c|}{Begin of Table}\\
	\hline
	No. & Something & something else\\
	\hline
	\endfirsthead
	
	\hline
	\multicolumn{3}{|c|}{Continuation of Table \ref{long}}\\
	\hline
	No. & Something & something else\\
	\hline
	\endhead
	
	\hline
	\endfoot
	
	\hline
	\multicolumn{3}{|c|}{End of Table}\\
	\hline\hline
	\endlastfoot
	
	\forloop{x}{0}{\value{x} < 117}{
	  \arabic{x} & Lots of lines & like this\\
	}
	\arabic{x} & Lots of lines & like this\\
\end{longtable}

\end{document}
```

{% include gallery id="gallery" layout="third" %}

where[^1]:

<div class="quote--left" markdown="1">

There are four `longtable`-specific elements:

- `\endfirsthead`

  Everything above this command will appear at the beginning of the table, in the first page.

- `\endhead`

  Whatever you put before this command and below `\endfirsthead` will be displayed at the top of the table in every page except the first one.

- `\endfoot`

  Similar to `\endhead`, what you put after `\endhead` and before this command will appear at the bottom of the table in every page except the last one.

- `\endlastfoot`

  Similar to `\endfirsthead`. The elements after `\endfoot` and before this command will be displayed at the bottom of the table but only in the last page where the table appears.

</div>

**References**

[^1]: [Tables: Multi-page tables](https://www.overleaf.com/learn/latex/Tables#Multi-page_tables).
