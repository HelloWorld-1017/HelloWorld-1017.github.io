---
title: Change LaTeX Compiler in Overleaf
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Font
 - LaTeX fontspec
 - pdfTeX
 - XeTeX
location: Buffalo, United States
date: 2025-11-06 09:43:30 -0500
last_modified_at: 2025-11-07 21:27:08 -0500
---

Sometimes, we may have to use TeX engine XeLaTeX to compile LaTeX document; for example, specify the typeface as Arial for the whole document[^1] (the way of using XeLaTeX in TeXStudio can also be found in blog[^1]):

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

However, Overleaf uses pdfLaTeX as a default engine (the same as TeXStudio), so when running the above script, some errors will occur:

![image-20251106162909570](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251106162916821.png)

So at this time, we need to change TeX engine as XeLaTeX to solve this problem. Here is the method:

First, click `Menu` in the left top corner:

![image-20251106163049304](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251106163049525.png)

Then, change the compiler from `pdfLaTeX` to `XeLaTeX` in the `Settings` part:

![image-20251106163138269](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251106163138529.png)

Finally, recompile the document at this time, we'll get a normal output:

![image-20251106163308542](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251106163308856.png)

Bingo\~

<br>

**References**

[^1]: [Specify Typeface as Arial for the Whole Document in LaTeX](/2024-11-12/15-59-38.html).