---
title: Examples from LaTeX `tcolorbox` Package
categories:
 - LaTeX
tags:
 - LaTeX empheq
 - LaTeX Box
 - LaTeX tcolorbox
 - LaTeX xcolor
date: 2025-05-12 22:05:57 +0800
last_modified_at: 2025-05-13 11:03:27 +0800
---

Here are some examples from the manual of LaTeX `tcolorbox` package[^1].

## Example 1

p. 377

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\usepackage[svgnames]{xcolor}
\usepackage[most]{tcolorbox}
\usepackage{amsmath}

\begin{document}

\begin{equation}
\tcbset{fonttitle=\scriptsize}
\tcboxmath[colback=LightBlue!25!white,colframe=blue]{ a^2 = 16 }
\quad\Rightarrow\quad
\tcboxmath[colback=Salmon!25!white,colframe=red,title=Implication]
{a = 4 ~\vee~ a=-4.}
\end{equation}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505131044192.png" alt="image-20250513104431131" style="width:100%;" />

<br>

## Example 2

p. 377

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\usepackage[svgnames]{xcolor}
\usepackage[most]{tcolorbox}
\usepackage{amsmath}

\begin{document}

\tcbset{myformula/.style={colback=yellow!10!white,
		colframe=red!50!black,
		every box/.style={highlight math style={colback=LightBlue!50!white,colframe=Navy}}
		}}
\begin{align}
	\tcbhighmath{\sum\limits_{n=1}^{\infty} \frac{1}{n}} &= \infty.\\
	\int x^2 ~\text{d}x &= \frac13 x^3 + c.
\end{align}
\begin{tcolorbox}[ams align,myformula]
	\tcbhighmath{\sum\limits_{n=1}^{\infty} \frac{1}{n}} &= \infty.\\
	\int x^2 ~\text{d}x &= \frac13 x^3 + c.
\end{tcolorbox}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505131045799.png" alt="image-20250513104537657" style="width:100%;" />

<br>

## Example 3

p. 378

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\usepackage[svgnames]{xcolor}
\usepackage[most]{tcolorbox}
\usepackage{amsmath}
\usepackage{empheq}

\begin{document}

\begin{empheq}[box=\tcbhighmath]{align}
	a &= \sin(z)\\
	E &= mc^2 + \int_a^b x\, dx
\end{empheq}
\tcbset{highlight math style={enhanced,
	colframe=red!60!black,
	colback=yellow!50!white,
	arc=4pt,
	boxrule=1pt,
	drop fuzzy shadow}}
\begin{empheq}[box=\tcbhighmath]{align}
	a &= \sin(z)\\
	E &= mc^2 + \int_a^b x\, dx
\end{empheq}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505131047992.png" alt="image-20250513104756935" style="width:100%;" />

<br>

## Example 4

pp. 106-107.

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\usepackage[svgnames]{xcolor}
\usepackage[most]{tcolorbox}
\usepackage{amsmath}
\usepackage{lipsum}
\tcbuselibrary{skins,breakable}

\begin{document}

\tcbset{colframe=red!75!black,
	fonttitle=\bfseries,
	colback=red!5!white,
	every box/.style={enhanced,
		watermark text=\thetcblayer,
		before=\par\smallskip,
		after=\par\smallskip},
		every box on layer 2/.append style={colback=yellow!10!white,
			drop fuzzy shadow}}

\begin{tcolorbox}[enhanced jigsaw,breakable,title=Layer 1 Box]
Here comes a footnote\footnote{Footnote from layer 1 box}.
\lipsum[2][1-4]
	\begin{tcolorbox}[title=Layer 2 Box]
		abc\footnote{The footnote of abc}
	\end{tcolorbox}
	\begin{tcolorbox}[title=Another Box,ams equation]
		\tcbhighmath{\sum\limits_{n=1}^{\infty} \frac{1}{n}} = \infty.
	\end{tcolorbox}
	Some text\footnote{Footnote from some text}.
	\begin{tcolorbox}[title=Yet Another Box]
		\tcboxfit[height=2cm]{\lipsum[1]}
		My text.
	\begin{tcolorbox}
	Another lipsum text\footnote{A lipsum text}. \lipsum[3]
	\begin{tcolorbox}[title=Layer 4,colframe=blue,colback=white]
		Layer 4\footnote{Layer 4 footnote}
	\end{tcolorbox}
	The End\footnote{Last footnote}.
	\end{tcolorbox}
	\end{tcolorbox}
\end{tcolorbox}

\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505131057580.png)

<br>

**References**

[^1]: [Manual for the `tcolorbox` package](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/tcolorbox/tcolorbox.pdf).

