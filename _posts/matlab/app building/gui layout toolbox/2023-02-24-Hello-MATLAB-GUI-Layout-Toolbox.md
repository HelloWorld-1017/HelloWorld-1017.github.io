---
layout: single
title: Hello, MATLAB GUI Layout Toolbox!
date: 2023-02-24 09:25:21 +0800
categories: 
 - MATLAB
tags:
 - MATLAB App Building
---

# Introduction

《MATLAB面向对象编程：从入门到设计模式（第2版）》中在构建GUI时特意提到了一个布局GUI控件的一个工具箱：[GUI Layout Toolbox](https://ww2.mathworks.cn/matlabcentral/fileexchange/47982-gui-layout-toolbox). 这本书发表于2017年10月，而这个工具箱最后一个版本Version 2.3.5发布于2020年10月29日：

![image-20230224035753476](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230224035753476.png?raw=true)

时间比较久远了。之所以提这个时间，是因为在MATLAB 2018b的版本App Building中加入了`uigridlayout`函数（[uigridlayout - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/uigridlayout.html)），该函数与这个工具箱实现的功能是一样的，基本上也都是采用Parent-Children的关系，随着`uigridlayout`函数的不断优化，可能就完全涵盖了这个工具箱的功能：

![image-20230224040421377](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230224040421377.png?raw=true)

毕竟`uigridlayout`函数的兼容性肯定是更好的（尽管这个工具箱也是由MathWorks工程师所创建的）。但是我还是想要学习一下这个工具箱，因为一方面它是专门针对GUI的Layout设置，在某一些方面可能更专业；另一方面，我在浏览它的Documentation时看到了一个很漂亮的complete example：

![image-20230224041218277](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230224041218277.png?raw=true)

并且它提供了实现的完整的代码和说明：

![image-20230224041301899](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230224041301899.png?raw=true)

因此想要学习一下。这篇博客就简单地记录一下《MATLAB面向对象编程：从入门到设计模式（第2版）》中所介绍的GUI Layout Toolbox提供的一些基本的Class的用法。

<br>

# VBox Class

```matlab
clc, clear, close all

f = figure('Menubar', 'none', 'ToolBar', 'none', 'Position', [500 500 80 300]);
mainLayout = uiextras.VBox('Parent', f, 'Padding', 20);
% VBox：纵向布局类
% 'Padding', 20：表示指定figure边缘到VBox的边缘是20个像素

uicontrol('style', 'pushbutton', 'String', 'Find Next', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Find Previous', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Replace', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Replace All', 'Parent', mainLayout);
uicontrol('style', 'pushbutton', 'String', 'Close', 'Parent', mainLayout);

set(mainLayout, 'Sizes', [40 40 40 40 40], 'Spacing', 10)
% 'Sizes', [40 40 40 40 40]：设置按钮的宽度分别为40,40,40,40
% 'Spacing', 10：表示按钮间隔是10像素
```

![image-20230224090756188](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230224090756188.png?raw=true)

<br>

# HBox Class

```matlab
clc, clear, close all

f = figure('Menubar','none','Toolbar','none','Position',[500 500 200 45]);
mainLayout = uiextras.HBox('Parent',f,'Padding',10);
% HBox：横向布局类

uicontrol('Parent',mainLayout,'Style','text','String','Find what:','FontSize',10);
uicontrol('Parent',mainLayout,'Style','popupmenu','string','prev1|prev2|prev3','Background','white');

set(mainLayout,'Sizes',[120,-1],'Spacing',10);
% 'Sizes',[120,-1]：表示第一个控件的宽度为固定的120，而-1表示第二个控件将会填满除去60像素后剩下的空间
```

![image-20230224091121502](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230224091121502.png?raw=true)

![image-20230224091134346](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230224091134346.png?raw=true)

并且支持多个控件的宽度设置都为`-1`：

```matlab
set(mainLayout,'Sizes',[-1,-1],'Spacing',10);
```

![image-20230224091250771](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230224091250771.png?raw=true)

<br>

# TabPanel Class

```matlab
clc, clear, close all

f = figure('MenuBar','none','ToolBar','none');
mainLayout = uiextras.TabPanel('Parent', f, 'Padding', 5);
% TabPanel：选项卡布局类

uitable('Data', magic(25), 'Parent', mainLayout);
uitable('Data', magic(25), 'Parent', mainLayout);
uitable('Data', magic(25), 'Parent', mainLayout);

mainLayout.TabNames = {'Sheet1', 'Sheet2', 'Sheet3'};
mainLayout.SelectedChild = 2;% 表示默认情况下被选中的Tab是第二个
mainLayout.FontSize = 10;
mainLayout.TabWidth = 100;
```

![image-20230224091432645](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230224091432645.png?raw=true)

<br>

# Grid Class

```matlab
clc, clear, close all

f = figure('MenuBar','none','ToolBar','none','Position',[500 500 300 150]);
mainLayout = uiextras.Grid('Parent',f,'Padding',10);

% Fist column
uicontrol('Parent',mainLayout,'Style','text','String','Replace with','FontSize',9);
uicontrol('Parent',mainLayout,'Style','text','String','Look in','FontSize',9);
uiextras.Empty('Parent',mainLayout);
uicontrol('Parent',mainLayout,'Style','Radio','String','Math case','FontSize',9);

% Second column
uicontrol('Parent',mainLayout,'Style','popupmenu','String','prev1|prev2|prev3','background','w');
uicontrol('Parent',mainLayout,'Style','popupmenu','String','prev1|prev2|prev3','background','w');
uiextras.Empty('Parent',mainLayout);
uicontrol('Parent',mainLayout,'Style','radio','String','Whole word','FontSize',9);
set(mainLayout,'RowSizes',[25,25,25,25],'ColumnSizes',[120,150],'Spacing',5);
```

![image-20230224091729441](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230224091729441.png?raw=true)

需要注意的是：Grid类对控件的排列方式是先列后行。

<br>

# Compound Layout

负荷布局是指把各个布局管理器对象组合起来，通过多层的Parent-Child关系对界面进行更灵活的设计。

```matlab
clc,clear,close all

f = figure('MenuBar','none','ToolBar','none','pos',[200 200 500 300]);
mainLayout = uiextras.HBox('Parent',f,'Spacing',10);
LeftLayout = uiextras.VBox('Parent',mainLayout,'Spacing',10,'Padding',10);
LUpperLayout = uiextras.HBox('Parent',LeftLayout,'Padding',10);
LLowerLayout = uiextras.Grid('Parent',LeftLayout,'Padding',10);
RightLayout = uiextras.VBox('Parent',mainLayout,'Spacing',20,'Padding',10);

% For Upper Left
uicontrol('Parent',LUpperLayout,'Style','text','String','Find what:','FontSize',10);
uicontrol('Parent',LUpperLayout,'Style','popupmenu','string','prev1|prev2|prev3','Background','white');

% For Lower Left
% Fist column
uicontrol('Parent',LLowerLayout,'Style','text','String','Replace with','FontSize',9);
uicontrol('Parent',LLowerLayout,'Style','text','String','Look in','FontSize',9);
uiextras.Empty('Parent',LLowerLayout);
uicontrol('Parent',LLowerLayout,'Style','Radio','String','Math case','FontSize',9);
% Second column
uicontrol('Parent',LLowerLayout,'Style','popupmenu','String','prev1|prev2|prev3','background','w');
uicontrol('Parent',LLowerLayout,'Style','popupmenu','String','prev1|prev2|prev3','background','w');
uiextras.Empty('Parent',LLowerLayout);
uicontrol('Parent',LLowerLayout,'Style','radio','String','Whole word','FontSize',9);
set(LLowerLayout,'RowSizes',[25,25,25,25],'ColumnSizes',[120,150],'Spacing',5);

% For Right
uicontrol('style', 'pushbutton', 'String', 'Find Next', 'Parent', RightLayout);
uicontrol('style', 'pushbutton', 'String', 'Find Previous', 'Parent', RightLayout);
uicontrol('style', 'pushbutton', 'String', 'Replace', 'Parent', RightLayout);
uicontrol('style', 'pushbutton', 'String', 'Replace All', 'Parent', RightLayout);
uicontrol('style', 'pushbutton', 'String', 'Close', 'Parent', RightLayout);
```

![image-20230224092153488](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230224092153488.png?raw=true)

此时各容器的包含关系为：

![image-20230224092357694](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230224092357694.png?raw=true)

<br>

**References**

[1] 徐潇. MATLAB 面向对象编程: 从入门到设计模式. 北京航空航天大学出版社, 2017.

