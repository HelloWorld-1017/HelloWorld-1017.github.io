---
title: LaTeX Breaking Spaces, Non-Breaking Spaces, and Math Spacing Commands
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
 - LaTeX Layout
location: Buffalo, United States
date: 2025-11-12 00:21:02 -0500
last_modified_at: 2025-11-15 13:33:00 -0500
---

In LaTeX, I always use a space character to add a blank space between the text, and sometimes commands `\ `, `\quad`, and `\qquad` to add some spacing between contents in math environments. Technically, all of them are <i class="term">breaking spaces</i>[^1]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251112221729950.png" alt="image-20251112221729896" style="width:75%;" />

which means that LaTeX can make a new line there if needed. In addition to them, there are some <i class="term">non-breaking spaces</i> (sometimes called <i class="term">ties</i>), where making a new line is not allowable, such as: `\thinspace` (`\,`), `\negthinspace` (`\!`, a kind of negative distance), `\enspace`, and `\nobreakspace` (`~`, which is the most classic tie):

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251112221714663.png" alt="image-20251112221714594" style="width:75%;" />

Then, let's test these commands one by one:

{% raw %}

```latex
\documentclass[12pt]{article}
\usepackage{forloop}
\usepackage{showframe}
\usepackage{xcolor}

\newcounter{x}

\newcommand{\helpertestblank}[1]{%
	\forloop{x}{0}{\value{x} < 30}{123#1}%
}

\begin{document}
\thispagestyle{empty}

% =====Breaking spaces====
\noindent{\color{red}\verb*| |}
\helpertestblank{ }

\noindent {\color{red}\verb*|\quad|}
\helpertestblank{\quad}

\noindent {\color{red}\verb*|\qquad|}
\helpertestblank{\qquad}

\noindent {\color{red} \verb*|\enskip|}
\helpertestblank{\enskip}

\noindent {\color{red}\verb*|\ |}
\helpertestblank{\ }

% ========================

% =====Non-breaking spaces====
\noindent {\color{red}\verb*|\thinspace|}
\helpertestblank{\thinspace}

\noindent {\color{red}\verb*|\,|}
\helpertestblank{\,}

\noindent {\color{red}\verb*|\negthinspace|}
\helpertestblank{\negthinspace}

\noindent {\color{red}\verb*|\!|}
\helpertestblank{\!}

\noindent {\color{red}\verb*|\enspace|}
\helpertestblank{\enspace}

\noindent {\color{red}\verb*|\nobreakspace|}
\helpertestblank{\nobreakspace}

\noindent {\color{red}\verb*|~|}
\helpertestblank{~}
% ========================

\end{document}
```

{% endraw %}

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251114194714445.png" alt="png-1" style="width:75%;" />

<br>

Above non-breaking spaces are useful in some cases, improving our writing details and making article look more professional, such as[^1]:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

Question~1

Donald~E. Knuth % In the first name and middle initial

Mr.~Knuth

function~$f(x)$

1,~2, and~3
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251114195252085.png" alt="image-20251114195252018" style="width:50%;" />

And among which, command `\!` can be used to generate a negative distance, and is frequently used in math environments, here are some examples[^1]:

```latex
\documentclass{article}
\usepackage{amsmath}
\DeclareMathOperator\dif{d\!} % For differential symbols

\begin{document}

\renewcommand{\arraystretch}{2}
\begin{tabular}{ll}
	With adjustment by \verb*|\!| & Without adjustment\\
	$ \int_0^1 f(t) \dif t
	= \iint_D g(x,y) \dif x \dif y $ & $ \int_0^1 f(t) \dif t
	= \iint_D g(x,y) \mathrm{d} x \mathrm{d} y $\\
	$ x^2 \! / 2 $ & $ x^2 / 2 $\\
	$ |\!{\gets} 5 {\to}\!| $ & $| {\gets} 5 {\to}|$\\
	$ A^{\!T} $ & $ A^T $ 
\end{tabular}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251114200227848.png" alt="image-20251114200227768" style="width:75%;" />

Honestly, I totally didn't notice these details before!!!

<div class="notice--primary" markdown="1">

In above cases, note how we type a differential symbol:

```latex
\usepackage{amsmath}
\DeclareMathOperator\dif{d\!} % For differential symbols
% ...
$ \int_0^1 f(t) \dif t
	= \iint_D g(x,y) \dif x \dif y $
```

A modified `\dif` command is declared in the preamble, which preserves the spacing before the differential symbol and simultaneously shrink the spacing after that[^1]. It's much more elegant than the way `\mathrm{d}` I always used before!!!

</div>

<br>

Besides, there are also three spacing commands that can be used in math environments, i.e., `\:`, `\>`, and `\;`[^1]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251113154520143.png" alt="image-20251113154513028" style="width:75%;" />

such as:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\[
aa\:a\>a\;a
\]

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251114201527942.png" alt="image-20251114201527886" style="width:50%;" />

In addition, we can use `\setlength` command to specify the spacing value of above math spacing commands[^1]:

- `\thinmuskip` for thin-space command `\,` and `\!` (default `3mu`)
- `\medmuskip` for medium-space command `\:` and `\>` (default `4mu plus 2mu minus 4mu`)
- `\thickmuskip` for thick-space command `\;` (default `5mu plus 5 mu`)

For example,

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\[
aa\,a\!a\:a\>a\;a
\]

\setlength{\thinmuskip}{7mu}
\setlength{\medmuskip}{19mu plus 2mu minus 4mu}
\setlength{\thickmuskip}{23mu plus 5 mu}

\[
aa\,a\!a\:a\>a\;a
\]

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251114203132981.png" alt="image-20251114203132870" style="width:75%;" />

<br>

**References**

[^1]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, p. 57, p. 86, p. 248, p. 279, p. 282.
