---
layout: single
title: 在MATLAB中通过变量获得结构体的字段值(getfield函数)
date: 2022-07-30 20:17:27 +0800
categories: 
 - Program
tags:
 - MATLAB
toc: false
---

<br>
在MATLAB中，通过变量获得结构体的字段值。比如，有一个结构体 s ，它分别有a，b，e 三个字段，字段值分别为1.0，2.0，3.0。现在想借助一个变量来获得字段 e 的值：

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

后来找到，应该使用 MATLAB 的 `getfield()` 函数：

```matlab
>> getfield(s, variable)

ans =
    3
```
