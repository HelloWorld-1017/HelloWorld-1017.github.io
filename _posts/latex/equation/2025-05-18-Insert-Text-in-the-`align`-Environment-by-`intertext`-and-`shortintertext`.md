---
title: Insert Text in the `align` Environment by `\intertext` and `\shortintertext` in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
 - LaTeX mathtools
date: 2025-05-18 17:53:32 +0800
last_modified_at: 2025-05-23 16:15:17 +0800
---

In LaTeX, we can use commands  `\intertext` or `\shortintertext` to insert text in the `align` environment, and the benefit of which ways is that these two commands won’t break the equation alignments created by the `align` environment[^1]:

```latex
\documentclass{article}
\usepackage{amsmath,mathtools}

\begin{document}

\begin{align}
x^2 + 2x &= -1
\intertext{after moving $-1$ from the right side to the left side, we have:}
x^2 + 2x + 1 &= 0
\end{align}

\begin{align}
x^2 + 2x &= -1
\shortintertext{after moving $-1$ from the right side to the left side, we have:}
x^2 + 2x + 1 &= 0
\end{align}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505190946056.png" alt="image-20250519094623936" style="width:67%;" />

As can be seen, the line spacing between two equations is smaller when using `\shortintertext` command. And note that, the `\shortintertext` command is from the `mathtools` package, so we should import it in the preamble in advance.

By the way, these two commands don’t work as above in the `split` environment although they won’t incur errors:

```latex
\documentclass{article}
\usepackage{amsmath,mathtools}

\begin{document}

\begin{equation}
\begin{split}
x^2 + 2x &= -1
\intertext{after moving $-1$ from the right side to the left side, we have:}
x^2 + 2x + 1 &= 0
\end{split}
\end{equation}

\begin{equation}
\begin{split}
x^2 + 2x &= -1
\shortintertext{after moving $-1$ from the right side to the left side, we have:}
x^2 + 2x + 1 &= 0
\end{split}
\end{equation}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505190952696.png" alt="image-20250519095236635" style="width:67%;" />

<br>

**References**

[^1]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, p. 266.
