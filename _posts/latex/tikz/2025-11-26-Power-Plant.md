---
title: LaTeX TikZ Power Plant
categories:
 - LaTeX
tags:
 - LaTeX TikZ
location: Buffalo, United States
date: 2025-11-26 22:35:12 -0500
last_modified_at: 2025-11-28 16:58:37 -0500
published: false
---

<br>

These days when I was making slides by LaTeX beamer. I found on StackExchange, a user providing a way to sketch a power plant using LaTeX TikZ:

```latex
\documentclass{standalone}
\usepackage{tikz}
\usetikzlibrary{positioning}
\usetikzlibrary{shapes.geometric}
\usetikzlibrary{backgrounds}
\begin{document}

\definecolor{DBrown}{HTML}{9B8879}
\definecolor{LBrown}{HTML}{C5B99F}
\definecolor{backg}{HTML}{BCC534}
\definecolor{latCol}{HTML}{E8B041}
\definecolor{pot}{HTML}{185BD9}
\begin{tikzpicture}[potSt/.style={ellipse,draw=pot,fill=pot,inner sep=0pt,minimum height=5pt,minimum width=2pt,rotate=-45}]
	%\node{\includegraphics{impEletr}};
	%background
	\fill[backg]  (-7.6,-1.2) rectangle (7.7,-5.4);
	\fill[latCol] (7.7,-1.2) -- (1.9,-5.4) -- (7.7,-5.4) -- cycle;
	
	\node[potSt] at (3.2,-4.8) {};
	\node[potSt]  at (4.7,-3.7) {};
	\node[potSt]  at (5.5,-4.7) {};
	\node[potSt]  at (7,-3.6) {};
	\node[potSt]  at (6.3,-2.6) {};
	
	%plant wires
	\draw[red,line width=6pt] (-5,-3.5) .. controls (-5.8,-3.9) and (-6.3,-4.1) .. (-7.6,-4.2);
	\draw[blue,line width=6pt] (-4.1,-3.7) .. controls (-5.4,-4) and (-6.3,-4.4) .. (-7.4,-5.3);
	
	%power plant
	\draw[very thick,fill=DBrown,miter limit=5] (-3.8,-2.41) -- (-1.1,-1.67) -- (-1.1,-3) -- (-3.77,-4) -- cycle;
	\draw[very thick,fill=LBrown] (-3.8,-2.41) -- (-6.4,-1.9) -- (-6.42,-3.23) -- (-3.77,-4) -- cycle;
	\draw[very thick,fill=LBrown,miter limit=5] (-3.8,-2.41) -- (-1.1,-1.67) -- (-3.6,-1.4) -- (-6.4,-1.9) -- cycle;
	
	\fill[LBrown] (-2.58,-0.69) .. controls (-2.54,-1.22) and (-2.64,-1.52) .. (-2.24,-1.92) -- (-3.84,-1.72) .. controls (-3.54,-1.32) and (-3.44,-1.12) .. (-3.48,-0.7) -- cycle;
	\draw[very thick] (-2.58,-0.69) .. controls (-2.54,-1.22) and (-2.64,-1.52) .. (-2.24,-1.92);
	\draw[very thick] (-3.48,-0.7) .. controls (-3.49,-1.12) and (-3.54,-1.32) .. (-3.84,-1.72);
	\draw[very thick,fill=LBrown]  (-3.03,-0.69) ellipse (0.45 and 0.05);
	
	\fill[LBrown] (-3.94,-0.87) .. controls (-3.9,-1.4) and (-4,-1.7) .. (-3.6,-2.1) -- (-5.2,-1.9) .. controls (-4.9,-1.5) and (-4.8,-1.3) .. (-4.84,-0.88) -- cycle;
	\draw[very thick] (-3.94,-0.87) .. controls (-3.9,-1.4) and (-4,-1.7) .. (-3.6,-2.1);
	\draw[very thick] (-4.84,-0.88) .. controls (-4.85,-1.3) and (-4.9,-1.5) .. (-5.2,-1.9);
	\draw[very thick,fill=LBrown]  (-4.39,-0.87) ellipse (0.45 and 0.05);
	
	%big lattice
	\begin{scope}[very thick]
		\draw (2.6,-3.4) .. controls (2,-2.1) and (2,1) .. (2,2) -- (1.4,2) .. controls (1.4,1) and (1.3,-2.1) .. (0.8,-3.4);
		\draw (0.8,-3.4) -- (2.2,-1.8) -- (1.3,-0.82) -- (2.03,-0.15) -- (1.36,0.53) -- (2,1.14);
		\node[isosceles triangle,draw,inner sep=0pt,shape border rotate=90, minimum height=0.47cm,minimum width=2.4cm,isosceles triangle stretches] (bigT)at (1.64,1.36) {};
		\node[draw,fill,minimum height=3mm,minimum width=2mm,inner sep=0pt,anchor=north west] (LIsoB) at ([xshift=1mm]bigT.left corner){};
		\node[draw,fill,minimum height=3mm,minimum width=2mm,inner sep=0pt,anchor=north east] (RIsoB) at ([xshift=-1mm]bigT.right corner){};
	\end{scope}
	
	
	%\node at (2,2.5) {petrothermal};
	%small lattice
	\begin{scope}[line width=1.1pt]
		\draw (5.14,-1.28) .. controls (4.9,-0.5) and (4.8,0.5) .. (4.8,1.33) -- (4.5,1.33) .. controls (4.5,0.5) and (4.5,-0.5) .. (4.23,-1.3);
		\draw (4.29,-1.1) -- (4.94,-0.5) -- (4.47,-0.05) -- (4.83,0.3) -- (4.5,0.6) -- (4.81,0.94);
		\node[isosceles triangle,draw,inner sep=0pt,shape border rotate=90, minimum height=0.25cm,minimum width=1.3cm,isosceles triangle stretches] (smaT) at (4.64,1.06) {};
		\node[draw,fill,minimum height=1.5mm,minimum width=0.8mm,inner sep=0pt,anchor=north west] (LIsoS) at ([xshift=1.35mm]smaT.left corner){};
		\node[draw,fill,minimum height=1.5mm,minimum width=0.8mm,inner sep=0pt,anchor=north east] (RIsoS) at ([xshift=-1.35mm]smaT.right corner){};
	\end{scope}
	
	%lattice wires
	\draw (-1.1,-2.8) .. controls (0.1,-2.7) and (2.7,-0.9) .. (RIsoB.south);
	\draw (-1.1,-2.2) .. controls (-0.3,-1.6) and (0.6,-0.8) .. (LIsoB.south);
	\draw (RIsoB.south) .. controls (3.4,-0.3) and (4.5,0.1) .. (RIsoS.south);
	\begin{scope}[on background layer]
		\draw (LIsoB.south) .. controls (3,-0.4) and (4,0.3) .. (LIsoS.south);
	\end{scope}
\end{tikzpicture}
	
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251128163246281.png)

Very interesting for me.

In which, the minimum code to sketch plant per se is:

```latex
\documentclass{standalone}
\usepackage{tikz}

