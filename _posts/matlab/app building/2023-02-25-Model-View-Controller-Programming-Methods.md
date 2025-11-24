---
title: An Example Creating MATLAB GUI with Object-oriented and Model-View-Controller Programming Methods
toc: false
categories: 
 - MATLAB
tags:
 - MATLAB Object-Oriented Programming
 - MATLAB App Building
date: 2023-02-25 15:52:53 +0800
last_modified_at: 2025-11-24 12:03:28 -0500
---

《MATLAB面向对象编程：从入门到设计模式（第2版）》[^1]这本书中介绍了一个使用“面向对象+MVC（Model-View-Controller）模式”创建GUI的示例：

![image-20230225151658839](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225151658839.png?raw=true)

该GUI很简单地模拟银行账户存款取款的过程。原书作者非常详细地介绍了如何使用面向对象编程的方式编写MVC模式的GUI程序，但是作为初学者，有一些小细节我不是很理解，原本我想要写一篇博客对这些地方一一进行解释，但是写到一半发现内容越写越多，并且再看时仍然觉得没有条理，没有主次，抓不住重点；另一方面，由于能力有限，很多地方我也无法完全搞明白。因此，我在这篇博客中仅仅把原书所提供的代码放在这里，以后在编程时进行模仿，一点一点进行学习。

<br>

`Model`类：

![image-20230225153008865](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225153008865.png?raw=true)

```matlab
classdef Model < handle
    properties
        balance
    end

    events
        balanceChanged
    end

    methods
        function obj = Model(balance)
            obj.balance = balance;
        end

        function deposit(obj, val)
            obj.balance = obj.balance + val;
            obj.notify('balanceChanged')
        end

        function withdraw(obj, val)
            obj.balance = obj.balance - val;
            obj.notify('balanceChanged')
        end
    end
end
```

`View`类：

![image-20230225153021925](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225153021925.png?raw=true)

```matlab
classdef View < handle
    properties
        % UIs
        hfig
        drawButton
        depositButton
        balanceBox
        numBox
        text
        % UI settings
        viewSize
        % Model handle and Controller handle
        modelObj
        controlObj
    end
    properties(Dependent)
        input
    end

    methods
        function obj = View(modelObj)
            obj.viewSize = [100,100,300,200];
            obj.modelObj = modelObj;
            obj.modelObj.addlistener('balanceChanged', @obj.updateBalance);
            obj.buildUI();
            obj.controlObj = obj.makeController();
            obj.attachToController(obj.controlObj);
        end

        function input = get.input(obj)  
            input = get(obj.numBox, 'string');
            input = str2double(input);
        end

        function buildUI(obj)
            obj.hfig = figure('pos', obj.viewSize);
            obj.drawButton = uicontrol('parent', obj.hfig, 'string', 'withdraw', ...
                'pos', [60, 28, 60, 28]);
            obj.depositButton = uicontrol('parent', obj.hfig, 'string', 'deposit', ...
                'pos', [180, 28, 60, 28]);
            obj.numBox = uicontrol('parent', obj.hfig, 'style', 'edit', ...
                'pos', [60, 85, 180, 28], 'tag', 'numBox');
            obj.text = uicontrol('parent', obj.hfig, 'style', 'text', 'string',...
                'Balance', 'pos', [60, 142, 60, 28]);
            obj.balanceBox = uicontrol('Parent', obj.hfig, 'Style', 'edit','String', 'Balance', ...
                'pos', [180, 142, 60, 28], 'tag', 'balanceBox');
            obj.updateBalance();
        end

        function updateBalance(obj,scr,data)
            set(obj.balanceBox, 'string', num2str(obj.modelObj.balance));
        end

        function controlObj = makeController(obj)
            controlObj = Controller(obj, obj.modelObj);
        end

        function attachToController(obj, controller)
            funcH = @controller.callback_drawbutton;
            set(obj.drawButton, 'callback', funcH); 

            funcH = @controller.callback_depositbutton;
            set(obj.depositButton, 'callback', funcH);
        end
    end
end
```

`Controller`类：

![image-20230225153037251](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225153037251.png?raw=true)

```matlab
classdef Controller < handle
    properties
        % View handle and Model handle
        viewObj
        modelObj
    end
    methods
        function obj = Controller(viewObj, modelObj)
            obj.viewObj = viewObj;
            obj.modelObj = modelObj;
        end
        function callback_drawbutton(obj,scr,event)
            obj.modelObj.withdraw(obj.viewObj.input);
        end
        function callback_depositbutton(obj,scr,event)
            obj.modelObj.deposit(obj.viewObj.input);
        end
    end
end
```

最后在`main.m`函数中创建GUI即可：

```matlab
modelObj = Model(500);
viewObj = View(modelObj);
```

<br>

**References**

[^1]: 徐潇. MATLAB 面向对象编程: 从入门到设计模式. 北京航空航天大学出版社, 2017.