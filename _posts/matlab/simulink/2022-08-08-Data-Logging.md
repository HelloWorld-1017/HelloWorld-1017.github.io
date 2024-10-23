---
title: Set Signal Logging in MATLAB Simulink
categories:
 - MATLAB
tags: 
 - MATLAB Simulink
date: 2022-08-08 18:23:43 +0800
last_modified_at: 2024-10-23 18:59:28 +0800
---

# 使用 Simulink Toolstrip 设置 Signal Logging

[Configure a Signal for Logging: Enable Logging Using Simulink Toolstrip](https://ww2.mathworks.cn/help/simulink/ug/configuring-a-signal-for-signal-logging.html#bt0cx46)

创建 Simulink 模型：

![image-20220808173055995](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808173055995.png?raw=true)

模块 Sine Wave 和 Cosine Wave 模块的幅值分别由变量 `A1` 和 `A2` 控制，由后面的脚本控制：

![image-20220808173020969](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808173020969.png?raw=true)



![image-20220808173248240](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808173248240.png?raw=true)



选中需要记录的信号后，点击 Simulation tab 中的 Log signals

![image-20220808173322109](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808173322109.png?raw=true)

之后，可以在需要记录的信号上看到天线的标志：

![image-20220808173443074](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808173443074.png?raw=true)

之后 `Ctrl+E` 点开模型配置，确保勾选了 `Signal Logging`

![image-20220808172818967](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808172818967.png?raw=true)

点击后面的 Configure Signals to Logging Selector 按钮

![image-20220808172910387](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808172910387.png?raw=true)

可以进行信号属性的配置，包括设置 Signal name 等等

![image-20220808173702360](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808173702360.png?raw=true)

Apply 后 OK。

之后使用脚本 script1.m 设置变量 `A1` 和 `A2` 的值，并运行仿真。

```matlab
clc, clear
mdl = 'model';
open_system(mdl);
in = Simulink.SimulationInput(mdl);
in = in.setVariable('A1', 10);
in = in.setVariable('A2', 15);
out = sim(in);
```

在 `out.logsout` 中就保存着记录的两个信号：

![image-20220808174843260](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220808174843260.png?raw=true)

```matlab
>> out.logsout

ans = 

Simulink.SimulationData.Dataset 'logsout' with 2 elements

                         Name        BlockPath         
                         __________  _________________ 
    1  [1x1 Signal]      CosineWave  model/Cosine Wave
    2  [1x1 Signal]      SineWave    model/Sine Wave  

  - Use braces { } to access, modify, or add elements using index.
```



# 使用脚本设置 Signal Logging

设置 Signal Logging 的过程同样可以使用脚本来完成

[Configure a Signal for Logging: Programmatic Interface](https://ww2.mathworks.cn/help/simulink/ug/configuring-a-signal-for-signal-logging.html#bsw9nl4-3)

```matlab
clc, clear
mdl = 'model';
open_system(mdl);
in = Simulink.SimulationInput(mdl);
in = in.setVariable('A1', 10);
in = in.setVariable('A2', 15);

signal1 = get_param('model/Sine Wave','PortHandles');
set_param(signal1.Outport(1),'DataLogging','on')

signal2 = get_param('model/Cosine Wave','PortHandles');
set_param(signal2.Outport(1),'DataLogging','on')

out = sim(in);
```



```matlab
>> out.logsout

ans = 

Simulink.SimulationData.Dataset 'logsout' with 2 elements

                         Name  BlockPath         
                         ____  _________________ 
    1  [1x1 Signal]      ''    model/Cosine Wave
    2  [1x1 Signal]      ''    model/Sine Wave  

  - Use braces { } to access, modify, or add elements using index.
```

<br>

**参考**

[1] [Configure a Signal for Logging - MathWorks](https://ww2.mathworks.cn/help/simulink/ug/configuring-a-signal-for-signal-logging.html)