\definecolor{DBrown}{HTML}{9B8879}
\definecolor{LBrown}{HTML}{C5B99F}

\begin{document}

\begin{tikzpicture}
	% power plant
	\draw[thick,fill=DBrown,miter limit=5] (-3.8,-2.41) -- (-1.1,-1.67) -- (-1.1,-3) -- (-3.77,-4) -- cycle;
	\draw[thick,fill=LBrown] (-3.8,-2.41) -- (-6.4,-1.9) -- (-6.42,-3.23) -- (-3.77,-4) -- cycle;
	\draw[thick,fill=LBrown,miter limit=5] (-3.8,-2.41) -- (-1.1,-1.67) -- (-3.6,-1.4) -- (-6.4,-1.9) -- cycle;
	
	\fill[LBrown] (-2.58,-0.69) .. controls (-2.54,-1.22) and (-2.64,-1.52) .. (-2.24,-1.92) -- (-3.84,-1.72) .. controls (-3.54,-1.32) and (-3.44,-1.12) .. (-3.48,-0.7) -- cycle;
	\draw[thick] (-2.58,-0.69) .. controls (-2.54,-1.22) and (-2.64,-1.52) .. (-2.24,-1.92);
	\draw[thick] (-3.48,-0.7) .. controls (-3.49,-1.12) and (-3.54,-1.32) .. (-3.84,-1.72);
	\draw[thick,fill=LBrown]  (-3.03,-0.69) ellipse (0.45 and 0.05);
	
	\fill[LBrown] (-3.94,-0.87) .. controls (-3.9,-1.4) and (-4,-1.7) .. (-3.6,-2.1) -- (-5.2,-1.9) .. controls (-4.9,-1.5) and (-4.8,-1.3) .. (-4.84,-0.88) -- cycle;
	\draw[thick] (-3.94,-0.87) .. controls (-3.9,-1.4) and (-4,-1.7) .. (-3.6,-2.1);
	\draw[thick] (-4.84,-0.88) .. controls (-4.85,-1.3) and (-4.9,-1.5) .. (-5.2,-1.9);
	\draw[thick,fill=LBrown]  (-4.39,-0.87) ellipse (0.45 and 0.05);
