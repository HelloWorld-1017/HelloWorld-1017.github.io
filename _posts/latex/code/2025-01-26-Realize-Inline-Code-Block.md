---
title: "Realize Inline Code Block in LaTeX: `\\verb`, `\\verb*`, `\\texttt`, vs. `\\lstinline` of `listings` Package"
toc: false
tags:
 - LaTeX Font
 - LaTeX listings
 - LaTeX Warnings and Errors
date: 2025-01-26 11:48:05 +0800
last_modified_at: 2025-01-26 11:48:05 +0800
---

In LaTeX, we can use command `\verb` or `\verb*` to insert an inline code block among the main text[^1], and the syntax is[^2]:

```
\verb char literal-text char
\verb* char literal-text char
```

where `char` can be `|`, `!`, `+`, `_`, or `"` *et al.*, for example,

```latex
\documentclass{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\setlength\parindent{0pt}

\begin{document}
This is a \verb|latex command \LaTeX|.\\
This is a \verb!latex command \LaTeX!.\\
This is a \verb+latex command \LaTeX+.\\
This is a \verb_latex command \LaTeX_.\\
This is a \verb"latex command \LaTeX".\\
This is a \verb#latex command \LaTeX#.\\
This is a \verb@latex command \LaTeX@.\\

This is a \verb*|latex command \LaTeX|.\\
This is a \verb*!latex command \LaTeX!.\\
This is a \verb*+latex command \LaTeX+.\\
This is a \verb*_latex command \LaTeX_.\\
This is a \verb*"latex command \LaTeX".\\
This is a \verb*#latex command \LaTeX#.\\
This is a \verb*@latex command \LaTeX@.\\
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261453343.png" alt="image-20250126145305256" style="width:50%;" />

As can be seen,

1. the `literal-text` wrapped in the `char`s is displayed in typewriter font;
2. compared to `\verb`, the spaces in `\verb*` are printed with a visible space character.

However, these two commands are fragile[^2], which would cause errors in many circumstances. Here are three examples.

**(1) In `\section` command**

```latex
\documentclass{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\setlength\parindent{0pt}

\begin{document}

\section{\verb*|latex command \LaTeX|}

\end{document}
```

```
line 8: \verb illegal in argument. \section{\verb*|latex command \LaTeX|}
line 8: Argument of \@sect has an extra }. \section{\verb*|latex command \LaTeX|}
line 8: Paragraph ended before \@sect was complete. \section{\verb*|latex command \LaTeX|}
line 10: Argument of \@gobble has an extra }. \end{document}
line 10: Paragraph ended before \@gobble was complete. \end{document}
line 10: Argument of \@gobble has an extra }. \end{document}
line 10: Paragraph ended before \@gobble was complete. \end{document}
line 10: Argument of \@firstoftwo has an extra }. \end{document}
line 10: Paragraph ended before \@firstoftwo was complete. \end{document}
line 10: Missing \endcsname inserted. \end{document}
...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261424738.png" alt="image-20250126142442675" style="width:50%;" />

**(2) In `\textcolor` command**

```latex
\documentclass{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\setlength\parindent{0pt}

\begin{document}

\textcolor{red}{\verb*|latex command \LaTeX|}

\end{document}
```

```
line 8: \verb illegal in argument. \textcolor{red}{\verb*|latex command \LaTeX|}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261425361.png" alt="image-20250126142551300" style="width:50%;" />

**(3) In `\makebox` command**

```latex
\documentclass{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\setlength\parindent{0pt}

\begin{document}

\makebox[10pt]{\verb|latex command \LaTeX|}

\end{document}
```

```
line 8: Missing } inserted. \makebox[10pt]{\verb|latex command \LaTeX|}
line 8: Extra }, or forgotten \endgroup. \makebox[10pt]{\verb|latex command \LaTeX|}
line 8: \verb illegal in argument. \makebox[10pt]{\verb|latex command \LaTeX|}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261427857.png" alt="image-20250126142705766" style="width:50%;" />

The reason is that we can’t use `\verb` and `\verb*` as a part of setting an argument of a macro[^2]:

<div class="quote--left" markdown="1">

You cannot use `\verb` in the argument to a macro, for instance in the argument to a `\section`. It is not a question of `\verb` being fragile (see `\protect`[^3]), instead it just cannot work, as the `\verb` command changes the catcode regime before reading its argument, and restore it immediately afterward, nevertheless with a macro argument the content of the argument has already be converted to a token list along the catcode regime in effect when the macro was called. However, the `cprotect` package[^4] can help with this.

