---
title: An Example of using the Panelbox Minimize/Maximize Function from MATLAB GUI Layout Toolbox
categories: 
 - MATLAB
tags:
 - MATLAB App Building
 - MATLAB Software Development Tools
date: 2023-02-26 19:47:42 +0800
last_modified_at: 2024-04-20 16:11:33 +0800
---

# Introduction

MATLAB GUI Layout Toolbox[^1]所提供的Panel类`uix.BoxPanel`具有“折叠/展开”（即minimize/maximize）的功能，并且提供了一个该属性的示例：`minimizeexample`。该示例创建了如下图所示的GUI界面：

![image-20230225231031216](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225231031216.png?raw=true)

如果点击Panel左上角的三角形，则界面会变成：

![image-20230225231104238](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225231104238.png?raw=true)

程序以此来实现Panel折叠与展开的功能。该示例的代码中包含着很多非常意思的细节，也解决了一些之前我没有理解的问题，因此写下这篇博客以记录一下。

<br>

# Main Function: `minimizexample()`

该示例仍然采用嵌套函数的方式共享数据（共享主函数中定义的变量），即在主函数`minimizeexample`下定义多个子函数（在这个示例中，仅包含一个子函数，即回调函数`nMinimize`）。

在主函数中，首先定义了一些创建GUI组件的常数和GUI组件：

```matlab
function minimizeexample()

width = 200;
pheightmin = 20;
pheightmax = 100;

% Create the window and main layout
fig = figure('Name','Collapsable GUI', ...
    'NumberTitle','off',...
    'Toolbar','none', ...
    'MenuBar','none');
box = uix.VBox('Parent',fig);

panel{1} = uix.BoxPanel('Title','Panel 1','Parent',box);
panel{2} = uix.BoxPanel('Title','Panel 2','Parent',box);
panel{3} = uix.BoxPanel('Title','Panel 3','Parent',box);
set(box,'Heights',pheightmax*ones(1,3));

% Add some contents
uicontrol('Parent',panel{1},'Style','PushButton','String','Button 1');
uicontrol('Parent',panel{2},'Style','PushButton','String','Button 2');
uicontrol('Parent',panel{3},'Style','PushButton','String','Button 3');

% Resize the window
pos = get(fig,'Position');
set(fig,'Position',[pos(1,1:2),width,sum(box.Heights)]);
...
end 
```

![image-20230225232409783](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225232409783.png?raw=true)

其中，创建Panel时使用的是MATLAB GUI Layout Toolbox所提供的Panel类`uix.BoxPanel`。需要注意的是，这三个Panel是保存在Cell类型的`Panel`变量中的：

```matlab
>> panel
panel =
  1×3 cell array
  Column 1
    {1×1 BoxPanel}
  Column 2
    {1×1 BoxPanel}
  Column 3
    {1×1 BoxPanel}
```

`Panel`变量中的每个元素是`BoxPanel`类的变量。

之后，为每一个`Panel`变量中的每个`BoxPanel`类元素创建回调函数：

```matlab
...
% Hook up the minimize callback
set(panel{1},'MinimizeFcn',{@nMinimize, 1});
set(panel{2},'MinimizeFcn',{@nMinimize, 2});
set(panel{3},'MinimizeFcn',{@nMinimize, 3});
...
```

回调函数`nMinimize`的具体定义为：

```matlab
function minimizeexample()
...
    function nMinimize(eventSource, eventData, whichpanel) %#ok<INUSL>
        % A panel has been maximized/minimized
        s = get(box,'Heights');
        pos = get(fig,'Position');
        panel{whichpanel}.Minimized = ~panel{whichpanel}.Minimized;
        if panel{whichpanel}.Minimized
            s(whichpanel) = pheightmin;
        else
            s(whichpanel) = pheightmax;
        end
        set(box,'Heights',s);

        % Resize the figure, keeping the top stationary
        delta_height = pos(1,4) - sum(box.Heights);
        set(fig,'Position',pos(1,:)+[0 delta_height 0 -delta_height]);
    end
end
```

创建回调函数和绑定回调函数的过程中就有一些需要注意的地方，下面就对它们进行介绍。

<br>

# Callbacks `nMinimize()`

## Hook up callbacks

由于三个Panel是类似的，并且折叠/展开的功能也是类似，因此在程序中仅仅创建了一个回调函数`nMinimize`，将其通过输入不同的参数将其绑定到不同的`uix.BoxPanel`上。绑定回调函数时使用的语法是：

