---
layout: single
title: Padding Zeros before String using Formatting Operators in MATLAB
date: 2023-04-24 22:54:24 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Language Fundamentals
toc: false
---

在MATLAB中，可以使用格式化运算符（Formatting Operators）来固定字符串的长度（不足的部分补零），`sprintf`函数和`num2str`函数均接受这样的语法：

```matlab
>> sprintf("test%04d",100)
ans = 
    "test0100"
```

```matlab
>> sprintf("test%04s",num2str(100))
ans = 
    "test0100"
```

```matlab
>> sprintf("test%s",num2str(100,"%04d"))
ans = 
    "test0100"
```

```matlab
>> sprintf("test%04s","ttt")
ans = 
    "test0ttt"
```

<br>

**References**

[1] [MATLAB笔记：数值前面补零+字符串前面补零 - sangba2019的博客 - CSDN博客](https://blog.csdn.net/sangba2019/article/details/109469154).

[2] [num2str - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/num2str.html).

[3] [sprintf - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/sprintf.html).

