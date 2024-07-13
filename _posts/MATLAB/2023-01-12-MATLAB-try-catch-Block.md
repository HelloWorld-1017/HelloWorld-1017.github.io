---
layout: single
title:  MATLAB `try,catch` Block
date: 2023-01-12 16:12:03 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Language Fundamentals
 - MATLAB Warnings and Errors
---

# Introduction

在MATLAB中，代码块（[try, catch- MathWorks](https://ww2.mathworks.cn/help/matlab/ref/try.html)）：

```matlab
try
   statements
catch exception
   statements
end
```

将执行在`try` block中的语句，并且在`catch` block中捕捉可能发生的错误。我们可以**通过这种方式重载（override）程序语句的默认错误行为（中断程序）**。如果`try` block中的语句产生了错误，那么程序会自动跳转到包含着用户自定义错误处理语句的`catch` block中，我们可以在`catch` block中为特定错误添加错误信息、将错误转换为警告以防止程序中断、甚至忽略掉特定错误等等。

<br>

# Example 1: Supplement Error Message

正常情况下，MATLAB中的语句：

```matlab
clc, clear, close all

A = rand(3);
B = ones(5);

C = [A; B];
```

会出现下面的报错信息：

```
Error using vertcat
Dimensions of arrays being concatenated are not consistent.

Error in script1 (line 6)
C = [A; B];
```

如果我们将`C = [A; B];`放入到下面简单的`try/catch`块中：

```matlab
try
    C = [A; B];
catch ME
end
```

运行后可以看到此时的命令行窗口中并不会产生报错信息，而是会在工作空间中产生一个`ME`变量，该变量是一个`MException`对象，其中包含着一些报错信息：

```matlab
>> ME
ME = 
  MException with properties:
    identifier: 'MATLAB:catenate:dimensionMismatch'
       message: 'Dimensions of arrays being concatenated are not consistent.'
         cause: {}
         stack: [1×1 struct]
    Correction: []
    
>> ME.stack
ans = 
  struct with fields:
    file: 'C:\Users\Tsing\Desktop\gramming\errors\script2.m'
    name: 'script2'
    line: 7
```

如果我们想要像之前一样在命令行窗口中抛出错误，则可以使用`rethrow`函数：

注：也可以使用`throw`函数，`rethrow`函数和`throw`函数是有一些区别的，具体可以参考：[`throw`: Compare Behavior of `throw` and `rethrow`](https://ww2.mathworks.cn/help/matlab/ref/mexception.throw.html#bud2vjm-4)。
{: .notice--primary}

```matlab
...
try
    C = [A; B];
catch ME
    rethrow(ME)
end
```

![image-20230111190642280](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111190642280.png?raw=true)

虽然报错信息是一样的，但是此时的变量空间中多出了`ME`这个变量。

> 另外需要说明的是，`ME`是我们自己定义的变量名，我们可以通过改变`catch`后的变量名来改变这一点，例如：
>
> ```matlab
> ...
> try
>     C = [A; B];
> catch me
>     rethrow(me)
> end
> ```

根据变量`ME`中包含的错误信息，我们可以通过`catch` block中的程序来丰富报错信息，例如：

```matlab
...
try
   C = [A; B];
catch ME
   if (strcmp(ME.identifier, 'MATLAB:catenate:dimensionMismatch'))
      msg = ['Dimension mismatch occurred: First argument has ', ...
            num2str(size(A,2)),' columns while second has ', ...
            num2str(size(B,2)),' columns.'];
        causeException = MException('MATLAB:myCode:dimensions', msg);
        ME1 = addCause(ME, causeException);
   end
   rethrow(ME1)
end 
```

此时命令行中的报错信息就多了关于维度的更详细的报错信息：

![image-20230111191939471](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111191939471.png?raw=true)

最后，我们可以简单对比一下添加信息前后的两个`MExpection`对象`ME`和`ME1`：

```matlab
ME = 
  MException with properties:

    identifier: 'MATLAB:catenate:dimensionMismatch'
       message: 'Dimensions of arrays being concatenated are not consistent.'
         cause: {}
         stack: [1×1 struct]
    Correction: []
```

```matlab
ME1 = 
  MException with properties:

    identifier: 'MATLAB:catenate:dimensionMismatch'
       message: 'Dimensions of arrays being concatenated are not consistent.'
         cause: {[1×1 MException]}
         stack: [1×1 struct]
    Correction: []


ME1.cause{1} = 
  MException with properties:

    identifier: 'MATLAB:myCode:dimensions'
       message: 'Dimension mismatch occurred: First argument has 3 columns while second has 5 columns.'
         cause: {}
         stack: [0×1 struct]
    Correction: []
```

<br>

# Example 2: Repackage Error as Warning

`try/catch`块可以用来将错误repackage为warning。例如在正常情况下，当我们调用一个没有定义的函数`notaFunction`，软件会报错：

```matlab
a = notaFunction(5,6);
```

![image-20230111193410824](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111193410824.png?raw=true)

我们可以将这个错误repackage为warning：

```matlab
try
    a = notaFunction(5,6);
catch
    warning('Problem using function.  Assigning a value of 0.');
    a = 0;
end
```

![image-20230111193344223](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111193344223.png?raw=true)

甚至我们可以更激进一点，将整个错误都隐藏掉：

```matlab
try
    a = notaFunction(5,6);
catch
end
```

此时的工作空间中没有一个变量。

<br>

# Example 3: Handle Different Types of Errors

`try/catch`代码块中`catch`后的`exception`变量是一个`MException`对象，我们可以通过它来识别错误。因此，我们可以使用`try/catch`以不同的方式处理不同类型的错误。例如还是针对上面的例子，我们想要实现：

- If the function `notaFunction` is undefined, issue a warning instead of an error and assign the output a value of `NaN`.
- If `notaFunction.m` exists, but is a script instead of a function, issue a warning instead of an error, run the script, and assign the output a value of `0`.
- If MATLAB throws an error for any other reason, rethrow the exception.

则可以使用代码：

```matlab
try
    a = notaFunction(5,6);
catch ME
    switch ME.identifier
        case 'MATLAB:UndefinedFunction'
            warning('Function is undefined.  Assigning a value of NaN.');
            a = NaN;
        case 'MATLAB:scriptNotAFunction'
            warning(['Attempting to execute script as function. '...
                'Running script and assigning output a value of 0.']);
            notaFunction;
            a = 0;
        otherwise
            rethrow(ME)
    end
end
```

这意味着我们将前面两种错误视为不同的warnings，并赋给变量`a`不同的值（供后续程序使用），而不处理其他错误的报错信息和行为。**开发者可以通过这种方式设计程序遇到预期错误时的行为，给出警告并做出响应（最简单的就像是上面给变量`a`赋不同值的操作），而不需要中断整个程序；程序只有遇到非预期错误时才会中断**。

<br>

# Example 4: When There Exist No Mistakes

当语句不存在错误时，`try/catch`是捕捉不到任何错误的，并且不会执行`catch`块中的内容。例如运行代码：

```matlab
a = 1;
b = 2;

try
    c = a+b;
catch ME
    d = 2;
    rethrow(ME)
end
```

此时：

- 工作空间中仅存在变量`a`，`b`，和`c`，不存在变量`ME`和`d`；
- 程序不会报错；

这也很容易理解，这个块是用来**尝试（try）**捕捉（catch）错误的，如果代码片段没有错误，当然捕捉不到也不会报错。

<br>















