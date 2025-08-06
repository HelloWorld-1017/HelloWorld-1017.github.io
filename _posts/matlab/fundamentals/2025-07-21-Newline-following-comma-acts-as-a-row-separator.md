---
title: A MATLAB Warning Reported by the Code Analyzer --- \"Newline following comma acts as a row separator.\"
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Language Fundamentals
 - MATLAB Warnings and Errors
date: 2025-07-21 10:00:17 +0800
last_modified_at: 2025-08-06 12:05:26 +0800
---

When creating a matrix in MATLAB, we should note that “Newline following comma acts as a row separator.” For example, 

```matlab
A = [1, 2, 3, 4, 
    5, 6, 7, 8];

A
```

```
A =
     1     2     3     4
     5     6     7     8
```

<div class="notice--primary" markdown="1">

Which is equivalent to:

```matlab
A = [1, 2, 3, 4;
    5, 6, 7, 8];
```

</div>

we can see MATLAB Code Analyzer reports a warning message about it:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202507211025237.png" alt="image-20250721102551150" style="width:80%;" />

We can use the “line continuation” operator `...`[^1] to not make a newline:

```matlab
A = [1, 2, 3, 4, 
    5, 6, 7, 8];

B = [1, 2, 3, 4, ...
    5, 6, 7, 8];

A, B
```

```
A =
     1     2     3     4
     5     6     7     8

B =
     1     2     3     4     5     6     7     8
```

This point looks very trivial, but it will lead some errors about matrix size if we don’t mention it when coding --- actually, recently I spent much time to find an error brought by making a newline but without using `...`.

Besides, the case is the same when omitting commas:

```matlab
A = [1 2 3 4
    5 6 7 8];

B = [1 2 3 4 ...
    5 6 7 8];

A, B
```

```
A =
     1     2     3     4
     5     6     7     8

B =
     1     2     3     4     5     6     7     8
```

<br>

**References**

[^1]: [MATLAB `ellipsis`: Line continuation](https://www.mathworks.com/help/matlab/ref/ellipsis.html).