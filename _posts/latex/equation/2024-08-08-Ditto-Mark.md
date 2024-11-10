---
title: Ditto Mark in LaTeX, Markdown file, and Webpage
toc: false
categories:
 - LaTeX
 - Web Development
tags:
 - HTML
 - LaTeX Equation
 - LaTeX Font
 - LaTeX fontenc
 - LaTeX Warnings and Errors
date: 2024-08-08 12:11:06 +0800
last_modified_at: 2024-11-09 12:22:46 +0800
---

**Ditto mark in LaTeX**[^1][^2]

```latex
\documentclass{article}
\usepackage[T1]{fontenc}

\begin{document}

	\textquotedbl

\end{document}
```

![image-20240809144821886](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408091448927.png)

<div class="notice--warning" markdown="1">

Note that code `\usepackage[T1]{fontenc}` is necessary, meaning that import package `fontenc`[^8] and make documentation adopt T1 font encoding (a.k.a. Cork encoding)[^7], otherwise following error occurs[^3]:

```
Command \textquotedbl unavailable in encoding OT1. \textquotedbl
```

</div>

There is another format[^1]:

```latex
---\textquotedbl---
```

![image-20240809144910611](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408091449639.png)

**Ditto mark in Markdown file and webpages**[^4]

HTML character code `&#12291;`: &#12291; ;

<br>

**Meaning of ditto mark**

<div class="quote--left" markdown="1">

Ditto is a mark (〃) that you write immediately *under a word in a list* to show that the same word is repeated.[^5]

The ditto mark is a shorthand sign, used mostly *in hand-written text*, indicating that *the words or figures above it* are to be repeated.[^6]

</div>

It is convenient to use this mark, and (I guess) may be cost-saving when printing text centuries ago.

<br>

**References**

[^1]: [fonts - Is there a ditto symbol?](https://tex.stackexchange.com/questions/53823/is-there-a-ditto-symbol).
[^2]: [The Comprehensive LaTeX Symbol List](https://faculty.bard.edu/bloch/symbols-letter.pdf), Scott Pakin, 2003.
[^3]: [Command `\k` unavailable in encoding OT1 (error takes me to line which doesn't even have "`\k`" in it](https://tex.stackexchange.com/questions/392208/command-k-unavailable-in-encoding-ot1-error-takes-me-to-line-which-doesnt-eve).
[^4]: [〃 - Ditto Mark ](https://symbl.cc/en/3003/).
[^5]: [ditto](https://www.ldoceonline.com/dictionary/ditto).
[^6]: [Ditto mark](https://en.wikipedia.org/wiki/Ditto_mark).
[^7]: [Cork encoding](https://en.wikipedia.org/wiki/Cork_encoding).
[^8]: [CTAN: Package fontenc](https://ctan.org/pkg/fontenc?lang=en).
