---
title: <font color="red">Specify Line Spacing in LaTeX</font>
categories:
 - LaTeX
tags:
 - LaTeX Layout
date: 2025-03-05 21:26:55 +0800
last_modified_at: 2025-03-05 21:26:55 +0800
gallery:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151818562.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151818737.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151819052.png
gallery1:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151837787.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151838198.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151839512.png
gallery2:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151914278.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151915453.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151915296.png
gallery3:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151942453.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151943388.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151943750.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151943418.png
gallery4:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151946125.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151947151.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151947484.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151947324.png
gallery5:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151949127.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151949380.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151949018.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501151949193.png
gallery6:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131105223.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501131105511.png
gallery7:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121303731.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121303142.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121305646.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121305518.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121306768.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121306511.png
---

# Introduction

In LaTeX, each typeset line has a <i class="term">baseline</i>, and the baseline-to-baseline distance is the <i class="term">line spacing</i>[^2], which is controlled by the `\baselineskip` command. In the following figure from the article[^1], the dotted lines represent baselines, and line spacing is the space between the adjacent two.

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121241189.png" alt="fig3" style="width:50%;" />

In the above figure, the typeset line is denoted as gray box, whose upper boundary and lower boundary specify the height of typeset line. As can be seen, the position relative to the baseline of each <i class="term">character box</i> varies, so the height of each typeset line is different. This feature leads to two results. The first is that, although the baseline lies within the gray box representing typeset line, their relative positions is NOT fixed. And another one is, although every line spacing is identical, if without special cases, the distance between the lower boundary of the former typeset line and the upper boundary of the latter typeset line, i.e. green box in the figure, is a flexible white space, or more accurately, a glue (See ==blog xxx, (talk about glue, mention `\leftskip` and `\rightskip`)==; ). So, we should note that, the distance we use and set most is the <i class="term">line spacing</i>, rather than the “glue”. And TeX will try to maintain the line spacing (i.e. inter-baseline distance) constant at most, still rather than the “glue”.

A series of images from the article[^1] really illustrate this point.

{% include gallery id="gallery7" layout="half" %}

<mark>LuaTex</mark> <mark>By the way, automatically calculated spaces between characters in a line.</mark>

<br>

As for line spacing, we should know that, font specifications can affect it, but this is only limited to font size. The following example shows that The font size directly affects line spacing[^2], but font family, typeface, font shape, and font series don’t[^4][^5].

