---
title: "TeX Primitive Command (Italic Correction) `\\/`"
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Font
date: 2024-03-27 08:25:49 +0800
last_modified_at: 2024-11-08 22:36:37 +0800
---

TeX primitive command `\/` can be used to add a small space after a letter[^1], so it can be used in some cases when typesetting in LaTeX system.

**(1) Cancel ligatures[^1][^2][^3][^4]**

There are some ligatures, that is some letters in a word are combined into a single symbol, when typesetting in LaTeX system. The presence and the form of ligatures are generally determined by the used font. For example, when using default Computer Modern or Latin Modern fonts, lowercase letter combinations $\text{ff}$, $\text{fi}$, $\text{fl}$, $\text{ffi}$, or $\text{ffl}$ will cause a ligature (some professional fonts will introduce more such combinations)[^1]. These five are the most basic ligatures in typesetting, the reason is that the letter $\text{f}$ exceeds its character boundary.

Ligature can be intentionally canceled by inserting `\/` command after the letter:

```latex
\documentclass{article}

\begin{document}
	\noindent
	ff, fi, fl, ffi, ffl\\
	f\/f, f\/i, f\/l, f\/f\/i, f\/f\/l\\
\end{document}
```

![image-20240326192031711](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403261920848.png)

**(2) Correct italic[^1]**

When using italic commands like `\itshape` and `\slshape`, the last italic letter will exceed the right boundary, making it close to the following roman letter. We can make an ***italic correction*** using `\/` command. For example:

```latex
\documentclass{article}

\begin{document}
	\noindent
	{\itshape M}M, {\slshape M}M\\
	{\itshape M\/}M, {\slshape M\/}M\\
\end{document}
```

![image-20240326194157182](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403261942273.png)

> Another way to correct is using the italic commands that with parameter, like `\textit{}` and `\textsl{}`: 
>
> ```latex
> \documentclass{article}
> 
> \begin{document}
> 	\noindent
> 	{\itshape M}M, {\slshape M}M\\
> 	{\itshape M\/}M, {\slshape M\/}M\\
> 	\textit{M}M, \textsl{M}M\\
> \end{document}
> ```
>
> ![image-20240326194401805](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403261944875.png)
>
> According to reference [^1] and what user Ulrike Fischer says in StackExchange[^2], `\textit` command will automatically insert `\/` to make an italic correction. If we think this kind of italic correction created by `\textit` is necessary in some cases, we can use `\nocorr` to disable this feature (and so is for `\textsl` command):
>
> ```latex
> \documentclass{article}
> 
> \begin{document}
> 	\noindent
> 	\textit{M}M, \textsl{M}M\\
> 	\textit{M\nocorr}M, \textsl{M\nocorr}M\\
> \end{document}
> ```
>
> ![image-20240326195943119](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403261959216.png)

**(3) Add the space between the bold letter and quotation mark [^1]**

`\/` also can be used to increase an appropriate distance between the bold letter, formatted by `\bfseries` command, and the quotation mark:

```latex
\documentclass{article}

\begin{document}
	\noindent
	Bold `{\bfseries leaf}'\\
	Bold `{\bfseries leaf\/}'\\
\end{document}
```

![image-20240326192246747](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403261922809.png)

> Similarly, another way is using `\textbf{}` to bold the characters:
>
> ```latex
> \documentclass{article}
> 
> \begin{document}
> 	\noindent 
> 	Bold `{\bfseries leaf}'\\
> 	Bold `{\bfseries leaf\/}'\\
> 	Bold `\textbf{leaf}'\\
> \end{document}
> ```
>
> ![image-20240326192327590](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403261923666.png)
>
> and we can also use `\nocorr` to disable the correction:
>
> ```latex
> \documentclass{article}
> 
> \begin{document}
> 	\noindent 
> 	Bold `\textbf{leaf}'\\
> 	Bold `\textbf{leaf\nocorr}'\\
> \end{document}
> ```
>
> ![image-20240326200321685](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403262003790.png)

By the way, the space size inserted by `\/` is related to the font size:

```latex
\documentclass{article}

\begin{document}
	\noindent
	ff, fi, fl, ffi, ffl\\
	f\/f, f\/i, f\/l, f\/f\/i, f\/f\/l\\
	{\huge f\/f, f\/i, f\/l, f\/f\/i, f\/f\/l}\\
	
	\noindent
	{\itshape M}M, {\slshape M}M\\
	{\itshape M\/}M, {\slshape M\/}M\\
	{\huge {\itshape M\/}M, {\slshape M\/}M}\\
	
	\noindent
	Bold `{\bfseries leaf}'\\
	Bold `{\bfseries leaf\/}'\\
	{\huge Bold `{\bfseries leaf\/}'}\\
\end{document}
```

![image-20240326204915905](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403262049031.png)

<br>

**References**

[^1]: 刘海洋编著. LaTeX入门. 北京: 电子工业出版社, 2013.6, pages 53, 64-65, available at: [LaTeX入门.pdf](https://yun.weicheng.men/Book/LaTeX%E5%85%A5%E9%97%A8.pdf).

[^2]: [primitives - What does \/ do? - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/231093/what-does-do).
[^3]: [TeX primitives listed by TeX engine - Overleaf, Online LaTeX Editor](https://www.overleaf.com/learn/latex/TeX_primitives_listed_by_TeX_engine).
[^4]: [How do I disable ligatures? - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/439651/how-do-i-disable-ligatures).



