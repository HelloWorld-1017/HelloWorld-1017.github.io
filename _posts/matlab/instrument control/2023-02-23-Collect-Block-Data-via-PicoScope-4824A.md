---
layout: single
title: Collecting Block Data in MATLAB via PicoScope 4824A
date: 2023-02-23 20:38:31 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Instrument Control Toolbox
 - Experiment
---

# Introduction

本博客学习 [PicoScope 4000 Series A API MATLAB Generic Instrument Driver - Github](https://github.com/picotech/picosdk-ps4000a-matlab-instrument-driver) 所提供的一个收集Block data的示例：`PS4000A_ID_Block_Example.m`.

<br>

# Work flow

## (1) Device connection

首先是配置设备，并建立与设备的连接（详见：[Connecting PicoScope 4824A in MATLAB: Create a device object & Connect to the instrument](http://whatastarrynight.com/matlab/Connecting-PicoScope-4824A-in-MATLAB/#create-a-device-object--connect-to-the-instrument)）：

```matlab
%% Device connection
% Load configuration information
[ps4000aStructs, ps4000aEnuminfo] = ps4000aSetConfig(); % DO NOT EDIT THIS LINE.

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
ps4000aDeviceObj = icdevice('picotech_ps4000a_generic.mdd', '');
connect(ps4000aDeviceObj);
```

## `invoke` function

在后面的代码中，要使用到很多的驱动所提供的的函数，此时就需要使用到`invoke`函数。例如：

``` matlab
[status.setChB] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 1, 0, 1, 8, 0.0);
```

```matlab
[status.setSimpleTrigger] = invoke(triggerGroupObj, 'setSimpleTrigger', 0, 500, 2); % For channel A
```

`invoke`函数是MATLAB Instrument Control Toolbox中的自建函数（[invoke - MathWorks](https://ww2.mathworks.cn/help/instrument/invoke.html)），该函数的作用是：Execute driver-specific function on device object. 这些driver-specific函数就在开发者所提供的`.mdd`文件中：

![image-20230223161155081](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230223161155081.png?raw=true)

![image-20230223161325106](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230223161325106.png?raw=true)

这些函数的输入输出的含义都从这里查找到。



## (2) Set channels

由于这个示例只显示Channel A所收集到的数据，因此需要关闭掉其他通道，实现的代码是：

```matlab
[status.setChB] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 1, 0, 1, 8, 0.0);

if (ps4000aDeviceObj.channelCount == PicoConstants.QUAD_SCOPE || ps4000aDeviceObj.channelCount == PicoConstants.OCTO_SCOPE)
    [status.setChC] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 2, 0, 1, 8, 0.0);
    [status.setChD] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 3, 0, 1, 8, 0.0);
end

if (ps4000aDeviceObj.channelCount == PicoConstants.OCTO_SCOPE)
    [status.setChE] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 4, 0, 1, 8, 0.0);
    [status.setChF] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 5, 0, 1, 8, 0.0);
    [status.setChG] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 6, 0, 1, 8, 0.0);
    [status.setChH] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 7, 0, 1, 8, 0.0);
end
```

代码中将`ps4000aDeviceObj.channelCount`与`PicoConstants.QUAD_SCOPE`和`PicoConstants.OCTO_SCOPE`进行了比较。`ps4000aDeviceObj`是我们创建的Device object，查看一下它的`channelCount`属性：

```matlab
>> ps4000aDeviceObj.channelCount
ans =
     8
```

而`PicoConstants`对象则是由PicoScope Support Toolbox提供（后面所要用到的`PicoStatus`属性也是一样的）：

![image-20230223163340590](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230223163340590.png?raw=true)

其中定义了很多的常数，这里所要用到的`PicoConstants.QUAD_SCOPE`和`PicoConstants.OCTO_SCOPE`分别为：

```matlab
>> PicoConstants.QUAD_SCOPE
ans =
     4
>> PicoConstants.OCTO_SCOPE
ans =
     8
```

因此，上面这段代码的使用`if`语句的含义就是为了适配不同的PicoScope设备。我这里使用的是8通道的PicoScope 4824A，因此不需要使用`if`语句，直接设置Channel B到Channel H的模式即可：

```matlab
[status.setChB] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 1, 0, 1, 8, 0.0);
[status.setChC] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 2, 0, 1, 8, 0.0);
[status.setChD] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 3, 0, 1, 8, 0.0);
[status.setChE] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 4, 0, 1, 8, 0.0);
[status.setChF] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 5, 0, 1, 8, 0.0);
[status.setChG] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 6, 0, 1, 8, 0.0);
[status.setChH] = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', 7, 0, 1, 8, 0.0);
```

此时`status`结构体中`setChB`到`setChH`的值都是0：

```matlab
>> status
status = 
  struct with fields:
    setChB: 0
    setChC: 0
    setChD: 0
    setChE: 0
    setChF: 0
    setChG: 0
    setChH: 0
```

这段代码的具体含义在注释中进行了标注：

```matlab
% Default driver settings applied to channels are listed below - 
% use |ps4000aSetChannel()| to turn channels on or off and set voltage ranges, 
% coupling, as well as analog offset.
%
% In this example, data is only collected on Channel A so default settings
% are used and other input channels are switched off.

% Channels       : 1 - 7 (ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_B - PS4000A_CHANNEL_H)
% Enabled        : 0
% Type           : 1 (ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC)
% Range          : 8 (ps4000aEnuminfo.enPS4000ARange.PS4000A_5V)
% Analogue Offset: 0.0
```

需要提醒的是，注释中`ps4000aEnuminfo`就是在最开始所加载的配置信息中得到的结构体，详细的内容可以见博客：[Connecting PicoScope 4824A in MATLAB: Load configuration information](http://whatastarrynight.com/matlab/Connecting-PicoScope-4824A-in-MATLAB/#load-configuration-information). 

```matlab
% Load configuration information
[ps4000aStructs, ps4000aEnuminfo] = ps4000aSetConfig(); % DO NOT EDIT THIS LINE.
```

## (3) Verify timebase index and maximum number of samples

```matlab
%% Verify timebase index and maximum number of samples
% Driver default timebase index used - use |ps4000aGetTimebase2()| to query the
% driver as to suitability of using a particular timebase index and the
% maximum number of samples available in the segment selected (the buffer
% memory has not been segmented in this example) then set the |timebase|
% property if required.
%
% To use the fastest sampling interval possible, set one analog channel
% and turn off all other channels.
%
% Use a while loop to query the function until the status indicates that a
% valid timebase index has been selected. In this example, the timebase 
% index of 79 is valid. 

% Initial call to ps4000aGetTimebase2() with parameters:
% timebase      : 79
% segment index : 0

status.getTimebase2 = PicoStatus.PICO_INVALID_TIMEBASE; % 14 
timebaseIndex = get(ps4000aDeviceObj, 'timebase');      % 79

while (status.getTimebase2 == PicoStatus.PICO_INVALID_TIMEBASE)
    [status.getTimebase2, timeIntervalNanoSeconds, maxSamples] = invoke(ps4000aDeviceObj, 'ps4000aGetTimebase2', timebaseIndex, 0);
    if (status.getTimebase2 == PicoStatus.PICO_OK)  % PicoStatus.PICO_OK is 0
        break
    else
        timebaseIndex = timebaseIndex + 1;
    end
end
fprintf('Timebase index: %d\n', timebaseIndex);
set(ps4000aDeviceObj, 'timebase', timebaseIndex);
```

这部分代码的作用主要有两个：

（1）获得变量`timeIntervalNanoSeconds`和`maxSamples`的值

通过下面的代码实现：

```matlab
[status.getTimebase2, timeIntervalNanoSeconds, maxSamples] = invoke(ps4000aDeviceObj, 'ps4000aGetTimebase2', timebaseIndex, 0);
```

> 函数`ps4000aGetTimebase2`同样可以在`.mdd`文件中找到，它的输入输出的形参为：
>
> ```matlab
> function [status, timeIntervalNanoSeconds, maxSamples] = ps4000aGetTimebase2(obj, timebase, segmentIndex)
> ```

其输出分别为：

```matlab
>> status.getTimebase2
ans =
     0
```

```matlab
>> timeIntervalNanoSeconds
timeIntervalNanoSeconds =
  single
        1000
```

```matlab
>> maxSamples
maxSamples =
  int32
   268435264
```

如果更改它的`timebase`输入为`200`（现在是默认的`79`）：

```matlab
K>> [status.getTimebase2, timeIntervalNanoSeconds, maxSamples] = invoke(ps4000aDeviceObj, 'ps4000aGetTimebase2', 200, 0)
status = 
  struct with fields:
          setChB: 0
          setChC: 0
          setChD: 0
          setChE: 0
          setChF: 0
          setChG: 0
          setChH: 0
    getTimebase2: 0

timeIntervalNanoSeconds =
  single
  2.5125e+03

maxSamples =
  int32
   268435264
```

则`timeIntervalNanoSeconds`会发生变化。

（2）获得变量`timebaseIndex`的值

如果运行本节一开始的那一整段代码，就会发现最后`timebaseIndex`的值没有变化，一开始是从`ps4000aDeviceObj`中获得的值是`79`，最后设置给`ps4000aDeviceObj`的值也是`79`。这是因为运行`invoke(ps4000aDeviceObj, 'ps4000aGetTimebase2', timebaseIndex, 0)`后它的`staus`输出和预设的常数`PicoStatus.PICO_OK`一致，都是`0`，表示处于OK状态。

如果`staus`输出不是`0`则会在`while`循环中进行累加`timebaseIndex`，并再次尝试运行`invoke(ps4000aDeviceObj, 'ps4000aGetTimebase2', timebaseIndex, 0)`，直到这段代码的`status`输出为`0`为止。这时的`timebaseIndex`的值就发生了变化，同样地，如上面所尝试的那样，`timeIntervalNanoSeconds`的值也会发生变化。

## (4) Set simple trigger

```matlab
%% Set simple trigger
% Set a trigger on Channel A, with an auto timeout - the default value for
% delay is used.
% Trigger properties and functions are located in the Instrument
% Driver's Trigger group.
triggerGroupObj = get(ps4000aDeviceObj, 'Trigger');
triggerGroupObj = triggerGroupObj(1);

% Set the |autoTriggerMs| property in order to automatically trigger the
% oscilloscope after 1 second if a trigger event has not occurred. Set to 0
% to wait indefinitely for a trigger event.
set(triggerGroupObj, 'autoTriggerMs', 1000);

% Channel     : 0 (ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_A)
% Threshold   : 500 (mV)
% Direction   : 2 (ps4000aEnuminfo.enPS4000AThresholdDirection.PS4000A_RISING)
[status.setSimpleTrigger] = invoke(triggerGroupObj, 'setSimpleTrigger', 0, 500, 2); % For channel A
```

PicoScope采集Block data的方式是触发收集。这段代码的含义是：在没有外部触发的情况下，1s后为Channel A设置一个阈值为`500mv`的上升沿触发，

## (5) Set block parameters 

```matlab
%% Set block parameters and capture data
% Capture a block of data and retrieve data values for Channel A.
% Block data acquisition properties and functions are located in the 
% Instrument Driver's Block group.

blockGroupObj = get(ps4000aDeviceObj, 'Block');
blockGroupObj = blockGroupObj(1);

% Set pre-trigger and post-trigger samples as required - the total of this should
% not exceed the value of maxSamples returned from the call to |ps4000GetTimebase2()|.
% The default of 0 pre-trigger and 1 million post-trigger samples is used
% in this example.
% set(ps4000aDeviceObj, 'numPreTriggerSamples', 0);
% set(ps4000aDeviceObj, 'numPostTriggerSamples', 2e6);
```

本段代码设置Block参数，默认是不收集触发前的样本，收集触发后的1,000,000个样本点；同样也可以在这里修改这一默认设置。

## (6) Capture data

```matlab
% This example uses the |runBlock()| function in order to collect a block
% of data.

% Capture a block of data:
% segment index: 0 (The buffer memory is not segmented in this example)
[status.runBlock] = invoke(blockGroupObj, 'runBlock', 0);

% Retrieve data values:
% start index       : 0
% segment index     : 0
% downsampling ratio: 1
% downsampling mode : 0 (ps4000aEnuminfo.enPS4000ARatioMode.PS4000A_RATIO_MODE_NONE)

% Provide additional output arguments for the remaining channels e.g. chB
% for Channel B
[numSamples, overflow, chA] = invoke(blockGroupObj, 'getBlockData', 0, 0, 1, 0);

% Stop the device
[status.stop] = invoke(ps4000aDeviceObj, 'ps4000aStop');
```

在这里，采集到数据的操作是通过代码`[status.runBlock] = invoke(blockGroupObj, 'runBlock', 0);`来实现的，当运行这行代码时，PicoScope会发生一些声响。

之后使用`[numSamples, overflow, chA] = invoke(blockGroupObj, 'getBlockData', 0, 0, 1, 0);`来获取到Block中的数据。其中：

```matlab
>> numSamples
numSamples =
  uint32
   1000000
```

```matlab
>> overflow
overflow =
  int16
   0
```

```matlab
>> whos chA
  Name            Size              Bytes  Class     Attributes
  chA       1000000x1             8000000  double           
```

## (7) Process data

最后就是将采集到的数据绘制出来：

```matlab
%% Process data
% Plot data values returned from the device.
figure1 = figure('Name','PicoScope 4000 Series (A API) Example - Block Mode Capture', ...
    'NumberTitle', 'off');

% Calculate sampling interval (nanoseconds) and convert to milliseconds
% Use the timeIntervalNanoSeconds output from the |ps4000aGetTimebase2()|
% function or calculate it using the main Programmer's Guide.
timeNs = double(timeIntervalNanoSeconds) * double(0:(numSamples-1));
timeMs = timeNs / 1e6;

% Channel A
plot(timeMs, chA);
title('Block Data Acquisition');
xlabel('Time (ms)');

% Obtain the channel range and units
[chARange, chAUnits] = invoke(ps4000aDeviceObj, 'getChannelInputRangeAndUnits', ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_A);
ylabel(getVerticalAxisLabel(chAUnits));

grid on;
legend('Channel A');
```

需要注意的是，绘制出的图像：

- 信号的时间从0开始；
- 将单位由nanoseconds转换为milliseconds；

另外注意到两个输出变量：

```matlab
>> chARange, chAUnits
chARange =
        5000
        
chAUnits =
    'mV'
```

以及设置纵坐标轴标签的操作：

```matlab
ylabel(getVerticalAxisLabel(chAUnits));
```

`getVerticalAxisLabel`函数是**PicoScope Support Toolbox**提供的函数。

最终图像的效果是：

![image-20230223201119914](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230223201119914.png?raw=true)

## (8) Disconnect Device

最后，断开连接：

```matlab
%% Disconnect device
% Disconnect device object from hardware.
disconnect(ps4000aDeviceObj);
delete(ps4000aDeviceObj);
```

<br>













