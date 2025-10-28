---
title: LaTeX Command `\justifying` of `ragged2e` Package ---  Switch back to justified text after ragged text
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Layout
 - LaTeX ragged2e
location: Buffalo, United States
date: 2025-10-28 13:20:05 -0400
last_modified_at: 2025-10-28 13:20:05 -0400
---

```latex
\documentclass[a4paper]{article}
\usepackage{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}
\usepackage{ragged2e}
\setlength{\parskip}{1em}

\pagestyle{empty}
\begin{document}

\begin{Center}
	\textbf{\textbackslash justifying in Center environment}
	
	\lipsum[1][1-5]
	
	{\justifying \textbf{\textbackslash justifying} \lipsum[1][1-5] \par}
	
	\lipsum[1][1-5]
\end{Center}

\begin{FlushLeft}
	\textbf{\textbackslash justifying in FlushLeft environment}
	
	\lipsum[1][1-5]
	
	{\justifying \textbf{\textbackslash justifying} \lipsum[1][1-5] \par}
	
	\lipsum[1][1-5]
\end{FlushLeft}

\begin{FlushRight}
	\textbf{\textbackslash justifying in FlushRight environment}
	
	\lipsum[1][1-5]

	{\justifying \textbf{\textbackslash justifying} \lipsum[1][1-5] \par}
	
	\lipsum[1][1-5]
\end{FlushRight}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251028132241033.png" alt="png-1" style="width:75%;" />

<br>

**References**

- [ragged2e.pdf](https://mirror.ox.ac.uk/sites/ctan.org/macros/latex/contrib/ragged2e/ragged2e.pdf).
- [Align Contents in LaTeX — Environments `center`, `Center`, `flushleft`, `FlushLeft`, `flushright`, `FlushRight`, and commands `\centering`, `\Centering`, `\raggedleft`, `\RaggedLeft`, `\raggedright`, `\RaggedRight`](/2025-10-28/12-16-33.html).