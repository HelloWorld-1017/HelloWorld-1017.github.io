---
layout: single
title: Close the Program Occupying Specific Port in Windows System
date: 2023-07-25 22:31:47 +0800
categories: 
 - Windows
toc: false
---

最近在启动一个Windows软件的时候，弹出了这样的一个警告：

```
连接启动失败
另一进程正在使用启动次连接所需的端口：
xxx需要在127.0.0.1监听1089端口。
```

这个警告表明此时电脑的`1089`已经被其他程序占用，因此就无法通过该端口实现通信。

解决方法是，首先在CMD中输入命令：

```shell
netstat -ano|findstr "1089"
```

最终会打印出占用`1089`端口的相关信息：

```
TCP    192.168.1.107:1089    20.198.162.78:443    ESTABLISHED    5288
```

其中，最后一项信息表示所占用程序的PID（Process Identifier）。之后打开任务管理器，在`详细信息`中找到PID为`5288`的程序，再点击`结束任务`即可关闭当前占用端口的程序。

<br>

**References**

[1] [win10系统下查看端口是否被占用 - CSDN博客](https://blog.csdn.net/qq_34207366/article/details/85068839).

[2] [深入理解什么是端口(port) - 知乎](https://zhuanlan.zhihu.com/p/225777212).