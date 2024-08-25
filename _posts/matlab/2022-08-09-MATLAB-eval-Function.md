---
layout: single
title: MATLAB `eval` Function
date: 2022-08-09 12:59:35 +0800
categories:
 - MATLAB
tags: 
 - MATLAB Programming
toc: false
---

首先创建两个结构体

```matlab
% Buid two structures
Stru1.Type = 'Integer';
Stru1.Value = 10;

Stru2.Type = 'Decimal';
Stru2.Value = 1.7;
```



![image-20220809124625224](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809124625224.png?raw=true)

想要通过循环的形式实现——将结构体的 Type 值作为变量名，并将结构体的 Value 值作为该变量的值，例如：

![image-20220809125024864](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220809125024864.png?raw=true)

可以借助 `eval` 函数实现：

```matlab
for i = 1:2
    eval(['type = ', 'Stru', num2str(i), '.Type']);
    % e.g. ['type = Stru1.Type']

    eval([ type, ' = ','Stru', num2str(i), '.Value']) 
    % e.g. ['Integer = Stru1.Value']
end
```



`eval` 函数的基本语法是 `eval(expression)` ，一定要保证 `experssion` 是个字符串。

<br>

**参考**

[1] [eval - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/eval.html).

