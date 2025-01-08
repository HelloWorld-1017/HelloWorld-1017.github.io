---
title: LaTeX `\makeatletter` and `\makeatother`
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Fundamentals
date: 2025-01-02 19:57:18 +0800
last_modified_at: 2025-01-03 13:50:00 +0800
---

A description of the command pair `\makeatletter` and `\makeatother` shows as follows[^1]:

<div class="quote--left" markdown="1">

Synopsis:

```latex
\makeatletter
#   ... definition of commands with @ in their name ..
\makeatother
```

Use this pair when you <i class="emphasize">redefine LaTeX commands that are named with an at-sign character `@`</i>. The `\makeatletter` declaration makes the at-sign character have the category code of a letter, code 11. The `\makeatother` declaration sets the category code of the at-sign to code 12, its default value.

As TeX reads characters, it assigns each one a category code, or <i class="term">catcode</i>. For instance, it assigns the backslash character `\` the catcode `0`. Command names consist of a category `0` character, ordinarily backslash, followed by letters, category `11` characters (except that a command name can also consist of a category `0` character followed by a single non-letter symbol).

<i class="emphasize">LaTeX’s source code has the convention that some commands use `@` in their name.</i> These commands are mainly intended for package or class writers. The convention prevents authors who are just using a package or class from accidentally replacing such a command with one of their own, because by default the at-sign has catcode `12`.

Use the pair `\makeatletter` and `\makeatother` inside a `.tex` file, typically in the preamble, when you are defining or redefining commands named with `@`, by having them surround your definition. Don’t use these inside `.sty` or `.cls` files since the `\usepackage` and `\documentclass` commands already arrange that the at-sign has the character code of a letter, catcode 11.

For a comprehensive list of macros with an at-sign in their names see https://ctan.org/pkg/macros2e[^2].

In this example the class file has a command `\thesis@universityname` that the user wants to change. These three lines should go in the preamble, before the `\begin{document}`.

```latex
\makeatletter
\renewcommand{\thesis@universityname}{Saint Michael's College}
\makeatother
```

</div>

We can simply understand the role of this command pair is to change those macros, whose name include character `@`, defined in the macro packages. A simple example can be found in blog[^3].

<br>

**References**

- [`\makeatletter`和`\makeatother`是干什么用的](https://www.douban.com/note/621707892/?_i=5806936NS6B8ON).
- [macros - What do `\makeatletter` and `\makeatother` do?](https://tex.stackexchange.com/questions/8351/what-do-makeatletter-and-makeatother-do).
- [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, p. 477.

[^1]: [`\makeatletter` \& `\makeatother` (LaTeX2e unofficial reference manual (December 2024))](https://latexref.xyz/_005cmakeatletter-_0026-_005cmakeatother.html).
[^2]: [CTAN: Package `macros2e`](https://ctan.org/pkg/macros2e).
[^3]: [Realize Word Wrap for a Long Link Text When Using Commands of LaTeX `hyperref `Package](/2024-09-05/05-37-22.html).
