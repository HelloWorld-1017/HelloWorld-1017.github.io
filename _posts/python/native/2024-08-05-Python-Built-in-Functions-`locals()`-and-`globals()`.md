---
title: Python Built-in Functions `locals()` and `globals()`
toc: false
categories:
 - Python
tags:
 - Native Python
date: 2024-08-05 19:04:55 +0800
last_modified_at: 2024-08-05 19:04:55 +0800
---

Official description for Python `locals()` function[^1]:

<div class="quote--left" markdown="1" id="locals">

Update and return a dictionary representing the current local symbol table. Free variables are returned by [`locals()`](https://docs.python.org/3/library/functions.html#locals) when it is called in function blocks, but not in class blocks. Note that at the module level, [`locals()`](https://docs.python.org/3/library/functions.html#locals) and [`globals()`](https://docs.python.org/3/library/functions.html#globals) are the same dictionary.

Note: The contents of this dictionary should not be modified; changes may not affect the values of local and free variables used by the interpreter.

</div>

and `globals()` function[^2]:

<div class="quote--left" markdown="1">

Return the dictionary implementing the current module namespace. For code within functions, this is set when the function is defined and remains the same regardless of where the function is called.

</div>

For example:

```python
def helperAdd(a, b, c):
    sum = a+b+c
    
    print(locals())
    
    return sum

sum = helperAdd(1, 2, 3)

globals()
```

```
{'a': 1, 'b': 2, 'c': 3, 'sum': 6}
{'__name__': '__main__',
 '__doc__': 'Automatically created module for IPython interactive environment',
 '__package__': None,
 '__loader__': None,
 '__spec__': None,
 '__builtin__': <module 'builtins' (built-in)>,
 '__builtins__': <module 'builtins' (built-in)>,
 '_ih': ['',
  'def helperAdd(a, b, c):\n    sum = a+b+c\n    \n    print(locals())\n    \n    return sum\n\nsum = helperAdd(1, 2, 3)\n\nglobals()'],
 '_oh': {},
 '_dh': [WindowsPath('G:/.../...')],
 'In': ['',
  'def helperAdd(a, b, c):\n    sum = a+b+c\n    \n    print(locals())\n    \n    return sum\n\nsum = helperAdd(1, 2, 3)\n\nglobals()'],
 'Out': {},
 'get_ipython': <function IPython.core.getipython.get_ipython()>,
 'exit': <IPython.core.autocall.ZMQExitAutocall at 0x218197e5410>,
 'quit': <IPython.core.autocall.ZMQExitAutocall at 0x218197e5410>,
 'open': <function io.open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None)>,
 '_': '',
 '__': '',
 '___': '',
 'json': <module 'json' from 'G:\\Spyder\\Python311\\Lib\\json\\__init__.py'>,
 'autopep8': <module 'autopep8' from 'G:\\...\\venv\\Lib\\site-packages\\autopep8.py'>,
 'getsizeof': <function sys.getsizeof>,
 'NamespaceMagics': IPython.core.magics.namespace.NamespaceMagics,
 '_nms': <IPython.core.magics.namespace.NamespaceMagics at 0x21819901fd0>,
 '_Jupyter': <ipykernel.zmqshell.ZMQInteractiveShell at 0x218197dc390>,
 'np': <module 'numpy' from 'G:\\...\\venv\\Lib\\site-packages\\numpy\\__init__.py'>,
 '_getsizeof': <function __main__._getsizeof(x)>,
 '_getshapeof': <function __main__._getshapeof(x)>,
 '_getcontentof': <function __main__._getcontentof(x)>,
 'var_dic_list': <function __main__.var_dic_list()>,
 '_i': '',
 '_ii': '',
 '_iii': '',
 '_i1': 'def helperAdd(a, b, c):\n    sum = a+b+c\n    \n    print(locals())\n    \n    return sum\n\nsum = helperAdd(1, 2, 3)\n\nglobals()',
 'helperAdd': <function __main__.helperAdd(a, b, c)>,
 'sum': 6}
```

<br>

By `globals()` function, users can modify variable value in current work space by indexing variable name[^3] like syntax `globals()['<variable_name>'] = <value>`, but it’s not functional by `locals()` function (as said “Note” in the [documentation](#locals)). We can simply verify this point:

```python
def helperAdd(a, b, c):
    sum = a+b+c
    
    print('a (local):', locals()['a'])
    
    a = 10
    
    print('a (local):', locals()['a'])
    
    locals()['a'] = 100
    
    print('a (local):', locals()['a'])
    
    return sum

sum = helperAdd(1, 2, 3)
print('sum (global):', globals()['sum'])

sum = 10
print('sum (global):', globals()['sum'])

globals()['sum'] = 100
print('sum (global):', globals()['sum'])
```

```
a (local): 1
a (local): 10
a (local): 10
sum (global): 6
sum (global): 10
sum (global): 100
```

<br>

**References**

[^1]: [Built-in Functions: `locals()` — Python 3.12.4 documentation](https://docs.python.org/3/library/functions.html#locals).
[^2]: [Built-in Functions: `globals()` — Python 3.12.4 documentation](https://docs.python.org/3/library/functions.html#globals).
[^3]: [Python - `globals()` function - GeeksforGeeks](https://www.geeksforgeeks.org/python-globals-function/).