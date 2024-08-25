---
layout: single
title: Insert Figures and Set whose Style in LaTeX beamer
date: 2023-10-20 23:34:45 +0800
categories:
 - LaTeX
tag: 
 - LaTeX beamer
 - LaTeX Figure
---

# Insert figures

Inserting figures in LaTeX `beamer` class is similar to that in `article` class, which could be found in blog [[1]](#ref) and [[2]](#ref):

```latex
\documentclass{beamer}
\usetheme{Warsaw}
\usepackage{graphicx,subfig}
\renewcommand{\figurename}{Fig.}
\captionsetup[figure]{justification=raggedright,singlelinecheck=false}
\captionsetup[subfigure]{justification=centering}

\begin{document}
	\begin{frame}{Figure and multi-figure layout}
		\begin{figure}
			\centering
			\includegraphics[width=0.2\textwidth]{pic-2.pdf}
			\caption{This is a random data series, and here is long long long long long long long long long long caption.}
			\label{fig-1}
		\end{figure}
		
		\begin{figure}
			\def\CE{0.20}
			\centering
			\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{pic-1.pdf}\label{fig-a}}\hfill
			\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{pic-2.pdf}}\hfill
			\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{pic-3.pdf}}\hfill
			\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}}
			\caption{This is a set of random data series.}
			\label{fig-2}
		\end{figure}
	\end{frame}
	
	\begin{frame}{Figure in columns environment}
		\begin{columns}
			\begin{column}{0.5\textwidth}
				The right side is a figure in the columns environment.\\ \bigskip
				There are three figures in these two slides, that is Fig. $\ref{fig-1}$, Fig. $\ref{fig-2}$, and Fig. $\ref{fig-3}$.
			\end{column}

			\begin{column}{0.5\textwidth}
				\begin{figure}
					\centering
					\includegraphics[width=0.7\textwidth]{pic-1.pdf}
					\caption{This is a random data series}
					\label{fig-3}
				\end{figure}
			\end{column}
		\end{columns}
	\end{frame}
\end{document}
```

![beamer1-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310202315092.png)

![beamer1-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310202315772.png)

<br>

# Dispalying figure caption number

Under default settings, as can be seen, there exist no caption number although the figure counter is available. And setting to display it is also very simple, all we need is setting:

```latex
\setbeamertemplate{caption}[numbered]
```

in the preamble area [[3]](#ref). 

![beamer2-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310202325657.png)

![beamer2-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310202325946.png)

<br>

<div id="ref"></div>

**References**

[1] [Customise Figure Caption Style in LaTeX System - What a starry night ~](https://helloworld-1017.github.io/2023-10-11/14-19-07.html).

[2] [Organise Multi-figure Layout in LaTeX System - What a starry night ~](https://helloworld-1017.github.io/2023-10-03/22-38-49.html).

[3] [Beamer Presentation: Figure has no number? - Stack Exchange](https://tex.stackexchange.com/a/127150/306224).

[4] [Figures in Beamer - A detailed tutorial - LaTeX Beamer](https://latex-beamer.com/tutorials/beamer-figure/).
