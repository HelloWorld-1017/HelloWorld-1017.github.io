---
title: Collect Streaming Data in MATLAB via PicoScope 4824A 
categories: 
 - MATLAB
tags:
 - MATLAB Instrument Control Toolbox
 - Experiment
date: 2023-03-13 13:35:31 +0800
last_modified_at: 2024-10-23 19:43:31 +0800
---

本博客学习 [PicoScope 4000 Series A API MATLAB Generic Instrument Driver - Github](https://github.com/picotech/picosdk-ps4000a-matlab-instrument-driver) 所提供的一个收集Streaming data的示例：`PS4000A_ID_Streaming_Example.m`.

# Load configuration information

```matlab
PS4000aConfig;
```

相比于博客[Connecting PicoScope 4824A in MATLAB - What a starry night~](http://whatastarrynight.com/matlab/Connecting-PicoScope-4824A-in-MATLAB/#load-configuration-information)中加载配置信息的方式，这种方式会在工作空间中得到的输出变量更多，分别是：

- `ps4000aConfigInfo`，结构体

- `ps4000aEnuminfo`，结构体

- `ps4000aMethodinfo`，结构体

- `ps4000aStructs`，结构体

- `ps4000aThunkLibName`，字符串，是动态链接库`ps4000a_thunk_pcwin64.dll`的地址：

  ```matlab
   'C:\...\MathWorks\MATLAB Add-Ons\Hardware Supports\PicoScope 4000 Series A API MATLAB Generic Instrument Driver\win64\ps4000a_thunk_pcwin64'
  ```

<br>

# Parameter definitions

定义表示A通道和B通道的变量：

```matlab
%% Parameter definitions
% Define any parameters that might be required throughout the script.
channelA = ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_A;
channelB = ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_B;
```

```matlab
>> channelA,channelB
channelA =
     0
channelB =
     1
```

# Device connnection

连接设备：

```matlab
%% Device connection
if (exist('ps4000aDeviceObj','var') && ps4000aDeviceObj.isvalid && strcmp(ps4000aDeviceObj.status,'open'))
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
ps4000aDeviceObj = icdevice('picotech_ps4000a_generic','ObjectVisibility','on'); 
% Connect device
connect(ps4000aDeviceObj);
```

详见博客：[Connecting PicoScope 4824A in MATLAB - What a starry night~](http://whatastarrynight.com/matlab/Connecting-PicoScope-4824A-in-MATLAB/#check-before-connection).

<br>

# Display unit information

```matlab
%% Display unit information
[infoStatus, unitInfo] = invoke(ps4000aDeviceObj, 'getUnitInfo');

disp('Device information:-')
disp(unitInfo);
```

其中：

```matlab
>> [infoStatus, unitInfo] = invoke(ps4000aDeviceObj, 'getUnitInfo')
infoStatus =
  11×1 uint32 column vector
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0
   0

unitInfo =
  11×1 cell array
    {'Driver version: 2.1.82.3072'}
    {'USB version: 3.0'           }
    {'Hardware version: 1'        }
    {'Variant: 4824A'             }
    {'Batch & Serial: JW851/0014' }
    {'Cal. Date: 15Jul22'         }
    {'Kernel version: 1.0'        }
    {'Digital HW version: 1'      }
    {'Analogue HW version: 1'     }
    {'Firmware 1: 1.7.5.0'        }
    {'Firmware 2: 1.0.11.0'       }
```

<br>

# Channel setup

## `ps4000aSetChannel` function

接下来，需要设置通道的参数，使除了通道A和通道B之外的其他通道都处于关闭状态：

```matlab
%% Channel setup
% All channels are enabled by default - switch off all except Channels A and B. 
% Channel A
channelSettings(1).enabled          = PicoConstants.TRUE; % 1
channelSettings(1).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;% 1
channelSettings(1).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;% 7
channelSettings(1).analogueOffset   = 0.0;

% Channel B
channelSettings(2).enabled          = PicoConstants.TRUE;
channelSettings(2).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(2).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(2).analogueOffset   = 0.0;

% Channel C
channelSettings(3).enabled          = PicoConstants.FALSE;
channelSettings(3).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(3).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(3).analogueOffset   = 0.0;

% Channel D
channelSettings(4).enabled          = PicoConstants.FALSE;
channelSettings(4).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(4).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(4).analogueOffset   = 0.0;

% Channel E
channelSettings(5).enabled          = PicoConstants.FALSE;
channelSettings(5).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(5).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(5).analogueOffset   = 0.0;

% Channel F
channelSettings(6).enabled          = PicoConstants.FALSE;
channelSettings(6).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(6).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(6).analogueOffset   = 0.0;

% Channel G
channelSettings(7).enabled          = PicoConstants.FALSE;
channelSettings(7).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(7).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(7).analogueOffset   = 0.0;

% Channel H
channelSettings(8).enabled          = PicoConstants.FALSE;
channelSettings(8).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(8).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(8).analogueOffset   = 0.0;

% Obtain the number of analog channels on the device from the driver
numChannels = get(ps4000aDeviceObj, 'channelCount');

for ch = 1:numChannels
    status.setChannelStatus(ch) = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', ...
        (ch - 1), channelSettings(ch).enabled, ...
        channelSettings(ch).coupling, channelSettings(ch).range, ...
        channelSettings(ch).analogueOffset);
end
```

其中`channelSettings`结构体的内容是：

![image-20230227083252181](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230227083252181.png?raw=true)

这部分的内容和博客[Collecting Block Data in MATLAB via PicoScope 4824A: Set channels](http://whatastarrynight.com/matlab/Collecting-Block-Data-in-MATLAB-via-PicoScope-4824A/#2-set-channels)中设置通道的方式是类似的，后者的代码更加紧凑，如果对于`ps4000aSetChannel`函数的输入参数中常数所代表的含义比较熟悉，可以后面这种方式。

## `getChannelInputRangeAndUnits` function

获取通道A和通道B的输出范围和输出单位，供后续使用：

```matlab
% Obtain the range and units for each enabled channel. For the PicoScope 4824, this will be in millivolts.
[chARange, chAUnits] = invoke(ps4000aDeviceObj, 'getChannelInputRangeAndUnits', ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_A);
[chBRange, chBUnits] = invoke(ps4000aDeviceObj, 'getChannelInputRangeAndUnits', ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_B);
```

其中，对于通道A和通道B，`getChannelInputRangeAndUnits`的输入参数分别为：

```matlab
>> ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_A
ans =
     0

>> ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_B
ans =
     1
```

输出参数分别为：

```matlab
>> chARange, chAUnits
chARange =
        2000
chAUnits =
    'mV'

>> chBRange, chBUnits
chBRange =
        2000
chBUnits =
    'mV'
```

## `maxADCValue` property

```matlab
% Obtain the maximum Analog Digital Converter Count value from the driver
% - this is used for scaling values returned from the driver when data is
% collected.
maxADCCount = double(get(ps4000aDeviceObj, 'maxADCValue'));
```

```matlab
>> maxADCCount
maxADCCount =
       32767
```

从PicoScope中读取出的数据是模拟量，是由整数表示的。在后面的代码中，会使用`adc2mv`函数转换为单位为mv的、以浮点数表示的值，在转换时就会用到`maxADCCount`的值。

<br>

# Set Data Buffers

设置数据缓存区。

```matlab
%% Set data buffers
% Data buffers for Channel A and B - buffers should be set with the
% (lib)ps400a shared library, and these *MUST* be passed with application
% buffers to the wrapper shared library. This will ensure that data is
% correctly copied from the shared library buffers for later processing.
```

## Constants for data buffers: `overviewBufferSize`, `segmentIndex`, and `ratioMode`

```matlab
overviewBufferSize  = 250000; % Size of the buffer(s) to collect data from the driver's buffer(s).
segmentIndex        = 0;   
ratioMode           = ps4000aEnuminfo.enPS4000ARatioMode.PS4000A_RATIO_MODE_NONE; % rationMode = 0;
```

## Buffers to be passed to the driver: `pDriverBufferChA`, `pDriverBufferChB`

```matlab
% Buffers to be passed to the driver
pDriverBufferChA = libpointer('int16Ptr',zeros(overviewBufferSize,1,'int16'));
pDriverBufferChB = libpointer('int16Ptr',zeros(overviewBufferSize,1,'int16'));
```

```matlab
>> pDriverBufferChA
pDriverBufferChA =
libpointer

>> pDriverBufferChB
pDriverBufferChB =
libpointer
```

这两个变量都是指针`lib.pointer`类的变量：

```matlab
>> whos pDriverBufferChA pDriverBufferChB
  Name                  Size            Bytes  Class          Attributes
  pDriverBufferChA      1x1                    lib.pointer              
  pDriverBufferChB      1x1                    lib.pointer     
```

之后，使用`ps4000aSetDataBuffer`函数设置通道A和通道B的buffer：

```matlab
status.setDataBufferChA = invoke(ps4000aDeviceObj, 'ps4000aSetDataBuffer', ...
    channelA, pDriverBufferChA, overviewBufferSize, segmentIndex, ratioMode);% status.setDataBufferChA = 0;
status.setDataBufferChB = invoke(ps4000aDeviceObj, 'ps4000aSetDataBuffer', ...
   channelB, pDriverBufferChB, overviewBufferSize, segmentIndex, ratioMode);% status.setDataBufferChB = 0;
```

## Application Buffers: `pAppBufferChA` and `pAppBufferChB`

前面一步设置了Driver buffer，接下来需要设置Application buffer，这个buffer保存着从driver中暂时复制出的数据。设置与前面的一步也是类似的，但是需要特别针对Streaming mode进行设置：

```matlab
% Application Buffers - these are for temporarily copying data from the driver.
pAppBufferChA = libpointer('int16Ptr',zeros(overviewBufferSize,1)); % overviewBufferSize = 250000;
pAppBufferChB = libpointer('int16Ptr',zeros(overviewBufferSize,1));

% Streaming properties and functions are located in the Instrument Driver's Streaming group.
streamingGroupObj = get(ps4000aDeviceObj, 'Streaming');
streamingGroupObj = streamingGroupObj(1);

% Register application buffer and driver buffers (with the wrapper driver).
status.setAppAndDriverBuffersA = invoke(streamingGroupObj, 'setAppAndDriverBuffers', channelA, ...
    pAppBufferChA, pDriverBufferChA, overviewBufferSize); % status.setAppAndDriverBuffersA = 0;
status.setAppAndDriverBuffersB = invoke(streamingGroupObj, 'setAppAndDriverBuffers', channelB, ...
   pAppBufferChB, pDriverBufferChB, overviewBufferSize);  % status.setAppAndDriverBuffersB = 0;
```

> 在后面从Application buffer读取数据时，会使用索引在这两个指针中取值：
>
> ```matlab
> % Convert data values from the application buffer(s) - in this example
> bufferChAmV = adc2mv(pAppBufferChA.Value(firstValuePosn:lastValuePosn),chARange,maxADCCount);
> bufferChBmV = adc2mv(pAppBufferChB.Value(firstValuePosn:lastValuePosn),chBRange,maxADCCount);
> ```

<br>

# Streaming Mode Settings and Other Settings

## Streaming interval: `streamingInterval` property

设置Streaming mode的采样间隔。这里就采用了默认的`1e-6`的采样间隔；除此之外，用户可以通过设置`streamingGroupObj`类的`streamingInterval`的属性进行设置：

```matlab
% Use default value for streaming interval which is 1e-6 for 1 MS/s.
% Collect data for 1 second with auto stop. The maximum array size will
% depend on the PC's resources. For further information, type |memory| in
% the MATLAB Command Window and press Enter.
%
% To change the sample interval set the |streamingInterval| property of the
% |Streaming| group object. The call to |ps4000aRunStreaming()| will output the actual
% sampling interval used by the driver.

% For 200 kS/s, specify 5 us
%set(streamingGroupObj, 'streamingInterval', 5e-6);

% For 10 MS/s, specify 100 ns (0.1 us)
%set(streamingGroupObj, 'streamingInterval', 100e-9);
```

## `numPreTriggerSamples` and `numPostTriggerSamples` properties

设置触发前后需要采集的样本点数：

```matlab
% Set the number of pre- and post-trigger samples
% If no trigger is set 'numPreTriggerSamples' is ignored
set(ps4000aDeviceObj, 'numPreTriggerSamples', 0);
set(ps4000aDeviceObj, 'numPostTriggerSamples', 2000000);
```

如果没有使用trigger，则不需要设置`'numPreTriggerSamples'`属性，但是`'numPostTriggerSamples'`仍然是需要的，后面会再一次提到这一点，这里的设置是和streaming mode的auto stop的行为（即和`maxSamples`）有关。

## `autoStop` property

可以设置Streaming mode是否停止（默认是自动停止）

```matlab
% The autoStop parameter can be set to false (0).
%set(streamingGroupObj, 'autoStop', PicoConstants.FALSE);
```

默认情况的Streaming mode，会在收集到`maxSamples`（后面会讲到）个样本点后停止；如果使用`set(streamingGroupObj, 'autoStop', PicoConstants.FALSE);`的代码，则数据收集是不会停止的，直到点击`stop`按钮（示例后面会设置一个GUI的`stop`按钮）。

## `downSampleRatio` and `downSampleRatioMode`

Streaming mode中关于下采样的设置

```matlab
% Set other streaming parameters
downSampleRatio     = 1;
downSampleRatioMode = ps4000aEnuminfo.enPS4000ARatioMode.PS4000A_RATIO_MODE_NONE; % downSampleRatioMode = 0;
```

## `maxSamples`

如果获取数据的时候（1）没有使用autoStop flag或者（2）使用trigger停止收集，例如像本示例仅采用2 s的数据，则收集到的数据大小是可以预期的，为这样一个数组预分配空间就是很更加高效的。

```matlab
% Defined buffers to store data collected from the channels.
% If capturing data without using the autoStop flag, or if using a trigger 
% with the autoStop flag, allocate sufficient space (1.5 times the size is 
% shown below) to allow for pre-trigger data. Pre-allocating the array is 
% more efficient than using vertcat to combine data.
maxSamples = get(ps4000aDeviceObj, 'numPreTriggerSamples') + ...
    get(ps4000aDeviceObj, 'numPostTriggerSamples');
```

```matlab
>> maxSamples
maxSamples =
     2000000
```

在预分配数组大小时，需要考虑下采样的设置：

```matlab
% Take into account the downsampling ratio mode - required if collecting
% data without a trigger and using the autoStop flag. 
% finalBufferLength = round(1.5 * maxSamples / downSampleRatio);
```

虽然注释中提到预分配的空间要是sufficient，采用1.5倍的设置的大小，但是实际的代码中并没有这么做，在下一节创建Final buffer时直接采用与预期的大小一样的数组大小，即`maxSamples = 2000000`。

## Create final data buffers: `pBufferChAFinal` and `pBufferChAFinal`

上面在创建Application buffer时提到，Application buffer只是暂时的一个buffer，它其中的数据需要传入到Final buffer中保存，因此同样需要为A通道和B通道创建指针：

```matlab
pBufferChAFinal = libpointer('int16Ptr', zeros(maxSamples, 1, 'int16'));
pBufferChBFinal = libpointer('int16Ptr', zeros(maxSamples, 1, 'int16'));
```

```matlab
>> pBufferChAFinal
pBufferChAFinal =
libpointer

>> pBufferChBFinal
pBufferChBFinal =
libpointer
```

> 和Application buffer类似，在后面向Final buffer中传入数据时，同样也是通过索引进行操作：
>
> ```matlab
> % Copy data into the final buffer(s).
> pBufferChAFinal.Value(previousTotal + 1:totalSamples) = bufferChAmV;
> pBufferChBFinal.Value(previousTotal + 1:totalSamples) = bufferChBmV;
> ```

## Decide whether plot live streaming data: `plotLiveData`

```matlab
% Prompt User to indicate if they wish to plot live streaming data.
plotLiveData = questionDialog('Plot live streaming data?', 'Streaming Data Plot');
if (plotLiveData == PicoConstants.TRUE)
    disp('Live streaming data collection with second plot on completion.');
else
    disp('Streaming data plot on completion.');
end
```

![image-20230227081059416](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230227081059416.png?raw=true)

## Start streaming data collection: `ps4000aRunStreaming` function

```matlab
% Start streaming data collection.
[status.runStreaming, actualSampleInterval, sampleIntervalTimeUnitsStr] = ...
    invoke(streamingGroupObj, 'ps4000aRunStreaming', downSampleRatio, ...
    downSampleRatioMode, overviewBufferSize);
```

```matlab
>> status.runStreaming, actualSampleInterval, sampleIntervalTimeUnitsStr
ans =
     0

actualSampleInterval =
  uint32
   1

sampleIntervalTimeUnitsStr =
    'us'
```

## Initialize variables to be used when collecting the data: `isAutoStopSet`, `newSamples`, `previousTotal`, `totalSamples`, `startIndex`, `hasTriggered`, and `triggeredAtIndex`

```matlab
% Variables to be used when collecting the data
isAutoStopSet       = PicoConstants.FALSE; % 0
newSamples          = 0; % Number of new samples returned from the driver.
previousTotal       = 0; % The previous total number of samples.
totalSamples        = 0; % Total number of samples captured by the device.
startIndex          = 0; % Start index of data in the buffer returned (zero-based).
hasTriggered        = 0; % To indicate if trigger event has occurred.
triggeredAtIndex    = 0; % The index in the overall buffer where the trigger occurred (zero-based).
```

## Display a 'Stop' button

创建一个停止按钮：

```matlab
% Display a 'Stop' button.
[~, stopFig.h] = stopButton(); % `stopButton` from PicoScope Support Toolbox   
```

![image-20230227080512640](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230227080512640.png?raw=true)

`stopButton()`函数来自PicoScope Support Toolbox，它有两个输出，分别是figure的和一个stop按钮：

```matlab
function [f, h] = stopButton()
% STOPBUTTON Displays a stop button.
%   [F, H] = STOPBUTTON() displays a Stop button to check abort data collection - 
%   based on MathWorks solution 1-15JIQ (http://uk.mathworks.com/matlabcentral/answers/100558-how-do-i-set-up-a-uicontrol-callback-to-interrupt-a-routine) and MATLAB Central Forum.
%   F is the handle to the button's figure, H is the uicontrol object.
%
%   Copyright: © 2014 - 2015 Pico Technology Ltd. All rights reserved.
%
%   See also FIGURE, UICONTROL.
    f = figure('Name', 'Stop Button', 'menubar', 'none',...
              'units', 'pix',...
              'pos', [400 400 100 50]);
    h = uicontrol('string', 'STOP', ...
                'callback', 'setappdata(gcf, ''run'', 0)', 'units', 'pixels',...
                'position',[10 10 100 30]);
end
```

可以在源代码中看到，`STOP`按钮的回调函数是，`'setappdata(gcf, ''run'', 0)'`，表示将figure中的`run `变量赋零。

> `setappdata()`是MATLAB所提供的函数（[setappdata - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/setappdata.html)），其作用是：store data in a UI. 但是这个数据在UI中是不显示的，比如对于官方所提供的一个示例：
>
> ```matlab
> f = figure;
> val = date;
> setappdata(f,'todaydate',val)
> ```
>
> ![image-20230227102020211](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230227102020211.png?raw=true)
>
> UI中是不显示该数据的，但同时该UI的属性中也找不到这个值，不太清楚这个值具体保存在哪里，但是可以通过`getappdata()`函数（[getappdata - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/getappdata.html)）重新获取到这个值：
>
> ```matlab
> >> getappdata(f,'todaydate')
> ans =
>     '27-Feb-2023'
> ```

首先需要对UI中的`run`变量幅值为1，并且在外部使用`flag`变量表示：

```matlab
flag = 1; % Use flag variable to indicate if the stop button has been clicked (0).
setappdata(gcf, 'run', flag);
```

## Figure for plotting live streaming data 

创建用于绘制live streaming data的figure：

```matlab
% Plot Properties - these are for displaying data as it is collected. In
% this example, data is displayed in millivolts. 
if (plotLiveData == PicoConstants.TRUE)
    % Plot on a single figure 
    figure1 = figure('Name','PicoScope 4000 Series (A API) Example - Streaming Mode Capture', ...
         'NumberTitle','off');
     axes1 = axes('Parent', figure1);

    % Estimate x-axis limit to try and avoid using too much CPU resources
    % when drawing - use max voltage range selected if plotting multiple
    % channels on the same graph.
    xlim(axes1, [0 (actualSampleInterval * maxSamples)]);

    yRange = max(chARange, chBRange);
    ylim(axes1,[(-1 * yRange) yRange]);

    hold(axes1,'on');
    grid(axes1, 'on');

    title(axes1, 'Live Streaming Data Capture');
    xLabelStr = strcat('Time (', sampleIntervalTimeUnitsStr, ')');
    xlabel(axes1, xLabelStr);
    ylabel(axes1, getVerticalAxisLabel(chAUnits));
end
```

需要注意的是横坐标范围的设置：`xlim(axes1, [0 (actualSampleInterval * maxSamples)]);`

![image-20230227104140854](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230227104140854.png?raw=true)

<br>

# Collecting Data and Live Plot

## Two-levels nested while loop and `getStreamingLatestValues` function

在进行完以上的设置之后，就可以循环地采集数据并绘制实时数据采集的曲线。其中，循环中的数据采集是通过`getStreamingLatestValues`函数进行的：

```matlab
...
status.getStreamingLatestValues = invoke(streamingGroupObj, 'getStreamingLatestValues');
...
```

它包裹在一个两层的`while`循环当中：

```matlab
while (isAutoStopSet == PicoConstants.FALSE && status.getStreamingLatestValues == PicoStatus.PICO_OK)
    ready = PicoConstants.FALSE; % PicoConstants.FALSE = 0;
   
    while (ready == PicoConstants.FALSE)
       % Collect data
       status.getStreamingLatestValues = invoke(streamingGroupObj, 'getStreamingLatestValues');

       % Chek whether ready
       ready = invoke(streamingGroupObj, 'isReady');

       % Give option to abort from here
       flag = getappdata(gcf, 'run');
       drawnow;
       
       if (flag == 0)
            disp('STOP button clicked - aborting data collection.')
            break
       end
       if (plotLiveData == PicoConstants.TRUE)
            drawnow;
       end
    end
    ...
    % Check if auto stop has occurred.
    isAutoStopSet = invoke(streamingGroupObj, 'autoStopped');
    if (isAutoStopSet == PicoConstants.TRUE)
       disp('AutoStop: TRUE - exiting loop.');
       break
    end
   
    % Check if 'STOP' button pressed.
    flag = getappdata(gcf, 'run');
    drawnow;
    if (flag == 0)
        disp('STOP button clicked - aborting data collection.')
        break
    end
end
```

整个内层的循环代表一次数据收集，这些数据都暂时保存在Application buffer中，之后会在外层循环中进行处理（在后面会介绍）。内层的停止条件有两个，满足其中之一就停止收集数据：

（1）用户点击了停止按钮：变量`flag`的值为`0`；

（2）Device object不是Ready的状态：变量`ready`的值为真；

外层循环代表整个的数据收集过程，其停止的条件有三个：

（1）设备自动停止收集：`isAutoStopSet`为真；

（2）Streaming mode工作状态不正常：`status.getStreamingLatestValues`不等于`PicoStatus.PICO_OK`；

（3）用户点击了停止按钮：变量`flag`的值为`0`；

## Processing one-time collected data at outer while loop

内层循环中收集到的数据会保存在Application buffer中，用户需要在外层循环中使用`availableData`函数获取到新收集到的数据的大小`newSamples`和起始位置`startIndex`。如果收集到了数据，即`newSamples`的值大于0，则进入一个`if`条件结构处理数据，整体的代码结构为：

```matlab
while (isAutoStopSet == PicoConstants.FALSE && status.getStreamingLatestValues == PicoStatus.PICO_OK)
    ...
    while (ready == PicoConstants.FALSE)
      ...
    end
    % Check for new data values
    [newSamples, startIndex] = invoke(streamingGroupObj, 'availableData');

    if (newSamples > 0)
        % Check if the scope has triggered
        [triggered, triggeredAt] = invoke(streamingGroupObj, 'isTriggerReady');

        if (triggered == PicoConstants.TRUE)
            % Adjust trigger position as MATLAB does not use zero-based indexing.
            bufferTriggerPosition = triggeredAt + 1;
            fprintf('Triggered - index in buffer: %d\n', bufferTriggerPosition);
            hasTriggered = triggered;

            % Set the total number of samples at which the device triggered.
            triggeredAtIndex = totalSamples + bufferTriggerPosition;
        end

        previousTotal = totalSamples;
        totalSamples  = totalSamples + newSamples;

        % Printing to console can slow down acquisition - use for demonstration.
        fprintf('Collected %d samples, startIndex: %d total: %d.\n', newSamples, startIndex, totalSamples);
        
        % Position indices of data in the buffer(s).
        firstValuePosn = startIndex + 1;
        lastValuePosn = startIndex + newSamples;
        
        % Convert data values from the application buffer(s) - in this example
        bufferChAmV = adc2mv(pAppBufferChA.Value(firstValuePosn:lastValuePosn),chARange,maxADCCount);
        bufferChBmV = adc2mv(pAppBufferChB.Value(firstValuePosn:lastValuePosn),chBRange,maxADCCount);

        % Process collected data further if required - this example plots
        % the data if the User has selected 'Yes' at the prompt.
        
        % Copy data into the final buffer(s).
        pBufferChAFinal.Value(previousTotal + 1:totalSamples) = bufferChAmV;
        pBufferChBFinal.Value(previousTotal + 1:totalSamples) = bufferChBmV;
        
        if (plotLiveData == PicoConstants.TRUE)
            % Time axis
            % Multiply by ratio mode as samples get reduced.
            time = (double(actualSampleInterval) * double(downSampleRatio)) * (previousTotal:(totalSamples - 1));
            plot(time, bufferChAmV, time, bufferChBmV);
        end

        % Clear variables.
        clear bufferChAmV bufferChBmV firstValuePosn lastValuePosn ...
            startIndex triggered triggerAt;
    end
	...
end
```

我们假定内层循环中的`getStreamingLatestValues`收集到了数据，并进入到`if`条件结构中进行处理。

## `isTriggerReady` function

在`if`条件结构的一开始，代码首先使用`isTriggerReady`函数判断是否存在trigger，并且记录下trigger的位置，并且在主代码的部分将这一信息打印出来：

```matlab
...
while (isAutoStopSet == PicoConstants.FALSE && status.getStreamingLatestValues == PicoStatus.PICO_OK)
    ...
    if (newSamples > 0)
        % Check if the scope has triggered
        [triggered, triggeredAt] = invoke(streamingGroupObj, 'isTriggerReady');

        if (triggered == PicoConstants.TRUE)
            % Adjust trigger position as MATLAB does not use zero-based indexing.
            bufferTriggerPosition = triggeredAt + 1;
            fprintf('Triggered - index in buffer: %d\n', bufferTriggerPosition);
            hasTriggered = triggered;

            % Set the total number of samples at which the device triggered.
            triggeredAtIndex = totalSamples + bufferTriggerPosition;
        end
    ...
    end
 end
 ...
if (hasTriggered == PicoConstants.TRUE)
    fprintf('Triggered at overall index: %d\n', triggeredAtIndex);
end
...
```

我在调试代码的时候并没有使用Trigger，无法查看这段代码的效果，但是我有一点不是很明白：如果在收集代码的过程存在多个Trigger，那么这样的代码设计只能记录下最后一个trigger的位置吗？看起来是这样的。

## Update `previousTotal` and `totalSamples` variables

更新`previousTotal`和`totalSamples` 变量，这一步是为了向Final buffer中传递Application buffer中暂时保存的数据：

```matlab
previousTotal = totalSamples;
totalSamples  = totalSamples + newSamples;
```

## Obtain data from Application buffer

获取到Application buffer中数据所在的索引，并使用`adc2mv`函数将其转换为单位为`mv`的数据：

```matlab
% Position indices of data in the buffer(s).
firstValuePosn = startIndex + 1;
lastValuePosn = startIndex + newSamples;

% Convert data values from the application buffer(s) - in this example
bufferChAmV = adc2mv(pAppBufferChA.Value(firstValuePosn:lastValuePosn),chARange,maxADCCount);
bufferChBmV = adc2mv(pAppBufferChB.Value(firstValuePosn:lastValuePosn),chBRange,maxADCCount);
```

其中，`adc2mv`函数的作用是：Converts **raw Analog** to **Digital Converter count values** to millivolts. 这一点很像像博客[Correction and Supplement for Blog “An Arduino Sample Project Based on Temperature Sensor”：From Arduino Output Value to Resistance](http://whatastarrynight.com/arduino/c/Correction-and-Supplement-for-Blog-An-Arduino-Sample-Project-Based-on-Temperature-Sensor/#from-arduino-output-value-to-resistance)中所述的模拟输出与输出电压之间的线性映射。

转换为数组`bufferChAmV`和`bufferChBmV`后，我们可以对数组进行处理，当然示例中仅仅是将数据绘制出来，而实际上在这里可以进行一些更复杂的操作：

```matlab
% Process collected data further if required - this example plots
% the data if the User has selected 'Yes' at the prompt.
```

## Pass collected data from Application buffer to Final buffer

之后，同样利用我们之前为Final buffer定义的指针`pBufferChAFinal`和`pBufferChBFinal`，将数据Application buffer中传递到Final buffer中：

```matlab
% Copy data into the final buffer(s).
pBufferChAFinal.Value(previousTotal + 1:totalSamples) = bufferChAmV;
pBufferChBFinal.Value(previousTotal + 1:totalSamples) = bufferChBmV;
```

之后，绘制live streaming data：

```matlab
if (plotLiveData == PicoConstants.TRUE)
    % Time axis
    % Multiply by ratio mode as samples get reduced.
    time = (double(actualSampleInterval) * double(downSampleRatio)) * (previousTotal:(totalSamples - 1));
    plot(time, bufferChAmV, time, bufferChBmV);
end
```

并清除掉为Driver buffer所设置的变量：

```matlab
clear bufferChAmV bufferChBmV firstValuePosn lastValuePosn ...
    startIndex triggered triggerAt;
```

从清除变量这一步可以清楚地体会到，Application buffer和Final buffer是不同的，在每次循环中Application buffer的数据都会清掉，而Final buffer则保存着所有的数据，因此，正如前面所指出的那样，最后能收集到多大体量的数据取决于PC的内存有多大。

<br>

# Final process

在实现了实时数据的采集和实时绘制后，剩下的就是一些比较简单的、常规的操作和处理，这里不再赘述：

```matlab
% Close the STOP button window
if (exist('stopFig', 'var'))
    close('Stop Button');
    clear stopFig;
end

if (plotLiveData == PicoConstants.TRUE)
    drawnow
end

if (hasTriggered == PicoConstants.TRUE)
    fprintf('Triggered at overall index: %d\n', triggeredAtIndex);
end

if (plotLiveData == PicoConstants.TRUE)
    % Take hold off the current figure
    hold off;
    movegui(figure1, 'west');
end
fprintf('\n');

%% Stop the device
% This function should be called regardless of whether the |autoStop|
% property is enabled or not.
status.stop = invoke(ps4000aDeviceObj, 'ps4000aStop');

%% Find the number of samples
% This is the number of samples held in the |(lib)ps4000a| shared library itself. The actual
% number of samples collected when using a trigger is likely to be greater.
[status.noOfStreamingValues, numStreamingValues] = invoke(streamingGroupObj, 'ps4000aNoOfStreamingValues');
fprintf('Number of samples available from the driver: %u.\n\n', numStreamingValues);

%% Process data
% Process all data if required

% Reduce size of arrays if required.
if (totalSamples < maxSamples)
    pBufferChAFinal.Value(totalSamples + 1:end) = [];
    pBufferChBFinal.Value(totalSamples + 1:end) = [];
end


% Retrieve data for the Channels.
channelAFinal = pBufferChAFinal.Value();
channelBFinal = pBufferChBFinal.Value();

% Plot the total data collected on another figure.
finalFigure = figure('Name','PicoScope 4000 Series (A API) Example - Streaming Mode Capture', ...
    'NumberTitle','off');
finalFigureAxes = axes('Parent', finalFigure);
hold(finalFigureAxes, 'on');

title('Streaming Data Capture (Final)');
xLabelStr = strcat('Time (', sampleIntervalTimeUnitsStr, ')');
xlabel(finalFigureAxes, xLabelStr);
ylabel(finalFigureAxes, 'Voltage (mV)');

% Find the maximum voltage range.
maxYRange = max(chARange, chBRange);
ylim(finalFigureAxes,[(-1 * maxYRange) maxYRange]);

% Calculated values for time axis, then plot.
timeAxis = (double(actualSampleInterval) * double(downSampleRatio)) * (0:length(channelAFinal) - 1);
plot(finalFigureAxes, timeAxis, channelAFinal, timeAxis, channelBFinal);

grid(finalFigureAxes, 'on');
legend(finalFigureAxes, 'Channel A', 'Channel B');
hold(finalFigureAxes, 'off');

movegui(finalFigureAxes, 'east');
%% Disconnect device
% Disconnect device object from hardware.
disconnect(ps4000aDeviceObj);
delete(ps4000aDeviceObj);
```

<br>

# Discussion about Buffers

以上就是整个示例的所有代码，其中比较难理解的部分是buffer的设置和使用。对于A和B两个通道，代码都设置了三个buffer，分别是driver buffer（data buffer），application buffer和final buffer，并且设置的方式都是一样的，我们这里就以A通道为例整理一下这些buffer的作用。

## Driver buffer `pDriverBufferChA`: `ps4000aSetDataBuffer` function

在设置Data buffer时，使用了`ps4000aSetDataBuffer`函数：

```matlab
overviewBufferSize  = 250000; % Size of the buffer(s) to collect data from the driver's buffer(s).
segmentIndex        = 0;   
ratioMode           = ps4000aEnuminfo.enPS4000ARatioMode.PS4000A_RATIO_MODE_NONE;

% Buffers to be passed to the driver
pDriverBufferChA = libpointer('int16Ptr',zeros(overviewBufferSize,1,'int16'));

status.setDataBufferChA = invoke(ps4000aDeviceObj, 'ps4000aSetDataBuffer', ...
    channelA, pDriverBufferChA, overviewBufferSize, segmentIndex, ratioMode);
```

![image-20230313124731594](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230313124731594.png?raw=true)

改代码将buffer size设置为250000。

## Application buffer `pAppBufferChA`: `setAppAndDriverBuffers` function

在设置application buffer时，使用的是函数 `setAppAndDriverBuffers`：

```matlab
% Application Buffers - these are for temporarily copying data from the driver.
pAppBufferChA = libpointer('int16Ptr',zeros(overviewBufferSize,1));

% Streaming properties and functions are located in the Instrument Driver's Streaming group.
streamingGroupObj = get(ps4000aDeviceObj, 'Streaming');
streamingGroupObj = streamingGroupObj(1);

% Register application buffer and driver buffers (with the wrapper driver).
status.setAppAndDriverBuffersA = invoke(streamingGroupObj, 'setAppAndDriverBuffers', channelA, ...
    pAppBufferChA, pDriverBufferChA, overviewBufferSize);
```

`setAppAndDriverBuffers`函数需要将data buffer和driver buffer都作为输入函数。

## Final buffer `pBufferChAFinal`

创建A通道的final buffer：

```matlab
maxSamples = get(ps4000aDeviceObj, 'numPreTriggerSamples') + ...
    get(ps4000aDeviceObj, 'numPostTriggerSamples');

pBufferChAFinal = libpointer('int16Ptr',zeros(maxSamples,1,'int16'));
```

创建一个指针变量即可，其中`maxSamples`的值为：

```matlab
>> maxSamples
maxSamples =
     2000000
```

## Collect data

### `overviewBufferSize`

在收集数据的时候，仅仅需要使用到的是application buffer`pAppBufferChA`和final buffer`pBufferChAFinal`，两者的关系上文中已经介绍过，不再赘述。需要注意的是，当运行程序时，代码会在命令行窗口打印相关的信息：

```
Collected 139264 samples, startIndex: 0 total: 139264.
Collected 110736 samples, startIndex: 139264 total: 250000.

Collected 237424 samples, startIndex: 0 total: 487424.
Collected 12576 samples, startIndex: 237424 total: 500000.

Collected 126688 samples, startIndex: 0 total: 626688.
Collected 69632 samples, startIndex: 126688 total: 696320.
Collected 53680 samples, startIndex: 196320 total: 750000.

Collected 15952 samples, startIndex: 0 total: 765952.
Collected 69632 samples, startIndex: 15952 total: 835584.
Collected 69632 samples, startIndex: 85584 total: 905216.
Collected 69632 samples, startIndex: 155216 total: 974848.
Collected 25152 samples, startIndex: 224848 total: 1000000.

Collected 44480 samples, startIndex: 0 total: 1044480.
Collected 69632 samples, startIndex: 44480 total: 1114112.
Collected 69632 samples, startIndex: 114112 total: 1183744.
Collected 66256 samples, startIndex: 183744 total: 1250000.

Collected 3376 samples, startIndex: 0 total: 1253376.
Collected 69632 samples, startIndex: 3376 total: 1323008.
Collected 69632 samples, startIndex: 73008 total: 1392640.
Collected 69632 samples, startIndex: 142640 total: 1462272.
Collected 37728 samples, startIndex: 212272 total: 1500000.

Collected 31904 samples, startIndex: 0 total: 1531904.
Collected 69632 samples, startIndex: 31904 total: 1601536.
Collected 69632 samples, startIndex: 101536 total: 1671168.
Collected 69632 samples, startIndex: 171168 total: 1740800.
Collected 9200 samples, startIndex: 240800 total: 1750000.

Collected 60432 samples, startIndex: 0 total: 1810432.
Collected 69632 samples, startIndex: 60432 total: 1880064.
Collected 69632 samples, startIndex: 130064 total: 1949696.
Collected 50304 samples, startIndex: 199696 total: 2000000.
AutoStop: TRUE - exiting loop.

Number of samples available from the driver: 2000000.
```

可以看到，当使用application buffer收集数据时，每一次收集到的数据量是不同的，但是当收集到`250000`个数据点时，就会清掉之前buffer中的数据，重新利用这一块application buffer进行收集，这一过程重复了8次。这个点数是由`overviewBufferSize`变量决定的。如果修改`overviewBufferSize`值为`500000`，则会发生相应的改变：

```
Collected 139264 samples, startIndex: 0 total: 139264.
Collected 278528 samples, startIndex: 139264 total: 417792.
Collected 69632 samples, startIndex: 417792 total: 487424.
Collected 12576 samples, startIndex: 487424 total: 500000.

Collected 126688 samples, startIndex: 0 total: 626688.
Collected 69632 samples, startIndex: 126688 total: 696320.
Collected 69632 samples, startIndex: 196320 total: 765952.
Collected 69632 samples, startIndex: 265952 total: 835584.
Collected 69632 samples, startIndex: 335584 total: 905216.
Collected 69632 samples, startIndex: 405216 total: 974848.
Collected 25152 samples, startIndex: 474848 total: 1000000.

Collected 44480 samples, startIndex: 0 total: 1044480.
Collected 69632 samples, startIndex: 44480 total: 1114112.
Collected 69632 samples, startIndex: 114112 total: 1183744.
Collected 69632 samples, startIndex: 183744 total: 1253376.
Collected 69632 samples, startIndex: 253376 total: 1323008.
Collected 69632 samples, startIndex: 323008 total: 1392640.
Collected 69632 samples, startIndex: 392640 total: 1462272.
Collected 37728 samples, startIndex: 462272 total: 1500000.

Collected 31904 samples, startIndex: 0 total: 1531904.
Collected 69632 samples, startIndex: 31904 total: 1601536.
Collected 69632 samples, startIndex: 101536 total: 1671168.
Collected 69632 samples, startIndex: 171168 total: 1740800.
Collected 69632 samples, startIndex: 240800 total: 1810432.
Collected 69632 samples, startIndex: 310432 total: 1880064.
Collected 69632 samples, startIndex: 380064 total: 1949696.
Collected 50304 samples, startIndex: 449696 total: 2000000.
AutoStop: TRUE - exiting loop.
```

### `maxSamples`

同样地，代码为final buffer也设置了指定的长度，即`maxSamples`的值，长度为2000000，这个值是由`numPreTriggerSamples`和`numPostTriggerSamples`的值共同决定的：

```matlab
maxSamples = get(ps4000aDeviceObj, 'numPreTriggerSamples') + ...
    get(ps4000aDeviceObj, 'numPostTriggerSamples');
```

当收集到这个数量的值时，程序就会停止收集数据（auto stop），这一点在官方文档中也可以看到：

![image-20230313132544155](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230313132544155.png?raw=true)

如果我们想要修改`maxSamples`的值，则需要修改前面对应的设置这两个值的代码，例如修改为收集300000个点：

```matlab
% Set the number of pre- and post-trigger samples
% If no trigger is set 'numPreTriggerSamples' is ignored
set(ps4000aDeviceObj, 'numPreTriggerSamples', 0);
set(ps4000aDeviceObj, 'numPostTriggerSamples', 1000000);
...
maxSamples = get(ps4000aDeviceObj, 'numPreTriggerSamples') + ...
    get(ps4000aDeviceObj, 'numPostTriggerSamples');
```

则效果为：

```
Collected 208896 samples, startIndex: 0 total: 208896.
Collected 278528 samples, startIndex: 208896 total: 487424.
Collected 12576 samples, startIndex: 487424 total: 500000.

Collected 57056 samples, startIndex: 0 total: 557056.
Collected 69632 samples, startIndex: 57056 total: 626688.
Collected 69632 samples, startIndex: 126688 total: 696320.
Collected 69632 samples, startIndex: 196320 total: 765952.
Collected 69632 samples, startIndex: 265952 total: 835584.
Collected 69632 samples, startIndex: 335584 total: 905216.
Collected 69632 samples, startIndex: 405216 total: 974848.
Collected 25152 samples, startIndex: 474848 total: 1000000.
AutoStop: TRUE - exiting loop.

Number of samples available from the driver: 1000000.
```

但是这一值仅仅只是针对auto stop这一行为而设定的。如果我们将`autostop`关掉：

```matlab
% The autoStop parameter can be set to false (0).
set(streamingGroupObj, 'autoStop', PicoConstants.FALSE);
```

虽然此时仍然是将final buffer的长度设置为100000，但是如果我们不点击停止按钮，则就会一直收集数据：

```
...

Collected 499744 samples, startIndex: 0 total: 35999744.
Collected 256 samples, startIndex: 499744 total: 36000000.

Collected 487168 samples, startIndex: 0 total: 36487168.
Collected 12832 samples, startIndex: 487168 total: 36500000.

Collected 474592 samples, startIndex: 0 total: 36974592.
Collected 25408 samples, startIndex: 474592 total: 37000000.

Collected 462016 samples, startIndex: 0 total: 37462016.
Collected 37984 samples, startIndex: 462016 total: 37500000.

Collected 449440 samples, startIndex: 0 total: 37949440.
Collected 50560 samples, startIndex: 449440 total: 38000000.

Collected 449439 samples, startIndex: 0 total: 38449439.
STOP button clicked - aborting data collection.

Collected 50561 samples, startIndex: 449439 total: 38500000.
STOP button clicked - aborting data collection.

Number of samples available from the driver: 1000000.
```

并不会报错。

<br>
