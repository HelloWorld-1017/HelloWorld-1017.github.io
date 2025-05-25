---
title: Adjust the Row Height of the Table in LaTeX 
toc: false
categories:
 - LaTeX
tags:
 - LaTeX array
 - LaTeX Box
 - LaTeX Table
date: 2025-05-24 22:29:47 +0800
last_modified_at: 2025-05-25 16:54:44 +0800
---

**Method 1**: by redefining the length `\arraystretch`[^1]

```latex
\documentclass{article}

\begin{document}

\begin{table}
\centering
\renewcommand{\arraystretch}{2}
\begin{tabular}{|c|c|c|}
\hline
a & b & c\\ \hline
3 & 4 & 5\\ \hline
5 & 12 & 13\\ \hline
\end{tabular}
\end{table}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251643367.png" alt="image-20250525164307324" style="width:50%;" />

<br>

**Method 2**: by the `\rule` command[^1]

```latex
\documentclass{article}

\begin{document}

\begin{table}
\centering
\begin{tabular}{|c|c|c|}
\hline
a & b & c\\ \hline
\rule{0pt}{25pt} 3 & 4 & 5\\ \hline
5 & 12 & 13\\ \hline
\end{tabular}
\end{table}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251645406.png" alt="image-20250525164544362" style="width:50%;" />

<br>

**Method 3**: by setting the length `\extrarowheight` provided by the `array` package

```latex
\documentclass{article}
\usepackage{array}

\begin{document}

\begin{table}
\centering
\setlength\extrarowheight{2em}
\begin{tabular}{|c|c|c|}
\hline
a & b & c\\ \hline
3 & 4 & 5\\ \hline
5 & 12 & 13\\ \hline
\end{tabular}
\end{table}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251647707.png" alt="image-20250525164711665" style="width:50%;" />

<br>

**Method 4**: by the `\\` command

```latex
\documentclass{article}

\begin{document}

\begin{table}
\centering
\begin{tabular}{|c|c|c|}
\hline
a & b & c\\ \hline
3 & 4 & 5 \\[10pt] \hline
5 & 12 & 13 \\ \hline
\end{tabular}
\end{table}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251649669.png" alt="image-20250525164909623" style="width:50%;" />

which is the same as the way of adjusting the line spacing of multiple-equation environments[^3].

<br>

**Method 5**: by the `\parbox` command[^2]

```latex
\documentclass{article}

\begin{document}

\begin{table}
\centering
\begin{tabular}{|c|c|c|}
\hline
a & b & c\\ \hline
\parbox[c][50pt][c]{50pt}{\centering 3} & 4 & 5 \\ \hline
5 & 12 & 13 \\ \hline
\end{tabular}
\end{table}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251651323.png" alt="image-20250525165120272" style="width:50%;" />

<br>

**References**

[^1]: [changing row height](https://www.sascha-frank.com/Faq/tables_four.html).
[^2]: [`\parbox` (LaTeX2e unofficial reference manual (January 2025))](https://latexref.xyz/_005cparbox.html).
[^3]: [Adjust the Line Spacing of Multiple-Equation Environments in LaTeX](/2025-05-19/15-29-06.html).

