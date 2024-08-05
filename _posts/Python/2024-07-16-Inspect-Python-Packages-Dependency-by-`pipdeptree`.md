---
title: Inspect Python Packages Dependency by `pipdeptree` (including a Simple Practice with Graphviz)
categories:
 - Python
tags:
 - Graphviz
date: 2024-07-16 23:08:22 +0800
last_modified_at: 2024-08-04 23:30:55 +0800
---

# Introduction

Python `pipdeptree` package is a practical tool to inspect dependencies of installed Python packages[^1]:

`pipdeptree` is a command line utility for displaying the installed python packages in form of a dependency tree. It works for packages installed globally on a machine as well as in a virtualenv. Since `pip freeze` shows all dependencies as a flat list, finding out which are the top level packages and which packages do they depend on requires some effort. It's also tedious to resolve conflicting dependencies that could have been installed because older version of `pip` didn't have true dependency resolution `pipdeptree` can help here by identifying conflicting dependencies installed in the environment.
{: .quote--left}

Take an example to test `pipdeptree`.

At first, I newly create a clean Python virtual environment by `venv` module[^2], and at the beginning there are two built-in packages, i.e. `pip` and `setuptools`. Then, referring to the example from official GitHub repository[^1], I install Flask, a lightweight web application framework, in the virtual environment. And of course, I install `pipdeptree` in advance. Anyway, I execute following two install commands after activating the virtual environment:

```powershell
pip install pipdeptree
pip install flask
```

Right now, there are 12 packages in this virtual environment:

| Order | Packages       | Version | Source                                                       |
| ----- | -------------- | ------- | ------------------------------------------------------------ |
| 1     | `blinker`      | 1.8.2   | `pip install flask`                                          |
| 2     | `click`        | 8.1.7   | `pip install flask`                                          |
| 3     | `colorama`     | 0.4.6   | `pip install flask`                                          |
| 4     | `Flask`        | 3.0.3   | `pip install flask`                                          |
| 5     | `itsdangerous` | 2.2.0   | `pip install flask`                                          |
| 6     | `Jinja2`       | 3.1.4   | `pip install flask`                                          |
| 7     | `MarkupSafe`   | 2.1.5   | `pip install flask`                                          |
| 8     | `packaging`    | 24.1    | `pip install pipdeptree`                                     |
| 9     | `pip`          | 24.0    | built-in packages in virtual environment created by `venv` module |
| 10    | `pipdeptree`   | 2.23.1  | `pip install pipdeptree`                                     |
| 11    | `setuptools`   | 65.5.0  | built-in packages in virtual environment created by `venv` module |
| 12    | `Werkzeug`     | 3.0.3   | `pip install flask`                                          |

`pipdeptree` provides a main command, `pipdeptree`, to inspect dependency relationships of all installed packages in a virtual environment, like my case for example:

```powershell
pipdeptree
```

```
Flask==3.0.3
├── blinker [required: >=1.6.2, installed: 1.8.2]
├── click [required: >=8.1.3, installed: 8.1.7]
│   └── colorama [required: Any, installed: 0.4.6]
├── itsdangerous [required: >=2.1.2, installed: 2.2.0]
├── Jinja2 [required: >=3.1.2, installed: 3.1.4]
│   └── MarkupSafe [required: >=2.0, installed: 2.1.5]
└── Werkzeug [required: >=3.0.0, installed: 3.0.3]
    └── MarkupSafe [required: >=2.1.1, installed: 2.1.5]
pipdeptree==2.23.1
├── packaging [required: >=23.1, installed: 24.1]
└── pip [required: >=23.1.2, installed: 24.0]
setuptools==65.5.0
```

Besides, there are some available options for `pipdeptree` according to the description in GitHub repository[^1]. In next section, I’ll show some of them which I think are most commonly used.

<br>

# Available options

## `--packages` option

```powershell
pipdeptree --packages flask
```

```
Flask==3.0.3
├── blinker [required: >=1.6.2, installed: 1.8.2]
├── click [required: >=8.1.3, installed: 8.1.7]
│   └── colorama [required: Any, installed: 0.4.6]
├── itsdangerous [required: >=2.1.2, installed: 2.2.0]
├── Jinja2 [required: >=3.1.2, installed: 3.1.4]
│   └── MarkupSafe [required: >=2.0, installed: 2.1.5]
└── Werkzeug [required: >=3.0.0, installed: 3.0.3]
    └── MarkupSafe [required: >=2.1.1, installed: 2.1.5]
```

