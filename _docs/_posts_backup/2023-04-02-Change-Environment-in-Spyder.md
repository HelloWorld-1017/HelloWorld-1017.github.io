---
layout: single
title: Change Environment in Spyder
date: 2023-04-02 16:42:49 +0800
categories: 
 - Python
toc: false
---

首先创建一个新的环境`newenv1`：

```shell
conda create --name newenv1 python
```

此时，Anaconda中具有两个环境：

```shell
conda info --envs
```

![image-20230402162050427](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230402162050427.png)

一个是基础环境`base`，一个是新创建的`newenv1`环境。

此时，打开Spyder软件，在命令行中输入命令：

```shell
import sys
sys.executable
```

可以看到此时Spyder使用的`base`环境：

![image-20230402162343455](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230402162343455.png)

并且具有很多之前安装的包：

![image-20230402162521518](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230402162521518.png)

<br>

为了将切换到`newenv1`环境，进行如下的设置：

![image-20230402162853906](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230402162853906.png)

应用后，重启Spyder：

![image-20230402162935063](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230402162935063.png)

刚打开Spyder后，出现了这样的报错：

![image-20230402163032045](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230402163032045.png)

提示缺乏`spyder-kernels`。因此，我们需要使用命令在化境`newenv1`中安装`spyder-kernels`：

```shell
conda activate newenv1
conda install spyder-kernels=2.4
```

安装完成后，再次打开Spyder可以看到错误提示消失了。此时再查看当前的环境信息：

![image-20230402163459142](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230402163459142.png)

以及安装的包：

![image-20230402163622353](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230402163622353.png)

可以看到使用的是新环境中安装的python解释器，并且只有最基础的一些包。Bingo~

<br>

**References**

[1] [Spyder says: Don't mix pip and conda - YouTube](https://www.youtube.com/watch?v=Ul79ihg41Rs).