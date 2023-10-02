---
layout: single
title:  Introduction to Grove Base Shield and Grove Cable (Arduino Kits)
date: 2023-01-13 20:49:47 +0800
categories: 
 - Hardware
tags:
 - Arduino
---

# Introduction

我在学习Arduino时，购买的是Seeed Studio公司的套件。为了扩展Arduino的接口并简化搭建项目时的连线，Seeed Studio公司研发了[Grove生态系统](https://wiki.seeedstudio.com/Grove_System/)，该系统主要包含三部分：Grove Base Shield，Grove Cable和各种各样的Grove模块。Grove Base Shield和Grove Cable具有通用性，所有的项目都会使用到它们，本博客主要对它们进行学习。

<br>

# Grove Base Shield and Grove Cable

[Grove Base Shield V2](https://wiki.seeedstudio.com/Base_Shield_V2/)是一块扩展板：

![image-20230113080428876](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113080428876.png?raw=true)

它直接安装在Arduino的顶部，以扩展Grove端口的数量，它具有7个数字端口（D2\~D8），4个模拟端口（A0\~A3），4个I2C端口和1个UART端口。Grove端口通过Grove数据线与外部Grove模块（带有Grove端口的模块）进行连接，简化电路连线。

最常用的连接Grove Base Shiled和Grove模块的Grove数据线（4针Grove接口连接线，Standard Cable，后面简称为Cable）包含4根不同颜色的线（[Grove System: Grove Cables](https://wiki.seeedstudio.com/Grove_System/#grove-cables)，[How To Choose The Right Cable](https://wiki.seeedstudio.com/How_To_Choose_The_Right_Cable/)）：

![image-20230113081818412](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113081818412.png?raw=true)

其中：

- pin 4：黑色连接线（连接GND端口，即电源负极）
- pin 3：红色连接线（连接VCC端口，即电源正极）
- pin 2：白色连接线（数据线2）
- pin 1：黄色连接线（数据线1）

> 除Standard Cable之外，还有一些其他的类型的数据线
>
> ![image-20230113182420907](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113182420907.png?raw=true)

对于Shiled上不同类型的端口，Cable的四根线与Grove Base Shiled端口引脚（对应Arduino引脚）的对应关系是不一样的，下面将分别介绍。

<br>

# Various Ports 

## Digital Ports

Grove Base Shiled一共有7个数字端口，分别是D2\~D8：

![image-20230113191311446](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113191311446.png?raw=true)

这些数字端口的前两个引脚分别是GND，VCC引脚，分别与Cable的pin4和pin3连接；下面的两个引脚分别是Dn+1和Dn引脚（例如对于数字端口D2，分别对应Arduino的D3引脚和D2引脚，后面的端口依次类推），分别与Cable的pin2和pin1相连：

![image-20230113083727961](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113083727961.png?raw=true)

大多数模块只使用Dn引脚。例如，在博客[An Arduino Sample Project Based on Vibration Sensor](http://whatastarrynight.com/arduino/c/An-Arduino-Sample-Project-Based-on-Vibration-Sensor/)中使用的振动传感器模块[Grove - Vibration Sensor(SW-420) ](https://wiki.seeedstudio.com/Grove-Vibration_Sensor_SW-420/)：

![image-20230113195123086](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113195123086.png?raw=true)

和蜂鸣器模块[Grove - Buzzer](https://wiki.seeedstudio.com/Grove-Buzzer/)，它们都将SIG（Signal）引脚Shiled的Dn引脚，将NC（Not Connected）引脚与Shiled的Dn+1引脚相连。

但是有些模块会使用两个引脚，例如[Grove - LED Button](https://wiki.seeedstudio.com/Grove-LED_Button/)模块：

![image-20230113195408765](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113195408765.png?raw=true)

会同时用到两个数据引脚。

## Analog Ports

Grove Base Shiled一共有4个模拟端口，分别是A0\~A3：

![image-20230113195558430](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113195558430.png?raw=true)

与数字端口类似，这些模拟端口的前两个引脚分别是GND，VCC引脚，分别与Cable的pin4和pin3连接。下面的两个引脚分别是An+1和An引脚，分别与Cable的pin2和pin1相连。

![image-20230113083739832](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113083739832.png?raw=true)

大多数模块只使用An引脚。例如，在博客[An Arduino Sample Project Based on Temperature Sensor](http://whatastarrynight.com/arduino/c/An-Arduino-Sample-Project-Based-on-Temperature-Sensor/)中使用的温度传感器模块[Grove - Temperature Sensor](https://wiki.seeedstudio.com/Grove-Temperature_Sensor/)；同样地，也有的模块同时使用An引脚和An+1引脚，例如[Grove - Thumb Joystick](https://wiki.seeedstudio.com/Grove-Thumb_Joystick/)。

## UART Ports

Grove UART是Shiled上一个特殊的数字输入输出接口：

![image-20230113201137392](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113201137392.png?raw=true)

该使用RX引脚（从上到下第四个引脚）串行接收数据，使用TX引脚（从上到下第三个引脚，上图中似乎误标注为DX引脚）串行发送数据：

![image-20230113083753079](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113083753079.png?raw=true)

## I2C Ports

Grove Base Shiled一共有4个I2C端口：

![image-20230113202028310](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113202028310.png?raw=true)

这四个端口所连接的引脚完全一致（因为Arduino本身值具有一个SCL引脚和一个SDA引脚），可以看做是一根I2C总线分出来的四个端口。

I2C端口具有标准布局。引脚1是SCL信号，引脚2是SDA信号，电源和接地与其他端口相同：

![image-20230113083825781](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230113083825781.png?raw=true)

在博客[An Arduino Sample Project Based on Liquid Crystal Display (LCD)](http://whatastarrynight.com/arduino/c/An-Arduino-Sample-Project-Based-on-Liquid-Crystal-Display-(LCD)/)中使用的[Grove - 16x2 LCD](https://wiki.seeedstudio.com/Grove-16x2_LCD_Series/)就需要使用I2C端口。

许多类型的Grove传感器都能使用I2C端口，但是需要注意的是，大多数器件都可同时支持5V / 3.3V，但有少数**只**支持3.3V或只支持5.0V，在使用前需要仔细检查电压参数。

<br>