```latex
\documentclass[a4paper,landscape]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\setlength{\lineskip}{3.5pt}
\setlength{\lineskiplimit}{2pt}
\setlength{\parindent}{20pt}
\setlength{\baselineskip}{12pt}

\usepackage{lipsum}
\newcommand{\mytext}{\lipsum[1][1-4]}

\usepackage{fontspec}
\makeatletter
\newcommand{\ffamily}{\f@family}
\newcommand{\fshape}{\f@shape}
\newcommand{\fseries}{\f@series}
\newcommand{\fsize}{\f@size}
\makeatother

\begin{document}
\newpage
\begin{minipage}{\textwidth}
For different font sizes:
	\begin{enumerate}
		\item {\tiny \verb*|\tiny|: The font size is \fsize\ pt, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\scriptsize \verb*|\scriptsize|: The font size is \fsize\ pt, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\footnotesize \verb*|\footnotesize|: The font size is \fsize\ pt, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\small \verb*|\small|: The font size is \fsize\ pt, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\normalsize \verb*|\normalsize|: The font size is \fsize\ pt, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\large \verb*|\large|: The font size is \fsize\ pt, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\Large \verb*|\Large|: The font size is \fsize\ pt, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\LARGE \verb*|\LARGE|: The font size is \fsize\ pt, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\huge \verb*|\huge|: The font size is \fsize\ pt, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\Huge \verb*|\Huge|: The font size is \fsize\ pt, The value of \verb|\baselineskip| is \the\baselineskip}.
	\end{enumerate}
\end{minipage}

\newpage
\begin{minipage}{\textwidth}
For different font families:
	\begin{enumerate}
		\item {\rmfamily \verb*|\rmfamily|: The font family is \ffamily, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\sffamily \verb*|\sffamily|: The font family is \ffamily, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\ttfamily \verb*|\ttfamily|: The font family is \ffamily, The value of \verb|\baselineskip| is \the\baselineskip}.
	\end{enumerate}
\end{minipage}

\vspace{2em}

\begin{minipage}{\textwidth}
For different font typefaces:
	\begin{enumerate}
		\item {\fontfamily{lmdh}\selectfont \verb*|\fontfamily{lmdh}\selectfont|: The font family is \ffamily, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\fontfamily{phv}\selectfont \verb*|\fontfamily{phv}\selectfont|: The font family is \ffamily, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\fontfamily{courier}\selectfont \verb*|\fontfamily{courier}\selectfont|: The font family is \ffamily, The value of \verb|\baselineskip| is \the\baselineskip}.
	\end{enumerate}
\end{minipage}

\vspace{2em}

\begin{minipage}{\textwidth}
For different font shapes:
	\begin{enumerate}
		\item {\upshape \verb*|\upshape|: The font shape is \fshape, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\itshape \verb*|\itshape|: The font shape is \fshape, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\slshape \verb*|\slshape|: The font shape is \fshape, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\scshape \verb*|\scshape|: The font shape is \fshape, The value of \verb|\baselineskip| is \the\baselineskip}.
	\end{enumerate}
\end{minipage}

\vspace{2em}

\begin{minipage}{\textwidth}
For different font series:
	\begin{enumerate}
		\item {\mdseries \verb*|\mdseries|: The font series is \fseries, The value of \verb|\baselineskip| is \the\baselineskip}.
		\item {\bfseries \verb*|\bfseries|: The font shape is \fseries, The value of \verb|\baselineskip| is \the\baselineskip}.
	\end{enumerate}
\end{minipage}
\end{document}
```

{% include gallery id="gallery6" layout="half" %}

==引用那个 blog==

Font size commands will accordingly change the line spacing, and there is a saying that , “by default, line spacing is 1.2 times as big as font size”[^2]. But it seem that, the multiplier relationship of 1.2 times is not so strict as can be seen from the above figure.

<br>

# Several methods to adjust line spacing





1. Method 1: Using `\baselineskip`;
2. Method 2: `\linespread{scale}` command;
3. Method 3: `\linespread` command
4. Method 4: `setspace` package.

## `\baselineskip` 

Methods[^1]:

1. Syntax 1: `\setlength{\baselineskip}{<line_spacing}>`.
2. Syntax 2: `\baselineskip <line_spacing>`.

<br>

For the document of default font size option (`10pt`):

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{lipsum}
\newcommand{\mytext}{\lipsum[1][1-3]}

\usepackage{fontspec}
\makeatletter
\newcommand{\fsize}{\f@size pt}
\makeatother

\linespread{1.2}

\begin{document}
\thispagestyle{empty}
The font size is \fsize.

