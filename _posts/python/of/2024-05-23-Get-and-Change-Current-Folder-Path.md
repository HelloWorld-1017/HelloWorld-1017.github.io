---
title: Get and Change Current Folder Path in Python
toc: false
categories:
 - Python
tags:
 - Python os
date: 2024-05-23 10:26:04 +0800
last_modified_at: 2024-05-23 10:26:04 +0800
---
```
import os
```

Get current folder path using `os.getcwd()` method:

```
os.getcwd()
```

Change current folder path using `os.chdir` method:

```
os.chdir($PATH)
```

NOTE THAT the path separator in `$PATH` is `\\`, rather than `\`.

<br>

**References**

[1] [spyder的工作路径和python的搜索路径](https://blog.csdn.net/weixin_38812277/article/details/78716387).
