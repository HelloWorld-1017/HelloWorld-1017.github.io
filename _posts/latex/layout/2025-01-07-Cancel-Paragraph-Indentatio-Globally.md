---
title: Cancel Paragraph Indentation Globally in LaTeX (including a simple introduction to LaTeX length variables)
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Layout
date: 2025-01-07 15:35:44 +0800
last_modified_at: 2025-01-10 15:15:55 +0800
---

We can use `\setlength\parindent{0pt}` in the preamble to cancel indentation for all paragraphs in a LaTeX document. The following text shows the effect of without this command and with it, respectively.

```latex
\documentclass[a4paper,11pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\begin{document}

\lipsum[1-7]

\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501071600827.png)

```latex
\documentclass[a4paper,11pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\setlength\parindent{0pt}

\begin{document}

\lipsum[1-7]

\end{document}
```

![img-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501071601895.png)

It is literally clear that the meaning of the command is to set (`\setlength`) the paragraph indentation as 0 pt (`\parindent{0pt}`).

Besides `\parindent`, there are also other length variables in LaTeX that can be set by the `\setlength` command. Here are their length names[^1]:

| No.  | Length            | Description                                                  |
| ---- | ----------------- | ------------------------------------------------------------ |
| 1    | `\baselineskip`   | Vertical distance between lines in a paragraph.              |
| 2    | `\columnsep`      | Distance between columns.                                    |
| 3    | `\columnwidth`    | The width of a column.                                       |
| 4    | `\evensidemargin` | Margin of even pages, commonly used in two-sided documents such as books. |
| 5    | `\linewidth`      | Width of the line in the current environment.                |
| 6    | `\oddsidemargin`  | Margin of odd pages, commonly used in two-sided documents such as books. |
| 7    | `\paperwidth`     | Width of the page.                                           |
| 8    | `\paperheight`    | Height of the page.                                          |
| 9    | `\parindent`      | Paragraph indentation.                                       |
| 10   | `\parskip`        | Vertical space between paragraphs.                           |
| 11   | `\tabcolsep`      | Separation between columns in a table (tabular environment). |
| 12   | `\textheight`     | Height of the text area in the page.                         |
| 13   | `\textwidth`      | Width of the text area in the page.                          |
| 14   | `\topmargin`      | Length of the top margin.                                    |

and we can use the `\the` command[^2] to check out their current values:

```latex
\documentclass[a4paper,11pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{lipsum}

\setlength\parindent{0pt}

\begin{document}

\begin{enumerate}
    \item \verb*|\baselineskip|: \the\baselineskip
    \item \verb*|\columnsep|: \the\columnsep
    \item \verb*|\columnwidth|: \the\columnwidth
    \item \verb*|\evensidemargin|: \the\evensidemargin
    \item \verb*|\linewidth|: \the\linewidth
    \item \verb*|\oddsidemargin|: \the\oddsidemargin
    \item \verb*|\paperwidth|: \the\paperwidth
    \item \verb*|\paperheight|: \the\paperheight
    \item \verb*|\parindent|: \the\parindent
    \item \verb*|\parskip|: \the\parskip
    \item \verb*|\tabcolsep|: \the\tabcolsep
    \item \verb*|\textheight|: \the\textheight
    \item \verb*|\textwidth|: \the\textwidth
    \item \verb*|\topmargin|: \the\topmargin
\end{enumerate}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501101515289.png" alt="image-20250110151542179" style="width:50%;" />

<br>

**References**

[^1]: [Lengths in LaTeX](https://www.overleaf.com/learn/latex/Lengths_in_LaTeX).
[^2]: [macros - The `\the` command](https://tex.stackexchange.com/questions/38674/the-the-command).
