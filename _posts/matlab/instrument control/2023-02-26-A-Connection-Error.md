---
title: A Connection Error when Using MATLAB Instrument Control Toolbox
toc: false
categories: 
 - MATLAB
 - Windows
tags:
 - MATLAB Instrument Control Toolbox
 - Experiment
 - MATLAB Warnings and Errors
date: 2023-02-26 21:30:29 +0800
last_modified_at: 2024-10-23 19:45:55 +0800
---

最近在学习MATLAB与PicoScope采集卡的连接，想要直接将采集卡采集到的数据直接传输到MATLAB中显示并使用。如博客[^1]中介绍的，想要实现这一想法需要使用到：MATLAB Instrument Control Toolbox，PicoScope Support Toolbox和适配于PicoScope 4824A的PicoScope 4000 Series A API MATLAB Generic Instrument Driver。

但是在调试学习代码的过程中，有时候总是会出现下面的报错：

```
Warning: Disconnect: No devices found. 
Error using icdevice
An error occurred while executing the driver create code.
No devices found.
If the error is not an instrument error, use MIDEDIT
to inspect the driver.

Error in script1 (line 26)
ps4000aDeviceObj = icdevice('picotech_ps4000a_generic','ObjectVisibility','on');
```

该报错表明无法使用MATLAB Instrument Control Toolbox所提供的`icdevice`函数创建Device Object，此时无论再运行多少次代码都会出现这样的报错，此时只需要关闭掉MATLAB，重新进入再运行即可解决这样的报错。

<br>

但是我记得一开始采用关掉MATLAB再运行的方式是不解决不了的，再运行还是会出现这样的报错，必须重启计算机才能解决，因此就极其麻烦，于是我就尝试解决这个问题。

首先，在一般的流程下，MATLAB需要先创建Device Object，并与设备进行连接：

```matlab
...
ps4000aDeviceObj = icdevice('picotech_ps4000a_generic','ObjectVisibility','on'); 
connect(ps4000aDeviceObj);
...
```

最后，在代码的最后需要断开并删除与设备的连接：

```matlab
...
disconnect(ps4000aDeviceObj);
delete(ps4000aDeviceObj);
```

在经过一系列的尝试后发现，在调试的过程中，如果代码已经执行完连接步骤（即`connect(ps4000aDeviceObj);`），而没有进行断开操作（即`disconnect(ps4000aDeviceObj);`），而我们在此时终止了代码并重新运行，则代码在运行到`ps4000aDeviceObj = icdevice('picotech_ps4000a_generic','ObjectVisibility','on'); `时就会出现这样的报错。这样的情形相当于仍然有一个驱动在连接着设备，因此就不能再创建其他连接设备的驱动。**但是，如何找到这个连接着的驱动并将其断开呢？**因为之前的代码已经终止，而再重新运行代码的时候原来的变量也都删除了，这一目标就变得很困难。

首先我们模拟上面提到的中断代码的过程，并且清除掉工作空间中的所有变量：

![image-20230226203117055](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230226203117055.png?raw=true)

虽然看似把“连接”都删除掉了，但其实还在。此时在CMD中输入[^2][^3]：

```powershell
tasklist /v /fo csv>>d:\tasklist.csv
```

会在D盘的根目录下生成一个`tasklist.csv`文件，该文件中保存着计算机目前所运行的进程信息：

![image-20230226205729454](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230226205729454.png?raw=true)

我们在其可以看到这样一个MATLAB的进程，占用着18320 PID（Process Identification）：

![image-20230226210410055](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230226210410055.png?raw=true)

之后在任务管理器的`详细信息`中找到这一进程，将其关闭后再次进入MATLAB运行程序即可重新建立连接：

![image-20230226210607291](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230226210607291.png?raw=true)

虽然最后看起来很简单，就是在任务管理器中将MATLAB结束进程即可，甚至现在尝试的话，只需要关闭MATLAB重新进入运行就能接解决问题。但是，在寻找解决方案的过程中并不想这么顺利。

因为就像文章刚开始所说的那样，一开始直接关闭MATLAB程序是无法解决问题的，这可能是因为在某些情况下虽然我们关闭了MATLAB程序，但是实际的进程并没有被中断，仍然可以在任务管理器中找到。

**另外，为什么确定是要关闭MATLAB程序呢？**因为之前我在所导出的`tasklist.csv`中文件搜索`picoscope`关键词时，找到了一个窗口标题为`PicoScope ......`的进程，而该进程的映像名称就是`MATLAB.exe`，我将其关闭后就解决了问题；现在再尝试时，`MATLAB.exe`所对应的窗口标题就是`MATLAB R2022a - acdemic use`，尽管如此，我将该进程关闭后依然有用。

总之，之前建立的驱动连接就保存在MATLAB软件中，无论是重启计算机，还是直接关闭软件，亦或是在任务管理器中将进程关闭，只要保证将MATLAB软件完全关闭，原先建立的连接就能够完全删除，再次运行程序就可以重新建立与设备的连接。

<br>

# References

[^1]: [Connecting PicoScope 4824A in MATLAB - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-02-22/20-41-42.html).
[^2]: [使用tasklist将任务管理器的进程导出-百度经验](https://jingyan.baidu.com/article/148a1921f2e8f94d71c3b1d0.html).
[^3]: [tasklist - Microsoft Learn](https://learn.microsoft.com/zh-cn/windows-server/administration/windows-commands/tasklist).