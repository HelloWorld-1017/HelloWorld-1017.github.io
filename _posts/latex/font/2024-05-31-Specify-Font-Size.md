---
title: Specify Font Size in LaTeX
categories:
 - Design
 - LaTeX
tags:
 - LaTeX beamer
 - LaTeX Font
date: 2024-05-31 12:32:43 +0800
last_modified_at: 2025-01-13 14:56:18 +0800
---

# Font size commands and environments

LaTeX provides several commands to specify font size, such as `\normalsize` (default), `\tiny`, `\scriptsize`, `\large`, and `\huge` etc. One point should be noted is that, the specific font size specified by one command is determined by <i class="emphasize">document class</i> and <i class="emphasize">font size option</i>[^1][^2]. Like for commonly used document class `article` (and also `report`, `book`, and `letter`)[^1], font sizes corresponding to different commands are shown in the following table:

<div id="table-1"></div>

| command                                           | 10pt                            | 11pt                            | 12pt                            |
| ------------------------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- |
| `\tiny`                                           | 5 pt                            | 6 pt                            | 6 pt                            |
| `\scriptsize`                                     | 7 pt                            | 8 pt                            | 8 pt                            |
| `\footnotesize`                                   | 8 pt                            | 9 pt                            | 10 pt                           |
| `\small`                                          | 9 pt                            | 10 pt                           | 11 pt                           |
| `\normalsize` <font color="blue">(default)</font> | <font color="blue">10 pt</font> | <font color="blue">11 pt</font> | <font color="blue">12 pt</font> |
| `\large`                                          | 12 pt                           | 12 pt                           | 14 pt                           |
| `\Large`                                          | 14 pt                           | 14 pt                           | 17 pt                           |
| `\LARGE`                                          | 17 pt                           | 17 pt                           | 20 pt                           |
| `\huge`                                           | 20 pt                           | 20 pt                           | 25 pt                           |
| `\Huge`                                           | 25 pt                           | 25 pt                           | 25 pt                           |

<div class="notice--primary" markdown="1">

For Chinese font, there is also[^2]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411091524400.png" alt="image-20241109152407316" style="width:50%;" />

</div>

and for `beamer` class:

| command                                           | 8pt                            | 9pt                            | 10pt                            | 11pt                            | 12pt                            | 14pt                            | 17pt                            | 20pt                            |
| ------------------------------------------------- | ------------------------------ | ------------------------------ | ------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- | ------------------------------- |
| `\tiny`                                           | 5 pt                           | 5 pt                           | 5 pt                            | 6 pt                            | 6 pt                            | 6 pt                            | 8 pt                            | 10 pt                           |
| `\scriptsize`                                     | 5 pt                           | 6 pt                           | 7 pt                            | 8 pt                            | 8 pt                            | 8 pt                            | 10 pt                           | 12 pt                           |
| `\footnotesize`                                   | 6 pt                           | 7 pt                           | 8 pt                            | 9 pt                            | 10 pt                           | 10 pt                           | 12 pt                           | 14 pt                           |
| `\small`                                          | 7 pt                           | 8 pt                           | 9 pt                            | 10 pt                           | 11 pt                           | 12 pt                           | 14 pt                           | 17 pt                           |
| `\normalsize` <font color="blue">(default)</font> | <font color="blue">8 pt</font> | <font color="blue">9 pt</font> | <font color="blue">10 pt</font> | <font color="blue">11 pt</font> | <font color="blue">12 pt</font> | <font color="blue">14 pt</font> | <font color="blue">17 pt</font> | <font color="blue">20 pt</font> |
| `\large`                                          | 10 pt                          | 10 pt                          | 12 pt                           | 12 pt                           | 14 pt                           | 17 pt                           | 20 pt                           | 25 pt                           |
| `\Large`                                          | 11 pt                          | 11 pt                          | 14 pt                           | 14 pt                           | 17 pt                           | 20 pt                           | 25 pt                           | 29.86 pt                        |
| `\LARGE`                                          | 12 pt                          | 12 pt                          | 17 pt                           | 17 pt                           | 20 pt                           | 25 pt                           | 29.86 pt                        | 35.83 pt                        |
| `\huge`                                           | 14 pt                          | 14 pt                          | 20 pt                           | 20 pt                           | 25 pt                           | 29.86 pt                        | 35.83 pt                        | 42.99 pt                        |
| `\Huge`                                           | 17 pt                          | 17 pt                          | 25 pt                           | 25 pt                           | 25 pt                           | 35.83 pt                        | 42.99 pt                        | 51.59 pt                        |

