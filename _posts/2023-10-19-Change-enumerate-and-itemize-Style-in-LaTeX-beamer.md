---
layout: single
title: "Change `enumerate` and `itemize` Style in LaTeX beamer"
date: 2023-10-19 21:42:12 +0800
categories:
 - LaTeX
tag: 
 - LaTeX beamer
---

# Original style

```latex
\documentclass{beamer}

\begin{document}
\begin{frame}
	\begin{columns}
		\column{0.5\textwidth}
		\begin{enumerate}
			\item Item one
			\item Item two
			\begin{enumerate}
				\item Sub-item one
				\item Sub-item two
				\begin{enumerate}
					\item Subsub-item one
					\item Subsub-item two
				\end{enumerate}
			\end{enumerate}
		\end{enumerate}
		\column{0.5\textwidth}
		\begin{itemize}
			\item Item one
			\item Item two
			\begin{itemize}
				\item Sub-tem one
				\item Sub-item two
				\begin{itemize}
					\item Subsub-item one
					\item Subsub-item two
				\end{itemize}
			\end{itemize}
		\end{itemize}
	\end{columns}
\end{frame}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310182241284.png" alt="png-1" style="zoom:50%;" />

<br>

# Change font size

We could use control sequence `\setbeamertemplate` in preamble area to globally specify the text font size in  `itemize` and `enumerate` environment [[1]](#ref):

```latex
\documentclass{beamer}

\setbeamertemplate{itemize/enumerate body begin}{\Large}
\setbeamertemplate{itemize/enumerate subbody begin}{\small}
\setbeamertemplate{itemize/enumerate subsubbody begin}{\tiny}
% ....
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310182243218.png" alt="png-1" style="zoom: 50%;" />

However, as can be seen, the text at the second level overlaps slightly as font size increases. We could correct this point by finishing the graph (inserting an empty line or adding `\\`) before the `itemize` or `enumerate` environment whose font size is switch to different value compared with the former one [[1]](#ref). 

The complete code shows as follows:

```latex
\documentclass{beamer}

\setbeamertemplate{itemize/enumerate body begin}{\Large}
\setbeamertemplate{itemize/enumerate subbody begin}{\small}
\setbeamertemplate{itemize/enumerate subsubbody begin}{\tiny}

\begin{document}
	\begin{frame}
		\begin{columns}
			\column{0.5\textwidth}
			\begin{enumerate}
				\item Item one
				\item Item two\\
				\begin{enumerate}
					\item Sub-item one
					\item Sub-item two\\
					\begin{enumerate}
						\item Subsub-item one
						\item Subsub-item two
					\end{enumerate}
				\end{enumerate}
			\end{enumerate}
			\column{0.5\textwidth}
			\begin{itemize}
				\item Item one
				\item Item two
				
				\begin{itemize}
					\item Sub-tem one
					\item Sub-item two
					
					\begin{itemize}
						\item Subsub-item one
						\item Subsub-item two
					\end{itemize}
				\end{itemize}
			\end{itemize}
		\end{columns}
	\end{frame}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310182245335.png" alt="png-1" style="zoom:50%;" />

In addition, there are a lot of styles that could be specified by `\setbeamertemplate`, and more detailed information could be found in BEAMER appearance cheat sheet [[2]](#ref):

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310192110891.png" alt="image-20231019211036814" style="zoom:50%;" />

<br>

# Align items top

At default case, like aforementioned examples, the content in the `frame` environment will be displayed in the slide center. If want to align items top (essentially, align columns in `columns` environment top), we could specify option `[t]` for `frame` environment [[3]](#ref): 

![image-20231019211210612](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310192112665.png)

The effect shows as follows:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310182300727.png" alt="png-1" style="zoom:50%;" />

If it does not work, we could add some extra codes in preamble area [[4]](#ref):

```latex
\makeatletter
\define@key{beamerframe}{t}[true]{
  \beamer@frametopskip=.2cm plus .5\paperheight\relax%
  \beamer@framebottomskip=0pt plus 1fill\relax%
  \beamer@frametopskipautobreak=\beamer@frametopskip\relax%
  \beamer@framebottomskipautobreak=\beamer@framebottomskip\relax%
  \def\beamer@initfirstlineunskip{}%
}
\makeatother   
```

or organise the contents using `minipage` environment rather than `columns` [[5]](#ref).

<br>

# Change unordered list mark style [[6, 7]](#ref)

```latex
\documentclass{beamer}
\usepackage{pifont}
\setbeamertemplate{itemize/enumerate body begin}{\small}
\setbeamertemplate{itemize/enumerate subbody begin}{\small}

\begin{document}
	\begin{frame}[t]{List style}
		\begin{columns}[t]
			\column{0.60\textwidth}
			Change the marker appearance.
			\begin{itemize}
				\setbeamertemplate{itemize items}[circle]
				\item circle
				\setbeamertemplate{itemize items}[square]
				\item square
				\setbeamertemplate{itemize items}[ball]
				\item ball
				\item Symbol provided by pifont package
				\begin{itemize}% Symbol provided by `pifont` package
					\item[\ding{51}] Code 51
					\item[\ding{56}] Code 56
					\item[\ding{43}] Code 43
					\item[\ding{118}] Code 118
					\item[\ding{170}] Code 170
					\item[\ding{112}] Code 112
					\item[\ding{117}] Code 117
					\item[\ding{220}] Code 220
					\item[\ding{226}] Code 226
					\item[\ding{227}] Code 227
					\item[\ding{228}] Code 228
				\end{itemize}
			\end{itemize}
			
			\column{0.40\textwidth}
			Change numerals.
			\begin{enumerate}[I]
				\item Point A
				\item Point B
				\begin{enumerate}[i]
					\item part 1
					\item part 2
				\end{enumerate}
				\item Point C
				\item Point D
			\end{enumerate}
		\end{columns}
	\end{frame}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310190017913.png" alt="png-1" style="zoom:50%;" />

<br>

<div id="ref"></div>

**References**

[1] [https://stackoverflow.com/a/75483399/22763127](https://stackoverflow.com/a/75483399/22763127).

[2] [https://www.cpt.univ-mrs.fr/~masson/latex/Beamer-appearance-cheat-sheet.pdf](https://www.cpt.univ-mrs.fr/~masson/latex/Beamer-appearance-cheat-sheet.pdf).

[3] [https://latex-beamer.com/faq/place-content-frame/](https://latex-beamer.com/faq/place-content-frame/).

[4] [https://tex.stackexchange.com/a/22944/306224](https://tex.stackexchange.com/a/22944/306224).

[5] [https://tex.stackexchange.com/a/184689/306224](https://tex.stackexchange.com/a/184689/306224).

[7] [https://latex-beamer.com/tutorials/lists/](https://latex-beamer.com/tutorials/lists/).

[6] [https://mirror-hk.koddos.net/CTAN/macros/latex/required/psnfss/psnfss2e.pdf](https://mirror-hk.koddos.net/CTAN/macros/latex/required/psnfss/psnfss2e.pdf).
