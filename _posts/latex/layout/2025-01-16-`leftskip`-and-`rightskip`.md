---
title: LaTeX `\leftskip` and `\rightskip` (including a simple introduction to LaTeX glue, or, rubber length)
categories:
 - Design
 - LaTeX
tags:
 - LaTeX Layout
date: 2025-01-16 11:08:46 +0800
last_modified_at: 2025-01-19 15:38:44 +0800
gallery: 
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501192116144.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501192117283.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501192117045.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501192117788.png
gallery1:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121220964.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121220910.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121221703.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121221909.png
---

# `\leftskip` and `\rightskip`

TeX primitive commands `\leftskip` and `\rightskip` are used to set[^1]:

<div class="quote--left" markdown="1">
- `\rightskip`: flexible spacing (glue) inserted to the right of each line in a paragraph.
- `\leftskip`: flexible spacing (glue) inserted to the left of each line in a paragraph.

</div>

```latex
\documentclass{article}
\usepackage[paperheight=16cm,paperwidth=12cm,textwidth=8cm]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\setlength{\lineskip}{3.5pt}
\setlength{\lineskiplimit}{2pt}
\setlength{\parindent}{20pt}
\setlength{\baselineskip}{12pt}

\newcommand{\mytextB}{When \TeX{} typesets a paragraph it treats each individual character as a two-dimensional ``box'' with a specific width, height and depth. \TeX{} uses those box (character) widths to calculate  linebreaks: the best (optimal) points at which to end one line and start another. Each typeset line of text is, in effect, just a ``bigger box'', producing a typeset paragraph which is a series of lines (bigger boxes) stacked vertically, separated by some white space. Words in the paragraph lines are also separated by an amount of white space which varies from line-to-line, as calculated by \TeX{} to achieve the ``optimal'' linebreaks.\par}

\begin{document}
\vspace*{\fill}
	\mytextB
	
	\vspace{5em}
	The value of \verb|\leftskip| is \the\leftskip.\\
	The value of \verb|\rightskip| is \the\rightskip.
\vspace*{\fill}

\newpage
\vspace*{\fill}
	\leftskip 10pt
	\rightskip 0pt plus 1fill
	
	\mytextB
	\vspace{5em}
	The value of \verb|\leftskip| is \the\leftskip.\\
	The value of \verb|\rightskip| is \the\rightskip.
	
\vspace*{\fill}

\newpage
\vspace*{\fill}
	\leftskip 0pt plus 1fill
	\rightskip 10pt

	\mytextB
	
	\vspace{5em}
	The value of \verb|\leftskip| is \the\leftskip.\\
	The value of \verb|\rightskip| is \the\rightskip.
\vspace*{\fill}

\newpage
\vspace*{\fill}
	\leftskip 0pt plus 1fill
	\rightskip 0pt plus 1fill
	
	\mytextB
	
	\vspace{5em}
	The value of \verb|\leftskip| is \the\leftskip.\\
	The value of \verb|\rightskip| is \the\rightskip.
\vspace*{\fill}
\end{document}
```

{% include gallery id="gallery" layout="half" %}



Above four examples respectively show the case of:

**(1) The default value of `\leftskip` and `\rightskip`**

**(2) Making `\leftskip` fixed and `\rightskip` flexible**[^1]

```latex
\leftskip 10pt
\rightskip 0pt plus 1fill
```

<div id="fig-1"></div>

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121112209.png" alt="fig1" style="width:50%;" />

Note: This image and following analogous ones are all from reference[^1].
{: .notice--primary}

**(3) Making `\leftskip` flexible and `\rightskip` fixed**

```latex
\leftskip 0pt plus 1fill
\rightskip 10pt
```

<div id="fig-2"></div>

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121113922.png" alt="fig2" style="width:50%;" />

**(4) Making both `\leftskip` and `\rightskip` flexible**

```latex
\leftskip 0pt plus 1fill
\rightskip 0pt plus 1fill
```

<div id="fig-3"></div>

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121113054.png" alt="fig3" style="width:50%;" />

