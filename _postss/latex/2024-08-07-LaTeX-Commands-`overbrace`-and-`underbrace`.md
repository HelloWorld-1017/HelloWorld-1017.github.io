---
title: LaTeX Commands `\overbrace` and `\underbrace`
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Equation
date: 2024-08-07 13:03:33 +0800
last_modified_at: 2024-08-07 13:03:33 +0800
---

```latex
\documentclass{article}

\begin{document}

$\overbrace{a+b+c} = \underbrace{1+2+3}$

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071243804.png" alt="image-20240807124251813" style="zoom:67%;" />

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

$ (\overbrace{a_0,a_1,\dots,a_n}^{\text{$n+1$ terms}}) = (\underbrace{0,0,\dots,0}_{n}, 1) $

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071245863.png" alt="image-20240807124552762" style="zoom:67%;" />

```latex
\documentclass{article}
\usepackage{amsmath, mathtools}

\begin{document}

$ \underbracket{\overbracket{1+2}^2+3}_3 $

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071248588.png" alt="image-20240807124841558" style="zoom:67%;" />

```latex
\documentclass{article}
\usepackage{xcolor}

\begin{document}

\[ \color{red}{a+\lefteqn{\overbrace{\phantom{a+b+c}}^m}{b}} \]
\[ \color{blue}{+\underbrace{c+d+e}_n+f} \]
\[ \color{red}{a+\lefteqn{\overbrace{\phantom{a+b+c}}^m}{b}}+\color{blue}{\underbrace{c+d+e}_n+f} \]

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071252210.png" alt="image-20240807125201168" style="zoom:67%;" />

<div class="quote--left" markdown="1">

The command `\lefteqn` is used for splitting long formulas across lines. It typesets its argument in display style flush left in a box of zero width.[^3]

`\lefteqn{eqn}` prints `eqn` in display math style, but pretends that it has zero width. It is typicaly used within an [`Eqnarray`](http://www.fifi.org/doc/tetex-doc/texmf/latex/latex2e-html/ltx-223.html) environment for displaying long equations that require multiple lines.[^4]

</div>

<div class="quote--left" markdown="1">

`\phantom{subformula}`, `\vphantom{subformula}`, `\hphantom{subformula}`[^5]

The `\phantom` command creates a box with the same height, depth, and width as subformula, but empty. That is, this command causes LaTeX to typeset the space but not fill it with the material. Here LaTeX will put a blank line that is the correct width for the answer, but will not show that answer.

The `\vphantom` variant produces an invisible box with the same vertical size as subformula, the same height and depth, *but having zero width*. And `\hphantom` makes a box with the same width as subformula *but with zero height and depth*.

</div>

{% raw %}

```latex
\documentclass{article}
\usepackage{xcolor}
\usepackage{amsmath, mathtools}

\begin{document}

\begin{align*}
y & = 2x^2 -3x +5\nonumber\\
  & \hphantom{= \ 2\left(x^2-\frac{3}{2}\,x\right. }%
\textcolor{blue}{%
\overbrace{\hphantom{+\left(\frac{3}{4}\right)^2- %
\left(\frac{3}{4}\right)^2}}^{=0}}\nonumber\\[-11pt]
  & = 2\left(\textcolor{red}{%
\underbrace{%
x^2-\frac{3}{2}\,x + \left(\frac{3}{4}\right)^2}%
}%
\underbrace{%
- \left(\frac{3}{4}\right)^2 + \frac{5}{2}}%
\right)\\
  & = \left(\qquad\textcolor{red}{\left(x-\frac{3}{4}\right)^2}
\qquad + \ \frac{31}{16}\qquad\right)\nonumber\\
y\textcolor{blue}{-\frac{31}{8}}
  & = 2\left(x\textcolor{cyan}{-\frac{3}{4}}\right)^2\nonumber
\end{align*}

\end{document}
```

{% endraw %}

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408071254701.png" alt="image-20240807125443640" style="zoom:67%;" />

<br>

**References**

- [LaTeX入门](https://yun.weicheng.men/Book/LaTeX%E5%85%A5%E9%97%A8.pdf), 刘海洋编著, pp. 230.
- [brackets - How can I get an underbrace and an overbrace to partially overlap in an equation? - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/297/how-can-i-get-an-underbrace-and-an-overbrace-to-partially-overlap-in-an-equation).

[^3]: [eqnarray (LaTeX2e unofficial reference manual (May 2024))](https://latexref.xyz/eqnarray.html).
[^4]: [Help On LaTeX `\lefteqn`](http://www.fifi.org/doc/tetex-doc/texmf/latex/latex2e-html/lefteqn.html).
[^5]: [\phantom & \vphantom & \hphantom (LaTeX2e unofficial reference manual (May 2024))](https://latexref.xyz/_005cphantom-_0026-_005cvphantom-_0026-_005chphantom.html).

