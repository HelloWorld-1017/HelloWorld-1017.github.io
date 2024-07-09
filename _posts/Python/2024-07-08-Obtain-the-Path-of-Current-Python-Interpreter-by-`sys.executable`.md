---
title: Obtain the Path of Current Python Interpreter by `sys.executable`
toc: false
categories:
 - Python
tags:
 - Python sys
date: 2024-07-08 18:44:39 +0800
last_modified_at: 2024-07-08 18:44:39 +0800
modification_history:
 - 2024-07-08 18:44:39 +0800
---

As in the official documentation[^1], by executing `sys.executable` function of Python `sys` package, we can get:

<div class="quote--left" markdown="1">

 A string giving the absolute path of the executable binary for the Python interpreter, on systems where this makes sense. If Python is unable to retrieve the real path to its executable, `sys.executable` will be an empty string or `None`.

</div>

Take my case.

```python
import sys
sys.executable
```

```
'G:\\Spyder\\Python311\\python.exe'
```

<br>

# References

[^1]: [sys — System-specific parameters and functions — Python 3.12.4 documentation](https://docs.python.org/3/library/sys.html#sys.executable).
