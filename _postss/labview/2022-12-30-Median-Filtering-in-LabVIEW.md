---
layout: single
title: Median Filtering in LabVIEW
date: 2022-12-30 08:23:21 +0800
categories: 
 - LabVIEW
 - Signals and Systems
---

# Introduction

本博客参考LabVIEW的官方范例：`Median Filtering.vi`搭建一个简单的中值滤波器。

![image-20221230085556794](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230085556794.png?raw=true)

![image-20221230085617227](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230085617227.png?raw=true)

该范例对含有高斯白噪声的脉冲波形进行中值滤波，并根据滤波后的波形重新计算脉冲波形的赋值、宽度、延迟等参数。总的来说，这个示例比较简单，但也有一些值得注意的地方，下面分别进行介绍。

<br>

# Sub-VI

范例程序使用了一个模块`脉冲参数(Pulse Parameters.vi)`：

![image-20221230064637959](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230064637959.png?raw=true)

但是，这个模块在函数选板中是搜索不到的，并且上图左下角的在线帮助按钮是灰色的。也就是说，这个模块实际上不是LabVIEW内置的函数，而是一个子VI。如果我们双击该子VI，并进入到其程序框图中，可以看到，这个子VI实际上也比较简单，就是调用了一个动态链接库：

![image-20221230071105198](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230071105198.png?raw=true)

下面就复现一下这个子VI。

首先`Ctrl+N`创建一个空的VI，之后在程序框图中添加一个`调用库函数节点`：

![image-20221230071839352](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230071839352.png?raw=true)

将范例中的`库名/路径`中的内容复制到这里，然后就可以打开`函数名`下拉菜单，选择`PulseParameters`：

![image-20221230072442759](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230072442759.png?raw=true)

注：为了和范例保持一致，`线程`选项这里在后面改为了`在任意线程中运行`。
{: .notice--warning}

之后，在`参数`选项卡中设置与范例中相同的内容，下面`函数原型`部分也会随之改变：

![image-20221230073221569](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230073221569.png?raw=true)

点击确定后，该节点的外观变为：

![image-20221230073405058](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230073405058.png?raw=true)

然后根据范例进行连线：

![image-20221230074043621](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230074043621.png?raw=true)

最终，我们将这个子VI保存为`pm.vi`。

在主VI中打开函数选板，点击`选择VI`插入子VI：

![image-20221230074421024](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230074421024.png?raw=true)

![image-20221230074843972](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230074843972.png?raw=true)

但此时的子VI没有输入输出的接线端，需要在子VI中的右上角进行手动设置：

![image-20221230084232282](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230084232282.png?raw=true)

除此之外，我们还可以根据自己的喜好设计子VI的图标：

![image-20221230084324203](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230084324203.png?raw=true)

最后，在主VI中进行里进行连线即可：

![image-20221230084413230](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230084413230.png?raw=true)

<br>

# Showing Multiple Legends in Waveform Graph

波形图中各个曲线的LineWidth、LineStyle、DisplayName等内容都可以在"属性->曲线"中进行设置：

![image-20221229235718185](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221229235718185.png?raw=true)

而前面板中图例显示的数量则需要在"属性->外观"中进行更改：

![image-20221229235647936](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221229235647936.png?raw=true)

<br>

# Left and Right Rank Setting

中值滤波方法的left rank和right rank的设置会影响滤波前后信号的时延，我们可以简单看一下影响：

![image-20221230091449702](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230091449702.png?raw=true)

![image-20221230091505675](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230091505675.png?raw=true)

![image-20221230091437710](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230091437710.png?raw=true)
