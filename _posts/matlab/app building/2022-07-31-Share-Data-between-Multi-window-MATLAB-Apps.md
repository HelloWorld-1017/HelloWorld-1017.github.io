---
title: Share Data between Multi-window MATLAB Apps
categories: 
 - MATLAB
tags:
 - MATLAB App Building
date: 2022-07-31 22:04:04 +0800
last_modified_at: 2024-10-23 19:05:16 +0800
---

# Introduction

[**Share Data in Multiwindow Apps**](https://ww2.mathworks.cn/help/matlab/creating_guis/multiwindow-app-gui-in-app-designer.html)

This example shows how to pass data from one app to another. This multiwindow app consists of **(1) a main app** that calls **(2) a dialog box app** with input arguments. The dialog box displays a set of options for modifying aspects of the main app. When the user closes it, the dialog box sends their selections back to the main app.

This example demonstrates the following app building tasks:

- Calling an app with input arguments

- Calling an app with a return argument that is the app object

- Passing values to an app by calling a public function in the app

- Writing `CloseRequestFcn` callbacks to perform maintenance tasks when each app closes

Copyright 2018 The MathWorks, Inc.

该示例来自MATLAB官方网站。一共有两个app，分别是 MainAppExample.mlapp 和 DialogAppExample.mlapp。在下文中，两个.mlapp代码分别在两个一级标题下完整给出，每个一级标题中的二级标题分别代表**类**的一部分属性或方法的实现，其中带  的二级标题是最具有差异和值得重点关注的部分。

<br>

# (I) MainAppExample.mlapp

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220731172154853.png?raw=true" alt="image-20220731172154853" style="zoom: 50%;" />

定义继承自 matlab.apps.AppBase 的子类 MainAppExample：

```matlab
classdef MainAppExample < matlab.apps.AppBase
	...
end
```

MainAppExample 类主要以下几部分属性和方法：

## （1）共有属性：组件

```matlab
    % Properties that correspond to app components
    properties (Access = public)
        UIFigure       matlab.ui.Figure
        OptionsButton  matlab.ui.control.Button
        UIAxes         matlab.ui.control.UIAxes
    end
```



## （2） 私有属性：DialogApp, 设置初始值

```matlab
    properties (Access = private)
        DialogApp                   % Dialog box app
        CurrentSize = 35;           % Surface sample size
        CurrentColormap = 'Parula'; % Colormap
    end
```





## （3）公有方法：updateplot

```matlab
    methods (Access = public)
        function updateplot(app, sz, c)
            % Store inputs as properties
            app.CurrentSize = sz;
            app.CurrentColormap = c;
            
            % Update plot 
            Z = peaks(sz);
            surf(app.UIAxes,Z);
            colormap(app.UIAxes,c);
            
            % Re-enable the Plot Options button
            app.OptionsButton.Enable = 'on';
        end
    end
```





## （4）私有方法：startupFcn, OptionButtonPushed, MainAppCloseRequest

```matlab
    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            % Call updateplot to display an initial plot
            updateplot(app, app.CurrentSize, app.CurrentColormap)
        end

        % Button pushed function: OptionsButton
        function OptionsButtonPushed(app, event)
            % Disable Plot Options button while dialog is open
            app.OptionsButton.Enable = 'off';
            
            % Open the options dialog and pass inputs
            app.DialogApp = DialogAppExample(app, app.CurrentSize, app.CurrentColormap);
        end

        % Close request function: UIFigure
        function MainAppCloseRequest(app, event)
            % Delete both apps
            delete(app.DialogApp)
            delete(app)
        end
```

### startupFcn

在启动 MainAppExample 时，App 会首先调用 `startupFcn(app)` 函数，根据 `app.CurrentSize` 和 `app.CurrentColormap` 的初始化值，调用 `updateplot(app, sz, c)` 函数绘制图像。



### OptionsButtonPushed

当点击 Options 按钮时，软件会执行 `OptionsButtonPushed` 回调函数，首先禁用掉 Options 按钮，之后弹出 DialogAppExample App

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220731212300394.png?raw=true" style="zoom:50%;" />

```matlab
app.DialogApp = DialogAppExample(app, app.CurrentSize, app.CurrentColormap);
```

其中，`DialogAppExample` 是所调用对话框 App 的类名，也是.mlapp的文件名；

`app.DialogApp`, ` app.CurrentSize`，`app.CurrentColormap` 均在（2）私有属性中有所声明。



### MainAppCloseRequest

`MainAppCloseRequest` 函数定义了关掉主 app 时的行为：当关掉主程序时，同时删除对话框程序。



## （5）私有方法：UIFigure 和 components 的初始化

```matlab
    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 449 370];
            app.UIFigure.Name = 'Display Plot';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @MainAppCloseRequest, true);

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            app.UIAxes.XTickLabelRotation = 0;
            app.UIAxes.YTickLabelRotation = 0;
            app.UIAxes.ZTickLabelRotation = 0;
            app.UIAxes.Position = [56 64 341 267];

            % Create OptionsButton
            app.OptionsButton = uibutton(app.UIFigure, 'push');
            app.OptionsButton.ButtonPushedFcn = createCallbackFcn(app, @OptionsButtonPushed, true);
            app.OptionsButton.Position = [176 20 100 22];
            app.OptionsButton.Text = 'Options';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end
```



## （6）公有方法：构建 app、删除 app

```matlab
    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = MainAppExample

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
```

<br>

# (II) DialogAppExample.mlapp

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220731172122056.png?raw=true" alt="image-20220731172122056" style="zoom:67%;" />

定义继承自 matlab.apps.AppBase 的子类 DialogAppExample：

```matlab
classdef DialogAppExample < matlab.apps.AppBase
...
end
```



## （1）共有属性：组件

```matlab
    properties (Access = public)
        UIFigure                  matlab.ui.Figure
        Button                    matlab.ui.control.Button
        DropDown                  matlab.ui.control.DropDown
        ColormapDropDownLabel     matlab.ui.control.Label
        EditField                 matlab.ui.control.NumericEditField
        SampleSizeEditFieldLabel  matlab.ui.control.Label
    end
```





## （2）私有属性：CallingApp

```matlab
    properties (Access = private) 
        CallingApp   % Main app object
    end
```





## （3）私有方法：StartupFcn, ButtonPushed, DialogAppCloseRequest

```matlab
    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function StartupFcn(app, mainapp, sz, c)
            % Store main app in property for CloseRequestFcn to use
            app.CallingApp = mainapp;
            
            % Update UI with input values
            app.EditField.Value = sz;
            app.DropDown.Value = c;
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            % Call main app's public function
            updateplot(app.CallingApp, app.EditField.Value, app.DropDown.Value);
            
            % Delete the dialog box
            delete(app)
        end

        % Close request function: UIFigure
        function DialogAppCloseRequest(app, event)
            % Enable the Plot Opions button in main app
            app.CallingApp.OptionsButton.Enable = 'on';
            
            % Delete the dialog box 
            delete(app)   
        end
    end
```

### StartupFcn

当主 app 使用代码

  ```matlab
  app.DialogApp = DialogAppExample(app, app.CurrentSize, app.CurrentColormap);
  ```

 调用对话框 app 时，程序首先会调用  DialogAppExample 的 `StartupFcn()` 函数。

  因此，将主 app 调用代码和 DialogAppExample 的 `StartupFcn()` 函数放在一起，有助于理解调用与函数参数之间的对应关系

  ```matlab
  % Call
  app.DialogApp = DialogAppExample(app, app.CurrentSize, app.CurrentColormap);
  
  % Function
  StartupFcn(app, mainapp, sz, c)
  ```

当调用对话框 app 时，主程序首先会将 `app.CurrentSize` 和 `app.CurrentColormap` 属性分别传递给对话框 app 的可编辑文本和下拉菜单的值：

  ```
  % Update UI with input values
  app.EditField.Value = sz;
  app.DropDown.Value = c;
  ```

### ButtonPushed

回调函数 `ButtonPushed()` 是 DialogAppExample 中 OK 按钮的回调函数。当点击 OK 按钮时，回调函数 `ButtonPushed()` 会调用主 app 的 `updateplot(app, sz, c)` ⭐**公用方法**⭐，更新主 app 中的图像，并删除对话框程序。

### DialogAppCloseRequest

`DialogAppCloseRequest` 函数定义了关掉对话框 app 时的行为：当关掉对话框 app 时，恢复主 app 的 Options 按钮，删除对话框 app。



## （4）私有方法：UIFigure 和 components 的初始化

```matlab
    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)
            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [600 100 392 248];
            app.UIFigure.Name = 'Options';
            app.UIFigure.CloseRequestFcn = createCallbackFcn(app, @DialogAppCloseRequest, true);

            % Create SampleSizeEditFieldLabel
            app.SampleSizeEditFieldLabel = uilabel(app.UIFigure);
            app.SampleSizeEditFieldLabel.HorizontalAlignment = 'right';
            app.SampleSizeEditFieldLabel.VerticalAlignment = 'top';
            app.SampleSizeEditFieldLabel.Position = [102 160 74 15];
            app.SampleSizeEditFieldLabel.Text = 'Sample Size';

            % Create EditField
            app.EditField = uieditfield(app.UIFigure, 'numeric');
            app.EditField.Limits = [2 1000];
            app.EditField.Position = [191 156 100 22];
            app.EditField.Value = 35;

            % Create ColormapDropDownLabel
            app.ColormapDropDownLabel = uilabel(app.UIFigure);
            app.ColormapDropDownLabel.HorizontalAlignment = 'right';
            app.ColormapDropDownLabel.VerticalAlignment = 'top';
            app.ColormapDropDownLabel.Position = [117 106 59 15];
            app.ColormapDropDownLabel.Text = 'Colormap';

            % Create DropDown
            app.DropDown = uidropdown(app.UIFigure);
            app.DropDown.Items = {'Parula', 'Jet', 'Winter', 'Cool'};
            app.DropDown.Position = [191 102 100 22];
            app.DropDown.Value = 'Parula';

            % Create Button
            app.Button = uibutton(app.UIFigure, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.Position = [116 43 174 22];
            app.Button.Text = 'OK';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

```



## （5）共有方法：构建 app、删除 app

```matlab
% App creation and deletion
    methods (Access = public)

        % Construct app
        function app = DialogAppExample(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)StartupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
```

<br>

# private function vs. public function

在上述过程中，我们可以看到对话框 app 调用了主 app 的 `updateplot()` 方法，这是可行的，因为主 app 中所定义的 `updateplot()` 方法是一个 public function

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220731222002303.png?raw=true" alt="image-20220731222002303" style="zoom: 67%;" />

public function 主要用于多窗口的 app ，以减少代码的冗余，具体的信息可以查看文档： [Reuse Code Using Helper Functions](https://ww2.mathworks.cn/help/matlab/creating_guis/code-and-call-app-functions-in-app-designer.html)。

<br>

# Conclusion

制作这种多窗口的 app，重点就在于做好三个方面的代码实现 $^{[2]}$ ：

- 主 app 传递参数给对话框 app：写好主 app 的调用函数，以及对话框 app 的  `StartupFcn()` 函数
- 对话框 app 返回信息给主 app
- 定义主 app 和对话框 app 关闭时的行为



> 注意 $^{[2]}$ ：
>
> If you plan to deploy your app as a web app (requires MATLAB® Compiler™), **creating multiple app windows** is not supported. Instead, consider **creating a single-window app with multiple tabs.** For more information, see [Web App Limitations and Unsupported Functionality](https://ww2.mathworks.cn/help/compiler/webapps/unsupported-functionality.html) (MATLAB Compiler).

<br>

**References**

[1] [Share Data in Multiwindow Apps - MATLAB Documentation.](https://ww2.mathworks.cn/help/matlab/creating_guis/multiwindow-app-gui-in-app-designer.html)

[2] [Create Multiwindow Apps in App Designer - MATLAB Documentation.](https://ww2.mathworks.cn/help/matlab/creating_guis/creating-multiwindow-apps-in-app-designer.html#mw_a0e1779a-a8a5-4114-a1f2-f82a6d1960c7)

[3] [Startup Tasks and Input Arguments in App Designer - MATLAB Documentation.](https://ww2.mathworks.cn/help/matlab/creating_guis/app-designer-startup-function.html)

