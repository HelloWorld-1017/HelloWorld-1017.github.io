---
title: Create and Change Python Environment in Spyder IDE (through Python Conda)
toc: false
categories: 
 - Python
tags:
 - Python conda
 - Python Virtual Environment
date: 2023-04-02 16:42:49 +0800
last_modified_at: 2024-07-09 16:07:12 +0800
modification_history:
 - 2023-04-02 16:42:49 +0800
 - 2024-05-22 19:41:35 +0800
 - 2024-07-04 16:04:54 +0800
 - 2024-07-09 16:07:12 +0800
---

首先，创建一个新的环境`newenv1`：

```powershell
conda create --name newenv1 python
```

此时可以查看Anaconda中包含两个环境：

```powershell
conda info --envs
```

![image-20230402162050427](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402162050427.png?raw=true)

一个是基础环境`base`，一个是新创建的`newenv1`环境。

此时，打开Spyder软件，在命令行中输入命令：

```python
import sys
sys.executable
```

可以看到此时Spyder使用的`base`环境：

![image-20230402162343455](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402162343455.png?raw=true)

并且具有很多之前安装的包：

```powershell
conda list
```

![image-20230402162521518](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402162521518.png?raw=true)

为了将切换到`newenv1`环境，进行如下的设置：

![image-20230402162853906](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402162853906.png?raw=true)

应用后，重启Spyder软件：

![image-20230402162935063](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402162935063.png?raw=true)

刚打开Spyder后，出现了这样的报错：

![image-20230402163032045](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402163032045.png?raw=true)

提示缺乏`spyder-kernels`。因此，我们需要使用命令在化境`newenv1`中安装`spyder-kernels`：

```powershell
conda activate newenv1
conda install spyder-kernels=2.4
```

安装完成后，再次打开Spyder可以看到错误提示消失了。此时再查看当前的环境信息：

![image-20230402163459142](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402163459142.png?raw=true)

以及安装的包：

![image-20230402163622353](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230402163622353.png?raw=true)

可以看到使用的是新环境中安装的python解释器，并且只有最基础的一些包。Bingo~

<br>

# References

[1] [Spyder says: Don't mix pip and conda - YouTube](https://www.youtube.com/watch?v=Ul79ihg41Rs).