---
title: Column- vs. Row-major Layout Array
toc: false
categories: 
 - MATLAB
 - Python
 - C
 - R
tags:
 - MATLAB Programming
 - MATLAB Coder
 - Prime Obsession
 - Number Theory
 - Data Structure
date: 2023-04-27 14:20:22 +0800
last_modified: 2024-07-19 04:26:52 +0800
---

前两天在逛知乎的时候，在一篇回答的下面看到了一个回答：“[在MATLAB中，] 先列后行比先行后列快很多”[^1] 。也就是说，在不得以循环遍历矩阵中的每一个数组的元素时，“先遍历列元素，再遍历行元素”所花费的时间更短。于是，今天我就简单地测试了一下，采用的测试程序是“100次循环`10e4`阶矩阵的元素自增1”：

```matlab
clc,clear,close all

%%First row, second column
tic
A = ones(10^4);
for t = 1:100
    for columns = 1:width(A)
        for rows = 1:height(A)
            A(rows,columns) = A(rows,columns)+1;
        end
    end
end
toc

%% First column, second row
clear all

tic
B = ones(10^4);
for t = 1:100
    for rows = 1:height(B)
        for columns = 1:width(B)
            B(rows,columns) = B(rows,columns)+1;
        end
    end
end
toc
```

```
Elapsed time is 24.729285 seconds.
Elapsed time is 263.073480 seconds.
```

可以看到，的确“先列后行”是更快的，并且速度差异是很明显的。

这种差异性是由MATLAB存储数组（Array）的方式导致的[^2]。

<br>

根据数组的存储方式，数组的布局（Array layout，order，format或representation）分为**column-major layout**和**row-major layout**。对于column-major layout的数组，**列**中的元素在内存中是连续的（contiguous）；对于row-major layout的数组，**行**中的元素在内存中是连续的。数组的布局方式对于代码的集成（integration），可用性（usability）和性能（performance）是非常重要的。某些算法对于特定的array layout执行得更好。

在MATLAB的编程语言和编程环境中，所有的数据都是默认采用单一的**column-major layout**。

常见的采用column-major layout（有时也被称为"Fortran" style ordering[^3]，Fortran-style contiguous array[^4]）的编程语言：MATLAB，Fortran（许多流体力学的仿真采用的是这种语言），R。常见的采用row-major layout（有时也被称为"C" style ordering，或者C-style contiguous array）的编程语言：C，C++，Python NumPy package[^4][^5]。
{: .notice--primary}

<br>

对于MATLAB采用column-major layout这一特性在下面的矩阵索引或运算的过程中可以得到一定的反映。

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

最近我在尝试计算某一个大数下素数的个数，其中涉及到使用MATLAB的`isprime`函数来判断某个数是否是素数 [^6]。`isprime`函数首先会将输入展开成一个列向量：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230428170321052.png?raw=true" alt="image-20230428170321052" style="zoom:50%;" />

为了测试使用行向量和列向量的区别，我将`isprime`函数复制了一份，并将这一语句修改为`X=X(:)'`，其余部分不变，定义为一个新的函数`helperIsprime`：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230428170545901.png?raw=true" alt="image-20230428170545901" style="zoom:50%;" />

注：这里的`herlperIsprimes`函数并没有进行博客[^6] 中提到的优化。
{: .notice--warning}

之后，测试了一下两个函数*“重复20次判断`1:2e7`内所有元素是否为素数”*所花费的时间：

```matlab
clc,clear,close all

tic
for i = 1:20
    result_builtin = isprime(1:2e7);
end
toc

clear all

tic
for i = 1:20
    result_helper = helperIsprime(1:2e7);
end
toc
```

```
Elapsed time is 2931.111347 seconds.
Elapsed time is 3875.116026 seconds.
```

结果表明，将列向量更改为行向量后，的确降低了代码遍历元素的速度，也从侧面验证了MATLAB采用的是column-major layout数组。

<br>

# References

[^1]: [MATLAB 有什么奇技淫巧？ - 天行者的回答 - 知乎](https://www.zhihu.com/question/45621009/answer/99882437).
[^2]: [Row-Major and Column-Major Array Layouts - MathWorks](https://ww2.mathworks.cn/help/coder/ug/what-are-column-major-and-row-major-representation-1.html).
[^3]: [Arrays in R and Python](https://cran.r-project.org/web/packages/reticulate/vignettes/arrays.html).
[^4]: [The N-dimensional array (ndarray) — NumPy v1.24 Manual](https://numpy.org/doc/stable/reference/arrays.ndarray.html).
[^5]: [Row- and column-major order - Wikipedia](https://en.wikipedia.org/wiki/Row-_and_column-major_order).
[^6]: [Trial Division and MATLAB `isprime` Function - What a starry night~](https://helloworld-1017.github.io/2023-04-27/12-05-29.html).
