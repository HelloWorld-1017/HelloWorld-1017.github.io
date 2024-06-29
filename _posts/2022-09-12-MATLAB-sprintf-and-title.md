---
layout: single
title: MATLAB `sprintf` Function and `title` Function
date: 2022-09-12 14:42:37 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Graphics
toc: false
last_modified_at: 2023-11-18 18:32:51 +0800
---

今天在学MATLAB的GMM示例时 [^1]，看到了一个添加图像标题比较漂亮的实现方法，使用了`sprintf` [^2]向`title` [^3]添加参数：

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

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220912231156922.png?raw=true" alt="image-20220912231156922" style="zoom:50%;" />

但是，`sprintf`函数的目的是为了向命令行中打印文本，所以它不支持LaTeX解释器，这一点使得这种用法其实不是很实用。

**Added on Nov. 18, 2023.** Actually, `sprintf` function could be used while adopting text interpreter, by formatting control sequence as well. The more information could be found in Blogs [^4] and [^5].
{: .notice--warning}

但是，受此启发，可以使用`sprintf`函数向`eval`函数传递参数，可以提高代码的可读性。

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

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220912142142800.png?raw=true" alt="image-20220912142142800" style="zoom:50%;" />

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

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220912142357249.png?raw=true" alt="image-20220912142357249" style="zoom:50%;" />

其中，变量`tt`和`ss`是标题和子标题所对应的Text对象，可以分别修改它们的行为：

```
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

**References**

[^1]: [Gaussian Mixture Model (GMM) - What a starry night~](https://helloworld-1017.github.io/2022-09-12/12-28-37.html).
[^2]: [MATLAB `sprintf`: Format data into string or character vector - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/sprintf.html)
[^3]: [MATLAB `title`: Add title - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/title.html).
[^4]: [matlab sprintf latex interpreter - 掘金](https://juejin.cn/s/matlab%20sprintf%20latex%20interpreter).
[^5]: [Monte Carlo Simulation to Estimate $\pi$ - What a starry night~](https://helloworld-1017.github.io/2023-11-18/17-40-37.html).