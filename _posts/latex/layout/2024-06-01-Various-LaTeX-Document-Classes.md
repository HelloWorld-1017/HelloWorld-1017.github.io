---
title: Various LaTeX Document Classes
categories:
 - Design
 - LaTeX
tags:
 - LaTeX Beamer
 - LaTeX eso-pic
 - LaTex fgruler
 - LaTeX Layout
 - LaTeX showframe
 - Microsoft Word
date: 2024-06-01 13:20:33 +0800
last_modified_at: 2025-01-11 21:13:20 +0800
---

# article

## default

```latex
\documentclass{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[type=upperleft]{fgruler}
\usepackage{layout}

\begin{document}
	\layout
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112038010.png)

```latex
\documentclass{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[grid,
	gridcolor=black!20,
	subgridcolor=black!20,
	gridunit=cm]{eso-pic}
\usepackage[type=upperleft]{fgruler}
\usepackage{showframe,lipsum}
\usepackage{changes}
\definechangesauthor[name={coauthor1},color=orange]{Ma}
\definechangesauthor[name={coauthor2},color=red]{Tommy}

\begin{document}
	\lipsum[1-3] 
	
	This is \added[id=Ma,comment={This is added by Ma.}]{added} text.
	
	This is \added[comment={This is added by Tommy.}]{added} text.
	
	This is \deleted[id=Tommy,comment={This is deleted by Tommy.}]{deleted} text.
	
	This is a \replaced{replacement}{replace}.
	
	\listofchanges
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112039177.png)

## a4paper

```latex
\documentclass[a4paper]{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[type=upperleft]{fgruler}
\usepackage{layout}

\begin{document}
	\layout
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112041615.png)

```latex
\documentclass[a4paper]{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[grid,
	gridcolor=black!20,
	subgridcolor=black!20,
	gridunit=cm]{eso-pic}
\usepackage[type=upperleft]{fgruler}
\usepackage{showframe,lipsum}
\usepackage{changes}
\definechangesauthor[name={coauthor1},color=orange]{Ma}
\definechangesauthor[name={coauthor2},color=red]{Tommy}

\begin{document}
	\lipsum[1-3] 
	
	This is \added[id=Ma,comment={This is added by Ma.}]{added} text.
	
	This is \added[comment={This is added by Tommy.}]{added} text.
	
	This is \deleted[id=Tommy,comment={This is deleted by Tommy.}]{deleted} text.
	
	This is a \replaced{replacement}{replace}.
	
	\listofchanges
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112041765.png)

## a4paper, margin

For Microsoft Word[^1]:

<div class="quote--left" markdown="1">

When your document is set to A4 paper, Microsoft Word sets the TOP and BOTTOM margins to 2.54 cm (1 inch) and the LEFT and RIGHT margins to 3.17 cm (1.25 inches). These settings can be adjusted as required, but it is unwise to set margins below 1.5 cm.

</div>

```latex
\documentclass{article}
\usepackage{geometry}
\geometry{a4paper,
	left=1.25in,
	right=1.25in,
	top=1in,
	bottom=1in}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[type=upperleft]{fgruler}
\usepackage{layout}

\begin{document}
	\layout
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112046558.png)

```latex
\documentclass{article}
\usepackage{geometry}
\geometry{a4paper,
	left=1.25in,
	right=1.25in,
	top=1in,
	bottom=1in}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[grid,
	gridcolor=black!20,
	subgridcolor=black!20,
	gridunit=cm]{eso-pic}
\usepackage[type=upperleft]{fgruler}
\usepackage{showframe,lipsum}
\usepackage{changes}
\definechangesauthor[name={coauthor1},color=orange]{Ma}
\definechangesauthor[name={coauthor2},color=red]{Tommy}

\begin{document}
	\lipsum[1-3] 
	
	This is \added[id=Ma,comment={This is added by Ma.}]{added} text.
	
	This is \added[comment={This is added by Tommy.}]{added} text.
	
	This is \deleted[id=Tommy,comment={This is deleted by Tommy.}]{deleted} text.
	
	This is a \replaced{replacement}{replace}.
	
	\listofchanges
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112046162.png)

## a4paper, margin, 12 pt

```latex
\documentclass[12pt]{article}
\usepackage{geometry}
\geometry{a4paper,
	left=1.25in,
	right=1.25in,
	top=1in,
	bottom=1in}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[type=upperleft]{fgruler}
\usepackage{layout}

\begin{document}
	\layout
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112048518.png)

```latex
\documentclass[12pt]{article}
\usepackage{geometry}
\geometry{a4paper,
	left=1.25in,
	right=1.25in,
	top=1in,
	bottom=1in}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[grid,
	gridcolor=black!20,
	subgridcolor=black!20,
	gridunit=cm]{eso-pic}
