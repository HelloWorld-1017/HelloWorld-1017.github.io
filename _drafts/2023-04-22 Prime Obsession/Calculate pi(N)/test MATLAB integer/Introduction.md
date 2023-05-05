

Automatic Data Type Conversion and Integer Calculation Speeds in MATLAB

MATLAB

Mathematics

Numerical Analysis

MATLAB Language Fundamentals



# Introduction

在MATLAB中，浮点数有两种类型：默认的64位双精度浮点数（Double-Precision Floating Point）`double`，32位单精度浮点数（Single-Precision Floating Point）[1]；整数有8种类型，包含4种有符号整型以及4种无符号整型 [2]：

![image-20230504182703473](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230504182703473.png)

不同数字类型的变量在进行相互运算时，有时会存在自动类型转换，有时会报错；并且，相同的数字采用不同类型的变量来承载，计算速度也有所差距，本博客就简单地梳理一下这些内容。

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

结果转换为与整数相同的数据类型，并且遵从四舍五入的规则：

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

![image-20230504215645036](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230504215645036.png)

<br>

# Integer Addition Operation Speed of Each Data Type

上述这十种数据类型都可以表示（特定范围的）正整数，在实验之前我觉得如果用整型变量表示整数，计算速度可能会快一些，因为浮点数的机器表示比整数的浮点数表示复杂 [3,4]。然后，我简单地进行了一个不同数据类型$10^4$阶$1$矩阵元素循环自加1的计算试验，测试了一下速度：

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
Elapsed time is 21.193129 seconds.
single
Elapsed time is 31.534959 seconds.
int8
Elapsed time is 42.866931 seconds.
int16
Elapsed time is 42.784059 seconds.
int32
Elapsed time is 42.227893 seconds.
int64
Elapsed time is 108.893160 seconds.
uint8
Elapsed time is 33.601635 seconds.
uint16
Elapsed time is 33.229937 seconds.
uint32
Elapsed time is 33.292885 seconds.
uint64
Elapsed time is 83.529158 seconds.
```

注：MATLAB版本，内存。。。
{: .notice--primary}

计算的结果表明，使用浮点数类型表示整数反而是更快的（并且使用`double`类型比`single`类型更快），不太清楚是什么原因。





<br>

**References**

[1] [Floating-Point Numbers - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/floating-point-numbers.html).

[2] [Integers - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/integers.html).

[3] [Machine Representation of Decimal Integers - What a starry night~](http://whatastarrynight.com/mathematics/matlab/Machine-Representation-of-Decimal-Integers/).

[4] [Floating Point Representation and Machine Representation of Decimal Digits (IEEE 754 Standards) - What a starry night~](http://whatastarrynight.com/mathematics/matlab/Floating-Point-Arithmetic/).