\end{tikzpicture}
	
\end{document}
```



<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251128164015305.png" alt="png-1" style="width:50%;" />

<br>

To use it repeatedly, we can use `\tikzset` command to define a `pic` called `powerplant`, and then we can easily use `\pic` command to put it in the `tikzpicture` environment:

```latex
\documentclass{standalone}
\usepackage{tikz}

\definecolor{DBrown}{HTML}{9B8879}
\definecolor{LBrown}{HTML}{C5B99F}

\tikzset{
	powerplant/.pic={
		\begin{scope}[scale=0.2]
			% power plant
			\draw[thick,fill=DBrown,miter limit=5] (-3.8,-2.41) -- (-1.1,-1.67) -- (-1.1,-3) -- (-3.77,-4) -- cycle;
			\draw[thick,fill=LBrown] (-3.8,-2.41) -- (-6.4,-1.9) -- (-6.42,-3.23) -- (-3.77,-4) -- cycle;
			\draw[thick,fill=LBrown,miter limit=5] (-3.8,-2.41) -- (-1.1,-1.67) -- (-3.6,-1.4) -- (-6.4,-1.9) -- cycle;
			
			\fill[LBrown] (-2.58,-0.69) .. controls (-2.54,-1.22) and (-2.64,-1.52) .. (-2.24,-1.92) -- (-3.84,-1.72) .. controls (-3.54,-1.32) and (-3.44,-1.12) .. (-3.48,-0.7) -- cycle;
			\draw[thick] (-2.58,-0.69) .. controls (-2.54,-1.22) and (-2.64,-1.52) .. (-2.24,-1.92);
			\draw[thick] (-3.48,-0.7) .. controls (-3.49,-1.12) and (-3.54,-1.32) .. (-3.84,-1.72);
			\draw[thick,fill=LBrown]  (-3.03,-0.69) ellipse (0.45 and 0.05);
			
			\fill[LBrown] (-3.94,-0.87) .. controls (-3.9,-1.4) and (-4,-1.7) .. (-3.6,-2.1) -- (-5.2,-1.9) .. controls (-4.9,-1.5) and (-4.8,-1.3) .. (-4.84,-0.88) -- cycle;
			\draw[thick] (-3.94,-0.87) .. controls (-3.9,-1.4) and (-4,-1.7) .. (-3.6,-2.1);
			\draw[thick] (-4.84,-0.88) .. controls (-4.85,-1.3) and (-4.9,-1.5) .. (-5.2,-1.9);
			\draw[thick,fill=LBrown]  (-4.39,-0.87) ellipse (0.45 and 0.05);
		\end{scope}
	}
}

