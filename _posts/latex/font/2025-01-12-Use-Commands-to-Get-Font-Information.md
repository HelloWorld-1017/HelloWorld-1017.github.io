---
title: Use Commands to Get Font Information in LaTeX
toc: false
categories:
 - Design
 - LaTeX
tags:
 - LaTeX Font
 - LaTeX fontspec
date: 2025-01-12 21:17:50 +0800
last_modified_at: 2025-01-13 10:30:24 +0800
---

In previous blogs, I explored font size[^1], font family, font shape, font series[^2], and font typeface[^3] in LaTeX. And on another hand, we can use commands, which are redefined from built-in macros of `fontspect` package, to get above information of currently used font[^4], for example:

```latex
\documentclass[a4paper,landscape]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{fontspec}

\makeatletter
\newcommand{\ffamily}{\f@family}
\newcommand{\fshape}{\f@shape}
\newcommand{\fseries}{\f@series}
\newcommand{\fsize}{\f@size}
\makeatother

\begin{document}
\begin{minipage}{13em}
	For different font families:
	\begin{enumerate}
		\item {\rmfamily \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\sffamily \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\ttfamily \ffamily, \fshape, \fseries, \fsize\ pt}
	\end{enumerate}
\end{minipage}
\begin{minipage}{13em}
	For different font typefaces:
	\begin{enumerate}
		\item {\fontfamily{lmdh}\selectfont \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\fontfamily{phv}\selectfont \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\fontfamily{courier}\selectfont \ffamily, \fshape, \fseries, \fsize\ pt}
	\end{enumerate}
\end{minipage}
\begin{minipage}{13em}
	For different font shapes:
	\begin{enumerate}
		\item {\upshape \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\itshape \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\slshape \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\scshape \ffamily, \fshape, \fseries, \fsize\ pt}
	\end{enumerate}
\end{minipage}
\begin{minipage}{13em}
	For different font series:
	\begin{enumerate}
		\item {\mdseries \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\bfseries \ffamily, \fshape, \fseries, \fsize\ pt}
	\end{enumerate}
\end{minipage}
\begin{minipage}{23em}
	For different font sizes:
	\begin{enumerate}
		\item {\tiny \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\scriptsize \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\footnotesize \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\small \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\normalsize \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\large \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\Large \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\LARGE \ffamily, \fshape, \fseries, \fsize\ pt}
		\item {\huge \ffamily, \fshape, \fseries, \fsize\ pt}	
		\item {\Huge \ffamily, \fshape, \fseries, \fsize\ pt}			
	\end{enumerate}
\end{minipage}
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131053916.png)

As can be seen, the font information of font family, font typeface, font shape, and font series is denoted by some code, i.e. Berry name[^6], and font size is by certain number which is in unit of point. The Berry name of font shape and font series is simple, and as for font family and typeface, we can find their Berry names in blog[^3], StachExchange answer (a more detailed list)[^5], and `fontname.pdf`[^6][^7].

<br>

Another way, which is more convenient, is using command `\fontname\font`:

```latex
\documentclass[a4paper,landscape]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{fontspec}

\begin{document}
\begin{minipage}{30em}
	For different font families:
	\begin{enumerate}
		\item {\rmfamily \fontname\font}
		\item {\sffamily \fontname\font}
		\item {\ttfamily \fontname\font}
	\end{enumerate}
\end{minipage}
\begin{minipage}{30em}
	For different font typefaces:
	\begin{enumerate}
		\item {\fontfamily{lmdh}\selectfont \fontname\font}
		\item {\fontfamily{phv}\selectfont \fontname\font}
		\item {\fontfamily{courier}\selectfont \fontname\font}
	\end{enumerate}
\end{minipage}

\vspace{2em}

\begin{minipage}{35em}
	For different font shapes:
	\begin{enumerate}
		\item {\upshape \fontname\font}
		\item {\itshape \fontname\font}
		\item {\slshape \fontname\font}
		\item {\scshape \fontname\font}
	\end{enumerate}
\end{minipage}
\begin{minipage}{30em}
	For different font series:
	\begin{enumerate}
		\item {\mdseries \fontname\font}
		\item {\bfseries \fontname\font}
	\end{enumerate}
\end{minipage}

\vspace{2em}

\begin{minipage}{\textwidth}
	For different font sizes:
	\begin{enumerate}
		\item {\tiny \fontname\font}
		\item {\scriptsize \fontname\font}
		\item {\footnotesize \fontname\font}
		\item {\small \fontname\font}
		\item {\normalsize \fontname\font}
		\item {\large \fontname\font}
		\item {\Large \fontname\font}
		\item {\LARGE \fontname\font}
		\item {\huge \fontname\font}
		\item {\Huge \fontname\font}	
	\end{enumerate}
\end{minipage}
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131056627.png)

<br>

**References**

[^1]: [LaTeX Font Size Commands](/2024-05-31/12-32-43.html).
[^2]: [Specify Font Family, Font Shape, and Font Series in LaTeX](/2025-01-12/14-34-58.html).
[^3]: [Specify Font Typeface in LaTeX](/2025-01-12/18-17-50.html).
[^4]: [`fontspec` - How to extract the `fontname` from `\the\font`](https://tex.stackexchange.com/questions/613994/how-to-extract-the-fontname-from-the-font).
[^5]: [https://tex.stackexchange.com/a/25251/306224](https://tex.stackexchange.com/a/25251/306224).
[^6]: [documentation - Berry naming scheme list of LaTeX font families](https://tex.stackexchange.com/questions/23592/berry-naming-scheme-list-of-latex-font-families).
[^7]: [fontname.pdf](https://www.tug.org/fontname/fontname.pdf).
