---
layout: single
title: Install the Python Packages Downloaded from Github
date: 2023-04-04 15:48:39 +0800
categories: 
 - Python
 - GitHub
toc: false
---

在Github上，有很多开源的Python库，有一些库可以很简单地使用`conda install`命令或者`pip install`命令进行安装，但是有一些包似乎并不提供这些方式（可能是没有上传到Anaconda Cloud或者PyPI上），例如最近学习的一个库：[PDEBench - Github](https://github.com/pdebench/PDEBench)，在库的Readme文件中，仅仅提供了一种安装方式：

![image-20230404152738286](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230404152738286.png?raw=true)

本博客就简单记录一下这个库的安装。

<br>

首先需要在Github上将整个repo下载下来，解压后把整个文件夹`PDEBench-main`放在要安装的环境下的`site-packages`文件夹下：

```
D:\Softwares\anaconda3\envs\PDEenv\Lib\site-packages\
```

之后，打开Anaconda prompt，cd到指定目录：

```
cd /d D:\Softwares\anaconda3\envs\PDEenv\Lib\site-packages\PDEBench-main
```

这里需要注意的是，不要忘记`/d`命令，否则会无法到指定目录 [1]。

然后，输入命令：

```
pip install .
```

就可以完成安装。这条命令的含义是执行`PDEBench-main`文件夹下的`setup.py`命令实现安装 [2]。

<br>

**References**

[1] [anaconda prompt中cd到指定目录 - CSDN博客](https://blog.csdn.net/in546/article/details/120498106).

[2] [python - What does pip install . (dot) mean? - Stack Overflow](https://stackoverflow.com/questions/39023758/what-does-pip-install-dot-mean)





