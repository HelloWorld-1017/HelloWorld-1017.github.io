---
layout: single
title: MATLAB `tiledlayout` Function and `subplot` Function
date: 2022-09-04 20:02:01 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Graphics
---

# `tiledlayout` Function

`tiledlayout`函数一般结合`nexttile`函数一起使用：

```matlab
clc, clear, close all

% Prepare data
scores = [444 460 380 388 389
          387 366 500 467 460
          365 451 611 426 495
          548 412 452 471 402];
strikes = [9  6  5  7  5
           6  4  8 10  7
           4  7 16  9  9
           10  9  8  8  9];

% Plot into 3-by-3 layout
t = tiledlayout(3, 3); 

% Team 1
n(1) = nexttile;
bar([1 2 3 4], strikes(:,1))
title('Team 1 Strikes')

% Team 2
n(2) = nexttile;
bar([1 2 3 4], strikes(:,2))
title('Team 2 Strikes')

% Team 3
n(3) = nexttile;
bar([1 2 3 4], strikes(:,3))
title('Team 3 Strikes')

% Team 4
n(4)  = nexttile;
bar([1 2 3 4], strikes(:,4))
title('Team 4 Strikes')

% Team 5
n(5) = nexttile(7);
bar([1 2 3 4], strikes(:,5))
title('Team 5 Strikes')

% Compare scores of the teams
n(6) = nexttile(5, [2 2]);
plot([1 2 3 4], scores, '-.')
labels = {'Team 1', 'Team 2', 'Team 3', 'Team 4', 'Team 5'};
legend(labels, 'Location', 'northwest')
% Configure ticks and axis labels
xticks([1 2 3 4])
xlabel('Game')
ylabel('Score')
title('The sub title')

% Add layout title
title(t, 'April Bowling League Data')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/pic1.jpg?raw=true" alt="pic1" style="zoom:80%;" />

其中`nexttile`函数的参数所代表的含义：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220904194910212.png" alt="image-20220904194910212" style="zoom:80%;" />

<br>

# `subplot` Function

`subplot`函数最常用的语法是：

```matlab
figure
subplot(2,2,1)
...
subplot(2,2,2)
...
subplot(2,2,2)
...
subplot(2,2,2)
...
```

比如：

```matlab
clc, clear, close all

figure(1)
subplot(2,2,1)
x = linspace(0,10);
y1 = sin(x);
plot(x,y1)
title('Subplot 1: sin(x)')

subplot(2,2,2)
y2 = sin(2*x);
plot(x,y2)
title('Subplot 2: sin(2x)')

subplot(2,2,3)
y3 = sin(4*x);
plot(x,y3)
title('Subplot 3: sin(4x)')

subplot(2,2,4)
y4 = sin(8*x);
plot(x,y4)
title('Subplot 4: sin(8x)')
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/pic2.jpg?raw=true" alt="pic2" style="zoom:80%;" />

但是除此之外，`subplot`函数可以设置`position`参数：

```matlab
clc, clear, close all

pos1 = [0.1 0.3 0.3 0.3];
sub(1) = subplot('Position', pos1);
y = magic(4);
plot(y)
title('First Subplot')

pos2 = [0.5 0.15 0.4 0.7];
sub(2) = subplot('Position', pos2);
bar(y)
title('Second Subplot')

sgtitle('Subplot Grid Title')
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/pic3.jpg?raw=true" alt="pic3" style="zoom:80%;" />

其中，不像`tiledlayout`函数中**最后**可以连用两个`title`函数，前一个`titile`设置最后一个子图的标题，后一个`title`设置总标题，如果使用`subplot`进行绘制，要使用`sgtitle`函数设置总标题：

```matlab
sgtitle('Subplot Grid Title')
```

<br>

**参考**

[1] [tiledlayout - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/tiledlayout.html).

[2] [subplot - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/subplot.html).

[3] [sgtitle - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/sgtitle.html).

