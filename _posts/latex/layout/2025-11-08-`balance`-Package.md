---
title: LaTeX `balance` Package --- Align the bottom of last page in two-column document
toc: false
categories:
 - LaTeX
tags:
 - LaTeX balance
 - LaTeX Layout
location: Buffalo, United States
date: 2025-11-08 11:18:31 -0500
last_modified_at: 2025-11-10 13:26:13 -0500
gallery:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251108120038550.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251108120044661.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251108120117744.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251108120128844.png
---

In LaTeX two-column document (such as `IEEEtran` class), we can use the `balance` package to align the bottom of last page, which is realized by `\balance` command and can be canceled by `\nobalance` command[^1][^2]:

```latex
\documentclass[balance]{IEEEtran}
\usepackage{lipsum}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{balance}

\begin{document}
	\lipsum\lipsum
	
	\balance
	
	\cleardoublepage
	\lipsum\lipsum
	\nobalance
\end{document}
```

{% include gallery id="gallery" layout="half" %}

<br>

**References**

[^1]: [balance.pdf](https://ctan.mirrors.hoobly.com/macros/latex/contrib/preprint/balance.pdf).
[^2]: [CTAN: Package `balance`](https://ctan.org/pkg/balance?lang=en).
