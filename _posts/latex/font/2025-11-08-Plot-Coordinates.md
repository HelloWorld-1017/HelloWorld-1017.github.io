---
title: Plot Coordinates Using LaTeX TikZ
toc: false
categories:
 - LaTeX
tags:
 - LaTeX TikZ
 - LaTeX TikZ arrows
location: Buffalo, United States
date: 2025-11-08 11:33:14 -0500
last_modified_at: 2025-11-10 13:30:02 -0500
---

Sometimes, I want to plot coordinates using LaTeX TikZ, but before I didn't find a fixed method that I can reuse it in the future. I ever recorded a way in blog[^1], but it's sort of complicated and seems not suitable for figures to be inserted in papers. Today, I saw an Overleaf blog[^2] that introduces a method. Actually, it is very easy, just using two `\draw` commands (and `\foreach` if numerical x-label needed), and I'm very sure I ever used this way, but every time I need to plot coordinates, I always think if there is a more professional command to realize. But in fact, it's unnecessary. So, I'd like to record it in this blog to remind me in the future. Here is the whole script, nothing big:

```latex
\documentclass[tikz]{standalone}
\usetikzlibrary{arrows.meta}

\begin{document}
\begin{tikzpicture}[>=Stealth]
	\draw[step=1cm,gray,very thin] (-1.9,-1.9) grid (5.9,5.9); % Background grid if needed
	
	\draw[thick,->] (0,0) -- (4.5,0) node[anchor=north west] {x axis};
	\draw[thick,->] (0,0) -- (0,4.5) node[anchor=south east] {y axis};
	\foreach \x in {0,1,2,3,4}
	\draw (\x cm,1pt) -- (\x cm,-1pt) node[anchor=north] {$\x$};
	\foreach \y in {0,1,2,3,4}
	\draw (1pt,\y cm) -- (-1pt,\y cm) node[anchor=east] {$\y$};
\end{tikzpicture}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251108115026031.png" alt="png-1" style="width:50%;" />

<br>

**References**

[^1]: [Display the Background Grid while Drawing Graphics in LaTeX TikZ](/2023-09-23/16-09-23.html).
[^2]: [LaTeX Graphics using TikZ: A Tutorial for Beginners (Part 1)—Basic Drawing](https://www.overleaf.com/learn/latex/LaTeX_Graphics_using_TikZ%3A_A_Tutorial_for_Beginners_(Part_1)—Basic_Drawing).