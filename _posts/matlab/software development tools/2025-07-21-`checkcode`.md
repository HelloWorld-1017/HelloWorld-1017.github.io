---
title: Print Message of Warnings and Errors Detected by Code Analyzer on the Command Window Using MATLAB `checkcode` Function
toc: false 
categories:
 - MATLAB
tags:
 - MATLAB Software Development Tools
date: 2025-07-21 13:46:03 +0800
last_modified_at: 2025-08-06 14:00:32 +0800
---

In MATLAB, Code Analyzer prompts some warnings and errors of current file when editing, for example, for the built-in example file `lengthofline.m`:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202507211347908.png" alt="image-20250721134746826" style="width:80%;" />

Actually, we can use `checkcode` function[^1] to print all of them (but without details and suggestions) on the Command Window:

```matlab
checkcode("lengthofline")
```

```
L 21 (C 1-9): Value assigned to variable might be unused.
L 22 (C 12-15): NUMEL(x) is usually faster than PROD(SIZE(x)).
L 23 (C 5-11): Variable appears to change size on every loop iteration. Consider preallocating for speed.
L 23 (C 44-49): Use STRCMPI(str1,str2) instead of using UPPER/LOWER in a call to STRCMP.
L 27 (C 12-15): NUMEL(x) is usually faster than PROD(SIZE(x)).
L 33 (C 13-16): Variable appears to change size on every loop iteration. Consider preallocating for speed.
L 33 (C 24-31): Use dynamic fieldnames with structures instead of GETFIELD.
L 42 (C 13-15): Variable appears to change size on every loop iteration. Consider preallocating for speed.
L 44 (C 13-15): Variable appears to change size on every loop iteration. Consider preallocating for speed.
L 47 (C 21): A '[' might be missing a closing ']', causing invalid syntax at ')'.
L 47 (C 51): A '(' might be missing a closing ')', causing invalid syntax at ';'.
L 47 (C 54): Parse error at ']': usage might be invalid MATLAB syntax.
L 48 (C 17): Add a semicolon after the statement to hide the output (in a function).
```

<br>

**References**

[^1]: [MATLAB `checkcode`: Check MATLAB code files for possible problems](https://www.mathworks.com/help/matlab/ref/checkcode.html).