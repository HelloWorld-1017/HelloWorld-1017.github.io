---
title: Compile LaTeX File Using Command Line
toc: false
categories:
 - LaTeX
tags:
 - dvips
 - LaTeX Tools
 - pdfTeX
 - PostScript
 - TeXstudio
date: 2025-01-16 16:40:21 +0800
last_modified_at: 2025-01-17 18:43:39 +0800
---

Before, I get used to using TeXstudio to compile LaTeX files. Actually, like other programming languages, we can compile LaTeX source files using command line[^1]. For example, if we have created a file named `doc.tex`[^6]:

```latex
\documentclass{article} % Starts an article
\usepackage{amsmath} % Imports amsmath
\title{\LaTeX} % Title

\begin{document} % Begins a document
\maketitle
\LaTeX{} is a document preparation system for
the \TeX{} typesetting program. It offers
programmable desktop publishing features and
extensive facilities for automating most
aspects of typesetting and desktop publishing,
including numbering and cross-referencing,
tables and figures, page layout,
bibliographies, and much more. \LaTeX{} was
originally written in 1984 by Leslie Lamport
and has become the dominant method for using
\TeX; few people write in plain \TeX{} anymore.
The current version is \LaTeXe.

% This is a comment, not shown in final output.
% The following shows typesetting power of LaTeX:
\begin{align}
	E_0 &= mc^2 \\
	E &= \frac{mc^2}{\sqrt{1-\frac{v^2}{c^2}}}
\end{align} 
\end{document}
```

then we can compile it using the command `latex`:

```powershell
latex doc.tex
```

so, we’ll get some printed information during the compilation:

```
This is pdfTeX, Version 3.141592653-2.6-1.40.23 (TeX Live 2021/W32TeX) (preloaded format=latex)
 restricted \write18 enabled.
entering extended mode
(./doc.tex
LaTeX2e <2021-11-15> patch level 1
L3 programming layer <2021-11-22>
(c:/texlive/2021/texmf-dist/tex/latex/base/article.cls
Document Class: article 2021/10/04 v1.4n Standard LaTeX document class
(c:/texlive/2021/texmf-dist/tex/latex/base/size10.clo))
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amstext.sty
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsgen.sty))
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsbsy.sty)
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsopn.sty))
(c:/texlive/2021/texmf-dist/tex/latex/l3backend/l3backend-dvips.def)
No file doc.aux.

LaTeX Warning: No \author given.

[1] (./doc.aux) )
Output written on doc.dvi (1 page, 1768 bytes).
Transcript written on doc.log.
```

and three output files:

```
doc.aux
doc.dvi
doc.log
```

where `doc.dvi` is the compiled file and the file extension `.dvi` stands for “device independent file format”[^2][^5].

Or, use the command `pdflatex`:

```powershell
pdflatex doc.tex
```

and then we have:

```
This is pdfTeX, Version 3.141592653-2.6-1.40.23 (TeX Live 2021/W32TeX) (preloaded format=pdflatex)
 restricted \write18 enabled.
entering extended mode
(./doc.tex
LaTeX2e <2021-11-15> patch level 1
L3 programming layer <2021-11-22>
(c:/texlive/2021/texmf-dist/tex/latex/base/article.cls
Document Class: article 2021/10/04 v1.4n Standard LaTeX document class
(c:/texlive/2021/texmf-dist/tex/latex/base/size10.clo))
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsmath.sty
For additional information on amsmath, use the `?' option.
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amstext.sty
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsgen.sty))
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsbsy.sty)
(c:/texlive/2021/texmf-dist/tex/latex/amsmath/amsopn.sty))
(c:/texlive/2021/texmf-dist/tex/latex/l3backend/l3backend-pdftex.def)
No file doc.aux.

LaTeX Warning: No \author given.

[1{c:/texlive/2021/texmf-var/fonts/map/pdftex/updmap/pdftex.map}] (./doc.aux) )
<c:/texlive/2021/texmf-dist/fonts/type1/public/amsfonts/cm/cmex10.pfb><c:/texli
ve/2021/texmf-dist/fonts/type1/public/amsfonts/cm/cmmi10.pfb><c:/texlive/2021/t
exmf-dist/fonts/type1/public/amsfonts/cm/cmmi7.pfb><c:/texlive/2021/texmf-dist/
fonts/type1/public/amsfonts/cm/cmr10.pfb><c:/texlive/2021/texmf-dist/fonts/type
1/public/amsfonts/cm/cmr12.pfb><c:/texlive/2021/texmf-dist/fonts/type1/public/a
msfonts/cm/cmr17.pfb><c:/texlive/2021/texmf-dist/fonts/type1/public/amsfonts/cm
/cmr5.pfb><c:/texlive/2021/texmf-dist/fonts/type1/public/amsfonts/cm/cmr7.pfb><
c:/texlive/2021/texmf-dist/fonts/type1/public/amsfonts/cm/cmsy10.pfb>
Output written on doc.pdf (1 page, 88375 bytes).
Transcript written on doc.log.
```

and three files:

```
doc.aux
doc.log
doc.pdf
```

including the compiled file `doc.pdf`.

As can be seen, although commands `latex` and `pdflatex` use the same TeX engine (pdfTeX) and same formatting (LaTeX), the compiled file formats are different. This is the difference of these two commands[^3][^4].

<div class="notice--primary" markdown="1">

If we compile `doc.tex` in the TeXstudio, we’ll get an additional zip file, `doc.synctex.gz`[^7], compared to the case of using `pdflatex` command:

```
doc.aux
doc.log
doc.pdf
doc.synctex.gz
```

</div>

For the case of using command `latex`, we can take a step further. There are two options to convert the `.dvi` file to a `.pdf` file[^1][^3][^4]:

1. Use the command `dvips -o doc.ps doc.dvi` to convert `doc.dvi` file into a PostScript file `doc.ps`, and then the command `ps2pdf doc.ps` to convert `doc.ps` to `doc.pdf`;
2. Or, directly use the command `dvipdfm doc.dvi` to convert `doc.dvi` into `doc.pdf`.

The workflow of combining using commands `latex` and `dvips` is the oldest way (but it’s not that suitable for Chinese documents) and looks sort of complicated. That being said, there are still some western journals adopting this kind of method[^3][^4].

<br>

**References**

- [vim - Compiling a LaTeX document manually](https://tex.stackexchange.com/questions/16884/compiling-a-latex-document-manually).
- [compiling - How to compile a LaTeX document?](https://tex.stackexchange.com/questions/1596/how-to-compile-a-latex-document).

[^1]: [Compiling a (LaTeX) Document](https://guides.lib.wayne.edu/latex/compile).
[^2]: [Device independent file format](https://en.wikipedia.org/wiki/Device_independent_file_format).
[^3]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 31.
[^4]: [An XeLaTeX Compilation Error: `Undefined control sequence. \pdfglyphtounicode`](/2024-07-24/16-47-47.html).
[^5]: [TeX](https://en.wikipedia.org/wiki/TeX): A DVI file could then be either viewed on screen or converted to a suitable format for any of the various printers for which a device driver existed (printer support was generally not an operating system feature at the time that TeX was created).
[^6]: [LaTeX](https://en.wikipedia.org/wiki/LaTeX).
[^7]: [MLTeX EncTeX and SyncTeX TeX extensions: What does SyncTeX do?](https://www.overleaf.com/learn/latex/MLTeX_EncTeX_and_SyncTeX_TeX_extensions#What_does_SyncTeX_do?).
