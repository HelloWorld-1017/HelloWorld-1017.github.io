---
layout: single
title: A GUI Demo Browser from MATLAB GUI Layout Toolbox
date: 2023-02-25 14:39:25 +0800
categories: 
 - MATLAB
tags:
 - MATLAB App Building
header:
  image: https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230224183310721.png?raw=true
---

# Introduction

博客[Hello, MATLAB GUI Layout Toolbox!](http://whatastarrynight.com/matlab/Hello-MATLAB-GUI-Layout-Toolbox/)中提到，MATLAB GUI Layout Toolbox提供了一个很漂亮的创建GUI的完整示例：

![image-20230225141945003](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225141945003.png?raw=true)

本博客就仔细地学习一下这个示例。

<br>

# Two Shared Variables (Structures)

这个GUI程序采用了一种非常简单的编程模式：即在一个主函数下嵌套多个函数。

```matlab
function demoBrowser()

   % Declare shared variables
   data = createData();
   gui = createInterface(data.DemoNames);

   % Now update the GUI with the current data
   updateInterface();
   redrawDemo();
   
   % Helper subfunctions.
   function data = createData() ... end;
   function gui = createInterface(names) ... end;
   function updateInterface() ... end;
   function redrawDemo() ... end;

   % Callback subfunctions.
   function onMenuSelection() ... end;
   function onListSelection() ... end;
   function onDemoHelp() ... end;
   function onHelp() ... end;
   function onExit() ... end;

end  % Main function
```

在这种编程方式下，所有的nested subfunctions都可以调用主函数中的任何变量。这一特性同样也可能是一种风险，因为定义在主函数中的任何变量都是全局变量。为了规避这一风险，开发者在开发这个程序的时候所有的逻辑都定义在subfunctions中，主函数中仅仅声明了两个shared variables (Structures)，即：

- **data**: a structure containing all shared data
- **gui**: a structure containing handles to GUI widgets

这两个变量同样由两个subfunctions建立。

## Structure `data`

`data`变量在主函数中的声明：

```matlab
data = createData();
```

以及`createData()`函数的内容：

```matlab
    function data = createData()
        % Create the shared data-structure for this application
        demoList = {
            'Complex surface'            'cplxdemo'
            'Cruller'                    'cruller'
            'Earth'                      'earthmap'
            'Four linked tori'           'tori4'
            'Klein bottle'               'xpklein'
            'Klein bottle (1)'           'klein1'
            'Knot'                       'knot'
            'Logo'                       'logo'
            'Spherical Surface Harmonic' 'spharm2'
            'Werner Boy''s Surface'      'wernerboy'
            };
        selectedDemo = 8;
        data = struct( ...
            'DemoNames', {demoList(:,1)'}, ...
            'DemoFunctions', {demoList(:,2)'}, ...
            'SelectedDemo', selectedDemo );
    end
```

此时得到的`data`是一个结构体：

```matlab
data = 
  struct with fields:
        DemoNames: {1×10 cell}
    DemoFunctions: {1×10 cell}
     SelectedDemo: 8
```

其中：

- `DemoNames`是这些Demo的名称，将要显示在后面的GUI中；

- `DemoFunctions`是这些Demo对应的函数名，这些函数都是MATLAB的内置函数。例如我们直接在命令行中输入`logo`，软件就会绘制出MATLAB的图标：

  ![image-20230224102041879](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230224102041879.png?raw=true)

  并且会在工作空间中加载相应的变量：

  ```matlab
  >> whos
    Name          Size            Bytes  Class                                        Attributes
    L            51x51            20808  double                                                 
    l1            1x1                 8  matlab.graphics.primitive.Light                        
    l2            1x1                 8  matlab.graphics.primitive.Light                        
    logoFig       1x1                 8  matlab.ui.Figure                                       
    logoax        1x1                 8  matlab.graphics.axis.Axes                              
    s             1x1                 8  matlab.graphics.primitive.Surface                      
    z             1x1                 8  matlab.graphics.interaction.internal.zoom   
  ```

- `SlectedDemo = 8`表示软件默认显示的是第8个Demo，如果用户在使用时选取了不同的Demo，`SlectedDemo`的值就会发生变化；

## Structure `gui`

`gui`变量在主函数中的声明及相应的创建函数：

```matlab
gui = createInterface(data.DemoNames);
```

```matlab
    function gui = createInterface(demoList)
        % Create the user interface for the application and return a
        % structure of handles for global use.
        gui = struct();

        % Open a window and add some menus
        gui.Window = figure( ...
            'Name', 'Gallery browser', ...
            'NumberTitle', 'off', ...
            'MenuBar', 'none', ...
            'Toolbar', 'none', ...
            'HandleVisibility', 'off' );

        % + File menu
        gui.FileMenu = uimenu(gui.Window,'Label','File');
        uimenu(gui.FileMenu,'Label','Exit','Callback',@onExit);
        
        % + View menu
        gui.ViewMenu = uimenu(gui.Window,'Label','View');
        for num = 1:numel(demoList)
            uimenu(gui.ViewMenu,'Label',demoList{num},'Callback',@onMenuSelection);
        end
        
        % + Help menu
        helpMenu = uimenu(gui.Window,'Label','Help');
        uimenu(helpMenu,'Label','Documentation','Callback',@onHelp);

        % Arrange the main interface
        mainLayout = uix.HBoxFlex('Parent',gui.Window,'Spacing',3);

        % + Create the panels
        controlPanel = uix.BoxPanel( ...
            'Parent',mainLayout, ...
            'Title','Select a demo:' );
        gui.ViewPanel = uix.BoxPanel( ...
            'Parent',mainLayout, ...
            'Title','Viewing: ???', ...
            'HelpFcn',@onDemoHelp);
        gui.ViewContainer = uicontainer( ...
            'Parent',gui.ViewPanel);

        % + Adjust the main layout
        set(mainLayout,'Widths',[-1,-2]);

        % + Create the controls
        controlLayout = uix.VBox('Parent',controlPanel, ...
            'Padding',3,'Spacing',3);
        gui.ListBox = uicontrol('Style','list', ...
            'BackgroundColor','w', ...
            'Parent',controlLayout, ...
            'String',demoList(:), ...
            'Value',1, ...
            'Callback',@onListSelection);
        gui.HelpButton = uicontrol('Style','PushButton', ...
            'Parent',controlLayout, ...
            'String', 'Help for <demo>', ...
            'Callback', @onDemoHelp);
        set(controlLayout,'Heights',[-1 28]); % Make the list fill the space

        % + Create the view
        gui.ViewAxes = axes('Parent',gui.ViewContainer);
    end
```

`createInterface()`函数创建的Parent-Children关系为：

![image-20230224183310721](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230224183310721.png?raw=true)

其中：

**（1）绿色的字体表示MATLAB本身自带的类**

包括：`figure`类，`uimenu`类，`uicontrol`类、`uicontainer`类和`axes`类，其中`uicontainer`类有一些特殊，MATLAB官方文档中并没有对这个类进行介绍。如果在命令行中输入`type uicontainer`，则只会显示`'uicontainer' is a built-in function.`；如果使用`open uicontainer`，则会有这样的一段注释：

![image-20230224183928678](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230224183928678.png?raw=true)

进行简单的介绍。“built-in function”可能就意味着它的代码不是开源的；但另一方面，如果在命令行中输入`open figure`，也只会出现类似的一段注释，然而我们就可以在MATLAB文档中查找到详细的设置，所以“built-in function”与是否有官方文档并没有直接的联系。我个人认为`uicontainer`类可能更像是一种“中间”函数，有些类似MATLAB的Handle类中定义的Hidden类型的properties.

**（2）蓝色的字体表示GUI Layout Toolbox中定义的类**

包括：`uix.HBoxFlex`类，`uix.BoxPanel`类和`uix.VBox`类，它们的所创建的对象分别为（这些类的介绍都可以在GUI Layout Toolbox的Documentation中找到）：

- `uix.HBoxFlex`类：Arrange elements horizontally with draggable dividers

  ![image-20230225120309693](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225120309693.png?raw=true)

- `uix.BoxPanel`类：Arrange a single element in a panel with boxed title

  ![image-20230225120238856](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225120238856.png?raw=true)

- `uix.VBox`类：Arrange elements vertically in a single column

  ![image-20230225120356671](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225120356671.png?raw=true)

可以看到，官方提供的这个示例中使用到的类都来自`uix`库，与在博客[Hello, MATLAB GUI Layout Toolbox!](http://whatastarrynight.com/matlab/Hello-MATLAB-GUI-Layout-Toolbox/)中所介绍的类不同，后者都来自`uiextras`库。这两个库在工具箱中都有定义：

![image-20230225120636190](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225120636190.png?raw=true)

然而在Documentation中只有对于`uix`库的介绍：

![image-20230225120800040](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225120800040.png?raw=true)

这可能是因为在某个版本中，开发者重新编写了一个`vix`库，并且完全覆盖了`uiextras`库的内容。可以看到`vix`库的类是更多的：

```matlab
% For +uix folder
>> ls
+mixin            Node.m            
.                 Panel.m           
..                PointerManager.m  
Box.m             Resources         
BoxPanel.m        ScrollingPanel.m  
ButtonBox.m       SelectionData.m   
CardPanel.m       TabPanel.m        
ChildEvent.m      Text.m            
ChildObserver.m   VBox.m            
Container.m       VBoxFlex.m        
Divider.m         VButtonBox.m      
Empty.m           calcPixelSizes.m  
FigureData.m      getPosition.m     
FigureObserver.m  loadIcon.m        
Grid.m            set.m             
GridFlex.m        setPosition.m     
HBox.m            tracking.m        
HBoxFlex.m        
HButtonBox.m   

% For +uiextras folder
>> ls
.             HBox.m        VButtonBox.m  
..            HBoxFlex.m    get.m         
BoxPanel.m    HButtonBox.m  set.m         
CardPanel.m   Panel.m       unset.m       
Empty.m       TabPanel.m    
Grid.m        VBox.m        
GridFlex.m    VBoxFlex.m    
```

**（3）红色的字体表示按钮的回调函数，将要在后面进行定义**

<br>

最终，执行完命令`   data = createData();`和`gui = createInterface( data.DemoNames );`后，得到的视图如下图所示：

![image-20230225121652066](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225121652066.png?raw=true)

<br>

# Update Interface

在主函数中定义shared variables，即`data`和`gui`两个结构体后，使用两个函数更新GUI：

```matlab
...
updateInterface();
redrawDemo();
...
```

## `updateInterface()` function

`updateInterface()`函数的定义：

```matlab
    function updateInterface()
        % Update various parts of the interface in response to the demo
        % being changed.
        
        % Update the list and menu to show the current demo
        set(gui.ListBox,'Value',data.SelectedDemo);

        % Update the help button label
        demoName = data.DemoNames{data.SelectedDemo};
        set(gui.HelpButton,'String',['Help for ',demoName]);

        % Update the view panel title
        set(gui.ViewPanel,'Title',sprintf('Viewing: %s',demoName));

        % Untick all menus
        menus = get(gui.ViewMenu,'Children');
        set(menus,'Checked','off');
        % Use the name to work out which menu item should be ticked
        whichMenu = strcmpi(demoName,get(menus,'Label'));
        set(menus(whichMenu),'Checked','on');
    end
```

该函数根据所选取的Demo，更新了GUI四部分的显示：

![image-20230225122727147](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225122727147.png?raw=true)

## `redrawDemo` function

`redrawDemo`函数的定义：

```matlab
    function redrawDemo()
        % Draw a demo into the axes provided
        % We first clear the existing axes ready to build a new one
        if ishandle(gui.ViewAxes)
            delete(gui.ViewAxes);
        end

        % Some demos create their own figure. Others don't.
        fcnName = data.DemoFunctions{data.SelectedDemo};
        switch upper(fcnName)
            case 'LOGO'
                % These demos open their own windows
                evalin('base', fcnName);% Evaluate MATLAB expression in specified workspace
                gui.ViewAxes = gca();
                fig = gcf();
                set(fig,'Visible','off');
            otherwise
                % These demos need a window opening
                fig = figure('Visible','off');
                evalin('base',fcnName);
                gui.ViewAxes = gca();
        end
        % Now copy the axes from the demo into our window and restore its
        % state.
        cmap = colormap(gui.ViewAxes);
        set(gui.ViewAxes,'Parent',gui.ViewContainer);
        colormap(gui.ViewAxes,cmap);
        rotate3d(gui.ViewAxes,'on');
        % Get rid of the demo figure
        close(fig);
    end
```

这个函数首先会删除掉原有的`gui.ViewAxes`：

![image-20230225123851778](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225123851778.png?raw=true)

然后在工作空间中执行Demo的函数名，在*their own windows*绘制出图像：

![image-20230225124409324](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225124409324.png?raw=true)

之后再将其隐藏，并且将图像copy到*our window*中显示，最后的效果是：

![image-20230225124252763](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225124252763.png?raw=true)

## `displayEndOfDemoMessage` function

在执行完函数`updateInterface();`和`redrawDemo();`后，程序最终会执行一个`displayEndOfDemoMessage`函数：

![image-20230225125034694](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230225125034694.png?raw=true)

该函数的作用是：

```matlab
>> help displayEndOfDemoMessage
 displayEndOfDemoMessage Explain how to get more information about a demo.
    displayEndOfDemoMessage(mfilename) shows a link to the published HTML
    version of a MATLAB code file written using cells.  Enable Cell Mode
    using the Cell menu in the MATLAB Editor.
 
    The message only displays when the file is run top-to-bottom.  When
    publishing or evaluating as cells, this function does nothing.
```

这里的参数是空的，说明这里并没有链接到一个published HTML version of a MATLAB code file，只是象征性地将其作为程序的结束。

<br>

# Create Callbacks for GUI Items

接下来就需要给GUI中的控件添加回调函数。

首先是页面左边List中选中元素的回调函数`onListSelection()`：

```matlab
    function gui = createInterface(demoList)
    ...
        gui.ListBox = uicontrol('Style','list', ...
        'BackgroundColor','w', ...
        'Parent',controlLayout, ...
        'String',demoList(:), ...
        'Value',1, ...
        'Callback',@onListSelection);
   ...
   end
    
    function onListSelection(src,~)
        % User selected a demo from the list - update "data" and refresh
        data.SelectedDemo = get(src,'Value');
        updateInterface();
        redrawDemo();
    end
```

这里的`src`变量是listbox类型`uicontrol`的handle.

以及`View`菜单的选项的回调函数：

```matlab
    function gui = createInterface(demoList)
    ...
        % + View menu
        gui.ViewMenu = uimenu(gui.Window,'Label','View');
        for num = 1:numel(demoList)
            uimenu(gui.ViewMenu,'Label',demoList{num},'Callback',@onMenuSelection);
        end
   ...
   end
   
    function onMenuSelection(src,~)
        % User selected a demo from the menu - work out which one
        demoName = get(src,'Label');
        data.SelectedDemo = find(strcmpi(demoName,data.DemoNames),1,'first');
        updateInterface();
        redrawDemo();
    end
```

这里的`src`变量是一个`Menu`类型变量的handle.

接下来定义两个Help功能的回调函数：

```matlab
    function onHelp( ~, ~ )
        % User has asked for the documentation
        doc layout
    end
    
    function onDemoHelp( ~, ~ )
        % User wnats documentation for the current demo
        showdemo(data.DemoFunctions{data.SelectedDemo});
    end
```

最后是File菜单下`Exit`选项的回调函数：

```matlab
    function onExit( ~, ~ )
        % User wants to quit out of the application
        delete(gui.Window);
    end
```

这些回调函数的定义都很简单，这里就不再介绍。

<br>

# Scalability

依据上面的步骤，就完成了GUI设计的全部工作。但是，工具箱Documentation的最后也指出，这里使用的简单的编程结构不是适用于大型的应用，并且推荐了一些参考的调整：

- Convert the "data" structure into a handle object. This allows a single "data" object to be shared between mutliple graphical interfaces, and in turn means that the interface need not be built as a single monolithic entity.
- Use the events system to trigger updates to specific parts of the GUI in response to bits of the data object changing. This removes the need for a single large "UpdateInterface" function and reduces coupling between parts of the interface. For example, the "SelectedDemo" property would have an associated event such that when it is changed by a callback (or from the command-line) it notifies other interface components of the change. Each interface component (or group thereof) can just listen for the events that affect it.

面向对象的编程模式更适合于大型GUI应用的编写。

<br>

# Appendix

```matlab
function main()
%demoBrowser: an example of using layouts to build a user interface
%
%   demoBrowser() opens a simple GUI that allows several of MATLAB's
%   built-in demos to be viewed. It aims to demonstrate how multiple
%   layouts can be used to create a good-looking user interface that
%   retains the correct proportions when resized. It also shows how to
%   hook-up callbacks to interpret user interaction.
%
%   See also: <a href="matlab:doc Layouts">Layouts</a>

%  Copyright 2009-2020 The MathWorks, Inc.

% Data is shared between all child functions by declaring the variables
% here (they become global to the function). We keep things tidy by putting
% all GUI stuff in one structure and all data stuff in another. As the app
% grows, we might consider making these objects rather than structures.

data = createData();
gui = createInterface(data.DemoNames);
updateInterface()
redrawDemo()

% Explicitly call the demo display so that it gets included if we deploy
displayEndOfDemoMessage('')

    function data = createData()
        % Create the shared data-structure for this application
        demoList = {
            'Complex surface'            'cplxdemo'
            'Cruller'                    'cruller'
            'Earth'                      'earthmap'
            'Four linked tori'           'tori4'
            'Klein bottle'               'xpklein'
            'Klein bottle (1)'           'klein1'
            'Knot'                       'knot'
            'Logo'                       'logo'
            'Spherical Surface Harmonic' 'spharm2'
            'Werner Boy''s Surface'      'wernerboy'
            };
        selectedDemo = 8;
        data = struct( ...
            'DemoNames', {demoList(:,1)'}, ...
            'DemoFunctions', {demoList(:,2)'}, ...
            'SelectedDemo', selectedDemo);
    end

    function gui = createInterface(demoList)
        % Create the user interface for the application and return a
        % structure of handles for global use.
        gui = struct();

        % Open a window and add some menus
        gui.Window = figure( ...
            'Name', 'Gallery browser', ...
            'NumberTitle', 'off', ...
            'MenuBar', 'none', ...
            'Toolbar', 'none', ...
            'HandleVisibility', 'off' );

        % + File menu
        gui.FileMenu = uimenu(gui.Window,'Label','File');
        uimenu(gui.FileMenu,'Label','Exit','Callback',@onExit);

        % + View menu
        gui.ViewMenu = uimenu(gui.Window,'Label','View');
        for num = 1:numel(demoList)
            uimenu(gui.ViewMenu,'Label',demoList{num},'Callback',@onMenuSelection);
        end

        % + Help menu
        helpMenu = uimenu(gui.Window,'Label','Help');
        uimenu(helpMenu,'Label','Documentation','Callback',@onHelp);

        % Arrange the main interface
        mainLayout = uix.HBoxFlex('Parent',gui.Window,'Spacing',3);

        % + Create the panels
        controlPanel = uix.BoxPanel( ...
            'Parent',mainLayout, ...
            'Title','Select a demo:' );
        gui.ViewPanel = uix.BoxPanel( ...
            'Parent',mainLayout, ...
            'Title','Viewing: ???', ...
            'HelpFcn',@onDemoHelp);
        gui.ViewContainer = uicontainer( ...
            'Parent',gui.ViewPanel);

        % + Adjust the main layout
        set(mainLayout,'Widths',[-1,-2]);

        % + Create the controls
        controlLayout = uix.VBox('Parent',controlPanel, ...
            'Padding',3,'Spacing',3);
        gui.ListBox = uicontrol('Style','list', ...
            'BackgroundColor','w', ...
            'Parent',controlLayout, ...
            'String',demoList(:), ...
            'Value',1, ...
            'Callback',@onListSelection);
        gui.HelpButton = uicontrol('Style','PushButton', ...
            'Parent',controlLayout, ...
            'String', 'Help for <demo>', ...
            'Callback', @onDemoHelp);
        set(controlLayout,'Heights',[-1 28]); % Make the list fill the space

        % + Create the view
        gui.ViewAxes = axes('Parent',gui.ViewContainer);
    end

    function updateInterface()
        % Update various parts of the interface in response to the demo
        % being changed.

        % Update the list and menu to show the current demo
        set(gui.ListBox,'Value',data.SelectedDemo);

        % Update the help button label
        demoName = data.DemoNames{data.SelectedDemo};
        set(gui.HelpButton,'String',['Help for ',demoName]);

        % Update the view panel title
        set(gui.ViewPanel,'Title',sprintf('Viewing: %s',demoName));

        % Untick all menus
        menus = get(gui.ViewMenu,'Children');
        set(menus,'Checked','off');
        % Use the name to work out which menu item should be ticked
        whichMenu = strcmpi(demoName,get(menus,'Label'));
        set(menus(whichMenu),'Checked','on');
    end

    function redrawDemo()
        % Draw a demo into the axes provided
        % We first clear the existing axes ready to build a new one
        if ishandle(gui.ViewAxes)
            delete(gui.ViewAxes);
        end

        % Some demos create their own figure. Others don't.
        fcnName = data.DemoFunctions{data.SelectedDemo};
        switch upper(fcnName)
            case 'LOGO'
                % These demos open their own windows
                evalin('base', fcnName);% Evaluate MATLAB expression in specified workspace
                gui.ViewAxes = gca();
                fig = gcf();
                set(fig,'Visible','off');
            otherwise
                % These demos need a window opening
                fig = figure('Visible','off');
                evalin('base',fcnName);
                gui.ViewAxes = gca();
        end
        % Now copy the axes from the demo into our window and restore its
        % state.
        cmap = colormap(gui.ViewAxes);
        set(gui.ViewAxes,'Parent',gui.ViewContainer);
        colormap(gui.ViewAxes,cmap);
        rotate3d(gui.ViewAxes,'on');
        % Get rid of the demo figure
        close(fig);
    end

    function onListSelection(src,~)
        % User selected a demo from the list - update "data" and refresh
        data.SelectedDemo = get(src,'Value');
        updateInterface();
        redrawDemo();
    end

    function onMenuSelection(src,~)
        % User selected a demo from the menu - work out which one
        demoName = get(src,'Label');
        data.SelectedDemo = find(strcmpi(demoName,data.DemoNames),1,'first');
        updateInterface();
        redrawDemo();
    end

    function onHelp( ~, ~ )
        % User has asked for the documentation
        doc layout
    end

    function onDemoHelp( ~, ~ )
        % User wnats documentation for the current demo
        showdemo(data.DemoFunctions{data.SelectedDemo});
    end

    function onExit( ~, ~ )
        % User wants to quit out of the application
        delete(gui.Window);
    end
end
```