## `--reverse` option

```powershell
pipdeptree --reverse --packages MarkupSafe
```

```
MarkupSafe==2.1.5
├── Jinja2==3.1.4 [requires: MarkupSafe>=2.0]
│   └── Flask==3.0.3 [requires: Jinja2>=3.1.2]
└── Werkzeug==3.0.3 [requires: MarkupSafe>=2.1.1]
    └── Flask==3.0.3 [requires: Werkzeug>=3.0.0]
```

## `--json` option

```powershell
pipdeptree --json
```

```json
[
    {
        "package": {
            "key": "blinker",
            "package_name": "blinker",
            "installed_version": "1.8.2"
        },
        "dependencies": []
    },
    {
        "package": {
            "key": "click",
            "package_name": "click",
            "installed_version": "8.1.7"
        },
        "dependencies": [
            {
                "key": "colorama",
                "package_name": "colorama",
                "installed_version": "0.4.6",
                "required_version": "Any"
            }
        ]
    },
    {
        "package": {
            "key": "colorama",
            "package_name": "colorama",
            "installed_version": "0.4.6"
        },
        "dependencies": []
    },
    {
        "package": {
            "key": "flask",
            "package_name": "Flask",
            "installed_version": "3.0.3"
        },
        "dependencies": [
            {
                "key": "blinker",
                "package_name": "blinker",
                "installed_version": "1.8.2",
                "required_version": ">=1.6.2"
            },
            {
                "key": "click",
                "package_name": "click",
                "installed_version": "8.1.7",
                "required_version": ">=8.1.3"
            },
            {
                "key": "itsdangerous",
                "package_name": "itsdangerous",
                "installed_version": "2.2.0",
                "required_version": ">=2.1.2"
            },
            {
                "key": "jinja2",
                "package_name": "Jinja2",
                "installed_version": "3.1.4",
                "required_version": ">=3.1.2"
            },
            {
                "key": "werkzeug",
                "package_name": "Werkzeug",
                "installed_version": "3.0.3",
                "required_version": ">=3.0.0"
            }
        ]
    },
    {
        "package": {
            "key": "itsdangerous",
            "package_name": "itsdangerous",
            "installed_version": "2.2.0"
        },
        "dependencies": []
    },
    {
        "package": {
            "key": "jinja2",
            "package_name": "Jinja2",
            "installed_version": "3.1.4"
        },
        "dependencies": [
            {
                "key": "markupsafe",
                "package_name": "MarkupSafe",
                "installed_version": "2.1.5",
                "required_version": ">=2.0"
            }
        ]
    },
    {
        "package": {
            "key": "markupsafe",
            "package_name": "MarkupSafe",
            "installed_version": "2.1.5"
        },
        "dependencies": []
    },
    {
        "package": {
            "key": "packaging",
            "package_name": "packaging",
            "installed_version": "24.1"
        },
        "dependencies": []
    },
    {
        "package": {
            "key": "pip",
            "package_name": "pip",
            "installed_version": "24.0"
        },
        "dependencies": []
    },
    {
        "package": {
            "key": "pipdeptree",
            "package_name": "pipdeptree",
            "installed_version": "2.23.1"
        },
        "dependencies": [
            {
                "key": "packaging",
                "package_name": "packaging",
                "installed_version": "24.1",
                "required_version": ">=23.1"
            },
            {
                "key": "pip",
                "package_name": "pip",
                "installed_version": "24.0",
                "required_version": ">=23.1.2"
            }
        ]
    },
    {
        "package": {
            "key": "setuptools",
            "package_name": "setuptools",
            "installed_version": "65.5.0"
        },
        "dependencies": []
    },
    {
        "package": {
            "key": "werkzeug",
            "package_name": "Werkzeug",
            "installed_version": "3.0.3"
        },
        "dependencies": [
            {
                "key": "markupsafe",
                "package_name": "MarkupSafe",
                "installed_version": "2.1.5",
                "required_version": ">=2.1.1"
            }
        ]
    }
]
```

<br>

# Generate dependency graph by Graphviz

In addition to above options, `pipdeptree` also supports generating dependency graph, and this function is realized by Graphviz[^3]. Four corresponding commands are introduced in the repository[^1]:

