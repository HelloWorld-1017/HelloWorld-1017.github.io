---
title: Solve the Problem of Python Matplotlib Interactive Graphs not Available in Spyder IDE
toc: false
categories:
 - Python
tags:
 - Python Graphics
 - Python Matplotlib
 - Spyder IDE
date: 2024-07-23 11:04:23 +0800
last_modified_at: 2024-07-23 13:11:55 +0800
---

Python Matplotlib supports generating interactive graphs[^1]. However, recently when I try to generate one, it can’t be normally showed although there’s no any error (by the way, I used `pyplot.show()` at the end of the code and I could save the generated interactive graph by `pyplot.savefig` function[^2]). And what’s worse is that ordinary static plots can’t be displayed neither at this time. Therefore, I guess this problem is most likely caused by improper IDE settings. The Python IDE I use is Spyder, so I find some corresponding solutions.

<br>

(1) The first solution I found is to change Graphics backend setting of Spyder IDE[^3]: `Tools` tab on toolbar > `Preferences` > `IPython console` > `Graphics` > `Graphics backend` > change `Automatic` to `Qt5`. Then, restart Spyder IDE and install PyQt5 package by Python Pip. 

<div class="notice--primary" markdown="1">

Because after restarting, an error occurs:

```
Python 3.11.9 (tags/v3.11.9:de54cf5, Apr  2 2024, 10:12:12) [MSC v.1938 64 bit (AMD64)]
Type "copyright", "credits" or "license" for more information.

IPython  -- An enhanced Interactive Python.

=========================================================================
NOTE: The following error appeared when setting your Matplotlib backend!!
=========================================================================

Failed to import any of the following Qt binding modules: PyQt5, PySide2

This is most likely caused by missing packages in the Python environment
or installation whose interpreter is located at:

    G:\...\...\Scripts\python.exe
```

</div>

After these steps, however, static graphs can be displayed but interactive ones still can not.

<br>

(2) Another way is trying to change IDE “Run” settings[^4]. For my case, following specification --- `Tools` > `Preferences` > `Run` > `Console` > change `Execute in current console` to `Execute in an external system terminal` --- can finally make interactive graphs available.

<br>

However, during my actual use, both methods ‘sometimes’ aren’t helpful (that is sometimes they work, but sometimes don’t). I don’t know why; maybe other settings are improper as well. So at last, I think the best way is to directly run script file in external terminal, such as Windows PowerShell, by command `python <$FILE_NAME>.py`, leaving IDE aside when executing script. This way is always valid, at least for now. 

<br>

**References**

[^1]: [Matplotlib — Visualization with Python](https://matplotlib.org/).
[^2]: [Export High Resolution Graphics in Python using Matplotlib pyplot.savefig Function - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-05-25/11-09-18.html).
[^3]: [关于spyder中plt.show()不显示画图输出结果的解决办法\_spyder图片结果在哪-CSDN博客](https://blog.csdn.net/qq_37071435/article/details/108846814).
[^4]: [https://stackoverflow.com/a/10724654/22763127](https://stackoverflow.com/a/10724654/22763127).
