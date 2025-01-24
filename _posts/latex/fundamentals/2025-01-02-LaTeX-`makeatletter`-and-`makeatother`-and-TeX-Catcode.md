---
title: LaTeX `\makeatletter` and `\makeatother` and TeX Catcode
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Fundamentals
 - TeX
date: 2025-01-02 19:57:18 +0800
last_modified_at: 2025-01-24 13:44:55 +0800
---

A description of the command pair `\makeatletter` and `\makeatother` shows as follows[^1]:

<div class="quote--left" markdown="1">

Synopsis:

```latex
\makeatletter
#   ... definition of commands with @ in their name ..
\makeatother
```

Use this pair when you <i class="emphasize">redefine LaTeX commands that are named with an at-sign character `@`</i>. The `\makeatletter` declaration makes the at-sign character have the category code of a letter, code `11`. The `\makeatother` declaration sets the category code of the at-sign to code `12`, its default value.

As TeX reads characters, it assigns each one a category code, or <i class="term">catcode</i>. For instance, it assigns the backslash character `\` the catcode `0`. Command names consist of a category `0` character, ordinarily backslash, followed by letters, category `11` characters (except that a command name can also consist of a category `0` character followed by a single non-letter symbol).

<i class="emphasize">LaTeX’s source code has the convention that some commands use `@` in their name.</i> These commands are mainly intended for package or class writers. The convention prevents authors who are just using a package or class from accidentally replacing such a command with one of their own, because by default the at-sign has catcode `12`.

Use the pair `\makeatletter` and `\makeatother` inside a `.tex` file, typically in the preamble, when you are defining or redefining commands named with `@`, by having them surround your definition. Don’t use these inside `.sty` or `.cls` files since the `\usepackage` and `\documentclass` commands already arrange that the at-sign has the character code of a letter, catcode `11`.

For a comprehensive list of macros with an at-sign in their names see[^2].

In this example the class file has a command `\thesis@universityname` that the user wants to change. These three lines should go in the preamble, before the `\begin{document}`.

```latex
\makeatletter
\renewcommand{\thesis@universityname}{Saint Michael's College}
\makeatother
```

</div>

Simply speaking, the command `\makeatletter` (“make”+“at”+“letter”) is to make symbol `@` as a normal “letter”, whose TeX catcode is `11`, and the command `\makeatother` (“make”+“at”+“other”) is to make `@` as an “other character”, whose catcode is `12`[^5]. 

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501241332694.png" alt="image-20250124133200610" style="width:67%;" />

By using `\makeatletter` and `\makeatother`, we can access or modify those LaTeX internal macros[^2] in the LaTeX document. This reason why we should use these tow commands to make LaTeX internal macros available in the LaTeX document is that, the symbol `@` included in the LaTeX internal macros’ name is viewed as a “letter”, while in the LaTeX document `@` is treated as an “other character”. As a result, if we’d like to utilize LaTeX internal macros in the LaTeX document, we should firstly convert `@` into “letter”, and after use, convert it to “other character” again. A simple example of using internal macro `\g@addto@macro` in the LaTeX document can be found in my previous blog[^3].

<br>

As for TeX catcode, every input character is assigned a catcode at the first step of compilation phase, and this catcode determines how the character will be handled in the following stages[^4].

<div class="quote--left" markdown="1">

TeX commands commonly start with a backslash and are grouped with curly braces. Almost all of TeX's syntactic properties can be changed on the fly, which makes TeX input hard to parse by anything but TeX itself. TeX is a macro- and token-based language: many commands, including most user-defined ones, are expanded on the fly until only unexpandable tokens remain, which are then executed. Expansion itself is practically free from side effects. Tail recursion of macros takes no memory, and if-then-else constructs are available. This makes TeX a Turing-complete language even at the expansion level. The system can be divided into four levels: <i class="emphasize">in the first, characters are read from the input file and assigned a category code (sometimes called "catcode", for short)</i>. Combinations of a backslash (actually, any character of category zero) followed by letters (characters of category `11`) or a single other character are replaced by a control-sequence token. In this sense, this stage is like lexical analysis, although it does not form numbers from digits. In the next stage, expandable control sequences (such as conditionals or defined macros) are replaced by their replacement text. The input for the third stage is then a stream of characters (including the ones with special meaning) and unexpandable control sequences (typically assignments and visual commands). Here, the characters get assembled into a paragraph, and TeX's paragraph breaking algorithm works by optimizing breakpoints over the whole paragraph. The fourth stage breaks the vertical list of lines and other material into pages.

</div>

**References**

- [`\makeatletter`和`\makeatother`是干什么用的](https://www.douban.com/note/621707892/?_i=5806936NS6B8ON).
- [macros - What do `\makeatletter` and `\makeatother` do?](https://tex.stackexchange.com/questions/8351/what-do-makeatletter-and-makeatother-do).
- [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, p. 477.

[^1]: [`\makeatletter` & `\makeatother` (LaTeX2e unofficial reference manual (December 2024))](https://latexref.xyz/_005cmakeatletter-_0026-_005cmakeatother.html).
[^2]: [CTAN: Package `macros2e`](https://ctan.org/pkg/macros2e).
[^3]: [Realize Word Wrap for a Long Link Text When Using Commands of LaTeX `hyperref` Package](/2024-09-05/05-37-22.html).
[^4]: [TeX](https://en.wikipedia.org/wiki/TeX).
[^5]: [Table of TeX category codes](https://www.overleaf.com/learn/latex/Table_of_TeX_category_codes).