```matlab
...
set(panel{1},'MinimizeFcn',{@nMinimize, 1});
...
```

`'MinimizeFcn'`（以及回调函数中需要用到的`Minimized`）都是`uix.BoxPanel`中所定义的属性：

![image-20230225234636017](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225234636017.png?raw=true)

而对于向`'MinimizeFcn'`绑定回调函数（即传入参数`{@nMinimize, 1}`）的方式，我不是很理解。因为如果在单独的一个脚本文件中仅仅写入：

```matlab
% test.m
a = {@nMinimize, 1};

function nMinimize(eventSource, eventData, whichpanel) %#ok<INUSL>
% A panel has been maximized/minimized
s = get(box,'Heights');
pos = get(fig,'Position');
panel{whichpanel}.Minimized = ~panel{whichpanel}.Minimized;
if panel{whichpanel}.Minimized
    s(whichpanel) = pheightmin;
else
    s(whichpanel) = pheightmax;
end
set(box,'Heights',s);

% Resize the figure, keeping the top stationary
delta_height = pos(1,4) - sum(box.Heights);
set(fig,'Position',pos(1,:)+[0 delta_height 0 -delta_height]);
end
```

最后得到的变量`a`是一个cell数组：

```matlab
>> a
a =
  1×2 cell array
    {@nMinimize}    {[1]}
```

数组的第一个元素是一个匿名函数，第二个元素是一个`double`类型的值。

> 尝试了一个普通的函数，结果也是类似的：
>
> ```matlab
> clc,clear,close all
> 
> a = {@xsquare,5}
> 
> function x = xsquare(x)
> x = x.^2;
> end
> ```
>
> ```matlab
> a =
>   1×2 cell array
>     {@xsquare}    {[5]}
> ```

我在官方文档MATLAB关于Anonymous Functions的官方文档[^2][^3]中也没有找到类似的用法和有关这一特性的介绍。因此，我就暂且将其理解为一种为**“多个类似的”**组件创建类似回调函数的特殊用法，cell数组中的`1`，`2`或`3`当作形参`whichpanel`传入到回调函数`nMinimize`中。

## Callbacks formal parameters: `eventSource` and `eventData`

观察回调函数`nMinimize`的形参，可以看到在上面提到的`whichpanel`之前还有两个形参`eventSource`和`eventData`：

```matlab
function nMinimize(eventSource, eventData, whichpanel) %#ok<INUSL>
% A panel has been maximized/minimized
s = get(box,'Heights');
pos = get(fig,'Position');
panel{whichpanel}.Minimized = ~panel{whichpanel}.Minimized;
if panel{whichpanel}.Minimized
    s(whichpanel) = pheightmin;
else
    s(whichpanel) = pheightmax;
end
set(box,'Heights',s);

% Resize the figure, keeping the top stationary
delta_height = pos(1,4) - sum(box.Heights);
set(fig,'Position',pos(1,:)+[0 delta_height 0 -delta_height]);
end
```

`eventSource`和`eventData`分别是`UIControl`类和`ActionData`类的变量:

```matlab
eventSource = 
  UIControl (▴) with properties:
              Style: 'checkbox'
             String: '▴'
    BackgroundColor: [1×3 double]
           Callback: {2×1 cell}
              Value: 1
           Position: [1×4 double]
              Units: 'pixels'
  Show all properties
```

```matlab
eventData = 
  ActionData with properties:
       Source: [1×1 UIControl]
    EventName: 'Action'
```

但可以看到，在整个回调函数的定义中，并没有使用这两个变量，**但是作为回调函数的定义，这两个变量是必须的！！！**

如果删去这两个变量，在调用回调函数时会提示Error：

```matlab
Error using minimizeexample/nMinimize
Too many input arguments.
 
Error while evaluating UIControl Callback.
```

## Code annotation `%#ok<INUSL>`

在函数定义中没有使用形参`eventSource` and `eventData`，但同时MATLAB Code Analyzer并没有进行提示，是因为在函数声明的后面添加了一条特殊的注释`%#ok<INUSL>`：

![image-20230226174152490](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230226174152490.png?raw=true)

用以提示Code Analyzer: *It means MATLAB editor will not issue warning at this line of code. It does not have any effect at the run time.* （参考[^4]），删除掉这条注释后，可以看到Code Analyzer就会像往常一样提示“输入参数可能未在函数定义中进行使用”：

![image-20230226174326526](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230226174326526.png?raw=true)

不同的代码开发者会采用不同的方式来处理这种“没有使用但必要”的情况，比如说博客[^5]中示例在回调函数定义时采用的方式是使用`~`进行替代：

