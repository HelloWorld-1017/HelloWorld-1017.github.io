---
layout: single
title: Column- and Row-major Layout Array
date: 2023-04-27 14:20:22 +0800
categories: 
 - MATLAB
 - Python
 - C
 - R
tags:
 - MATLAB Programming
 - MATLAB Coder
toc: false
---

前两天在逛知乎的时候，在一篇回答的下面看到了一条评论， 大致意思是“（在MATLAB中，）先行后列比先列后行快”。也就是说，在不得以循环遍历矩阵中的每一个数组的元素时，“先按照行的顺序遍历，再按照列的顺序遍历”所花费的时间更短。于是，今天我就简单地测试了一下，采用的测试程序是“100次循环`10e4`阶矩阵的元素自增1”：

```matlab
clc,clear,close all

%% First row, second column
tic
A = ones(10^4);
for t = 1:100
    for j = 1:height(A)
        for i = 1:width(A)
            A(i,j) = A(i,j)+1;
        end
    end
end
toc

%% First column, second row
clear all

tic
B = ones(10^4);
for t = 1:100
    for i = 1:width(B)
        for j = 1:height(B)
            B(i,j) = B(i,j)+1;
        end
    end
end
toc
```

```
Elapsed time is 24.729285 seconds.
Elapsed time is 263.073480 seconds.
```

可以看到，的确“先行后列”是更快的，并且速度差异是很明显的。

这种差异性是由MATLAB存储数组（Array）的方式所导致的 [1]。

根据数组的存储方式，数组的布局（Array layout，order，format或representation）分为**column-major layout**和**row-major layout**。对于column-major layout的数组，**列**元素在内存中是连续的（contiguous）；对于row-major layout的数组，**行**元素在内存中是连续的。数组的布局方式对于代码的集成（integration），可用性（usability）和性能（performance）是非常重要的。某些算法对于特定的array layout执行得更好。

在MATLAB的编程语言和编程环境中，所有的数据都是默认采用单一的**column-major layout**。

> 常见的采用column-major layout（有时也被称为"Fortran" style ordering [2]，Fortran-style contiguous array [3]）的编程语言：MATLAB，Fortran（许多流体力学的仿真采用的是这种语言），R。
>
> 常见的采用row-major layout（有时也被称为"C" style ordering [2] C-style contiguous array [3]）的编程语言：C，C++，Python NumPy package [3, 4]。

<br>

对于MATLAB采用column-major layout这一特性在下面的矩阵索引或操作的过程中可以得到一定的反映。

（1）矩阵索引

```matlab
A = [1,2,3,4;...
    5,6,7,8];
A(3)
```

```
ans =
     2
```

（2）矩阵展开

```matlab
A = [1,2,3,4;...
    5,6,7,8];
A(:)
```

```
ans =
     1
     5
     2
     6
     3
     7
     4
     8
```

（3）素数判断



<br>

**References**

[1] [Row-Major and Column-Major Array Layouts - MathWorks](https://ww2.mathworks.cn/help/coder/ug/what-are-column-major-and-row-major-representation-1.html).

[2] [Arrays in R and Python](https://cran.r-project.org/web/packages/reticulate/vignettes/arrays.html).

[3] [The N-dimensional array (ndarray) — NumPy v1.24 Manual](https://numpy.org/doc/stable/reference/arrays.ndarray.html).

[4] [Row- and column-major order - Wikipedia](https://en.wikipedia.org/wiki/Row-_and_column-major_order).

