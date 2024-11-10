---
title: Center Text in A Page in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Page Settings
date: 2024-05-27 21:22:43 +0800
last_modified_at: 2024-11-08 21:32:48 +0800
---

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}

\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{showframe}

\begin{document}
	\vspace*{\fill}
	
	\lipsum[1-2]
	
	\vspace*{\fill}
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411082306445.png)

<br>

**References**

- [LaTeX如何将页面内容设置在正中心？](https://www.zhihu.com/question/303812076/answer/540251166).
