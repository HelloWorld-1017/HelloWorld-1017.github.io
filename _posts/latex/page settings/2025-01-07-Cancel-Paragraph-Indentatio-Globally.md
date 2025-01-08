---
title: Cancel Paragraph Indentation Globally in LaTeX (including a simple introduction to LaTeX length variables)
toc: false
categories:
 - LaTeX
tags:
 - LaTeX Layout
date: 2025-01-07 15:35:44 +0800
last_modified_at: 2025-01-08 16:23:27 +0800
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

| Length            | Description                                                  |
| ----------------- | ------------------------------------------------------------ |
| `\baselineskip`   | Vertical distance between lines in a paragraph.              |
| `\columnsep`      | Distance between columns.                                    |
| `\columnwidth`    | The width of a column.                                       |
| `\evensidemargin` | Margin of even pages, commonly used in two-sided documents such as books. |
| `\linewidth`      | Width of the line in the current environment.                |
| `\oddsidemargin`  | Margin of odd pages, commonly used in two-sided documents such as books. |
| `\paperwidth`     | Width of the page.                                           |
| `\paperheight`    | Height of the page.                                          |
| `\parindent`      | Paragraph indentation.                                       |
| `\parskip`        | Vertical space between paragraphs.                           |
| `\tabcolsep`      | Separation between columns in a table (tabular environment). |
| `\textheight`     | Height of the text area in the page.                         |
| `\textwidth`      | Width of the text area in the page.                          |
| `\topmargin`      | Length of the top margin.                                    |

<br>

**References**

[^1]: [Lengths in LaTeX](https://www.overleaf.com/learn/latex/Lengths_in_LaTeX).