</div>

For the `\section` command, we could use `\cprotect` command provided by `cprotect` package[^4] to solve the problem:

```latex
\documentclass{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{cprotect}

\setlength\parindent{0pt}

\begin{document}

\cprotect\section{\verb|latex command \LaTeX|}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261428389.png" alt="image-20250126142831326" style="width:50%;" />

but it’s not workable for `\textcolor` and `\makebox` *et al.* commands.

<div class="notice--primary" markdown="1">

Commands `\verb` and `\verb*` are not professional for inline code block designed on purpose, but many writers get used to using them to display code to contrast with the surrounded main text. In fact, they are respectively inline version of `verbatim` and `verbatim*` environment, which is literally for verbatim transcription. This accounts for, to some extent, why they are not compatible with other macros.

<div class="quote--left" markdown="1">

The `verbatim` environment is a paragraph-making environment that gets LaTeX to print exactly what you type in. It turns LaTeX into a typewriter with carriage returns and blanks having the same effect that they would on a typewriter. The output looks exactly as it looks in the input file.[^5]

</div>

like[^6]:

```latex
\documentclass{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\setlength\parindent{0pt}

\begin{document}

\begin{verbatim}
#!usr/bin/env perl
$name = "guy";
print "Hello, $name!\n";
\end{verbatim}

\begin{verbatim*}
#include <stdio.h>
main() {
	printf("Hello, world.\n");
}
\end{verbatim*}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261323188.png" alt="image-20250126132331113" style="width:50%;" />

</div>

To avoid the problem caused by `\verb` in some cases, we can utilize `\texttt` command to realize the same visual effect, i.e. displaying the text in the typewriter font[^7]:

```latex
\documentclass{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\setlength\parindent{0pt}

\begin{document}

\section{\texttt{latex command \textbackslash LaTeX}}

\textcolor{red}{\texttt{latex command \textbackslash LaTeX}}\\

\makebox[10pt]{\texttt{latex command \textbackslash LaTeX}}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261429979.png" alt="image-20250126142950906" style="width:50%;" />

but we should note the way of dealing with some special characters in each programming language, like use `\textbackslash` to output `\` in the above example.

<br>

Besides, the `\lstinline` command of `listings` package is also could be used to show inline code[^8]:

```latex
\documentclass{article}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{cprotect}
\setlength\parindent{0pt}

\usepackage{listings}
\lstset{basicstyle=\ttfamily} % Note here.

\begin{document}

\lstinline{latex command \LaTeX}

\cprotect\section{\lstinline{latex command \LaTeX}}

\textcolor{red}{\lstinline{latex command \LaTeX}}

\makebox[10pt]{\lstinline{latex command \LaTeX}}
\end{document}
```

```
line 16: Improper alphabetic constant. ...lor{red}{\lstinline{latex command \LaTeX}}
line 18: Improper alphabetic constant. ...ox[10pt]{\lstinline{latex command \LaTeX}}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501261448721.png" alt="image-20250126144819642" style="width:50%;" />

but as shown, this command will cause similar errors as `\verb` (and its syntax also resembles `\verb`[^9]).

<br>

**References**

[^1]: [Insert inline code block in Latex document](https://stackoverflow.com/questions/66192685/insert-inline-code-block-in-latex-document).
[^2]: [`\verb` (LaTeX2e unofficial reference manual (January 2025))](https://latexref.xyz/_005cverb.html#:~:text=The%20*%20-form%20differs%20only%20in,with%20extension!%20and%20...).
[^3]: [`\protect` (LaTeX2e unofficial reference manual (January 2025))](https://latexref.xyz/_005cprotect.html).
[^4]: [CTAN: Package `cprotect`](https://ctan.org/pkg/cprotect).
[^5]: [LaTeX help 1.1 - `verbatim`](https://emerson.emory.edu/services/latex/latex_80.html).
[^6]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX%E5%85%A5%E9%97%A8.pdf), 刘海洋编著, p. 110.
[^7]: [verbatim - When should one use `\verb` and when `\texttt`](https://tex.stackexchange.com/questions/2790/when-should-one-use-verb-and-when-texttt).
[^8]: [insert code keywords inline](https://tex.stackexchange.com/questions/286094/insert-code-keywords-inline).
[^9]: [4.5 Listings and Other Verbatim Text](https://www.dickimaw-books.com/latex/thesis/html/verbatim.html).