---
layout: single
title:  An Arduino Sample Project Based on Vibration Sensor
date: 2023-01-10 21:18:17 +0800
categories: 
 - Hardware
 - C
tags:
 - C Warnings and Errors
 - Arduino
---

# Introduction

本博客使用Arduino、振动传感器和蜂鸣器复刻了一个示例项目[Grove - Vibration Sensor(SW-420): Play With Arduino](https://wiki.seeedstudio.com/Grove-Vibration_Sensor_SW-420/#play-with-arduino)，并在此基础上开展了一些试验和讨论。

<br>

# Vibration Sensor

本项目所采用的振动传感器模块是Seeed Studio公司Grove套件中的Vibration Sensor(SW-420)：

![image-20230110195353558](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110195353558.png?raw=true)

产品官方文档见：[Grove - Vibration Sensor(SW-420) - Seeed Wiki](https://wiki.seeedstudio.com/Grove-Vibration_Sensor_SW-420/)。该官方文档中提供了该振动模块的电路的`.sch`文件、`.brd`文件：

![image-20230110193936566](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110193936566.png?raw=true)

![image-20230110193953904](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110193953904.png?raw=true)

均可下载学习。

> 注：
>
> 下载的压缩包解压后有几个文件：
>
> ![image-20230110194323884](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110194323884.png?raw=true)
>
> 我们在Altium Designer软件中打开`.PrjPcb`后缀的项目文件即可打开这个项目，就可以看到项目下的所有文件：
>
> ![image-20230110194553613](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110194553613.png?raw=true)

SW-420是振动模块中振动传感器的型号：

![image-20230110195736085](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110195736085.png?raw=true)

这是一个高灵敏度、非定向（non-directional）的振动传感器。当模块是稳定的时候，电路接通并输出高电平；当模块发生运动或者振动时，电路将短暂断开并输出低电平。

<br>

# Buzzer

项目所采用的蜂鸣器同样来自Grove套件（[Grove - Buzzer - Seeed Wiki](https://wiki.seeedstudio.com/Grove-Buzzer/)）：

![image-20230110195459813](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110195459813.png?raw=true)

该模块的主要部件是一个压电蜂鸣器（[piezo buzzer](https://en.wikipedia.org/wiki/Buzzer#Piezoelectric)），它可以连接到**数字端口输出**，当输出为高电平时，它会发出声音。

我们将模块连接到D6端口，之后烧录以下示例程序：

```c++
//assign buzzer as pin 6
#define buzzer 6

void setup()
{
  //set buzzer as output
  pinMode(buzzer, OUTPUT);
}

void loop()
{ //turn on buzzer(set logic level high)
  digitalWrite(buzzer, HIGH);
  //wait 5s
  delay(5000);
  //turn off buzzer(set logic level low)
  digitalWrite(buzzer, LOW);
  //wait 1s
  delay(1000);
}
```

可以看到我们设置高低电平的效果，蜂鸣器响的时间比较长（5s），停的时间比较短（1s）。

> Arduino程序至少有两个代码块，每一块都有一组用大括号括起来的语句：
>
> ```c++
> void setup()
> {
>     //statement 1;
> }
> 
> void loop()
> {
>     //statement 2;
> }
> ```
>
> 其中：
>
> - `setup()`部分：这部分的功能是准备函数，在程序开始时调用，通常用于
>   - 初始化变量
>   - 初始化引脚模式
>   - 启动串行通信等等
> - `loop()`部分：在执行`setup()`函数之后，接下来就将执行`loop()`函数。`loop()`函数将执行诸如读取输入、触发输出等之类的语句。该函数是代码的主要部分，将循环运行。

<br>

# Project

本博客所搭建的项目来自[Grove - Vibration Sensor(SW-420): Play With Arduino](https://wiki.seeedstudio.com/Grove-Vibration_Sensor_SW-420/#play-with-arduino)，该项目实现的功能很简单：当振动传感器振动时，蜂鸣器发出高频警报声。

我们将振动传感器连接到D2端口，将蜂鸣器连接到D3端口：

![image-20230110203517589](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110203517589.png?raw=true)

烧录下面的程序：


```c++
// constants won't change. They're used here to set pin numbers:
const int vibrationPin = 2;     // the number of the vibration pin
const int buzzer =  3;      // the number of the buzzer pin

// variables will change:
int state = 0;         // variable for reading the viabration sensor status

void setup() {
  // initialize the buzzer  as an output:
  pinMode(buzzer, OUTPUT);
  // initialize the viabraiton as an input:
  pinMode(vibrationPin, INPUT);
}

void loop() {
  // read the state of the viabration value:
  state = digitalRead(vibrationPin);

  if (state == HIGH) {
    // turn Buzzer off:
    digitalWrite(buzzer, LOW);
  } else {
    // turn Buzzer on:
    digitalWrite(buzzer, HIGH);
  }
```

前文提到，振动传感器振动时输出低电平，蜂鸣器接收到高电平时发出声音。依据这样的特性，上面代码使用`if`条件结构实现我们想要的功能：振动传感器输出低电平时，蜂鸣器发出声音。

<br>

# Experiments

在上述项目的基础上，我开展了以下几个简单的试验。

**Experiment 1**：如果将D2端口的振动传感器拔掉，那么D2将始终处于低电平的状态，蜂鸣器将持续发出声音；

**Experiment 2**：我们可以通过旋转振动模块上的电位器控制传感器的灵敏度：

![image-20230110204310766](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110204310766.png?raw=true)

但是这个电位器是可以向着一个方面一直旋转的，灵敏度的控制效果并不好；

**Experiment 3**：上面提到，`setup()`部分代码可以初始化变量，但是我将前面初始化的语句放入到`setup()`中：

```c++
void setup() {
  // constants won't change. They're used here to set pin numbers:
  const int vibrationPin = 2;     // the number of the vibration pin
  const int buzzer =  3;      // the number of the buzzer pin
  // variables will change:
  int state = 0;         // variable for reading the viabration sensor status

  // initialize the buzzer  as an output:
  pinMode(buzzer, OUTPUT);
  // initialize the viabraiton as an input:
  pinMode(vibrationPin, INPUT);
}
```

结果程序就会报错：

```
C:\Users\Tsing\Desktop\vibration_sensor_buzzer\vibration_sensor_buzzer.ino: In function 'void loop()':
C:\Users\Tsing\Desktop\vibration_sensor_buzzer\vibration_sensor_buzzer.ino:16:3: error: 'state' was not declared in this scope
   state = digitalRead(vibrationPin);
   ^~~~~
C:\Users\Tsing\Desktop\vibration_sensor_buzzer\vibration_sensor_buzzer.ino:16:3: note: suggested alternative: 'static'
   state = digitalRead(vibrationPin);
   ^~~~~
   static
C:\Users\Tsing\Desktop\vibration_sensor_buzzer\vibration_sensor_buzzer.ino:16:23: error: 'vibrationPin' was not declared in this scope
   state = digitalRead(vibrationPin);
                       ^~~~~~~~~~~~
C:\Users\Tsing\Desktop\vibration_sensor_buzzer\vibration_sensor_buzzer.ino:20:18: error: 'buzzer' was not declared in this scope
     digitalWrite(buzzer, LOW);
                  ^~~~~~
C:\Users\Tsing\Desktop\vibration_sensor_buzzer\vibration_sensor_buzzer.ino:23:18: error: 'buzzer' was not declared in this scope
     digitalWrite(buzzer, HIGH);
                  ^~~~~~

exit status 1

Compilation error: 'state' was not declared in this scope
```

报错信息表明这样的代码是起不到声明（declare）的作用的。

后来我突然想起来，在C语言中，语句：

```c++
int state = 0; 
```

其实是将声明和初始化放在了一起。因此，前面“`setup()`部分用来初始化变量”的说法是没有问题的，即代码：

```c++
const int vibrationPin = 2; 
const int buzzer = 3;     
int state;         

void setup() {
  state = 0;
  // initialize the buzzer  as an output:
  pinMode(buzzer, OUTPUT);
  // initialize the viabraiton as an input:
  pinMode(vibrationPin, INPUT);
}
```

将声明与初始化分开，变量`state`的初始化放在`setup()`部分是没有错误的，但是它的声明一定要放在最开始！！！

另外需要注意的是，对于整型常数`const int vibrationPin = 2;`，我们不能采用类似将声明与初始化分开的方式，否则就会报错。

```c++
const int vibrationPin;    
const int buzzer;      
int state; 

void setup() {
  vibrationPin = 2;
  buzzer = 3;
  state = 0;
  // initialize the buzzer  as an output:
  pinMode(buzzer, OUTPUT);
  // initialize the viabraiton as an input:
  pinMode(vibrationPin, INPUT);
}
```

可以看到程序报错：

```
C:\Users\Tsing\Desktop\vibration_sensor_buzzer\vibration_sensor_buzzer.ino: In function 'void setup()':
C:\Users\Tsing\Desktop\vibration_sensor_buzzer\vibration_sensor_buzzer.ino:8:18: error: assignment of read-only variable 'vibrationPin'
   vibrationPin = 2;
                  ^
C:\Users\Tsing\Desktop\vibration_sensor_buzzer\vibration_sensor_buzzer.ino:9:12: error: assignment of read-only variable 'buzzer'
   buzzer = 3;
            ^
exit status 1
Compilation error: assignment of read-only variable 'vibrationPin'
```

<br>







