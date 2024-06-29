---
layout: single
title: An Error about Lacking `"ps4000aWrap.dll"` File while Connecting PicoScope 4824A in MATLAB
date: 2023-05-22 17:29:23 +0800
categories: 
 - MATLAB
tags: 
 - Experiment
 - MATLAB Instrument Control Toolbox
 - MATLAB Warnings and Errors
toc: false
---

博客 [1,2,3] 展示了如何使用MATLAB建立与PicoScope 4824A采集卡的连接并收集数据。想要实现这一功能，需要在MATLAB的Add-on中下载并安装Instrument Control Toolbox，PicoScope Support Toolbox，以及适配PicoScope 4824A的驱动：PicoScope 4000 Series A API MATLAB Generic Instrument Driver。但是，我在一台新的电脑上安装这些工具箱后运行程序时出现了这样的报错：

```
Warning: Disconnect: No devices found. 
Error using icdevice
An error occurred while executing the driver create code.
There was an error loading the library "ps4000aWrap.dll"
找不到指定的模块。
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/b307435ba1c307fb61125dc5.png?raw=true" alt="b307435ba1c307fb61125dc5" style="zoom: 33%;" />

在网上找了很久也没有找到相关的解决方案，有的方法很复杂也无济于事（例如 [4]）。但最后解决的也非常简单，就是下载缺少的文件即可：下载picosdk-c-wrappers-binaries仓库 [5]，将其中的`Windows 64-bit`文件夹中的`ps4000aWrap.dll`和`ps4000aWrap.lib`文件放在MATLAB的搜索目录下。以上就解决了这个报错\~\~\~

<br>

**References**

[1] [Connecting PicoScope 4824A in MATLAB - What a starry night~](http://ma1017.github.io/matlab/Connecting-PicoScope-4824A-in-MATLAB/).

[2] [Collecting Streaming Data in MATLAB via PicoScope 4824A - What a starry night~](http://ma1017.github.io/matlab/Collecting-Streaming-Data-in-MATLAB-via-PicoScope-4824A/).

[3] [Collecting Block Data in MATLAB via PicoScope 4824A - What a starry night~](http://ma1017.github.io/matlab/Collecting-Block-Data-in-MATLAB-via-PicoScope-4824A/).

[4] [How can i set up my Picoscope Device in Instrument Control Toolbox? - MATLAB Answers](https://ww2.mathworks.cn/matlabcentral/answers/268391-how-can-i-set-up-my-picoscope-device-in-instrument-control-toolbox).

[5] [picotech/picosdk-c-wrappers-binaries: Binaries versions of wrapper library projects for PicoScope® oscilloscope products](https://github.com/picotech/picosdk-c-wrappers-binaries).
