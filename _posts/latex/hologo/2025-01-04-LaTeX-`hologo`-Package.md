---
title: LaTeX `hologo` Package
toc: false
categories:
 - LaTeX
tags:
 - LaTeX hologo
 - LaTeX longtable
 - LaTeX Table
date: 2025-01-04 12:32:02 +0800
last_modified_at: 2025-01-04 12:32:02 +0800
---

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\geometry{a4paper}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[colorlinks=true]{hyperref}
\usepackage{longtable,booktabs}
\usepackage{hologo}

\begin{document}
\begin{longtable}{ll}
	\toprule
	\textbf{Command} & \textbf{Logo} \\
	\midrule
	\endfirsthead
	\multicolumn{2}{r}{(Continued)}\\
	\toprule
	\textbf{Command} & \textbf{Logo} \\
	\midrule
	\endhead
	\hline
	\endfoot
	\hline
	\endlastfoot
	\verb*|\hologo{(La)TeX}| & \hologo{(La)TeX} \\
	\verb*|\hologo{AmSLaTeX}| & \hologo{AmSLaTeX} \\
	\verb*|\hologo{AmSTeX}| & \hologo{AmSTeX} \\
	\verb*|\hologo{biber}| & \hologo{biber} \\
	\verb*|\hologo{BibTeX}| & \hologo{BibTeX} \\
	\verb*|\hologoVariant{BibTeX}{sf}| & \hologoVariant{BibTeX}{sf}\\
	\verb*|\hologoVariant{BibTeX}{sc}| & \hologoVariant{BibTeX}{sc}\\
	\verb*|\hologo{BibTeX8}| & \hologo{BibTeX8}\\
	\verb*|\hologo{ConTeXt}| & \hologo{ConTeXt}\\
	\verb*|\hologoVariant{ConTeXt}{narrow}| & \hologoVariant{ConTeXt}{narrow}\\
	\verb*|\hologoVariant{ConTeXt}{simple}| & \hologoVariant{ConTeXt}{simple}\\
	\verb*|\hologo{emTeX}| & \hologo{emTeX}\\
	\verb*|\hologo{eTeX}| & \hologo{eTeX}\\
	\verb*|\hologo{ExTeX}| & \hologo{ExTeX}\\
	\verb*|\hologo{HanTheThanh}| & \hologo{HanTheThanh}\\
	\verb*|\hologo{iniTeX}| & \hologo{iniTeX}\\
	\verb*|\hologo{KOMAScript}| & \hologo{KOMAScript}\\
	\verb*|\hologo{La}| & \hologo{La}\\
	\verb*|\hologo{LaTeX}| & \hologo{LaTeX}\\
	\verb*|\hologo{LaTeX2e}| & \hologo{LaTeX2e}\\
	\verb*|\hologo{LaTeX3}| & \hologo{LaTeX3}\\
	\verb*|\hologo{LaTeXe}| & \hologo{LaTeXe}\\
	\verb*|\hologo{LaTeXML}| & \hologo{LaTeXML}\\
	\verb*|\hologo{LaTeXTeX}| & \hologo{LaTeXTeX}\\
	\verb*|\hologo{LuaLaTeX}| & \hologo{LuaLaTeX}\\
	\verb*|\hologo{LuaTeX}| & \hologo{LuaTeX}\\
	\verb*|\hologo{LyX}| & \hologo{LyX}\\
	\verb*|\hologo{METAFONT}| & \hologo{METAFONT}\\
	\verb*|\hologo{MetaFun}| & \hologo{MetaFun}\\
	\verb*|\hologo{METAPOST}| & \hologo{METAPOST}\\
	\verb*|\hologo{MetaPost}| & \hologo{MetaPost}\\
	\verb*|\hologo{MiKTeX}| & \hologo{MiKTeX}\\
	\verb*|\hologo{NTS}| & \hologo{NTS}\\
	\verb*|\hologo{OzMF}| & \hologo{OzMF}\\
	\verb*|\hologo{OzMP}| & \hologo{OzMP}\\
	\verb*|\hologo{OzTeX}| & \hologo{OzTeX}\\
	\verb*|\hologo{OzTtH}| & \hologo{OzTtH}\\
	\verb*|\hologo{PCTeX}| & \hologo{PCTeX}\\
	\verb*|\hologo{pdfTeX}| & \hologo{pdfTeX}\\
	\verb*|\hologo{pdfLaTeX}| & \hologo{pdfLaTeX}\\
	\verb*|\hologo{PiC}| & \hologo{PiC}\\
	\verb*|\hologo{PiCTeX}| & \hologo{PiCTeX}\\
	\verb*|\hologo{plainTeX}| & \hologo{plainTeX}\\
	\verb*|\hologoVariant{plainTeX}{space}| & \hologoVariant{plainTeX}{space}\\
	\verb*|\hologoVariant{plainTeX}{hyphen}| & \hologoVariant{plainTeX}{hyphen}\\
	\verb*|\hologoVariant{plainTeX}{runtogether}| & \hologoVariant{plainTeX}{runtogether}\\
	\verb*|\hologo{SageTeX}| & \hologo{SageTeX}\\
	\verb*|\hologo{SLiTeX}| & \hologo{SLiTeX}\\
	\verb*|\hologoVariant{SLiTeX}{lift}| & \hologoVariant{SLiTeX}{lift}\\
	\verb*|\hologoVariant{SLiTeX}{narrow}| & \hologoVariant{SLiTeX}{narrow}\\
	\verb*|\hologoVariant{SLiTeX}{simple}| & \hologoVariant{SLiTeX}{simple}\\
	\verb*|\hologo{SliTeX}| & \hologo{SLiTeX}\\
	\verb*|\hologoVariant{SliTeX}{narrow}| & \hologoVariant{SliTeX}{narrow}\\
	\verb*|\hologoVariant{SliTeX}{simple}| & \hologoVariant{SliTeX}{simple}\\
	\verb*|\hologoVariant{SliTeX}{lift}| & \hologoVariant{SliTeX}{lift}\\
	\verb*|\hologo{teTeX}| & \hologo{teTeX}\\
	\verb*|\hologo{TeX}| & \hologo{TeX}\\
	\verb*|\hologo{TeX4ht}| & \hologo{TeX4ht}\\
	\verb*|\hologo{TTH}| & \hologo{TTH}\\
	\verb*|\hologo{virTeX}| & \hologo{virTeX}\\
	\verb*|\hologo{VTeX}| & \hologo{VTeX}\\
	\verb*|\hologo{Xe}| & \hologo{Xe}\\
	\verb*|\hologo{XeLaTeX}| & \hologo{XeLaTeX}\\
	\verb*|\hologo{XeTeX}| & \hologo{XeTeX}\\
	\bottomrule
\end{longtable}
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501041233272.png)

![img-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501041233727.png)

<br>

**References**

- [CTAN: Package `hologo`](https://ctan.org/pkg/hologo?lang=en).