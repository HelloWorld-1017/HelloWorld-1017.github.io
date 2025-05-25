---
title: Line Break in Text in LaTeX Equation Environments
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Box
 - LaTeX Equation
 - LaTeX stackengine
 - LaTeX Table
date: 2025-05-24 22:30:37 +0800
last_modified_at: 2025-05-25 17:16:25 +0800
---

**Method 1**: by the `\parbox` command[^1]

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{equation*}
\parbox{1cm}{The quick brown fox jumps over the lazy dog.}\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\vspace{5em}

\begin{equation*}
\parbox{3cm}{The quick brown fox jumps over the lazy dog.}\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\vspace{5em}

\begin{equation*}
\parbox{5cm}{The quick brown fox jumps over the lazy dog.}\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251045203.png" alt="image-20250525104539110" style="width:50%;" />

Besides, we can use the first argument, `position`, of the `\parbox` command to line up either the top or bottom line (the default position is the center)[^5][^6]:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{equation*}
\parbox[t]{3cm}{The quick brown fox jumps over the lazy dog.}\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\vspace{5em}

\begin{equation*}
\parbox[c]{3cm}{The quick brown fox jumps over the lazy dog.}\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\vspace{5em}

\begin{equation*}
\parbox[b]{3cm}{The quick brown fox jumps over the lazy dog.}\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251049788.png" alt="image-20250525104939700" style="width:50%;" />

<br>

**Method 2**: by the `tabular` environment[^2]

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{equation*}
\begin{tabular}{@{}l@{}}
The quick brown fox\\jumps over\\the lazy dog.
\end{tabular}
\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\vspace{5em}

\begin{equation*}
\begin{tabular}{@{}c@{}}
The quick brown fox\\jumps over\\the lazy dog.
\end{tabular}
\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\vspace{5em}

\begin{equation*}
\begin{tabular}{@{}r@{}}
The quick brown fox\\jumps over\\the lazy dog.
\end{tabular}
\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251052061.png" alt="image-20250525105213897" style="width:50%;" />

<br>

**Method 3**: by the `\Centerstack` command of the `stackengine` package[^3][^4]

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage[usestackEOL]{stackengine} 

\begin{document}

\begin{equation*}
\Centerstack[l]{The quick brown fox\\jumps over\\the lazy dog.}
\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\vspace{5em}

\begin{equation*}
\Centerstack[c]{The quick brown fox\\jumps over\\the lazy dog.}
\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\vspace{5em}

\begin{equation*}
\Centerstack[r]{The quick brown fox\\jumps over\\the lazy dog.}
\quad\Longleftrightarrow\quad
1+2=3
\end{equation*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251056240.png" alt="image-20250525105613178" style="width:50%;" />

<br>

**References**

[^1]: [https://tex.stackexchange.com/a/580266/306224](https://tex.stackexchange.com/a/580266/306224).
[^2]: [https://tex.stackexchange.com/a/580272/306224](https://tex.stackexchange.com/a/580272/306224).
[^3]: [https://tex.stackexchange.com/a/580269/306224](https://tex.stackexchange.com/a/580269/306224).
[^4]: [The `stackengine` Package](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/stackengine/stackengine.pdf).
[^5]: [LaTeX help 1.1 - `\parbox`](https://emerson.emory.edu/services/latex/latex_147.html).
[^6]: [`\parbox` (LaTeX2e unofficial reference manual (January 2025))](https://latexref.xyz/_005cparbox.html).