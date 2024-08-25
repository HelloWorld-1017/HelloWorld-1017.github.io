---
title: "LaTeX Loop Statement: `\\foreach`, `\\forloop`, and `\\multido`"
categories:
 - LaTeX
 - Collections
tags:
 - LaTeX TikZ
 - LaTeX calc
date: 2024-08-11 10:38:04 +0800
last_modified_at: 2024-08-11 10:38:04 +0800
---

# `\foreach` command

## Example 1

Code source[^1]

```latex
\documentclass{standalone}
\usepackage{tikz, siunitx}

\begin{document}

\begin{tikzpicture}
	\draw[->] (0,0) -- ({rad(210)}, 0);
	\draw[->] (0,-1.2) -- (0,1.2);
	\foreach \t in {0, 90, 180} { 
	\draw ({rad(\t)}, -0.05) -- ({rad(\t)}, 0.05); 
	\node[below, outer sep=2pt, fill=white, font=\small] at ({rad(\t)}, 0) {\ang{\t}};
	}
	\foreach \y in {-1,1} {\draw (-0.05,\y) -- (0.05,\y);}
\end{tikzpicture}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111007060.png" alt="png-1" style="width:50%;" />

<div class="notice--primary" markdown="1">

And a more complete version[^1]

```latex
\documentclass{standalone}
\usepackage{tikz, siunitx}

\begin{document}

\begin{tikzpicture}[scale=1.5]
	\newcommand\iangle{120}
	\begin{scope}[xshift=-2cm]
		\draw[->] (-1.2,0) -- (1.2,0);
		\draw[->] (0,-1.2) -- (0,1.2);
		\draw[thick] (0,0) circle (1);
		\coordinate[label=\iangle:$P$] (P) at (\iangle:1);
		\coordinate[label=below:$P_0$] (P0) at (P |- 0,0);
		\draw (0,0) -- (P);
		\draw (P) -- (P0);
		\fill[fill=gray,fill opacity=0.2]
		(0,0) -- (0:1) arc (0:\iangle:1) -- cycle;
		\filldraw[fill=gray,fill opacity=0.5]
		(0,0) -- (0:0.3) arc (0:\iangle:0.3) -- cycle;
		\node[right] at (\iangle/2:0.3) {\ang{\iangle}};
	\end{scope}
	
	\draw[->] (0,0) -- ({rad(210)}, 0);
	\draw[->] (0,-1.2) -- (0,1.2);
	\draw[thick, domain=0:rad(210)] plot (\x, {sin(\x r)})
	node[right] {$\sin x$};
	\foreach \t in {0, 90, 180} {
	\draw ({rad(\t)}, -0.05) -- ({rad(\t)}, 0.05);
	\node[below, outer sep=2pt, fill=white, font=\small] at ({rad(\t)}, 0) {\ang{\t}};
	}
	
	\foreach \y in {-1,1} {\draw (-0.05,\y) -- (0.05,\y);}
	
	\coordinate[label=above:$Q$] (Q) at ({rad(\iangle)}, {sin(\iangle)});
	\coordinate[label=below:$Q_0$] (Q0) at (Q |- 0,0);
	\draw (Q) -- (Q0);
	
	\draw[dashed] (P) -- (Q);
\end{tikzpicture}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111007675.png" alt="png-1" style="width:100%;" />

</div>

`siunitx` package is “A comprehensive (SI) units package.”[^5]

## Example 2

Actually,  `\foreach` command is provided by `pgffor` package, hence can be independent independent of `tikz` package[^1].

```latex
\documentclass{standalone}
\usepackage{pgffor} % \usepackage{tikz}

\begin{document}
\foreach \i in {0,...,7}{
    \i  
}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111010932.png" alt="png-1" style="zoom:33%;" />

## Example 3

```latex
\documentclass{standalone}
\usepackage{tikz}

\begin{document}
\begin{tikzpicture}
    \foreach \i\j in {1/A,2/B,3/C,4/D,5/E,6/F}{
        \node[draw,circle] at (\i,0){\Large\j};
    }
\end{tikzpicture}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111014480.png" alt="png-1" style="width:33%;" />

## Example 4

Code source[^2]

```latex
\documentclass{standalone}
\usepackage[dvipsnames]{xcolor}
\usepackage{tikz}

\begin{document}
\begin{tikzpicture}[myNode/.style={circle,draw,fill=teal,text=white}]
  \foreach \x in {0,...,4}
    \foreach \y in {0,...,4}
       \node [myNode]  (\x\y) at (1.5*\x,1.5*\y) {\x,\y};

  \foreach \x in {0,...,4}
    \foreach \y [count=\yi] in {0,...,3}{
      \draw[-latex] (\x\y)--(\x\yi);
      \draw[-latex] (\y\x)--(\yi\x);
    }   

  \foreach \x [count=\xi] in {0,...,3}
    \foreach \y [count=\yi] in {0,...,3}
      \draw[-latex] (\x\y)--(\xi\yi);
\end{tikzpicture}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111011464.png" alt="png-1" style="width:50%;" />

## Other examples

More exquisite TikZ design with `\foreach` can be found at [TikZ examples feature: Foreach](https://texample.net/tikz/examples/feature/foreach/).

<br>

# `\forloop` command

## Example 1

Code source[^2][^3]

```latex
\documentclass{standalone}
\usepackage{forloop}

