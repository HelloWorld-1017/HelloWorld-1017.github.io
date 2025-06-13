---
title: Force Floats Appear Where They Are Defined in LaTeX
categories:
 - LaTeX
tags:
 - LaTeX endfloat
 - LaTeX Figure
 - LaTeX flafter
 - LaTeX float
 - LaTeX placeins
 - LaTeX Table
date: 2025-06-11 12:18:27 +0800
last_modified_at: 2025-06-13 13:47:49 +0800

gallery:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121227001.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121227300.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121227144.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121227563.png

gallery1: 
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121231274.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121231181.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121231957.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121231927.png

gallery2:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121234571.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121234072.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121235509.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121235753.png

gallery3:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121241747.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121241093.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121242586.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121242900.png

gallery4:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121254073.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121254647.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121254148.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121255203.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121255480.png

gallery5:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121322795.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121323800.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121323778.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121323486.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121323434.png

gallery6:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121331944.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121331202.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121331972.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121332981.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121333695.png

gallery7: 
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121827551.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121828352.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121828690.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121828047.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121828223.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121828285.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121828419.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121829238.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121829398.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121829742.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121829066.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121829750.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121830833.png

gallery8:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121903753.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121903235.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121903847.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506121903316.png
---

# LaTeX floats

In LaTeX, figures and tables that created by the `figure` and `table` environment are, by default, <i class="term">floats</i>[^1], and LaTeX adopts different methods, or rather, algorithms, to determine the position of normal text and floats:

<div class="quote--left" markdown="1">

Floats are containers for things in a document that cannot be broken over a page. LaTeX by default recognizes "table" and "figure" floats, but you can define new ones of your own. Floats are there to deal with the problem of the object that won't fit on the present page and to help when you really don't want the object here just now.

<i class="emphasize">Floats are not part of the normal stream of text, but separate entities,</i> positioned in a part of the page to themselves (top, middle, bottom, left, right, or wherever the designer specifies). <i class="emphasize">They always have a caption describing them and they are always numbered so they can be referred to from elsewhere in the text.</i> LaTeX automatically floats Tables and Figures, depending on how much space is left on the page at the point that they are processed. <i class="emphasize">If there is not enough room on the current page, the float is moved to the top of the next page.</i> This can be changed by moving the Table or Figure definition to an earlier or later point in the text, or by adjusting some of the parameters which control automatic floating.

Authors sometimes have many floats occurring in rapid succession, which raises the problem of how they are supposed to fit on the page and still leave room for text. In this case, <i class="emphasize">LaTeX stacks them all up and prints them together if possible, or leaves them to the end of the chapter in protest</i>. The skill is to space them out within your text so that they intrude neither on the thread of your argument or discussion nor on the visual balance of the typeset pages.

</div>

For example, the `figure` environment will create a float figure:

```latex
\begin{figure}[placement specifier]
... figure contents ...
\end{figure}
```

where “The <i class="term">placement specifier</i> parameter exists as a <i class="emphasize">compromise</i>, and its purpose is to give the author a greater degree of control over where certain floats are placed.”[^1]:

<div class="quote--left" markdown="1">


Specifier and its Permission:

- `h`: Place the float *here*, i.e., *approximately* at the same point it occurs in the source text (however, not *exactly* at the spot).
- `t`:  Position at the *top* of the page.
- `b`: Position at the *bottom* of the page.
- `p`: Put on a special *page* for floats only.
- `!`:  Override internal parameters LaTeX uses for determining "good" float positions.
- `H`: Places the float at precisely the location in the LaTeX code. Requires the `float` package, i.e., `\usepackage{float}`.

</div>

<br>

# Force floats appear where they are defined

Sometimes, people, myself included, want the floats appear where they are defined, i.e., the relation between main text and floats is the same in the LaTeX source code and correspondingly rendered document, or rather, make floats do not float. To this end, in addition to aforementioned placement specifiers, `[h]` and `[H]` (provided by the `float` package), there are also other ways[^1]:

<div class="quote--left" markdown="1">

