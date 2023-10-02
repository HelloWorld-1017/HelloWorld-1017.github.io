---
layout: single
title: An Arduino Sample Project Based on LED and Button
date: 2023-01-25 22:42:41 +0800
categories: 
 - Hardware
 - C
 - MATLAB
tags: 
 - Arduino
 - MATLAB Support Package for Arduino Hardware
toc: false
---

本项目采用的LED灯为：[Grove - LED Socket Kit - Seeed Wiki](https://wiki.seeedstudio.com/Grove-LED_Socket_Kit/)，按钮为[Grove - Button - Seeed Wiki](https://wiki.seeedstudio.com/Grove-Button/)，实现的功能非常简单：按钮按下时灯亮，松开后灯灭。本文主要是简单记录一下MATLAB对于Arduino数字端口的读写操作。

Arduino IDE：

```c++
const int buttonPin = 2;     // the number of the pushbutton pin, "D2" port
const int ledPin =  3;      // the number of the LED pin, "D3" port

// variables will change:
int buttonState = 0;         // variable for reading the pushbutton status

void setup() {
    // initialize the LED pin as an output:
    pinMode(ledPin, OUTPUT);
    // initialize the pushbutton pin as an input:
    pinMode(buttonPin, INPUT);
}

void loop(){
    // read the state of the pushbutton value:
    buttonState = digitalRead(buttonPin);

    // check if the pushbutton is pressed.
    // if it is, the buttonState is HIGH:
    if (buttonState == HIGH) {
        // turn LED on:
        digitalWrite(ledPin, HIGH);
    }
    else {
        // turn LED off:
        digitalWrite(ledPin, LOW);
    }
}
```

MATLAB实现：

```matlab
clc, clear, close all

buttonPin = "D2";     
ledPin =  "D3";

a = arduino;

while true
    buttonState = readDigitalPin(a, buttonPin);
    if buttonState == true
        writeDigitalPin(a, ledPin, true);
    else
        writeDigitalPin(a, ledPin, false);
    end
end
```

其中用到了`readDigitalPin`和`writeDigitalPin`函数。

另外需要注意一点，在MATLAB中，并不存在关键字`HIGH`和`LOW`，需要使用`true`和`false`代替。

<br>

