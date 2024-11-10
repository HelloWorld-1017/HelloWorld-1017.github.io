---
title: Specify Page Background Color in LaTeX
categories:
 - LaTeX
tags:
 - LaTeX Page Settings
 - LaTeX TikZ
date: 2024-06-01 13:16:55 +0800
last_modified_at: 2024-06-01 13:16:55 +0800
---

# Introduction

Jidan's blog, *How do you change background color of page in LaTeX*[^1], gives some examples showing how to specify page background color when typesetting in LaTeX system. In this post, I will reproduce and take some notes about some of them which I think are fundamental and commonly used.

<br>

#  LaTeX `xcolor` package

`\pagecolor{$COLOR_NAME}` command is provided by LaTeX `xcolor` package[^2], and its function is to "specify the background color for the current, and all following, pages.", and "it is a global declaration which does not respect $\mathrm{\TeX}$​ groups." By setting `$COLOR_NAME` as some built-in color names preset by `xcolor` package, it is easy to change page background color:

NOTE: More information about built-in color names of `xcolor` package can be found in my previous blog.[^3]
{: .notice--primary}

```latex
\documentclass[a4paper,12pt]{article}
\usepackage[margin=1in]{geometry}

\usepackage{lipsum}

\usepackage{xcolor}
\pagecolor{yellow}

\begin{document}
	\lipsum[1-10]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406011024847.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406011024090.png)

As mentioned above, `\pagecolor` command will specify background color for all following pages. As in the above case I use it in the preamble, it will dictate all pages in the documentation. If we want to cancel page color settings, we can use `\newpage` command to create a new page, and `\nopagecolor`, which is also provided by `xcolor` package, to clear background color for subsequent pages, like:

```latex
\documentclass[a4paper,12pt]{article}
\usepackage[margin=1in]{geometry}

\usepackage{lipsum}

\usepackage{xcolor}
\pagecolor{yellow}

\begin{document}
	\lipsum[1-6]
	
	\newpage
	\nopagecolor
	\lipsum[1-10]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406011035952.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406011035283.png)

![png-3](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202406011035485.png)

Besides, by combining `\pagecolor` and `\newpage` commands in the main `document` environment, we can specify page background color for different parts:

```latex
\documentclass[a4paper,12pt]{article}
\usepackage[margin=1in]{geometry}

\usepackage[x11names]{xcolor}

\usepackage{lipsum}

\begin{document}
	\pagecolor{AntiqueWhite1}
	\lipsum[1-6]
	
	\newpage
	\pagecolor{AntiqueWhite2}
	\lipsum[1-6]
	
	\newpage
	\pagecolor{AntiqueWhite3}
	\lipsum[1-6]
	
	\newpage
	\pagecolor{AntiqueWhite4}
	\lipsum[1-6]
\end{document}
```

NOTE: To use color name `AntiqueWhite1` and *etc.*, we should specify option `x11names` when importing `xcolor` package[^3]. 
{: .notice--primary}

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311857019.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311857407.png)

![png-3](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311859361.png)

![png-4](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311859122.png)

In addition to those built-in color names, we can customize our own colors in the preamble by `\definecolor` command or `\colorlet`, where both commands are also provided by `xcolor` package[^2]:

```latex
\documentclass[a4paper,12pt]{article}
\usepackage[margin=1in]{geometry}

\usepackage[x11names]{xcolor}
\definecolor{bgRGB}{RGB}{255,210,210}
\definecolor{bgHTML}{HTML}{E0FFE0}
\definecolor{bgCMYK}{cmyk}{0.1,0.1,0,0}
\colorlet{mixedcolor}{red!60!blue} % Mixed color
\colorlet{transparentRed}{red!7!white} % Transparent red

\usepackage{lipsum}

\begin{document}
	\pagecolor{bgRGB}
	\lipsum[1-6]
	
	\newpage
	\pagecolor{bgHTML}
	\lipsum[1-6]
	
	\newpage
	\pagecolor{bgCMYK}
	\lipsum[1-6]
	
	\newpage
	\pagecolor{mixedcolor}
	\lipsum[1-6]
	
	\newpage
	\pagecolor{transparentRed}
	\lipsum[1-6]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311916380.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311916510.png)

![png-3](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311916347.png)

![png-4](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311921439.png)

![png-5](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311927451.png)

What's more, we can globally specify background color for those even and odd pages respectively. To this end, the `\afterpage` command of `afterpage` package[^5] is needed. 

```latex
\documentclass[a4paper,12pt]{article}
\usepackage[margin=1in]{geometry}

\usepackage{xcolor,afterpage}
\newcommand{\togglePageColor}{
	\ifodd\value{page}
	\pagecolor{red!20}
	\afterpage{\togglePageColor}
	\else
	\pagecolor{green!20}
	\afterpage{\togglePageColor}
	\fi
}

\usepackage{lipsum}

\begin{document}
	\togglePageColor
	
	\lipsum[1-20]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311951663.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311951547.png)

![png-3](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311951666.png)

![png-4](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311951287.png)

<br>

# LaTeX `pagecolor` package

Actually, as mentioned in Jidan's blog[^1], there is a more professional package called `pagecolor`[^6], providing several other commands to control page background color in a more detailed way. However, at this moment, `\pagecolor` command of `xcolor` package is enough to meet my ends, so I wouldn't introduce more about `pagecolor` package here.

<br>

# LaTeX `tikZ` package

Besides using commands of `xcolor` package to set page background color, another way is through `tikz` package. It is realized by creating a colorful shade covering the whole page by `tikzpicture` environment. More importantly, this way allows us to make a page background with gradient colors.

```latex
\documentclass[a4paper,12pt]{article}
\usepackage[margin=1in]{geometry}

\usepackage{tikz}
\usepackage{lipsum}

\begin{document}
	\begin{tikzpicture}[remember picture, overlay]
		\shade[top color=red!30, bottom color=yellow] (current page.south west) rectangle (current page.north east);
	\end{tikzpicture}
	
	\lipsum[1-11]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311943772.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311943814.png)

However, as can be seen, this method can merely change background color of one page. If we want to specify page background color for all pages in the documentation, we can put aforementioned `tikzpicture` environment into `contents` option of `\backgroundsetup` command. `\backgroundsetup` is from `background` package[^4], and actually `background` package provides functions to control many other aspects of page background.

```latex
\documentclass[a4paper,12pt]{article}
\usepackage[margin=1in]{geometry}

\usepackage{tikz}
\usepackage{background}

\backgroundsetup{
	scale=1,
	color=black,
	opacity=1,
	angle=0,
	position=current page.south,
	vshift=0cm,
	hshift=0cm,
	contents={
		\begin{tikzpicture}[remember picture, overlay]
			\shade[top color=red!30, bottom color=yellow] (current page.south west) rectangle (current page.north east);
		\end{tikzpicture}
	}
}

\usepackage{lipsum}

\begin{document}
	\lipsum[1-11]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311940296.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405311940753.png)

<br>

# References

[^1]: [How do you change background color of page in LaTeX?](https://www.physicsread.com/latex-page-color-and-background-color-of-document/).
[^2]: [CTAN: Package xcolor](https://ctan.org/pkg/xcolor?lang=en).
[^3]: [Built-in Colors in LaTeX xcolor Package - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-10-17/18-16-22.html).
[^4]: [CTAN: Package background](https://ctan.org/pkg/background?lang=en).
[^5]: [CTAN: Package afterpage](https://ctan.org/pkg/afterpage?lang=en).
[^6]: [CTAN: Package pagecolor](https://ctan.org/pkg/pagecolor?lang=en).
