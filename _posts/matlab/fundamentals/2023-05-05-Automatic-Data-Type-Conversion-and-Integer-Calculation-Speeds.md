---
title: Automatic Data Type Conversion and Integer Calculation Speeds in MATLAB
categories: 
 - MATLAB
 - Mathematics
tags:
 - Numerical Analysis
 - MATLAB Language Fundamentals
date: 2023-05-05 17:23:27 +0800
last_modified_at: 2023-05-05 17:23:27 +0800
---

# Introduction

在MATLAB中，浮点数有两种类型：默认的64位双精度浮点数（Double-Precision Floating Point）`double`，32位单精度浮点数（Single-Precision Floating Point）`single` [1]；整数有8种类型，包含4种有符号整型以及4种无符号整型 [2]：

![image-20230504182703473](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230504182703473.png?raw=true)

不同数字类型的变量在进行相互运算时，有时会存在自动类型转换，有时会报错；并且，相同的数字采用不同类型的变量来承载，计算速度也有所差距，本博客就简单整理一下这些内容。

<br>

# Automatic Data Type Conversion and Data Type Error in MATLAB

双精度浮点数与单精度浮点数之间可以进行计算，并将结果自动转换为`single`类型：

```matlab
>> double(3.2)+single(3.2)
ans =
  single
    6.4000
```

```matlab
>> double(pi)+single(pi)
ans =
  single
    6.2832
```

另外，双精度的浮点数可以与任意的整数类型变量进行计算：

```matlab
>> double(7)+uint32(9)
ans =
  uint32
   16
```

结果转换为与整数相同的整型，并且遵从四舍五入的规则：

```matlab
>> double(7.2)+uint32(9)
ans =
  uint32
   16
```

```matlab
>> double(7.7)+uint32(9)
ans =
  uint32
   17
```

但是，单精度浮点数不能与任何类型的整数进行计算：

```matlab
>> single(7)+uint32(9)
Error using  + 
Integers can only be combined with integers of the same class, or scalar
doubles.
```

并且从这个报错信息中可以得知，不同类型的整数之间是不能进行运算的。例如：

```matlab
>> int8(3)+int16(3)
Error using  + 
Integers can only be combined with integers of the same class, or scalar
doubles.
```

总之，不同数字类型的变量的运算规则可以总结为：

![image-20230504215645036](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230504215645036.png?raw=true)

<br>

# Integer Addition Operation Speed of Each Data Type

上述这十种数据类型都可以表示（特定范围的）正整数，在实验之前我觉得如果用整型变量表示整数，计算速度可能会快一些，因为浮点数的机器表示比整数的浮点数表示复杂 [3,4]。然后，我简单地进行了不同数据类型$10^4$阶$1$矩阵元素循环自加1的计算试验，测试了一下速度：

```matlab
clc,clear,close all

%% A is double
tic
A = helperAccumulation(double(ones(10^4)));
disp(class(A))
toc

%% B is single
clear
tic
B = helperAccumulation(single(ones(10^4)));
disp(class(B))
toc

%% C is int8
clear
tic
C = helperAccumulation(int8(ones(10^4)));
disp(class(C))
toc

%% D is int16
clear
tic
D = helperAccumulation(int16(ones(10^4)));
disp(class(D))
toc

%% E is int32
clear
tic
E = helperAccumulation(int32(ones(10^4)));
disp(class(E))
toc

%% F is int64
clear
tic
F = helperAccumulation(int64(ones(10^4)));
disp(class(F))
toc

%% G is uint8
clear
tic
G = helperAccumulation(uint8(ones(10^4)));
disp(class(G))
toc

%% H is uint16
clear
tic
H = helperAccumulation(uint16(ones(10^4)));
disp(class(H))
toc

%% I is uint32
clear
tic
I = helperAccumulation(uint32(ones(10^4)));
disp(class(I))
toc

%% J is uint64
clear
tic
J = helperAccumulation(uint64(ones(10^4)));
disp(class(J))
toc

function matrix = helperAccumulation(matrix)
for t = 1:100
    for columns = 1:width(matrix)
        for rows = 1:height(matrix)
            matrix(rows,columns) = matrix(rows,columns)+1;
        end
    end
end
end
```

```
double
Elapsed time is 10.621610 seconds.
single
Elapsed time is 12.998448 seconds.
int8
Elapsed time is 17.986876 seconds.
int16
Elapsed time is 17.811298 seconds.
int32
Elapsed time is 16.945584 seconds.
int64
Elapsed time is 57.852715 seconds.
uint8
Elapsed time is 14.257828 seconds.
uint16
Elapsed time is 14.199355 seconds.
uint32
Elapsed time is 14.027019 seconds.
uint64
Elapsed time is 44.500926 seconds.
```

注：CPU: 12th Gen Intel(R) Core(TM) i7-12700K；Internal storage: 16.0 GB；GPU: NVIDIA GeForce RTX 3060 Ti；MATLAB Version: 9.12.0.1884302 (R2022a)。
{: .notice--primary}

计算的结果表明，使用浮点数类型表示整数反而是更快的（并且使用`double`类型比`single`类型更快）。目前还不太清楚是什么原因，先记录在这里。

<br>

**References**

[1] [Floating-Point Numbers - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/floating-point-numbers.html).

[2] [Integers - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/integers.html).

[3] [Machine Representation of Decimal Integers - What a starry night~](http://ma1017.github.io/mathematics/matlab/Machine-Representation-of-Decimal-Integers/).

[4] [Floating Point Representation and Machine Representation of Decimal Digits (IEEE 754 Standards) - What a starry night~](http://ma1017.github.io/mathematics/matlab/Floating-Point-Arithmetic/).