---
title: "The Way to Install Python Jupyter Notebook: the difference between `pip install notebook` (recommended) and `pip install jupyter`"
toc: false
categories:
 - Python
tags:
 - Python Jupyter Notebook
date: 2024-07-10 10:20:53 +0800
last_modified_at: 2024-07-14 20:30:52 +0800
---

As described in its official GitHub repository[^1], Python Jupyter Notebook can be locally installed easily by:

```powershell
pip install notebook
```

and then wen can launch it with:

```powershell
jupyter notebook
```

![image-20240711041546271](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407110415449.png)

<div class="notice--warning" markdown="1">

By the way, for my case, I found a small warning printed in the CMD:

```
[W 2024-07-10 10:42:11.503 ServerApp] jupyter_nbextensions_configurator | error adding extension (enabled: True): The module 'jupyter_nbextensions_configurator' could not be found (No module named 'jupyter_nbextensions_configurator'). Are you sure the extension is installed?
    Traceback (most recent call last):
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\extension\manager.py", line 323, in add_extension
        extpkg = ExtensionPackage(name=extension_name, enabled=enabled)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\extension\manager.py", line 187, in __init__
        self._load_metadata()
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\extension\manager.py", line 202, in _load_metadata
        raise ExtensionModuleNotFound(msg) from None
    jupyter_server.extension.utils.ExtensionModuleNotFound: The module 'jupyter_nbextensions_configurator' could not be found (No module named 'jupyter_nbextensions_configurator'). Are you sure the extension is installed?
```

which prompts that module `jupyter_nbextensions_configurator`[^2] hasn’t installed. To solve this problem, I just need to install it by:

```powershell
pip install jupyter_nbextensions_configurator
```

Then, when I execute `jupyter notebook` this warning disappears.

</div>

Some references also say that users can use another command to install Jupyter Notebook[^3], i.e.:

```powershell
pip install jupyter
```

Yes, it works. However, I didn’t found more information about the difference between command `pip install notebook` and `pip install jupyter`, but just some trivial clues.

As for installing Jupyter Notebook, command `pip install notebook` is recommended, not only in official GitHub repository[^1], but also in official documentation[^5]. While for command `pip install jupyter`, I just found some information about it in PyPi website[^4]:

<div class="quote--left" markdown="1">
```powershell
pip install jupyter
```

Jupyter metapackage. Install all the Jupyter components in one go.

Project description: Install the Jupyter system, including the notebook, qtconsole, and the IPython kernel.

</div>

