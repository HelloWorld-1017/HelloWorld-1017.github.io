---
layout: single
title: 【MATLAB Graphics】`sprintf` Function and `title` Function
date: 2022-09-12 14:42:37 +0800
categories: 
 - Programming
tags:
 - MATLAB
 - MATLAB Graphics
toc: false
---



今天在学MATLAB的GMM示例时，看到了一个添加图像标题比较漂亮的实现方法，使用了`sprintf`向`title`添加参数：

```matlab
clc, clear, close all

mu = 0;
sigma = 1;
x = -5:0.01:5;
y = normpdf(x, mu, sigma);

figure(1)
plot(x, y, LineWidth=1.5);
title(sprintf('Normal Distribution PDf\n mu = %d, sigma = %d', mu, sigma))
box on
grid on
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220912231156922.png" alt="image-20220912231156922" style="zoom:50%;" />

但是🤦‍♂️！`sprintf`函数的目的是为了向命令行中打印文本，所以它不支持LaTeX解释器，这一点使得这种用法其实不是很实用。

但是🙆‍♂️！受此启发，可以使用`sprintf`函数向`eval`函数传递参数，可以提高代码的可读性。

顺便学习了一下`title`函数的用法，`title`函数是可以支持双行标题和子标题的。

双行标题用法：

```matlab
figure(2)
plot(x, y, LineWidth=1.5);
t = ['Normal Distribution PDF'; 
    '$\mu$ = ', num2str(mu), ', $\sigma$ = ', num2str(sigma)];
title(t, Interpreter="latex")
box on
grid on
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220912142142800.png" alt="image-20220912142142800" style="zoom:50%;" />

子标题用法：

```matlab
figure(3)
plot(x, y, LineWidth=1.5);
t = 'Normal Distribution PDF';
subt = ['$\mu$ = ', num2str(mu), ', $\sigma$ = ', num2str(sigma)];
[tt, ss] = title(t, subt, Interpreter="latex");
box on
grid on
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220912142357249.png" alt="image-20220912142357249" style="zoom:50%;" />

其中，变量`tt`和`ss`是标题和子标题所对应的Text对象，可以分别修改它们的行为：

```matlab
tt = 
  Text (Normal Distribution PDF) with properties:

                 String: 'Normal Distribution PDF'
               FontSize: 11
             FontWeight: 'bold'
               FontName: 'Helvetica'
                  Color: [0 0 0]
    HorizontalAlignment: 'center'
               Position: [6.3798e-06 0.4257 0]
                  Units: 'data'

  Show all properties

        BackgroundColor: 'none'
           BeingDeleted: off
             BusyAction: 'queue'
          ButtonDownFcn: ''
               Children: [0×0 GraphicsPlaceholder]
               Clipping: off
                  Color: [0 0 0]
            ContextMenu: [0×0 GraphicsPlaceholder]
              CreateFcn: ''
              DeleteFcn: ''
              EdgeColor: 'none'
                Editing: off
                 Extent: [-1.9169 0.4257 3.8338 0.0212]
              FontAngle: 'normal'
               FontName: 'Helvetica'
               FontSize: 11
          FontSmoothing: on
              FontUnits: 'points'
             FontWeight: 'bold'
       HandleVisibility: 'off'
                HitTest: on
    HorizontalAlignment: 'center'
           Interactions: [1×1 matlab.graphics.interaction.interactions.EditInteraction]
            Interpreter: 'latex'
          Interruptible: on
              LineStyle: '-'
              LineWidth: 0.5000
                 Margin: 3
                 Parent: [1×1 Axes]
          PickableParts: 'visible'
               Position: [6.3798e-06 0.4257 0]
               Rotation: 0
               Selected: off
     SelectionHighlight: on
                 String: 'Normal Distribution PDF'
                    Tag: ''
                   Type: 'text'
                  Units: 'data'
               UserData: []
      VerticalAlignment: 'bottom'
                Visible: on
```

<br>

**参考**

[1] [sprintf - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/sprintf.html).

[2] [title - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/title.html).