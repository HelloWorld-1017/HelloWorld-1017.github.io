---
title: Correction and Supplement for Blog "An Arduino Sample Project Based on Temperature Sensor"
categories:
 - C
 - Hardware
tags:
 - Arduino
date: 2023-01-24 20:04:03 +0800
last_modified_at: 2024-10-23 20:08:00 +0800
---

# Introduction

之前在学习温度传感器模块的时候（博客[An Arduino Sample Project Based on Temperature Sensor - What a starry night~](http://whatastarrynight.com/hardware/c/An-Arduino-Sample-Project-Based-on-Temperature-Sensor/)，后简称为“博客”），有一个问题没有解决，没有搞清楚Arduino端口的输出值与电阻值之间的转换关系。但其实问题不止于此，我忽略了很多重要的东西，因此这篇博客意在对上一篇博客进行纠正和补充。

<br>

# The Different Versions of Temperature Sonsors

首先，在[博客](http://whatastarrynight.com/arduino/c/An-Arduino-Sample-Project-Based-on-Temperature-Sensor/)的学习中，我参考的文档以及所采用的代码都来自文档：[Grove - Temperature Sensor](https://wiki.seeedstudio.com/Grove-Temperature_Sensor/)，但实际上这篇文档介绍的是V1.0版本的温度模块，而我购买的是V1.2版本，应当参考文档[Grove - Temperature Sensor V1.2](https://wiki.seeedstudio.com/Grove-Temperature_Sensor_V1.2/#play-with-arduino)（这篇wiki同样适用于V1.1版本）。V1.2版本的温度模块实际运行的代码应该是这样的：

```c++
// Demo code for Grove - Temperature Sensor V1.1/1.2
// Loovee @ 2015-8-26
 
#include <math.h>
 
const int B = 4275;               // B value of the thermistor
const int R0 = 100000;            // R0 = 100k
const int pinTempSensor = A0;     // Grove - Temperature Sensor connect to A0
 
#if defined(ARDUINO_ARCH_AVR)
#define debug  Serial
#elif defined(ARDUINO_ARCH_SAMD) ||  defined(ARDUINO_ARCH_SAM)
#define debug  SerialUSB
#else
#define debug  Serial
#endif
 
void setup()
{
    Serial.begin(9600);
}
 
void loop()
{
    int a = analogRead(pinTempSensor);
 
    float R = 1023.0/a-1.0;
    R = R0*R;
 
    float temperature = 1.0/(log(R/R0)/B+1/298.15)-273.15; // convert to temperature via datasheet
 
    Serial.print("temperature = ");
    Serial.println(temperature);
 
    delay(100);
}
```

<br>

# From Arduino Output Value to Resistance

上述代码中：

```c++
float R = 1023.0/a-1.0;
R = R0*R;
```
实现Arduino输出值与电阻值之间的转换

```c++
float temperature = 1.0/(log(R/R0)/B+1/298.15)-273.15;
```

实现电阻值与温度值之间的转换。

后者（即NTC电阻的RT特性）可以完全按照[博客](http://whatastarrynight.com/arduino/c/An-Arduino-Sample-Project-Based-on-Temperature-Sensor/)中所述进行理解，没有问题；重点还是理解Arduino输出值与电阻值的转换。

实际上，该模块中集成了一个voltage divider（[Lesson 11 : Temperature sensor Grove module. - YouTube](https://www.youtube.com/watch?v=wjL7xOGqAqg&t=4s)）：（选用100k电阻是因为NTC在25摄氏度时的电阻值就是100k）

![image-20230114134916769](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230114134916769.png?raw=true)

因此端口的输出电压$V$与工作电压$V_{CC}$之间存在比例关系：

$$
V = V_{CC}\dfrac{R_0}{R_0+NTC}\notag
$$

$$
\dfrac{V}{V_{CC}} = \dfrac{R_0}{R_0+NTC}\notag
$$

$$
NTC=V_{CC}\dfrac{R_0}{V}-R_0\notag
$$

$$
NTC=(\dfrac{V_{CC}}{V}-1)R_0\notag
$$

具体而言，NTC与输出电压的转换关系应该是：

$$
NTC=(\dfrac{5}{V}-1)R_0\label{eq1}
$$

但是，Arduino端口的输出值`a`并不是电压值。根据Arduino官方关于`ananologRead()`函数的文档（[analogRead() - Arduino Reference](https://www.arduino.cc/reference/en/language/functions/analog-io/analogread/)），Arduino板实际上包含了一个10-bit模数转换器（10-bit analog to digital converter），这意味着Arduino会将工作电压（即5V，下文中将再次强调这一电压值）范围内的值映射为0~1023之间的整数输出：

> Reads the value from the specified analog pin. Arduino boards contain a multichannel, 10-bit analog to digital converter. This means that it will map input voltages between 0 and the operating voltage(5V or 3.3V) into integer values between 0 and 1023. 

注：这也意味着resolution为 5 volts / 1024 units，即0.0049 volts (4.9 mV) per unit.
{: .notice--primary}

因此，式$\eqref{eq1}$中的电压（模拟量）比值$\dfrac5V$可以改为实际输出（数字量）比值$\dfrac{1023}{a}$：

$$
NTC=(\dfrac{1023}{a}-1)R_0
$$

这就是上面代码计算的原理。

此时再观察[博客](http://whatastarrynight.com/arduino/c/An-Arduino-Sample-Project-Based-on-Temperature-Sensor/)中使用的转换代码：

```c++
a = analogRead(0); // Read analog A0 output value
resistance = (float)(1023-a)*10000/a; //get the resistance of the sensor;
```

可以发现它与本文所采用的代码：

```c++
float R = 1023.0/a-1.0;
R = R0*R;
```

完全是等效的，只是两个版本热敏电阻的Zero Power Resistance at 25 $^\circ \mathrm{C}$是不同的而已！！！更进一步地讲，[博客](http://whatastarrynight.com/arduino/c/An-Arduino-Sample-Project-Based-on-Temperature-Sensor/)中运行的代码与本博客中的代码在实现原理上是一致的，差别就在于NTC电阻的$B$值和$R_0$值不同

<br>

# Operating Voltage

第二个问题是Arduino工作电压的问题。我所使用的扩展板上[Grove Base Shield V2](https://wiki.seeedstudio.com/Base_Shield_V2/)有一个调整工作电压的开关（可选3.3V或5.0V）：

![image-20230124185657874](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230124185657874.png?raw=true)

我之前并不在意这个开关，但这个工作很重要。仍然是`ananologRead()`函数的文档（[analogRead() - Arduino Reference](https://www.arduino.cc/reference/en/language/functions/analog-io/analogread/)）：

![image-20230124195203036](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230124195203036.png?raw=true)

这里明确指出Arduino Uno的工作电压是5 Volts，因此需要始终把它调整到5 V的位置。如果将其调整到3.3V的位置，就会出现错误。对于LED灯而言，它的亮度会变暗；而对于本文所使用的温度传感器，则会导致明显的输出错误。

工作电压为5 V时打印的环境温度值：

![image-20230124195524904](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230124195524904.png?raw=true)

工作电压为3.3 V时打印的环境温度值：

![image-20230124195554249](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230124195554249.png?raw=true)

<br>





