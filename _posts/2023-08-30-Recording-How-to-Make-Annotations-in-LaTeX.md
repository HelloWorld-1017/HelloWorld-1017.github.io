---
layout: single
title: Recording How to Make Annotations in LaTeX
date: 2023-08-31 08:52:55 +0800
categories:
 - LaTeX
---

# Highlight

Highlight in LaTeX could be realised by  `soul` macro package [1]. But note that don’t forget to import `color` package, otherwise the color cannot display normally. In addition, we could use `\sethlcolor` defined in `soul` package to change highlight color, but this setting will influence the whole following context unless we reset color setting using `\sethlcolor` again. For example: 

```latex
\documentclass{article}
\usepackage{color} % N.B.: necessary
\usepackage{soul}
\sethlcolor{red}

\begin{document}
We test \hl{red hightlight} here.

\sethlcolor{green}
We test \hl{green highlight} here.

We test \hl{highlight} here.
\end{document}
```

![image-20230830215902044](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230830215902044.png)

<br>

# Recording Modification and Making Remarks

If we want to record what have changed in the content, the `changes` macro package is a good choice [1], and at which point we could make some necessary comments for it. Like: 

```latex
\documentclass{article}
\usepackage{changes}
\definechangesauthor[name={coauthor1},color=orange]{Ma}
\definechangesauthor[name={coauthor2},color=red]{Tommy}

\begin{document}
This is \added[id=Ma,comment={This is added by Ma.}]{added} text.

This is \added[comment={This is added by Tommy.}]{added} text.

This is \deleted[id=Tommy,comment={This is deleted by Tommy.}]{deleted} text.

This is a \replaced{replacement}{replace}.

\listofchanges
\end{document}
```

![image-20230830221530665](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230830221530665.png)

N.B.: In origin blog [1], the remark is added by keyword `remark`, like `This is \added[id=Ma,remark={This is added by Ma.}]{added} text.` However, an error occurs, “Package xkeyval Error: ‘remark’ undefined in families ‘Changes@added’. ...id=Ma,remark={This is added by Ma.}]{added}” as actually there exists no `remark` defined in `changes` package (at least in my `changes` edition installed) [2]. The keyword `common` should be used instead.
{: .notice--warning}

Apart from using functions provided by `changes` package, Nebil [3] provided an interesting way to make inline annotations within the context, by a user-defining approach using `\newcommand` keyword:

```latex
% This example is from github repository by Nebil: https://gist.github.com/nebil/4e114e433c193297c0f3802bc9c33ef4
% This source code is licensed under a Creative Commons CC0 license.
% More info at <https://creativecommons.org/publicdomain/zero/1.0/>.
\documentclass[12pt]{article}
\usepackage{xcolor}

\begin{document}
% Describe the style of both the box and the text.
\newcommand{\remark}[3]{
    {\colorbox{#2}{\sffamily\scriptsize\bfseries\textcolor{white}{#1}}}
    {\sffamily\small\itshape\textcolor{#2}{#3}}
} 

% Define a new command--using the previously defined one--for each author.
\newcommand{\alice}[1]{\remark{Alice}{blue}{#1}}
\newcommand{\bob}[1]{\remark{Bob}{red}{#1}}

% A simple example
As a minimal working example, we add a paragraph with some plain-old vanilla text.
\alice{This is a quite remarkable paragraph, I must say!}
\bob{Thank you for that insightful inline remark, Alice.}
\end{document}
```

The generated PDF is showed as follow:

![image-20230830224747979](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230830224747979.png)

<br>

**References**

[1] [https://www.neusncp.com/user/blog?id=305#](https://www.neusncp.com/user/blog?id=305#).

[2] [xkeyval error when using the changes package - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/618627/xkeyval-error-when-using-the-changes-package).

[3] [💬 remark -- a simple command to add inline notes in LaTeX · GitHub](https://gist.github.com/nebil/4e114e433c193297c0f3802bc9c33ef4).
