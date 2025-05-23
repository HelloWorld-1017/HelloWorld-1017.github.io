---
title: Highlight Parts of An Equation in LaTeX
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
 - LaTeX hf-tikz
 - LaTeX tcolorbox
 - LaTeX TikZ
 - LaTeX xcolor
date: 2025-05-19 17:21:20 +0800
last_modified_at: 2025-05-23 17:52:37 +0800
---

**Method 1**: by the `\colorbox` command[^1]

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage[svgnames]{xcolor}

\begin{document}

\begin{align*}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \notag \\
&= \colorbox{LightBlue}{$a^3+b^3$}
\end{align*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505192016419.png" alt="image-20250519201656344" style="width:50%;" />

Note that, the equation, i.e. `a^3+b^3`, should be put in an in-line equation environment wrapped in two `$`s.

<br>

**Method 2**: by the `\tcboxmath` command of `tcolorbox` package[^2]

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage[svgnames]{xcolor}
\usepackage[most]{tcolorbox}
 
\begin{document}

\begin{align*}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \notag \\
&= \tcboxmath[colback=LightBlue!25!white,colframe=blue]{a^3+b^3}
\end{align*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505192030906.png" alt="image-20250519203017829" style="width:50%;" />

Note that, this method will change the position of the highlighted parts as be centered in the box.

<br>

**Method 3**: by redefining the `\boxed` command using the `hf-tikz` package

The `\boxed` command is from the `amsmath` package, and it can be used to box parts of an equation:

```latex
\documentclass{article}
\usepackage{amsmath}
 
\begin{document}

\begin{align*}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= \boxed{a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2} \notag \\
&= a^3 + b^3
\end{align*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505231717362.png" alt="image-20250523171743187" style="width:50%;" />

And we can use the `hf-tikz` package to redefine the `\boxed` command, to make the box more beautiful[^3][^6]:

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage[svgnames]{xcolor}
\usepackage[customcolors,shade]{hf-tikz}

\newcommand*{\boxcolor}{blue}
\makeatletter
\renewcommand{\boxed}[1]{\textcolor{\boxcolor}{
	\tikz[baseline={([yshift=-1ex]current bounding box.center)}]
	\node[rectangle,minimum width=1ex,rounded corners,draw,fill=LightBlue!25] 
	{\normalcolor\m@th$\displaystyle#1$};}}
\makeatother
 
\begin{document}

\begin{align*}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= \boxed{a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2} \notag \\
&= a^3 + b^3
\end{align*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505192027864.png" alt="image-20250519202726765" style="width:50%;" />

**Method 4**: by the `hf-tikz` package

All of above methods don’t support the syntax of spanning multiple rows of an equation, something like:

```latex
% ...

\begin{align*}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= \colorbox{LightBlue}{a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \notag \\
&= $a^3+b^3$}
\end{align*}

% ...
```

or,

```latex
\begin{align*}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= \tcboxmath[colback=LightBlue!25!white,colframe=blue]{a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \notag \\
&= a^3+b^3}
\end{align*}
```

I guess this is because some special commands like `\\` or `&` will break those commands. So, from this perspective, the method provided by the `hf-tikz` package[^4][^5], using `\tikzmarkin{node-id}` and `\tikzmarkend{node-id}` to mark the beginning (i.e. the left upper corner) and the end (i.e. the right lower corner) of the highlighted box, is much more flexible. Here are some examples.

```latex
\documentclass{article}
\usepackage{amsmath}
\usepackage[svgnames]{xcolor}
\usepackage[customcolors,shade]{hf-tikz}
 
\begin{document}

\begin{equation}
\begin{split}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= \tikzmarkin[set fill color=LightBlue!10, set border color=blue]{a} a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \notag \\
&= a^3 + b^3\tikzmarkend{a} % Default position
\end{split}
\end{equation}

\begin{equation}
\begin{split}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= \tikzmarkin[set fill color=LightBlue!10, set border color=blue, below right offset={0,0},above left offset={0,0}]{b} a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \notag \\
&= a^3 + b^3\tikzmarkend{b}
\end{split}
\end{equation}

\begin{equation}
\begin{split}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= \tikzmarkin[set fill color=LightBlue!10, set border color=blue]{c}(0,0)(0,0) a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \notag \\
&= a^3 + b^3\tikzmarkend{c}
\end{split}
\end{equation}

\begin{equation}
\begin{split}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= \tikzmarkin[set fill color=LightBlue!10, set border color=blue, below right offset={3.8,-0.2},above left offset={-0.07,0.4}]{d}a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \notag \\
&= a^3 + b^3\tikzmarkend{d}
\end{split}
\end{equation}

\hfsetfillcolor{red!10}
\hfsetbordercolor{red}
\begin{equation}
\begin{split}
&\mathrel{\phantom{=}} (a+b)(a^2-ab+b^2) \notag \\
&= \tikzmarkin[below right offset={3.8,-0.2},above left offset={-0.07,0.4}]{e}a^3 - a^2b + ab^2 + a^2b - ab^2 + b^2 \notag \\
&= a^3 + b^3\tikzmarkend{e}
\end{split}
\end{equation}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505192036546.png" alt="image-20250519203630437" style="width:50%;" />

Note that here we showed two syntaxes to change the size and position of the highlighted box (see[^5] in detail):

```latex
\tikzmarkin{marker-id}(below right offset)(above left offset)
```

and

```latex
\tikzmarkin[below right offset={xxx,xxx},above left offset={xxx,xxx}]
```

<br>

**References**

[^1]: [An Example of Annotating Equation in LaTeX Using Colored Box and TikZ Package](/2024-05-04/20-29-57.html).
[^2]: [Examples from LaTeX `tcolorbox` Package](/2025-05-12/22-05-57.html).
[^3]: [https://tex.stackexchange.com/a/75255/306224](https://tex.stackexchange.com/a/75255/306224).
[^4]: [https://tex.stackexchange.com/a/75133/306224](https://tex.stackexchange.com/a/75133/306224).
[^5]: [The `hf-tikz` package](http://mirrors.ibiblio.org/CTAN/graphics/pgf/contrib/hf-tikz/hf-tikz.pdf), p. 3.
[^6]: [Hierarchical Structures: Package, Environments, Scopes, and Styles](https://tikz.dev/tikz-scopes).
