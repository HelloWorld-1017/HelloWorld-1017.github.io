---
title: Cross Out Text (Strikethrough) in LaTeX --- The `soul` package, `ulem` package, and `cancel` package
toc: false
categories:
 - LaTeX
tags:
 - LaTeX cancel
 - LaTeX Equation
 - LaTeX soul
 - LaTeX ulem
date: 2025-05-29 20:41:35 +0800
last_modified_at: 2025-06-01 11:34:41 +0800
---

**Method 1**: by the `\st` command of the `soul` package

In LaTeX, we can use the `\st` command of the `soul` package[^2] to cross out text: 

```latex
\documentclass{article}
\usepackage{lipsum}
\usepackage{soul}

\newcommand{\mylipsum}{\lipsum[1][1-2]}

\begin{document}

\mylipsum
\st{text to be deleted}
\mylipsum
\st{text to be deleted}
\mylipsum

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506010946377.png" alt="image-20250601094635305" style="width:67%;" />

and meanwhile we can use the `\setstcolor` command to set the color of  the strikethrough[^1]:

 ```latex
 \documentclass{article}
 \usepackage{lipsum}
 \usepackage{soul,xcolor}
 
 \newcommand{\mylipsum}{\lipsum[1][1-2]}
 
 \begin{document}
 
 \mylipsum
 \st{text to be deleted}
 \mylipsum
 \setstcolor{red}
 \st{text to be deleted}
 \mylipsum
 \st{text to be deleted}
 \setstcolor{black}
 \mylipsum
 \st{text to be deleted}
 \mylipsum
 
 \end{document}
 ```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506010948580.png" alt="image-20250601094858516" style="width:67%;" />

Besides, the `\st` command can be used to cross out inline equations:

```latex
\documentclass{article}
\usepackage{lipsum,amsmath}
\usepackage{soul,xcolor}

\newcommand{\mylipsum}{\lipsum[1][1-2]}

\begin{document}

\mylipsum
\st{text to be deleted, $a^2+b^2=c^2$}
\mylipsum
\setstcolor{red}
\st{text to be deleted, $a^2+b^2=c^2$}
\mylipsum
\st{text to be deleted, $a^2+b^2=c^2$}
\setstcolor{black}
\mylipsum
\st{text to be deleted, $a^2+b^2=c^2$}
\mylipsum

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506010953103.png" alt="image-20250601095340036" style="width:67%;" />

but it cannot be used inside of the math modes, including inline math mode and display math mode, for example, the syntax like:

```latex
$a^2+\st{b^2=c^2}$
```

or

```latex
\begin{equation*}
	a^2+\st{b^2=c^2}
\end{equation*}
```

will induce errors.

<br>

**Method 2**: by the `ulem` package

The `ulem` package is originally for underlining[^3], but the reference[^1] provides a way to realize strikethrough by it:

```latex
\documentclass{article}
\usepackage{xcolor,lipsum}
\usepackage[normalem]{ulem}

\newcommand{\mylipsum}{\lipsum[1][1-2]}

\newcommand\redsout{\bgroup\markoverwith{\textcolor{red}{\rule[0.7ex]{2pt}{0.7pt}}}\ULon}

\begin{document}

\mylipsum
\redsout{text to be deleted, $a^2+b^2=c^2$}
\mylipsum
$a^2+\redsout{b^2=c^2}$
\mylipsum

\begin{equation}
	a^2+\redsout{b^2=c^2}\\
\end{equation}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506011015169.png" alt="image-20250601101520094" style="width:67%;" />

where the code

```latex
\newcommand\redsout{\bgroup\markoverwith{\textcolor{red}{\rule[0.7ex]{2pt}{0.7pt}}}\ULon}
```

is to define a new underline style to realize the effect of strikethrough. More details about this syntax can be found in the documentation of `ulem` package [^4].

At this time, we can see this defined command `\redsout` can be used in both inline math mode and display math mode. A very flexible way.

<br>

**Method 3**: by the `cancel` package[^5]

```latex
\documentclass{article}
\usepackage{lipsum}
\usepackage{cancel}

\newcommand{\mylipsum}{\lipsum[1][1-2]}

\begin{document}
% The `\cancel` command
\mylipsum
\cancel{text to be deleted, $a^2+b^2=c^2$}
\mylipsum
$a^2+\cancel{b^2=c^2}$
\mylipsum

\vspace{3em}

\begin{equation}
	a^2+\cancel{b^2=c^2}\\
\end{equation}

% The `\bcancel` command
\mylipsum
\bcancel{text to be deleted, $a^2+b^2=c^2$}
\mylipsum
$a^2+\bcancel{b^2=c^2}$
\mylipsum

\begin{equation}
	a^2+\bcancel{b^2=c^2}\\
\end{equation}

\vspace{3em}

% The `\xcancel` command
\mylipsum
\xcancel{text to be deleted, $a^2+b^2=c^2$}
\mylipsum
$a^2+\xcancel{b^2=c^2}$
\mylipsum

\begin{equation}
	a^2+\xcancel{b^2=c^2}\\
\end{equation}

% The `\cancelto` command
\begin{equation}
	\cancelto{3^2}{a^2}+\cancelto{4^2}{b^2}=\cancelto{5^2}{c^2}\\
\end{equation}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506011104632.png" alt="image-20250601110429512" style="width:67%;" />

where[^6]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506011105252.png" alt="image-20250601110538163" style="width:67%;" />

Also, we can use the following code in the preamble to specify the color of cancel mark:

```latex
\usepackage{xcolor}
\renewcommand\CancelColor{\color{red}}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506011116285.png" alt="image-20250601111655168" style="width:67%;" />

<br>

**References**

- [Strikethrough](https://en.wikipedia.org/wiki/Strikethrough)

[^1]: [https://tex.stackexchange.com/a/130626/306224](https://tex.stackexchange.com/a/130626/306224).
[^2]: [CTAN: Package `soul`](https://ctan.org/pkg/soul?lang=en).
[^3]: [CTAN: Package `ulem`](https://ctan.org/pkg/ulem?lang=en).
[^4]: [The `ulem` package: underlining for emphasis](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/ulem/ulem.pdf), p.3.
[^5]: [text decorations - How to strike through obliquely, e.g. to indicate cancellation?](https://tex.stackexchange.com/questions/40253/how-to-strike-through-obliquely-e-g-to-indicate-cancellation).
[^6]: [The `cancel` package](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/cancel/cancel.pdf).
