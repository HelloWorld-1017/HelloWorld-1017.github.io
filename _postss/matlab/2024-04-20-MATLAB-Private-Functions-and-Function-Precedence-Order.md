---
layout: single
title: MATLAB Private Functions and Function Precedence Order
categories:
 - MATLAB
tags:
 - MATLAB Programming
 - MATLAB Language Fundamentals
drafted_at: 2024-04-19 15:18:07 +0800
date: 2024-04-20 22:17:17 +0800
last_modified_at0: 2024-04-20 22:17:17 +0800
last_modified_at: 2024-04-20 22:17:17 +0800
---

# MATLAB private functions

Private function (in `private` subfolder)[^1] is one of MATLAB functions types[^2], and is "*available **only** to functions in the folder **immediately** above the `private` folder.*"[^2]. Generally speaking, when we call a function in MATLAB, the software will search for the invoked function in the search path[^6] and the current folder. If user-defined functions are put in a subfolder of current folder, there will be an error when we call them in the script of current folder. But it is okay if the subfolder name is `private`.

For example, in the current folder, we can new a subfolder `private` and a script file `script1.m`. Then, a function file `helperAdd.m` is defined in the subfolder `private`:

```matlab
function c = helperAdd(a,b)
c = a+b;
end
```

Next, we invoke the `helperAdd` function in `script1.m`:

```matlab
% script1.m
clc,clear,close all

c = helperAdd(1,2);
```

Variable `c` is:

```
>> c
c =
     3
```

So, it really works. BUT, if we call the `helperAdd` function in the command window (current folder) instead, MATLAB will throw an error, saying:

```
>> helperAdd(1,2)
'helperAdd' is not found in the current folder or on the MATLAB path, but exists in:
    C:\xxx\xxxx\xxxx\xxxx\private

Change the MATLAB current folder.
```

**This feature is different from the way directly defining the `helperAdd` function in the current folder**, or rather, private functions in `private` subfolder are not available in the command window whose path is current folder.

<br>

On the other hand, although MATLAB will search for the `private` subfolder when running `script1.m` in this example, the `private` subfolder is not in MATLAB search path[^6]. We can verify this point by inserting `path` function[^3] in the `helperAdd` function, to display the search path in command window when `script1.m` calls `helperAdd`:

```matlab
function c = helperAdd(a,b)
c = a+b;
path
end
```

There is a long list showing every search path in the command window, but `private` subfolder isn't in it.

By the way, it is another way to obtain the MATLAB search path by viewing `pathdef.m` file [^4].
{: .notice--primary}

So, the process of MATLAB searching `helperAdd` function is not realized by TEMPORARILY adding `private` subfolder into the search path (and then remove it after calling. I think this is a way, although sounds complicated), it has another searching mechanism.

<br>

Anyway, it is a concise way to organize user-defined functions in some complicated programming scenarios by putting them together in `private` subfolder. But there is a small point, in my actual use, I found the class definition `.m` files cannot be put in the `private` subfolder, otherwise the class cannot be instantiated correctly, and an error will occur, "Class definition files cannot be contained in a private directory." This caveat sounds trivial, but still should be pointed out, literally, private function is a kind of special FUNCTION, and class definition `.m` files are not functions for MATLAB. 

But on the other hand, MATLAB seemingly views the script files as functions. For example, if we create a `script2.m` file in `private` subfolder, whose content is:

```matlab
% script2.m in `private` subfolder
disp("This is a test.")
```

Then, we invoke it in `script1.m` script file:

```matlab
% script1.m
clc,clear,close all
script2
```

and it works:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404192250985.png" alt="image-20240419225034141" style="zoom: 80%;" />

<br>

# MATLAB function precedence order

MATLAB can find private functions in the `private` subfolder, but the priority problem of function execution exists when there are several functions have the same file name. In fact, a webpage in MATLAB documentation[^5] provides a detailed description about it. 

In the case of several functions **in current scope** having the same name, MATLAB determines the precedence order by the following list:

**<font color='blue'>(1) Variables</font>**: Before assuming that a name matches a function, MATLAB checks for a variable with that name in the current space. NOTE: If you create a variable with the same name as a function, MATLAB cannot run that function until you clear the variable from memory.

Or rather, variables have a higher searching priority than ALL types of functions, this is why users should avoid defining the variables has the same name as built-in functions. A common case is, some users, myself included, habitually define `i` as the `for` loop variable; on another hand, `i` is a built-in imaginary unit (and so is `j`). But the `for` loop can work well, because MATLAB will first check variables when encountering `i`.

By the way, as for built-in imaginary unit, individual symbol `i` or `j` is also not recommended. For example, if we want to create a variable `a` representing $5\mathrm{i}$ by `a=5*i;`, MATLAB Code Analyzer will warns that,  "For improved robustness, considering replacing `i` and `j` by `1i`." So, it's better to use `a = 5i;` and `a = 5*1i;` instead, although it looks somewhat special because a valid variable name in MATLAB must start with a letter[^7].

(2) Function or class whose name matches an explicitly imported name (which is imported by `import` function[^8])

**<font color='blue'>(3) Nested functions within the current function</font>**

**<font color='blue'>(4) Local functions within the current file</font>**

(5) Function or class whose name matches a wildcard-based imported name

**<font color='blue'>(6) Private functions</font>**

**<font color='blue'>(7) Object functions</font>**

(8) Class constructors in @-folders

(9) Loaded Simulink® models

**<font color='blue'>(10) Functions in the current folder</font>**

**<font color='blue'>(11) Functions elsewhere on the path, in order of appearance</font>**

The above bold-blue function types are the ones that relatively commonly used in practice. An somewhat unexpected point is that, private functions (6) even have a higher position than functions in the current folder (10).

<br>

At times, there exist some files with the same name but with different file types (different file suffixes) **within the same folder**, and MATLAB will equally view some of which as functions. Similarly, in this case, MATLAB will also consider them in a precedence order:

**<font color='blue'>(1) Built-in function</font>**

(2) MEX-function

(3) Simulink model files that are not loaded, with file types in this order:

1. SLX file
2. MDL file

(4) Stateflow® chart with a `.sfx` extension

(5) App file (`.mlapp`) created using MATLAB App Designer

(6) Program file with a `.mlx` extension

MATLAB `.mlx` file is a live code file[^9], which some users really like, but I don't get used to it. At least not yet.

**<font color='blue'>(7) P-file (that is, an encoded program file with a `.p` extension)</font>**

MATLAB `.p` file is a content-obscured version of source file `.m` file[^10][^11].

**<font color='blue'>(8) Program file with a `.m` extension</font>**

<br>

# References

[^1]: [Private Functions - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/private-functions.html).
[^2]: [Types of Functions - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/types-of-functions.html).
[^3]: [MATLAB `path`: View or change search path - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/path.html).
[^4]: [Matlab调用其他文件夹下的函数 - GShang - 博客园](https://www.cnblogs.com/gshang/p/14489731.html).
[^5]: [MATLAB Function Precedence Order - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/function-precedence-order.html).
[^6]: [What Is the MATLAB Search Path? - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_env/what-is-the-matlab-search-path.html).
[^7]: [Variable Names - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/variable-names.html).
[^8]: [MATLAB `import`: Add namespace, class, or functions to current import list - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/import.html).
[^9]: [Live Code File Format (.mlx) - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/live-script-file-format.html).
[^10]: [Create a Content-Obscured File with P-Code - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/building-a-content-obscured-format-with-p-code.html).
[^11]: [MATLAB p Code - What a starry night~](https://helloworld-1017.github.io/2023-09-22/19-07-51.html).
