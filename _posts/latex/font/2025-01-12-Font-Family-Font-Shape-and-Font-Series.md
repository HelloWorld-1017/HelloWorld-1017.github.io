---
title: Specify Font Family, Font Shape, and Font Series in LaTeX
toc: false
categories:
 - Design
 - LaTeX
tags:
 - LaTeX Font
date: 2025-01-12 14:34:58 +0800
last_modified_at: 2025-01-12 14:34:58 +0800
---

There are five common properties determining the display effect of a certain font, that is font size, font encoding, **font family**, **font shape**, and **font series** (which usually refers to the font weight and width). Considering that font size is always separately specified[^2] and font encoding is rarely set directly, the last three ones are used most[^1].  So, the following content shows different values of these three font properties and resulting text.

(1) Font family
- Roman font family: `\rmfamily{}`, `\rmfamily`;
- Sans serif font family: `\sffamily{}`, `\sffamily`;
- Typewriter font family: `\ttfamily{}`, `\ttfamily`;

(2) Font shape
- Upright shape: `\textup{}`, `\upshape`;
- Italic shape: `\textit{}`, `\itshape`;
- Slanted shape: `\textsl{}`, `\slshape`;
- Small capitals shape: `\textsc{}`, `\scshape`;

(3) Font series
- Medium series: `\textmd{}`, `\mdseries`;
- Bold extended series: `\textbf{}`, `\bfseries`;

```latex
\documentclass[a4paper]{article}

\begin{document}
\begin{table}
	\caption{Font family}\vspace{1em}
	\begin{tabular}{|l|l|l|}
		\hline
		Roman font family (default) & \rmfamily{Roman font family} & {\rmfamily Roman font family}\\ \hline
		Sans serif font family & \sffamily{Sans serif font family} & {\sffamily Sans serif font family}\\ \hline
		Typewriter font family & \ttfamily{Typewriter font family} & {\ttfamily Typewriter font family}\\ \hline
	\end{tabular}
\end{table}

\begin{table}
	\caption{Font shape}\vspace{1em}
	\begin{tabular}{|l|l|l|}
		\hline
		Upright shape (default) & \textup{Upright shape} & {\upshape Upright shape}\\ \hline
		Italic shape & \textit{Italic shape} & {\itshape Italic shape}\\ \hline
		Slanted shape & \textsl{Slanted shape} & {\slshape Slanted shape}\\ \hline
		Small capitals shape & \textsc{Small capitals shape} & {\scshape Small capitals shape}\\ \hline
	\end{tabular}
\end{table}

\begin{table}
	\caption{Font series}\vspace{1em}
	\begin{tabular}{|l|l|l|}
		\hline
		Medium series (default) & \textmd{Medium series} & {\mdseries Medium series}\\ \hline
		Bold extended series & \textbf{Bold extended series} & {\bfseries Bold extended series}\\ \hline
	\end{tabular}
\end{table}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121733866.png" alt="image-20250112173335786" style="width:50%;" />

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121733142.png" alt="image-20250112173347105" style="width:50%;" />

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121734300.png" alt="image-20250112173405248" style="width:50%;" />

<br>

**References**

- [Font sizes, families, and styles](https://www.overleaf.com/learn/latex/Font_sizes%2C_families%2C_and_styles).

[^1]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 62-64.
[^2]: [LaTeX Font Size Commands](/2024-05-31/12-32-43.html).