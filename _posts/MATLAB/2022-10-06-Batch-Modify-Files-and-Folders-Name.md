---
title: Batch Modify Files and Folders Name in MATLAB
categories: 
  - MATLAB
  - Windows
tags:
 - MATLAB Language Fundamentals
 - Regular Expression
date: 2022-10-06 22:35:37 +0800
last_modified_at: 2024-07-13 17:08:57 +0800
---

# Batch Modify Files Name

今天在整理电脑文件的时候遇到了这样一类问题，比如说现在有这样几个相同类型的文件：

```
PeakyBlinders01.jpg
PeakyBlinders02.jpg
PeakyBlinders03.jpg
PeakyBlinders04.jpg
...
```

我想要把`PeakyBlinders01`修改成`01 Peaky Blinders`。

需要做的工作是提取文件名中的序号，然后保留序号，把文件名中的其他字符更改为其他的格式。在MATLAB中借助正则表达式，可以做到这一点：

```matlab
clc, clear, close all

file = dir("*.jpg");
for i = 1:numel(file)
    oldname = file(i).name;
    matchStr = regexp(oldname, '[0-9][0-9]', "match");
    newname = [num2str(matchStr{1}), ' Peaky Blinders.jpg'];
    eval(['!rename', ' "', oldname, '" "', newname, '"']);
end
```

运行代码后，可以看到文件名被修改成预期的样子：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20221006223019726.png?raw=true" alt="image-20221006223019726" style="zoom:67%;" />

代码中：

- `matchStr = regexp(oldname, '[0-9][0-9]', "match");`，表示使用正则表达式匹配字符串中连续的两个数字；
- `eval(['!rename', ' "', oldname, '" "', newname, '"']);`，其中`!rename`表示调用Windows系统的`rename`函数修改文件名，注意不要忘掉空格和双引号。

<br>

# Batch Modify Folders Name

Added on Oct. 26, 2023.
{: .notice--warning}

Today, I want to change the folders name in my website post assets repository [[2]](#ref) from `<year>.<month>. <date> <foldername>`:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310252323313.png" style="zoom:50%;" />

to `<year>-<month>-<date> <foldername>`. Similarly, I wrote a simple script to realise it:

```matlab
clc,clear,close all

folderInfo = dir(pwd);
pat = digitsPattern(4)+"."+digitsPattern(2)+"."+digitsPattern(2);

for i = 3:numel(folderInfo)
    oldDate = extract(folderInfo(i).name,pat);
    if ~isempty(oldDate)
        oldDate = oldDate{1};
        newName = replace(folderInfo(i).name,oldDate,sprintf("%s-%s-%s",oldDate(1:4),oldDate(6:7),oldDate(9:10)));
        eval(['!rename', ' "', folderInfo(i).name, '" "', newName, '"']);
    end
end
```

The results are like:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310261204044.png" alt="image-20231026120413011" style="zoom:50%;" />

<div id="ref"></div>

<br>

**Reference**

[1] [regexp - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/regexp.html#bt5ujf4-1).

[2] [HelloWorld-1017/HelloWorld-1017.github.io-post-assets](https://github.com/HelloWorld-1017/HelloWorld-1017.github.io-post-assets).

[3] [`digitsPattern`: Match digit characters. - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/digitspattern.html).

