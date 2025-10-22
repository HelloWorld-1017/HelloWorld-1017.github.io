---
title: LaTeX Commands `\multicolumn` and `\multirow` --- Merge multiple table cells horizentally and vertically
toc: false
categories:
 - LaTeX
tags:
 - LaTeX multirow
 - LaTeX Table
location: Buffalo, United States
date: 2025-10-22 00:00:21 -0400
last_modified_at: 2025-10-22 00:00:21 -0400
---

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\usepackage{multirow}

\begin{document}
\begin{table}
\centering
	\begin{tabular}{|c|c|c|c|}
		\hline
		xxx & \multicolumn{3}{|c|}{xxx}\\ \hline
		\multirow{3}{*}{xxx} & & & \\ \cline{2-4}
		& & \multicolumn{2}{|c|}{\multirow{2}{*}{xxx}} \\ \cline{2-2}
		& & \multicolumn{2}{|c|}{} \\ \hline
	\end{tabular}
\end{table}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251022000318720.png" alt="image-20251022000318616" style="width:50%;" />

<br>