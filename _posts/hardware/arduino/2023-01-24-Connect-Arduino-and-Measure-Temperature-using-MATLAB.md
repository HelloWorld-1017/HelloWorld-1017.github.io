---
title: Connect Arduino and Measure Temperature using MATLAB
toc: false
categories: 
 - Hardware
 - MATLAB
tags: 
 - Arduino
 - MATLAB Support Package for Arduino Hardware
date: 2023-01-24 21:25:03 +0800
last_modified_at: 2024-10-23 19:53:27 +0800
---

本博客所使用硬件（包括：Arduino，扩展板以及温度传感模块）以及代码原理与博客[Correction and Supplement for Blog “An Arduino Sample Project Based on Temperature Sensor”](http://whatastarrynight.com/arduino/c/Correction-and-Supplement-for-Blog-An-Arduino-Sample-Project-Based-on-Temperature-Sensor/) 中介绍完全一致，唯一的差别就是本博客使用MATLAB进行编程。

脚本文件如下：

```matlab
clc, clear, close all

B = 4275;
R0 = 100000;

a = arduino;
while true
    % Read output voltage 
    outputValue = readVoltage(a, 'A0');

    % Calculate resistance
    resistance = (5/outputValue-1)*R0;

    % Convert resistance to temperature
    temperature = 1/(log(resistance/R0)/B+1/298.15)-273.15;
    disp(['temperature = ', num2str(temperature)])
    pause(0.1)
end
```

运行后可以看到在命令行窗口中的持续输出：

![image-20230124205608726](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230124205608726.png?raw=true)

代码中的变量`a`是一个`arduino`类的对象：

```matlab
>> a
                  Port: 'COM3'
                 Board: 'Uno'
         AvailablePins: {'D2-D13', 'A0-A5'}
  AvailableDigitalPins: {'D2-D13', 'A0-A5'}
      AvailablePWMPins: {'D3', 'D5-D6', 'D9-D11'}
   AvailableAnalogPins: {'A0-A5'}
    AvailableI2CBusIDs: [0]
             Libraries: {'I2C', 'SPI', 'Servo'}
   AnalogReferenceMode: 'internal'
       AnalogReference: 5.000(V)
              BaudRate: 115200
```

可以很清楚地看到工作电压为5 V，但是我不太清楚为什么这里额波特率为115200，之前在Arduino IDE中一直使用的都是9600.

可以通过代码：

```matlab
methods(a)
```

查看`arduino`类支持的方法：

```matlab
Methods for class arduino:

addon                  getBLEConnectedStatus  rotaryEncoder          writeDigitalPin        
apds9960               motorCarrier           scanI2CBus             writePWMDutyCycle      
canChannel             playTone               servo                  writePWMVoltage        
configurePin           readDigitalPin         shiftRegister          
device                 readVoltage            ultrasonic             

Methods of arduino inherited from handle.
```

这里主要使用了`readVoltage`函数读取模拟输入。

根据博客[Correction and Supplement for Blog “An Arduino Sample Project Based on Temperature Sensor”](http://whatastarrynight.com/arduino/c/Correction-and-Supplement-for-Blog-An-Arduino-Sample-Project-Based-on-Temperature-Sensor/)，Arduino板实际上输出的是0~1023之间的整数，因此在Arduino IDE中需要使用代码：

```c++
float R = 1023.0/a-1.0;
R = R0*R;
```

计算NTC电阻值。而MATLAB的`readVoltage`函数直接读取的就是电压值，因此只需要使用：

```matlab
% Calculate resistance
resistance = (5/outputValue-1)*R0;
```

计算NTC电阻值即可。

<br>