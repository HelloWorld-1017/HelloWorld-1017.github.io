---
title: Specify Typeface as Arial for the Whole Document in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Font
 - LaTeX fontspec
 - LaTeX Warnings and Errors
 - LuaLaTeX
 - TeXstudio
 - XeLaTeX
date: 2024-11-12 15:59:38 +0800
last_modified_at: 2024-11-12 15:59:38 +0800
---

YouTube video[^1] provides a way to globally specify typeface as Arial in a LaTeX document, that is using `\setmainfont` commands provided by `fontspec` package[^2]:

```latex
\usepackage{fontspec}
\setmainfont{Arial}
```

A complete example is like:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}

\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{fontspec}
\setmainfont{Arial}

\begin{document}
	\lipsum[1-8]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411121620612.png)

But, it should be noted that `fontspec` package is for compilers XeLaTeX and LuaLaTeX[^2]. For example, the following error occurred when I made the first compilation:

```
Fatal Package fontspec Error: The fontspec package requires either XeTeX or(fontspec) LuaTeX. \msg_fatal:nn {fontspec} {cannot-use-pdftex}
Emergency stop. \msg_fatal:nn {fontspec} {cannot-use-pdftex}
```

because I used pdfLaTeX. It works after I changing the compiler[^3]: in `Options > Configure TeXstudio > Build > Default Compiler` from my previous setting `txs:///pdflatex` to `txs:///xelatex`. 

<br>

**References**

[^1]: [How to change font to Arial in LaTeX](https://www.youtube.com/watch?v=e25NDs5D9PI).
[^2]: [CTAN: Package fontspec](https://ctan.org/pkg/fontspec?lang=en).
[^3]: [An XeLaTeX Compilation Error: `Undefined control sequence. \pdfglyphtounicode`](/2024-07-24/16-47-47.html).