\usepackage[type=upperleft]{fgruler}
\usepackage{showframe,lipsum}
\usepackage{changes}
\definechangesauthor[name={coauthor1},color=orange]{Ma}
\definechangesauthor[name={coauthor2},color=red]{Tommy}

\begin{document}
	\lipsum[1-3] 
	
	This is \added[id=Ma,comment={This is added by Ma.}]{added} text.
	
	This is \added[comment={This is added by Tommy.}]{added} text.
	
	This is \deleted[id=Tommy,comment={This is deleted by Tommy.}]{deleted} text.
	
	This is a \replaced{replacement}{replace}.
	
	\listofchanges
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112049342.png)

## a5paper

```latex
\documentclass[a5paper]{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[type=upperleft]{fgruler}
\usepackage{layout}

\begin{document}
	\layout
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112051276.png)

```latex
\documentclass[a5paper]{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[grid,
	gridcolor=black!20,
	subgridcolor=black!20,
	gridunit=cm]{eso-pic}
\usepackage[type=upperleft]{fgruler}
\usepackage{showframe,lipsum}
\usepackage{changes}
\definechangesauthor[name={coauthor1},color=orange]{Ma}
\definechangesauthor[name={coauthor2},color=red]{Tommy}

\begin{document}
	\lipsum[1-3] 
	
	This is \added[id=Ma,comment={This is added by Ma.}]{added} text.
	
	This is \added[comment={This is added by Tommy.}]{added} text.
	
	This is \deleted[id=Tommy,comment={This is deleted by Tommy.}]{deleted} text.
	
	This is a \replaced{replacement}{replace}.
	
	\listofchanges
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112052525.png)

![img-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112052965.png)

## b5paper

```latex
\documentclass[b5paper]{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[type=upperleft]{fgruler}
\usepackage{layout}

\begin{document}
	\layout
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112054968.png)

```latex
\documentclass[b5paper]{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[grid,
	gridcolor=black!20,
	subgridcolor=black!20,
	gridunit=cm]{eso-pic}
\usepackage[type=upperleft]{fgruler}
\usepackage{showframe,lipsum}
\usepackage{changes}
\definechangesauthor[name={coauthor1},color=orange]{Ma}
\definechangesauthor[name={coauthor2},color=red]{Tommy}

\begin{document}
	\lipsum[1-3] 
	
	This is \added[id=Ma,comment={This is added by Ma.}]{added} text.
	
	This is \added[comment={This is added by Tommy.}]{added} text.
	
	This is \deleted[id=Tommy,comment={This is deleted by Tommy.}]{deleted} text.
	
	This is a \replaced{replacement}{replace}.
	
	\listofchanges
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112054809.png)

![img-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112054336.png)

<br>

# IEEEtran

```latex
\documentclass{IEEEtran}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[type=upperleft]{fgruler}
\usepackage{layout}

\begin{document}
	\layout
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112056122.png)

```latex
\documentclass{IEEEtran}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[grid,
	gridcolor=black!20,
	subgridcolor=black!20,
	gridunit=cm]{eso-pic}
\usepackage[type=upperleft]{fgruler}
\usepackage{showframe,lipsum}
\usepackage{changes}
\definechangesauthor[name={coauthor1},color=orange]{Ma}
\definechangesauthor[name={coauthor2},color=red]{Tommy}

\begin{document}
	\lipsum[1-7] 
	
	This is \added[id=Ma,comment={This is added by Ma.}]{added} text.
	
	This is \added[comment={This is added by Tommy.}]{added} text.
	
	This is \deleted[id=Tommy,comment={This is deleted by Tommy.}]{deleted} text.
	
	This is a \replaced{replacement}{replace}.
	
	\listofchanges
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112057792.png)

<br>

# beamer

```latex
\documentclass{beamer}
\usepackage[type=upperleft]{fgruler}
\usepackage{layout}

\begin{document}
	\layout
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112100324.png)

```latex
\documentclass{beamer}
\usepackage[grid,
	gridcolor=black!20,
	subgridcolor=black!20,
	gridunit=cm]{eso-pic}
\usepackage[type=upperleft]{fgruler}
\usepackage{showframe,lipsum}

\begin{document}
	\lipsum[1]
\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501112101043.png)

<br>

**References**

- [CTAN: Package `layout`](https://ctan.org/pkg/layout?lang=en).
- [CTAN: Package `showframe`](https://ctan.org/pkg/showframe).
- [LaTeX/Page Layout](https://en.wikibooks.org/wiki/LaTeX/Page_Layout).

[^1]: [Word\_ch6.pdf](https://gct.com.au/SampleFiles/word/Word_ch6.pdf).

