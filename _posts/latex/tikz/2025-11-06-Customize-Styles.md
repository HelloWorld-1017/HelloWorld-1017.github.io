---
title: Customize LaTeX TikZ Style Using Commands `\tikzset`, `\tikzstyle`, and/or Options of `tikzpicture` Environment
categories:
 - LaTeX
tags:
 - LaTeX TikZ
location: Buffalo, United States
date: 2025-11-06 16:56:49 -0500
last_modified_at: 2025-11-10 14:07:09 -0500
---

# Introduction

Recently, I started trying to plot schematics in the paper, mainly method overview but not including line plot and bar plot etc., using LaTeX TikZ, because this package is very compatible with LaTeX document, and more beautiful, more elegant than Visio and MS PowerPoint (at least for me). After I drawing some TikZ figures, I found there is a very efficient method to simplify the process, that is, defining a unified style instead of setting for each node separately, which avoids a lot of repeated specification. Actually I knew this method before, but I didn't have many chances to practice and hence didn't understand its conveniency as I do now. So, I would record it in this blog to deepen my understanding.

<br>

# `\tikzset` command

First, we can use the `\tikzset` command to specify node styles[^1].

## For all nodes: `\tikzset{every node/.style={<specifications>}}`

**(1) Use `\tikzset{every node/.style={<specifications>}}` in the preamble**

```latex
\documentclass[border=10pt]{standalone}
\usepackage{tikz}

\tikzset{every node/.style={red, draw=blue, fill=yellow!20, minimum size=0.5cm}}

\begin{document}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle]{a}
	node at (4,1)[shape=circle]{b}
	node at (4,0)[shape=circle]{c}
	node at (5,1)[shape=rectangle]{d}
	node at (3,1)[shape=rectangle]{e};
\end{tikzpicture}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle]{a}
	node at (4,1)[shape=circle]{b}
	node at (4,0)[shape=circle]{c}
	node at (5,1)[shape=rectangle]{d}
	node at (3,1)[shape=rectangle]{e};
\end{tikzpicture}
	
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107224346318.png" alt="png-1" style="width:75%;" />

**(2) Use `\tikzset{every node/.style={<specifications>}}` in a separate `tikzpicture` environment**

```latex
\documentclass[border=10pt]{standalone}
\usepackage{tikz}

\begin{document}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle,draw]{a}
	node at (4,1)[shape=circle,draw]{b}
	node at (4,0)[shape=circle,draw]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,draw]{e};
\end{tikzpicture}

\begin{tikzpicture}
	\tikzset{every node/.style={red, draw=blue, fill=yellow!20, minimum size=0.5cm}}
	
	\path node at (4,2)[shape=circle]{a}
	node at (4,1)[shape=circle]{b}
	node at (4,0)[shape=circle]{c}
	node at (5,1)[shape=rectangle]{d}
	node at (3,1)[shape=rectangle]{e};
\end{tikzpicture}
	
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107224553504.png" alt="png-1" style="width:75%;" />

## Customize a style: `\tikzset{mystyle/.style={<specifications>}}`

**(1) Use `\tikzset{mystyle/.style={<specifications>}}` in the preamble**

```latex
\documentclass[border=10pt]{standalone}
\usepackage{tikz}

\tikzset{mystyle/.style={red, draw=blue, fill=yellow!20, minimum size=0.5cm}}

\begin{document}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle,mystyle]{a}
	node at (4,1)[shape=circle,draw]{b}
	node at (4,0)[shape=circle,draw]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,draw]{e};
\end{tikzpicture}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle,draw]{a}
	node at (4,1)[shape=circle,draw]{b}
	node at (4,0)[shape=circle,draw]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,draw]{e};
\end{tikzpicture}
	
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107224931902.png" alt="png-1" style="width:75%;" />

**(2) Use `\tikzset{mystyle/.style={<specifications>}}` in a separate `tikzpicture` environment**

```latex
\documentclass[border=10pt]{standalone}
\usepackage{tikz}

\begin{document}
\begin{tikzpicture}
	\path node at (4,2)[shape=circle,draw]{a}
	node at (4,1)[shape=circle,draw]{b}
	node at (4,0)[shape=circle,draw]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,draw]{e};
\end{tikzpicture}

\begin{tikzpicture}
	\tikzset{mystyle/.style={red, draw=blue, fill=yellow!20, minimum size=0.5cm}}
	
	\path node at (4,2)[shape=circle,mystyle]{a}
	node at (4,1)[shape=circle,draw]{b}
	node at (4,0)[shape=circle,draw]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,draw]{e};
\end{tikzpicture}
	
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107225055984.png" alt="png-1" style="width:75%;" />

Note, at this time, we can't use `mystyle` style in the first `tikzpicture` environment because it only works locally.

<br>

# `\tikzstyle` command

Besides, we can also use `\tikzstyle` command to define styles[^2]. By the way, I think the syntax of `\tikzstyle` command is cleaner than `\tikzset`.

## For all nodes: `\tikzstyle{every node} = [<specifications>]`

**(1) Use `\tikzstyle{every node} = [<specifications>]` in the preamble**

```latex
\documentclass[border=10pt]{standalone}
\usepackage{tikz}

\tikzstyle{every node} = [red, draw=blue, fill=yellow!20, minimum size=0.5cm]

\begin{document}
	
\begin{tikzpicture}
	\path node at (4,2)[shape=circle]{a}
	node at (4,1)[shape=circle]{b}
	node at (4,0)[shape=circle]{c}
	node at (5,1)[shape=rectangle]{d}
	node at (3,1)[shape=rectangle]{e};
\end{tikzpicture}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle]{a}
	node at (4,1)[shape=circle]{b}
	node at (4,0)[shape=circle]{c}
	node at (5,1)[shape=rectangle]{d}
	node at (3,1)[shape=rectangle]{e};
\end{tikzpicture}
	
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251110134143093.png" alt="png-1" style="width:75%;" />

**(2) Use `\tikzstyle{every node} = [<specifications>]` in a separate `tikzpicture` environment**

```latex
\documentclass[border=10pt]{standalone}
\usepackage{tikz}

