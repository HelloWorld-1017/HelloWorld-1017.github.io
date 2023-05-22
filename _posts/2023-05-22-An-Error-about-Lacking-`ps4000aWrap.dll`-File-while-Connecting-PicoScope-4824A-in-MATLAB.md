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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/b307435ba1c307fb61125dc5.png" alt="b307435ba1c307fb61125dc5" style="zoom: 33%;" />

在网上找了很久也没有找到相关的解决方案，有的方法很复杂也无济于事。但最后解决的也非常简单，就是下载缺少的文件即可：下载picosdk-c-wrappers-binaries仓库 [4]，将其中的`Windows 64-bit`文件夹中的`ps4000aWrap.dll`和`ps4000aWrap.lib`文件放在MATLAB的搜索目录下。以上就解决了这个报错\~\~\~

<br>

**References**

[1] [Connecting PicoScope 4824A in MATLAB - What a starry night~](http://whatastarrynight.com/matlab/Connecting-PicoScope-4824A-in-MATLAB/).

[2] [Collecting Streaming Data in MATLAB via PicoScope 4824A - What a starry night~](http://whatastarrynight.com/matlab/Collecting-Streaming-Data-in-MATLAB-via-PicoScope-4824A/).

[3] [Collecting Block Data in MATLAB via PicoScope 4824A - What a starry night~](http://whatastarrynight.com/matlab/Collecting-Block-Data-in-MATLAB-via-PicoScope-4824A/).

[4] [picotech/picosdk-c-wrappers-binaries: Binaries versions of wrapper library projects for PicoScope® oscilloscope products](https://github.com/picotech/picosdk-c-wrappers-binaries).