![image-20230226174830073](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230226174830073.png?raw=true)

![image-20230226174935333](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230226174935333.png?raw=true)

以及博客[^6]中直接选择忽略Code Analyzer警告的处理方式：

![image-20230226175152657](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230226175152657.png?raw=true)

总的来讲，我认为本博客中这个示例的处理方式是更加规范的。

## Whether Resize the Figure

回调函数定义的部分没有什么复杂的地方，需要提一点的是，原代码会根据Panel的折叠情况来调整figure的大小：

![image-20230226180336598](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230226180336598.png?raw=true)

但我个人认为固定住figure的大小是更合理的，只需要注释掉下面的代码即可：

```matlab
    ...
    % Resize the figure, keeping the top stationary
    delta_height = pos(1,4) - sum(box.Heights);
    set(fig,'Position',pos(1,:)+[0 delta_height 0 -delta_height]);
    ...
```

![image-20230226180518858](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230226180518858.png?raw=true)

<br>

# Conclusion

最后，需要提醒一点，GUI Layout Toolbox所提供的`uix.VBox`类和`uix.VBoxFlex`类也具有类似折叠/展开的功能：

> Note that minimizing a panel to its title-bar only really makes sense inside a `uix.VBox` or `uix.VBoxFlex`.

<br>

# Appendix

```matlab
function minimizeexample()
%MINIMIZEEXAMPLE: An example of using the panelbox minimize/maximize
%  Copyright 2009-2020 The MathWorks, Inc.

width = 200;
pheightmin = 20;
pheightmax = 100;

% Create the window and main layout
fig = figure('Name','Collapsable GUI', ...
    'NumberTitle','off',...
    'Toolbar','none', ...
    'MenuBar','none');
box = uix.VBox('Parent',fig);

panel{1} = uix.BoxPanel('Title','Panel 1','Parent',box);
panel{2} = uix.BoxPanel('Title','Panel 2','Parent',box);
panel{3} = uix.BoxPanel('Title','Panel 3','Parent',box);
set(box,'Heights',pheightmax*ones(1,3));

% Add some contents
uicontrol('Style','PushButton','String','Button 1','Parent',panel{1});
uicontrol('Style','PushButton','String','Button 2','Parent',panel{2});
uicontrol('Style','PushButton','String','Button 3','Parent',panel{3});

% Resize the window
pos = get(fig,'Position');
set(fig,'Position',[pos(1,1:2),width,sum(box.Heights)]);

% Hook up the minimize callback
set(panel{1},'MinimizeFcn',{@nMinimize, 1});
set(panel{2},'MinimizeFcn',{@nMinimize, 2});
set(panel{3},'MinimizeFcn',{@nMinimize, 3});

    function nMinimize(eventSource, eventData, whichpanel) %#ok<INUSL>
        % A panel has been maximized/minimized
        s = get(box,'Heights');
        pos = get(fig,'Position');
        panel{whichpanel}.Minimized = ~panel{whichpanel}.Minimized;
        if panel{whichpanel}.Minimized
            s(whichpanel) = pheightmin;
        else
            s(whichpanel) = pheightmax;
        end
        set(box,'Heights',s);
        
         % Resize the figure, keeping the top stationary
         delta_height = pos(1,4) - sum(box.Heights);
         set(fig,'Position',pos(1,:)+[0 delta_height 0 -delta_height]);
    end % nMinimize

end % EOF
```

<br>

# References

[^1]: [GUI Layout Toolbox - File Exchange - MATLAB Central](https://ww2.mathworks.cn/matlabcentral/fileexchange/47982-gui-layout-toolbox?s_tid=srchtitle_support_results_1_MATLAB%20GUI%20Layout%20Toolbox).
[^2]: [Anonymous Functions - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/anonymous-functions.html).
[^3]: [Create Function Handle - MathWorks](https://ww2.mathworks.cn/help/matlab/matlab_prog/creating-a-function-handle.html).
[^4]: [%#ok -> What's the meaning?](https://comp.soft-sys.matlab.narkive.com/KETqSEbs/ok-inusl-what-s-the-meaning).
[^5]: [A GUI Demo Browser from MATLAB GUI Layout Toolbox - What a starry night~](https://helloworld-1017.github.io/2023-02-25/14-39-25.html).
[^6]: [An Example Creating MATLAB GUI with Object-oriented and Model-View-Controller Programming Methods - What a starry night~](https://helloworld-1017.github.io/2023-02-25/15-52-53.html).