- The `placeins` package provides the command `\FloatBarrier`, which can be used to prevent floats from being moved over it. This can, e.g., be useful at the beginning of each section. The package even provides an option to change the definition of `\section` to automatically include a `\FloatBarrier`. This can be set by loading the package with the option `[section]` (`\usepackage[section]{placeins}`). `\FloatBarrier` may also be useful to prevent floats intruding on lists created using `itemize` or `enumerate`.
- The `flafter` package can be used to force floats to appear after they are defined, and the `endfloat` package can be used to place all floats at the end of a document.
- The `float` package provides the `H` option to floating environments, which completely stops them from floating.
- Package `caption` provides the command `\captionof{<type>}{<caption text>}` that lets you typeset a caption without a floating environment. You have the full and absolute control about the placement of your figures and captions.

</div>

In the following text, I would compare these methods by taking an example.

<br>

# Examples

## The original case (default float)

<div id="script-1"></div>

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

\section{Section 1}
\mylipsum

\begin{figure}
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-1}
\end{figure}

\begin{table}
\centering
\caption{This is a simple table.}
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

\begin{figure}
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-2}
\end{figure}

\begin{table}
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

\begin{figure}
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-3}
\end{figure}

\begin{table}
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

\begin{figure}
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-4}
\end{figure}

\begin{table}
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

In the source code, I add a figure and a table below Section 1, Subsection 2.1, Subsection 2.2, and Section 4, respectively. However, as can be seen in the rendered document, if without any placement specifier (i.e., the default case), floats will be placed at the top of each page (however, this doesn’t means that floats are always moved to the top of the page).

## Use placement specifiers

### Placement specifier `[h]`

Add the placement specifier `[h]` after each float environment in the [Script 1](#script-1), for example:

```latex
% ...

\begin{figure}[h]
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-1}
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

% ...
```

{% include gallery id="gallery1" layout="half" %}

At this time, with the `[h]` option, figures and tables indeed appear where they are defined.

### Placement specifier `[!h]`

Add the placement specifier `[!h]` after each float in the [Script 1](#script-1):

{% include gallery id="gallery2" layout="half" %}

For this example, using the placement specifier `[!h]` has the same effect as using `[h]`.

### Placement specifier `[H]` (provided by the `float` package)

Import the `float` package, `\usepackage{float}`, in the preamble, and add the placement specifier `[H]` after each float in the [Script 1](#script-1):

{% include gallery id="gallery3" layout="half" %}

In this example, using `[H]` option of the `float` package also has the same effect as using the `[h]` option.

## The `placeins` package

### Use the `\FloatBarrier` command

Import the `placeins` package, and use a `\FloatBarrier` command after every `\section` and `\subsection` command based on the [Script 1](#script-1):

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

\usepackage{placeins}

\begin{document}

\section{Section 1}
\FloatBarrier
\mylipsum

\begin{figure}
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-1}
\end{figure}

\begin{table}
\centering
\caption{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{table}

\section{Section 2}
\FloatBarrier
\mylipsum

\subsection{Subsection 2.1}
\FloatBarrier
\mylipsum

\begin{figure}
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-2}
\end{figure}

\begin{table}
\centering
\caption{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{table}

\subsection{Subsection 2.2}
\FloatBarrier
\mylipsum

\begin{figure}
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-3}
\end{figure}

\begin{table}
\centering
\caption{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{table}

\section{Section 3}
\FloatBarrier
\mylipsum

\section{Section 4}
\FloatBarrier
\mylipsum

\begin{figure}
\centering
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}}\hfill
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}}
\caption{CTAN lion}
\label{fig-4}
\end{figure}

\begin{table}
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

{% include gallery id="gallery4" layout="half" %}

### Import the package with the `section` option

