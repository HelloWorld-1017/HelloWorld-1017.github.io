---
title: LaTeX `showlabels` Package --- Keep track of all defined labels
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Cross Reference
 - LaTeX showlabels
 - LaTeX rotating
date: 2025-05-23 18:54:45 +0800
last_modified_at: 2025-05-24 16:44:41 +0800
---

LaTeX `showlabels` package is used to help us to “track of all the labels you define, by putting the name of new labels into the margin whenever the `\label` command is used”[^1]. Here is an example.

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

\usepackage{showlabels}
\showlabels{bibitem}
\showlabels{cite}

\begin{document}

\section{Section}
\label{sec1}
\subsection{Subsection}
\label{subsec1}
\subsubsection{Subsubsection}
\label{subsubsec1}

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

\begin{subequations}
\begin{align}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \label{eq1-1}\\
&= a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \label{eq1-2}\\
&= a^3+b^3 \label{eq1-3}
\end{align}\label{eq1}
\end{subequations}


\begin{equation}
\begin{split}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \\
&= a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \\
&= a^3+b^3 
\end{split}\label{eq2}
\end{equation}

\cite{ref1}

\cite{ref2}

\cite{ref3}

\begin{thebibliography}{1}
\bibitem{ref1} The showlabels package. \href{https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/showlabels/showlabels.pdf}{showlabels.pdf}.

\bibitem{ref2} The showlabels package. \href{https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/showlabels/showlabels.pdf}{showlabels.pdf}.

\bibitem{ref3} The showlabels package. \href{https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/showlabels/showlabels.pdf}{showlabels.pdf}.
\end{thebibliography}
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505241631830.png)

In the above case, with the default option, the label of sub-figures cannot be displayed as expected. The package also provides other options[^2][^3], and the `inline` option can help to solve this problem to some extent:

```latex
% ...

\usepackage[inline]{showlabels}
\showlabels{bibitem}
\showlabels{cite}

% ...
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505241637883.png)

<br>

Besides, the package also supports formatting the labels[^3]:

```latex
% ...

\usepackage{showlabels}
\renewcommand{\showlabelfont}{\small\slshape\color{red}}
\showlabels[\fbox]{bibitem}
\showlabels[\fbox]{cite}

% ...
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505241641013.png)

or even labels rotating by the `rotating` package[^3]:

```latex
% ...

\usepackage{showlabels}
\renewcommand{\showlabelfont}{\small\slshape\color{red}}
\showlabels{bibitem}
\showlabels{cite}

\usepackage{rotating}
\renewcommand{\showlabelsetlabel}[1]
{\begin{turn}{60}\showlabelfont #1\end{turn}}

% ...
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505241644834.png)

<br>

**References**

[^1]: [CTAN: Package `showlabels`](https://ctan.org/pkg/showlabels?lang=en).
[^2]: [Keep track of your labels with `showlabels`](https://www.overleaf.com/learn/latex/Latex-questions/Keep_track_of_your_labels_with_showlabels).
[^3]: [The `showlabels` package](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/showlabels/showlabels.pdf).
