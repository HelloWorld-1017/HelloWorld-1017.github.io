---
layout: single
title: MATLAB `bsxfun` Function
date: 2022-09-29 18:46:47 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Language Fundamentals
 - MATLAB Graphics
---

# Syntax

MATLAB中的`bsxfun`函数用于：Apply element-wise operation to two arrays with implicit expansion enabled。其基本语法是：

```matlab
C = bsxfun(@(x, y) func, A, B)
```

- `@(x, y) func`表示一个匿名函数，`x`和`y`是匿名函数的形参；
- `A`和`B`分别是匿名函数形参`x`和`y`的具体取值；
- `C`是返回的向量（或者矩阵）。

<br>

# Examples

## Example 1: A, 1-by-n; B, 1-by-n

如果`A`和`B`都是具有4个元素的行向量，

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220929181926223.png?raw=true" alt="image-20220929181926223" style="zoom: 67%;" />

例如：

```matlab
% A, 1-by-4; B, 1-by-4
C = bsxfun(@(a, b) a-b, [1, 2, 3, 4], [6, 9, 7, 10]);
```

```matlab
C =
    -5    -7    -4    -6
```

## Example 2: A, m-by-1; B, m-by-1

如果`A`和`B`是具有3个元素的列向量；

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220929181957911.png?raw=true" alt="image-20220929181957911" style="zoom:67%;" />

例如：

```matlab
% A, 3-by-1; B, 3-by-1
C = bsxfun(@(a, b) a-b, [1, 2, 3]', [6, 9, 7]');
```

```matlab
C =
    -5
    -7
    -4
```

## Example 3: A, m-by-1; B, 1-by-n

如果`A`是具有3个元素的列向量，`B`是具有4个元素的行向量：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220929182030416.png?raw=true" alt="image-20220929182030416" style="zoom:67%;" />

例如：

```matlab
% A, 3-by-1; B, 1-by-4
C = bsxfun(@(a, b) a-b, [1, 2, 3]', [6, 9, 7, 10]);
```

```matlab
C =
    -5    -8    -6    -9
    -4    -7    -5    -8
    -3    -6    -4    -7
```

## Example 4: A, 1-by-n; B, m-by-1

如果`A`是具有3个元素的行向量，`B`是具有4个元素的列向量：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220929182119471.png?raw=true" alt="image-20220929182119471" style="zoom:67%;" />

例如：

```matlab
% A, 1-by-3; B, 4-by-1
C = bsxfun(@(a, b) a-b, [1, 2, 3], [6, 9, 7, 10]');
```

```matlab
C =
    -5    -4    -3
    -8    -7    -6
    -6    -5    -4
    -9    -8    -7
```

注：这种情况的输出矩阵`C`就是上一种情况输出矩阵的转置。这种使用比比较得别扭，所以大部分情况都是使用上一种方式。
{: .notice--warning}

<br>

# Usage for Plot Profiles with Different Parameters

使用`bsxfun`函数，可以比较简洁地绘制出不同参数的函数曲线。比如，绘制函数$y=e^{kx}$，其中$k$分别取1，2，3，4：

```matlab
clc, clear, close all

xp = linspace(0, 1, 30);
ks = 1:4;
C = bsxfun(@(x, k) exp(k*x), xp', ks);
plot(repmat(xp', 1, numel(ks)), C, LineWidth=1.5);
legend('k=1', 'k=2', 'k=3', 'k=4', "Location", "best")
grid on
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220929184409017.png?raw=true" alt="image-20220929184409017" style="zoom:67%;" />

<br>

**参考**

[1] [bsxfun - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/bsxfun.html).