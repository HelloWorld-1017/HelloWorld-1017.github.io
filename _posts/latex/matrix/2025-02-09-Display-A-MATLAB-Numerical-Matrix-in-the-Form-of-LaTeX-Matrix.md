---
title: Display A MATLAB Numerical Matrix in the Form of LaTeX Matrix
toc: false
categories:
 - LaTeX
 - MATLAB
date: 2025-02-09 11:37:26 +0800
last_modified_at: 2025-08-04 11:56:07 +0800
---

To display a MATLAB numerical matrix in the form of LaTeX matrix, we can create such a self-defined MATLAB function `Matrix2LaTeX` (which is modified on the basis of the code provided by reference[^1]):

```matlab
function result = Matrix2LaTeX(matrix, precision)
% Set precision of numbers
if nargin == 1
    precision = '4';
else
    precision = int2str(precision);
end

% Define the output form of each element in the matrix
outForm4NegativeNumber = ['%0.', precision, 'f & '];
if any(matrix<=0, "all")
    placeHolder = '\\phantom{-}';
    outForm4PositiveNumber = [placeHolder, '%0.', precision, 'f & '];
end

% Generate the LaTeX code of the matrix
[nRow, nColumn] = size(matrix);
out = char(sprintf("\\begin{bmatrix}"));
for i = 1:nRow
    out = [out, char(sprintf('\n\t'))]; %#ok % make a newline
    for j = 1:nColumn
        element = matrix(i, j);
        if element<0
            temp = sprintf(outForm4NegativeNumber, element);
        else
            temp = sprintf(outForm4PositiveNumber, element);
        end
        out = [out, temp]; %#ok
    end

    % Delete the last `&`
    out = out(1:end-3);

    % Add the symbol `\\` at the end of the line
    out = [out, '\\']; %#ok
end
out = [out, char(sprintf("\n\\end{bmatrix}\n"))];

result = out;
disp(result)
end
```

and we can test it using a simple example:

```matlab
clc, clear, close all

rng("default")

A = randn(5, 4)
tm1 = Matrix2LaTeX(A, 4);
```

```
A =
    0.5377   -1.3077   -1.3499   -0.2050
    1.8339   -0.4336    3.0349   -0.1241
   -2.2588    0.3426    0.7254    1.4897
    0.8622    3.5784   -0.0631    1.4090
    0.3188    2.7694    0.7147    1.4172

\begin{bmatrix}
	\phantom{-}0.5377 & -1.3077 & -1.3499 & -0.2050\\
	\phantom{-}1.8339 & -0.4336 & \phantom{-}3.0349 & -0.1241\\
	-2.2588 & \phantom{-}0.3426 & \phantom{-}0.7254 & \phantom{-}1.4897\\
	\phantom{-}0.8622 & \phantom{-}3.5784 & -0.0631 & \phantom{-}1.4090\\
	\phantom{-}0.3188 & \phantom{-}2.7694 & \phantom{-}0.7147 & \phantom{-}1.4172\\
\end{bmatrix}
```

Next, let’s copy the LaTeX code into a LaTeX document, then we’ll have:

```latex
\documentclass{article}
\usepackage{amsmath}

\begin{document}

\begin{equation}
\begin{bmatrix}
	\phantom{-}0.5377 & -1.3077 & -1.3499 & -0.2050\\
	\phantom{-}1.8339 & -0.4336 & \phantom{-}3.0349 & -0.1241\\
	-2.2588 & \phantom{-}0.3426 & \phantom{-}0.7254 & \phantom{-}1.4897\\
	\phantom{-}0.8622 & \phantom{-}3.5784 & -0.0631 & \phantom{-}1.4090\\
	\phantom{-}0.3188 & \phantom{-}2.7694 & \phantom{-}0.7147 & \phantom{-}1.4172\\
\end{bmatrix}
\end{equation}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202508041145050.png" alt="image-20250804114539988" style="width:80%;" />

<br>

**References**

[^1]: MATLAB N个实用技巧——MATLAB中文论坛精华总结 (第2版), 刘焕进, 李鹏, 王辉, 王海洋 编著, pp. 235-237.