\vfill
\begin{minipage}{\textwidth}
	Original:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|\setlength{\baselineskip}{15pt}| command:\\
	\setlength{\baselineskip}{15pt}
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb|\baselineskip 17pt| command:\\
	\baselineskip 17pt
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb|\baselineskip 33pt| command:\\
	\baselineskip 33pt
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}
\vfill
\end{document}
```

{% include gallery id="gallery2" layout="third" %}

<br>

## `\baselinestretch`

<div class="quote--left" markdown="1">
`\baselinestretch`: a command which stores a numeric factor used to calculate the value of `\baselineskip` when a font is selected. It has a default value of `1`.
**`\baselinestretch`**: this command stores a scaling factor used to multiply (scale) the current value of [`\baselineskip`](https://www.overleaf.com/learn/latex/Articles/How_to_change_paragraph_spacing_in_LaTeX#\baselineskip_(TeX_primitive)). That scaling is typically applied the *next time* a font-selection command is used--such as `\selectfont`. To change the value stored by `\baselinestretch` you should write `\renewcommand{\baselinestretch}{scale}`.
**Note**: If you write `\renewcommand{\baselinestretch}{scale}` in the body of the document, the new value of `\baselinestretch` [will not take immediate effect](https://tex.stackexchange.com/questions/241120/why-does-changing-baselinestretch-not-change-line-spacing): the new `scale` factor is stored for future use. To immediately use/apply the new`scale` value, write `\selectfont` as demonstrated in the [code fragment below](https://www.overleaf.com/learn/latex/Articles/How_to_change_paragraph_spacing_in_LaTeX#Demonstrating_\baselinestretch).

</div>

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{lipsum}
\newcommand{\mytext}{\lipsum[1][1-3]}

\usepackage{fontspec}
\makeatletter
\newcommand{\fsize}{\f@size pt}
\makeatother

\renewcommand{\baselinestretch}{1.2}

\begin{document}
\thispagestyle{empty}
The font size is \fsize.

\vfill
\begin{minipage}{\textwidth}
	\verb*|\renewcommand{\baselinestretch}{1.2}| in the preamble:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\renewcommand{\baselinestretch}{1}\selectfont
\begin{minipage}{\textwidth}
	\verb*|\renewcommand{\baselinestretch}{1}\selectfont| in the document body:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\renewcommand{\baselinestretch}{1.5}\selectfont
\begin{minipage}{\textwidth}
	\verb*|\renewcommand{\baselinestretch}{1.5}\selectfont| in the document body:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\renewcommand{\baselinestretch}{2}\selectfont
\begin{minipage}{\textwidth}
	\verb*|\renewcommand{\baselinestretch}{2}\selectfont| in the document body:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\renewcommand{\baselinestretch}{3}\selectfont
\begin{minipage}{\textwidth}
	\verb*|\renewcommand{\baselinestretch}{3}\selectfont| in the document body:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}
\vfill
\end{document}
```

{% include gallery id="gallery" layout="third" %}

## `\linespread`

<div class="quote--left" markdown="1">
`\linespread{scale}`: can be used to change [`\baselineskip`](https://www.overleaf.com/learn/latex/Articles/How_to_change_paragraph_spacing_in_LaTeX#\baselineskip_(TeX_primitive)) without affecting the current font size. This command sets `\baselinestretch` to `scale` which subsequently changes `\baselineskip` to `scale × \baselineskip`. However, that scaling also does not take place immediately unless the `\linespread` command is used in the document preamble. If `\linespread` used in the document body, it takes effect after the next font sizing/selection command is used.

</div>

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{lipsum}
\newcommand{\mytext}{\lipsum[1][1-3]}

\usepackage{fontspec}
\makeatletter
\newcommand{\fsize}{\f@size pt}
\makeatother

\linespread{1.2}

\begin{document}
\thispagestyle{empty}
The font size is \fsize.

\vfill
\begin{minipage}{\textwidth}
	\verb*|\linespread{1.2}| in the preamble:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\linespread{1}\selectfont
\begin{minipage}{\textwidth}
	\verb*|\linespread{1}\selectfont| in the document body:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\linespread{1.5}\selectfont
\begin{minipage}{\textwidth}
	\verb*|\linespread{1.5}\selectfont| in the document body:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\linespread{2}\selectfont
\begin{minipage}{\textwidth}
	\verb*|\linespread{2}\selectfont| in the document body:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\linespread{3}\selectfont
\begin{minipage}{\textwidth}
	\verb*|\linespread{3}\selectfont| in the document body:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}
