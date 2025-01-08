---
title: Align the Left Text Left and Right the Text Right in the Same Line in LaTeX
categories:
 - LaTeX
tags:
 - LaTeX Box
 - LaTeX Layout
 - LaTeX Table
 - LaTeX tabularx
date: 2024-09-04 12:23:07 +0800
last_modified_at: 2025-01-05 10:14:45 +0800
---

# Method 1: `\hfill` command

(1) `\hfill` command[^1]

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{showframe}

\begin{document}
\vspace*{\fill}

\noindent Line 1 (left) \hfill Line 1 (right) \\
Line 2 (left) \hfill Line 2 (right) \\

\vspace*{\fill}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501051005558.png" alt="image-20250105100504480" style="width:67%;" />

(2) `\hfill` command + `minipage` environment[^1]

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{showframe}

\begin{document}
\vspace*{\fill}

\noindent
\begin{minipage}{2in}
\textbf{Student:} \\
Mr. xxx
\end{minipage}
\hfill
\begin{minipage}{1.3in}
\textbf{Supervisor:} \\
Prof. Dr. xxx
\end{minipage}

\vspace*{\fill}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501051005430.png" alt="image-20250105100555336" style="width:67%;" />

<br>

# Method 2: `tabular*` environment

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{showframe}


\begin{document}
\vspace*{\fill}

\noindent
\begin{tabular*}{\textwidth}[t]{l@{\extracolsep{\fill}}r}
Line 1 (left) & Line 1 (right) \\
Line 2 (left) & Line 2 (right) \\
\end{tabular*}

\vspace*{\fill}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501051006400.png" alt="image-20250105100641297" style="width:67%;" />

where the `\extracolsep` command is to add elastic width to the table column[^2].

Besides, we can use `@{}` to suppress the small space before the first column and that after the last column[^3]:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{showframe}


\begin{document}
\vspace*{\fill}

\noindent
\begin{tabular*}{\textwidth}[t]{@{}l@{\extracolsep{\fill}}r@{}}
Line 1 (left) & Line 1 (right) \\
Line 2 (left) & Line 2 (right) \\
\end{tabular*}

\vspace*{\fill}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501051007640.png" alt="image-20250105100718487" style="width:67%;" />

<br>

# Method 3: `tabularx` environment

<div class="quote--left" markdown="1">

`\begin{tabularx}{⟨width⟩}[⟨pos⟩]{⟨preamble⟩}`

The arguments of `tabularx` are essentially the same as those of the standard `tabular*` environment. However rather than adding space between the columns to achieve the desired width, it adjusts the widths of some of the columns. The columns which are affected by the `tabularx` environment should be denoted with the letter `X` in the preamble argument. The `X` column specification will be converted to `p{⟨some value⟩}` once the correct column width has been calculated.[^4]

</div>

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{showframe}


\usepackage{tabularx}

\begin{document}
\vspace*{\fill}

\noindent
\begin{tabularx}{\textwidth}{@{}lXr@{}}
Line 1 (left) & & Line 1 (right) \\
Line 2 (left) & & Line 2 (right) \\
\end{tabularx}

\vspace*{\fill}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501051008162.png" alt="image-20250105100806100" style="width:67%;" />

We can use `\tabularnewline` to specify the line spacing:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{showframe}


\usepackage{tabularx}

\begin{document}
\vspace*{\fill}

\noindent
\begin{tabularx}{\textwidth}{@{}lXr@{}}
Line 1 (left) & & Line 1 (right) \tabularnewline[5ex]
Line 2 (left) & & Line 2 (right) \tabularnewline
\end{tabularx}

\vspace*{\fill}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501051009631.png" alt="image-20250105100929568" style="width:67%;" />

<br>

# Method 4: user-defined text box

By using user-defined text box[^5]:

```latex
\documentclass[a4paper]{article}
\usepackage[margin=1in]{geometry}
\usepackage[x11names]{xcolor}
\pagecolor{AntiqueWhite1}
\usepackage{showframe}

\newcommand\textbox[1]{\parbox{.33\textwidth}{#1}}
\newcommand\textboxt[1]{\parbox{.25\textwidth}{#1}}

\begin{document}
\vspace*{\fill}

\noindent
\textbox{Left\hfill}
\textbox{\hfil Center\hfil}
\textbox{\hfill Right}

\vspace{3em}

\noindent
\textbox{\raggedright Left}
\textbox{\centering Center}
\textbox{\raggedleft Right}

\vspace{3em}

\noindent
\textboxt{\raggedright Left}
\hspace{-9px}
\textboxt{\centering Center 1}
\textboxt{\centering Center 2}
\hspace{-9px}
\textboxt{\raggedleft Right} 

\vspace*{\fill}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501051010446.png" alt="image-20250105101029331" style="width:67%;" />

Note that the nuance between `\hfil` and `\hfill` command[^6]. 

<br>

**References**

[^1]: [https://tex.stackexchange.com/a/294156/306224](https://tex.stackexchange.com/a/294156/306224).

[^2]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX入门.pdf), 刘海洋编著, pp. 298-299.
[^3]: [spacing - Clarification on the use of `@{}` with table headings](https://tex.stackexchange.com/questions/1290/clarification-on-the-use-of-with-table-headings).
[^4]: [The `tabularx` package](https://texdoc.org/serve/tabularx/0).
[^5]: [horizontal alignment - How to make text aligned left/center/right in the same line?](https://tex.stackexchange.com/questions/55472/how-to-make-text-aligned-left-center-right-in-the-same-line).
[^6]: [spacing - Difference between `\hfil` and `\hfill`](https://tex.stackexchange.com/questions/528920/difference-between-hfil-and-hfill).

