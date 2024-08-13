---
title: Changing the Value of MATLAB uicontrols *Programmatically* does NOT call the `ValueChangedFcn` Callback
toc: false
categories: 
 - MATLAB
tags: 
 - MATLAB App Building
date: 2023-05-25 14:20:21 +0800
last_modified_at: 2024-08-12 16:25:00 +0800
---

今天在调试MATLAB GUI程序时发现了一个关于`ValueChangedFcn`回调函数的调用特性：**使用代码修改UI控件时并不会调用控件的`ValueChangedFcn`回调函数**。

创建一个`uidropdown`和相应的`ValueChangedFcn`函数：

```matlab
clc,clear,close all

fig = uifigure("Position",[680,558,180,180],"WindowStyle","alwaysontop");
dropdown = uidropdown(fig,"Position",[17.70,11.00,83.37,22.00],...
    "ValueChangedFcn",@callback_uidropdown);

function callback_uidropdown(src,~)
disp("Value changed!")
disp(src.Value)
end
```

当在GUI中修改`uidropdown`的选项时，会调用回调函数`callback_uidropdown`：

![image-20230525134555824](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230525134555824.png?raw=true)

使用代码修改`uidropdown`的值也可以修改GUI中的显示，**但是不会调用回调函数**：

```matlab
set(dropdown,"Value","Option 1");
```

![image-20230525134738926](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230525134738926.png?raw=true)

```matlab
dropdown.Value = "Option 3";
```

![](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230525134935087.png?raw=true)

<br>

`state`类型`uibutton`控件的`"ValueChangedFcn"`回调函数也是类似的：

```matlab
clc,clear,close all

fig = uifigure("Position",[680,558,180,45],"WindowStyle","alwaysontop");
button = uibutton(fig,"state","Position",[17.70,11.00,83.37,22.00],...
    "ValueChangedFcn",@callback_uibutton);

function callback_uibutton(src,~)
disp("Value changed!")
disp(src.Value)
end
```

可以进行同样的验证。

<br>

在编写GUI时需要注意这个小特性，否则会出现一些意料之外的错误。

