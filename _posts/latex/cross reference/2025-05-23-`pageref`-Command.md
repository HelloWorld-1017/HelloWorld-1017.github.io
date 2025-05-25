---
title: LaTeX `\pageref` Command
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Cross Reference
date: 2025-05-23 19:29:10 +0800
last_modified_at: 2025-05-25 09:45:31 +0800
gallery:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505241806398.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505241806832.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505241806105.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505241822880.png
---

In LaTeX, we can use the `\pageref` command to “produce the page number of the place in the text where the corresponding `\label` command appears. ie. where `\label{key}` appears”[^1][^2]. Here is an example.

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath}
\usepackage{graphicx,subfig}
\usepackage[
	colorlinks,
	linkcolor=blue,
	urlcolor=blue,
	citecolor=red]{hyperref}

\usepackage{lipsum}
\newcommand{\mylipsum}{\lipsum[1]}
\newcommand{\mylonglipsum}{\lipsum[1-4]}

\begin{document}
\tableofcontents

\section{Section}
\label{sec}
\mylonglipsum

\subsection{Subsection}
\label{subsec}
\mylonglipsum

\subsubsection{Subsubsection}
\label{subsubsec}
\mylipsum

\paragraph{Paragraph A} \mylipsum
\subparagraph{Paragraph A-1} \mylipsum
\subparagraph{Paragraph A-2} \mylipsum
\mylipsum

\begin{figure}[h]
\def\CE{0.20}
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\label{fig1-1}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\label{fig1-2}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\label{fig1-3}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}\label{fig1-4}}
\caption{CTAN lion}
\label{fig1}
\end{figure}

\paragraph{Paragraph B} \mylipsum

\begin{subequations}
\begin{align}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \label{eq1-1}\\
&= a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \label{eq1-2}\\
&= a^3+b^3 \label{eq1-3}
\end{align}\label{eq1}
\end{subequations}

\subparagraph{Paragraph B-1} \mylipsum

\begin{equation}
\begin{split}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \\
&= a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \\
&= a^3+b^3 
\end{split}\label{eq2}
\end{equation}

\subparagraph{Paragraph B-2} \mylipsum
\mylipsum

\begin{itemize}
\item Section \ref{sec} on Page \pageref{sec}.
\item Subsection \ref{subsec} on Page \pageref{subsec}.
\item Subsubsection \ref{subsubsec} on Page \pageref{subsubsec}.
\item Equation \ref{eq1} on Page \pageref{eq1}.
	\subitem Subequation \ref{eq1-1} on Page \pageref{eq1-1}.
	\subitem Subequation \ref{eq1-2} on Page \pageref{eq1-2}.
	\subitem Subequation \ref{eq1-3} on Page \pageref{eq1-3}.
\item Equation \ref{eq2} on Page \pageref{eq2}.
\item Figure \ref{fig1} on Page \pageref{fig1}.
	\subitem Subfigure \ref{fig1-1} on Page \pageref{fig1-1}.
	\subitem Subfigure \ref{fig1-2} on Page \pageref{fig1-2}.
	\subitem Subfigure \ref{fig1-3} on Page \pageref{fig1-3}.
	\subitem Subfigure \ref{fig1-4} on Page \pageref{fig1-4}.
\item Reference \cite{bib-1} on Page \pageref{bib-1}.
\item Reference \cite{bib-2} on Page \pageref{bib-2}.
\item Reference \cite{bib-3} on Page \pageref{bib-3}.
\item Reference \ref{ref1} on Page \pageref{ref1}.
\item Reference \ref{ref2} on Page \pageref{ref2}.
\item Reference \ref{ref3} on Page \pageref{ref3}.
\end{itemize}

\begin{thebibliography}{1}
\bibitem{bib-1} \label{ref1} Reference 1.
\bibitem{bib-2} \label{ref2} Reference 2.
\bibitem{bib-3} \label{ref3} Reference 3.
\end{thebibliography}

\end{document}
```

{% include gallery id="gallery" layout="half" %}

Naturally, we can see that for references, `\pageref` can’t recognize labels created by the `\bibitem`, so if we want to realize the same effects as that of sections and equations etc., we could create a label for a bibliography item using the `\label` command and then refer to this label by the `\pageref`.

Besides, we can define a new command `\mypageref` for ease of use:

```latex
\newcommand{\mypageref}[1]{\ref{#1} on Page \pageref{#1}}
```

```latex
\begin{itemize}
\item Section \mypageref{sec}.
\item Subsection \mypageref{subsec}.
\item Subsubsection \mypageref{subsubsec}.
\item Equation \mypageref{eq1}.
	\subitem Subequation \mypageref{eq1-1}.
	\subitem Subequation \mypageref{eq1-2}.
	\subitem Subequation \mypageref{eq1-3}.
\item Equation \mypageref{eq2}.
\item Figure \mypageref{fig1}.
	\subitem Subfigure \mypageref{fig1-1}.
	\subitem Subfigure \mypageref{fig1-2}.
	\subitem Subfigure \mypageref{fig1-3}.
	\subitem Subfigure \mypageref{fig1-4}.
\item Reference \mypageref{ref1}.
\item Reference \mypageref{ref2}.
\item Reference \mypageref{ref3}.
\end{itemize}
```

<br>

What's more, we can see another practical use of the `\pageref` command in page numbering in blog[^3].

<br>

**References**

[^1]: [LaTeX help 1.1 - `\pageref`](https://emerson.emory.edu/services/latex/latex_16.html).
[^2]: [Cross referencing sections, equations and floats](https://www.overleaf.com/learn/latex/Cross_referencing_sections%2C_equations_and_floats#Referencing_the_page_of_an_element).
[^3]: [An Example of Page Numbering in LaTeX](/2025-05-13/14-20-50.html).