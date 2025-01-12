---
title: Make the Document Orientation as \"Landscape\" in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Layout
 - LaTeX lscape
 - LaTeX pdflscape
date: 2025-01-12 18:51:16 +0800
last_modified_at: 2025-01-12 18:51:16 +0800
gallery:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121857906.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121858387.png
gallery1:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121902412.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121902096.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121903745.png
gallery2:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121904435.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121904851.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501121904066.png
---

**(1) For the whole document**[^1]

```latex
\documentclass[a4paper,landscape]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\begin{document}
	\lipsum[1-16]
\end{document}
```

{% include gallery id="gallery" layout="half" %}

**(2) For a few pages**[^1]

By `landscape` environment of `lscape` package:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\usepackage{lscape}

\begin{document}
\lipsum[1-7]

\begin{landscape}
	\lipsum[8-23]
\end{landscape}
\end{document}
```

{% include gallery id="gallery1" layout="third" %}

By `landscape` environment of `pdflscape` package:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\usepackage{pdflscape}

\begin{document}
\lipsum[1-7]

\begin{landscape}
	\lipsum[8-23]
\end{landscape}
\end{document}
```

{% include gallery id="gallery2" layout="third" %}

<br>

**References**

- [How to change certain pages into landscape/portrait mode](https://tex.stackexchange.com/questions/337/how-to-change-certain-pages-into-landscape-portrait-mode).

[^1]: [Landscape in Latex](https://texblog.org/2007/11/10/landscape-in-latex/).

