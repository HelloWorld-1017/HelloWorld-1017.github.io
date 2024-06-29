---
layout: single
title: Write Waveforms to File in LabVIEW
date: 2022-12-30 20:35:43 +0800
categories: 
 - LabVIEW
tags:
 - LabVIEW Warnings and Errors
---

# Introduction

LabVIEW提供了一个读取/写入波形数据的范例：`Waveform - Write Waveforms to File.vi`。

![image-20221230114125035](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230114125035.png?raw=true)

![image-20221230114147251](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230114147251.png?raw=true)

通过查看菜单栏的“查看->VI层次结构”，可以看到该范例中所有VI的调用关系。

![image-20221230115325283](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230115325283.png?raw=true)

其中，子VI `Acquire Array of Waveforms (simulated).vi`和`Acquire Waveform (simulated).vi`在函数选板中是找不到的，是自建VI，因此，我们先从这两个子VI开始，模仿还原整个VI程序。

<br>

# Acquire Waveform (simulated).vi

子VI `Acquire Waveform (simulated).vi`创建一个长度为`Sample size`的随机波形，并修改波形的`Channel Name`属性值。

属性修改的效果：

![image-20221230175350999](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230175350999.png?raw=true)

![image-20221230175334886](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230175334886.png?raw=true)

> 注：在默认情况下，波形输出控件是不显示`属性`的，需要右键设置。
>
> ![image-20221230175837121](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230175837121.png?raw=true)

我们可以修改波形输出空间中Y的索引，发现随着索引的增大，数组的元素个数逐渐减小：

![image-20221230180224590](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230180224590.png?raw=true)

![image-20221230180315318](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230180315318.png?raw=true)

![image-20221230180626611](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230180626611.png?raw=true)

不太清楚这里使用的是什么数据结构。

另一方面，如果把这个波形输出接到波形图表显示控件上，可以看到是只显示一条曲线的：

![image-20221230180853262](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230180853262.png?raw=true)

最终，我们把显示中间结果的部件删去，得到子VI程序框图：

![image-20221230181126915](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230181126915.png?raw=true)

并保存为`Acquire Waveform (self).vi`。

<br>

# Acquire Array of Waveforms (simulated).vi

`Acquire Array of Waveforms (simulated).vi`是`Acquire Waveform (simulated).vi`父VI，前者直接调用后者。前者的程序框图为：

![image-20221230182609951](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230182609951.png?raw=true)

之后，将其保存为`Acquire Array of Waveforms (self).vi`

<br>

# Waveform - Write Waveforms to File.vi

在依次搭建了前面两个子VI后，就可以还原主VI了。主VI `Waveform - Write Waveforms to File.vi`主要完成三部分工作：

- 将波形写入到.dat文件
- 读取.dat文件
- 将波形写入到用制表符分隔的.txt文件

![image-20221230191831212](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230191831212.png?raw=true)

这里需要注意的一点是文件路径的使用。如果想要在该VI文件所在工作目录来创建文件，字符常量那里需要加上`..\`。

![image-20221230192847925](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230192847925.png?raw=true)

最终，我们可以得到.dat二进制文件和.txt文本文档文件。可以看一下.txt文件的内容：

![image-20221230192652014](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230192652014.png?raw=true)

<br>

# Path Dependency

该范例VI文件路径依赖关系如下图所示：

![image-20221230201849330](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230201849330.png?raw=true)

![image-20221230201905767](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230201905767.png?raw=true)

两个子VI文件保存在主VI所在文件夹的`Support VIs`文件夹中。在学习的过程中，我将这三个VI文件放在了相同的文件夹中：

![image-20221230202110737](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230202110737.png?raw=true)

此时再打开主VI，则会弹出关于路径依赖关系的警告：

![image-20221230202208569](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230202208569.png?raw=true)

点开`显示详细信息`，则弹出以下页面：

![image-20221230202316715](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230202316715.png?raw=true)

我们可以点击`保存至文件..`将报警信息保存为.txt文件。之后，假如我们关闭该VI后再次进入，则不会再弹出这样的警告信息，但是我们仍然可以在`查看>>加载并保存警告列表`中找到这个报警信息。

我不是很清楚出现这个warning的具体原因，可能是因为在第一次在主VI中插入子VI时采用的是相对路径。
