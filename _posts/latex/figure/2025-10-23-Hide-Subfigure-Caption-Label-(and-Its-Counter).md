---
title: Hide Subfigure Caption Label (and Its Counter) in LaTeX
toc: false
categories:
 - LaTeX
tag:
 - LaTeX Figure
 - LaTeX subfig
location: Buffalo, United States
date: 2025-10-23 15:24:36 -0400
last_modified_at: 2025-11-02 22:13:28 -0500
---

In LaTeX, we can use command `\captionsetup[subfigure]{labelformat=empty}` to hide the subfigure caption label, and meanwhile use `\addtocounter{subfigure}{-1}` to make subfigure counter not count the current subfigure. Next, don't forget using `\captionsetup[subfigure]{labelformat=parens}` to reactive subfigure caption label. Here is an example (the source code is basically from blog [^1]):

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\usepackage{graphicx,subfig}

\begin{document}
	\begin{figure*}[htp]
		\centering
		% Fig 1
		\captionsetup[subfigure]{labelformat=empty} % Hide subfigure caption
		\begin{minipage}{0.32\linewidth}
			\subfloat[xxx]{\includegraphics[width=\linewidth]{fig1.jpg}}
		\end{minipage}\hfill
		\addtocounter{subfigure}{-1} % Roll back the subfigure counter by 1
		\captionsetup[subfigure]{labelformat=parens} % Reactive subfigure caption
		% Fig 2
		\begin{minipage}{0.32\linewidth}
			\subfloat[xxx]{\includegraphics[width=\linewidth]{fig2.jpg}}
		\end{minipage}\hfill
		% Fig 3
		\begin{minipage}{0.32\linewidth}
			\subfloat[xxx]{\includegraphics[width=\linewidth]{fig3.jpg}}
		\end{minipage}\hfill
		\vspace*{1em}
		% Fig 3 & Fig 4 (NOTE HERE, two figures are put in one minipage)
		\begin{minipage}{0.32\linewidth}
			\subfloat[xxx]{\includegraphics[width=\linewidth]{fig4.jpg}}\\
			\subfloat[xxx]{\includegraphics[width=\linewidth]{fig5.jpg}}
		\end{minipage}\hfill
		\begin{minipage}{0.67\linewidth}
			\vspace*{1.5em}
			\subfloat[xxx]{\includegraphics[width=\linewidth]{fig6.jpg}}
		\end{minipage}
		\caption{xxx}
	\end{figure*}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251023190801051.png" alt="image-20251023190753860" style="width:75%;" />

Note that command `\captionsetup[subfigure]{labelformat=empty}` can only cancel subfigure caption LABEL, not including caption per se. Of course, we can choose not input caption when creating subfigure by `\subfloat` command:

```latex
% ...
\subfloat[]{\includegraphics[width=\linewidth]{fig1.jpg}}
% ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251023192041118.png" alt="image-20251023191933048" style="width:75%;" />

<br>

**References**

[^1]: [Organize Multiple Subfigures Like MATLAB `tiledlayout` Function in LaTeX](/2025-10-22/10-36-42.html).