In addition, it should be noted that, <i class="emphasize">font size affects line spacing</i>. So, take `article` class, following examples reproduce [Table I](#table-1) and meanwhile show the additional information of line spacing for each case.

**(1) font size option: 10 pt (default)**

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{fontspec}
\makeatletter
\newcommand{\fsize}{\f@size pt}
\makeatother

\begin{document}
\thispagestyle{empty}
\begin{table}
	\centering
	\begin{tabular}{llll}
		\hline
		\textbf{Font size command} & \textbf{Text} & \textbf{Font size} & \textbf{Line spacing} \\ \hline
		\verb|\tiny| & {\tiny Lorem ipsum} & {\tiny\fsize} & {\tiny\the\baselineskip}\\ \hline
		\verb|\scriptsize| & {\scriptsize Lorem ipsum} & {\scriptsize\fsize} & {\scriptsize\the\baselineskip}\\ \hline
		\verb|\small| & {\small Lorem ipsum} & {\small\fsize} & {\small\the\baselineskip}\\ \hline
		\verb|\normalsize| & {\normalsize Lorem ipsum} & {\normalsize\fsize} & {\normalsize\the\baselineskip}\\ \hline
		\verb|\large| & {\large Lorem ipsum} & {\large\fsize} & {\large\the\baselineskip}\\ \hline
		\verb|\Large| & {\Large Lorem ipsum} & {\Large\fsize} & {\Large\the\baselineskip}\\ \hline
		\verb|\LARGE| & {\LARGE Lorem ipsum} & {\LARGE\fsize} & {\LARGE\the\baselineskip}\\ \hline
		\verb|\huge| & {\huge Lorem ipsum} & {\huge\fsize} & {\huge\the\baselineskip}\\ \hline
		\verb|\Huge| & {\Huge Lorem ipsum} & {\Huge\fsize} & {\Huge\the\baselineskip}\\ \hline
	\end{tabular}
\end{table}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131345191.png" alt="image-20250113134548054" style="width:50%;" />

**(2) font size option: 11 pt**

```latex
\documentclass[a4paper,11pt]{article}
% ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131346394.png" alt="image-20250113134651270" style="width:50%;" />

**(3) font size option: 12 pt**

```latex
\documentclass[a4paper,12pt]{article}
% ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131347022.png" alt="image-20250113134736928" style="width:50%;" />

<div class="notice--primary" markdown="1">

According to above results, for `\normalize` font (default) of each document, we have:

| Font size option of document | Font size    | Line spacing | Line spacing/Font size |
| ---------------------------- | ------------ | ------------ | ---------------------- |
| 1o pt                        | 10 pt        | 12 pt        | 1.2                    |
| 11 pt                        | 10.95 pt[^4] | 13.6 pt      | 1.24                   |
| 12 pt                        | 12 pt        | 14.5 pt      | 1.21                   |

As can be seen, the ratio of line spacing and font size approximates 1.2.[^5] 

</div>

And we can use corresponding environment of above commands[^3], such as `LARGE` environment in 10 pt document:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{fontspec}

\makeatletter
\newcommand{\fsize}{\f@size pt}
\makeatother

\begin{document}
\thispagestyle{empty}

\begin{LARGE}
	Lorem ipsum.\\
	Font size: \fsize \\
	Line spacing: \the\baselineskip \\
\end{LARGE}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131403769.png" alt="image-20250113140339635" style="width:50%;" />

and 12 pt document:

```latex
\documentclass[a4paper,12pt]{article}
% ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131404279.png" alt="image-20250113140429139" style="width:50%;" />

<br>

# The `\fontsize` and `\selectfont` commands

We can use commands `\fontsize` and `\selectfont` to make a more precise and flexible specification for font size and line spacing, such as[^3]:

<div class="quote--left" markdown="1">

- `\fontsize{6}{8}\selectfont`: use 6pt text with baselines spaced at 8pt
- `\fontsize{8}{9}\selectfont`: use 8pt text with baselines spaced at 9pt
- `\fontsize{12}{13.5}\selectfont`: use 12pt text with baselines spaced at 13.5pt

</div>

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{fontspec}
\makeatletter
\newcommand{\fsize}{\f@size pt}
\makeatother

\begin{document}
\thispagestyle{empty}
\begin{table}
	\centering
	\begin{tabular}{llll}
		\hline
		\textbf{Font size command} & \textbf{Text} & \textbf{Font size} & \textbf{Line spacing} \\ \hline
		\verb|\fontsize{6}{8}\selectfont| & {\fontsize{6}{8}\selectfont Lorem ipsum} & {\fontsize{6}{8}\selectfont\fsize} & {\fontsize{6}{8}\selectfont\the\baselineskip}\\ \hline
		\verb|\fontsize{8}{9}\selectfont| & {\fontsize{8}{9}\selectfont Lorem ipsum} & {\fontsize{8}{9}\selectfont\fsize} & {\fontsize{8}{9}\selectfont\the\baselineskip}\\ \hline
		\verb|\fontsize{12}{13.5}\selectfont| & {\fontsize{12}{13.5}\selectfont Lorem ipsum} & {\fontsize{12}{13.5}\selectfont\fsize} & {\fontsize{12}{13.5}\selectfont\the\baselineskip}\\ \hline
	\end{tabular}
\end{table}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131414445.png" alt="image-20250113141455322" style="width:50%;" />

and this method isn’t affected by font size option of the document.

Besides, the text lines wouldn’t overlap even if the specified line spacing is extremely smaller than the font size, for example:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{fontspec}
\makeatletter
\newcommand{\fsize}{\f@size pt}
\makeatother

\usepackage{lipsum}

\begin{document}
\thispagestyle{empty}

\fontsize{12}{2}\selectfont \lipsum[1-3]
\vspace{2em}

Font size: \fsize; Line spacing: \the\baselineskip\\
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131428803.png" alt="image-20250113142834612" style="width:50%;" />

<br>

**References**

[^1]: [LaTeX font size](https://www.sascha-frank.com/latex-font-size.html).
[^2]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 82-85.
[^3]: [How do I adjust the font size?](https://www.overleaf.com/learn/latex/Questions/How_do_I_adjust_the_font_size%3F#LaTeX_font_size_commands).
[^4]: [Why does LaTeX use 10.95pt text when the 11pt option is selected. : r/LaTeX](https://www.reddit.com/r/LaTeX/comments/ihle9h/why_does_latex_use_1095pt_text_when_the_11pt/).
[^5]: [How to change paragraph spacing in LaTeX](https://www.overleaf.com/learn/latex/Articles/How_to_change_paragraph_spacing_in_LaTeX#Using_LaTeX_packages:_setspace_and_parskip).
