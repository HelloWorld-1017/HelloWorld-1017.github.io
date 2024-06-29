---
layout: single
title:  Read and Play Audio in MATLAB
date: 2023-01-14 19:41:41 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Data Import and Analysis
toc: false
---

在MATLAB中，用户可以使用[`audioinfo`函数](https://ww2.mathworks.cn/help/matlab/ref/audioinfo.html)获得声音文件的信息；使用[`audioread`函数](https://ww2.mathworks.cn/help/matlab/ref/audioread.html)从声音文件中读取数据，并使用[`sound`函数](https://ww2.mathworks.cn/help/matlab/ref/sound.html)播放声音。

首先从网易云音乐上下载一个`.mp3`后缀的音乐文件`wanfeng.mp3`，使用[`audioinfo`函数](https://ww2.mathworks.cn/help/matlab/ref/audioinfo.html)获取它的信息：

```matlab

>> ainfo = audioinfo("wanfeng.mp3")
ainfo = 
  struct with fields:
             Filename: 'C:\Users\Tsing\Desktop\huogai\wanfeng.mp3'
    CompressionMethod: 'MP3'
          NumChannels: 2
           SampleRate: 44100
         TotalSamples: 8940671
             Duration: 2.027363000000000e+02
                Title: '晚风'
              Comment: '163 key(Don't modify):L64FU3W4YxX3ZFTmbZ+8/TXi60+/SzPUjSUNMVsdX+PCpKIeyShrk7/BY+Ejb4FReuzVIcMZEWPOwz7R5ei11Xe5RDH7CarLfBCg+8YNV9Z/HUD72WuOV3NvBBMQ2OZkRN4nBuaSaUyXYOFv7hsT0I/yQH7HFJ0cJfvdDsajVXALOAGYeynjLxfYXRcU5Qkvc18sYp4tEL8sFhj9RgnQXdhGCZsOmTkTlTQqqMEb4dQXsWsG4yvo5Yb8l+T1fXIRD+8+Ix3gkB+Tyx6/g0u0Tik6KPG9q4HYOXIAVsOLfr4weEnJb+yLc9jycjdk1BpLqFgpRgJu/GiX+aZow7NOPjW1EVpNsillUe/zSDUXIGUihOH0IqOoNoLKFurGmMb6qUmlwKTHTRfq1/CuumOzZy2y4JGnwu9hU+xhFCQx5V12ApklDkRfCe8duVvL8pIL0Phxvj7usONl3wOt9Yc+AaeHZyc3hzG4lVVapoXl/U0mFPBdiXsvIx29y+CcMvuLyTkBHXiQjMaaBA21XHYUkA=='
               Artist: '7copy'
              BitRate: 320
```

其中：

- `CompressionMethod`字段，表示该声音文件采用MP3（Moving Picture Experts Group Audio Layer III，动态影像专家压缩标准音频层面3）音频压缩技术；

- `NumChannels`字段，表示这是一个左右双通道的音频文件；

- `SampleRate`字段，表示音频信号采样率，单位是Hz；

- `Duration`字段，表示音频时长；

- `TotalSamples`字段，表示音频文件总的采样点数，等于`SampleRate`字段和`Duration`字段的乘积，即：

  ```matlab
  >> ainfo.SampleRate*ainfo.Duration-ainfo.TotalSamples
  ans =
    -0.169999999925494
  ```

- `BitRate`表示音频压缩文件的千比特率（kbit/s），只对MP3文件（`.mp3`文件）和MPEG-4 Audio（`.m4a`，`.mp4`）文件有效；

接下来使用[`audioread`函数](https://ww2.mathworks.cn/help/matlab/ref/audioread.html)将音频文件中的数据读取到MATLAB工作空间中：

```matlab
[data, fs] = audioread("wanfeng.mp3");
```

```matlab
>> whos
  Name            Size                Bytes  Class     Attributes
  data      8940144x2             143042304  double              
  fs              1x1                     8  double              
```

其中：

- `data`是一个两通道的音频数据矩阵：

  ![image-20230114190256022](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230114190256022.png?raw=true)

  此时我们并没有指定`audioread`函数的`dataType`属性，因此`data`的数据类型是默认的`double`，并且数据矩阵中的元素是标准化后的值，从[-1, 1]取值。若设置`audioread`函数的`dataType`属性为`'native'`：

  ```matlab
  [data, fs] = audioread("wanfeng.mp3", 'native');
  ```

  ```matlab
  >> whos
    Name            Size               Bytes  Class     Attributes
    data      8940144x2             71521152  single              
    fs              1x1                    8  double              
  ```
  此时的`data`变量就是`single`类型，由上图可以看到，`data`变量中的元素仍然从[-1,1]取值。但是对于其他类型的音频文件并不总是这样的取值范围。

- `fs`，表示采样率，值为44100，单位是Hz；

  > 注：44100Hz，即44.1kHz是一个常用的音频采样率，其他常用的采样率还有：
  >
  > ![image-20230114193835323](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230114193835323.png?raw=true)
  >
  > （[sound: Sample rate - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/sound.html#mw_395634c1-32c7-44d2-aaf2-8e31939e60da)）

得到音频数据`data`和采样率`fs`后，就可以使用[`sound`函数](https://ww2.mathworks.cn/help/matlab/ref/sound.html)播放声音：

```matlab
sound(data, fs)
```

注：这里采用与音频文件一致的采样率播放，除此之外还可以使用不同的采样率播放，已达到放慢音频播放或者加快音频播放的效果。
{: .notice--primary}

仅仅只播放一个声道的音频也是可以的：

```matlab
sound(data(:,1), fs) % left channel
```

```matlab
sound(data(:,2), fs) % right channel
```

如果想要终止声音，需要在命令行窗口中输入命令：

```matlab
>> clear sound
```

并且，还可以绘制一下两个通道的音频波形（[Read and Write Audio Files: Plot Audio Data - MathWorks](https://ww2.mathworks.cn/help/matlab/import_export/read-and-get-information-about-audio-files.html#d124e14734)）：

```matlab
clc, clear, close all

ainfo = audioinfo("wanfeng.mp3");

[data, fs] = audioread("wanfeng.mp3", 'native');

t = 0:1/fs:floor(ainfo.Duration);
t = t(1:end-1);

data = data(1:numel(t),:);

figure
hold(gca, "on")
box(gca, "on")
grid(gca, "on")
plot(t, data(:,1), DisplayName="left-channel")
plot(t,  data(:,2), DisplayName="right-channel")
legend()
xlim([t(1), t(end)])
xlabel('Time')
ylabel('Audio Signal')
```

![image-20230114193236012](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230114193236012.png?raw=true)

<br>



