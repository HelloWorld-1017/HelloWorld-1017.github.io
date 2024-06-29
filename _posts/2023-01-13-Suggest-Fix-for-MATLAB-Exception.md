---
layout: single
title:  Suggest Fix for MATLAB Exception
date: 2023-01-13 17:56:03 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Programming
 - MATLAB Warnings and Errors
toc: false
---

当MATLAB代码在运行的过程中遇到错误时，软件会抛出警告并中断程序，有时候进一步地给出一些解决的suggestion。例如，假如我们想要使用`clc`命令清理命令行窗口，但是误把命令输为`ckccc`，结果MATLAB就会报错：

![image-20230113154031194](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113154031194.png?raw=true)

但是如果我们误输入为与`clc`相近的`ckc`时，MATLAB就会在报错的同时给出一个suggestion：

![image-20230113154236171](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113154236171.png?raw=true)

实际上我们在编程的时候也可以针对指定的错误提供suggestion，这需要用到`MException`对象的`addCorrection`方法向`MException`对象中添加correction对象，然后再将`MExcption`对象`rethrow`或者`throw`出来（使用`rethrow`或者`throw`取决于在我们处理错误之前程序是否报错）。

[`addCorr	ection`函数](https://ww2.mathworks.cn/help/matlab/ref/mexception.addcorrection.html)的功能是：provide suggested fix for exception，官方文档提供了一个示例：[Suggest Fix When Function Called Without Arguments](https://ww2.mathworks.cn/help/matlab/ref/mexception.addcorrection.html#mw_b657ad50-cad3-443e-943d-ecafda6133f3)。

首先定义一个`hello`函数：

```matlab
function hello(audience)
fprintf("Hello, %s!\n", audience);
end
```

该函数接受一个输入参数，并在命令行窗口打印欢迎语句，例如：

```matlab
>> hello("Tommy")
Hello, Tommy!
```

如果我们不输入参数，则程序会报错：

```matlab
>> hello
Not enough input arguments.

Error in hello (line 8)
fprintf("Hello, %s!\n", audience);
```

![image-20230113174217985](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113174217985.png?raw=true)

我们可以使用下面的程序对这个错误给出解决建议：

```matlab
function hello(audience)
if nargin < 1
    me = MException('MATLAB:notEnoughInputs', 'Not enough input arguments.');
    aac = matlab.lang.correction.AppendArgumentsCorrection('"world"');
    me = me.addCorrection(aac);
    throw(me);
end

fprintf("Hello, %s!\n", audience);
end
```

此时再调用没有参数的`hello`函数，程序就会给出suggestion：

```matlab
>> hello
Error using hello
Not enough input arguments.
 
Did you mean:
>> hello("world")
```

![image-20230113174514760](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113174514760.png?raw=true)

可以看到，程序使用`MException`类型变量`me`的`addCorrection`方法将变量`acc`添加到建立的`me`中。这里的变量`acc`是一个`AppendArgumentsCorrection`类型的对象，是`matlab.lang.correction`库专门提供的用于为error（更准确地说是Exception）提供suggestion的对象。除此之外，类似的对象还有两个，分别是：

- `matlab.lang.correction.ConvertToFunctionNotationCorrection`
- `matlab.lang.correction.ReplaceIdentifierCorrection`

![image-20230113175422223](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113175422223.png?raw=true)

<br>