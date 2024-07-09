---
title: Create Python Virtual Environment by Python `venv`
categories:
 - Python
tags:
 - Python Virtual Environment
drafted_at: 2024-07-01 19:43:48 +0800
date: 2024-07-09 15:49:08 +0800
last_modified_at: 2024-07-09 15:49:08 +0800
modification_history:
 - 2024-07-09 15:49:08 +0800
---

# Introduction

Python `venv` is a lightweight virtual environment manager[^1], and it is convenient to use it in some simple scenarios:

<div class="quote--left" markdown="1">

The `venv` module supports creating lightweight “virtual environments”, each with their own independent set of Python packages installed in their `site` directories. A virtual environment is created on top of an existing Python installation, known as the virtual environment’s “base” Python, and may optionally be isolated from the packages in the base environment, so only those explicitly installed in the virtual environment are available.

</div>

I’ll record some basic use of `venv` module in this post. 

<br>

# Create a virtual environment

Previously I ever installed a Spyder IDE in folder `G:\Spyder`, and a Python at `G:\Spyder\Python311`, and in which there is a `python.exe`. In `G:\Spyder\Python311`, we can open CMD and create a virtual environment, for example, called `my_env`, using Python `venv`:

```powershell
python -m venv my_env
```

<div class="notice--primary" markdown="1">
Or instead, we could specify a absolute path, like creating a virtual environment `my_env` into `Test1` folder in desktop for example:

```
python -m venv C:\Users\$USER_NAME\Desktop\Test1\mv_venv
```

</div>

After it, a new folder called `my_env` is created in `G:\Spyder\Python311`. And in `G:\Spyder\Python311\my_env`, there are three sub-folders:

- `Include`: this is a empty folder.
- `Lib`: there is only a folder called `site-packages` in it, and every Python package will be installed in `site-packages`.
- `Scripts`: there are 9 files in this folder, i.e. `activate`, `activate.bat`, `Activate.ps1`, `deactivate.bat`, `pip.exe`, `pip3.11.exe`, `pip3.exe`, `python.exe`, `pythonw.exe`. As will be showed later, operations associated with the virtual environment rely on these files.

and one file:

- `pyvenv.cfg`

<br>

# Activate the virtual environment

Then, we can activate above virtual environment `my_env` by command[^3]:

```powershell
my_env\Scripts\Activate.ps1
```

and at this time, we have got into the virtual environment:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407041522630.png" alt="image-20240704152157553" style="zoom:50%;" />

<div class="notice--warning" markdown="1">

Some references[^2] say that to activate the virtual environment, we should use the command:

```bash
source my_env/Srcipts/activate
```

however, an error occurred when I use it:

```
source : 无法将“source”项识别为 cmdlet、函数、脚本文件或可运行程序
的名称。请检查名称的拼写，如果包括路径，请确保路径正确，然后再试一次
。
所在位置 行:1 字符: 1
+ source my_env/Srcipts/activate
+ ~~~~~~
    + CategoryInfo          : ObjectNotFound: (source:String) [], C
   ommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

This is because command `source` is only available on Linux or Mac systems. For Windows systems, the above command functions[^3].

By the way, if I just delete the `source` of command `source my_env/Srcipts/activate`, there is also a similar error:

```powershell
my_env/Srcipts/activate
```

```
my_env/Srcipts/activate : 无法将“my_env/Srcipts/activate”项识别为 cmdl
et、函数、脚本文件或可运行程序的名称。请检查名称的拼写，如果包括路径，请
确保路径正确，然后再试一次。
所在位置 行:1 字符: 1
+ my_env/Srcipts/activate
+ ~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (my_env/Srcipts/activate:
   String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

So, note that on Windows systems, delimiters in file path should be `\`.

</div>

After activating the virtual environment, if use `pip list` to list the installed packages at this moment, we have:

```powershell
pip list
```

```
Package    Version
---------- -------
pip        24.0
setuptools 65.5.0
```

The IDE software I use is Spyder; in order to use the Python interpreter of this virtual environment in Spyder, `spyder-kernels` package should be installed in advance[^4]:

```powershell
pip install spyder-kernels
```

here we have:

```powershell
pip list
```

```
Package           Version
----------------- -----------
asttokens         2.4.1
cloudpickle       3.0.0
colorama          0.4.6
comm              0.2.2
debugpy           1.8.2
decorator         5.1.1
executing         2.0.1
ipykernel         6.29.5
ipython           8.26.0
jedi              0.19.1
jupyter_client    8.6.2
jupyter_core      5.7.2
matplotlib-inline 0.1.7
nest-asyncio      1.6.0
packaging         24.1
parso             0.8.4
pip               24.0
platformdirs      4.2.2
prompt_toolkit    3.0.47
psutil            6.0.0
pure-eval         0.2.2
Pygments          2.18.0
python-dateutil   2.9.0.post0
pywin32           306
pyzmq             26.0.3
setuptools        65.5.0
six               1.16.0
spyder-kernels    2.5.2
stack-data        0.6.3
tornado           6.4.1
traitlets         5.14.3
typing_extensions 4.12.2
wcwidth           0.2.13
```

Next, we can follow the steps introduced in blog[^4] to change the Python interpreter in Spyder.

<br>

# Deactivate the virtual environment

At last, we can deactivate the virtual environment by:

```powershell
deactivate
```

<br>

# References

[^1]: [venv — Creation of virtual environments — Python 3.12.4 documentation](https://docs.python.org/3/library/venv.html).
[^2]: [Python Guide To Activate Venv / Virtual Environments - Linux Dedicated Server Blog](https://ioflood.com/blog/python-activate-venv/).
[^3]: [使用当前文件夹下的python pip\_mob649e8152a959的技术博客\_51CTO博客](https://blog.51cto.com/u_16175427/8206004).
[^4]: [Create and Change Python Environment in Spyder Software - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-04-02/16-42-49.html).
