---
title: Use Footnotes in LaTeX Tables
toc: false
categories:
 - LaTeX
tags:
 - LaTeX hyperref
 - LaTeX Table
date: 2025-01-02 21:41:01 +0800
last_modified_at: 2025-01-04 12:29:47 +0800
---

LaTeX `hyperref` package[^3] provides the `footnote` command to create a footnote, but the footnote can’t be displayed normally when we use it in the tables[^4]. For example,

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\geometry{a4paper}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[colorlinks=true]{hyperref}

\begin{document}
\begin{table}
	\centering
	\caption[\TeX{} engine features]{This is the table caption.}
	\vspace{0.5em}
	\begin{tabular}{|l|l|}
		\hline
		Footnote & Footnote\footnote{This is footnote.}\\
		\hline
		Footnote & Footnote\footnote{This is footnote.}\\
		\hline
		Footnote & Footnote\footnote{This is footnote.}\\
		\hline
		Footnote & Footnote\footnote{This is footnote.}\\
		\hline
		Footnote & Footnote\footnote{This is footnote.}\\
		\hline
	\end{tabular}
\end{table}

\vspace{7em}
Footnote\footnote{This is FOOTNOTE.}.
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501031200114.png" alt="img-1" style="width:100%;" />

this is because it is more commonly to use table notes rather than table footnotes[^1]:

<div class="quote--left" markdown="1">

...using footnotes in tables is not considered to be typographic best practice: ideally, *table notes* should be used instead of *table footnotes*. The use of table notes or table footnotes may be defined by document class/style files you are required to use, or the choice may be yours: either way, LaTeX provides a range of solutions you can use.”

</div>

We can wrap `tabular` in the `minipage` environment to display table notes:

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\geometry{a4paper}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[colorlinks=true]{hyperref}
\usepackage{caption}

\begin{document}
\begin{minipage}[c]{\textwidth}
	\centering
	\captionof{table}{This is the table caption.}
	\begin{tabular}{|l|l|}
		\hline
		Footnote & Footnote\footnote{This is footnote.}\\
		\hline
		Footnote & Footnote\footnote{This is footnote.}\\
		\hline
		Footnote & Footnote\footnote{This is footnote.}\\
		\hline
		Footnote & Footnote\footnote{This is footnote.}\\
		\hline
		Footnote & Footnote\footnote{This is footnote.}\\
		\hline
	\end{tabular}
\end{minipage}

\vspace{7em}
Footnote\footnote{This is FOOTNOTE.}.
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501031201692.png" alt="img-1" style="width:100%;" />

and we can use `\renewcommand{\thempfootnote}{\arabic{mpfootnote}}` in the preamble to change footnote markers to Arabic digits:

```latex
\documentclass{article}
% ...

\renewcommand{\thempfootnote}{\arabic{mpfootnote}}

\begin{document}
% ...
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501031202215.png" alt="img-1" style="width:100%;" />

On the other hand, to realize the effect of “table footnotes”, reference[^1] also provides two methods: the first one is a manual approach:

<div class="quote--left" markdown="1">

... Normally, table footnotes within a `minipage` are placed at the bottom of the `minipage`, as the examples above have shown. The following example, from the LaTeX2e unofficial reference manual[^2] uses the `\footnotemark` and `\footnotetext` commands, together with a new counter (`mpFootnoteValueSaver`) to ensure the table footnotes appear at the bottom of the document page, to be included as part of the document’s standard footnotes.

When the table is typeset, the LaTeX code `\setcounter{mpFootnoteValueSaver}{\value{footnote}}` sets the value of `mpFootnoteValueSaver` to be the current `footnote` counter value; this ensures footnotes produced within the table use marker values that are synchronized with the main document footnote sequence (numbering). After the table is typeset, note how the `mpFootnoteValueSaver` is incremented by `1` through the code `\stepcounter{mpFootnoteValueSaver}`.

</div>

{% raw %}

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\geometry{a4paper}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[colorlinks=true]{hyperref}
\usepackage{caption}

\begin{document}

Footnote\footnote{This is FOOTNOTE.}.
\vspace{7em}

\newcounter{mpFootnoteValueSaver}
\begin{minipage}[c]{\textwidth}
	\setcounter{mpFootnoteValueSaver}{\value{footnote}}
	\centering
	\captionof{table}{This is the table caption.}
	\begin{tabular}{|l|l|}
		\hline
		Footnote & Footnote\footnotemark\\
		\hline
		Footnote & Footnote\footnotemark\\
		\hline
		Footnote & Footnote\footnotemark\\
		\hline
		Footnote & Footnote\footnotemark\\
		\hline
		Footnote & Footnote\footnotemark\\
		\hline
	\end{tabular}
\end{minipage}
\stepcounter{mpFootnoteValueSaver}%
\footnotetext[\value{mpFootnoteValueSaver}]{%
  This is footnote.}%

\stepcounter{mpFootnoteValueSaver}%
\footnotetext[\value{mpFootnoteValueSaver}]{%
  This is footnote.}
  
\stepcounter{mpFootnoteValueSaver}%
\footnotetext[\value{mpFootnoteValueSaver}]{%
  This is footnote.}
  
\stepcounter{mpFootnoteValueSaver}%
\footnotetext[\value{mpFootnoteValueSaver}]{%
  This is footnote.}
  
\stepcounter{mpFootnoteValueSaver}%
\footnotetext[\value{mpFootnoteValueSaver}]{%
  This is footnote.}
  
\vspace{7em}
Footnote\footnote{This is FOOTNOTE.}.
\end{document}
```

{% endraw %}

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501031236600.png" alt="img-1" style="width:100%;" />

and another one is by `\tablefootnote` command of `tablefootnote` package:

```latex
\documentclass{article}
\usepackage[margin=1in]{geometry}
\geometry{a4paper}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage[colorlinks=true]{hyperref}
\usepackage{tablefootnote}

\begin{document}

Footnote\footnote{This is FOOTNOTE.}.
\vspace{7em}

\begin{table}[h]
	\centering
	\caption[\TeX{} engine features]{This is the table caption.}
	\vspace{0.5em}
	\begin{tabular}{|l|l|}
		\hline
		Footnote & Footnote\tablefootnote{This is footnote.}\\
		\hline
		Footnote & Footnote\tablefootnote{This is footnote.}\\
		\hline
		Footnote & Footnote\tablefootnote{This is footnote.}\\
		\hline
		Footnote & Footnote\tablefootnote{This is footnote.}\\
		\hline
		Footnote & Footnote\tablefootnote{This is footnote.}\\
		\hline
	\end{tabular}
\end{table}

\vspace{7em}
Footnote\footnote{This is FOOTNOTE.}.
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501031239937.png" alt="img-1" style="width:100%;" />

<br>

**References**

[^1]: [Footnotes: Footnotes in tables](https://www.overleaf.com/learn/latex/Footnotes#Footnotes_in_tables).
[^2]: [Footnotes in a table (LaTeX2e unofficial reference manual (December 2024))](https://latexref.xyz/Footnotes-in-a-table.html).
[^3]: [CTAN: Package `hyperref`](https://ctan.org/pkg/hyperref?lang=en).
[^4]: [Specify Link Color Using LaTeX hyperref Package](/2024-06-02/21-22-07.html).

