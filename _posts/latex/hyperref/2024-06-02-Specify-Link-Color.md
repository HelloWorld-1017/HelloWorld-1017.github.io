---
title: Specify Link Color Using LaTeX `hyperref` Package
toc: false
categories:
 - LaTeX
tags:
 - LaTeX hyperref
date: 2024-06-02 21:22:07 +0800
last_modified_at: 2025-01-03 13:46:47 +0800
---

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\geometry{a4paper}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage[
hyperfootnotes=true,
colorlinks=true,
linkcolor=violet,
anchorcolor=orange,
citecolor=green, 
filecolor=red,
runcolor=cyan,
urlcolor=blue 
]{hyperref}

\newcommand{\myhypertarget}[3][orange]{\hypertarget{#2}{\textcolor{#1}{#3}}}

\begin{document}
\tableofcontents

\section{Introduction}
\label{sec-introduction}
\begin{tabular}{ll}
	Website       & \href{www.wikipedia.com}{Wikipedia}\\
	File          & \href{readme.txt}{Open ``./readme.txt''}\\
	Run file      & \href{run:readme.txt}{Run ``./readme.txt''}\\
	Footnote      & footnote\footnote{This is a footnote.}\\
	Internal link & \hyperref[sec-introduction]{Introduction}\\
	\hypertarget{link}{Anchored by ``hypertarget"} & \hyperlink{link}{Link to tag ``link''.}\\
	\myhypertarget{mylink}{Anchored by ``myhypertarget"} & \hyperlink{mylink}{Link to tag ``mylink''.}\\
	Cite reference & \cite{b1}\\
\end{tabular}

\vspace{7em}

footnote\footnote{This is a footnote.}.

\vspace{7em}

\begin{thebibliography}{00}
\bibitem{b1} \href{https://tex.stackexchange.com/questions/478463/anchorcolor-in-hyperref-not-working}{anchorcolor in hyperref not working?}
\end{thebibliography}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501022146282.png" alt="img-1" style="width:100%;" />

As can be seen, the footnote in the table can’t be seen. This problem is discussed in detail in blog[^1].
{: .notice--primary}

<br>

**References**

- [Adding Hyperlinks in LaTeX](https://www.baeldung.com/cs/latex-hyperref-url-hyperlinks).
- [options for appearance of links in `hyperref`?](https://tex.stackexchange.com/questions/50747/options-for-appearance-of-links-in-hyperref).
- [`anchorcolor` in `hyperref` not working?](https://tex.stackexchange.com/questions/478463/anchorcolor-in-hyperref-not-working).
- [better default colors for `hyperref` links](https://tex.stackexchange.com/questions/525261/better-default-colors-for-hyperref-links).

[^1]: [Use Footnotes in LaTeX Tables](/2025-01-02/21-41-01.html).

