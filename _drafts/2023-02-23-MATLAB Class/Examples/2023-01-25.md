2023-01-25

模型-视图-控制器（Model-View-Controller，MVC）模式进行编程。

模型（Model）反映程序的中心逻辑。



视图：用来显示User Interface给用户

它的职责包括：

- 产生figure和空间对象，设置它们的位置及默认值
- 把控件和回调函数联合起来

在实际编程中，模型反映的是程序的逻辑，是相对稳定的；而视图界面需要经常调整，并且界面的调整不应该影响程序的模型。采用面对对象的编程思想最显然的做法是：把界面和模型封装到不同的类中，让各个类各司其职，这叫做把界面变化和模型结构。

还有一些和界面模型无关的功能，比如处理用户的输入，放在第三类中，即控制器（Controller）类；



## Model Class

![image-20230125130233776](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230125130233776.png)

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

我们把balance定义为Model类的一个属性。

当`deposit`或`withdraw`函数被调用时，`balance`将发生变化，Model类对象发出通知给监听该事件的listener. 在这个场景里，listener是View类中的`updataBalance`函数。



Model类和View类对象之间的关系是被监听和监听的关系（Observer Pattern），



## View Class

![image-20230125130246349](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230125130246349.png)

View类主要做了以下几件事情：

（1）根据输入参数获得`Model`类的Handle：

```matlab
classdef View < handle
...
    methods
        function obj = View(modelObj)
            obj.modelObj = modelObj;
           ...
        end
    end
end
```

`View`类必须拥有`Model`类的Handle，这样才能在`View`类的`updateBalance()`函数中查询`Model`的内部状态，并更新界面；

（2）使用`addlistener`方法（`Handle`基类的方法）将`updateBalance`作为`Model`类的`balanceChanged`事件的监听者：

```matlab
classdef View < handle
	...
    methods
        function obj = View(modelObj)
            ...
            obj.modelObj.addlistener('balanceChanged', @obj.updateBalance);
            ...
        end
        function updateBalance(obj)
            set(obj.balanceBox, 'string', num2str(obj.modelObj.balance));
        end
        end
    end
end
```

`updateBalance`方法的作用是：一旦监听到`balanceChanged`事件，就将模型类的`balance`属性打印到`balanceBox`控件中；

（3）初始化UI视图：

```matlab
classdef View < handle
	...
    methods
        function obj = View(modelObj)
            ...
            obj.buildUI();
            ...
        end
        function buildUI(obj)
            obj.hfig = figure('pos', [100, 100, 300, 200]);
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
    end
end
```

在初始化GUI的最后，需要调用一次`updateBlance`方法。

（4）产生Controller：

```matlab
classdef View < handle
	...
    methods
        function obj = View(modelObj)
        	...
            obj.controlObj = obj.makeController();
            ...
        end
        function controlObj = makeController(obj)
            controlObj = Controller(obj, obj.modelObj);
        end
    end
end
```

每个View类对象必须至少拥有一个控制器。因为控制器负责处理用户的输入，所以必须根据视图的情况来设计，所以View类负责产生自己的Controller。

（5）注册控件的回调函数：

```matlab
classdef View < handle
	...
    methods
        function obj = View(modelObj)
        	....
            obj.attachToController(obj.controlObj);
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

因为View类的职责仅仅是展示，不包括响应，所以View类还要负责给自己拥有的控件注册回调函数，这两个回调函数均来自Controller类。

（6）除了以上内容，`View`类中还包含一个Dependent属性`input`，以及对应的`get.input`函数：

```matlab
classdef View < handle
	...
    properties(Dependent)
        input
    end
    methods
		...
        function input = get.input(obj)  % Get 中间层？
            input = get(obj.numBox, 'string');
            input = str2double(input);
        end
        ...
    end
end
```

Dependent 属性的值依赖于其他属性。





**类内部的赋值和查询也会调用`set`方法和`get`方法**









## Controller Class

![image-20230125130258747](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230125130258747.png)





<br>

`View`类用于创建视图。









控制逻辑





完整代码放在文末附录

<br>

**References**





