---
title: Number Equations and Figures by Sections or Subsections in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
 - LaTeX Figure
date: 2025-05-16 15:34:44 +0800
last_modified_at: 2025-05-16 15:34:44 +0800
gallery:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505161540098.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505161540552.png
gallery1:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505161543727.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505161543633.png
---

**(1) Number equations and figures by sections**

In LaTeX, we can use commands:

```latex
\numberwithin{equation}{section}
\numberwithin{figure}{section}
```

to number equations and figures by sections. Here is an example.

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

\begin{document}
\section{Section 1}
\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\label{fig-a}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-1}
\end{figure}

\begin{equation}
a=b+c\\
\end{equation}

\section{Section 2}
\begin{equation}
a=b+c\\
\end{equation}

\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\label{fig-a}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-2}
\end{figure}

\subsection{Subsection 2.1}
\begin{equation}
a=b+c\\
\end{equation}

\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\label{fig-a}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-3}
\end{figure}

\begin{equation}
a=b+c\\
\end{equation}

\subsection{Subsection 2.2}
\begin{equation}
a=b+c\\
\end{equation}

\begin{equation}
a=b+c\\
\end{equation}

\subsection{Subsection 2.3}

\begin{equation}
a=b+c\\
\end{equation}

\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\label{fig-a}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-4}
\end{figure}

\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\label{fig-a}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-5}
\end{figure}

\begin{equation}
a=b+c\\
\end{equation}

\section{Section 3}
\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\label{fig-a}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-6}
\end{figure}

\begin{equation}
a=b+c\\
\end{equation}

\begin{equation}
a=b+c\\
\end{equation}
\end{document}
```

{% include gallery id="gallery" layout="half" %}

**(2) Number equations and figures by subsections**

Similarly, by subsections we could use commands:

```latex
% ...

\numberwithin{equation}{subsection}
\numberwithin{figure}{subsection}

% ...
```

{% include gallery id="gallery1" layout="half" %}

<br>

**References**

- [Latex 公式图表按章节编号、顺序编号\_latex公式按章节编号](https://blog.csdn.net/weixin_42845306/article/details/124652562).
- [Change the type of equation numbering in document class article](https://tex.stackexchange.com/questions/54241/change-the-type-of-equation-numbering-in-document-class-article).
