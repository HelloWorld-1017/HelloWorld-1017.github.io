---
title: Adjust the Distance between Figure and Main Text in LaTeX Using `\vspace*` Command
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Figure
 - LaTeX Layout
location: Buffalo, United States
date: 2025-11-09 16:30:11 -0500
last_modified_at: 2025-11-11 17:55:20 -0500
---

When writing document in LaTeX, sometimes we may want to adjust, usually slightly, the distance between figures and main text; we can use `\vspace*` command to realize it. For example,

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}

\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{graphicx,subfig}

\begin{document}
\thispagestyle{empty}

\lipsum[1]
\begin{figure*}[h]
	\centering
	\vspace*{3em}
	\includegraphics[width=0.33\linewidth]{ctan_lion.png}
	\caption{CTAN lion}
	\vspace*{-3em}
\end{figure*}

\lipsum[1]

\begin{figure*}[h]
	\centering
	\vspace*{3em}
	\subfloat[]{\includegraphics[width=0.33\linewidth]{ctan_lion.png}}\hfill
	\subfloat[]{\includegraphics[width=0.33\linewidth]{ctan_lion.png}}\hfill
	\subfloat[]{\includegraphics[width=0.33\linewidth]{ctan_lion.png}}\hfill
	\caption{CTAN lion}
	\vspace*{-3em}
\end{figure*}

\lipsum[1]

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251111003159112.png" alt="png-1" style="width:75%;" />

By the way, the `\vspace*` command, instead of `\vspace`, is preferred, because sometimes `\vspace` command would be discarded --- although it works well in above case, I encountered a case where it didn't work (but I can't reproduce it now here ... weird 😔). There are some references talking about the difference between `\vspace` and `\vspace*`:

<div class="quote--left" markdown="1">

The command `\vspace` is used to add vertical space between lines, paragraphs, or sections. It works well in the middle of a page, but at the start or end of a page, LaTeX may ignore it.

The command `\vspace*` is a stronger version. Unlike `\vspace`, it does not get ignored at the top or bottom of a page. This makes it perfect when you must ensure extra space stays visible in all positions.[^1]

</div>

<div class="quote--left" markdown="1">

I don't think the sign of the argument matters, Without the `*` the skip is always discarded at the start of the page, and with the `*` it is not discarded.[^2]

</div>

and I also reported a same phenomenon in my another blog[^3]. 

<br>

**References**

[^1]: [Difference between `vspace` and `vspace*` in LaTeX](https://www.physicsread.com/vspace-vs-vspace-star-latex/).
[^2]: [spacing - difference between `\vspace` and `\vspace*` for negative arguments](https://tex.stackexchange.com/questions/76101/difference-between-vspace-and-vspace-for-negative-arguments).
[^3]: [Center Text Vertically in A Page in LaTeX Using `\vspace*` Command](/2024-05-27/21-22-43.html).