\vfill
\end{document}
```

{% include gallery id="gallery1" layout="third" %}

<br>

| Font size option: 10pt                                       | font size (pt) | line spacing (pt) | line spacing/font size |
| ------------------------------------------------------------ | -------------- | ----------------- | ---------------------- |
| `\renewcommand{\baselinestretch}{1.2}`<br />(or `\linespread{1.2}`) | 10             | 14.40             | 1.44 ($=1.2\times1.2$) |
| `\renewcommand{\baselinestretch}{1}\selectfont`<br />(or `\linespread{1}\selectfont`) | 10             | 12                | 1.2                    |
| `\renewcommand{\baselinestretch}{1.5}\selectfont`<br />(or `\linespread{1.5}\selectfont`) | 10             | 18                | 1.8 ($=1.2\times1.5$)  |
| `\renewcommand{\baselinestretch}{2}\selectfont`<br />(or `\linespread{2}\selectfont`) | 10             | 24                | 2.4 ($=1.2\times2$)    |
| `\renewcommand{\baselinestretch}{3}\selectfont`<br />(or `\linespread{3}\selectfont`) | 10             | 36                | 3.6 ($=1.2\times3$)    |

<br>

| Font size option: 11pt                                       | font size (pt) | line spacing (pt) | line spacing/font size        |
| ------------------------------------------------------------ | -------------- | ----------------- | ----------------------------- |
| `\renewcommand{\baselinestretch}{1.2}`<br />(or `\linespread{1.2}`) | 10.95          | 16.32             | 1.49 ($\approx1.24\times1.2$) |
| `\renewcommand{\baselinestretch}{1}\selectfont`<br />(or `\linespread{1}\selectfont`) | 10.95          | 13.6              | 1.24                          |
| `\renewcommand{\baselinestretch}{1.5}\selectfont`<br />(or `\linespread{1.5}\selectfont`) | 10.95          | 20.40             | 1.86 ($=1.24\times1.5$)       |
| `\renewcommand{\baselinestretch}{2}\selectfont`<br />(or `\linespread{2}\selectfont`) | 10.95          | 27.20             | 2.48 ($=1.24\times2$)         |
| `\renewcommand{\baselinestretch}{3}\selectfont`<br />(or `\linespread{3}\selectfont`) | 10.95          | 40.80             | 3.72 ($=1.24\times3$)         |

The reason for the anomalous value of `10.95pt`, and not exactly `11pt`, is nicely explained in this [reddit post](https://www.reddit.com/r/LaTeX/comments/ihle9h/why_does_latex_use_1095pt_text_when_the_11pt/).

<br>

| Font size option: 11pt                                       | font size (pt) | line spacing (pt) | line spacing/font size        |
| ------------------------------------------------------------ | -------------- | ----------------- | ----------------------------- |
| `\renewcommand{\baselinestretch}{1.2}`<br />(or `\linespread{1.2}`) | 12             | 17.40             | 1.45 ($\approx1.21\times1.2$) |
| `\renewcommand{\baselinestretch}{1}\selectfont`<br />(or `\linespread{1}\selectfont`) | 12             | 14.5              | 1.21                          |
| `\renewcommand{\baselinestretch}{1.5}\selectfont`<br />(or `\linespread{1.5}\selectfont`) | 12             | 21.75             | 1.81 ($\approx1.21\times1.5$) |
| `\renewcommand{\baselinestretch}{2}\selectfont`<br />(or `\linespread{2}\selectfont`) | 12             | 29.0              | 2.42 ($=1.21\times2$)         |
| `\renewcommand{\baselinestretch}{3}\selectfont`<br />(or `\linespread{3}\selectfont`) | 12             | 43.5              | 3.63 ($=1.21\times3$)         |

<br>

## `setspace` package



<div class="quote--left" markdown="1">

- the commands `\singlespacing`, `\onehalfspacing` and `\doublespacing` can be used in the document preamble, or within the document body to change spacing in part, or all, of your document;
- the `\setstretch{baselinestretch}` command sets a custom spacing (via changes to `\baselinestretch`)—it can also be used in the document preamble;
- the environments `singlespace`, `singlespace*`, `onehalfspace` and `doublespace` allow line spacing to be changed for selected parts of the document’s text;
- the `\SetSinglespace{value}` command uses value to adjust single-line spacing to accommodate line spacing of text typeset with fonts whose character shapes (“glyphs”) are relatively small, or large, for the given point size. See the section Brief notes on fonts and point size for an illustration demonstrating the variation of font glyph size for a given point size;
- the `spacing` environment provides custom spacing and requires one argument: the `\baselinestretch` value to use;

</div>

The following example shows the results of setting different font sizes and line spacing combinations by different `setspace` commands and environment:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{lipsum}
\newcommand{\mytext}{\lipsum[1][1-3]}

\usepackage{fontspec}
\makeatletter
\newcommand{\fsize}{\f@size pt}
\makeatother

\usepackage{setspace}

\begin{document}
\thispagestyle{empty}
The font size is \fsize.

\vfill
\begin{minipage}{\textwidth}
	Original:\\
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|\singlespacing| command:\\
	\singlespacing
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|\onehalfspacing| command:\\
	\onehalfspacing
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|\doublespacing| command:\\
	\doublespacing
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\newpage
\thispagestyle{empty}
\vfill
\begin{minipage}{\textwidth}
	\verb*|\setstretch{1}| command:\\
	\setstretch{1}
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|\setstretch{1.5}| command:\\
	\setstretch{1.5}
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|\setstretch{1.7}| command:\\
	\setstretch{1.7}
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|\setstretch{2}| command:\\
	\setstretch{2}
	\mytext\\
	The value of \verb|\baselineskip| is \the\baselineskip.
\end{minipage}
\vfill

\newpage
\thispagestyle{empty}
\vfill
\begin{minipage}{\textwidth}
	\verb*|singlespace| environment:\\
	\begin{singlespace}
		\mytext\\
		The value of \verb|\baselineskip| is \the\baselineskip.
	\end{singlespace}
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|singlespace*| environment:\\
	\begin{singlespace*}
		\mytext\\
		The value of \verb|\baselineskip| is \the\baselineskip.
	\end{singlespace*}
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|onehalfspace| environment:\\
	\begin{onehalfspace}
		\mytext\\
		The value of \verb|\baselineskip| is \the\baselineskip.
	\end{onehalfspace}
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|doublespace| environment:\\
	\begin{doublespace}
		\mytext\\
		The value of \verb|\baselineskip| is \the\baselineskip.
	\end{doublespace}
\end{minipage}

\newpage
\thispagestyle{empty}
\vfill
\begin{minipage}{\textwidth}
	\verb*|spacing{1.5}| environment:\\
	\begin{spacing}{1.5}
		\mytext\\
		The value of \verb|\baselineskip| is \the\baselineskip.
	\end{spacing}
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|spacing{1.7}| environment:\\
	\begin{spacing}{1.7}
		\mytext\\
		The value of \verb|\baselineskip| is \the\baselineskip.
	\end{spacing}
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|spacing{2}| environment:\\
	\begin{spacing}{2}
		\mytext\\
		The value of \verb|\baselineskip| is \the\baselineskip.
	\end{spacing}
\end{minipage}

\vfill
\begin{minipage}{\textwidth}
	\verb*|spacing{3.3}| environment:\\
	\begin{spacing}{3.3}
		\mytext\\
		The value of \verb|\baselineskip| is \the\baselineskip.
	\end{spacing}
\end{minipage}
\end{document}
```

