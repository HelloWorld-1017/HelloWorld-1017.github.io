---
title: Merge Audio Files Using MATLAB
toc: false
categories: 
 - MATLAB
tags:
 - MATLAB Data Import and Analysis
date: 2023-07-15 21:56:52 +0800
last_modified_at: 2024-10-23 19:10:30 +0800
---

最近在练习IELTS听力，一句一句地跟读雅思听力真题。我用iPad把每一个跟读的句子都进行了录音：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230715212548114.png?raw=true" alt="image-20230715212548114" style="zoom: 80%;" />

但是在合并这些音频文件的时候遇到了一些小问题。首先iPad自带的录音软件不支持音频拼接，我只能把音频文件导入到电脑中，之后使用电脑软件进行操作。由于我并不需要复杂的音频编辑功能，因此我就直接使用了“格式工厂”所提供的“音频合并”工具将`.m4a`音频文件拼接，并输出为`.mp3`格式的文件。但是这个合成文件有一个很大的问题，即两段音频的连接处都会有“哒”的一声，当音量放大时就会非常刺耳；并且这个现象与转换的输出格式`.mp3`无关（即输出`.m4a`格式仍然会存在这样的问题），应该是“格式工厂”软件本身的问题。

于是，我就尝试着使用MATLAB来拼接这些音频文件，最终的脚本文件为：

```matlab
m4aFiles = dir("*.m4a");
data = [];
for i = 1:height(m4aFiles)
    [newData,fs] = audioread(num2str(i)+".m4a");
    data = [data;newData];
end
audiowrite("final.m4a",data,fs);
```

最终的音频合成文件`final.m4a`就不存在上述的问题。

但是需要注意的一点是，MATLAB的`audiowrite`并不支持输出`.mp3`格式的音频文件。

如果使用语句：

```matlab
audiowrite("final.mp3",data,fs);
```

则软件会报错：

```
Error using audiowrite>validateExtension
Incorrect file extension for file final.mp3.
Supported extensions are:
	.flac
	.m4a
	.mp4
	.oga
	.ogg
	.opus
	.wav

Error in audiowrite>validateFilename (line 398)
validateExtension(filepath.Extension,filename)

Error in audiowrite (line 168)
    [props.filename, fileExisted] = validateFilename( props.filename );

Error in script1 (line 9)
audiowrite("final.mp3",data,fs);
```

这是因为从R2023a版本开始，`audiowrite`函数才支持写入`.mp3`格式的音频文件：

![image-20230715215357461](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230715215357461.png?raw=true)

而我使用的是R2022a，一直没有更新MATLAB。

<br>

**References**

[1] [audiowrite - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/audiowrite.html?lang=en).