---
title: Increase the Maximum Number of Matrix Columns when Using LaTeX `\bmatrix` Environment
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
date: 2025-05-12 21:33:32 +0800
last_modified_at: 2025-05-13 10:16:55 +0800
---

In LaTeX, when we use the `\bmatrix` environment to type mathematical matrices, we should note that the `\bmatrix` by default only supports matrices whose number of columns is less than or equal to 10[^1]. If not:

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath}

\begin{document}

\begin{equation}
\begin{bmatrix}
1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 \\
1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 \\
1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 \\
1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 \\
1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 \\
1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 & 11 & 12 & 13 & 14 & 15 \\
\end{bmatrix}
\end{equation}

\end{document}
```

an error will occur:

```
Extra alignment tab has been changed to \cr. 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 & 10 &
```

and the generated result is:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505131013840.png" alt="image-20250513101308744" style="width:50%;" />

which is not as we expect.

To solve this problem, we can add such a command in the preamble[^2]:

```latex
\addtocounter{MaxMatrixCols}{10}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505131015939.png" alt="image-20250513101511852" style="width:50%;" />

or the command[^3]:

```latex
\setcounter{MaxMatrixCols}{20}
```

<br>

**References**

[^1]: [https://stackoverflow.com/a/2789482/22763127](https://stackoverflow.com/a/2789482/22763127).
[^2]: [106-Latex矩阵过大问题](https://blog.csdn.net/Pro2015/article/details/100126089).
[^3]: [https://stackoverflow.com/a/68628959/22763127](https://stackoverflow.com/a/68628959/22763127).
