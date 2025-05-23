---
title: Realize More Section Levels in LaTeX `article` Document Class
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Layout
 - LaTeX TOC
date: 2025-05-19 14:15:18 +0800
last_modified_at: 2025-05-23 16:11:42 +0800
---

In LaTeX `article` document class, there are three commands, `\section`, `\subsection`, and `\subsubsection` to create the title of the first-, second-, and third-level section, respectively, and also two commands, `\paragraph` and `\subparagraph`, to create a paragraph title and a subparagraph title:

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{lipsum}
\newcommand{\mylipsum}{\lipsum[1][1-3]}

\begin{document}
\tableofcontents

\section{Section}
\mylipsum

\subsection{Subsection}
\mylipsum

\subsubsection{Subsubsection}
\mylipsum

\paragraph{Paragraph A} \mylipsum
\subparagraph{Paragraph A-1} \mylipsum
\subparagraph{Paragraph A-2} \mylipsum
\mylipsum

\paragraph{Paragraph B} \mylipsum
\subparagraph{Paragraph B-1} \mylipsum
\subparagraph{Paragraph B-2} \mylipsum
\mylipsum

\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191503093.png)

As can be seen, the TOC can only display the titles of `\section`, `\subsection`, and `\subsubsection`, without including that of `\paragraph` and `\subparagraph`. Besides, in the `acrticle` class there are no more section levels, something like `\subsubsubsection` or `\subsub...subsection`.

Therefore, to realize more section levels and make them appear them in the TOC, we can re-define the command `\paragraph` as the fourth-level section[^1]:

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{lipsum}
\newcommand{\mylipsum}{\lipsum[1][1-3]}

\makeatletter
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}{-2.5ex\@plus -1ex \@minus -.25ex}{1.25ex \@plus .25ex}{\normalfont\normalsize\bfseries}}
\makeatother

\setcounter{secnumdepth}{4} % how many sectioning levels to assign numbers to
\setcounter{tocdepth}{4}    % how many sectioning levels to show in ToC

\begin{document}
\tableofcontents

\section{Section}
\mylipsum

\subsection{Subsection}
\mylipsum

\subsubsection{Subsubsection}
\mylipsum

\paragraph{Paragraph A} \mylipsum
\subparagraph{Paragraph A-1} \mylipsum
\subparagraph{Paragraph A-2} \mylipsum
\mylipsum

\paragraph{Paragraph B} \mylipsum
\subparagraph{Paragraph B-1} \mylipsum
\subparagraph{Paragraph B-2} \mylipsum
\mylipsum

\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191508143.png)

Or, similar to the above method, directly define new commands `\subsubsubsection` and `\subsubsubsubsection`[^2]:

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{lipsum}
\newcommand{\mylipsum}{\lipsum[1][1-3]}

\makeatletter
\newcommand\subsubsubsection{\@startsection{paragraph}{4}{\z@}{-2.5ex\@plus -1ex \@minus -.25ex}{1.25ex \@plus .25ex}{\normalfont\normalsize\bfseries}}
\newcommand\subsubsubsubsection{\@startsection{subparagraph}{5}{\z@}{-2.5ex\@plus -1ex \@minus -.25ex}{1.25ex \@plus .25ex}{\normalfont\normalsize\bfseries}}
\makeatother

\setcounter{secnumdepth}{5} % how many sectioning levels to assign numbers to
\setcounter{tocdepth}{5}    % how many sectioning levels to show in ToC

\begin{document}
\tableofcontents

\section{Section}
\mylipsum

\subsection{Subsection}
\mylipsum

\subsubsection{Subsubsection}
\mylipsum

\subsubsubsection{Paragraph A} \mylipsum
\subsubsubsubsection{Paragraph A-1} \mylipsum
\subsubsubsubsection{Paragraph A-2} \mylipsum
\mylipsum

\subsubsubsection{Paragraph B} \mylipsum
\subsubsubsubsection{Paragraph B-1} \mylipsum
\subsubsubsubsection{Paragraph B-2} \mylipsum
\mylipsum

\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505191513601.png)

<br>

**References**

[^1]: [https://tex.stackexchange.com/a/60218/306224](https://tex.stackexchange.com/a/60218/306224).
[^2]: [https://tex.stackexchange.com/a/569249/306224](https://tex.stackexchange.com/a/569249/306224).
