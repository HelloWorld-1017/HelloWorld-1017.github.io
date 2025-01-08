---
title: Organize Multi-figure Layout in LaTeX System
categories:
 - LaTeX
tags:
 - LaTeX Figure
 - LaTeX graphicx
 - LaTeX subfig
date: 2023-10-03 22:38:49 +0800
last_modified_at: 2025-01-07 14:44:29 +0800
---

#  `\subfloat` and `\includegraphics` control sequence

In LaTeX system, the multi-figure layout could be organised by `\includegraphics`  and `\subfloat` control sequence. The `\includegraphics` is from `graphicx` macro package, and `\subfloat` is from `subfig` package.

```latex
\documentclass{article}
\usepackage{graphicx,subfig}
\usepackage{geometry}
\geometry{a4paper}

\begin{document}

\begin{figure}
	\def\CE{0.20}
	\centering
	\subfloat[Data series A.]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-1.pdf}\label{fig-a}}\hfill
	\subfloat[Data series B.]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-2.pdf}}\hfill
	\subfloat[Data series C.]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-3.pdf}}\hfill
	\subfloat[Data series D.]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}}\hfill
	\subfloat[Data series E.]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-5.pdf}}\hfill
	\subfloat[Data series F.]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-6.pdf}}\hfill
	\subfloat[Data series G.]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-7.pdf}}\hfill
	\subfloat[Data series H.]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-8.pdf}}
	\caption{This is caption.}
	\label{fig}
\end{figure}

This is Fig. \ref{fig}, and this is subfigure Fig. \ref{fig-a}.

\end{document}
```

![image-20231003195205834](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231003195205834.png)

(1) The title of sub-figure is specified in the `\subfloat` option, if don’t want to make a title for it, just leave a space in `\subfloat[]`, like:

```latex
\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-8.pdf}}
```

(2) The control sequence `\hfill` could fill the horizontal spacing between the sub-figures; on the other hand, they could arrange sub-figures automatically as well. If we delete them, these sub-figures will be ALWAYS placed in a row, although the last few sub-figures couldn’t be displayed in the page normally: 

```latex
\documentclass{article}
\usepackage{graphicx,subfig}
\usepackage{geometry}
\geometry{a4paper}

\begin{document}

\begin{figure}
	\def\CE{0.25}
	\centering
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-1.pdf}
	\label{fig-a}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-2.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-3.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-5.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-6.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-7.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-8.pdf}}
	\caption{This is caption.}
	\label{fig}
\end{figure}

This is Fig. \ref{fig}, and this is subfigure Fig. \ref{fig-a}.

\end{document}
```

![image-20231003204857145](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231003204857145.png)

(3) If want to show the sub-figures in multiple rows, we just need to add control sequence `\\` (or leave a new line with nothing) after where to split, like making a new row from the 5th sub-figure:

```latex
\documentclass{article}
\usepackage{graphicx,subfig}
\usepackage{geometry}
\geometry{a4paper}

\begin{document}

\begin{figure}
	\def\CE{0.25}
	\centering
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-1.pdf}\label{fig-a}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-2.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-3.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}}\\
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-5.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-6.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-7.pdf}}
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-8.pdf}}
	\caption{This is caption.}
	\label{fig}
\end{figure}

This is Fig. \ref{fig}, and this is subfigure Fig. \ref{fig-a}.

\end{document}
```

![image-20231003205433919](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231003205433919.png)

(4) If want to change the cross reference style of sub-figure, we could make an extra setting by `\DeclareSubrefFormat` and `\captionsetup` control sequence in preamble area, like: 

```latex
\documentclass{article}
\usepackage{graphicx,float,subfig}
\usepackage{geometry}
\geometry{a4paper}
\DeclareSubrefFormat{myparens}{#1-(#2)}
\captionsetup[subfloat]{subrefformat=myparens}

\begin{document}

\begin{figure}
	\def\CE{0.20}
	\centering
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-1.pdf}\label{fig-a}}\hfill
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-2.pdf}}\hfill
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-3.pdf}}\hfill
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}}
	\caption{This is caption.}
	\label{fig}
\end{figure}

This is Fig. \ref{fig}, and this is subfigure Fig. \subref*{fig-a}.

\end{document}
```

![image-20230927201859291](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20230927201859291.png)

It should be noted that here, we should use `\subref*` to refer the label of sub-figure, and do not forget the `*` mark [1]. 

(5) Multiple figures could be put into one `\subfloat` environment to share a sub-figure title:

