---
title: Align Contents in LaTeX --- Environments `center`, `Center`, `flushleft`, `FlushLeft`, `flushright`, `FlushRight`, and commands `\centering`, `\Centering`, `\raggedleft`, `\RaggedLeft`, `\raggedright`, `\RaggedRight`
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Layout
 - LaTeX ragged2e
location: Buffalo, United States
date: 2025-10-28 12:16:33 -0400
last_modified_at: 2025-10-28 12:16:33 -0400
---

```latex
\documentclass[a5paper]{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}
\usepackage{ragged2e}

\pagestyle{empty}
\begin{document}

\textbf{plain}: \lipsum[1][1-5]

\begin{center}
	\textbf{center environment}: \lipsum[1][1-5]
\end{center}

\begin{Center}
	\textbf{Center environment of ragged2e package}: \lipsum[1][1-5]
\end{Center}

{\centering \textbf{\textbackslash centering command}: \lipsum[1][1-5] \par} % \par and curly brackets are needed

{\Centering \textbf{\textbackslash Centering command of ragged2e package}: \lipsum[1][1-5] \par} % \par and curly brackets are needed

\newpage
\begin{flushleft}
	\textbf{flushleft environment}: \lipsum[1][1-5]
\end{flushleft}

\begin{FlushLeft}
	\textbf{FlushLeft environment of ragged2e package}: \lipsum[1][1-5]
\end{FlushLeft}

{\raggedleft \textbf{\textbackslash raggedleft command}: \lipsum[1][1-5] \par} % \par and curly brackets are needed

{\RaggedLeft \textbf{\textbackslash RaggedLeft command of ragged2e package}: \lipsum[1][1-5] \par} % \par and curly brackets are needed

\newpage
\begin{flushright}
	\textbf{flushright environment}: \lipsum[1][1-5]
\end{flushright}

\begin{FlushRight}
	\textbf{FlushRight environment of ragged2e package}: \lipsum[1][1-5]
\end{FlushRight}

{\raggedright \textbf{\textbackslash raggedright command}: \lipsum[1][1-5] \par} % \par and curly brackets are needed

{\RaggedRight \textbf{\textbackslash RaggedRight command of ragged2e package}: \lipsum[1][1-5] \par} % \par and curly brackets are needed
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251028122218789.png" alt="png-1" style="width:75%" />

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251028122224325.png" alt="png-2" style="width:75%;" />

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251028122231902.png" alt="png-3" style="width:75%;" />

- It seems that there is not a standard environment called `centering`, although I used it a lot before --- I remember it works without errors or warnings ......
- Environments will create additional vertical distance.
- When using commands, instead of environments, remember to use `\par` and `{}` to isolate the content, which prevents influencing subsequent contents.
- Those commands and environments (with capitalization) from the `ragged2e` package are built upon those original ones, and they avoid "the text looks *too* ragged" by using hyphenation somewhere if needed[^1][^2].

<br>

**References**

[^1]: [ragged2e.pdf](https://mirror.ox.ac.uk/sites/ctan.org/macros/latex/contrib/ragged2e/ragged2e.pdf).
[^2]: [Text alignment](https://www.overleaf.com/learn/latex/Text_alignment).