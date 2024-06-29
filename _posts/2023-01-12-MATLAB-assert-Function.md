---
layout: single
title: MATLAB `assert` Function
date: 2023-01-12 19:27:33 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Programming
 - MATLAB Warnings and Errors
toc: false
---

MATLAB[`assert`函数](https://ww2.mathworks.cn/help/matlab/ref/assert.html)的作用是：Throw error if condition false。在定义MATLAB函数时，我们可以使用这个函数自定义一些错误。

`assert`函数完整的语法是：

```matlab
assert(cond,errID,msg,A1,...,An)
```

其中：

- `cond`是逻辑判断语句，当`cond`的结果是false（即逻辑零）时，该函数将抛出错误信息；

- `errID`是assertion failure的identifier，它的命名需要满足一定的规则：

  ![image-20230112175940649](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230112175940649.png?raw=true)

  这个Identifier是存在于[`MExpection`](https://ww2.mathworks.cn/help/matlab/ref/mexception.html)对象中的，在后文中会详细地讨论这一点。

- `msg`是报错信息，`A1,...,An`用于替换变量`msg`中的conversion specifiers；

例如，我们规定：当变量`a`的数值小于`b`时程序抛出指定错误：

```matlab
a = 1;
b = 2;

assert(a>=b, 'MYError:aleb', "a=%d, b=%d. a is less than b", a, b)
```

此时程序会将错误信息打印在命令行窗口中：

![image-20230112180908056](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230112180908056.png?raw=true)

`assert`函数的使用是比较简单的，但是我们仍然需要说明两点。

首先，`assert`函数抛出的是一个error，当抛出了这个error后，程序就中断了，后面的程序语句就不会再执行。

其次，在上面的信息中，尽管我们在`assert`中定义了该error的identifier为`'MYError:aleb'`，但是在脚本文件中看不出它的意义，因为在正常情况下该报错并不会返回一个`MException`对象。想要了解它所代表的含义，我们需要在函数文件中使用`assert`函数，并在脚本文件中使用`try, catch`块调用函数文件。

> 注：这里表述不是特别得严谨。实际上，虽然此时的工作空间中并没有`MException`对象，但是我们可以使用`MException.last`语句得到关于这个报错的报错信息：
>
> ```matlab
> >> MException.last
> ans = 
>   MException with properties:
> 
>     identifier: 'MYError:aleb'
>        message: 'a=1, b=2. a is less than b'
>          cause: {}
>          stack: [1×1 struct]
>     Correction: []
> ```
>
> 但需要注意的是，这条语句只能在程序运行报错后，在命令行窗口中使用，不能直接跟在脚本文件中`assert`函数的后面，因为如前文所述，当程序抛出error后程序就中断了。

例如定义一个函数`helperFcn`，当函数的输入`a`大于`b`的值时报一种错误；当函数的输入`a`大于`c`值时报另一种错误；若函数不报错，则将`a`的值输出：

```matlab
function out = helperFcn(a,b,c)
assert(a<=b, "MYError:agtb", "a=%d, b=%d, c=%d. a is greater than b", a, b, c)
assert(a<=c, "MYError:agtb", "a=%d, b=%d, c=%d. a is greater than c", a, b, c)
out = a;
end
```

之后使用`try, catch`来模拟三种情形：

```matlab
try
    out1 = helperFcn(2,1,4);
catch ME1
end

try
    out2 = helperFcn(2,4,1);
catch ME2
end

try
    out3 = helperFcn(2,3,4);
catch ME3
end
```

运行脚本文件后，工作空间中得三个变量：

```matlab
>> whos
  Name      Size            Bytes  Class         Attributes
  ME1       1x1              3616  MException              
  ME2       1x1              3616  MException              
  out3      1x1                 8  double                  
```

说明前两个`try, catch`块捕捉到了错误，第三个`try, catch`块并没有捕捉到错误，而是成功执行了`try`块中的语句。

对比`ME1`和`ME2`：

```matlab
ME1 = 
  MException with properties:
    identifier: 'MYError:agtb'
       message: 'a=2, b=1, c=4. a is greater than b'
         cause: {}
         stack: [2×1 struct]
    Correction: []

ME2 = 
  MException with properties:
    identifier: 'MYError:agtb'
       message: 'a=2, b=4, c=1. a is greater than c'
         cause: {}
         stack: [2×1 struct]
    Correction: []
```

就可以看到我们在函数`helperFcn`中使用`assert`函数定义error时设定identifier的意义。

注：关于`try, catch`代码块以及`MException`对象`identifier`属性的使用，可以参考博客：[MATLAB `try,catch` Block](http://whatastarrynight.com/matlab/MATLAB-try-catch-Block/)。

