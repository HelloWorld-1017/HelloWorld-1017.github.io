LaTeX Figure





```latex
\documentclass{article}
\usepackage{geometry}
\geometry{a4paper}
\usepackage{graphicx,subfig}

\begin{document}
	\begin{figure}
		\centering
		\includegraphics[width=0.2\textwidth]{pic-1.pdf}
		\caption{This is a random data series 1, and here is short caption.}
		\vspace{-20em}
	\end{figure}
	\begin{figure}
		\centering
		\includegraphics[width=0.2\textwidth]{pic-2.pdf}
		\caption{This is a random data series 2, and here is long long long long long long long long long long caption.}
		\vspace{-20em}
	\end{figure}
	\begin{figure}
		\def\CE{0.20}
		\centering
		\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{pic-1.pdf}\label{fig-a}}\hfill
		\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{pic-2.pdf}}\hfill
		\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{pic-3.pdf}}\hfill
		\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}}
		\caption{This is a set of random data series.}
		\label{fig}
	\end{figure}
\end{document}
```

![image-20231006204107184](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231006204107184.png)

If the title is too long, ...



这么修改也会影响子图的标题，因此需要避免这一点

```latex
\documentclass{article}
\usepackage{geometry}
\geometry{a4paper}
\usepackage{graphicx,subfig}
\usepackage{caption}
\captionsetup[figure]{justification=raggedright,singlelinecheck=false}
\captionsetup[subfigure]{justification=centering}

\begin{document}

\begin{figure}
	\centering
	\includegraphics[width=0.2\textwidth]{pic-1.pdf}
	\caption{This is a random data series 1, and here is short caption.}
	\vspace{-20em}
\end{figure}
\begin{figure}
	\centering
	\includegraphics[width=0.2\textwidth]{pic-2.pdf}
	\caption{This is a random data series 2, and here is long long long long long long long long long long caption.}
	\vspace{-20em}
\end{figure}
\begin{figure}
	\def\CE{0.20}
	\centering
	\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{pic-1.pdf}\label{fig-a}}\hfill
	\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{pic-2.pdf}}\hfill
	\subfloat[]{\includegraphics[height=\CE\textwidth,width=\CE\textwidth]{pic-3.pdf}}\hfill
	\subfloat[]{\includegraphics[height=\CE\textwidth, width=\CE\textwidth]{pic-4.pdf}}
	\caption{This is a set of random data series.}
	\label{fig}
\end{figure}
\end{document}
```

![image-20231006203959865](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231006203959865.png)

this is like the IEEE-providing template 

==the way modifying the caption style locally==

