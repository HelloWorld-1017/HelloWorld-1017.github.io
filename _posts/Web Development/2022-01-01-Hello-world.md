---
title: Hello, world!
toc: false
categories: 
 - Web Development
tags:
 - Jekyll
comment: true
date: 2022-01-01 10:17:07 +0800
last_modified_at: 2024-08-13 17:10:32 +0800
---

<div class="quote--left" markdown="1">

... There’s a long-held tradition in the programming world that printing a `Hello world!` message to the screen as your first program in a new language will bring you good luck.[^1]

</div>

# Welcome

**Hello world**, this is my first Jekyll blog post.

I hope you like it!

$e^{i\pi}+1=0$

![image-20220707190620188](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707190620188.png?raw=true)

```python
f = lambda x: x[0] ** 2 + x[1] ** 2 + x[2] ** 2 - 1.0
g = lambda x: 2 * x[0] ** 2 + x[1] ** 2 - 4 * x[2]
h = lambda x: 3 * x[0] ** 2 - 4 * x[1] ** 2 + x[2] ** 2
```

```matlab
function output1 = CustomRmoutliers(x)
% x: timetable
% output1: timetable, removed outliers

tt = diff(x.Variables);
[~, breakpoints] = rmoutliers(tt, 'median');
x(breakpoints, :) = [];

output1 = x;
end
```

![Mapping](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/Mapping.gif?raw=true)

<br>

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, p. 4.

