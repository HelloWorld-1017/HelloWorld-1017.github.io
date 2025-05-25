---
title: Change the Paper Size in the Middle of A Document in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - TeX
 - LaTeX Layout
 - LaTeX geometry
date: 2025-05-23 22:03:50 +0800
last_modified_at: 2025-05-25 19:55:34 +0800
gallery:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251944640.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251944428.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251944532.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251944600.png
gallery1:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251950664.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251951717.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251951370.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251951293.png
gallery2:
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251952035.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251952477.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251953759.png
 - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505251953191.png
---

In LaTeX, we can use the `\newgeometry` command to change the page layout in the middle of a document, and then use the `\restoregeometry` command to restore the layout specified in the preamble. Both of these two commands are from the `geometry` package[^1], and here is an example from the documentation of the package.

```latex
\documentclass{article}
\usepackage[hmargin=3cm]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\begin{document}

\lipsum[1-6]

\newgeometry{left=3cm,right=1cm,bottom=0.1cm}
\lipsum[1-6]
\restoregeometry

\newgeometry{margin=1cm,includefoot}
\lipsum[1-6]
\restoregeometry

\lipsum[1-6]

\end{document}
```

{% include gallery id="gallery" layout="half" %}

However, the `\newgeometry` command doesn’t support changing paper size and other papersize-related options:

<div class="quote--left" markdown="1">

`\newgeometry` is almost similar to `\geometry` except that `\newgeometry` disables all the options specified in the preamble and skips the papersize-related options: `landscape`, `portrait` and paper size options (such as `papersize`, `paper=a4paper` and so forth).[^1]

</div>

<div class="quote--left" markdown="1">

The options for the layout size are available in `\newgeometry`, so that you can change the layout size in the middle of the document. The paper size itself can’t be changed though.[^2]

</div>

So, if we want to the change paper size in the middle of a document, we should look for other methods. David Carlisle provides one[^3], and based on his method, I realized changing the paper size from `a4paper` to `b4paper` as below.

```latex
\documentclass{article}
\usepackage[a4paper,margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\begin{document}
\lipsum

\clearpage
\edef\hmm{\pdfpagewidth=\the\pdfpagewidth \pdfpageheight=\the\pdfpageheight\relax}

% ISO B4
\pdfpagewidth=250mm
\pdfpageheight=353mm
\newgeometry{margin=0.1in,top=1in,textwidth=240mm,textheight=330mm}
\oddsidemargin=0mm

\lipsum\lipsum\lipsum
 
\restoregeometry
\hmm

\lipsum

\end{document}
```

{% include gallery id="gallery1" layout="half" %}

where `\edef`[^4] and `\relax`[^5][^6] are two TeX macros.

<br>

Besides, we can make the orientation of above B4 papers as landscape[^7]:

```latex
\documentclass{article}
\usepackage[a4paper,margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}
\usepackage{pdflscape}

\begin{document}
\lipsum

\clearpage
\edef\hmm{\pdfpagewidth=\the\pdfpagewidth \pdfpageheight=\the\pdfpageheight\relax}

% ISO B4
\pdfpagewidth=250mm
\pdfpageheight=353mm
\newgeometry{margin=0.1in,top=1in,textwidth=240mm,textheight=330mm}
\oddsidemargin=0mm

\begin{landscape}
	\lipsum\lipsum\lipsum
\end{landscape}

\restoregeometry
\hmm

\lipsum

\end{document}
```

{% include gallery id="gallery2" layout="half" %}

<br>

**References**

[^1]: [The `geometry` package](https://faculty.bard.edu/bloch/geometry.pdf).
[^2]: [steeven9.github.io/USI-LaTeX/html/packages\_geometry.html](https://steeven9.github.io/USI-LaTeX/html/packages_geometry.html).
[^3]: [https://tex.stackexchange.com/a/622310/306224](https://tex.stackexchange.com/a/622310/306224).
[^4]: [TeX/edef](https://en.wikibooks.org/wiki/TeX/edef).
[^5]: [macros - What does \relax do?](https://tex.stackexchange.com/questions/96501/what-does-relax-do).
[^6]: [TeX/relax](https://en.wikibooks.org/wiki/TeX/relax).
[^7]: [Make the Document Orientation as "Landscape" in LaTeX](/2025-01-12/18-51-16.html).
