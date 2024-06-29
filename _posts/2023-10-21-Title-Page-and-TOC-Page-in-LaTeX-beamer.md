---
layout: single
title: Title Page and TOC (Table of Contents) Page in LaTeX beamer
date: 2023-10-21 21:49:32 +0800
categories:
 - LaTeX
tags:
 - LaTeX beamer
toc: false
---

While using LaTeX beamer to make slides, the title page and the TOC page won't display without users' declaration.

If want to show title page, we should add related information in preamble area:

```latex
\title{(Title)}
\subtitle{(Subtitle)}
\author{(Author)}
\date{\today}
\institute{(Institute)}
```

and then add the `\titlepage` in the first frame to show title page:

```latex
\begin{frame}
	\titlepage
\end{frame}
```

In the second frame, we could use `\tableofcontents` to show TOC page:

```latex
\begin{frame}
	\tableofcontents
\end{frame}
```

The sections and sub-sections are specified using `\section` and `\subsection` in the following text, and it should be noted that, there should be some frame(s) after `\section` and `\subsection`, otherwise the corresponding section or sub-section title won't show in the TOC page.

A simple-but-complete example shows as follows:

```latex
\documentclass{beamer}
\usetheme{Warsaw}

\title{(Title)}
\subtitle{(Subtitle)}
\author{(Author)}
\date{\today}
\institute{(Institute)}

\begin{document}
\begin{frame}
	\titlepage
\end{frame}

\begin{frame}
	\tableofcontents
\end{frame}

\section{Section I}
\subsection{Subsection I-(A)}
\begin{frame}{Title of Subsection I-(A)}{Subtitle of Subsection I-(A)}
\end{frame}

\subsection{Subsection I-(B)}
\begin{frame}{Title of Subsection I-(B)}{Subtitle of Subsection I-(B)}
\end{frame}

\section{Section II}
\subsection{Subsection II-(A)}
\begin{frame}{Title of Subsection II-(A)}{Subtitle of Subsection II-(A)}
\end{frame}

\subsection{Subsection II-(B)}
\begin{frame}{Title of Subsection II-(B)}{Subtitle of Subsection II-(B)}
\end{frame}

\end{document}
```

![page-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211627066.png)

![page-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211627255.png)

![page-3](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211627439.png)

![page-4](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211627475.png)

![page-5](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211628127.png)

![page-6](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211628101.png)

<br>

**References**

[1] 刘海洋编著. LaTeX入门. 北京: 电子工业出版社, 2013.6.