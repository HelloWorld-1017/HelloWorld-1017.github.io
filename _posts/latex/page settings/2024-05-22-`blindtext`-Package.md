---
title: "LaTeX `blindtext` Package: Generate Dummy Text (\"Blind\" Text)"
categories:
 - Design
 - LaTeX
tags:
 - LaTeX Page Settings
date: 2024-05-22 22:26:44 +0800
last_modified_at: 2024-08-04 23:29:41 +0800
---

# Introduction

Few days ago, I learned about LaTeX `lipsum` package[^1], which is to generate *Lorem Ipsum*  to test document layout. Those kinds of texts, like *Lorem Ipsum* with no any actual meanings, are also called dummy text, or "blind" text. In the process, I found another package `blindtext`[^2]; it is also used to test document style, but compared with `lipsum` its generated contents cover more elements, including text, section and subsection style at each level, and lists created by different commands. It is more like to generate a template. In this post, I would record some basic usages of `blindtext` package.

<br>

# Fundamental control commands of `blindtext` package

`blindtext` package provides two fundamental commands, `\blinddocument` and `\Blinddocument`. Both them are for creating random document[^2]; the former is to create document, and the latter is to create a bigger one. Take testing `IEEEtran` template[^5] (to produce officially-correct output for the Institute of Electrical and Electronics Engineers (IEEE) transactions, journals and conferences):

## `\blinddocument` command

```latex
\documentclass[lettersize,journal]{IEEEtran}
\usepackage{blindtext}

\begin{document}
	\blinddocument
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405200537562.png)

## `\Blinddocument` command

```latex
\documentclass[lettersize,journal]{IEEEtran}
\usepackage{blindtext}

\begin{document}
	\Blinddocument
\end{document}
```

At this time, 9 pages will be generated:

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211435754.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211436739.png)

![png-3](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211437879.png)

![png-4](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211437855.png)

![png-5](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211437584.png)

![png-6](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211438175.png)

![png-7](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211438433.png)

![png-8](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211438720.png)

![png-9](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211438453.png)

<br>

# Display Table of Contents (TOC)

By default, `\blinddocument` and `\Blinddocument` won't generate Table of Contents (TOC). We can use `toc` option to generate it:

```latex
\documentclass[lettersize,journal]{IEEEtran}
\usepackage[toc]{blindtext}

\begin{document}
	\blinddocument
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211745900.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405211746100.png)

<br>

# Different language versions

At the default case, the generated text is a short-version Latin *Lorem Ipsum*[^1], repeating the following paragraph time and time again:

---

*Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam lobortis facilisis sem. Nullam nec mi et neque pharetra sollicitudin. Praesent imperdiet mi nec ante. Donec ullamcorper, felis non sodales commodo, lectus velit ultrices augue, a dignissim nibh lectus placerat pede. Vivamus nunc nunc, molestie ut, ultricies vel, semper in, velit. Ut porttitor. Praesent in sapien. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Duis fringilla tristique neque. Sed interdum libero ut metus. Pellentesque placerat. Nam rutrum augue a leo. Morbi sed elit sit amet ante lobortis sollicitudin. Praesent blandit blandit mauris. Praesent lectus tellus, aliquet aliquam, luctus a, egestas a, turpis. Mauris lacinia lorem sit amet ipsum. Nunc quis urna dictum turpis accumsan semper.*

---

Actually, in addition to Latin, `blindtext` also supports generating text in other languages, such as English, German, French, and Greek, which is realized by combining `babel` package[^3][^4] and corresponding options. 

## English

```latex
\documentclass[lettersize,journal]{IEEEtran}
\usepackage[english]{babel}
\usepackage{blindtext}

\begin{document}
	\blinddocument
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405200543131.png)

## German

```latex
\documentclass[lettersize,journal]{IEEEtran}
\usepackage[german]{babel}
\usepackage{blindtext}

\begin{document}
	\blinddocument
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405200556120.png)

## French

```latex
\documentclass[lettersize,journal]{IEEEtran}
\usepackage[french]{babel}
\usepackage{blindtext}

\begin{document}
	\blinddocument
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405200555371.png)

## Greek

```latex
\documentclass[lettersize,journal]{IEEEtran}
\usepackage[greek]{babel}
\usepackage{blindtext}

\begin{document}
	\blinddocument
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405212100462.png)

<br>

# Other control commands in `blindtext` package

On another hand, `blindtext` package also provides some other commands to generate certain element individually, such as `\blindtext` (and `\Blindtext`), `\blinditemize`, `\blindenumerate`, `\blinddescription`, `\blindlist`, and `\blindlistlist`. 

```latex
\documentclass[lettersize,journal]{IEEEtran}
\usepackage{blindtext}

\begin{document}
	\verb*|\blindtext|
	\blindtext
	
	\verb*|\blinditemize|
	\blinditemize
	
	\verb*|\blindenumerate|
	\blindenumerate
	
	\verb*|\blinddescription|
	\blinddescription
	
	\verb*|\blindlist{itemize}[3]|
	\blindlist{itemize}[3]

	\verb*|\blindlist{enumerate}[3]|
	\blindlist{enumerate}[3]
	
	\verb*|\blindlistlist{itemize}[3]|
	\blindlistlist{itemize}[3]
	
	\verb*|\blindlistlist{enumerate}[3]|
	\blindlistlist{enumerate}[3]
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405212228672.png)

It's very convenient to use them to test text or list environment locally, for example:

```latex
\documentclass[lettersize,journal]{IEEEtran}
\usepackage{blindtext}
% For changing font typefaces, Refer to: https://www.overleaf.com/learn/latex/Font_typefaces
\usepackage[T1]{fontenc}
\usepackage{tgbonum}

\begin{document}
	\blindtext
	
	\textbf{\blindtext}
	
	{\Large \blindtext}
	
	{\fontfamily{cmr}\selectfont\blindtext} % Computer Modern Roman
	
	{\fontfamily{lmdh}\selectfont\blindtext} % Latin Modern Dunhill
	
	{\fontfamily{cmss}\selectfont\blindtext} % Computer Modern Sans Serif
	
	{\fontfamily{lmdh}\selectfont\blindlistlist{enumerate}[3]} % Latin Modern Dunhill
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405212310819.png)

<br>

# Test math environment

Besides, `blindtext` package also provides the `\blindmathpaper` control command to test math environment style:

```latex
\documentclass[lettersize,journal]{IEEEtran}
\usepackage{babel}
\usepackage{blindtext}

\begin{document}
	\blindmathpaper
\end{document}
```

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405200606283.png)

However, as can be seen, `\blindmathpaper` can only generate some display equations created by identifiers `$$ $$` or `\[ \]`; other formula environments are not included. 

<br>

# References

[^1]: [From LaTeX lipsum Package to Cicero’s de Finibus Bonorum et Malorum (On the ends of good and evil) and Cato Maior de Senectute (Cato the Elder on Old Age) - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-05-11/22-05-01.html).
[^2]: [CTAN: Package blindtext](https://ctan.org/pkg/blindtext).
[^3]: [CTAN: Package babel](https://ctan.org/pkg/babel?lang=en).
[^4]: [latex - Changing language of dummy document in blindtext package in Linux - Stack Overflow](https://stackoverflow.com/questions/70132622/changing-language-of-dummy-document-in-blindtext-package-in-linux).
[^5]: [CTAN: Package IEEEtran](https://ctan.org/pkg/ieeetran?lang=en).