\begin{document}
	
\begin{tikzpicture}
	\tikzstyle{every node} = [red, draw=blue, fill=yellow!20, minimum size=0.5cm]
	
	\path node at (4,2)[shape=circle]{a}
	node at (4,1)[shape=circle]{b}
	node at (4,0)[shape=circle]{c}
	node at (5,1)[shape=rectangle]{d}
	node at (3,1)[shape=rectangle]{e};
\end{tikzpicture}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle]{a}
	node at (4,1)[shape=circle]{b}
	node at (4,0)[shape=circle]{c}
	node at (5,1)[shape=rectangle]{d}
	node at (3,1)[shape=rectangle]{e};
\end{tikzpicture}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251110134652433.png" alt="png-1" style="width:75%;" />

## Customize a style: `\tikzstyle{mystyle} = [<specifications>]`

**(1) Use `\tikzstyle{mystyle} = [<specifications>]` in the preamble**

```latex
\documentclass[border=10pt]{standalone}
\usepackage{tikz}

\tikzstyle{mystyle} = [red, draw=blue, fill=yellow!20, minimum size=0.5cm]
\tikzstyle{mystyle1} = [red, draw=blue, fill=green!20, minimum size=0.5cm]
\tikzstyle{mystyle2} = [red, draw=blue, fill=red!20, minimum size=0.5cm]

\begin{document}
	
\begin{tikzpicture}
	\path node at (4,2)[shape=circle,mystyle]{a}
	node at (4,1)[shape=circle,mystyle2]{b}
	node at (4,0)[shape=circle,mystyle1]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,mystyle1]{e};
\end{tikzpicture}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle,draw]{a}
	node at (4,1)[shape=circle,draw]{b}
	node at (4,0)[shape=circle,draw]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,draw]{e};
\end{tikzpicture}
	
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251110134408837.png" alt="png-1" style="width:75%;" />

**(2) Use `\tikzstyle{mystyle} = [<specifications>]` in a separate `tikzpicture` environment**

```latex
\documentclass[border=10pt]{standalone}
\usepackage{tikz}

\begin{document}

\begin{tikzpicture}
	\tikzstyle{mystyle} = [red, draw=blue, fill=yellow!20, minimum size=0.5cm]
	\tikzstyle{mystyle1} = [red, draw=blue, fill=green!20, minimum size=0.5cm]
	\tikzstyle{mystyle2} = [red, draw=blue, fill=red!20, minimum size=0.5cm]
	
	\path node at (4,2)[shape=circle,mystyle]{a}
	node at (4,1)[shape=circle,mystyle2]{b}
	node at (4,0)[shape=circle,mystyle1]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,mystyle1]{e};
\end{tikzpicture}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle,draw]{a}
	node at (4,1)[shape=circle,draw]{b}
	node at (4,0)[shape=circle,draw]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,draw]{e};
\end{tikzpicture}
	
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251110134843783.png" alt="png-1" style="width:75%;" />

And also similar to `\tikzset` command, at this time, these styles are only functional locally.

<br>

# Specify styles in the option of `tikzpicture`

## For all nodes

```latex
\documentclass[border=10pt]{standalone}
\usepackage{tikz}

\begin{document}
	
\begin{tikzpicture}[every node/.style={red, draw=blue, fill=yellow!20, minimum size=0.5cm}]
	\path node at (4,2)[shape=circle]{a}
	node at (4,1)[shape=circle]{b}
	node at (4,0)[shape=circle]{c}
	node at (5,1)[shape=rectangle]{d}
	node at (3,1)[shape=rectangle]{e};
\end{tikzpicture}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle,draw]{a}
	node at (4,1)[shape=circle,draw]{b}
	node at (4,0)[shape=circle,draw]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,draw]{e};
\end{tikzpicture}
	
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107225323586.png" alt="png-1" style="width:75%;" />

## Customize a style

```latex
\documentclass[border=10pt]{standalone}
\usepackage{tikz}

\begin{document}
	
\begin{tikzpicture}[
	mystyle/.style={red, draw=blue, fill=yellow!20, minimum size=0.5cm},
	mystyle1/.style={red, draw=blue, fill=green!20, minimum size=0.5cm},
	mystyle2/.style={red, draw=blue, fill=red!20, minimum size=0.5cm}] % Note use `,` to separate
	
	\path node at (4,2)[shape=circle,mystyle]{a}
	node at (4,1)[shape=circle,mystyle2]{b}
	node at (4,0)[shape=circle,mystyle1]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,mystyle1]{e};
\end{tikzpicture}

\begin{tikzpicture}
	\path node at (4,2)[shape=circle,draw]{a}
	node at (4,1)[shape=circle,draw]{b}
	node at (4,0)[shape=circle,draw]{c}
	node at (5,1)[shape=rectangle,draw]{d}
	node at (3,1)[shape=rectangle,draw]{e};
\end{tikzpicture}
	
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107225625870.png" alt="png-1" style="width:75%;" />

<br>

**References**

[^1]: [Change style of labels of Tikz nodes of a given style](https://tex.stackexchange.com/questions/78689/change-style-of-labels-of-tikz-nodes-of-a-given-style).
[^2]: [best practices - Should `\tikzset` or `\tikzstyle` be used to define TikZ styles?](https://tex.stackexchange.com/questions/52372/should-tikzset-or-tikzstyle-be-used-to-define-tikz-styles).
