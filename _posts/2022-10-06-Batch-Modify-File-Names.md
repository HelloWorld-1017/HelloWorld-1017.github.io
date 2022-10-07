---
layout: single
title: Batch Modify File Names
date: 2022-10-06 22:35:37 +0800
categories: 
 - Programming
tags:
 - MATLAB
 - MATLAB Language Fundamentals
 - Regular Expression
toc: false
---

今天在整理电脑文件的时候遇到了这样一类问题，比如说现在有这样几个相同类型的文件：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221006222410110.png" alt="image-20221006222410110" style="zoom: 67%;" />

我想要把`PeakyBlinders01`修改成`01 Peaky Blinders`。

需要做的工作是提取文件名中的序号，然后保留序号，把文件名中的其他字符更改为其他的格式。在MATLAB中借助正则表达式，可以做到这一点：

```matlab
clc, clear, close all

file = dir("*.jpg");
for i = 1:numel(file)
    oldname = file(i).name;
    matchStr = regexp(oldname, '[0-9][0-9]', "match");
    newname = [num2str(matchStr{1}), ' Peaky Blinders.mp4'];
    eval(['!rename', ' "', oldname, '" "', newname, '"']);
end

```

运行代码后，可以看到文件名被修改成预期的样子：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221006223019726.png" alt="image-20221006223019726" style="zoom:67%;" />

其中，代码中：

- `matchStr = regexp(oldname, '[0-9][0-9]', "match");`，表示使用正则表达式匹配字符串中连续的两个数字；
- `eval(['!rename', ' "', oldname, '" "', newname, '"']);`，其中`!rename`表示调用Windows系统的`rename`函数修改文件名。需要注意的是不能忘掉空格和双引号。

<br>

**Reference**

[1] [regexp - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/regexp.html#bt5ujf4-1).