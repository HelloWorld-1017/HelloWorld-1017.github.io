---
layout: single
title: Invoke Structure Fields using Variables in MATLAB
date: 2022-07-30 20:17:27 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Language Fundamentals
toc: false
---

在MATLAB中，通过变量获得结构体的字段值。比如，有一个结构体`s`，它分别有`a`，`b`，`e` 三个字段，字段值分别为`1.0`，`2.0`，`3.0`。现在想借助一个变量来获得字段`e`的值：

```matlab
% Define a structure
s.a = 1.0;
s.b = 2.0;
s.e = 3.0;

% Variable index
variable = 'e';
```

一开始想到使用 `eval()` 函数，但是系统无法识别这样的表达：

```matlab
>> s.eval(variable)

Unrecognized field name "eval".
```

后来找到可以使用 MATLAB 的 `getfield()` 函数 [[1]](#ref)：

```matlab
>> getfield(s, variable)

ans =
    3
```

但是，其实 MATLAB 提供了一种更简单的方法通过变量来创建或使用字段 [[2]](#ref):

```matlab
>> s.(variable)

ans =
     3
```

<br>

<div id="ref"></div>

**References**

[1] [`getfield` - MATLAB Documentation](https://ww2.mathworks.cn/help/matlab/ref/getfield.html?searchHighlight=getfield%28%29&s_tid=srchtitle_getfield%2528%2529_1)

[2] [Generate Field Names from Variables](https://ww2.mathworks.cn/help/matlab/matlab_prog/generate-field-names-from-variables.html)

 
