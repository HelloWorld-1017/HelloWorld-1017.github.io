---
title: Customize Cross Reference Format in LaTeX Using `cleveref` Package
toc: false
categories:
 - LaTeX
tags:
 - LaTeX cleveref
 - LaTeX hyperref
date: 2023-11-28 19:12:32 +0800
last_modified_at: 2025-01-06 19:13:04 +0800
---

In LaTeX, it’s very convenient to use `\label` and `\ref` command to make a cross reference. However, in the normal case, `\ref` command can’t create a link that can make PDF file jump to the label where it is defined when we click it, and also can’t color the text. For example:

```latex
\documentclass{article}
\usepackage{geometry}
\geometry{a4paper}
\usepackage{graphicx,subfig,amsmath}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\DeclareSubrefFormat{myparens}{#1-(#2)}
\captionsetup[subfloat]{subrefformat=myparens}

\begin{document}

\section{Introduction}
\label{sec-introduction}
\begin{equation}
	a = b+c \label{eq}
\end{equation}
\begin{figure}
	\def\CE{0.30}
	\centering
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{lion.eps}\label{fig-a}}\hspace{20pt}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{lion.eps}}
	\caption{This is caption.}
	\label{fig}
\end{figure}

\noindent
Section: ~\ref{sec-introduction}\\
Equation: $~\eqref{eq}$\\
Figure: ~\ref{fig}\\
Subfigure: ~\subref*{fig-a}\\

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501071516266.png" alt="image-20250107151643090" style="width:50%;" />

We can combine using `hyperref` and `cleveref` packages[^1][^2] to overcome the above two problems:

```latex
\documentclass{article}
\usepackage{geometry}
\geometry{a4paper}
\usepackage{graphicx,subfig,amsmath}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage[colorlinks,linkcolor=red]{hyperref}
\usepackage{cleveref}

\DeclareSubrefFormat{myparens}{#1-(#2)}
\captionsetup[subfloat]{subrefformat=myparens}

\begin{document}

\section{Introduction}
\label{sec-introduction}

\begin{equation}
a = b+c 
\label{eq}
\end{equation}

\begin{figure}
	\def\CE{0.30}
	\centering
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{lion.eps}\label{fig-a}}\hspace{20pt}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{lion.eps}}
	\caption{This is caption.}
	\label{fig}
\end{figure}

\noindent
Section: ~\cref{sec-introduction}\\
Equation: $~\cref{eq}$\\
Figure: ~\cref{fig}\\
Subfigure: ~\cref{fig-a}\\

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501071517381.png" alt="image-20250107151756233" style="width:50%;" />

<div class="notice--primary" markdown="1">

In the above case, the name for equation, `eq.`, is italic. This is because I put `~\cref{eq}` in an inline math environment. Otherwise:

```latex
% ...

Equation: ~\cref{eq}\\

% ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501071549757.png" alt="image-20250107154956683" style="width:50%;" />

</div>

Besides the default setting, there are some other options acceptable for the `cleveref` package, such as `nameinlink`:

```latex
\usepackage[nameinlink]{cleveref}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501071550962.png" alt="image-20250107155049890" style="width:50%;" />

and `noabbrev` and `capitalise` options:

```latex
\usepackage[nameinlink,noabbrev,capitalise]{cleveref}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501071551495.png" alt="image-20250107155131404" style="width:50%;" />

<br>

**References**

- [Latex正确的引用姿势(使用`~\cite`, `~\cref`, `~\autoref`)\_latex `cref`](https://blog.csdn.net/qq_34769162/article/details/124061761).

[^1]: [The `cleveref` package](https://us.mirrors.cicku.me/ctan/macros/latex/contrib/cleveref/cleveref.pdf).
[^2]: [sectioning - cross reference a section and equation with color](https://tex.stackexchange.com/questions/536790/cross-reference-a-section-and-equation-with-color).
