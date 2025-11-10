---
title: Specify Typeface as Arial in LaTeX Using `\setsansfont` Command
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Font
 - LaTeX fontspec
location: Buffalo, United States
date: 2025-11-06 16:48:59 -0500
last_modified_at: 2025-11-10 13:33:29 -0500
---

Blog[^1] introduces a way to specify the typeface as Arial for a whole LaTeX document (don't forget to change the compiler to XeLaTeX):

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}

\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{fontspec}
\setmainfont{Arial}

\begin{document}
	\lipsum[1-8]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107220446736.png)

which way relies on the `fontspec` package and its `\setmainfont` command:

```latex
\usepackage{fontspec}
\setmainfont{Arial}
```

which means setting main typeface of the document as `Arial`.

However, recently I found a problem about this method, that is, it will lead to the typeface of the text in equation environments changing to Arial as well (especially the `\min` font in the following example):

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath}

\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{fontspec}
\setmainfont{Arial}

\begin{document}
\lipsum[1]

\begin{equation}
	\begin{split}
		\min\ & a^2+b^2\\
		& a,\ b\ge0\ \text{This is constraints.}\\
	\end{split}
\end{equation}

\lipsum[2]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107220833220.png)

Actually, this feature is reasonable, because we set the *main typeface*.

If we don't want to influence equation environments, we can choose using:

```latex
\setsansfont{Arial}
```

to only change the sans-serif font as Arial, and then use `\sffamily` command in the main text (by the way, using this method, we also need to specify the compiler as XeLaTeX of course):

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath}

\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{fontspec}
\setsansfont{Arial}

\begin{document}
\sffamily

\lipsum[1]

\begin{equation}
	\begin{split}
		\min\ & a^2+b^2\\
		& a,\ b\ge0\ \text{This is constraints.}\\
	\end{split}
\end{equation}

\lipsum[2]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107221500920.png)

At this time, we can see the font of "min" in the equation is still Time New Roman (although the text created by `\text` command is changed to Arial, like we used `\setmainfont{Arial}` above).

Or, we can put `\sffamily` in a `{}` to make it functional locally:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath}

\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\usepackage{fontspec}
\setsansfont{Arial}

\begin{document}
{\sffamily \lipsum[1]}

\begin{equation}
	\begin{split}
		\min\ & a^2+b^2\\
		& a,\ b\ge0\ \text{This is constraints.}\\
	\end{split}
\end{equation}

\lipsum[2]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107221735503.png)

By the way, if we don't specify sans-serif font as Arial, the default sans-serif font is Computer Modern Sans Serif (a font designed by Knuth)[^2]:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath}

\usepackage{lipsum}

\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}

\begin{document}
{\sffamily \lipsum[1]}

\begin{equation}
	\begin{split}
		\min\ & a^2+b^2\\
		& a,\ b\ge0\ \text{This is constraints.}\\
	\end{split}
\end{equation}

\lipsum[2]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251107222145489.png)

It seems, at least for me, not that common.

<br>

**References**

[^1]: [Specify Typeface as Arial for the Whole Document in LaTeX](/2024-11-12/15-59-38.html).
[^2]: [Identity of LaTeX default sans serif font](https://tex.stackexchange.com/questions/30814/identity-of-latex-default-sans-serif-font).