---
title: Print MATLAB Source Code in LaTeX
toc: false
categories:
 - MATLAB
 - LaTeX
tags:
 - LaTeX listings
date: 2025-05-24 20:16:02 +0800
last_modified_at: 2025-05-25 17:14:26 +0800
---

**Method 1**: by the `listings` package[^1][^4] (the `lstlisting` environment with the `language` option)

```latex
\documentclass{article}
\usepackage{listings}

\begin{document}

\begin{lstlisting}[language=matlab]
%% Sample Matlab code
A = [1, 2, 3;... foo
    4, 5, 6];
s = 'abcd';
for k = 1:4
    disp(s(k)) % bar
end

% create row vector x, then reverse it
x = linspace(0,1,101);
y = x(end:-1:1);
\end{lstlisting}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505242103991.png" alt="image-20250524210322914" style="width:50%;" />

<br>

**Method 2**: by the `matlab-prettifier` package[^3] (the `lstlisting` environment with the `style` option, where at this time we don’t need to import the `listings` package)

(a) `style=Matlab-editor`

```latex
\documentclass{article}
\usepackage{matlab-prettifier}

\begin{document}

\begin{lstlisting}[style=Matlab-editor]
%% Sample Matlab code
A = [1, 2, 3;... foo
    4, 5, 6];
s = 'abcd';
for k = 1:4
    disp(s(k)) % bar
end

% create row vector x, then reverse it
x = linspace(0,1,101);
y = x(end:-1:1);
\end{lstlisting}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505242104633.png" alt="image-20250524210439588" style="width:50%;" />

(b) `style=Matlab-bw`

```latex
\documentclass{article}
\usepackage{matlab-prettifier}

\begin{document}

\begin{lstlisting}[style=Matlab-bw]
%% Sample Matlab code
A = [1, 2, 3;... foo
    4, 5, 6];
s = 'abcd';
for k = 1:4
    disp(s(k)) % bar
end

% create row vector x, then reverse it
x = linspace(0,1,101);
y = x(end:-1:1);
\end{lstlisting}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505242106268.png" alt="image-20250524210636221" style="width:50%;" />

(c) `style=Matlab-Pyglike`

```latex
\documentclass{article}
\usepackage{matlab-prettifier}

\begin{document}

\begin{lstlisting}[style=Matlab-Pyglike]
%% Sample Matlab code
A = [1, 2, 3;... foo
    4, 5, 6];
s = 'abcd';
for k = 1:4
    disp(s(k)) % bar
end

% create row vector x, then reverse it
x = linspace(0,1,101);
y = x(end:-1:1);
\end{lstlisting}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505242108554.png" alt="image-20250524210835502" style="width:50%;" />

(d) By combining other options[^2]

```latex
\documentclass{article}
\usepackage{matlab-prettifier}

\begin{document}

\begin{lstlisting}[frame=single,
	numbers=left,
	style=Matlab-Pyglike]
%% Sample Matlab code
A = [1, 2, 3;... foo
    4, 5, 6];
s = 'abcd';
for k = 1:4
    disp(s(k)) % bar
end

% create row vector x, then reverse it
x = linspace(0,1,101);
y = x(end:-1:1);
\end{lstlisting}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505242110472.png" alt="image-20250524211040410" style="width:50%;" />

What’s more, we can directly print the source code from an external `.m` script file[^2]:

```latex
\documentclass{article}
\usepackage{matlab-prettifier}

\begin{document}

\lstinputlisting[
	frame=single,
	numbers=left,
	style=Matlab-editor
	]{script.m}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505242117462.png" alt="image-20250524211753397" style="width:50%;" />

Besides, the documentation of `matlab-prettifier` package provides more customization options[^3].

<br>

**Method 3**: use the `listings` package to customize styles

We can use the `listings` package to customize styles by a set of properties. Here is an example from the article[^1], although it is originally designed for the programming language Octave.

```latex
\documentclass{article}
\usepackage{listings}
\usepackage{xcolor}

\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\lstdefinestyle{mystyle}{
    backgroundcolor=\color{backcolour},   
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,         
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbers=left,                    
    numbersep=5pt,                  
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=2
}

%\lstset{style=mystyle}

\begin{document}

\lstinputlisting[language=Matlab,style=mystyle]{script.m}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202505242121355.png" alt="image-20250524212114287" style="width:50%;" />

More properties can be found in the documentation of `listings` package[^4].

<br>

**References**

[^1]: [Code listing](https://www.overleaf.com/learn/latex/Code_listing).
[^2]: [How can I include MATLAB code in my LaTeX document?](https://www.overleaf.com/learn/latex/Questions/How_can_I_include_MATLAB_code_in_my_LaTeX_document%3F).
[^3]: [The `matlab-prettifier` package](https://ftp.yz.yamagata-u.ac.jp/pub/CTAN/macros/latex/contrib/matlab-prettifier/matlab-prettifier.pdf).
[^4]: [The Listings Package](https://texdoc.org/serve/listings.pdf/0).
