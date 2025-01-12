---
title: Add Corner Marks and Watermark in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX crop
 - LaTeX draftwatermark
 - LaTeX fgruler
 - LaTeX Layout
date: 2025-01-10 13:12:12 +0800
last_modified_at: 2025-01-11 18:33:46 +0800
---

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[type=upperleft]{fgruler}

\usepackage{draftwatermark}
\SetWatermarkText{\sffamily Proofreading}
\SetWatermarkScale{2.7}
\SetWatermarkColor{red!50!white!50} 

\usepackage[
	cam,
	center,
	font=textsf,
	width=25truecm,
	height=33.7truecm
]{crop}

\usepackage{lipsum}

\begin{document}
	\lipsum[1-17]
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501101401661.png)

![img-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501101401717.png)

<br>

**References**

- [`crop` - How to get a fgruler on three sides of a page?](https://tex.stackexchange.com/questions/392389/how-to-get-a-fgruler-on-three-sides-of-a-page).
- [CTAN: Package `crop`](https://ctan.org/pkg/crop?lang=en).
- [CTAN: Package `draftwatermark`](https://ctan.org/pkg/draftwatermark?lang=en).
