---
layout: single
title: Install ESP32 Boards in Arduino IDE
date: 2023-06-12 16:09:23 +0800
categories: 
 - Hardware
 - C
 - GitHub
tags: 
 - Arduino
 - ESP32
toc: false
---

最近看到ESP32开发板具有Wifi模块和蓝牙模块实现无线通信，觉得比较有意思，能够使用软件来代替硬件的功能，因此就买了一块ESP32开发板。我在网上看到可以在Arduino IDE中编写ESP32的程序，但在实际安装ESP32相关库时遇到了一系列问题，本博客记录一下解决方案。

按理说在Arduino IDE中安装是一件比较简单的事情，只需要在`Tool>Borad>Boards Manager...`搜索安装即可，但是最开始搜索ESP32时找不到任何的内容，在网上搜索了一下解决方案，这是需要在`File>Preferences>Additional boards manager URLs`中添加类似于搜索ESP32的搜索路径 [1]：

![image-20230617153702877](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230617153702877.png?raw=true)

之后，就可以在`Tool>Borad>Boards Manager...`中搜索到ESP32板子的相关内容。我使用这种方式在一台电脑上实现了安装，但是在另一台电脑上安装失败，始终报错下载失败之类的信息。

于是，我就继续尝试了手动安装ESP32库的方式 [1]。大致的思路就是在Github中下载ESP32库 [2]，然后在`...\Arduino15\packages\arduino\hardware\`文件夹中建立`espressif`文件夹，将从Github上下载的文件解压并放在`espressif`文件夹下，并将文件夹名改为`esp32`，最后运行`esp32`文件夹中`tools\get.exe`文件即可实现安装。但是安装完成后，我并没有在Arduino IDE中搜索到相应的ESP32板子。

后面进行了很多的尝试和分析，我觉得可能是文件名哪里出现了错误，导致Arduino IDE无法搜索到我们手动安装的库。于是作为测试，我就在Arduino IDE下载了`Arduino megaAVR Boards`这个板子的相关套件。Luckily，下载很顺利。之后，我就在`...\Arduino15\packages\arduino\hardware\`文件夹下看到了`megaavr`文件夹：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230617160310109.png?raw=true" alt="image-20230617160310109"  />

点进去之后，看到一个以版本号命名的文件夹：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230617160353174.png?raw=true" alt="image-20230617160353174"  />

于是我就尝试着将`espressif`文件夹下的`esp32`修改为了相对应的版本号`2.0.9`（可在 [2] 中的README文件中查找到），然后就可以在Arduino IDE中找到ESP32相关的板子了，bingo!

![image-20230617160756420](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230617160756420.png?raw=true)

<br>

**References**

[1] [试了三种方法我终于安装好了ESP32的开发环境 - 简书](https://www.jianshu.com/p/a8f3fc166b5d).

[2] [espressif/arduino-esp32: Arduino core for the ESP32](https://github.com/espressif/arduino-esp32).