{% include gallery id="gallery3" layout="half" %}

11 pt document:

{% include gallery id="gallery4" layout="half" %}

12 pt document:

{% include gallery id="gallery5" layout="half" %}

For the document with different font size options, we can record the font size, line spacing, and the ratio of line spacing and font size for each case in the following three tables respectively:

| Font size option: 10 pt    | font size | line spacing | line spacing/font size         |
| -------------------------- | --------- | ------------ | ------------------------------ |
| Original                   | 10        | 12           | <font color="blue">1.2</font>  |
| `\singlespacing` command   | 10        | 12           | <font color="blue">1.2</font>  |
| `\onehalfspacing` command  | 10        | 15           | <font color="green">1.5</font> |
| `\doublespacing` command   | 10        | 20           | <font color="green">2</font>   |
| `\setstretch{1}` command   | 10        | 12           | <font color="blue">1.2</font>  |
| `\setstretch{1.5}` command | 10        | 18           | 1.8 $\approx 1.5\times1.2$     |
| `\setstretch{1.7}` command | 10        | 20.40        | 2.04 $\approx 1.7\times1.2$    |
| `\setstretch{2}` command   | 10        | 24.0         | 2.4 $\approx 2\times1.2$       |
| `singlespace` environment  | 10        | 12.0         | <font color="blue">1.2</font>  |
| `singlespace*` environment | 10        | 12.0         | <font color="blue">1.2</font>  |
| `onehalfspace` environment | 10        | 15.0         | <font color="green">1.5</font> |
| `doublespace` environment  | 10        | 20.0         | <font color="green">2</font>   |
| `spacing{1.5}` environment | 10        | 18.0         | 1.8 $\approx 1.5\times1.2$     |
| `spacing{1.7}` environment | 10        | 20.40        | 2.04 $\approx 1.7\times1.2$    |
| `spacing{2}` environment   | 10        | 24.0         | 2.4 $\approx 2\times1.2$       |
| `spacing{3.3}` environment | 10        | 39.60        | 3.96 $\approx 3.3\times1.2$    |

