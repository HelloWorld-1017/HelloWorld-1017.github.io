---
layout: single
title: MATLAB `movmean` and `movmedian` Function
date: 2022-09-26 14:18:45 +0800
categories:
 - MATLAB
 - Signals and Systems
tags:
 - MATLAB Data Import and Analysis
---

# Introduction

MATLAB提供移动（局部）均值和移动（局部）中值的计算函数`movmean`和`movmedian`，它们的属性设置基本一致。本文以`movmean`函数为例进行详细地解释。

<br>

# Examples

## Centered Moving Average of Vector

### Example 1: `movmean(A, 3)`

```matlab
clc, clear, close all

A = [4 8 6 -1 -2 -3 -1 3 4 5];
M1 = movmean(A, 3);
```

```matlab
M1 =
    6.0000    6.0000    4.3333    1.0000   -2.0000   -2.0000   -0.3333    2.0000    4.0000    4.5000
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220925224512539.png?raw=true" alt="image-20220925224512539" style="zoom: 50%;" />

当设置`window`为3时，默认情况下不减少数组的维度，第一个和最后一个窗口的长度为2。

### Example 2: `movmean(A, 3, 'Endpoints', 'discard')`

该函数在默认情况下，`'Endpoint'`属性是`'shrink'`，表示“Shrink the window size near the endpoints of the input to include only existing elements”。如果想要软件只计算Full-Window Averages，可以进行下面的设置，表示“Do not output any averages when the window does not completely overlap with existing elements”：

```matlab
M2 = movmean(A, 3, 'Endpoints', 'discard');
```

```matlab
M2 =
    6.0000    4.3333    1.0000   -2.0000   -2.0000   -0.3333    2.0000    4.0000
```

此时，数组的维度减少到$(10-(3-1))$：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220925230850480.png?raw=true" alt="image-20220925230850480" style="zoom:50%;" />



### Example 3: `movmean(A, 4)`

如果窗口的长度为偶数：

```matlab
M3 = movmean(A, 4);
```

```matlab
M3 =
    6.0000    6.0000    4.2500    2.7500         0   -1.7500   -0.7500    0.7500    2.7500    4.0000
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220925231251841.png?raw=true" alt="image-20220925231251841" style="zoom:50%;" />

### Example 4: `movmean(A, 4, 'Endpoints', 'discard')`

同样地，只计算Full-Window Averages：

```matlab
M4 = movmean(A, 4, 'Endpoints', 'discard');
```

```matlab
M4 =
    4.2500    2.7500         0   -1.7500   -0.7500    0.7500    2.7500
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220925231334507.png?raw=true" alt="image-20220925231334507" style="zoom:50%;" />

## Trailing Moving Average of Vector

### Example 1: `movmean(A, [2, 1])`

`M = movmean(A,[kb kf])` computes the mean with a window of length `kb+kf+1` that includes the element in the current position, `kb` elements backward, and `kf` elements forward.这种情况可以将使滑动平均不包含“未来值”。

如：

```matlab
M5 = movmean(A, [2, 1]);
```

```matlab
M5 =
    6.0000    6.0000    4.2500    2.7500         0   -1.7500   -0.7500    0.7500    2.7500    4.0000
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220926124803586.png?raw=true" alt="image-20220926124803586" style="zoom:67%;" />

### Example 2: `movmean(A, [2, 1], 'Endpoints', 'discard')`

同样地，只计算Full-Window Averages：

```matlab
M6 = movmean(A, [2, 1], 'Endpoints', 'discard');
```

```matlab
M6 =
    4.2500    2.7500         0   -1.7500   -0.7500    0.7500    2.7500
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220925233158393.png?raw=true" alt="image-20220925233158393" style="zoom:50%;" />

### Example 3: `movmean(A, [2, 0])`

如果只由“过去值”计算均值：

```matlab
M7 = movmean(A, [2, 0]);
```

```matlab
M7 =
    4.0000    6.0000    6.0000    4.3333    1.0000   -2.0000   -2.0000   -0.3333    2.0000    4.0000
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220926124906435.png?raw=true" alt="image-20220926124906435" style="zoom:67%;" />

### Example 4: `movmean(A, [2, 0], 'Endpoints', 'discard')`

同样地，如果只计算Full-Window Averages：

```matlab
M8 = movmean(A, [2, 0], 'Endpoints', 'discard');
```

```matlab
M8 =
    6.0000    4.3333    1.0000   -2.0000   -2.0000   -0.3333    2.0000    4.0000
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220925233522871.png?raw=true" alt="image-20220925233522871" style="zoom:50%;" />

<br>

**参考**

[1] [movmean - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/movmean.html).

[2] [movmedian - MathWork](https://ww2.mathworks.cn/help/matlab/ref/movmedian.html).