In this case, both `\leftskip` and `\rightskip` are specified as `0pt plus 1fill`, which makes them <i class="emphasize">equally</i> infinitely flexible. If we want set them as infinitely flexible but <i class="emphasize">not equally</i>, we can use commands like:

```latex
\documentclass{article}
\usepackage[paperheight=16cm,paperwidth=12cm,textwidth=8cm]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\setlength{\lineskip}{3.5pt}
\setlength{\lineskiplimit}{2pt}
\setlength{\parindent}{20pt}
\setlength{\baselineskip}{12pt}

\newcommand{\mytextB}{When \TeX{} typesets a paragraph it treats each individual character as a two-dimensional ``box'' with a specific width, height and depth. \TeX{} uses those box (character) widths to calculate  linebreaks: the best (optimal) points at which to end one line and start another. Each typeset line of text is, in effect, just a ``bigger box'', producing a typeset paragraph which is a series of lines (bigger boxes) stacked vertically, separated by some white space. Words in the paragraph lines are also separated by an amount of white space which varies from line-to-line, as calculated by \TeX{} to achieve the ``optimal'' linebreaks.\par}

\begin{document}
\vspace*{\fill}
	\mytextB
	
	\vspace{5em}
	The value of \verb|\leftskip| is \the\leftskip.\\
	The value of \verb|\rightskip| is \the\rightskip.
\vspace*{\fill}

\newpage
\vspace*{\fill}
\begingroup
	\leftskip 0pt plus 1fill
	\rightskip 0pt plus 1fill
	
	\mytextB
	
	\vspace{5em}
	The value of \verb|\leftskip| is \the\leftskip.\\
	The value of \verb|\rightskip| is \the\rightskip.
\endgroup
\vspace*{\fill}

\newpage
\vspace*{\fill}
\begingroup
	\leftskip 0pt plus 3fill
	\rightskip 0pt plus 1fill
	
	\mytextB
	
	\vspace{5em}
	The value of \verb|\leftskip| is \the\leftskip.\\
	The value of \verb|\rightskip| is \the\rightskip.
\endgroup
\vspace*{\fill}

\newpage
\vspace*{\fill}
\begingroup
	\leftskip 0pt plus 100fill
	\rightskip 0pt plus 1fill
	
	\mytextB
	
	\vspace{5em}
	The value of \verb|\leftskip| is \the\leftskip.\\
	The value of \verb|\rightskip| is \the\rightskip.
\endgroup
\vspace*{\fill}

\end{document}
```

{% include gallery id="gallery1" layout="half" %}

Note: By the way, in this example, the code is put in a group created by `\begingroup` and `\endgroup` to make settings functional locally.
{: .notice--primary}

<br>

# LaTeX glue (rubber length)

Actually, `\leftskip` and `\rightskip` defined like `0pt plus 1fill` etc. are called LaTeX <i class="term">glue</i> (or, <i class="term">rubber length</i>[^2]), a kind of flexible white space which can be stretched or shrunk according to the amount of space required[^1]. A complete definition for a glue incorporates a fixed part, a stretchable part and a shrinkable part[^3]:

```latex
<fixed part> plus <stretchable part> minus <shrinkable part>
```

Besides `\leftskip` and `\rightskip`, there are also some other lengths that can be defined as glue, such as line spacing (green parts in [Fig. 1](#fig-1), [Fig. 2](#fig-2), and [Fig. 3](#fig-3)), paragraph spacing[^4], the white space after words and punctuation marks[^3], and so forth.

<br>

**References**

[^1]: [How to change paragraph spacing in LaTeX](https://www.overleaf.com/learn/latex/Articles/How_to_change_paragraph_spacing_in_LaTeX).
[^2]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, p. 87.
[^3]: [https://tex.stackexchange.com/a/64759/306224](https://tex.stackexchange.com/a/64759/306224).
[^4]: [LaTeX `\parskip` and `parskip` Package](http://127.0.0.1:4000/2025-01-16/11-14-45.html).
