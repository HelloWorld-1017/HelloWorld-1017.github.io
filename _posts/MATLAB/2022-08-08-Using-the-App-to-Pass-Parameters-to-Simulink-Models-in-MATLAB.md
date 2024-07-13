---
layout: single
title: Using the App to Pass Parameters to Simulink Models in MATLAB
date: 2022-08-08 11:50:23 +0800
categories:
 - MATLAB
tags: 
 - MATLAB App Building
toc: false
---
首先创建一个简单的 Simulink 模型 test_passVariables.slx，仅包含一个 Constant 模块和 Display 模块：

![image-20220808111745944](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808111745944.png?raw=true)

其中 Constant 模块的数值是由变量 `K` 定义：

![image-20220808111948609](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808111948609.png?raw=true)

<br>

创建一个简单的 App，test.mlapp，仅包含一个 Buttton：

![image-20220808112125498](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808112125498.png?raw=true)

回调函数为：

```matlab
% Button pushed function: Button
function ButtonPushed(app, event)
    model = uigetfile("*.slx");
    model = strsplit(model, '.');
    model = model{1};
    open_system(model);
    in = Simulink.SimulationInput(model);
    in = in.setVariable('K', 10);
    sim(in)
end
```

运行 App 并点击 “加载模型” 按钮，选中 test_passVariables.slx 文件后，开始运行：

![image-20220808112426409](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808112426409.png?raw=true)

得到预期效果。

<br>

⚠ **说明** ⚠

1. 虽然模型能够正常运行，但是 Simulink 模型中的 Constant 模块仍然会有 error

   <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808112607223.png?raw=true"/>

   这是因为变量 `K` 完全是由模型文件外的代码控制的，在 workspace 中并没有变量 `K` ，在模型的 `PreLoadFcn` 中也没有预先定义；

   

2. 按钮的回调函数中的变量 model 不能带有文件后缀 `.slx`。如果 `model = 'test_passVariables.slx'` ，虽然使用 `open_systme(model)` 不会报错，但是后续运行模型时会报错。比如，使用以下代码：

   ```matlab
   function ButtonPushed(app, event)
       model = uigetfile("*.slx");
       open_system(model);
       in = Simulink.SimulationInput(model);
       in = in.setVariable('K', 10);
       sim(in)
   end
   ```

   出现报错信息：

   ```matlab
   Error using test/ButtonPushed
   Invalid ModelName, 'test_passVariables.slx', specified in the SimulationInput object. ModelName must be a valid Simulink model
   name.
   
   Error in matlab.apps.AppBase>@(source,event)executeCallback(appdesigner.internal.service.AppManagementService.instance(),app,callback,requiresEventData,event) (line 63)
               newCallback = @(source, event)executeCallback(appdesigner.internal.service.AppManagementService.instance(), ...
    
   Error while evaluating Button PrivateButtonPushedFcn.
   ```

   <br>
   
   **References**
   
   [1] [setVariable - MathWorks](https://ww2.mathworks.cn/help/simulink/slref/setvariable.html).

