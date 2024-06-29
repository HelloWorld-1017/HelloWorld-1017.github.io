---
layout: single
title: An Arduino Sample Project Based on Liquid Crystal Display (LCD)
date: 2023-01-12 10:55:51 +0800
categories: 
 - Hardware
 - C
tags:
 - Arduino
---

# Introduction

本博客使用LCD屏幕搭建示例项目：[Grove - 16x2 LCD: Play with Arduino](https://wiki.seeedstudio.com/Grove-16x2_LCD_Series/#play-with-arduino)。该示例项目使用的LCD显示器（Liquid Crystal Display，液晶显示器）来自Grove套件（[Grove - 16x2 LCD](https://wiki.seeedstudio.com/Grove-16x2_LCD_Series/)）：

![image-20230112082835171](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230112082835171.png?raw=true)

示例项目的运行需要使用与硬件配套的[Github: Grove RGB LCD Library](https://github.com/Seeed-Studio/Grove_LCD_RGB_Backlight)，要首先安装：

![image-20230111131428527](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111131428527.png?raw=true)

![image-20230111123913945](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230111123913945.png?raw=true)

之后将LCD屏接到I2C端口（并且接到四个I2C端口中的任意一个都可以，都不影响使用，也不需要修改代码），烧录代码：

```c
//Inclue RBG LCD library
#include <Wire.h>
#include "rgb_lcd.h"

rgb_lcd lcd;

const int colorR = 255;
const int colorG = 0;
const int colorB = 0;

void setup() 
{
    // set up the LCD's number of columns and rows:
    lcd.begin(16, 2);
    
    lcd.setRGB(colorR, colorG, colorB);
    
    // Print a message to the LCD.
    lcd.print("Hello, world!");

    delay(1000);
}

void loop() 
{
    // set the cursor to column 0, line 1
    // (note: line 1 is the second row, since counting begins with 0):
    lcd.setCursor(0, 1);
    // print the number of seconds since reset:
    lcd.print(millis()/1000);

    delay(100);
}
```

最后的效果是LCD的第一行显示“Hello, world"的字样，第二行显示跳动的数字，该数字表示程序运行的秒数：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230112083836037.png?raw=true" alt="image-20230112083836037" style="zoom:80%;" />

<br>

# Code Learning

程序一开始包含了两个头文件：

```c++
//Inclue RBG LCD library
#include <Wire.h>
#include "rgb_lcd.h"
```

不是很清楚头文件` <Wire.h>`的作用，因为注释掉后程序仍可以运行；第二个头文件`"rgb_lcd.h"`就是前面我们下载的Grove RGB LCD Library中的内容。紧接着实例化类`rgb_lcd()`，声明得到一个对象`lcd`：

```c
rgb_lcd lcd;
```

以供后面的程序中调用和使用函数。

## `setup()`

### Initialization

LCD屏幕的初始化，要与屏幕的型号所匹配：

```c
lcd.begin(16, 2);
```

`lcd.begin()`函数的第一个参数表示列，第二参数表示行，这一点有一些别扭；另外，我尝试修改两个参数的值，最后发现第二个参数的影响比较大，例如如果代码改为：

```c
lcd.begin(16, 1);
```

虽然不会报错，但是LCD屏幕的第二行不会显示任何内容。

### Change Color of Backlight

改变LCD背光颜色：

```c
const int colorR = 255;
const int colorG = 0;
const int colorB = 0;

void setup() 
{
    // ...
    lcd.setRGB(colorR, colorG, colorB);
}
```

这部分代码的含义是将背光颜色调整为纯红色，但实际上这里的设置对LCD的显示效果没有任何影响，因为我们使用的这块LCD屏是固定的蓝底白字（White on Blue）显示。

### Hello, world!

代码：

```c
lcd.print("Hello, world!");
```

将"Hello, world!"字样打印在屏幕第一行。但是这块LCD屏不支持中文，例如我们想要输出“你好，世界！”：

```c
lcd.print("你好，世界！");
```

显示的是乱码的内容：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230112093319330.png?raw=true" alt="image-20230112093319330" style="zoom:80%;" />



## `loop()`

### Fix Cursor

代码：

```c++
// set the cursor to column 0, line 1
// (note: line 1 is the second row, since counting begins with 0):
lcd.setCursor(0, 1);
```

是为了固定Cursor在指定位置。我们可以尝试改变一下`lcd.setCursor`的参数。例如：

```c
lcd.setCursor(3, 1);
```

![image-20230112101854633](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230112101854633.png?raw=true)

如果直接将这一行注释掉：

```c++
// lcd.setCursor(3,1);
```

`loop()`部分中打印的数字就不会在固定的位置显示。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230112102240616.png?raw=true" alt="image-20230112102240616" style="zoom:80%;" />

### `lcd.print(millis()/1000);`

`loop()`部分代码的主要功能就是刷新屏幕第二行的数字：

```c
lcd.print(millis()/1000);
delay(100);
```

此时屏幕上所打印的数字是整数，一秒钟变化一次，但是每秒钟屏幕刷新十次。其中，[`millis()`函数](https://www.arduino.cc/reference/en/language/functions/time/millis/)返回的是Arduino的运行时间，单位是毫秒；并且`millis()`函数所返回的数据类型是`unsigned long`，表示**无符号长整型**。

在C语言中，两个整型变量相除，是得不到一个double浮点数的，而是会直接舍去小数部分向下取整，因此屏幕上显示的是整数。如果想要在屏幕上显示小数表示的秒数，则可以使用下面两种方法：

```c++
lcd.print(millis()/1000.00); // Method 1
lcd.print("  "); 
lcd.print((double)millis()/1000); // Method 2
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230112100947579.png?raw=true" alt="image-20230112100947579" style="zoom:80%;" />

<br>











