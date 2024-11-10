---
title: "\"The quick brown fox jumps over the lazy dog.\""
toc: false
categories:
 - Design
 - LaTeX
tags:
 - LaTeX Font
date: 2024-05-31 10:02:38 +0800
last_modified_at: 2024-11-09 14:02:44 +0800
---

<div class="quote--left" markdown="1">

"The quick brown fox jumps over the lazy dog" is an English-language pangram -- a sentence that <i class="emphasize">contains all the letters of the alphabet</i>. The phrase is commonly used for touch-typing practice, testing typewriters and computer keyboards, displaying examples of fonts, and other applications involving text where the use of all letters in the alphabet is desired.[^1]

</div>

```latex
\documentclass{standalone}
\standaloneconfig{preview, border=2em}
\usepackage[x11names]{xcolor}

\pagecolor{AntiqueWhite1}

\begin{document}
	The quick brown fox jumps over the lazy dog.
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411091418967.png" alt="png-1" style="width:67%;" />

<br>

**References**

- [fontsamples.pdf](https://latex.silmaril.ie/formattinginformation/images/fontsamples.pdf).

[^1]: [The quick brown fox jumps over the lazy dog](https://en.wikipedia.org/wiki/The_quick_brown_fox_jumps_over_the_lazy_dog).