\begin{document}

\begin{tikzpicture}
	\pic at (0,0) {powerplant};
	\pic[scale=0.7] at (1,0) {powerplant};
	\pic[scale=0.5] at (2,0) {powerplant};
\end{tikzpicture}
	
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251128164802067.png" alt="png-1" style="width:75%;" />

<br>

To step further, we use the `\newcommand` to define a picture, called `inlinepowerplant`, such we can use it in the main text.

```latex
\documentclass{standalone}
\usepackage{tikz}

\definecolor{DBrown}{HTML}{9B8879}
\definecolor{LBrown}{HTML}{C5B99F}

\newcommand{\inlinepowerplant}{
	\raisebox{0.5ex}{
		\begin{tikzpicture}[baseline=(current bounding box.center),scale=0.2]
			% power plant
			\draw[thick,fill=DBrown,miter limit=5] (-3.8,-2.41) -- (-1.1,-1.67) -- (-1.1,-3) -- (-3.77,-4) -- cycle;
			\draw[thick,fill=LBrown] (-3.8,-2.41) -- (-6.4,-1.9) -- (-6.42,-3.23) -- (-3.77,-4) -- cycle;
			\draw[thick,fill=LBrown,miter limit=5] (-3.8,-2.41) -- (-1.1,-1.67) -- (-3.6,-1.4) -- (-6.4,-1.9) -- cycle;
			
			\fill[LBrown] (-2.58,-0.69) .. controls (-2.54,-1.22) and (-2.64,-1.52) .. (-2.24,-1.92) -- (-3.84,-1.72) .. controls (-3.54,-1.32) and (-3.44,-1.12) .. (-3.48,-0.7) -- cycle;
			\draw[thick] (-2.58,-0.69) .. controls (-2.54,-1.22) and (-2.64,-1.52) .. (-2.24,-1.92);
			\draw[thick] (-3.48,-0.7) .. controls (-3.49,-1.12) and (-3.54,-1.32) .. (-3.84,-1.72);
			\draw[thick,fill=LBrown]  (-3.03,-0.69) ellipse (0.45 and 0.05);
			
			\fill[LBrown] (-3.94,-0.87) .. controls (-3.9,-1.4) and (-4,-1.7) .. (-3.6,-2.1) -- (-5.2,-1.9) .. controls (-4.9,-1.5) and (-4.8,-1.3) .. (-4.84,-0.88) -- cycle;
			\draw[thick] (-3.94,-0.87) .. controls (-3.9,-1.4) and (-4,-1.7) .. (-3.6,-2.1);
			\draw[thick] (-4.84,-0.88) .. controls (-4.85,-1.3) and (-4.9,-1.5) .. (-5.2,-1.9);
			\draw[thick,fill=LBrown]  (-4.39,-0.87) ellipse (0.45 and 0.05);
		\end{tikzpicture}
	}
}
\begin{document}

Power plant 1: \inlinepowerplant, Power plant 2: \inlinepowerplant.
	
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251128165352492.png)

Note that, 

- use `scope` environment in `\tikzset` command; whereas use `tikzpicture` environment in the `\newcommand` command;
- in the latter case, the setting `baseline=(current bounding box.center)` for `tikzpicture` and the use of `\raisebox{0.5ex}{...}` is to manually align the center of picture with the main text.

<br>

[TikzEdt - A WYSIWYG Tikz editor. Home](http://www.tikzedt.org/).

[TikZiT](https://tikzit.github.io/): an online tool.



<br>

**References**

[^1]: [https://tex.stackexchange.com/a/516476/306224](https://tex.stackexchange.com/a/516476/306224).
