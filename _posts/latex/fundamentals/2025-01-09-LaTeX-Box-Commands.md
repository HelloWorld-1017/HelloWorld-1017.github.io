---
title: "LaTeX Box Commands: `\\mbox`, `\\makebox`, `\\fbox`, `\\framebox` and `\\parbox`"
categories:
 - LaTeX
tags:
 - LaTeX Box
 - LaTeX Fundamentals
 - LaTeX Layout
date: 2025-01-09 16:12:35 +0800
last_modified_at: 2025-01-09 18:27:26 +0800
---

# `\mbox` and `\makebox`

LaTeX `\mbox` and `\makebox` command[^1]:

```
\mbox{text}
\makebox{text}
\makebox[width]{text}
\makebox[width][position]{text}
```

Here are some examples:

```latex
\documentclass[a4paper,11pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\setlength\parindent{0pt}

\begin{document}
\verb|\mbox| command:
\vspace{1em}

\mbox{text}

\vspace{5em}

\verb|\makebox| command:
\vspace{1em}

\makebox[10em][c]{left center right}\\
\makebox[10em][l]{left center right}\\
\makebox[10em][r]{left center right}\\
\makebox[10em][s]{left center right}\\

\makebox[\linewidth][c]{left center right}\\
\makebox[\linewidth][l]{left center right}\\
\makebox[\linewidth][r]{left center right}\\
\makebox[\linewidth][s]{left center right}\\

\makebox[0pt][l]{Left}Right\\

\newcommand{\pts}[1]{\makebox[0em][r]{#1 points\hspace*{1em}}}
\pts{10}What is the air-speed velocity of an unladen swallow?\\
\pts{90}An African or European swallow?\\
\end{document}
```

![image-20250109170102775](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501091701911.png)

<br>

#  `\fbox` and `\framebox`

LaTeX `\fbox` and `\framebox` command[^2]:

```
\fbox{text}
\framebox{text}
\framebox[width]{text}
\framebox[width][position]{text}
```

Here are some examples:

```latex
\documentclass[a4paper,11pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\setlength\parindent{0pt}

\begin{document}
\verb|\fbox| command:
\vspace{1em}

\fbox{text}

{\setlength{\fboxsep}{0em}
	{\fbox{left center right}}}\\
{\setlength{\fboxsep}{1em}
	{\fbox{left center right}}}\\

{\setlength{\fboxsep}{0em}\setlength{\fboxrule}{1pt}
	{\fbox{left center right}}}\\
{\setlength{\fboxsep}{1em}\setlength{\fboxrule}{1pt}
	{\fbox{left center right}}}\\

\vspace{5em}

\verb|\framebox| command:
\vspace{1em}

\framebox[10em][c]{left center right}\\
\framebox[10em][l]{left center right}\\
\framebox[10em][r]{left center right}\\
\framebox[10em][s]{left center right}\\

\framebox[\linewidth][c]{left center right}\\
\framebox[\linewidth][l]{left center right}\\
\framebox[\linewidth][r]{left center right}\\
\framebox[\linewidth][s]{left center right}\\

{\setlength{\fboxsep}{0em}
	{\framebox{left center right}}}\\
{\setlength{\fboxsep}{1em}
	{\framebox{left center right}}}\\

{\setlength{\fboxsep}{0em}\setlength{\fboxrule}{1pt}
	{\framebox{left center right}}}\\
{\setlength{\fboxsep}{1em}\setlength{\fboxrule}{1pt}
	{\framebox{left center right}}}\\
\end{document}
```

![image-20250109170209523](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501091702705.png)

where[^2]:

- `\fboxrule`: The thickness of the rules around the enclosed box. The default is 0.2 pt.
- `\fboxsep`: The distance from the frame to the enclosed box. The default is 3 pt.
- and syntax like `\setlength{\fboxsep}{0em}` and `\setlength{\fboxrule}{1pt}` is wrapped in extra curly braces to keep the specification work locally.

<br>

# `\parbox`

LaTeX `\parbox` command[^3][^4][^5]:

```
\parbox{width}{contents}
\parbox[position]{width}{contents}
\parbox[position][height]{width}{contents}
\parbox[position][height][inner-pos]{width}{contents}
```

Here are some examples:

```latex
\documentclass[a4paper,11pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\setlength\parindent{0pt}

\newcommand{\mytext}{\lipsum[1][1-2]}

\begin{document}
\mytext\parbox{20em}{\textcolor{blue}{\mytext}}\\

\mytext\parbox[t]{20em}{\textcolor{blue}{\mytext}}\\
\mytext\parbox[c]{20em}{\textcolor{blue}{\mytext}}\\
\mytext\parbox[b]{20em}{\textcolor{blue}{\mytext}}\\
\mytext\parbox[s]{20em}{\textcolor{blue}{\mytext}}\\

\mytext\parbox[t][15em]{20em}{\textcolor{blue}{\mytext}}\\
\mytext\parbox[t][15em][c]{20em}{\textcolor{blue}{\mytext}}\\
\mytext
\end{document}
```

![image-20250109175350276](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501091753378.png)

By the way, for those more complicated cases, `minipage` environment is more suitable than simple `\parbox` command[^4]:

<div class="quote--left" markdown="1">

A `\parbox` command is used for a parbox containing a small piece of text, with nothing fancy inside. In particular, you shouldn't use any of the paragraph-making environments inside a `\parbox` argument. For larger pieces of text, including ones containing a paragraph-making environment, you should use a `minipage` environment See [minipage](http://herbert.the-little-red-haired-girl.org/html/latex2e/minipage.html).

</div>

# Display modes

For `\mbox`, `\makebox`, `\fbox`, and `\framebox`, the text in these commands is typeset in LR mode[^1][^2], meaning that the text is not broken into lines[^6]:

<div class="quote--left" markdown="1">

<i class="term">LR mode</i> (for <i class="term">left-to-right mode</i>; in plain TeX this is called <i class="term">restricted horizontal mode</i>) is in effect when LaTeX starts making a box with an `\mbox` command. As in paragraph mode, LaTeX’s output is a string of words with spaces between them. Unlike in paragraph mode, in LR mode LaTeX never starts a new line, it just keeps going from left to right. (Although LaTeX will not complain that the LR box is too long, when it is finished and next tries to put that box into a line, it might well complain that the finished LR box won’t fit there.)

</div>

while the text in the `\parbox` command is in text mode[^3], which means that LaTeX will break lines to make a paragraph[^6]:

<div class="quote--left" markdown="1">

<i class="term">Paragraph mode</i> (in plain TeX this is called <i class="term">horizontal mode</i>) is what LaTeX is in when processing ordinary text. It breaks the input text into lines and finds the positions of line breaks, so that in vertical mode page breaks can be done. This is the mode LaTeX is in most of the time.

</div>

For example,

```latex
\documentclass[a4paper,11pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\setlength\parindent{0pt}

\newcommand{\mytext}{\lipsum[1][1-2]}

\begin{document}
\mbox{\mytext}

\makebox[10em][l]{\mytext}

\fbox{\mytext}

\framebox[10em][c]{\mytext}

\mytext\parbox{20em}{\textcolor{blue}{\mytext}}
\end{document}
```

![image-20250109181611996](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501091816132.png)

<br>

**References**

[^1]: [`\mbox` & `\makebox` (LaTeX2e unofficial reference manual (December 2024))](https://latexref.xyz/_005cmbox-_0026-_005cmakebox.html).
[^2]: [`\fbox` & `\framebox` (LaTeX2e unofficial reference manual (December 2024))](https://latexref.xyz/_005cfbox-_0026-_005cframebox.html).
[^3]: [`\parbox` (LaTeX2e unofficial reference manual (December 2024))](https://latexref.xyz/_005cparbox.html).
[^4]: [`\parbox`](http://herbert.the-little-red-haired-girl.org/html/latex2e/$5cparbox.html).
[^5]: [LaTeX help 1.1 - `\parbox`](https://emerson.emory.edu/services/latex/latex_147.html).
[^6]: [Modes (LaTeX2e unofficial reference manual (December 2024))](https://latexref.xyz/Modes.html).