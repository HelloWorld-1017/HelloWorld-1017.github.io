---
title: Type Equations in LaTeX `standalone` Document 
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
 - LaTeX preview
 - LaTeX standalone
 - LaTeX TikZ
location: Buffalo, United States
date: 2025-11-12 16:09:10 -0500
last_modified_at: 2025-11-15 13:20:58 -0500
---

In LaTeX `standalone` Document, if we want to directly type equations:

```latex
\documentclass{standalone}
\usepackage{amsmath}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\begin{document}
	
\begin{equation}
	c = a+b
\end{equation}

\end{document}
```

we'll get errors:

```
doc.tex: error: 9: Missing $ inserted. \begin{equation}
doc.tex: error: 11: You can't use `\eqno' in math mode. \end{equation}
doc.tex: error: 11: Missing $ inserted. \end{equation}
```

To solve this problem, we can use the `preview` option of `standalone` class[^1]:

```latex
\documentclass[preview]{standalone}
\usepackage{amsmath}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\begin{document}
	
\begin{equation*}
	c = a+b
\end{equation*}
	
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251112195157441.png)

The `preview` will put the content into a `preview` environment[^2]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251112193834543.png" alt="image-20251112193827386" style="width:75%;" />

where the `preview` package is to extract a certain environment as graphic[^3]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251112194142583.png" alt="image-20251112194142520" style="width:75%;" />

Right now, the equation works, but as can been it seems that `preview` option will influence other appearance. For example, in above case, the colored page background can't be displayed normally. And another problems is, blank spacing will fill between the equation and left and right sides.

<br>

So, I think another method is more elegant, that is put the equation in a `tikzpicture` environment as a node content[^4]. For example:

```latex
\documentclass[tikz]{standalone}
\usepackage{amsmath}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\begin{document}
	
\begin{tikzpicture}
	\node {$c = a+b$};
\end{tikzpicture}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251112194802311.png" alt="png-1" style="width:50%;" />

And of course, like we insert equations in TikZ pictures, at this time we can also use other complicated equation environments:

```latex
\documentclass[tikz]{standalone}
\usepackage{amsmath}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\begin{document}
	
\begin{tikzpicture}
	\node {$
	\begin{aligned}
		c &= a+b\\
		c &= a+b\\
		c &= a+b\\
	\end{aligned}
	$};
\end{tikzpicture}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251112195117510.png" alt="png-1" style="width:50%;" />

<br>

**References**

[^1]: [https://tex.stackexchange.com/a/50171/306224](https://tex.stackexchange.com/a/50171/306224).
[^2]: [The `standalone` Package](https://mirror.clarkson.edu/ctan/macros/latex/contrib/standalone/standalone.pdf).
[^3]: [The `preview` Package for LaTeX Version 14.0.6](https://ctan.math.illinois.edu/macros/latex/contrib/preview/preview.pdf).
[^4]: [https://tex.stackexchange.com/a/360059/306224](https://tex.stackexchange.com/a/360059/306224).
