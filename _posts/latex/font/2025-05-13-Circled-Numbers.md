---
title: Circled Numbers in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
 - LaTeX Font
 - LaTeX pifont
 - LaTeX TikZ
date: 2025-05-13 16:50:54 +0800
last_modified_at: 2025-05-13 16:50:54 +0800
---

In LaTeX, we can type circled numbers using commands provided by `pifont` package[^1][^2]:

```latex
\documentclass{article}
\usepackage{pifont}

\begin{document}

\noindent
\ding{172}\ding{173}\ding{174}\ding{175}\ding{176}\ding{177}\ding{178}\ding{179}\ding{180}\ding{181}\\
\ding{182}\ding{183}\ding{184}\ding{185}\ding{186}\ding{187}\ding{188}\ding{189}\ding{190}\ding{191}\\
\ding{192}\ding{193}\ding{194}\ding{195}\ding{196}\ding{197}\ding{198}\ding{199}\ding{200}\ding{201}\\
\ding{202}\ding{203}\ding{204}\ding{205}\ding{206}\ding{207}\ding{208}\ding{209}\ding{210}\ding{211}\\

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505131713821.png" alt="image-20250513171305729" style="width:50%;" />

Note that if we want to use them in the `equation` environment, the command should be wrapped in the `\text` command:

```latex
\documentclass{article}
\usepackage{pifont}
\usepackage{amsmath}

\begin{document}

\begin{equation}
\text{\ding{172}},\text{\ding{173}},\text{\ding{174}},\text{\ding{175}},\text{\ding{176}},\text{\ding{177}},\text{\ding{178}},\text{\ding{179}},\text{\ding{180}},\text{\ding{181}}
\end{equation}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505131719818.png" alt="image-20250513171942766" style="width:67%;" />

otherwise they are not visible. However, as can be seen, this method is sort of limited -- for example we can’t type circled 11 in this way.

There is another way, i.e., using the `\textcircled` command[^3]:

```latex
\documentclass{article}

\begin{document}

\textcircled{1},\textcircled{2},\textcircled{3},\textcircled{4},\textcircled{5},\textcircled{6},\textcircled{7},\textcircled{8},\textcircled{9},\textcircled{10},\textcircled{11},\textcircled{12},\textcircled{13},\textcircled{14},\textcircled{15},\textcircled{16},\textcircled{17}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505131729791.png" alt="image-20250513172905744" style="width:50%;" />

but at this time we can see some numbers exceed the circle.

To solve this problem, Stefan provides an elegant way by using TikZ package[^4]:

```latex
\documentclass{article}
\usepackage{tikz}

\newcommand*\circled[1]{\tikz[baseline=(char.base)]{
	\node[shape=circle, draw, inner sep=0pt,
	minimum width=1em] (char) {\footnotesize  #1};}}

\begin{document}

\circled{1},\circled{2},\circled{3},\circled{4},\circled{5},\circled{6},\circled{7},\circled{8},\circled{9},\circled{10},\circled{11},\circled{12},\circled{13},\circled{14},\circled{15},\circled{16},\circled{17}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505131742630.png" alt="image-20250513174211516" style="width:50%;" />

which is very flexible.

<br>

**References**

[^1]: [write number in circle](https://latex.org/forum/viewtopic.php?t=19995).
[^2]: [Using common PostScript fonts with LaTeX](https://mirror-hk.koddos.net/CTAN/macros/latex/required/psnfss/psnfss2e.pdf).
[^3]: [https://tex.stackexchange.com/q/7032/306224](https://tex.stackexchange.com/q/7032/306224).
[^4]: [https://tex.stackexchange.com/a/7045/306224](https://tex.stackexchange.com/a/7045/306224).





