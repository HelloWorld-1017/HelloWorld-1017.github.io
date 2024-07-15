---
title: Install `jupyter_contrib_nbextensions` Package (a collection of extensions) for Python Jupyter Notebook
categories:
 - Python
tags:
 - Python Jupyter Notebook
 - Python Dependency Conflicts
 - Python Warnings and Errors
date: 2024-07-15 14:30:37 +0800
last_modified_at: 2024-07-15 14:30:37 +0800
---

# Introduction

It is an officially recommended way to install Python Jupyter Notebook by command `pip install notebook`[^5] as introduced in blog[^1]. However, after installing it, when I tried to install `jupyter_contrib_nbextensions` package[^6] and configure settings to access some Notebook extensions, some unexpected errors occurred. The main reason is that command `pip install notebook` will install the latest Jupyter Notebook release by default, i.e. `7.2.1` on July 2024, and `jupyter_contrib_nbextensions` haven’t adapted well to `7.x`-version Jupyter Notebook as introduced in its GitHub repository[^5]:

<div class="quote--left" markdown="1">

**Maintained versions**

We maintain the **two most recently released major versions of Jupyter Notebook**, Classic Notebook v6 and Notebook v7. Notebook v5 is no longer maintained. All Notebook v5 users are strongly advised to upgrade to Classic Notebook v6 as soon as possible.

Upgrading to Notebook v7 may require more work, if you use custom extensions, <font color="red" style="font-weight:bold;">as extensions written for Notebook v5 or Classic Notebook v6 are not compatible with Notebook v7</font>.

<br>

**Notebook v7**

The newest major version of Notebook is based on:

- <font color="red" style="font-weight:bold;">JupyterLab components for the frontend</font>
- <font color="red" style="font-weight:bold;">Jupyter Server for the Python server</font>

This represents a significant change to the `jupyter/notebook` code base.

