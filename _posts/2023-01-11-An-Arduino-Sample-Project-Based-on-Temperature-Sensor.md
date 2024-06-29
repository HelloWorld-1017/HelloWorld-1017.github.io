---
layout: single
title:  An Arduino Sample Project Based on Temperature Sensor
date: 2023-01-11 12:03:04 +0800
categories: 
 - Hardware
 - C
tags:
 - Arduino
---

# Introduction

本博客学习使用Grove套件的温度传感模块搭建示例项目[Grove - Temperature Sensor: With Arduino](https://wiki.seeedstudio.com/Grove-Temperature_Sensor/#with-arduino)，该项目采用的温度传感器模块（[Grove - Temperature Sensor](https://wiki.seeedstudio.com/Grove-Temperature_Sensor/)）：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111095119452.png?raw=true" alt="image-20230111095119452" style="zoom: 50%;" />

该温度传感器模块采用的是TTC3A103-39H热敏电阻（[thermistor](https://en.wikipedia.org/wiki/Thermistor)），这是一个NTC热敏电阻（negative temperature coefficient thermistor），即电阻的阻值随着环境温度的下降而增加。

<br>

# Project

将温度传感器模块接入到Arduino的模拟A0端口：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111095445576.png?raw=true" alt="image-20230111095445576" style="zoom:67%;" />

并烧录以下程序：

```c++
#include <math.h>

int B = 3975;                  //B value of the thermistor
int a;
float temperature;
float resistance;

void setup()
{
    Serial.begin(9600);
}

void loop()
{
    a = analogRead(0); // Read analog A0 output value
    resistance = (float)(1023-a)*10000/a; //get the resistance of the sensor;
    temperature = 1/(log(resistance/10000)/B+1/298.15)-273.15;//convert to temperature via datasheet&nbsp;
    delay(1000);
    Serial.print("Current temperature is ");
    Serial.println(temperature);
}
```

之后，我们可以打开Serial Monitor监视温度的输出值：

![image-20230111095702194](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111095702194.png?raw=true)

也可以打开Serial Plotter观看绘制的曲线：

![image-20230111095747184](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111095747184.png?raw=true)

下面，我们就学习一下上述的代码片段。



# `Serial.begin(9600)`

代码在`setup()`部分进行了这样的设置：

```c++
Serial.begin(9600);
```

博客[What is Serial.begin(9600)? - Programming Electronics Academy](https://www.programmingelectronics.com/serial-begin-9600/)在实践上对这一行代码做出了通俗的解释，下面是我对这篇博客的思想进行简单的学习总结。

`Serial.begin(9600);`出现在很多的代码中。函数`Serial.begin()`的作用是在Arduino板和另一台设备之间建立串行通信（serial communication），最常见的场景就是我们使用USB连接线（即**Universal Serial Bus cable**，通用串行总线电缆）将Arduino与PC连接。当我们在两台设备之间建立了串行通信后，函数`Serial.begin()`就允许两台设备使用串行协议（serial protocol）进行通信。

（1）我们在什么时候需要使用`Serial.begin()`函数呢？

使用`Serial.begin()`函数最常见的原因是：我们想要从Arduino中输出一些信息到我们的电脑屏幕上，也就是说，我们想要打印一些文本。用于将Arduino输出的信息打印到电脑屏幕上展示的函数是`Serial.print()`，例如

```c
void setup() {
  Serial.begin(9600);
}

void loop() {
  Serial.print("Hello, Arduino!");
}
```

代码会将信息打印在Serial Monitor窗口中：

![image-20230111103429873](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111103429873.png?raw=true)

（需要注意，这里是循环打印）

在其他场景下我们也会用到`Serial.begin()`。例如，我们的计算机上运行着一个程序，该程序期望通过某一端口从Arduino中读取数据，此时我们就需要使用`Serial.begin()`。

（2）代码`Serial.begin()`编写在代码中的哪一部分？

在99%的场景下，我们都会将`Serial.begin()`写在`setup()`部分，因为我们只需要建立一次串行通信。

（3）`Serial.begin(9600)`中的数字9600代表什么？

数字9600被称作波特率（baud rate），表示串行通信每秒可以传输9600个二进制位。在实际使用中，关于波特率最重要的事情是：为了成功建立起串行通信，`Serial.begin()`中的波特率需要与接收设备上设置的波特率匹配。**如果两者的波特率是不匹配的，那么我们试图通过串口所发送到的任何东西都是错的。**

如果是使用Arduino IDE Serial Monitor窗口从Arduino中读取信息，那么我们可以使用baud rate下拉菜单设置波特率：

![image-20230111104847077](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111104847077.png?raw=true)

我们可以简单尝试一下不同波特率所传递的的信息：

![image-20230111105209342](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111105209342.png?raw=true)

![image-20230111105240672](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111105240672.png?raw=true)

![image-20230111105315382](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111105315382.png?raw=true)

<br>

# From Output Value to Resistance to Temperature

温度传感器模块的输出值实际上并不是温度值，要想获得正确的温度值（并且是摄氏温度），则需要一系列值的转换。实现这一功能的代码片段是`loop()`中的：

```c
a = analogRead(0); // Read analog A0 output value
resistance = (float)(1023-a)*10000/a; //get the resistance of the sensor;
temperature = 1/(log(resistance/10000)/B+1/298.15)-273.15;//convert to temperature via datasheet&nbsp;
```

其中：

- 变量`a`是analog A0 output value；
- 变量`resistance`是温度传感器的阻值；
- 变量`temperature`是环境温度值，单位是摄氏度；

## From Resistance to Temperature

我们首先看代码`temperature = 1/(log(resistance/10000)/B+1/298.15)-273.15;`。这段代码实际上表征了温度传感器的阻值与环境温度之间的关系。

我们前面提到过，温度传感器的主要部分是一个NTC热敏电阻，其特性可以使用[B参数方程](https://en.wikipedia.org/wiki/Thermistor#B_or_%CE%B2_parameter_equation)（或称为$\beta$参数方程）：

$$
\dfrac1T=\dfrac1{T_0}+\dfrac1B\ln\dfrac{R}{R_0}
$$

其中：

- 参数B是一个常数，是热敏电阻本身的性质
- 温度和B参数的单位都是开尔文（kelvins）；
- $R_0$是电阻在温度$T_0$（$25^\circ\mathrm{C}=298.15\mathrm{K}$）时的阻值

上式等价于：

$$
R=R_0\exp\Big\{B(\dfrac1T-\dfrac1{T_0})\Big\}
$$

也等价于：

$$
R=r_\infty\exp(B/T)\label{eq1}
$$

其中：

$$
r_\infty=R_0\exp(-B/T_0)\label{eq2}
$$

是一个常数。进一步，我们可以得到：

$$
T=\dfrac{B}{\ln(R/r_\infty)}\label{eq4}
$$

>  另外，方程$\eqref{eq4}$可以进一步改写为：
>  
> $$
> \ln R=B/T+\ln r_\infty\label{eq5}
> $$
> 
> 方程$\eqref{eq5}$表征一条lnR-(1/T)的曲线，我们可以使用这条曲线的斜率估计B参数。

代码：

```c
temperature = 1/(log(resistance/10000)/B+1/298.15)-273.15;
```

所表示的二者关系为：

$$
\begin{split}
T&=\dfrac{1}{\dfrac1B\ln(R/10000)+1/298.15}-273.15\\
&=\dfrac{B}{\ln\dfrac{R}{10000\times\exp(-B/298.15)}}-273.15
\end{split}
$$

其中，$-273.15$表示从开氏温度到摄氏温度之间的转换（$绝对温度(开氏温度)=摄氏温度+273.15$，273.15是绝对零度），将剩余部分与式$\eqref{eq1}$与式$\eqref{eq2}$进行对比，可以得到$R_0\vert_{T=T_0}=10000\ \Omega$。

实际上，$R_0$作为一个常数，应该可以通过传感器的datasheet（或者R-T曲线）获得，但是官网中所提供的热敏电阻TTC3A103-39H的R-T曲线很模糊，并且后面的型号也不是39H。后来，我找到[NTC Thermistor-Veteng](https://www.veteng.com/product/ntc-thermistor-ttc3a103-55.html)提供了该信号的相关参数：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111112842711.png?raw=true" alt="image-20230111112842711" style="zoom:80%;" />

可以看到，该型号热敏电阻的Zero Power Resistance at 25 $^\circ \mathrm{C}$是$10\ \mathrm{k\Omega}$，B参数为3975，与我们代码中的设定是一致的。

## From Output Value to Resistance

我们可以看到，在将电阻值转换成温度值之前，我们需要首先将Arduino A0端口的输出值转换为电阻值：

```c
a = analogRead(0); // Read analog A0 output value
resistance = (float)(1023-a)*10000/a; //get the resistance of the sensor;
```

如果我们进行转换，而直接将端口输出值作为电阻值：

```c
resistance = a;
temperature = 1/(log(resistance/10000)/B+1/298.15)-273.15;
```

则输出值的摄氏温度为：

![image-20230111115106177](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111115106177.png?raw=true)

这些值肯定是不对的，但是我们现在不太清楚转换公式的含义是什么，也不清楚如何在网络上查找资料，因此先搁置在这里。

另一方面，我们可能会问：模拟端口A0的输出值是什么呢？可以简单输出看一下：

![image-20230111121741551](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111121741551.png?raw=true)

可以看到模拟端口A0的输出值是一个一个整数。再进一步，如果把A0端口的温度传感器拔掉，可以看到电脑屏幕上仍会打印值

![image-20230111122131766](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111122131766.png?raw=true)

并且也会变化，但是我目前还不清楚它们端口输出值的具体含义。

<br>

# `Serial.printIn()` Function

代码在打印温度的时候使用了函数`Serial.printIn()` ：

```c
Serial.print("Current temperature is ");
Serial.println(temperature);
```

我们同样可以使`Serial.print()`函数进行打印：

```c
Serial.print("Current temperature is ");
Serial.print(temperature);
```

但是该函数没有末尾的自动换行功能：

![image-20230111115845719](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111115845719.png?raw=true)

两个函数差异的详细阐述可以参考博客：[Arduino编程之Serial.println()和Serial.print() - 腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/2163164#:~:text=Arduino编程之Serial.println ()和Serial.print () Arduino 的输出基本就用两个函数 print 和 println，区别在于后者比前者多了回车换行,(data) 从串行端口输出数据，跟随一个回车（ASCII 13%2C 或 ‘r’）和一个换行符（ASCII 10%2C 或 ‘n’）。)。

<br>



