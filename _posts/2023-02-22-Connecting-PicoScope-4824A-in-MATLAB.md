---
layout: single
title: Connecting PicoScope 4824A in MATLAB
date: 2023-02-22 20:41:42 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Instrument Control Toolbox
 - Experiment
---

# Introduction

Pico公司在Github中提供了在MATLAB中连接PicoScope产品的驱动以及相关的示例，不同系列的示波器的调用接口也不同。适配PicoScope 4824A的驱动见：[PicoScope 4000 Series A API MATLAB Generic Instrument Driver - Github](https://github.com/picotech/picosdk-ps4000a-matlab-instrument-driver)。这个驱动可以直接在MATLAB Add-Ons中直接下载。

![image-20230222163859156](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222163859156.png?raw=true)

使用该Driver需要提前在MATLAB中安装：Instrument Control Toolbox，PicoScope Support Toolbox. 这两个工具箱同样可以在MATLAB Add-Ons中进行下载。

下载 PicoScope 4000 Series A API MATLAB Generic Instrument Driver 后，其文件夹中包含这些文件：

![image-20230222164455771](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222164455771.png?raw=true)

在根文件中主要包含一个定义的类`PS4000aConstants.m`，一个函数文件`ps4000aSetConfig.m`和一个脚本文件`PS4000aConfig.m`，和一个MDD类型的文件`picotech_ps4000a_generic.mdd`。另外，还包含一个`exmaples`文件夹，提供了一些使用驱动的示例。

<br>

# Examples

`examples`文件夹中包含了六个使用驱动的示例。其实现的功能和运行的结果分别如下所示。

注：在运行下面示例的时候，仅仅是将Pico采集卡与笔记本相连，各通道均没有连接传感器，收集到的信号都是噪声信号。
{: .notice--warning}

## `PS4000A_ID_Block_Adv_Trigger_PWQ_Example.m`

> Demonstrates how to call Instrument Driver functions in order to capture **a block of data** using advanced **trigger functions** with a **pulse width qualifier**.

![image-20230222171105520](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222171105520.png?raw=true)

## `PS4000A_ID_Block_Example.m`

> Demonstrates how to call Instrument Driver functions in order to capture **a block of data** from a PicoScope 4000 Series oscilloscope.

![image-20230222171203084](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222171203084.png?raw=true)



## `PS4000A_ID_Block_FFT_Example.m`

> Demonstrates how to call Instrument Driver functions in order to capture **a block of data** from a PicoScope 4000 Series oscilloscope. A **Fast Fourier Transform (FFT)** is then applied to the data collected on channel A.

![pic1](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/pic1.png?raw=true)

## `PS4000A_ID_Rapid_Block_Plot3D_Example.m`

> Demonstrates how to call Instrument Driver functions in order to capture **data in rapid block mode** from a PicoScope 4000 Series oscilloscope.

![image-20230222172017745](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222172017745.png?raw=true)

## `PS4000A_ID_Sig_Gen_Example.m`

> Demonstrates how to call Instrument Driver functions in order to **control the signal generator output** (where available) of a PicoScope 4000 Series oscilloscope.

这个示例需要使用到PicoScope背面的信号输出端口：

![image-20230222173012453](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222173012453.png?raw=true) 

代码的备注提到示波器的输出端口可以与另一个PicoScope相连，就可以在软件中显示相应波形：

> For this example the 'Gen' output of the oscilloscope was connected to Channel A on **another** PicoScope oscilloscope running the PicoScope 6 software application. Images, where shown, depict output, or part of the output in the PicoScope 6 display.

但实际上，一个PicoScope的Gen端口可以直接与前面的采集端口直接相连。因此，通过一个BNC接线就可以将这个示例与其他的示例联合起来使用。

> The **various signal generator functions** called in this script may be combined with the functions used in the **various data acquisition examples** in order to output a signal and acquire data. <u>The functions to setup the signal generator should be called prior to the start of data collection.</u>

## `PS4000A_ID_Streaming_Example.m`

> Demonstrates how to call functions in order to capture data in **streaming mode** from a PicoScope 4000 Series oscilloscope.

![image-20230222192050051](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222192050051.png?raw=true)

在运行的过程中，会跳出一个弹框，询问是否实时显示streaming data：

![image-20230222192035899](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222192035899.png?raw=true)

若选择是，则会在另一个窗口动态地绘制出信号变化的过程：

![image-20230222192231616](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222192231616.png?raw=true)

<br>

# Create a device object & Connect to the instrument

在所有的示例文件中，前两步都是固定的，分别是Create a device object 和 Connect to the instrument. 

## Create a device object

### Load configuration information

在创建对象时，首先需要加载配置信息：设置路径并加载struct和enumeration信息。

```matlab
%% Load configuration information
% Setup paths and also load struct and enumeration information. Enumeration
% values are required for certain function calls.
[ps4000aStructs, ps4000aEnuminfo] = ps4000aSetConfig(); % DO NOT EDIT THIS LINE.
```

`ps4000aSetConfig()`函数就是前面提到的在根文件夹中定义的那个函数。该函数的作用是将prototype files文件加载到MATLAB的工作空间中，以供Instrument Driver `picotech_ps4000a_generic.mdd`获取信息。不同的平台导入的信息是不一样的。

> This function allows the information from the prototype files to be loaded into the workspace that the picotech_ps4000a_generic.mdd Instrument Driver is accessed from. 
>
> Configures paths according to platforms and loads information from prototype files for PicoScope 4000 Series Oscilloscopes using the functions from the ps4000a/libps4000a shared library. The folder that this file is located in must be added to the MATLAB path.

路径和文件应该是保存在Pico所提供的SDK中：

> Platform Specific Information:-
>
> Microsoft Windows: Download the Software Development Kit installer from the [Pico Technology Download software and manuals for oscilloscopes and data loggers](https://www.picotech.com/downloads) page.

注释也特别提醒"DO NOT EDIT THIS LINE."，只需要在连接设备前调用即可：

> Run this script (`ps4000aSetConfig.m`) in the MATLAB environment prior to connecting to the  device.

如果有特殊需要的话，用户可以修改`ps4000aSetConfig.m`文件：

> This file (`ps4000aSetConfig.m`) can be edited to suit application requirements.

在执行完上面那行代码后，在工作空间中会出现两个结构体`ps4000aEnuminfo`和`ps4000aStructs`；这两个结构体里面同样嵌套着很多结构体，里面保存着大量的定义好的常量。

### Check before connection

在创建device object `ps4000aDeviceObj`前，需要先检查Instrument session是否仍然处于open的状态，如果处于open的状态，则会弹出这样一个弹窗：

![image-20230222193115369](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222193115369.png?raw=true)

如果选择`Yes`，则会先关闭session，然后再运行后面的代码；如果选择了`No`，则会调出脚本文件，不会再执行后面的代码。

在所有的示例文件中，在代码的最后都会断开并删除session：

```matlab
%% Disconnect device
% Disconnect device object from hardware.
disconnect(ps4000aDeviceObj);
delete(ps4000aDeviceObj);
```

因此，一般情况下不会弹出这个对话框。

这部分实现的代码是：

```matlab
% Check if an Instrument session using the device object 'ps4000aDeviceObj'
% is still open, and if so, disconnect if the User chooses 'Yes' when prompted.
if (exist('ps4000aDeviceObj', 'var') && ps4000aDeviceObj.isvalid && strcmp(ps4000aDeviceObj.status, 'open'))
    openDevice = questionDialog(['Device object ps4000aDeviceObj has an open connection. ' ...
        'Do you wish to close the connection and continue?'], ...
        'Device Object Connection Open');
    if (openDevice == PicoConstants.TRUE)
        % Close connection to device
        disconnect(ps4000aDeviceObj);
        delete(ps4000aDeviceObj);
    else
        % Exit script if User 
        return
    end
end
```

逻辑也比较清晰。

### Create a device object

之后创建Device oject：

```matlab
% Create a device object. 
% The serial number can be specified as a second input parameter.
ps4000aDeviceObj = icdevice('picotech_ps4000a_generic.mdd', '');
```

`icdevice`函数是MATLAB Instrument Control Toolbox 的内置函数：[icdevice - MathWorks](https://ww2.mathworks.cn/help/instrument/icdevice.html). 参数`'picotech_ps4000a_generic.mdd'`就是一个instrument driver，同样定义在工具箱的根文件夹中。打开picotech_ps4000a_generic.mdd`文件，会弹出下面的页面：

![image-20230222201027864](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222201027864.png?raw=true)

里面是关于Pico所定义的这个驱动的相关信息。

运行代码`ps4000aDeviceObj = icdevice('picotech_ps4000a_generic.mdd', '');`后，此时工作空间中多出了一个`ps4000aDeviceObj`的`icdevice`类的变量。双击该变量，则会弹出页面：

![image-20230222201536141](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230222201536141.png?raw=true)

在命令行中也会打印出一些关于Device object的说明信息：

```
PicoScope 4000 Series (A API) MATLAB Instrument Driver

Copyright © 2014-2019 Pico Technology Ltd. All rights reserved.

   Instrument Device Object Using Driver : picotech_ps4000a_generic.mdd
 
   Instrument Information
      Type:               Oscilloscope
      Manufacturer:       Pico Technology Ltd.
      Model:              PicoScope 4000 Series (A API)
 
   Driver Information
      DriverType:         MATLAB generic
      DriverName:         picotech_ps4000a_generic.mdd
      DriverVersion:      1.2.16.10
 
   Communication State
      Status:             closed

Number of units found: 1

Serial number(s): JW851/0014
```

## Connect to the instrument

在创建完Device object后就可以使用connect函数（[connect - MathWorks](https://ww2.mathworks.cn/help/instrument/connect.html)）连接硬件了：

```matlab
% Connect device object to hardware.
connect(ps4000aDeviceObj);
```

当执行完成后就会在命令行中打印连接的信息：

```
Serial number(s): JW851/0014

Opening PicoScope 4000 Series (A API) device...

   Instrument Device Object Using Driver : picotech_ps4000a_generic.mdd
 
   Instrument Information
      Type:               Oscilloscope
      Manufacturer:       Pico Technology Ltd.
      Model:              PicoScope 4000 Series (A API)
 
   Driver Information
      DriverType:         MATLAB generic
      DriverName:         picotech_ps4000a_generic.mdd
      DriverVersion:      1.2.16.10
 
   Communication State
      Status:             open

Setting Device Parameters...

Default Channel Setup:-
-----------------------

Channel A:-
	Enabled: True
	Coupling: DC
	Range: 5V
	Analog Offset: 0.0V

Channel B:-
	Enabled: True
	Coupling: DC
	Range: 5V
	Analog Offset: 0.0V

Channel C:-
	Enabled: True
	Coupling: DC
	Range: 5V
	Analog Offset: 0.0V

Channel D:-
	Enabled: True
	Coupling: DC
	Range: 5V
	Analog Offset: 0.0V

Channel E:-
	Enabled: True
	Coupling: DC
	Range: 5V
	Analog Offset: 0.0V

Channel F:-
	Enabled: True
	Coupling: DC
	Range: 5V
	Analog Offset: 0.0V

Channel G:-
	Enabled: True
	Coupling: DC
	Range: 5V
	Analog Offset: 0.0V

Channel H:-
	Enabled: True
	Coupling: DC
	Range: 5V
	Analog Offset: 0.0V

Default Block mode parameters:-

               Timebase index : 79
                 Time Interval: 1000.0 ns
 Number of pre-trigger samples: 0
Number of post-trigger samples: 1000000
       Total number of samples: 1000000

Default Streaming mode parameters:-

 Streaming interval: 1.00e-06 s
Streaming auto stop: 1

Default Signal generator parameters:-

      Start frequency: 1000 Hz
       Stop frequency: 1000 Hz
       Offset voltage: 0 mV
 Peak to Peak voltage: 2000 mV
Initialization complete.

Connected to PicoScope 4000 Series (A API) device:-

      Instrument Model: 4824A
   Batch/Serial Number: JW851/0014
       Analog Channels: 8
             Bandwidth: 20 MHz
         Buffer memory: 256 MS
 Maximum sampling rate: 80 MS/s
 Signal Generator Type: Arbitrary Waveform Generator
```

主要包含：

- 更新后的Device object信息；
- 默认Channel设置；
- 默认Block mode参数；
- 默认Streaming mode参数；
- 默认Signal generator参数；
- 以及硬件参数；

<br>

# Disconnect  Device

在使用完通信功能后，需要关闭并删除Device object：

```matlab
%% Disconnect device
% Disconnect device object from hardware.
disconnect(ps4000aDeviceObj);
delete(ps4000aDeviceObj);
```

这样的打开关闭的操作类似于各种软件读取文件的操作：先打开文件，再读取数据，最后再关闭文件。所以，从另一种角度来讲，我们可以把PicoScope所采集的数据理解成一种“动态”的文件。

<br>

# Appendix

完整的代码如下：

```matlab
%% Clear command window and close any figures
clc, clear, close all

%% Load configuration information
% Setup paths and also load struct and enumeration information. Enumeration
% values are required for certain function calls.
[ps4000aStructs, ps4000aEnuminfo] = ps4000aSetConfig(); % DO NOT EDIT THIS LINE.

%% Device connection
% Check if an Instrument session using the device object 'ps4000aDeviceObj'
% is still open, and if so, disconnect if the User chooses 'Yes' when prompted.
if (exist('ps4000aDeviceObj', 'var') && ps4000aDeviceObj.isvalid && strcmp(ps4000aDeviceObj.status, 'open'))
    openDevice = questionDialog(['Device object ps4000aDeviceObj has an open connection. ' ...
        'Do you wish to close the connection and continue?'], ...
        'Device Object Connection Open');
    if (openDevice == PicoConstants.TRUE)
        % Close connection to device
        disconnect(ps4000aDeviceObj);
        delete(ps4000aDeviceObj);
    else
        % Exit script if User 
        return;
    end
end

% Create a device object. 
% The serial number can be specified as a second input parameter.
ps4000aDeviceObj = icdevice('picotech_ps4000a_generic.mdd', '');

% Connect device object to hardware.
connect(ps4000aDeviceObj);

%% Disconnect device
% Disconnect device object from hardware.
disconnect(ps4000aDeviceObj);
delete(ps4000aDeviceObj);
```

<br>

