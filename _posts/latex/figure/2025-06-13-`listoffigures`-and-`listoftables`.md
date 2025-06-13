---
title: LaTeX Commands `\listoffigures` and `\listoftables` --- Create a TOC for Figures and Tables
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Figure
 - LaTeX Table
 - LaTeX TOC
date: 2025-06-13 14:06:40 +0800
last_modified_at: 2025-06-13 14:06:40 +0800
gallery:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506131410457.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506131411025.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506131411421.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506131413424.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506131413322.png
---

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath}
\usepackage[colorlinks, linkcolor=blue]{hyperref}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{graphicx,subfig}
\renewcommand{\figurename}{Fig.}

\numberwithin{equation}{section}
\numberwithin{figure}{section}

\def\CE{0.20}

\usepackage{lipsum}
\newcommand{\mylipsum}{\lipsum[1-3]}

\begin{document}
\listoffigures
\listoftables

\newpage

\section{Section 1}
\mylipsum

\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption[ctan linon (use a short caption as an alias in the ``List of Figures'')]{CTAN lion}
\label{fig-1}
\end{figure}

\begin{table}[h]
\centering
\caption[simple table (use a short caption as an alias in the ``List of Tables'')]{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{table}

\section{Section 2}
\mylipsum

\subsection{Subsection 2.1}
\mylipsum

\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-2}
\end{figure}

\begin{table}[h]
\centering
\caption{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{table}

\subsection{Subsection 2.2}
\mylipsum

\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-3}
\end{figure}

\begin{table}[h]
\centering
\caption{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{table}

\section{Section 3}
\mylipsum

\section{Section 4}
\mylipsum

\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-4}
\end{figure}

\begin{table}[h]
\centering
\caption{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{table}

\end{document}
```

{% include gallery id="gallery" layout="half" %}

<br>

**References**

- [LaTeX/Floats, Figures and Captions](https://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions).