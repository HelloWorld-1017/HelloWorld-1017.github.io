---
title: Delete Graph Object in MATLAB Figure
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Graphics
date: 2024-08-03 18:51:50 +0800
last_modified_at: 2024-08-03 18:51:50 +0800
---

<div id="code-snippet"></div>

```matlab
clc, clear, close all
rng("default")

data = rand(10,3);

fig = figure;
ax = axes;
p = plot(data,"LineWidth",1.5);

legend("data1","data2","data3")
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408031855656.png" alt="image-20240803185524582" style="zoom:67%;" />

```matlab
% ...

% Delete the second line
delete(p(2))
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408031857088.png" alt="image-20240803185703055" style="zoom:67%;" />

```matlab
% ...

% Delete the first line of remaining two lines
delete(ax.Children(2))
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408031857266.png" alt="image-20240803185741234" style="zoom:67%;" />

NOTE that, although we can get graph handles by above two methods, they are stored in different orders: the former is sequential, whereas the latter reversed. We can check this point after executing above [code snippet](#code-snippet).

```
>> p

p = 
  3×1 Line array:
  Line    (data1)
  Line    (data2)
  Line    (data3)
```

```
>> ax.Children

ans = 
  3×1 Line array:
  Line    (data3)
  Line    (data2)
  Line    (data1)
```

<br>

**References**

[1] [MATLAB `delete`: Delete files or objects](https://www.mathworks.com/help/matlab/ref/delete.html).