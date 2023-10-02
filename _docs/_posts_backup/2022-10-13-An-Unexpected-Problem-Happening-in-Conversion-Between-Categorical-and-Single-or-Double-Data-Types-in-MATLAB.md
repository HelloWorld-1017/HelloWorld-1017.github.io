---
layout: single
title: An Unexpected Problem Happening in Conversion Between Categorical and Single or Double Data Types in MATLAB
date: 2022-10-13 12:20:17 +0800
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Language Fundamentals
toc: false
---

使用MATLAB训练和测试监督机器学习算法时，通常会面对定类变量的标签，之前我是直接使用整数来表示的，但是后来学习MATLAB示例，发现官方示例使用的标签经常使用的时`categorical`类型的数据，后来我也就经常使用`categorical()`函数将整数转化为`categorical`类型的数据再进行处理，这么做的一个好处是，当在用户在编写代码的过程中无意对定类变量进行了数学运算(比如加减乘除)时，软件会进行报错，比如：

```
Operator '+' is not supported for
operands of type 'categorical'.

Operator '*' is not supported for
operands of type 'categorical'.
```

并且还可以设置它的`'Ordinal'`参数，使得定类变量具有mathematical ordering。

但是今天在将`categorial`数据类型和数值数据类型转换的过程中，发现了一个不符合预期的地方。

比如，对于非零数值`a`，将其转换为`categorical`数据类型`ac`，之后再将`ac`转换为单精度数据`as`、双精度数据`ad`都是没有问题的：

```matlab
clc, clear, close all

a = 1;
% Convert `a` to 'categorical' data type `ac`
ac = categorical(a);
% Concert `ac` to 'single' data type `as`
as = single(ac);
% Concert `ac` to 'double' data type `ad`
ad = single(ac);
```

```matlab
a =
     1
ac = 
  categorical
     1 
as =
  single
     1
ad =
  single
     1
```

但是，如果`a`为零值，进行同样的转换操作：

```matlab
clc, clear, close all

a = 0;
% Convert `a` to 'categorical' data type `ac`
ac = categorical(a);
% Concert `ac` to 'single' data type `as`
as = single(ac);
% Concert `ac` to 'double' data type `ad`
ad = single(ac);
```

结果就变为：

```matlab
a =
     0
ac = 
  categorical
     0 
as =
  single
     1
ad =
  single
     1
```

即在将categorical数据类型转换为single或者double类型数据时，中间差了1，这是不太符合预期的。

对于从零值开始的向量也是如此：

```matlab
clc, clear, close all

A = 0:6;
% Convert `A` to 'categorical' data type `Ac`
Ac = categorical(A);
% Concert `Ac` to 'single' data type `As`
As = single(Ac);
% Concert `Ac` to 'double' data type `Ad`
Ad = single(Ac);
```

```matlab
A =
     0     1     2     3     4     5     6
Ac = 
  1×7 categorical array
     0      1      2      3      4      5      6 
As =
  1×7 single row vector
     1     2     3     4     5     6     7
Ad =
  1×7 single row vector
     1     2     3     4     5     6     7
```

而对于非零值开始的向量就不存在这样的问题：

```matlab
clc, clear, close all

A = 1:7;
% Convert `A` to 'categorical' data type `Ac`
Ac = categorical(A);
% Concert `Ac` to 'single' data type `As`
As = single(Ac);
% Concert `Ac` to 'double' data type `Ad`
Ad = single(Ac);
```

```matlab
A =
     1     2     3     4     5     6     7
Ac = 
  1×7 categorical array
     1      2      3      4      5      6      7 
As =
  1×7 single row vector
     1     2     3     4     5     6     7
Ad =
  1×7 single row vector
     1     2     3     4     5     6     7
```

这个问题不是warning也不是error，只是代码实现上的一种考量，这种考量可能会在某些场景下会有优势，但是我目前还不是很理解。

但是也不能因噎废食，`categorical`函数还是很方便的，并且`categorical`数据类型的很大一个便利之处就是它能够直接保存文本标签。

<br>

**Reference**

[1] [categorical - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/categorical.html).