So, my understanding of this is, easily speaking, packages installed by `pip install notebook` are just for supporting Jupyter Notebook, which is just a subset (one product) of complete Jupyter ecosystem installed by `pip install jupyter`. To verify this point, I respectively create two clean virtual environments[^6] to test what packages both commands install specifically, and the results show in [the following table](#package-list).

In [the table](#package-list), two packages in <font color="blue" style="font-weight:bold;">bold blue</font>, `pip` and `setuptools`, are built-in packages when creating virtual environment by `venv` module[^6].  In addition to these two packages, command `pip install notebook` (two columns on the right-hand side) installs 91 packages, which are the exactly same as those installed by `pip install jupyter` (two columns on the left-hand side). Besides, `pip install jupyter` installs 7 other packages which are marked in <font color="green" style="font-weight:bold;">bold green</font>, i.e. `ipywidgets`, `jupyter`, `jupyter-console`, `jupyterlab_widgets`, `qtconsole`, `QtPy`, and `widgetsnbextension` ([whose information](#extra-packages) can be got by `pip show` command).

So, that’s it. 

All in all, if only install Jupyter notebook, it is a better choice to follow the official instruction, that is using command `pip install notebook`.

<br>

<div id="package-list"></div>

| `pip install jupyter` (100 packages)                         | Version                                                     | `pip install notebook` (93 packages)                         | Version                                                    |
| ------------------------------------------------------------ | ----------------------------------------------------------- | ------------------------------------------------------------ | ---------------------------------------------------------- |
| (1) `anyio`                                                  | 4.4.0                                                       | (1) `anyio`                                                  | 4.4.0                                                      |
| (2) `argon2-cffi`                                            | 23.1.0                                                      | (2) `argon2-cffi`                                            | 23.1.0                                                     |
| (3) `argon2-cffi-bindings`                                   | 21.2.0                                                      | (3) `argon2-cffi-bindings`                                   | 21.2.0                                                     |
| (4) `arrow`                                                  | 1.3.0                                                       | (4) `arrow`                                                  | 1.3.0                                                      |
| (5) `asttokens`                                              | 2.4.1                                                       | (5) `asttokens`                                              | 2.4.1                                                      |
| (6) `async-lru`                                              | 2.0.4                                                       | (6) `async-lru`                                              | 2.0.4                                                      |
| (7) `attrs`                                                  | 23.2.0                                                      | (7) `attrs`                                                  | 23.2.0                                                     |
| (8) `Babel`                                                  | 2.15.0                                                      | (8) `Babel`                                                  | 2.15.0                                                     |
| (9) `beautifulsoup4`                                         | 4.12.3                                                      | (9) `beautifulsoup4`                                         | 4.12.3                                                     |
| (10) `bleach`                                                | 6.1.0                                                       | (10) `bleach`                                                | 6.1.0                                                      |
| (11) `certifi`                                               | 2024.7.4                                                    | (11) `certifi`                                               | 2024.7.4                                                   |
| (12) `cffi`                                                  | 1.16.0                                                      | (12) `cffi`                                                  | 1.16.0                                                     |
| (13) `charset-normalizer`                                    | 3.3.2                                                       | (13) `charset-normalizer`                                    | 3.3.2                                                      |
| (14) `colorama`                                              | 0.4.6                                                       | (14) `colorama`                                              | 0.4.6                                                      |
| (15) `comm`                                                  | 0.2.2                                                       | (15) `comm`                                                  | 0.2.2                                                      |
| (16) `debugpy`                                               | 1.8.2                                                       | (16) `debugpy`                                               | 1.8.2                                                      |
| (17) `decorator`                                             | 5.1.1                                                       | (17) `decorator`                                             | 5.1.1                                                      |
| (18) `defusedxml`                                            | 0.7.1                                                       | (18) `defusedxml`                                            | 0.7.1                                                      |
| (19) `executing`                                             | 2.0.1                                                       | (19) `executing`                                             | 2.0.1                                                      |
| (20) `fastjsonschema`                                        | 2.20.0                                                      | (20) `fastjsonschema`                                        | 2.20.0                                                     |
| (21) `fqdn`                                                  | 1.5.1                                                       | (21) `fqdn`                                                  | 1.5.1                                                      |
| (22) `h11`                                                   | 0.14.0                                                      | (22) `h11`                                                   | 0.14.0                                                     |
| (23) `httpcore`                                              | 1.0.5                                                       | (23) `httpcore`                                              | 1.0.5                                                      |
| (24) `httpx`                                                 | 0.27.0                                                      | (24) `httpx`                                                 | 0.27.0                                                     |
| (25) `idna`                                                  | 3.7                                                         | (25) `idna`                                                  | 3.7                                                        |
| (26) `ipykernel`                                             | 6.29.5                                                      | (26) `ipykernel`                                             | 6.29.5                                                     |
| (27) `ipython`                                               | 8.26.0                                                      | (27) `ipython`                                               | 8.26.0                                                     |
| <font color="green" style="font-weight:bold;">(28) ipywidgets</font> | <font color="green" style="font-weight:bold;">8.1.3</font>  |                                                              |                                                            |
| (29) `isoduration`                                           | 20.11.0                                                     | (28) `isoduration`                                           | 20.11.0                                                    |
| (30) `jedi`                                                  | 0.19.1                                                      | (29) `jedi`                                                  | 0.19.1                                                     |
| (31) `Jinja2`                                                | 3.1.4                                                       | (30) `Jinja2`                                                | 3.1.4                                                      |
| (32) `json5`                                                 | 0.9.25                                                      | (31) `json5`                                                 | 0.9.25                                                     |
| (33) `jsonpointer`                                           | 3.0.0                                                       | (32) `jsonpointer`                                           | 3.0.0                                                      |
| (34) `jsonschema`                                            | 4.23.0                                                      | (33) `jsonschema`                                            | 4.23.0                                                     |
| (35) `jsonschema-specifications`                             | 2023.12.1                                                   | (34) `jsonschema-specifications`                             | 2023.12.1                                                  |
| <font color="green" style="font-weight:bold;">(36) jupyter</font> | <font color="green" style="font-weight:bold;">1.0.0</font>  |                                                              |                                                            |
| (37) `jupyter_client`                                        | 8.6.2                                                       | (35) `jupyter_client`                                        | 8.6.2                                                      |
| <font color="green" style="font-weight:bold;">(38) jupyter-console</font> | <font color="green" style="font-weight:bold;">6.6.3</font>  |                                                              |                                                            |
| (39) `jupyter_core`                                          | 5.7.2                                                       | (36) `jupyter_core`                                          | 5.7.2                                                      |
| (40) `jupyter-events`                                        | 0.10.0                                                      | (37) `jupyter-events`                                        | 0.10.0                                                     |
| (41) `jupyter-lsp`                                           | 2.2.5                                                       | (38) `jupyter-lsp`                                           | 2.2.5                                                      |
| (42) `jupyter_server`                                        | 2.14.1                                                      | (39) `jupyter_server`                                        | 2.14.1                                                     |
| (43) `jupyter_server_terminals`                              | 0.5.3                                                       | (40) `jupyter_server_terminals`                              | 0.5.3                                                      |
| (44) `jupyterlab`                                            | 4.2.3                                                       | (41) `jupyterlab`                                            | 4.2.3                                                      |
| (45) `jupyterlab_pygments`                                   | 0.3.0                                                       | (42) `jupyterlab_pygments`                                   | 0.3.0                                                      |
| (46) `jupyterlab_server`                                     | 2.27.2                                                      | (43) `jupyterlab_server`                                     | 2.27.2                                                     |
| <font color="green" style="font-weight:bold;">(47) jupyterlab_widgets</font> | <font color="green" style="font-weight:bold;">3.0.11</font> |                                                              |                                                            |
| (48) `MarkupSafe`                                            | 2.1.5                                                       | (44) `MarkupSafe`                                            | 2.1.5                                                      |
| (49) `matplotlib-inline`                                     | 0.1.7                                                       | (45) `matplotlib-inline`                                     | 0.1.7                                                      |
| (50) `mistune`                                               | 3.0.2                                                       | (46) `mistune`                                               | 3.0.2                                                      |
| (51) `nbclient`                                              | 0.10.0                                                      | (47) `nbclient`                                              | 0.10.0                                                     |
| (52) `nbconvert`                                             | 7.16.4                                                      | (48) `nbconvert`                                             | 7.16.4                                                     |
| (53) `nbformat`                                              | 5.10.4                                                      | (49) `nbformat`                                              | 5.10.4                                                     |
| (54) `nest-asyncio`                                          | 1.6.0                                                       | (50) `nest-asyncio`                                          | 1.6.0                                                      |
| (55) `notebook`                                              | 7.2.1                                                       | (51) `notebook`                                              | 7.2.1                                                      |
| (56) `notebook_shim`                                         | 0.2.4                                                       | (52) `notebook_shim`                                         | 0.2.4                                                      |
| (57) `overrides`                                             | 7.7.0                                                       | (53) `overrides`                                             | 7.7.0                                                      |
| (58) `packaging`                                             | 24.1                                                        | (54) `packaging`                                             | 24.1                                                       |
| (59) `pandocfilters`                                         | 1.5.1                                                       | (55) `pandocfilters`                                         | 1.5.1                                                      |
| (60) `parso`                                                 | 0.8.4                                                       | (56) `parso`                                                 | 0.8.4                                                      |
| <font color="blue" style="font-weight:bold;">(61) pip</font> | <font color="blue" style="font-weight:bold;">24.0</font>    | <font color="blue" style="font-weight:bold;">(57) pip</font> | <font color="blue" style="font-weight:bold;">24.0</font>   |
| (62) `platformdirs`                                          | 4.2.2                                                       | (58) `platformdirs`                                          | 4.2.2                                                      |
| (63) `prometheus_client`                                     | 0.20.0                                                      | (59) `prometheus_client`                                     | 0.20.0                                                     |
| (64) `prompt_toolkit`                                        | 3.0.47                                                      | (60) `prompt_toolkit`                                        | 3.0.47                                                     |
| (65) `psutil`                                                | 6.0.0                                                       | (61) `psutil`                                                | 6.0.0                                                      |
| (66) `pure-eval`                                             | 0.2.2                                                       | (62) `pure-eval`                                             | 0.2.2                                                      |
| (67) `pycparser`                                             | 2.22                                                        | (63) `pycparser`                                             | 2.22                                                       |
| (68) `Pygments`                                              | 2.18.0                                                      | (64) `Pygments`                                              | 2.18.0                                                     |
| (69) `python-dateutil`                                       | 2.9.0.post0                                                 | (65) `python-dateutil`                                       | 2.9.0.post0                                                |
| (70) `python-json-logger`                                    | 2.0.7                                                       | (66) `python-json-logger`                                    | 2.0.7                                                      |
| (71) `pywin32`                                               | 306                                                         | (67) `pywin32`                                               | 306                                                        |
| (72) `pywinpty`                                              | 2.0.13                                                      | (68) `pywinpty`                                              | 2.0.13                                                     |
| (73) `PyYAML`                                                | 6.0.1                                                       | (69) `PyYAML`                                                | 6.0.1                                                      |
| (74) `pyzmq`                                                 | 26.0.3                                                      | (70) `pyzmq`                                                 | 26.0.3                                                     |
| <font color="green" style="font-weight:bold;">(75) qtconsole</font> | <font color="green" style="font-weight:bold;">5.5.2</font>  |                                                              |                                                            |
| <font color="green" style="font-weight:bold;">(76) QtPy</font> | <font color="green" style="font-weight:bold;">2.4.1</font>  |                                                              |                                                            |
| (77) `referencing`                                           | 0.35.1                                                      | (71) `referencing`                                           | 0.35.1                                                     |
| (78) `requests`                                              | 2.32.3                                                      | (72) `requests`                                              | 2.32.3                                                     |
| (79) `rfc3339-validator`                                     | 0.1.4                                                       | (73) `rfc3339-validator`                                     | 0.1.4                                                      |
| (80) `rfc3986-validator`                                     | 0.1.1                                                       | (74) `rfc3986-validator`                                     | 0.1.1                                                      |
| (81) `rpds-py`                                               | 0.19.0                                                      | (75) `rpds-py`                                               | 0.19.0                                                     |
| (82) `Send2Trash`                                            | 1.8.3                                                       | (76) `Send2Trash`                                            | 1.8.3                                                      |
| <font color="blue" style="font-weight:bold;">(83) setuptools</font> | <font color="blue" style="font-weight:bold;">65.5.0</font>  | <font color="blue" style="font-weight:bold;">(77) setuptools</font> | <font color="blue" style="font-weight:bold;">65.5.0</font> |
| (84) `six`                                                   | 1.16.0                                                      | (78) `six`                                                   | 1.16.0                                                     |
| (85) `sniffio`                                               | 1.3.1                                                       | (79) `sniffio`                                               | 1.3.1                                                      |
| (86) `soupsieve`                                             | 2.5                                                         | (80) `soupsieve`                                             | 2.5                                                        |
| (87) `stack-data`                                            | 0.6.3                                                       | (81) `stack-data`                                            | 0.6.3                                                      |
| (88) `terminado`                                             | 0.18.1                                                      | (82) `terminado`                                             | 0.18.1                                                     |
| (89) `tinycss2`                                              | 1.3.0                                                       | (83) `tinycss2`                                              | 1.3.0                                                      |
| (90) `tornado`                                               | 6.4.1                                                       | (84) `tornado`                                               | 6.4.1                                                      |
| (91) `traitlets`                                             | 5.14.3                                                      | (85) `traitlets`                                             | 5.14.3                                                     |
| (92) `types-python-dateutil`                                 | 2.9.0.20240316                                              | (86) `types-python-dateutil`                                 | 2.9.0.20240316                                             |
| (93) `typing_extensions`                                     | 4.12.2                                                      | (87) `typing_extensions`                                     | 4.12.2                                                     |
| (94) `uri-template`                                          | 1.3.0                                                       | (88) `uri-template`                                          | 1.3.0                                                      |
| (95) `urllib3`                                               | 2.2.2                                                       | (89) `urllib3`                                               | 2.2.2                                                      |
| (96) `wcwidth`                                               | 0.2.13                                                      | (90) `wcwidth`                                               | 0.2.13                                                     |
| (97) `webcolors`                                             | 24.6.0                                                      | (91) `webcolors`                                             | 24.6.0                                                     |
| (98) `webencodings`                                          | 0.5.1                                                       | (92) `webencodings`                                          | 0.5.1                                                      |
| (99) `websocket-client`                                      | 1.8.0                                                       | (93)`websocket-client`                                       | 1.8.0                                                      |
| <font color="green" style="font-weight:bold;">(100) widgetsnbextension</font> | <font color="green" style="font-weight:bold;">4.0.11</font> |                                                              |                                                            |

<br>

<div id="extra-packages"></div>

```powershell
pip show ipywidgets jupyter jupyter-console jupyterlab_widgets qtconsole QtPy widgetsnbextension
```

```
Name: ipywidgets
Version: 8.1.3
Summary: Jupyter interactive widgets
Home-page: http://jupyter.org
Author: Jupyter Development Team
Author-email: jupyter@googlegroups.com
License: BSD 3-Clause License
Location: G:\Spyder\Python311\mmy_env\Lib\site-packages
Requires: comm, ipython, jupyterlab-widgets, traitlets, widgetsnbextension
Required-by: jupyter
---
Name: jupyter
Version: 1.0.0
Summary: Jupyter metapackage. Install all the Jupyter components in one go.
Home-page: http://jupyter.org
Author: Jupyter Development Team
Author-email: jupyter@googlegroups.org
License: BSD
Location: G:\Spyder\Python311\mmy_env\Lib\site-packages
Requires: ipykernel, ipywidgets, jupyter-console, nbconvert, notebook, qtconsole
Required-by:
---
Name: jupyter-console
Version: 6.6.3
Summary: Jupyter terminal console
Home-page:
Author:
Author-email: Jupyter Development Team <jupyter@googlegroups.com>
License: BSD 3-Clause License

- Copyright (c) 2001-2015, IPython Development Team
- Copyright (c) 2015-, Jupyter Development Team

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
Location: G:\Spyder\Python311\mmy_env\Lib\site-packages
Requires: ipykernel, ipython, jupyter-client, jupyter-core, prompt-toolkit, pygments, pyzmq, traitlets
Required-by: jupyter
---
Name: jupyterlab_widgets
Version: 3.0.11
Summary: Jupyter interactive widgets for JupyterLab
Home-page: https://github.com/jupyter-widgets/ipywidgets
Author: Jupyter Development Team
Author-email: jupyter@googlegroups.com
License: BSD-3-Clause
Location: G:\Spyder\Python311\mmy_env\Lib\site-packages
Requires:
Required-by: ipywidgets
---
Name: qtconsole
Version: 5.5.2
Summary: Jupyter Qt console
Home-page: http://jupyter.org
Author: Jupyter Development Team
Author-email: jupyter@googlegroups.com
License: BSD
Location: G:\Spyder\Python311\mmy_env\Lib\site-packages
Requires: ipykernel, jupyter-client, jupyter-core, packaging, pygments, pyzmq, qtpy, traitlets
Required-by: jupyter
---
Name: QtPy
Version: 2.4.1
Summary: Provides an abstraction layer on top of the various Qt bindings (PyQt5/6 and PySide2/6).
Home-page: https://github.com/spyder-ide/qtpy
Author: Colin Duquesnoy and the Spyder Development Team
Author-email: spyder.python@gmail.com
License: MIT
Location: G:\Spyder\Python311\mmy_env\Lib\site-packages
Requires: packaging
Required-by: qtconsole
---
Name: widgetsnbextension
Version: 4.0.11
Summary: Jupyter interactive widgets for Jupyter Notebook
Home-page: http://jupyter.org
Author: Jupyter Development Team
Author-email: jupyter@googlegroups.com
License: BSD 3-Clause License
Location: G:\Spyder\Python311\mmy_env\Lib\site-packages
Requires:
Required-by: ipywidgets
```

<br>

**References**

[^1]: [jupyter/notebook: Jupyter Interactive Notebook](https://github.com/jupyter/notebook).
[^2]: [Jupyter-contrib/jupyter_nbextensions_configurator: A jupyter notebook serverextension providing config interfaces for nbextensions.](https://github.com/Jupyter-contrib/jupyter_nbextensions_configurator).
[^3]: [Jupyter notebook 详细安装步骤-腾讯云开发者社区-腾讯云](https://cloud.tencent.com/developer/article/2186536).

[^4]: [jupyter · PyPI](https://pypi.org/project/jupyter/).
[^5]: [Project Jupyter \| Installing Jupyter](https://jupyter.org/install).
[^6]: [Create Python Virtual Environment by Python venv - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-09/15-49-08.html).



