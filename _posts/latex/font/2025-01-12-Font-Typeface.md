---
title: Specify Font Typeface in LaTeX
toc: false
categories:
 - Design
 - LaTeX
tags:
 - LaTeX Font
 - LaTeX fontenc
date: 2025-01-12 18:17:50 +0800
last_modified_at: 2025-01-12 19:55:57 +0800
---

**(1) For a certain piece of text**[^1]

By the code `\fontfamily{#1}\selectfont`, where `#1` is the “font code” in the following table:

```latex
\documentclass[a4paper,landscape]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\usepackage[T1]{fontenc}

\setlength\parindent{0pt}

\newcommand{\testfont}[1]{\fontfamily{#1}\selectfont The quick brown fox jumps over the lazy dog. 0123456789}

\begin{document}
\thispagestyle{empty}
\vspace*{\fill}
\begin{center}
	\begin{tabular}{|l|l|l|l|}
		\hline
		Font & Font package name & Font code & Example\\ \hline
		Computer Modern Roman & & cmr & \testfont{cmr}\\ \hline
		Latin Modern Roman & lmodern & lmr & \testfont{lmr}\\ \hline
		Latin Modern Dunhill & lmodern & lmdh & \testfont{lmdh}\\ \hline
		TeX Gyre Termes & tgtermes & qtm & \testfont{qtm}\\ \hline
		TeX Gyre Pagella & tgpagella & qpl & \testfont{qpl}\\ \hline
		TeX Gyre Bonum & tgbonum & qbk & \testfont{qbk}\\ \hline
		TeX Gyre Schola & tgschola & qcs & \testfont{qcs}\\ \hline
		Times & mathptmx & ptm & \testfont{ptm}\\ \hline
		Utopia / Fourier & utopia / fourier & put & \testfont{put}\\ \hline
		Palatino & palatino & ppl & \testfont{ppl}\\ \hline
		Bookman & bookman & pbk & \testfont{pbk}\\ \hline
		Charter & charter & bch & \testfont{bch}\\ \hline
		Computer Modern Sans Serif & & cmss & \testfont{cmss}\\ \hline
		Latin Modern Sans Serif & lmodern & lmss & \testfont{lmss}\\ \hline
		TeX Gyre Adventor & tgadventor & qag & \testfont{qag}\\ \hline
		TeX Gyre Heros & tgheros & qhv & \testfont{qhv}\\ \hline
		Helvetica & helvet & phv & \testfont{qhv}\\ \hline
		Computer Modern Typewriter & & cmtt & \testfont{cmtt}\\ \hline
		Latin Modern Sans Typewriter & lmodern & lmtt & \testfont{lmtt}\\ \hline
		TeX Gyre Cursor & tgcursor & qcr & \testfont{qcr}\\ \hline
		Courier & courier & pcr & \testfont{pcr}\\ \hline
	\end{tabular}
\end{center}
\vspace*{\fill}
\end{document}
```

![image-20250112194302037](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121943158.png)

More typefaces can be found in the reference[^2].

**(2) For the whole document**[^1]

By importing the package whose name is “font package name” mentioned in the above table, we can change the font typeface for the whole document. Take “TeX Gyre Bonum”, we have:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\usepackage[T1]{fontenc}
\usepackage{tgbonum}

\begin{document}
    \vspace*{\fill}
    \lipsum[1-7]
    \vspace*{\fill}
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121826882.png)

and “Helvetica”:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\usepackage[T1]{fontenc}
\usepackage{helvet}
\renewcommand{\familydefault}{\sfdefault}

\begin{document}
    \vspace*{\fill}
    \lipsum[1-7]
    \vspace*{\fill}
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121940066.png)

and “Courier”:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\usepackage[T1]{fontenc}
\usepackage{courier}
\renewcommand\familydefault{\ttdefault}

\begin{document}
    \vspace*{\fill}
    \lipsum[1-6]
    \vspace*{\fill}
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121952528.png)

Note that in the “Helvetica” example and “Courier” example, code `\renewcommand{\familydefault}{\sfdefault}`[^3] and `\renewcommand\familydefault{\ttdefault}`[^4] is necessary.

<br>

**References**

[^1]: [Font typefaces](https://www.overleaf.com/learn/latex/Font_typefaces).
[^2]: [The LaTeX Font Catalogue](https://tug.org/FontCatalogue/).
[^3]: [`\usepackage{helvet}` not changing doc font \: r/LaTeX](https://www.reddit.com/r/LaTeX/comments/15swk6j/usepackagehelvet_not_changing_doc_font/).
[^4]: [The LaTeX Font Catalogue – Courier](https://www.tug.org/FontCatalogue/courier/).