<br>


| Font size option: 11 pt    | font size | line spacing | line spacing/font size          |
| -------------------------- | --------- | ------------ | ------------------------------- |
| Original                   | 10.95     | 13.6         | <font color="blue">1.24</font>  |
| `\singlespacing` command   | 10.95     | 13.6         | <font color="blue">1.24</font>  |
| `\onehalfspacing` command  | 10.95     | 16.50        | <font color="green">1.51</font> |
| `\doublespacing` command   | 10.95     | 22.00        | <font color="green">2.00</font> |
| `\setstretch{1}` command   | 10.95     | 13.6         | <font color="blue">1.24</font>  |
| `\setstretch{1.5}` command | 10.95     | 20.40        | 1.86 $\approx 1.5\times1.24$    |
| `\setstretch{1.7}` command | 10.95     | 23.12        | 2.11 $\approx 1.7\times1.24$    |
| `\setstretch{2}` command   | 10.95     | 27.20        | 2.48 $\approx 2\times1.24$      |
| `singlespace` environment  | 10.95     | 13.6         | <font color="blue">1.24</font>  |
| `singlespace*` environment | 10.95     | 13.6         | <font color="blue">1.24</font>  |
| `onehalfspace` environment | 10.95     | 16.50        | <font color="green">1.51</font> |
| `doublespace` environment  | 10.95     | 22.00        | <font color="green">2.00</font> |
| `spacing{1.5}` environment | 10.95     | 20.40        | 1.86 $\approx 1.5\times1.24$    |
| `spacing{1.7}` environment | 10.95     | 23.12        | 2.11 $\approx 1.7\times1.24$    |
| `spacing{2}` environment   | 10.95     | 27.20        | 2.48 $\approx 2\times1.24$      |
| `spacing{3.3}` environment | 10.95     | 44.88        | 4.10 $\approx 3.3\times1.24$    |

<br>

