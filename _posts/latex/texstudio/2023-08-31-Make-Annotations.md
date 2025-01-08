---
title: "Make Annotations in LaTeX for documents: `soul` package, `changes` package, `easyReview` package, and one user-defined method"
categories:
 - LaTeX
tags:
 - TeXstudio
date: 2023-08-31 08:52:55 +0800
last_modified_at: 2024-11-08 22:45:44 +0800
---

# `soul` package: highlight the text

Highlighting text in LaTeX can be realized by `soul` package [^1]. And, bear in mind that do import `color` package, otherwise the color cannot display normally. In addition, we could use `\sethlcolor` defined in `soul` package to change highlight color, but this setting will influence the whole following context unless we reset color setting using `\sethlcolor` again. For example: 

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

![image-20230830215902044](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230830215902044.png?raw=true)

<br>

# `changes` package: record modifications and make comments

If we want to record what have changed in the documentation, `changes` package is a good choice [^1], and by which we could make some necessary comments for it, like:

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

![image-20230830221530665](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230830221530665.png?raw=true)

Note: In hxy's blog [^1], the remark is added by keyword `remark`, like `This is \added[id=Ma,remark={This is added by Ma.}]{added} text.` However, an error occurs, “Package xkeyval Error: ‘remark’ undefined in families ‘Changes@added’. ...id=Ma,remark={This is added by Ma.}]{added}” as actually there exists no `remark` defined in `changes` package (at least for the `changes` package installed in my PC) [^2]. The keyword `comment` should be used instead.
{: .notice--warning}

<br>

# `easyReview` package: help to mark in the review and editorial process

## Basic commands

In LaTeX editor TeXstudio, there are five quick command buttons in the tool bar:

![image-20240606122147959](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406061222194.png)

They correspond to commands `\alter`, `\comment`, `\add`, `\remove`, and `\replace`, respectively. To use these commands, we should import `easyReview` package[^4] in the preamble. 

`easyReview` package[^5] mainly provides six commands to help to review (or perform editorial process), including five aforementioned commands and `\highlight`, which is literally to highlight text. Their effects are as follows:

```latex
\documentclass[a5paper]{article}

%\usepackage{setspace}
%\renewcommand{\baselinestretch}{1.2}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{easyReview} 

\setlength{\parskip}{10pt}

\begin{document}
	\thispagestyle{empty}
	
	\verb*|\alert{text}| A text without the alert command. \alert{A text with the alert command.}
	
	\verb*|\comment{text}{comment}| \comment{This text will receive a comment.}{\textit{This is the comment I have.}}
	
	\verb*|\add{text}| This text was already in the text. \add{This text is been added now.} 

	\verb*|\highlight{text}| A text without the highlight command. \highlight{A text with the highlight command.}
	
	\verb*|\remove{text}| This text is not to be removed. \remove{This text is to be removed.}
	
	\verb*|\replace{text}{replacement}| \replace{This part of the text needs to be replaced.}{for this newer part of the text}.
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406061542308.png)

## `\setreviewsoff` and `\setreviewson`

`easyReview` package also provides a command named `\setreviewsoff` to not display reviews (if not declared, the default case amounts to conducting command `\setreviewon`). Take adding `\setreviewsoff` into the preamble:

```latex
% ...

\usepackage{easyReview} 
\setreviewsoff

% ...

\begin{document}
	% ...
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406061544105.png)

However, I think this function is not that useful and may make the text more confused.

## Change annotation colors

As described in `esayReview` package documentation[^5], users can change *all* colors but the highlight color, by these assignments that has literally meanings:

{% raw %}

```
\renewcommand{\alertColor}{\textcolor{%new alert color%}}
\renewcommand{\removeColor}{\textcolor{%new remove color%}}
\renewcommand{\addColor}{\textcolor{%new add color%}}
```

{% endraw %}

For example:

```latex
\documentclass[a5paper]{article}

%\usepackage{setspace}
%\renewcommand{\baselinestretch}{1.2}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{easyReview} 
\renewcommand{\alertColor}{\textcolor{Magenta4}}
\renewcommand{\removeColor}{\textcolor{LightBlue4}}
\renewcommand{\addColor}{\textcolor{Green4}}

\setlength{\parskip}{10pt}

\begin{document}
	\thispagestyle{empty}
	
	\verb*|\alert{text}| A text without the alert command. \alert{A text with the alert command.}
	
	\verb*|\comment{text}{comment}| \comment{This text will receive a comment.}{\textit{This is the comment I have.}}
	
	\verb*|\add{text}| This text was already in the text. \add{This text is been added now.} 
	
	\verb*|\highlight{text}| A text without the highlight command. \highlight{A text with the highlight command.}
	
	\verb*|\remove{text}| This text is not to be removed. \remove{This text is to be removed.}
	
	\verb*|\replace{text}{replacement}| \replace{This part of the text needs to be replaced.}{for this newer part of the text}.
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406061601827.png)

As can be seen, the setting for "remove" color seem not functional, and always same as "alert" color. Besides, there is no a specific command to modify the background color and text color of "comment" block.

## Conflict with `\lipsum` command

At the beginning, I want to use `\lipsum` command of `lipsum` package[^6] to test those commands in `easyReview` package. However, for commands `\comment`, `\highlight`, `\remove`, and `\replace`, taking `\lipsum` commands as input parameter would incur errors. Finally, I had to use explicit text to make it work, like:

```latex
\documentclass[a5paper]{article}
\usepackage[margin=1in]{geometry}
\setlength{\parskip}{7pt}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{easyReview} 

\usepackage{lipsum}

\begin{document}
	\thispagestyle{empty}
	
	\verb*|\alert{text}| \alert{\lipsum[1][1-4]}
	
	\verb*|\comment{text}{comment}| \comment{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce neque leo, dignissim ut pellentesque at, eleifend eget arcu.}{\lipsum[1][1-4]}
	
	\verb*|\add{text}| \add{\lipsum[1][1-4]}
	
	\verb*|\highlight{text}| \highlight{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce neque leo, dignissim ut pellentesque at, eleifend eget arcu. Fusce lacinia nulla id turpis iaculis, et venenatis purus volutpat. Pellentesque elementum massa vel pulvinar elementum.}
	
	\verb*|\remove{text}| \remove{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce neque leo, dignissim ut pellentesque at, eleifend eget arcu. Fusce lacinia nulla id turpis iaculis, et venenatis purus volutpat. Pellentesque elementum massa vel pulvinar elementum.}
	
	\verb*|\replace{text}{replacement}| \replace{Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce neque leo, dignissim ut pellentesque at, eleifend eget arcu. Fusce lacinia nulla id turpis iaculis, et venenatis purus volutpat. Pellentesque elementum massa vel pulvinar elementum.}{\lipsum[1][1-4]}
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406061620755.png)

Before, I always wrongly view `\lipsum` as a command to merely generate a plain dummy text and use it to test many commands, but actually, according to my previous experiences, error usually occurs when `\lipsum` is taken as input parameter for many commands. At this moment, I realize that, for `\lipsum`, generating text is only a means, but not ends: its ends is to test document layout. For this reason, using `\lipsum` to test other commands is not an appropriate approach.

<br>

# A user-defined method to create inline annotations

Apart from using functions provided by those LaTeX packages, Nebil [^3] provided an interesting way to make inline annotations within the context, by a user-defined approach using `\newcommand` keyword:

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

![image-20230830224747979](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230830224747979.png?raw=true)

<br>

**References**

[^1]: [https://www.neusncp.com/user/blog?id=305#](https://www.neusncp.com/user/blog?id=305#).
[^2]: [xkeyval error when using the changes package](https://tex.stackexchange.com/questions/618627/xkeyval-error-when-using-the-changes-package).
[^3]: [remark -- a simple command to add inline notes in LaTeX · GitHub](https://gist.github.com/nebil/4e114e433c193297c0f3802bc9c33ef4).
[^4]: [texstudio commands \comment \alert and \add](https://tex.stackexchange.com/questions/619426/texstudio-commands-comment-alert-and-add).
[^5]: [CTAN: Package easyReview](https://ctan.org/pkg/easyreview?lang=en).

[^6]: [From LaTeX lipsum Package to Cicero’s de Finibus Bonorum et Malorum (On the ends of good and evil) and Cato Maior de Senectute (Cato the Elder on Old Age)](https://helloworld-1017.github.io/2024-05-11/22-05-01.html).