```latex
\documentclass{article}
\usepackage{graphicx,subfig}
\usepackage{geometry}
\geometry{a4paper}

\begin{document}

\begin{figure}
	\def\CE{0.20}
	\centering
	\subfloat[]{
	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-1.pdf}\label{fig-a}\hfill
	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-2.pdf}\hfill
	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-3.pdf}\hfill
	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}
	}\\
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-5.pdf}}\hfill
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-6.pdf}}\hfill
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-7.pdf}}\hfill
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-8.pdf}}\hfill
	\caption{This is caption.}
	\label{fig}
\end{figure}

This is Fig. \ref{fig}, and this is subfigure Fig. \ref{fig-a}.

\end{document}
```

![image-20231003215214330](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231003215214330.png)

It can be seen from this example that the `\fill` doesn’t work in `\subfloat` environment.
{: .notice--primary}

<br>

# `minipage` environment

Using `minipage` environment is another way to organise figures, and I think this is a better approach as it is convenient for sub-figures to share a label horizontally or vertically:

```latex
\documentclass{article}
\usepackage{graphicx,subfig}
\usepackage{geometry}
\geometry{a4paper}

\begin{document}

\begin{figure}
	\def\CE{0.20}
	\centering
	\subfloat[]{
		\begin{minipage}{\linewidth}
		\centering
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-1.pdf}\hfill
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-2.pdf}\hfill
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-3.pdf}\hfill
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}
		\end{minipage}
	}\\
	\subfloat[]{
		\begin{minipage}{\linewidth}
		\centering
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-5.pdf}\hfill
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-6.pdf}\hfill
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-7.pdf}\hfill
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-7.pdf}
		\end{minipage}
	}
	\caption{This is caption.}
	\label{fig}
\end{figure}

\end{document}
```

![image-20231003220508298](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231003220508298.png)

```latex
\documentclass{article}
\usepackage{graphicx,subfig}
\usepackage{geometry}
\geometry{a4paper}

\begin{document}

\begin{figure}
	\def\CE{0.8}
	\centering
	\subfloat[]{
		\begin{minipage}{0.25\textwidth}
		\centering
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-1.pdf}\\
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-2.pdf}
		\end{minipage}
	}
	\subfloat[]{
		\begin{minipage}{0.25\textwidth}
		\centering
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-3.pdf}\\
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}
		\end{minipage}
	}
	\subfloat[]{
		\begin{minipage}{0.25\textwidth}
		\centering
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-5.pdf}\\
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-6.pdf}
		\end{minipage}
	}
	\subfloat[]{
		\begin{minipage}{0.25\textwidth}
		\centering
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-7.pdf}\\
		\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-8.pdf}
		\end{minipage}
	}
	\caption{This is caption.}
	\label{fig}
\end{figure}

\end{document}
```

![image-20231003221109667](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231003221109667.png)

> Note well here that the `minipage` environment must be include in `\subfloat` as well, otherwise the sub-figure won’t appear:
>
> ```latex
> \documentclass{article}
> \usepackage{graphicx,subfig}
> \usepackage{geometry}
> \geometry{a4paper}
> 
> \begin{document}
> 
> \begin{figure}
> 	\def\CE{0.20}
> 	\centering
> 	\begin{minipage}{\linewidth}
> 	\centering
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-1.pdf}\hfill
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-2.pdf}\hfill
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-3.pdf}\hfill
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}
> 	\end{minipage}\\
> 	\begin{minipage}{\linewidth}
> 	\centering
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-5.pdf}\hfill
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-6.pdf}\hfill
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-7.pdf}\hfill
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-7.pdf}
> 	\end{minipage}
> 	\caption{This is caption.}
> 	\label{fig}
> \end{figure}
> 
> \end{document}
> ```
>
> ![image-20231003220042444](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231003220042444.png)
>
> Actually, in the previous part, the reason why we put `\includegraphics` in `\subfloat` is the same, if we just use `\includegraphics` control sequence:
>
> ```latex
> \documentclass{article}
> \usepackage{graphicx,subfig}
> \usepackage{geometry}
> \geometry{a4paper}
> 
> \begin{document}
> 
> \begin{figure}
> 	\def\CE{0.20}
> 	\centering
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-1.pdf}\label{fig-a}\hfill
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-2.pdf}\hfill
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-3.pdf}\hfill
> 	\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}\hfill
> 	\caption{This is caption.}
> 	\label{fig}
> \end{figure}
> 
> \end{document}
> ```
>
> ![image-20231003223254443](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231003223254443.png)

<br>

**References**

[1] [The Subfig Package v1.3, last revised 2025/06/28](https://texdoc.org/serve/subfig/0).