To learn more about Notebook v7: [https://jupyter.org/enhancement-proposals/79-notebook-v7/notebook-v7.html](https://jupyter.org/enhancement-proposals/79-notebook-v7/notebook-v7.html)

<br>

**Classic Notebook v6**

Maintenance and security-related issues [only](https://github.com/jupyter/notebook-team-compass/issues/5#issuecomment-1085254000) are now being addressed in the [`6.5.x`](https://github.com/jupyter/notebook/tree/6.5.x) branch. It depends on [`nbclassic`](https://github.com/jupyter/nbclassic) for the HTML/JavaScript/CSS assets.

New features and continuous improvement is now focused on Notebook v7 (see section above).

If you have an open pull request with a new feature or if you were planning to open one, we encourage switching over to the Jupyter Server and JupyterLab architecture, and distribute it as a server extension and / or JupyterLab prebuilt extension. That way your new feature will also be compatible with the new Notebook v7.

</div>

So, to use `jupyter_contrib_nbextensions`, we should install the Jupyter Notebook whose version is lower than `7`. The complete code to install Jupyter Notebook dependencies, `jupyter_contrib_nbextensions`, and make them compatible shows as follows:

<div id="command-set-1"></div>

```powershell
pip install notebook<7
pip install jupyter_nbextensions_configurator
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
pip install jupyter-server<2
```

They are enough to reach the goal in a new Python virtual environment. And in the following text, I’ll describe them in detail.

<br>

# Step by step

At the beginning, I installed Jupyter Notebook by[^1]:

```powershell
pip install notebook
pip install jupyter_nbextensions_configurator
```

and install `jupyter_contrib_nbextensions` and configure it by[^6]:

```powershell
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
```

However, there’s an error occurring when I executed `jupyter contrib nbextension install --user`:

```
Traceback (most recent call last):
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_contrib_core\notebook_compat\nbextensions.py", line 6, in <module>
    from notebook.extensions import BaseExtensionApp
ModuleNotFoundError: No module named 'notebook.extensions'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_contrib_core\notebook_compat\nbextensions.py", line 10, in <module>
    from notebook.nbextensions import BaseNBExtensionApp
ModuleNotFoundError: No module named 'notebook.nbextensions'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<frozen runpy>", line 198, in _run_module_as_main
  File "<frozen runpy>", line 88, in _run_code
  File "G:\Spyder\Python311\mmy_venv\Scripts\jupyter-contrib.EXE\__main__.py", line 7, in <module>
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_core\application.py", line 283, in launch_instance
    super().launch_instance(argv=argv, **kwargs)
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\traitlets\config\application.py", line 1073, in launch_instance
    app = cls.instance(**kwargs)
          ^^^^^^^^^^^^^^^^^^^^^^
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\traitlets\config\configurable.py", line 583, in instance
    inst = cls(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_contrib_core\application.py", line 27, in __init__
    self._refresh_subcommands()
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_contrib_core\application.py", line 43, in _refresh_subcommands
    get_subcommands_dict = entrypoint.load()
                           ^^^^^^^^^^^^^^^^^
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\pkg_resources\__init__.py", line 2471, in load
    return self.resolve()
           ^^^^^^^^^^^^^^
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\pkg_resources\__init__.py", line 2477, in resolve
    module = __import__(self.module_name, fromlist=['__name__'], level=0)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_contrib_nbextensions\application.py", line 7, in <module>
    from jupyter_contrib_core.notebook_compat.nbextensions import ArgumentConflict
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_contrib_core\notebook_compat\nbextensions.py", line 12, in <module>
    from ._compat.nbextensions import BaseNBExtensionApp
  File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_contrib_core\notebook_compat\_compat\nbextensions.py", line 35, in <module>
    from notebook.nbextensions import (
ModuleNotFoundError: No module named 'notebook.nbextensions'
```

which points out that module `notebook.nbextensions` lacks. 

At this time, the version of installed Jupyter Notebook is `7.2.1`:

```powershell
pip show notebook
```

```
(mmy_venv) PS G:\Spyder\Python311> pip show notebook
Name: notebook
Version: 7.2.1
Summary: Jupyter Notebook - A web-based notebook environment for interactive computing
Home-page:
Author:
Author-email: Jupyter Development Team <jupyter@googlegroups.com>
License: BSD 3-Clause License

- Copyright (c) 2001-2015, IPython Development Team
- Copyright (c) 2015-, Jupyter Development Team

All rights reserved.

......
```

and I can launch Notebook by `jupyter notebook` although there’s no `Nbextensions` tab on toolbar:

![image-20240711160240207](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407111603688.png)

As mentioned before, this is because `notebook` and `jupyter_contrib_nbextensions` have a dependency conflict[^2], and we should downgrade Jupyter Notebook by[^3]:

```powershell
pip install notebook<7
```

At this time, Notebook version is `6.5.7`:

```powershell
pip show notebook
```

```
Name: notebook
Version: 6.5.7
Summary: A web-based notebook environment for interactive computing
Home-page: http://jupyter.org
Author: Jupyter Development Team
Author-email: jupyter@googlegroups.com
License: BSD
Location: G:\Spyder\Python311\mmy_venv\Lib\site-packages
Requires: argon2-cffi, ipykernel, ipython-genutils, jinja2, jupyter-client, jupyter-core, nbclassic, nbconvert, nbformat, nest-asyncio, prometheus-client, pyzmq, Send2Trash, terminado, tornado, traitlets
Required-by: jupyter_contrib_core, jupyter_contrib_nbextensions, jupyter_nbextensions_configurator
```

now if I run `jupyter contrib nbextension install --user` again, there will be no error during this process.

Now, when I launch Jupyter Notebook, there exists `Nbextensions` tab: 

![image-20240709201841063](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407092018327.png)

However at this moment, every operation in Jupyter Notebook is forbidden: 

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407092024585.png"/>

![image-20240709203653206](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407092036278.png)

And it prompts that I should input password or token:

<div id="fig-1"></div>

![image-20240709204033124](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407092040273.png)

At the same time, there are some error and warning messages printed on PowerShell host: 

```
[W 16:12:13.447 NotebookApp] Error loading server extension jupyterlab
    Traceback (most recent call last):
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\notebook\notebookapp.py", line 2050, in init_server_extensions
        func(self)
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyterlab\serverextension.py", line 71, in load_jupyter_server_extension
        extension.initialize()
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyterlab\labapp.py", line 923, in initialize
        super().initialize()
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\extension\application.py", line 437, in initialize
        self._prepare_handlers()
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\extension\application.py", line 327, in _prepare_handlers
        self.initialize_handlers()
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyterlab\labapp.py", line 737, in initialize_handlers
        page_config["token"] = self.serverapp.identity_provider.token
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    AttributeError: 'NotebookApp' object has no attribute 'identity_provider'
```

and

<div id="message-1"></div>

```
[C 16:12:13.494 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///C:/Users/whatastarrynight/AppData/Roaming/jupyter/runtime/nbserver-17600-open.html
    Or copy and paste one of these URLs:
        http://localhost:8888/?token=a78eb94xxx
     or http://127.0.0.1:8888/?token=a78eb94xxx
G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\base\handlers.py:608: UserWarning: The Tornado web application does not have an 'identity_provider' defined in its settings. In future releases of jupyter_server, this will be a required key for all subclasses of `JupyterHandler`. For an example, see the jupyter_server source code for how to add an identity provider to the tornado settings: https://github.com/jupyter-server/jupyter_server/blob/v2.0.0/jupyter_server/serverapp.py#L242
  if type(self.identity_provider) is IdentityProvider and mod_obj.__name__ != __name__:
```

and

```
[W 16:12:15.682 NotebookApp] [jupyter_nbextensions_configurator] wrote error: 'Forbidden'
    Traceback (most recent call last):
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\tornado\web.py", line 1769, in _execute
        result = await result  # type: ignore
                 ^^^^^^^^^^^^
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\base\handlers.py", line 751, in prepare
        await super().prepare()
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\base\handlers.py", line 643, in prepare
        return web.authenticated(lambda _: super().prepare())(self)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\tornado\web.py", line 3289, in wrapper
        url = self.get_login_url()
              ^^^^^^^^^^^^^^^^^^^^
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\base\handlers.py", line 783, in get_login_url
        raise web.HTTPError(403)
    tornado.web.HTTPError: HTTP 403: Forbidden
```

I think it’s easy to solve it by inputing the token in [the message](#message-1) into the input box in [the figure](#fig-1), but it doesn’t work and I don’t know why. I tried some methods introduced in some on-line references, and finally found one of them works, that is downgrade `jupyter-server` module[^4].

Before downgrading, `jupyter-server` is `2.14.2`:

```powershell
pip show jupyter-server
```

```
Name: jupyter_server
Version: 2.14.2
Summary: The backend—i.e. core services, APIs, and REST endpoints—to Jupyter web applications.
Home-page:
Author:
Author-email: Jupyter Development Team <jupyter@googlegroups.com>
License: BSD 3-Clause License

- Copyright (c) 2001-2015, IPython Development Team
- Copyright (c) 2015-, Jupyter Development Team

All rights reserved.

... ...
```

and we should downgrade it to lower than `2.x` version:

```powershell
pip install jupyter-server<2
```

<div class="notice--danger" markdown="1" id="error-1">

During downgrading, there’s an error thrown:

```
ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
jupyterlab 4.2.3 requires jupyter-server<3,>=2.4.0, but you have jupyter-server 1.24.0 which is incompatible.
```

This error will be mentioned in the [In closing](#in-closing) part.

</div>

At this time, `jupyter-server` is `1.24.0`:

```powershell
pip show jupyter-server
```

```
Name: jupyter-server
Version: 1.24.0
Summary: The backend—i.e. core services, APIs, and REST endpoints—to Jupyter web applications.
Home-page: https://jupyter-server.readthedocs.io
Author: Jupyter Development Team
Author-email: jupyter@googlegroups.com
License:
Location: G:\Spyder\Python311\mmy_venv\Lib\site-packages
Requires: anyio, argon2-cffi, jinja2, jupyter-client, jupyter-core, nbconvert, nbformat, packaging, prometheus-client, pywinpty, pyzmq, Send2Trash, terminado, tornado, traitlets, websocket-client
Required-by: jupyter-lsp, jupyter_nbextensions_configurator, jupyterlab, jupyterlab_server, notebook_shim
```

After this step, I can launch Jupyter Notebook and use it with extensions normally, and those `forbidden` messages disappear:

![image-20240711162619762](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407111626987.png)

<div class="notice--danger" markdown="1" id="error-2">
However, there’s an error when running command `jupyter notebook`:


```
[W 16:24:19.202 NotebookApp] Error loading server extension jupyterlab
    Traceback (most recent call last):
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\notebook\notebookapp.py", line 2050, in init_server_extensions
        func(self)
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyterlab\serverextension.py", line 71, in load_jupyter_server_extension
        extension.initialize()
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyterlab\labapp.py", line 923, in initialize
        super().initialize()
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\extension\application.py", line 421, in initialize
        self._prepare_handlers()
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyter_server\extension\application.py", line 311, in _prepare_handlers
        self.initialize_handlers()
      File "G:\Spyder\Python311\mmy_venv\Lib\site-packages\jupyterlab\labapp.py", line 737, in initialize_handlers
        page_config["token"] = self.serverapp.identity_provider.token
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    AttributeError: 'NotebookApp' object has no attribute 'identity_provider'
```

This error will be mentioned in the [In closing](#in-closing) part as well.

</div>

<br>

# In closing

To sum up, to make package `jupyter_contrib_nbextensions` available for Jupyter Notebook, I used following commands one by one:

<div id="command-set-2"></div>

```powershell
pip install notebook
pip install jupyter_nbextensions_configurator
pip install jupyter_contrib_nbextensions
pip install notebook<7
jupyter contrib nbextension install --user
pip install jupyter-server<2
```

and make it more concise, we have:

<div id="command-set-3"></div>

```powershell
pip install notebook<7
pip install jupyter_nbextensions_configurator
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
pip install jupyter-server<2
```

that is directly installing `6.x`-version Jupyter Notebook at the beginning ([Command set 3](#command-set-3) and  [Command set 1](#command-set-1) in Introduction are one and the same). 

I respectively execute two command sets , [Command set 2](#command-set-2) and [Command set 3](#command-set-3), in two newly created virtual environments (by `venv` module), and get the packages lists showed in [Appendix](#appendix). It can be seen that:

1. All packages installed by [Command set 3](#command-set-3) are the same as that by [Command set 2](#command-set-2);
2. [Command set 2](#command-set-2) introduce 13 extra packages (those marked in <font color="red" style="font-weight:bold;">bold right</font> in [Appendix](#appendix)), i.e. `async-lru`, `Babel`, `certifi`, `charset-normalizer`, `h11`, `httpcore`, `httpx`, `json5`, `jupyter-lsp`, `jupyterlab`, `jupyterlab_server`, `requests`, and `urllib3`. They are most likely the dependencies of `7.x`-version Jupyter Notebook.

So, a takeaway is that, **if we downgrade a certain package, its dependencies seem not be influenced correspondingly, at least those extra modules won’t be uninstalled automatically at this case**. As a result, some package conflicts will appear. For example, two errors showed before, [Error message 1](#error-1) and [Error message 2](#error-2), are both caused by `jupyter_server` module, which is one of `7.x`-version Jupyter Notebook dependencies: if I execute [Command set 3](#command-set-3) instead, these two errors won’t show up.

<br>

# Appendix

| [Command set 2](#command-set-2) (101 packages)               | Version                                                     | [Command set 1 (or 3)](#command-set-1) (88 packages) | Version        |
| ------------------------------------------------------------ | ----------------------------------------------------------- | ---------------------------------------------------- | -------------- |
| (1) `anyio`                                                  | 3.7.1                                                       | (1) `anyio`                                          | 3.7.1          |
| (2) `argon2-cffi`                                            | 23.1.0                                                      | (2) `argon2-cffi`                                    | 23.1.0         |
| (3) `argon2-cffi-bindings`                                   | 21.2.0                                                      | (3) `argon2-cffi-bindings`                           | 21.2.0         |
| (4) `arrow`                                                  | 1.3.0                                                       | (4) `arrow`                                          | 1.3.0          |
| (5) `asttokens`                                              | 2.4.1                                                       | (5) `asttokens`                                      | 2.4.1          |
| <font color="red" style="font-weight:bold;">(6) async-lru</font> | <font color="red" style="font-weight:bold;">2.0.4</font>    |                                                      |                |
| (7) `attrs`                                                  | 23.2.0                                                      | (6) `attrs`                                          | 23.2.0         |
| <font color="red" style="font-weight:bold;">(8) Babel</font> | <font color="red" style="font-weight:bold;">2.15.0</font>   |                                                      |                |
| (9) `beautifulsoup4`                                         | 4.12.3                                                      | (7) `beautifulsoup4`                                 | 4.12.3         |
| (10) `bleach`                                                | 6.1.0                                                       | (8) `bleach`                                         | 6.1.0          |
| <font color="red" style="font-weight:bold;">(11) certifi</font> | <font color="red" style="font-weight:bold;">2024.7.4</font> |                                                      |                |
| (12) `cffi`                                                  | 1.16.0                                                      | (9) `cffi`                                           | 1.16.0         |
| <font color="red" style="font-weight:bold;">(13) charset-normalizer</font> | <font color="red" style="font-weight:bold;">3.3.2</font>    |                                                      |                |
| (14) `colorama`                                              | 0.4.6                                                       | (10) `colorama`                                      | 0.4.6          |
| (15) `comm`                                                  | 0.2.2                                                       | (11) `comm`                                          | 0.2.2          |
| (16) `debugpy`                                               | 1.8.2                                                       | (12) `debugpy`                                       | 1.8.2          |
| (17) `decorator`                                             | 5.1.1                                                       | (13) `decorator`                                     | 5.1.1          |
| (18) `defusedxml`                                            | 0.7.1                                                       | (14) `defusedxml`                                    | 0.7.1          |
| (19) `entrypoints`                                           | 0.4                                                         | (15) `entrypoints`                                   | 0.4            |
| (20) `executing`                                             | 2.0.1                                                       | (16) `executing`                                     | 2.0.1          |
| (21) `fastjsonschema`                                        | 2.20.0                                                      | (17) `fastjsonschema`                                | 2.20.0         |
| (22) `fqdn`                                                  | 1.5.1                                                       | (18) `fqdn`                                          | 1.5.1          |
| <font color="red" style="font-weight:bold;">(23) h11</font>  | <font color="red" style="font-weight:bold;">0.14.0</font>   |                                                      |                |
| <font color="red" style="font-weight:bold;">(24) httpcore</font> | <font color="red" style="font-weight:bold;">1.0.5</font>    |                                                      |                |
| <font color="red" style="font-weight:bold;">(25) httpx</font> | <font color="red" style="font-weight:bold;">0.27.0</font>   |                                                      |                |
| (26) `idna`                                                  | 3.7                                                         | (19) `idna`                                          | 3.7            |
| (27) `ipykernel`                                             | 6.29.5                                                      | (20) `ipykernel`                                     | 6.29.5         |
| (28) `ipython`                                               | 8.26.0                                                      | (21) `ipython`                                       | 8.26.0         |
| (29) `ipython-genutils`                                      | 0.2.0                                                       | (22) `ipython-genutils`                              | 0.2.0          |
| (30) `isoduration`                                           | 20.11.0                                                     | (23) `isoduration`                                   | 20.11.0        |
| (31) `jedi`                                                  | 0.19.1                                                      | (24) `jedi`                                          | 0.19.1         |
| (32) `Jinja2`                                                | 3.1.4                                                       | (25) `Jinja2`                                        | 3.1.4          |
| <font color="red" style="font-weight:bold;">(33) json5</font> | <font color="red" style="font-weight:bold;">0.9.25</font>   |                                                      |                |
| (34) `jsonpointer`                                           | 3.0.0                                                       | (26) `jsonpointer`                                   | 3.0.0          |
| (35) `jsonschema`                                            | 4.23.0                                                      | (27) `jsonschema`                                    | 4.23.0         |
| (36) `jsonschema-specifications`                             | 2023.12.1                                                   | (28) `jsonschema-specifications`                     | 2023.12.1      |
| (37) `jupyter_client`                                        | 7.4.9                                                       | (29) `jupyter_client`                                | 7.4.9          |
| (38) `jupyter_contrib_core`                                  | 0.4.2                                                       | (30) `jupyter_contrib_core`                          | 0.4.2          |
| (39) `jupyter_contrib_nbextensions`                          | 0.7.0                                                       | (31) `jupyter_contrib_nbextensions`                  | 0.7.0          |
| (40) `jupyter_core`                                          | 5.7.2                                                       | (32) `jupyter_core`                                  | 5.7.2          |
| (41) `jupyter-events`                                        | 0.10.0                                                      | (33) `jupyter-events`                                | 0.10.0         |
| (42) `jupyter-highlight-selected-word`                       | 0.2.0                                                       | (34) `jupyter-highlight-selected-word`               | 0.2.0          |
| <font color="red" style="font-weight:bold;">(43) jupyter-lsp</font> | <font color="red" style="font-weight:bold;">2.2.5</font>    |                                                      |                |
| (44) `jupyter_nbextensions_configurator`                     | 0.6.4                                                       | (35) `jupyter_nbextensions_configurator`             | 0.6.4          |
| (45) `jupyter-server`                                        | 1.24.0                                                      | (36) `jupyter-server`                                | 1.24.0         |
| (46) `jupyter_server_terminals`                              | 0.5.3                                                       | (37) `jupyter_server_terminals`                      | 0.5.3          |
| <font color="red" style="font-weight:bold;">(47) jupyterlab</font> | <font color="red" style="font-weight:bold;">4.2.3</font>    |                                                      |                |
| (48) `jupyterlab_pygments`                                   | 0.3.0                                                       | (38) `jupyterlab_pygments`                           | 0.3.0          |
| <font color="red" style="font-weight:bold;">(49) jupyterlab_server</font> | <font color="red" style="font-weight:bold;">2.27.2</font>   |                                                      |                |
| (50) `lxml`                                                  | 5.2.2                                                       | (39) `lxml`                                          | 5.2.2          |
| (51) `MarkupSafe`                                            | 2.1.5                                                       | (40) `MarkupSafe`                                    | 2.1.5          |
| (52) `matplotlib-inline`                                     | 0.1.7                                                       | (41) `matplotlib-inline`                             | 0.1.7          |
| (53) `mistune`                                               | 3.0.2                                                       | (42) `mistune`                                       | 3.0.2          |
| (54) `nbclassic`                                             | 1.1.0                                                       | (43) `nbclassic`                                     | 1.1.0          |
| (55) `nbclient`                                              | 0.10.0                                                      | (44) `nbclient`                                      | 0.10.0         |
| (56) `nbconvert`                                             | 7.16.4                                                      | (45) `nbconvert`                                     | 7.16.4         |
| (57) `nbformat`                                              | 5.10.4                                                      | (46) `nbformat`                                      | 5.10.4         |
| (58) `nest-asyncio`                                          | 1.6.0                                                       | (47) `nest-asyncio`                                  | 1.6.0          |
| (59) `notebook`                                              | 6.5.7                                                       | (48) `notebook`                                      | 6.5.7          |
| (60) `notebook_shim`                                         | 0.2.4                                                       | (49) `notebook_shim`                                 | 0.2.4          |
| (61) `overrides`                                             | 7.7.0                                                       | (50) `overrides`                                     | 7.7.0          |
| (62) `packaging`                                             | 24.1                                                        | (51) `packaging`                                     | 24.1           |
| (63) `pandocfilters`                                         | 1.5.1                                                       | (52) `pandocfilters`                                 | 1.5.1          |
| (64) `parso`                                                 | 0.8.4                                                       | (53) `parso`                                         | 0.8.4          |
| (65) `pip`                                                   | 24.0                                                        | (54) `pip`                                           | 24.0           |
| (66) `platformdirs`                                          | 4.2.2                                                       | (55) `platformdirs`                                  | 4.2.2          |
| (67) `prometheus_client`                                     | 0.20.0                                                      | (56) `prometheus_client`                             | 0.20.0         |
| (68) `prompt_toolkit`                                        | 3.0.47                                                      | (57) `prompt_toolkit`                                | 3.0.47         |
| (69) `psutil`                                                | 6.0.0                                                       | (58) `psutil`                                        | 6.0.0          |
| (70) `pure-eval`                                             | 0.2.2                                                       | (59) `pure-eval`                                     | 0.2.2          |
| (71) `pycparser`                                             | 2.22                                                        | (60) `pycparser`                                     | 2.22           |
| (72) `Pygments`                                              | 2.18.0                                                      | (61) `Pygments`                                      | 2.18.0         |
| (73) `python-dateutil`                                       | 2.9.0.post0                                                 | (62) `python-dateutil`                               | 2.9.0.post0    |
| (74) `python-json-logger`                                    | 2.0.7                                                       | (63) `python-json-logger`                            | 2.0.7          |
| (75) `pywin32`                                               | 306                                                         | (64) `pywin32`                                       | 306            |
| (76) `pywinpty`                                              | 2.0.13                                                      | (65) `pywinpty`                                      | 2.0.13         |
| (77) `PyYAML`                                                | 6.0.1                                                       | (66) `PyYAML`                                        | 6.0.1          |
| (78) `pyzmq`                                                 | 26.0.3                                                      | (67) `pyzmq`                                         | 26.0.3         |
| (79) `referencing`                                           | 0.35.1                                                      | (68) `referencing`                                   | 0.35.1         |
| <font color="red" style="font-weight:bold;">(80) requests</font> | <font color="red" style="font-weight:bold;">2.32.3</font>   |                                                      |                |
| (81) `rfc3339-validator`                                     | 0.1.4                                                       | (69) `rfc3339-validator`                             | 0.1.4          |
| (82) `rfc3986-validator`                                     | 0.1.1                                                       | (70) `rfc3986-validator`                             | 0.1.1          |
| (83) `rpds-py`                                               | 0.19.0                                                      | (71) `rpds-py`                                       | 0.19.0         |
| (84) `Send2Trash`                                            | 1.8.3                                                       | (72) `Send2Trash`                                    | 1.8.3          |
| (85) `setuptools`                                            | 65.5.0                                                      | (73) `setuptools`                                    | 65.5.0         |
| (86) `six`                                                   | 1.16.0                                                      | (74) `six`                                           | 1.16.0         |
| (87) `sniffio`                                               | 1.3.1                                                       | (75) `sniffio`                                       | 1.3.1          |
| (88) `soupsieve`                                             | 2.5                                                         | (76) `soupsieve`                                     | 2.5            |
| (89) `stack-data`                                            | 0.6.3                                                       | (77) `stack-data`                                    | 0.6.3          |
| (90) `terminado`                                             | 0.18.1                                                      | (78) `terminado`                                     | 0.18.1         |
| (91) `tinycss2`                                              | 1.3.0                                                       | (79) `tinycss2`                                      | 1.3.0          |
| (92) `tornado`                                               | 6.4.1                                                       | (80) `tornado`                                       | 6.4.1          |
| (93) `traitlets`                                             | 5.14.3                                                      | (81) `traitlets`                                     | 5.14.3         |
| (94) `types-python-dateutil`                                 | 2.9.0.20240316                                              | (82) `types-python-dateutil`                         | 2.9.0.20240316 |
| (95) `typing_extensions`                                     | 4.12.2                                                      | (83) `typing_extensions`                             | 4.12.2         |
| (96) `uri-template`                                          | 1.3.0                                                       | (84) `uri-template`                                  | 1.3.0          |
| <font color="red" style="font-weight:bold;">(97) urllib3</font> | <font color="red" style="font-weight:bold;">2.2.2</font>    |                                                      |                |
| (98) `wcwidth`                                               | 0.2.13                                                      | (85) `wcwidth`                                       | 0.2.13         |
| (99) `webcolors`                                             | 24.6.0                                                      | (86) `webcolors`                                     | 24.6.0         |
| (100) `webencodings`                                         | 0.5.1                                                       | (87) `webencodings`                                  | 0.5.1          |
| (101) `websocket-client`                                     | 1.8.0                                                       | (88) `websocket-client`                              | 1.8.0          |

<br>

**References**

[^1]: [The Way to Install Python Jupyter Notebook: the difference between pip install notebook (recommended) and pip install jupyter - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-10/10-20-53.html).
[^2]: [ModuleNotFoundError: No module named ‘notebook.base‘_modulenotfounderror: no module named 'notebook.bas-CSDN博客](https://blog.csdn.net/jingmenghai/article/details/131870625).
[^3]: [Downgrade Package by Python pip - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-08/19-04-51.html).
[^4]: [https://stackoverflow.com/a/75221670/22763127](https://stackoverflow.com/a/75221670/22763127).
[^5]: [jupyter/notebook: Jupyter Interactive Notebook](https://github.com/jupyter/notebook).
[^6]: [ipython-contrib/jupyter\_contrib\_nbextensions: A collection of various notebook extensions for Jupyter](https://github.com/ipython-contrib/jupyter_contrib_nbextensions).
