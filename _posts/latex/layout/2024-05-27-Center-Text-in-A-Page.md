---
title: Center Text Vertically in A Page in LaTeX Using `\vspace*` Command
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Layout
date: 2024-05-27 21:22:43 +0800
last_modified_at: 2025-11-10 23:55:28 -0500
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

Note that, we should use `\vspace*` command rather than `\vspace`, otherwise we can't get expected results. For example:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}

\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{showframe}

\begin{document}
	
\vspace{\fill}
\lipsum[1-2]
\vspace{\fill}

\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251110235346606.png)

This is because[^1]:

<div class="quote--left" markdown="1">

The command `\vspace` is used to add vertical space between lines, paragraphs, or sections. It works well in the middle of a page, but at the start or end of a page, LaTeX may ignore it.

The command `\vspace*` is a stronger version. Unlike `\vspace`, it does not get ignored at the top or bottom of a page. This makes it perfect when you must ensure extra space stays visible in all positions.

</div>

**References**

- [LaTeX如何将页面内容设置在正中心？](https://www.zhihu.com/question/303812076/answer/540251166).

[^1]: [Difference between `vspace` and `vspace*` in LaTeX](https://www.physicsread.com/vspace-vs-vspace-star-latex/).