| Font size option: 12 pt    | font size | line spacing | line spacing/font size         |
| -------------------------- | --------- | ------------ | ------------------------------ |
| Original                   | 12        | 14.5         | <font color="blue">1.21</font> |
| `\singlespacing` command   | 12        | 14.5         | <font color="blue">1.21</font> |
| `\onehalfspacing` command  | 12        | 18.0         | <font color="green">1.5</font> |
| `\doublespacing` command   | 12        | 24.00        | <font color="green">2</font>   |
| `\setstretch{1}` command   | 12        | 14.5         | <font color="blue">1.21</font> |
| `\setstretch{1.5}` command | 12        | 21.75        | 1.81 $\approx 1.5\times1.21$   |
| `\setstretch{1.7}` command | 12        | 24.65        | 2.05 $\approx 1.7\times1.21$   |
| `\setstretch{2}` command   | 12        | 29.0         | 2.42 $\approx 2\times1.21$     |
| `singlespace` environment  | 12        | 14.5         | <font color="blue">1.21</font> |
| `singlespace*` environment | 12        | 14.5         | <font color="blue">1.21</font> |
| `onehalfspace` environment | 12        | 18.0         | <font color="green">1.5</font> |
| `doublespace` environment  | 12        | 24.0         | <font color="green">2</font>   |
| `spacing{1.5}` environment | 12        | 21.75        | 1.81 $\approx 1.5\times1.21$   |
| `spacing{1.7}` environment | 12        | 24.65        | 2.05 $\approx 1.7\times1.21$   |
| `spacing{2}` environment   | 12        | 29.0         | 2.42 $\approx 2\times1.21$     |
| `spacing{3.3}` environment | 12        | 47.85        | 3.99 $\approx 3.3\times1.21$   |

Then, we can conclude that:

1. Although different font size options leading different font size and result of a certain command (or environment), there is a certain pattern in the ratio of line spacing and font size; take the document with default font size `10pt`,
2. The original ratio is 1.2, and `\singlespacing` command, `\setstretch{1}` command, `singlespace` environment, `singlespace*` environment, and `spacing{1}` environment have the same ratio.
3. The ratio of `\onehalfspacing` command (and so for `\doublespacing` command) is the same as that of `onehalfspace` environment (`doublespace` environment). And for them, the multiple of the ratio is relative to the font size, rather than the original line spacing (==这里注意，其实这个值就是`\baselineskip`==).
4. The ratio of `\setstretch{baselinestretch}` command is the same as that of `spacing{baselinestretch}` environment. And for them, the multiple of the ratio is relative to the original line spacing, rather than font size.

<div class="quote--left" markdown="1">

the ratio of `\baselineskip` and font size is close to 1.2. That ratio value designates single-line spacing and provides the basis for line-spacing calculations used by the `setspace` package.

</div>

<br>

# Appendix

## `\SetSinglespace`

再测试一下setspace package这个command：`\SetSinglespace{value}`, [How to change paragraph spacing in LaTeX: Using the `\SetSinglespace` command](https://www.overleaf.com/learn/latex/Articles/How_to_change_paragraph_spacing_in_LaTeX#Using_the_\SetSinglespace_command).

```latex
\documentclass[a4paper]{article}
\pagestyle{empty}
\usepackage{setspace,lipsum,fontspec}

\newcommand{\mytext}{\lipsum[1][1-3]}

\SetSinglespace{1.1}\singlespacing

\begin{document}
\section*{Computer Modern default single spacing}
\mytext (\the\baselineskip)
	 
\setmainfont{TeX Gyre Pagella}
\section*{TeX Gyre Pagella default single line spacing}
\mytext (\the\baselineskip)

\section*{TeX Gyre Pagella adjusted single line spacing}
Note: we need to issue \verb|\singlespacing| after writing \verb|\SetSinglespace{1.1}|
\SetSinglespace{2}\singlespacing
\begin{singlespace*} 
	\mytext (\the\baselineskip)
\end{singlespace*}

\mytext (\the\baselineskip)
\end{document}
```

<br>

**References**

[^1]: [How to change paragraph spacing in LaTeX](https://www.overleaf.com/learn/latex/Articles/How_to_change_paragraph_spacing_in_LaTeX).
[^2]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 82-85.
[^4]: [Specify Font Family, Font Shape, and Font Series in LaTeX](/2025-01-12/14-34-58.html).
[^5]: [Use Commands to Get Font Information in LaTeX](/2025-01-12/21-17-50.html).
