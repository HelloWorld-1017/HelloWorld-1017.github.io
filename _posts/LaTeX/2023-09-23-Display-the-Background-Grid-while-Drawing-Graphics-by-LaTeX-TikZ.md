---
title: Display the Background Grid while Drawing Graphics by LaTeX TikZ
categories: 
 - LaTeX
tags:
 - LaTeX TikZ
date: 2023-09-23 16:09:23 +0800
last_modified_at: 2024-08-04 23:27:53 +0800
---

While using LaTeX TikZ to draw diagrams, users maybe confused with determining the coordinate of each object. A background grid of drawing area could visually help user draw the figure.

# TikZ `backgrounds ` library

One choice is utilising the TikZ `backgrounds` library:

```latex
\documentclass{article}
\usepackage{geometry} 
\geometry{a2paper}
\usepackage{xcolor}
\usepackage{tikz}
\usetikzlibrary{arrows.meta,bending}
\usetikzlibrary{backgrounds}
% Backgroud grid settings
\tikzset{background top/.style={draw=blue!50,line width=1ex},
         background bottom/.style={draw=blue!50,line width=1ex},
         background left/.style={draw=blue!50,line width=1ex},
         background right/.style={draw=blue!50,line width=1ex}} 

\begin{document}
\begin{center}
	\begin{tikzpicture} % The drawing area is flexible
		[framed,
		show background top,
		show background bottom,
		show background left,
		show background right,background grid/.style={thin,draw=gray,step=0.5cm},
		show background grid] % Set required grid options
		
		\draw[line width=1.5pt] (0,0) ellipse [x radius=2cm, y radius=1.5cm];
		\draw[line width=1.5pt] (20,20) circle [radius=1cm];
		\draw[line width=1.5pt,color=red] (0,0) rectangle (20,20);
		\draw[line width=1.5pt,color=red] (-5,-5) rectangle (0,0);
		\draw[line width=1.5pt] (-5,-5) circle [radius=1cm];
		\draw[tips, -{Latex[open,length=10pt,bend]},line width=2pt,color=blue] (0,0) to [bend left] (-5,20);
		\draw[tips, -{Latex[open,length=10pt,bend]},line width=2pt,color=green] (0,0) to [bend left] (20,-5);
		\draw[tips, -{Latex[open,length=10pt,bend]},line width=2pt,color=blue] (0,0) to [bend left] (-5,20);
		\fill (0,0) circle (3pt); 
		\fill (20,20) circle (3pt); 
		\fill (-5,-5) circle (3pt);
		\fill (-5,20) circle (3pt);
		\fill (20,-5) circle (3pt); 
	\end{tikzpicture}
\end{center}
\end{document}
```

![image-20230923151638213](https://raw.githubusercontent.com/Ma1017/blog-images/main/imgs/image-20230923151638213.png)

It is a great implementation method as this background grid is flexible, that is when a new object is added in the `tikzpicture` environment the grid will adjust automatically, like adding a new circle whose centre of coordinate is `(23,23)` for instance:

```latex
...
\draw[line width=1.5pt] (23,23) circle [radius=1cm];
...
\fill (23,23) circle (3pt);
...
```

The grid area will enlarge adaptively:

![image-20230923161525294](https://raw.githubusercontent.com/Ma1017/blog-images/main/imgs/image-20230923161525294.png)

<br>

# TikZ `help lines` 

Another option is using TikZ `help lines` to draw background grid:

```latex
\documentclass{article}
\usepackage{geometry} 
\geometry{a2paper}
\usepackage{xcolor}
\usepackage{tikz}
\usetikzlibrary{arrows.meta,bending}
\usetikzlibrary{backgrounds}
% Help line setttings
\tikzset{help lines/.style=thin,color=gray}

\begin{document}
\begin{center}
	\begin{tikzpicture}
		\draw [help lines,step=.5cm] (-5,-5) grid (20,20);
		
		\draw[line width=1.5pt] (0,0) ellipse [x radius=2cm, y radius=1.5cm];
		\draw[line width=1.5pt] (20,20) circle [radius=1cm];
		\draw[line width=1.5pt,color=red] (0,0) rectangle (20,20);
		\draw[line width=1.5pt,color=red] (-5,-5) rectangle (0,0);
		\draw[line width=1.5pt] (-5,-5) circle [radius=1cm];
		\draw[tips, -{Latex[open,length=10pt,bend]},line width=2pt,color=blue] (0,0) to [bend left] (-5,20);
		\draw[tips, -{Latex[open,length=10pt,bend]},line width=2pt,color=green] (0,0) to [bend left] (20,-5);
		\draw[tips, -{Latex[open,length=10pt,bend]},line width=2pt,color=blue] (0,0) to [bend left] (-5,20);
		\fill (0,0) circle (3pt); 
		\fill (20,20) circle (3pt); 
		\fill (-5,-5) circle (3pt);
		\fill (-5,20) circle (3pt);
		\fill (20,-5) circle (3pt); 
	\end{tikzpicture}
\end{center}
\end{document}
```

![image-20230923152810904](https://raw.githubusercontent.com/Ma1017/blog-images/main/imgs/image-20230923152810904.png)

This grid area is fixed and completely determined by the diagonal points setting:

```latex
\draw [help lines,step=.5cm] (-5,-5) grid (20,20);
```

where `(-5,-5)` is coordinate of lower left corner point, and `(20,20)` is the coordinate of top right-hand corner point. So, this method has a better application while drawing objects in the local area, but not appropriate to determine the coordinate of the whole area of `tikzpicture` environment. 

<br>

**References**

[1] [Background Library - PGF/TikZ Manual](https://tikz.dev/library-backgrounds).

[2] [Tutorial: A Picture for Karl’s Students - PGF/TikZ Manual](https://tikz.dev/tutorial#autosec-69).