\begin{document}
    \newcounter{x}
    \forloop{x}{1}{\value{x} < 10}{
        \arabic{x}
    }
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111016266.png" alt="png-1" style="width:33%;" />

## Example 2

Code source[^2]

```latex
\documentclass[varwidth]{standalone}
\usepackage{forloop}

\begin{document}
\newcounter{x}                     
\newcounter{y}
\forloop{y}{0}{\value{y} < 5}{     
   \forloop{x}{0}{\value{x} < 10}{ 
       (\arabic{x},\arabic{y})     
   }
   \\
}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111017809.png" alt="png-1" style="width:67%;" />

## Example 3

Code source[^2]

```latex
\documentclass{standalone}
\usepackage{forloop}
\usepackage{calc}

\begin{document}
\newcounter{x}
\newcounter{y}
\newcounter{z}
\begin{tabular}{||r||r|r|r|r|r|r|r|r|r|r||}
	\hline\hline
	\ & %skip the top left cell
	\forloop{x}{0}{\value{x} < 10}{ % generates the header row of the table
	   \arabic{x} \ifthenelse{\value{x}<9}{&}{}
	              % one less '&' than the number of columns
	}
	\\\hline\hline
	
	\forloop{y}{0}{\value{y} < 10}{
	   \arabic{y} \ifthenelse{\value{y}<10}{&}{}
	   \forloop{x}{0}{\value{x} < 10}{
	       \setcounter{z}{\value{x}*\value{y}}  % '*' needs the calc package
	       \arabic{z} \ifthenelse{\value{x}<9}{&}{}
	   }   
	   \\\hline
	}
	 &\multicolumn{10}{|c||}{Multiplication Table}\\\hline
\end{tabular}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111018211.png" alt="png-1" style="width:67%;" />

<br>

# `\multido` command

<div class="quote--left" markdown="1">

The general syntax for `\multido` is:

```latex
\multido{variables}{repetitions}{stuff}
```

`stuff` is whatever you want repeated; it can be any balanced TeX input. `repetitions` is the number times `stuff` is repeated. 

The first argument is the interesting one. `variables` is a comma-separated list of variable declarations. Each variable declaration is of the form:

```
variable = initial value + increment
```

`variable` is a command sequence that can be used in `stuff`. It is initially set to `initial value`, and is then incremented by `increment` with each repetition.

</div>

## Example 1

Code source[^4]

{% raw %}

```latex
\documentclass{standalone}
\usepackage{multido}

\begin{document}
	\setlength{\unitlength}{1cm}
	\small
	\begin{picture}(8,1)(0,-.5)
		\put(0,0){\vector(1,0){8}}
		\multido{\i=0+1,\n=0+0.25}{8}{%
		\put(\i,-.1){\line(0,1){.2}}
		\put(\i,-.2){\makebox(0,0)[t]{\n}}}
	\end{picture}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111018321.png" alt="png-1" style="width:50%;" />

{% endraw %}

## Example 2

Code source[^4]

```latex
\documentclass[varwidth]{standalone}
\usepackage{multido}

\begin{document}
    \multido{}{10}{\TeX\ }

    \multido{\d=2pt+3pt}{5}{\d, }

    \multido{\n=2+3}{10}{\n, }

    \multido{\i=2+-3}{10}{\i, }

    \multido{\r=2+3.05}{6}{\r, }

    \multido{\n=2.00+-3.05}{8}{\n, }
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408111019298.png" alt="png-1" style="width:67%;" />

<br>

**References**

[^1]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 394-396.
[^2]: [Defining Loops in a LaTeX Document \| Baeldung on Computer Science](https://www.baeldung.com/cs/latex-loops).
[^3]: [CTAN: Package `forloop`](https://ctan.org/pkg/forloop?lang=en), documentation: [forloop.pdf](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/forloop/forloop.pdf).
[^4]: [CTAN: Package `multido`](https://ctan.org/pkg/multido?lang=en), documentation: [multido-doc.dvi](https://mirror-hk.koddos.net/CTAN/macros/generic/multido/multido-doc.pdf).
[^5]: [CTAN: Package `siunitx`](https://ctan.org/pkg/siunitx?lang=en), documentation: [siunitx – A comprehensive (SI) units package](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/siunitx/siunitx.pdf).

