---
title: Style Chapter Format in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX titlesec
date: 2025-01-04 15:28:02 +0800
last_modified_at: 2025-01-04 15:28:02 +0800
---

The original style:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{blindtext}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\begin{document}
	\blinddocument
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501041532853.png)

![img-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501041532773.png)

A simple style specified using `titlesec` package:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{blindtext}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{titlesec}

\titleformat{\section}{
  \vspace{-4pt}\scshape\centering\large
}{\S~\thesection\quad}{0em}{}[\color{red}\titlerule\vspace{-5pt}]

\titleformat{\subsection}{
  \vspace{-4pt}\sffamily\raggedright\large
}{\S~\thesubsection\quad}{1em}{}[\color{green}\titlerule\vspace{-5pt}]

\titleformat{\subsubsection}{
  \vspace{-4pt}\bfseries\itshape\raggedright\large
}{\S~\thesubsubsection\quad}{3em}{}[\color{blue}\titlerule\vspace{-5pt}]

\begin{document}
	\blinddocument
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501041533731.png)

![img-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501041533128.png)

<br>

**References**

- [CTAN: Package `titlesec`](https://ctan.org/pkg/titlesec?lang=en).
- [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 135-137.