```powershell
pipdeptree --graph-output dot > dependencies.dot
pipdeptree --graph-output pdf > dependencies.pdf
pipdeptree --graph-output png > dependencies.png
pipdeptree --graph-output svg > dependencies.svg
```

However, to use these commands to generate dependency graph as expected, some points should be noted.

First, in order to use Graphviz, we should first install Graphviz on computer (installation package links can be found Graphviz documentation[^4]. Installment process is simple, and during which we should check option `Add Graphviz to the system PATH for all users`. After installment, `dot -v` can be used to test if it is installed successfully), and then install Graphviz-Python interface[^5] by command `pip install graphviz`. 

At this time, I use command:

```powershell
pipdeptree --graph-output png > dependencies.png
```

to get a PNG file `dependencies.png`, but when I open it, an error occurs, which prompts that the file format is not supported:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407152103498.png" alt="image-20240715205636759" style="zoom:67%;" />

Similar message appears when I use command to generate PDF file. On the other hand, when I use command 

```powershell
pipdeptree --graph-output dot > dependencies.dot
```

to output DOT file, I can open it and its content looks normal:

```
digraph {
	blinker [label="blinker\n1.8.2"]
	click -> colorama [label=any]
	click [label="click\n8.1.7"]
	colorama [label="colorama\n0.4.6"]
	flask -> blinker [label=">=1.6.2"]
	flask -> click [label=">=8.1.3"]
	flask -> itsdangerous [label=">=2.1.2"]
	flask -> jinja2 [label=">=3.1.2"]
	flask -> werkzeug [label=">=3.0.0"]
	flask [label="Flask\n3.0.3"]
	graphviz [label="graphviz\n0.20.3"]
	itsdangerous [label="itsdangerous\n2.2.0"]
	jinja2 -> markupsafe [label=">=2.0"]
	jinja2 [label="Jinja2\n3.1.4"]
	markupsafe [label="MarkupSafe\n2.1.5"]
	packaging [label="packaging\n24.1"]
	pip [label="pip\n24.0"]
	pipdeptree -> packaging [label=">=23.1"]
	pipdeptree -> pip [label=">=23.1.2"]
	pipdeptree [label="pipdeptree\n2.23.1"]
	setuptools [label="setuptools\n65.5.0"]
	werkzeug -> markupsafe [label=">=2.1.1"]
	werkzeug [label="Werkzeug\n3.0.3"]
}
```

So, I come up with an indirect method to generate graph, that is rendering this generated DOT file. I find corresponding command to realize this goal:

```powershell
dot -Tpng dependencies.dot -o dependencies.png
```

However, another error appears:

```
Error: dependencies.dot: syntax error in line 1 near ''
```

As for this error, some references[^6][^7] say it is caused by inappropriate encoding, and to correct it, we can open DOT file in text editor, and `Save As` it in `UTF-8` encoding (previous encoding is `UTF-16 LE`). Then, use `dot -Tpng dependencies.dot -o dependencies.png` again, I get a PNG file at this time:

![dependencies](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407161815830.png)

which can be viewed with no problem. By the way, to enhance image resolution, we can add `graph [dpi=1200]` in DOT file[^8]:

```
digraph {
	graph [dpi=1200]
	...
	...
}
```

and likewise, use command `dot -Tpng dependencies.dot -o dependencies.png` to get:

![dependencies](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407161817706.png)

<br>

**References**

[^1]: [tox-dev/pipdeptree: A command line utility to display dependency tree of the installed Python packages](https://github.com/tox-dev/pipdeptree/tree/main).
[^2]: [Create Python Virtual Environment by Python `venv` - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-09/15-49-08.html).
[^3]: [Graphviz](https://www.graphviz.org/).
[^4]: [Download \| Graphviz](https://www.graphviz.org/download/#windows).
[^5]: [xflr6/graphviz: Simple Python interface for Graphviz](https://github.com/xflr6/graphviz).
[^6]: [十分钟学会graphviz画图 - 简书](https://www.jianshu.com/p/6d9bbbbf38b1).
[^7]: [关于命令行调用graphvis出现 syntax error in line的问题\_安装graphviz的时候会出现这个问题syntax error in line 2 near ',\-CSDN博客](https://blog.csdn.net/weixin_43490216/article/details/104851996).
[^8]: [https://stackoverflow.com/a/3918019/22763127](https://stackoverflow.com/a/3918019/22763127).