Do not use the `\FloatBarrier` command each time, but instead add `\usepackage[section]{placeins}` in the preamble based on the [Script 1](#script-1):

{% include gallery id="gallery5" layout="half" %}

### Summary

Above two ways of using the `placeins` package have the same effect, at least for this example. They really prevent floats from being moved over where the `\FloatBarrier` command is used, but it’s different from forcing floats fix where they are defined. Also, the overall layout is not good, even worse. Besides, there is a bug of the `placeins` package[^3][^4].

## The `flafter` package (vs. the `endfloat` package)

Just use `\usepackage{flafter}` in the preamble based on the [Script 1](#script-1):

{% include gallery id="gallery6" layout="half" %}

As can be seen, the `flafter` package can “force floats to appear *after* they are defined”, but similar to the `placeins` package, it can’t force them appear *where* they are defined. Besides, there are some unexpected additional blank spaces before the last figure and the last table.

As a comparison, we can use the `endfloat` package instead in the preamble, then we have:

{% include gallery id="gallery7" layout="half" %}

## Not use `figure` and `table` environment

Actually, the fact that the figures and tables are float is determined by the `figure` and `table` environment. So, if we don’t use these two environments, then figures and tables won’t float. For example, we can use `\includegraphics` commands and `tabular` environments in the `center` environment, rather than `figure` and `table` environment, to show figures and tables, and then use the `\captionof` command of the `caption` package to add captions for them:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath}
\usepackage[colorlinks, linkcolor=blue]{hyperref}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{graphicx}
\renewcommand{\figurename}{Fig.}

\numberwithin{equation}{section}
\numberwithin{figure}{section}

\def\CE{0.20}

\usepackage{lipsum}
\newcommand{\mylipsum}{\lipsum[1-3]}

\usepackage{caption}

\begin{document}

\section{Section 1}
\mylipsum

\begin{center}
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}
\captionof{figure}{CTAN lion}
\label{fig-1}
\end{center}

\begin{center}
\captionof{table}{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{center}

\section{Section 2}
\mylipsum

\subsection{Subsection 2.1}
\mylipsum

\begin{center}
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}
\captionof{figure}{CTAN lion}
\label{fig-2}
\end{center}

\begin{center}
\centering
\captionof{table}{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{center}

\subsection{Subsection 2.2}
\mylipsum

\begin{center}
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}
\captionof{figure}{CTAN lion}
\label{fig-3}
\end{center}

\begin{center}
\centering
\captionof{table}{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{center}

\section{Section 3}
\mylipsum

\section{Section 4}
\mylipsum

\begin{center}
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{ctanlion.eps}\hfill
\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{ctanlion.eps}
\captionof{figure}{CTAN lion}
\label{fig-4}
\end{center}

\begin{center}
\centering
\captionof{table}{This is a simple table.}
\begin{tabular}{ccc}
\hline
a & b & c\\ \hline
1 & 2 & 3\\ \hline
\end{tabular}
\end{center}

\end{document}
```

{% include gallery id="gallery8" layout="half" %}

The results are really what we expect. One shortcoming is that, however, for figures, due to that we don’t use `figure` environment at this time, `\subfloat` can’t be used either. So, right now I don’t find a proper way to add a subcaption for each subfigure.

<br>

# Discussions

From above examples, we can conclude that, to force floats appear where they are defined, the best way is to use option `[h]`, `[!h]`, or `[H]`. Of course, not using float environments is also available, but it’s a method not that standard.

However, it should be noted that, based on my experiences, using `[H]` option sometimes brings some additional blank spaces, even a whole blank page in some cases, after a float. To take a step further, there are more unexpected problems.

When we say “force floats appear where they are defined”, what we actually mean is to “force floats appear *exactly* where they are defined”, just as in Microsoft Word, figures will be at where they are inserted. In above examples, using placement specifier `[h]`, `[!h]`, or `[H]` can realize this point, but these options can’t always guarantee (as said before, these placement specifiers exist, to some extent, just as a compromise) --- from time to time we can see that they seem not functional --- because there actually are many rules, or rather, algorithms, to determine the final position of a float[^2], such as a basic one:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506131208639.png" alt="image-20250613120806493" style="width:67%;" />

In fact this is a very professional field.

So, to my mind, in practice, we should try different ways or combine some of them to control the position of a float to reach a good effect. It depends. In some cases, it’s not a good choice to make every float appear where they are defined in the source code.

<br>

**References**

[^1]: [LaTeX/Floats, Figures and Captions](https://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions).
[^2]: [positioning - How to influence the position of float environments like figure and table in LaTeX?](https://tex.stackexchange.com/questions/39017/how-to-influence-the-position-of-float-environments-like-figure-and-table-in-lat/39020#39020).
[^3]: [sectioning - How to keep a float within certain boundaries (say, a section)? (`\FloatBarrier` doesn’t seem to help because of a bug)](https://tex.stackexchange.com/questions/654346/how-to-keep-a-float-within-certain-boundaries-say-a-section-floatbarrier-d).
[^4]: [CTAN: Package `placeins`](https://ctan.org/pkg/placeins?lang=en).
