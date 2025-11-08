---
title: Display Each TikZ Figure in One Page in a LaTeX `standalone` Document
toc: false
categories:
 - LaTeX
tags:
 - LaTeX standalone
 - LaTeX TikZ
location: Buffalo, United States
date: 2025-11-06 15:02:05 -0500
last_modified_at: 2025-11-07 21:23:47 -0500
---

In LaTeX, if we draw a TikZ pictures using the `standalone` document class, we can easily get a PDF file only including one figure, which can facilitate organizing contents sometimes[^1]. However, if put multiple `tikzpicture` environments in this `standalone` document, then we can see they are actually put next to each other. For example:

```latex
\documentclass{standalone}
\usepackage{tikz}

\begin{document}
	
\begin{tikzpicture}
	\draw (0,0)node[draw]{A} -- (1,1)node[draw]{B};
\end{tikzpicture}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle,draw]{}
	node at (4,1)[shape=circle,draw]{}
	node at (4,0)[shape=circle,draw]{}
	node at (5,1)[shape=rectangle,draw]{}
	node at (3,1)[shape=rectangle,draw]{};
\end{tikzpicture}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251106151610191.png" alt="image-20251106151603016" style="width:50%;" />

So, to put each TikZ figure in one separate page, we can use the option `tikz` in the `\documentclass` command (and hence no need to use `\usepackage` to import `tikz` package anymore):

```latex
\documentclass[tikz]{standalone}

\begin{document}
	
\begin{tikzpicture}
	\draw (0,0)node[draw]{A} -- (1,1)node[draw]{B};
\end{tikzpicture}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle,draw]{}
	node at (4,1)[shape=circle,draw]{}
	node at (4,0)[shape=circle,draw]{}
	node at (5,1)[shape=rectangle,draw]{}
	node at (3,1)[shape=rectangle,draw]{};
\end{tikzpicture}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251106151924586.png" alt="image-20251106151924507" style="width:50%;" />

What's more, we can further split this single file into three files:

File 1: `doc.tex`

```latex
\documentclass[tikz]{standalone}

\begin{document}

\input{fig1}

\input{fig2}
	
\end{document}
```

File 2: `fig1.tex`

```latex
\begin{tikzpicture}
	\draw (0,0)node[draw]{A} -- (1,1)node[draw]{B};
\end{tikzpicture}
```

File 3: `fig2.tex`

```latex
\begin{tikzpicture}
	\path node at (4,2)[shape=circle,draw]{}
	node at (4,1)[shape=circle,draw]{}
	node at (4,0)[shape=circle,draw]{}
	node at (5,1)[shape=rectangle,draw]{}
	node at (3,1)[shape=rectangle,draw]{};
\end{tikzpicture}
```

At this time, when we compile the `doc.tex`, we'll get the same PDF file. If we need to design plenty of figures, this method provides an easier way, more or less, to organize them.

<br>

Actually, if we just need to insert TikZ figures in LaTeX document, the way in blog[^1] is more elegant: put the code of each TikZ figure in a `standalone` class file, and insert all figures one by one using command `\includestandalone` in the corresponding position. The method introduced in this blog is more suitable for the cases where we want to use TikZ figures in other places, such as MS Word or PowerPoint etc. --- we can compile the file that includes all TikZ figures, and then use `pdftoppm.exe` (which is downloaded along with the TeX Live)[^2] to convert the generated PDF file, page by page, into `.png` files, and finally we'll get each TikZ figure in a single `.png` file!

<br>

**References**

[^1]: [LaTeX `standalone` Class](/2024-08-12/15-54-42.html).
[^2]: [Convert PDF File to PNG Format using `pdftoppm.exe`](/2023-10-18/20-12-31.html).
