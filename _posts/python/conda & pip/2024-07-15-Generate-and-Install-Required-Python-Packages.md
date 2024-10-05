---
title: "Generate and Install Required Python Packages: `pip freeze > requirements.txt` and `pip install -r requirements.txt`"
toc: false
categories:
 - Python
tags:
 - Python pip
date: 2024-07-15 18:40:39 +0800
last_modified_at: 2024-07-15 18:40:39 +0800
---

Python `pip freeze` command is to “output installed packages in requirements format.”[^1]

For example, after creating a new virtual environment by `venv` module[^2] and in which installing package `numpy` (by command `pip install numpy`), we can find there are three packages in this virtual environment right now:

```powershell
pip list
```

```
Package    Version
---------- -------
numpy      2.0.0
pip        24.0
setuptools 65.5.0
```

Then, we can use `pip freeze` to output packages name and version information in requirements format to PowerShell host:

```
pip freeze
```

```
numpy==2.0.0
```

<div class="notice" markdown="1">

As can be seen, only `numpy` package information is printed. The reason is that `pip freeze` will neglect some packages by default, and to make it do not, we can specify `--all` option[^1]:

<div class="quote--left" markdown="1">

`--all`

Do not skip these packages in the output: wheel, pip, setuptools, distribute

(environment variable: `PIP_ALL`)

</div>

Take this case, we have:

```powershell
pip freeze --all
```

```
numpy==2.0.0
pip==24.0
setuptools==65.5.0
```

By the way, I think the default option is more reasonable, because these packages look like ‘tool kit’, which are installed by default in many scenarios.

</div>

And we can generate corresponding `requirements.txt` file with the aid of PowerShell redirection operator[^3]:

```powershell
pip freeze > requirements.txt
```

Conversely, to install packages in `requirements.txt`, we can execute the following command[^1][^4]:


```powershell
pip install -r requirements.txt
```

<br>

**References**

[^1]: [`pip freeze` - pip documentation v24.1.2](https://pip.pypa.io/en/stable/cli/pip_freeze/).
[^2]: [Create Python Virtual Environment by Python `venv` - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-09/15-49-08.html#top).
[^3]: [Redirection Operators `>` and `>>` in Windows PowerShell - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-11/11-44-01.html).
[^4]: [Getting Started: Install multiple packages using a requirements file - pip documentation v24.1.1](https://pip.pypa.io/en/stable/getting-started/#install-multiple-packages-using-a-requirements-file).
