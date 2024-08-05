---
title: "Explore Python Module, Class, and Function by `help` function, `__doc__` attribute, and `dir` function"
categories:
 - Python
tags:
 - Native Python
 - Python Numpy
 - Python PyTorch
date: 2024-08-05 16:41:24 +0800
last_modified_at: 2024-08-05 16:41:24 +0800
---

# `help` function

Python `help` function[^1] is to:

<div class="quote--left" markdown="1">

Invoke the built-in help system. (This function is intended for interactive use.) If no argument is given, the interactive help system starts on the interpreter console. If the argument is a string, then the string is looked up as the name of a module, function, class, method, keyword, or documentation topic, and a help page is printed on the console. If the argument is any other kind of object, a help page on the object is generated.

</div>

The help documentation that can be printed through `help` function is called “docstrings”, which is a kind of special comment[^2]:

<div class="quote--left" markdown="1" id="docstrings">
... The docstring(documentation string) is used for documentation. It is nested inside triple quotes and is the first statement within a class or function or a module.

</div>

i.e. the first comment nested in triple quotes after the class (or function etc.) statement.

Here are some examples.

## `help` function without argument

As introduced, `help()` function without argument will invoke the interactive help system:

```python
help()
```

```
Welcome to Python 3.11's help utility! If this is your first time using
Python, you should definitely check out the tutorial at
https://docs.python.org/3.11/tutorial/.

Enter the name of any module, keyword, or topic to get help on writing
Python programs and using Python modules.  To get a list of available
modules, keywords, symbols, or topics, enter "modules", "keywords",
"symbols", or "topics".

Each module also comes with a one-line summary of what it does; to list
the modules whose name or summary contain a given string such as "spam",
enter "modules spam".

To quit this help utility and return to the interpreter,
enter "q" or "quit".

help>
```

Then, we can input class name etc. to ask for help information. But, I think directly taking it as input parameter of `help` function is more convenient.

## For Python built-in function

```python
help(print)
```

```
Help on built-in function print in module builtins:

print(*args, sep=' ', end='\n', file=None, flush=False)
    Prints the values to a stream, or to sys.stdout by default.
    
    sep
      string inserted between values, default a space.
    end
      string appended after the last value, default a newline.
    file
      a file-like object (stream); defaults to the current sys.stdout.
    flush
      whether to forcibly flush the stream.
```

## For self-defined function

The following simple example can well verify aforementioned introduction to [docstrings](#docstrings):

```python
def help_function():
    '''
    This is a self-defined function (first commont nested in triple quotes).
    '''
    
    '''
    This is a self-defined function (second commont nested in triple quotes).
    '''
    
    # This is a self-defined function (first comment after hashtag)
    
    print("HELP!")
    
    '''
    Commont nested in triple quotes after function definition
    '''
    
    # Commont after hashtag after function definition
    
help(help_function)
```

```
Help on function help_function in module __main__:

help_function()
    This is a self-defined function (first commont nested in triple quotes).
```

## For self-defined class

Define a simple class `Helper`[^2], then we can query its help information by syntax like `help(<class_name>)`:

```python
class Helper:
    '''
    Helper class definition
    '''
    def __init__(self):
        '''The helper class is initialized'''

    def print_help(self):
        '''Returns the help description'''
        print('helper description')

help(Helper)
```

```
Help on class Helper in module __main__:

class Helper(builtins.object)
 |  Helper class definition
 |  
 |  Methods defined here:
 |  
 |  __init__(self)
 |      The helper class is initialized
 |  
 |  print_help(self)
 |      Returns the help description
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __dict__
 |      dictionary for instance variables
 |  
 |  __weakref__
 |      list of weak references to the object
```

or the help information of particular method by `help(<certain_method_of_the_class>)`:

```python
help(Helper.print_help)
```

```
Help on function print_help in module __main__:

print_help(self)
    Returns the help description
```

## For built-in class and object in certain package

### Numpy `ndarray`

Most mature Python packages usually provide detailed help documentation that can be accessed and printed through `help` function. Likewise, these docstrings are wrapped by triple quotes, but the whole code structure seem not that apparent. Take Python Numpy (my version is `'1.26.4'`) for example, if we execute following code:

```python
import numpy as np

help(np.array([1. ,2. ,3.]))
```

we’ll get a much detailed help information, which can be found in [Appendix I](#appendix-i).

We can find those help docstrings are stored in `numpy\core\_add_newdocs.py` file (corresponding file in GitHub repo is [https://github.com/numpy/numpy/blob/v1.26.4/numpy/core/\_add\_newdocs.py](https://github.com/numpy/numpy/blob/v1.26.4/numpy/core/_add_newdocs.py)), which is not the file where Numpy `ndarray` is defined. 

Code structure of `_add_newdocs.py` looks like:

```python
"""
This is only meant to add docs to objects defined in C-extension modules.
The purpose is to allow easier editing of the docstrings without
requiring a re-compile.

NOTE: Many of the methods of ndarray have corresponding functions.
      If you update these docstrings, please keep also the ones in
      core/fromnumeric.py, core/defmatrix.py up-to-date.

"""

from numpy.core.function_base import add_newdoc
from numpy.core.overrides import array_function_like_doc


###############################################################################
#
# flatiter
#
# flatiter needs a toplevel description
#
###############################################################################

add_newdoc('numpy.core', 'flatiter',
    """
    help information ...
    """)

add_newdoc('numpy.core', 'flatiter', ('base',
    """
    help information ...
    """))

add_newdoc('numpy.core', 'flatiter', ('coords',
    """
    help information ...
    """))

# ...


##############################################################################
#
# Documentation for ndarray attributes and methods
#
##############################################################################


##############################################################################
#
# ndarray object
#
##############################################################################

add_newdoc('numpy.core.multiarray', 'ndarray', 
    """
    help information ...
    """)

##############################################################################
#
# ndarray attributes
#
##############################################################################

add_newdoc('numpy.core.multiarray', 'ndarray', ('__array_interface__',
    """Array protocol: Python side."""))

add_newdoc('numpy.core.multiarray', 'ndarray', ('__array_priority__',
    """Array priority."""))

# ...

add_newdoc('numpy.core.multiarray', 'ndarray', ('view',
    """
    help information ...
    """))

##############################################################################
#
# umath functions
#
##############################################################################
add_newdoc('numpy.core.umath', 'frompyfunc',
    """
    help information ...
    """)

add_newdoc('numpy.core.umath', 'geterrobj',
    """
    help information ...
    """)

# ...
```

We can realize that this file is specially used for adding docstrings by `add_newdoc` function, which is imported from `numpy.core.function_base` module. And, this file defines docstrings for different classes, not exclusive for `ndarray`. From results in [Appendix I](#appendix-i), we can see that in this case those docstrings related to `ndarray`, including “ndarray object” part and “ndarray attributes” parts, are all printed (in alphabetical order).

On the other hand, if we run the code:

```python
help(np.array)
```

we’ll get help documentation in [Appendix II](#appendix-ii). We can find at this time only docstrings in “ndarray object” part are printed. So, this example also shows the difference between the cases of taking “object” and “class” as input  of `help` function. And, the beginning text in [Appendix I](#appendix-i), `Help on ndarray object:`, and that in [Appendix II](#appendix-ii), `Help on built-in function array in module numpy:`,  also show this point.

### PyTorch `tensor`

It’s similar for PyTorch `Tensor` (my version is `'2.3.1+cu121'`), we can try:

```python
import torch

help(torch.tensor([1. ,2. ,3. ]))
```

```python
help(torch.tensor)
```

and their results are showed in [Appendix III](#appendix-iii) and [Appendix IV](#appendix-iv), respectively. The difference between them is like above Numpy `ndarray` case.

We can find these help documentation in `toch\_tensor.py` file (corresponding file in GitHub repo `v2.3.1` branch is [https://github.com/pytorch/pytorch/blob/v2.3.1/torch/\_tensor.py](https://github.com/pytorch/pytorch/blob/v2.3.1/torch/_tensor.py)), which is like:

```python
# ...

def _handle_torch_function_and_wrap_type_error_to_not_implemented(f):
    # ...
    return wrapped


# Should not be used, this is kept only for BC of loading old serialized Tensor subclasses
def _rebuild_from_type(func, type, args, dict):
    # ...
    return ret


def _rebuild_from_type_v2(func, new_type, args, state):
    # ...
    return ret


# NB: If you subclass Tensor, and want to share the subclassed class
# across processes, you must also update torch/multiprocessing/reductions.py
# to define a ForkingPickler serialization mode for the class.
#
# NB: If you add a new method to Tensor, you must update
# torch/_C/__init__.pyi.in to add a type annotation for your method;
# otherwise, it will not show up in autocomplete.
class Tensor(torch._C.TensorBase):
    # ...
    __module__ = "torch"

def _convert(ret, cls):
    # ...
    return ret
```

As can be seen, for PyTorch `Tensor`, class definition and docstrings are put together.

<br>

# `__doc__` attribute

By printing `__doc__` attribute, we can also obtain docstrings. For example, for self-defined class, we have:

```python
class Helper:
    '''
    Helper class definition
    '''
    def __init__(self):
        '''The helper class is initialized'''

    def print_help(self):
        '''Returns the help description'''
        print('helper description')

print("docstrings obtained by `__doc__` attribute:")
print(Helper.__doc__)
print(Helper.__init__.__doc__)
print(Helper.print_help.__doc__)
```

```
docstrings obtained by `__doc__` attribute:

    Helper class definition
    
The helper class is initialized
Returns the help description
```

We can find that, compared with `help` function, the results obtained by `__doc_` look sort of simple, and for Python class, `<class_name>.__doc__` only shows ensuing docstrings after class statement, not including docstrings of its methods and attributes. We could check this point by looking at Numpy array again.

```python
import numpy as np

print(np.array.__doc__)
print(np.array([1., 2., 3.]).__doc__)
```

the results are showed in [Appendix V](#appendix-v) and [Appendix VI](appendix-vi), respectively.

<br>

# `dir` function

`help` function and `__doc_` attribute can return detailed help documentation, but if we only want to list names of available attributes and methods of certain module (class, or function), we can use `dir` function[^3][^4][^5]:

<div class="quote--left" markdown="1">

It is one of the built-in functions that is available in Python which has one optional argument. This built-in function will return the list of names in the current local scope. The `dir()` function syntax is `dir(object)`. The object can be a function, module, string, tuple, dictionary, etc.

The [`dir()` function](https://www.geeksforgeeks.org/python-dir-function/) is considered one of the functions that is useful in the debugging process. The return value from this function is different based on the argument passed. There are four types of return values in the `dir()` function:

- No argument: return the list of names in the current local scope.
- Module object as argument: return the list containing the names of the module’s attributes.
- Type or class object: return the list containing the names of its attributes, and recursively of the attributes of its bases.
- Other object: return the list containing the object’s attributes’ names, the names of its class’s attributes, and recursively of the attributes of its class’s base classes.

</div>

## `dir` function without argument

As above, `dir` function without argument, i.e. `dir()`, can “return the list of names in the *current local scope*.” Even if we don't run any program, `dir()` will still return values. And, in different IDE or editors, outputs of `dir()` are different.

For example, directly open Python in the Console and run:

```python
dir()
```

```
['__annotations__', '__builtins__', '__doc__', '__loader__', '__name__', '__package__', '__spec__']
```

whereas in Spyder IDE:

```python
dir()
```

```
['In',
 'Out',
 '_',
 '__',
 '___',
 '__builtin__',
 '__builtins__',
 '__doc__',
 '__loader__',
 '__name__',
 '__package__',
 '__spec__',
 '_dh',
 '_i',
 '_i1',
 '_ih',
 '_ii',
 '_iii',
 '_oh',
 'exit',
 'get_ipython',
 'open',
 'quit']
```

and in Jupyter Notebook:

```python
dir()
```

```
['In',
 'NamespaceMagics',
 'Out',
 '_',
 '_Jupyter',
 '__',
 '___',
 '__builtin__',
 '__builtins__',
 '__doc__',
 '__loader__',
 '__name__',
 '__package__',
 '__spec__',
 '_dh',
 '_getcontentof',
 '_getshapeof',
 '_getsizeof',
 '_i',
 '_i1',
 '_ih',
 '_ii',
 '_iii',
 '_nms',
 '_oh',
 'autopep8',
 'exit',
 'get_ipython',
 'getsizeof',
 'json',
 'np',
 'open',
 'quit',
 'var_dic_list']
```

Then, if we define some variables (e.g. in the case of Jupyter Notebook), there will be some corresponding variables in `dir()` results:

```python
aa, bb, cc = 1, 2, 3

dir()
```

```
['In',
 'NamespaceMagics',
 'Out',
 '_',
 '_1',
 '_Jupyter',
 '__',
 '___',
 '__builtin__',
 '__builtins__',
 '__doc__',
 '__loader__',
 '__name__',
 '__package__',
 '__spec__',
 '_dh',
 '_getcontentof',
 '_getshapeof',
 '_getsizeof',
 '_i',
 '_i1',
 '_i2',
 '_ih',
 '_ii',
 '_iii',
 '_nms',
 '_oh',
 'aa',
 'autopep8',
 'bb',
 'cc',
 'exit',
 'get_ipython',
 'getsizeof',
 'json',
 'np',
 'open',
 'quit',
 'var_dic_list']
```

<div class="notice--primary" markdown="1">

About this point, `globals` function is more powerful:

```python
globals()
```

```
{'__name__': '__main__',
 '__doc__': 'Automatically created module for IPython interactive environment',
 '__package__': None,
 '__loader__': None,
 '__spec__': None,
 '__builtin__': <module 'builtins' (built-in)>,
 '__builtins__': <module 'builtins' (built-in)>,
 '_ih': ['', 'aa, bb, cc = 1, 2, 3\n\nprint(dir())', 'globals()'],
 '_oh': {},
 '_dh': [WindowsPath('G:/.../...')],
 'In': ['', 'aa, bb, cc = 1, 2, 3\n\nprint(dir())', 'globals()'],
 'Out': {},
 'get_ipython': <function IPython.core.getipython.get_ipython()>,
 'exit': <IPython.core.autocall.ZMQExitAutocall at 0x170c34b53d0>,
 'quit': <IPython.core.autocall.ZMQExitAutocall at 0x170c34b53d0>,
 'open': <function io.open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None)>,
 '_': '',
 '__': '',
 '___': '',
 'json': <module 'json' from 'G:\\Spyder\\Python311\\Lib\\json\\__init__.py'>,
 'autopep8': <module 'autopep8' from 'G:\\...\\venv\\Lib\\site-packages\\autopep8.py'>,
 'getsizeof': <function sys.getsizeof>,
 'NamespaceMagics': IPython.core.magics.namespace.NamespaceMagics,
 '_nms': <IPython.core.magics.namespace.NamespaceMagics at 0x170c3509410>,
 '_Jupyter': <ipykernel.zmqshell.ZMQInteractiveShell at 0x170c34ac750>,
 'np': <module 'numpy' from 'G:\\...\\venv\\Lib\\site-packages\\numpy\\__init__.py'>,
 '_getsizeof': <function __main__._getsizeof(x)>,
 '_getshapeof': <function __main__._getshapeof(x)>,
 '_getcontentof': <function __main__._getcontentof(x)>,
 'var_dic_list': <function __main__.var_dic_list()>,
 '_i': 'aa, bb, cc = 1, 2, 3\n\nprint(dir())',
 '_ii': '',
 '_iii': '',
 '_i1': 'aa, bb, cc = 1, 2, 3\n\nprint(dir())',
 'aa': 1,
 'bb': 2,
 'cc': 3,
 '_i2': 'globals()'}
```

</div>

## For built-in function

```python
dir(print)
```

```
['__call__',
 '__class__',
 '__delattr__',
 '__dir__',
 '__doc__',
 '__eq__',
 '__format__',
 '__ge__',
 '__getattribute__',
 '__getstate__',
 '__gt__',
 '__hash__',
 '__init__',
 '__init_subclass__',
 '__le__',
 '__lt__',
 '__module__',
 '__name__',
 '__ne__',
 '__new__',
 '__qualname__',
 '__reduce__',
 '__reduce_ex__',
 '__repr__',
 '__self__',
 '__setattr__',
 '__sizeof__',
 '__str__',
 '__subclasshook__',
 '__text_signature__']
```

## For class, function, and object

For self-defined class `Helper`:

```python
class Helper:
    '''
    Helper class definition
    '''
    def __init__(self):
        '''The helper class is initialized'''

    def print_help(self):
        '''Returns the help description'''
        print('helper description')
    
    def print_help1(self):
        pass
    
    def print_help2(self):
        pass

dir(Helper)
```

```
['__class__',
 '__delattr__',
 '__dict__',
 '__dir__',
 '__doc__',
 '__eq__',
 '__format__',
 '__ge__',
 '__getattribute__',
 '__getstate__',
 '__gt__',
 '__hash__',
 '__init__',
 '__init_subclass__',
 '__le__',
 '__lt__',
 '__module__',
 '__ne__',
 '__new__',
 '__reduce__',
 '__reduce_ex__',
 '__repr__',
 '__setattr__',
 '__sizeof__',
 '__str__',
 '__subclasshook__',
 '__weakref__',
 'print_help',
 'print_help1',
 'print_help2']
```

Similarly, for Numpy `ndarray`:

```python
import numpy as np

dir(np.array)
```

Or, we can use `np.array.__dir__()`.
{: .notice--primary}

```
['__call__',
 '__class__',
 '__delattr__',
 '__dir__',
 '__doc__',
 '__eq__',
 '__format__',
 '__ge__',
 '__getattribute__',
 '__getstate__',
 '__gt__',
 '__hash__',
 '__init__',
 '__init_subclass__',
 '__le__',
 '__lt__',
 '__module__',
 '__name__',
 '__ne__',
 '__new__',
 '__qualname__',
 '__reduce__',
 '__reduce_ex__',
 '__repr__',
 '__self__',
 '__setattr__',
 '__sizeof__',
 '__str__',
 '__subclasshook__',
 '__text_signature__']
```

and corresponding object:

```python
dir(np.array([1., 2., 3.]))
```

Similarly, it’s okay to use `np.array([1., 2., 3.]).__dir__()`.
{: .notice--primary}

```
['T',
 '__abs__',
 '__add__',
 '__and__',
 '__array__',
 '__array_finalize__',
 '__array_function__',
 '__array_interface__',
 '__array_prepare__',
 '__array_priority__',
 '__array_struct__',
 '__array_ufunc__',
 '__array_wrap__',
 '__bool__',
 '__class__',
 '__class_getitem__',
 '__complex__',
 '__contains__',
 '__copy__',
 '__deepcopy__',
 '__delattr__',
 '__delitem__',
 '__dir__',
 '__divmod__',
 '__dlpack__',
 '__dlpack_device__',
 '__doc__',
 '__eq__',
 '__float__',
 '__floordiv__',
 '__format__',
 '__ge__',
 '__getattribute__',
 '__getitem__',
 '__getstate__',
 '__gt__',
 '__hash__',
 '__iadd__',
 '__iand__',
 '__ifloordiv__',
 '__ilshift__',
 '__imatmul__',
 '__imod__',
 '__imul__',
 '__index__',
 '__init__',
 '__init_subclass__',
 '__int__',
 '__invert__',
 '__ior__',
 '__ipow__',
 '__irshift__',
 '__isub__',
 '__iter__',
 '__itruediv__',
 '__ixor__',
 '__le__',
 '__len__',
 '__lshift__',
 '__lt__',
 '__matmul__',
 '__mod__',
 '__mul__',
 '__ne__',
 '__neg__',
 '__new__',
 '__or__',
 '__pos__',
 '__pow__',
 '__radd__',
 '__rand__',
 '__rdivmod__',
 '__reduce__',
 '__reduce_ex__',
 '__repr__',
 '__rfloordiv__',
 '__rlshift__',
 '__rmatmul__',
 '__rmod__',
 '__rmul__',
 '__ror__',
 '__rpow__',
 '__rrshift__',
 '__rshift__',
 '__rsub__',
 '__rtruediv__',
 '__rxor__',
 '__setattr__',
 '__setitem__',
 '__setstate__',
 '__sizeof__',
 '__str__',
 '__sub__',
 '__subclasshook__',
 '__truediv__',
 '__xor__',
 'all',
 'any',
 'argmax',
 'argmin',
 'argpartition',
 'argsort',
 'astype',
 'base',
 'byteswap',
 'choose',
 'clip',
 'compress',
 'conj',
 'conjugate',
 'copy',
 'ctypes',
 'cumprod',
 'cumsum',
 'data',
 'diagonal',
 'dot',
 'dtype',
 'dump',
 'dumps',
 'fill',
 'flags',
 'flat',
 'flatten',
 'getfield',
 'imag',
 'item',
 'itemset',
 'itemsize',
 'max',
 'mean',
 'min',
 'nbytes',
 'ndim',
 'newbyteorder',
 'nonzero',
 'partition',
 'prod',
 'ptp',
 'put',
 'ravel',
 'real',
 'repeat',
 'reshape',
 'resize',
 'round',
 'searchsorted',
 'setfield',
 'setflags',
 'shape',
 'size',
 'sort',
 'squeeze',
 'std',
 'strides',
 'sum',
 'swapaxes',
 'take',
 'tobytes',
 'tofile',
 'tolist',
 'tostring',
 'trace',
 'transpose',
 'var',
 'view']
```

<br>

# Appendix

## Appendix I

```
Help on ndarray object:

class ndarray(builtins.object)
 |  ndarray(shape, dtype=float, buffer=None, offset=0,
 |          strides=None, order=None)
 |  
 |  An array object represents a multidimensional, homogeneous array
 |  of fixed-size items.  An associated data-type object describes the
 |  format of each element in the array (its byte-order, how many bytes it
 |  occupies in memory, whether it is an integer, a floating point number,
 |  or something else, etc.)
 |  
 |  Arrays should be constructed using `array`, `zeros` or `empty` (refer
 |  to the See Also section below).  The parameters given here refer to
 |  a low-level method (`ndarray(...)`) for instantiating an array.
 |  
 |  For more information, refer to the `numpy` module and examine the
 |  methods and attributes of an array.
 |  
 |  Parameters
 |  ----------
 |  (for the __new__ method; see Notes below)
 |  
 |  shape : tuple of ints
 |      Shape of created array.
 |  dtype : data-type, optional
 |      Any object that can be interpreted as a numpy data type.
 |  buffer : object exposing buffer interface, optional
 |      Used to fill the array with data.
 |  offset : int, optional
 |      Offset of array data in buffer.
 |  strides : tuple of ints, optional
 |      Strides of data in memory.
 |  order : {'C', 'F'}, optional
 |      Row-major (C-style) or column-major (Fortran-style) order.
 |  
 |  Attributes
 |  ----------
 |  T : ndarray
 |      Transpose of the array.
 |  data : buffer
 |      The array's elements, in memory.
 |  dtype : dtype object
 |      Describes the format of the elements in the array.
 |  flags : dict
 |      Dictionary containing information related to memory use, e.g.,
 |      'C_CONTIGUOUS', 'OWNDATA', 'WRITEABLE', etc.
 |  flat : numpy.flatiter object
 |      Flattened version of the array as an iterator.  The iterator
 |      allows assignments, e.g., ``x.flat = 3`` (See `ndarray.flat` for
 |      assignment examples; TODO).
 |  imag : ndarray
 |      Imaginary part of the array.
 |  real : ndarray
 |      Real part of the array.
 |  size : int
 |      Number of elements in the array.
 |  itemsize : int
 |      The memory use of each array element in bytes.
 |  nbytes : int
 |      The total number of bytes required to store the array data,
 |      i.e., ``itemsize * size``.
 |  ndim : int
 |      The array's number of dimensions.
 |  shape : tuple of ints
 |      Shape of the array.
 |  strides : tuple of ints
 |      The step-size required to move from one element to the next in
 |      memory. For example, a contiguous ``(3, 4)`` array of type
 |      ``int16`` in C-order has strides ``(8, 2)``.  This implies that
 |      to move from element to element in memory requires jumps of 2 bytes.
 |      To move from row-to-row, one needs to jump 8 bytes at a time
 |      (``2 * 4``).
 |  ctypes : ctypes object
 |      Class containing properties of the array needed for interaction
 |      with ctypes.
 |  base : ndarray
 |      If the array is a view into another array, that array is its `base`
 |      (unless that array is also a view).  The `base` array is where the
 |      array data is actually stored.
 |  
 |  See Also
 |  --------
 |  array : Construct an array.
 |  zeros : Create an array, each element of which is zero.
 |  empty : Create an array, but leave its allocated memory unchanged (i.e.,
 |          it contains "garbage").
 |  dtype : Create a data-type.
 |  numpy.typing.NDArray : An ndarray alias :term:`generic <generic type>`
 |                         w.r.t. its `dtype.type <numpy.dtype.type>`.
 |  
 |  Notes
 |  -----
 |  There are two modes of creating an array using ``__new__``:
 |  
 |  1. If `buffer` is None, then only `shape`, `dtype`, and `order`
 |     are used.
 |  2. If `buffer` is an object exposing the buffer interface, then
 |     all keywords are interpreted.
 |  
 |  No ``__init__`` method is needed because the array is fully initialized
 |  after the ``__new__`` method.
 |  
 |  Examples
 |  --------
 |  These examples illustrate the low-level `ndarray` constructor.  Refer
 |  to the `See Also` section above for easier ways of constructing an
 |  ndarray.
 |  
 |  First mode, `buffer` is None:
 |  
 |  >>> np.ndarray(shape=(2,2), dtype=float, order='F')
 |  array([[0.0e+000, 0.0e+000], # random
 |         [     nan, 2.5e-323]])
 |  
 |  Second mode:
 |  
 |  >>> np.ndarray((2,), buffer=np.array([1,2,3]),
 |  ...            offset=np.int_().itemsize,
 |  ...            dtype=int) # offset = 1*itemsize, i.e. skip first element
 |  array([2, 3])
 |  
 |  Methods defined here:
 |  
 |  __abs__(self, /)
 |      abs(self)
 |  
 |  __add__(self, value, /)
 |      Return self+value.
 |  
 |  __and__(self, value, /)
 |      Return self&value.
 |  
 |  __array__(...)
 |      a.__array__([dtype], /)
 |      
 |      Returns either a new reference to self if dtype is not given or a new array
 |      of provided data type if dtype is different from the current dtype of the
 |      array.
 |  
 |  __array_finalize__(...)
 |      a.__array_finalize__(obj, /)
 |      
 |      Present so subclasses can call super. Does nothing.
 |  
 |  __array_function__(...)
 |  
 |  __array_prepare__(...)
 |      a.__array_prepare__(array[, context], /)
 |      
 |      Returns a view of `array` with the same type as self.
 |  
 |  __array_ufunc__(...)
 |  
 |  __array_wrap__(...)
 |      a.__array_wrap__(array[, context], /)
 |      
 |      Returns a view of `array` with the same type as self.
 |  
 |  __bool__(self, /)
 |      True if self else False
 |  
 |  __complex__(...)
 |  
 |  __contains__(self, key, /)
 |      Return key in self.
 |  
 |  __copy__(...)
 |      a.__copy__()
 |      
 |      Used if :func:`copy.copy` is called on an array. Returns a copy of the array.
 |      
 |      Equivalent to ``a.copy(order='K')``.
 |  
 |  __deepcopy__(...)
 |      a.__deepcopy__(memo, /)
 |      
 |      Used if :func:`copy.deepcopy` is called on an array.
 |  
 |  __delitem__(self, key, /)
 |      Delete self[key].
 |  
 |  __divmod__(self, value, /)
 |      Return divmod(self, value).
 |  
 |  __dlpack__(...)
 |      a.__dlpack__(*, stream=None)
 |      
 |      DLPack Protocol: Part of the Array API.
 |  
 |  __dlpack_device__(...)
 |      a.__dlpack_device__()
 |      
 |      DLPack Protocol: Part of the Array API.
 |  
 |  __eq__(self, value, /)
 |      Return self==value.
 |  
 |  __float__(self, /)
 |      float(self)
 |  
 |  __floordiv__(self, value, /)
 |      Return self//value.
 |  
 |  __format__(...)
 |      Default object formatter.
 |  
 |  __ge__(self, value, /)
 |      Return self>=value.
 |  
 |  __getitem__(self, key, /)
 |      Return self[key].
 |  
 |  __gt__(self, value, /)
 |      Return self>value.
 |  
 |  __iadd__(self, value, /)
 |      Return self+=value.
 |  
 |  __iand__(self, value, /)
 |      Return self&=value.
 |  
 |  __ifloordiv__(self, value, /)
 |      Return self//=value.
 |  
 |  __ilshift__(self, value, /)
 |      Return self<<=value.
 |  
 |  __imatmul__(self, value, /)
 |      Return self@=value.
 |  
 |  __imod__(self, value, /)
 |      Return self%=value.
 |  
 |  __imul__(self, value, /)
 |      Return self*=value.
 |  
 |  __index__(self, /)
 |      Return self converted to an integer, if self is suitable for use as an index into a list.
 |  
 |  __int__(self, /)
 |      int(self)
 |  
 |  __invert__(self, /)
 |      ~self
 |  
 |  __ior__(self, value, /)
 |      Return self|=value.
 |  
 |  __ipow__(self, value, /)
 |      Return self**=value.
 |  
 |  __irshift__(self, value, /)
 |      Return self>>=value.
 |  
 |  __isub__(self, value, /)
 |      Return self-=value.
 |  
 |  __iter__(self, /)
 |      Implement iter(self).
 |  
 |  __itruediv__(self, value, /)
 |      Return self/=value.
 |  
 |  __ixor__(self, value, /)
 |      Return self^=value.
 |  
 |  __le__(self, value, /)
 |      Return self<=value.
 |  
 |  __len__(self, /)
 |      Return len(self).
 |  
 |  __lshift__(self, value, /)
 |      Return self<<value.
 |  
 |  __lt__(self, value, /)
 |      Return self<value.
 |  
 |  __matmul__(self, value, /)
 |      Return self@value.
 |  
 |  __mod__(self, value, /)
 |      Return self%value.
 |  
 |  __mul__(self, value, /)
 |      Return self*value.
 |  
 |  __ne__(self, value, /)
 |      Return self!=value.
 |  
 |  __neg__(self, /)
 |      -self
 |  
 |  __or__(self, value, /)
 |      Return self|value.
 |  
 |  __pos__(self, /)
 |      +self
 |  
 |  __pow__(self, value, mod=None, /)
 |      Return pow(self, value, mod).
 |  
 |  __radd__(self, value, /)
 |      Return value+self.
 |  
 |  __rand__(self, value, /)
 |      Return value&self.
 |  
 |  __rdivmod__(self, value, /)
 |      Return divmod(value, self).
 |  
 |  __reduce__(...)
 |      a.__reduce__()
 |      
 |      For pickling.
 |  
 |  __reduce_ex__(...)
 |      Helper for pickle.
 |  
 |  __repr__(self, /)
 |      Return repr(self).
 |  
 |  __rfloordiv__(self, value, /)
 |      Return value//self.
 |  
 |  __rlshift__(self, value, /)
 |      Return value<<self.
 |  
 |  __rmatmul__(self, value, /)
 |      Return value@self.
 |  
 |  __rmod__(self, value, /)
 |      Return value%self.
 |  
 |  __rmul__(self, value, /)
 |      Return value*self.
 |  
 |  __ror__(self, value, /)
 |      Return value|self.
 |  
 |  __rpow__(self, value, mod=None, /)
 |      Return pow(value, self, mod).
 |  
 |  __rrshift__(self, value, /)
 |      Return value>>self.
 |  
 |  __rshift__(self, value, /)
 |      Return self>>value.
 |  
 |  __rsub__(self, value, /)
 |      Return value-self.
 |  
 |  __rtruediv__(self, value, /)
 |      Return value/self.
 |  
 |  __rxor__(self, value, /)
 |      Return value^self.
 |  
 |  __setitem__(self, key, value, /)
 |      Set self[key] to value.
 |  
 |  __setstate__(...)
 |      a.__setstate__(state, /)
 |      
 |      For unpickling.
 |      
 |      The `state` argument must be a sequence that contains the following
 |      elements:
 |      
 |      Parameters
 |      ----------
 |      version : int
 |          optional pickle version. If omitted defaults to 0.
 |      shape : tuple
 |      dtype : data-type
 |      isFortran : bool
 |      rawdata : string or list
 |          a binary string with the data (or a list if 'a' is an object array)
 |  
 |  __sizeof__(...)
 |      Size of object in memory, in bytes.
 |  
 |  __str__(self, /)
 |      Return str(self).
 |  
 |  __sub__(self, value, /)
 |      Return self-value.
 |  
 |  __truediv__(self, value, /)
 |      Return self/value.
 |  
 |  __xor__(self, value, /)
 |      Return self^value.
 |  
 |  all(...)
 |      a.all(axis=None, out=None, keepdims=False, *, where=True)
 |      
 |      Returns True if all elements evaluate to True.
 |      
 |      Refer to `numpy.all` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.all : equivalent function
 |  
 |  any(...)
 |      a.any(axis=None, out=None, keepdims=False, *, where=True)
 |      
 |      Returns True if any of the elements of `a` evaluate to True.
 |      
 |      Refer to `numpy.any` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.any : equivalent function
 |  
 |  argmax(...)
 |      a.argmax(axis=None, out=None, *, keepdims=False)
 |      
 |      Return indices of the maximum values along the given axis.
 |      
 |      Refer to `numpy.argmax` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.argmax : equivalent function
 |  
 |  argmin(...)
 |      a.argmin(axis=None, out=None, *, keepdims=False)
 |      
 |      Return indices of the minimum values along the given axis.
 |      
 |      Refer to `numpy.argmin` for detailed documentation.
 |      
 |      See Also
 |      --------
 |      numpy.argmin : equivalent function
 |  
 |  argpartition(...)
 |      a.argpartition(kth, axis=-1, kind='introselect', order=None)
 |      
 |      Returns the indices that would partition this array.
 |      
 |      Refer to `numpy.argpartition` for full documentation.
 |      
 |      .. versionadded:: 1.8.0
 |      
 |      See Also
 |      --------
 |      numpy.argpartition : equivalent function
 |  
 |  argsort(...)
 |      a.argsort(axis=-1, kind=None, order=None)
 |      
 |      Returns the indices that would sort this array.
 |      
 |      Refer to `numpy.argsort` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.argsort : equivalent function
 |  
 |  astype(...)
 |      a.astype(dtype, order='K', casting='unsafe', subok=True, copy=True)
 |      
 |      Copy of the array, cast to a specified type.
 |      
 |      Parameters
 |      ----------
 |      dtype : str or dtype
 |          Typecode or data-type to which the array is cast.
 |      order : {'C', 'F', 'A', 'K'}, optional
 |          Controls the memory layout order of the result.
 |          'C' means C order, 'F' means Fortran order, 'A'
 |          means 'F' order if all the arrays are Fortran contiguous,
 |          'C' order otherwise, and 'K' means as close to the
 |          order the array elements appear in memory as possible.
 |          Default is 'K'.
 |      casting : {'no', 'equiv', 'safe', 'same_kind', 'unsafe'}, optional
 |          Controls what kind of data casting may occur. Defaults to 'unsafe'
 |          for backwards compatibility.
 |      
 |            * 'no' means the data types should not be cast at all.
 |            * 'equiv' means only byte-order changes are allowed.
 |            * 'safe' means only casts which can preserve values are allowed.
 |            * 'same_kind' means only safe casts or casts within a kind,
 |              like float64 to float32, are allowed.
 |            * 'unsafe' means any data conversions may be done.
 |      subok : bool, optional
 |          If True, then sub-classes will be passed-through (default), otherwise
 |          the returned array will be forced to be a base-class array.
 |      copy : bool, optional
 |          By default, astype always returns a newly allocated array. If this
 |          is set to false, and the `dtype`, `order`, and `subok`
 |          requirements are satisfied, the input array is returned instead
 |          of a copy.
 |      
 |      Returns
 |      -------
 |      arr_t : ndarray
 |          Unless `copy` is False and the other conditions for returning the input
 |          array are satisfied (see description for `copy` input parameter), `arr_t`
 |          is a new array of the same shape as the input array, with dtype, order
 |          given by `dtype`, `order`.
 |      
 |      Notes
 |      -----
 |      .. versionchanged:: 1.17.0
 |         Casting between a simple data type and a structured one is possible only
 |         for "unsafe" casting.  Casting to multiple fields is allowed, but
 |         casting from multiple fields is not.
 |      
 |      .. versionchanged:: 1.9.0
 |         Casting from numeric to string types in 'safe' casting mode requires
 |         that the string dtype length is long enough to store the max
 |         integer/float value converted.
 |      
 |      Raises
 |      ------
 |      ComplexWarning
 |          When casting from complex to float or int. To avoid this,
 |          one should use ``a.real.astype(t)``.
 |      
 |      Examples
 |      --------
 |      >>> x = np.array([1, 2, 2.5])
 |      >>> x
 |      array([1. ,  2. ,  2.5])
 |      
 |      >>> x.astype(int)
 |      array([1, 2, 2])
 |  
 |  byteswap(...)
 |      a.byteswap(inplace=False)
 |      
 |      Swap the bytes of the array elements
 |      
 |      Toggle between low-endian and big-endian data representation by
 |      returning a byteswapped array, optionally swapped in-place.
 |      Arrays of byte-strings are not swapped. The real and imaginary
 |      parts of a complex number are swapped individually.
 |      
 |      Parameters
 |      ----------
 |      inplace : bool, optional
 |          If ``True``, swap bytes in-place, default is ``False``.
 |      
 |      Returns
 |      -------
 |      out : ndarray
 |          The byteswapped array. If `inplace` is ``True``, this is
 |          a view to self.
 |      
 |      Examples
 |      --------
 |      >>> A = np.array([1, 256, 8755], dtype=np.int16)
 |      >>> list(map(hex, A))
 |      ['0x1', '0x100', '0x2233']
 |      >>> A.byteswap(inplace=True)
 |      array([  256,     1, 13090], dtype=int16)
 |      >>> list(map(hex, A))
 |      ['0x100', '0x1', '0x3322']
 |      
 |      Arrays of byte-strings are not swapped
 |      
 |      >>> A = np.array([b'ceg', b'fac'])
 |      >>> A.byteswap()
 |      array([b'ceg', b'fac'], dtype='|S3')
 |      
 |      ``A.newbyteorder().byteswap()`` produces an array with the same values
 |        but different representation in memory
 |      
 |      >>> A = np.array([1, 2, 3])
 |      >>> A.view(np.uint8)
 |      array([1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0,
 |             0, 0], dtype=uint8)
 |      >>> A.newbyteorder().byteswap(inplace=True)
 |      array([1, 2, 3])
 |      >>> A.view(np.uint8)
 |      array([0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0,
 |             0, 3], dtype=uint8)
 |  
 |  choose(...)
 |      a.choose(choices, out=None, mode='raise')
 |      
 |      Use an index array to construct a new array from a set of choices.
 |      
 |      Refer to `numpy.choose` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.choose : equivalent function
 |  
 |  clip(...)
 |      a.clip(min=None, max=None, out=None, **kwargs)
 |      
 |      Return an array whose values are limited to ``[min, max]``.
 |      One of max or min must be given.
 |      
 |      Refer to `numpy.clip` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.clip : equivalent function
 |  
 |  compress(...)
 |      a.compress(condition, axis=None, out=None)
 |      
 |      Return selected slices of this array along given axis.
 |      
 |      Refer to `numpy.compress` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.compress : equivalent function
 |  
 |  conj(...)
 |      a.conj()
 |      
 |      Complex-conjugate all elements.
 |      
 |      Refer to `numpy.conjugate` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.conjugate : equivalent function
 |  
 |  conjugate(...)
 |      a.conjugate()
 |      
 |      Return the complex conjugate, element-wise.
 |      
 |      Refer to `numpy.conjugate` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.conjugate : equivalent function
 |  
 |  copy(...)
 |      a.copy(order='C')
 |      
 |      Return a copy of the array.
 |      
 |      Parameters
 |      ----------
 |      order : {'C', 'F', 'A', 'K'}, optional
 |          Controls the memory layout of the copy. 'C' means C-order,
 |          'F' means F-order, 'A' means 'F' if `a` is Fortran contiguous,
 |          'C' otherwise. 'K' means match the layout of `a` as closely
 |          as possible. (Note that this function and :func:`numpy.copy` are very
 |          similar but have different default values for their order=
 |          arguments, and this function always passes sub-classes through.)
 |      
 |      See also
 |      --------
 |      numpy.copy : Similar function with different default behavior
 |      numpy.copyto
 |      
 |      Notes
 |      -----
 |      This function is the preferred method for creating an array copy.  The
 |      function :func:`numpy.copy` is similar, but it defaults to using order 'K',
 |      and will not pass sub-classes through by default.
 |      
 |      Examples
 |      --------
 |      >>> x = np.array([[1,2,3],[4,5,6]], order='F')
 |      
 |      >>> y = x.copy()
 |      
 |      >>> x.fill(0)
 |      
 |      >>> x
 |      array([[0, 0, 0],
 |             [0, 0, 0]])
 |      
 |      >>> y
 |      array([[1, 2, 3],
 |             [4, 5, 6]])
 |      
 |      >>> y.flags['C_CONTIGUOUS']
 |      True
 |  
 |  cumprod(...)
 |      a.cumprod(axis=None, dtype=None, out=None)
 |      
 |      Return the cumulative product of the elements along the given axis.
 |      
 |      Refer to `numpy.cumprod` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.cumprod : equivalent function
 |  
 |  cumsum(...)
 |      a.cumsum(axis=None, dtype=None, out=None)
 |      
 |      Return the cumulative sum of the elements along the given axis.
 |      
 |      Refer to `numpy.cumsum` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.cumsum : equivalent function
 |  
 |  diagonal(...)
 |      a.diagonal(offset=0, axis1=0, axis2=1)
 |      
 |      Return specified diagonals. In NumPy 1.9 the returned array is a
 |      read-only view instead of a copy as in previous NumPy versions.  In
 |      a future version the read-only restriction will be removed.
 |      
 |      Refer to :func:`numpy.diagonal` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.diagonal : equivalent function
 |  
 |  dot(...)
 |  
 |  dump(...)
 |      a.dump(file)
 |      
 |      Dump a pickle of the array to the specified file.
 |      The array can be read back with pickle.load or numpy.load.
 |      
 |      Parameters
 |      ----------
 |      file : str or Path
 |          A string naming the dump file.
 |      
 |          .. versionchanged:: 1.17.0
 |              `pathlib.Path` objects are now accepted.
 |  
 |  dumps(...)
 |      a.dumps()
 |      
 |      Returns the pickle of the array as a string.
 |      pickle.loads will convert the string back to an array.
 |      
 |      Parameters
 |      ----------
 |      None
 |  
 |  fill(...)
 |      a.fill(value)
 |      
 |      Fill the array with a scalar value.
 |      
 |      Parameters
 |      ----------
 |      value : scalar
 |          All elements of `a` will be assigned this value.
 |      
 |      Examples
 |      --------
 |      >>> a = np.array([1, 2])
 |      >>> a.fill(0)
 |      >>> a
 |      array([0, 0])
 |      >>> a = np.empty(2)
 |      >>> a.fill(1)
 |      >>> a
 |      array([1.,  1.])
 |      
 |      Fill expects a scalar value and always behaves the same as assigning
 |      to a single array element.  The following is a rare example where this
 |      distinction is important:
 |      
 |      >>> a = np.array([None, None], dtype=object)
 |      >>> a[0] = np.array(3)
 |      >>> a
 |      array([array(3), None], dtype=object)
 |      >>> a.fill(np.array(3))
 |      >>> a
 |      array([array(3), array(3)], dtype=object)
 |      
 |      Where other forms of assignments will unpack the array being assigned:
 |      
 |      >>> a[...] = np.array(3)
 |      >>> a
 |      array([3, 3], dtype=object)
 |  
 |  flatten(...)
 |      a.flatten(order='C')
 |      
 |      Return a copy of the array collapsed into one dimension.
 |      
 |      Parameters
 |      ----------
 |      order : {'C', 'F', 'A', 'K'}, optional
 |          'C' means to flatten in row-major (C-style) order.
 |          'F' means to flatten in column-major (Fortran-
 |          style) order. 'A' means to flatten in column-major
 |          order if `a` is Fortran *contiguous* in memory,
 |          row-major order otherwise. 'K' means to flatten
 |          `a` in the order the elements occur in memory.
 |          The default is 'C'.
 |      
 |      Returns
 |      -------
 |      y : ndarray
 |          A copy of the input array, flattened to one dimension.
 |      
 |      See Also
 |      --------
 |      ravel : Return a flattened array.
 |      flat : A 1-D flat iterator over the array.
 |      
 |      Examples
 |      --------
 |      >>> a = np.array([[1,2], [3,4]])
 |      >>> a.flatten()
 |      array([1, 2, 3, 4])
 |      >>> a.flatten('F')
 |      array([1, 3, 2, 4])
 |  
 |  getfield(...)
 |      a.getfield(dtype, offset=0)
 |      
 |      Returns a field of the given array as a certain type.
 |      
 |      A field is a view of the array data with a given data-type. The values in
 |      the view are determined by the given type and the offset into the current
 |      array in bytes. The offset needs to be such that the view dtype fits in the
 |      array dtype; for example an array of dtype complex128 has 16-byte elements.
 |      If taking a view with a 32-bit integer (4 bytes), the offset needs to be
 |      between 0 and 12 bytes.
 |      
 |      Parameters
 |      ----------
 |      dtype : str or dtype
 |          The data type of the view. The dtype size of the view can not be larger
 |          than that of the array itself.
 |      offset : int
 |          Number of bytes to skip before beginning the element view.
 |      
 |      Examples
 |      --------
 |      >>> x = np.diag([1.+1.j]*2)
 |      >>> x[1, 1] = 2 + 4.j
 |      >>> x
 |      array([[1.+1.j,  0.+0.j],
 |             [0.+0.j,  2.+4.j]])
 |      >>> x.getfield(np.float64)
 |      array([[1.,  0.],
 |             [0.,  2.]])
 |      
 |      By choosing an offset of 8 bytes we can select the complex part of the
 |      array for our view:
 |      
 |      >>> x.getfield(np.float64, offset=8)
 |      array([[1.,  0.],
 |             [0.,  4.]])
 |  
 |  item(...)
 |      a.item(*args)
 |      
 |      Copy an element of an array to a standard Python scalar and return it.
 |      
 |      Parameters
 |      ----------
 |      \*args : Arguments (variable number and type)
 |      
 |          * none: in this case, the method only works for arrays
 |            with one element (`a.size == 1`), which element is
 |            copied into a standard Python scalar object and returned.
 |      
 |          * int_type: this argument is interpreted as a flat index into
 |            the array, specifying which element to copy and return.
 |      
 |          * tuple of int_types: functions as does a single int_type argument,
 |            except that the argument is interpreted as an nd-index into the
 |            array.
 |      
 |      Returns
 |      -------
 |      z : Standard Python scalar object
 |          A copy of the specified element of the array as a suitable
 |          Python scalar
 |      
 |      Notes
 |      -----
 |      When the data type of `a` is longdouble or clongdouble, item() returns
 |      a scalar array object because there is no available Python scalar that
 |      would not lose information. Void arrays return a buffer object for item(),
 |      unless fields are defined, in which case a tuple is returned.
 |      
 |      `item` is very similar to a[args], except, instead of an array scalar,
 |      a standard Python scalar is returned. This can be useful for speeding up
 |      access to elements of the array and doing arithmetic on elements of the
 |      array using Python's optimized math.
 |      
 |      Examples
 |      --------
 |      >>> np.random.seed(123)
 |      >>> x = np.random.randint(9, size=(3, 3))
 |      >>> x
 |      array([[2, 2, 6],
 |             [1, 3, 6],
 |             [1, 0, 1]])
 |      >>> x.item(3)
 |      1
 |      >>> x.item(7)
 |      0
 |      >>> x.item((0, 1))
 |      2
 |      >>> x.item((2, 2))
 |      1
 |  
 |  itemset(...)
 |      a.itemset(*args)
 |      
 |      Insert scalar into an array (scalar is cast to array's dtype, if possible)
 |      
 |      There must be at least 1 argument, and define the last argument
 |      as *item*.  Then, ``a.itemset(*args)`` is equivalent to but faster
 |      than ``a[args] = item``.  The item should be a scalar value and `args`
 |      must select a single item in the array `a`.
 |      
 |      Parameters
 |      ----------
 |      \*args : Arguments
 |          If one argument: a scalar, only used in case `a` is of size 1.
 |          If two arguments: the last argument is the value to be set
 |          and must be a scalar, the first argument specifies a single array
 |          element location. It is either an int or a tuple.
 |      
 |      Notes
 |      -----
 |      Compared to indexing syntax, `itemset` provides some speed increase
 |      for placing a scalar into a particular location in an `ndarray`,
 |      if you must do this.  However, generally this is discouraged:
 |      among other problems, it complicates the appearance of the code.
 |      Also, when using `itemset` (and `item`) inside a loop, be sure
 |      to assign the methods to a local variable to avoid the attribute
 |      look-up at each loop iteration.
 |      
 |      Examples
 |      --------
 |      >>> np.random.seed(123)
 |      >>> x = np.random.randint(9, size=(3, 3))
 |      >>> x
 |      array([[2, 2, 6],
 |             [1, 3, 6],
 |             [1, 0, 1]])
 |      >>> x.itemset(4, 0)
 |      >>> x.itemset((2, 2), 9)
 |      >>> x
 |      array([[2, 2, 6],
 |             [1, 0, 6],
 |             [1, 0, 9]])
 |  
 |  max(...)
 |      a.max(axis=None, out=None, keepdims=False, initial=<no value>, where=True)
 |      
 |      Return the maximum along a given axis.
 |      
 |      Refer to `numpy.amax` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.amax : equivalent function
 |  
 |  mean(...)
 |      a.mean(axis=None, dtype=None, out=None, keepdims=False, *, where=True)
 |      
 |      Returns the average of the array elements along given axis.
 |      
 |      Refer to `numpy.mean` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.mean : equivalent function
 |  
 |  min(...)
 |      a.min(axis=None, out=None, keepdims=False, initial=<no value>, where=True)
 |      
 |      Return the minimum along a given axis.
 |      
 |      Refer to `numpy.amin` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.amin : equivalent function
 |  
 |  newbyteorder(...)
 |      arr.newbyteorder(new_order='S', /)
 |      
 |      Return the array with the same data viewed with a different byte order.
 |      
 |      Equivalent to::
 |      
 |          arr.view(arr.dtype.newbytorder(new_order))
 |      
 |      Changes are also made in all fields and sub-arrays of the array data
 |      type.
 |      
 |      
 |      
 |      Parameters
 |      ----------
 |      new_order : string, optional
 |          Byte order to force; a value from the byte order specifications
 |          below. `new_order` codes can be any of:
 |      
 |          * 'S' - swap dtype from current to opposite endian
 |          * {'<', 'little'} - little endian
 |          * {'>', 'big'} - big endian
 |          * {'=', 'native'} - native order, equivalent to `sys.byteorder`
 |          * {'|', 'I'} - ignore (no change to byte order)
 |      
 |          The default value ('S') results in swapping the current
 |          byte order.
 |      
 |      
 |      Returns
 |      -------
 |      new_arr : array
 |          New array object with the dtype reflecting given change to the
 |          byte order.
 |  
 |  nonzero(...)
 |      a.nonzero()
 |      
 |      Return the indices of the elements that are non-zero.
 |      
 |      Refer to `numpy.nonzero` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.nonzero : equivalent function
 |  
 |  partition(...)
 |      a.partition(kth, axis=-1, kind='introselect', order=None)
 |      
 |      Rearranges the elements in the array in such a way that the value of the
 |      element in kth position is in the position it would be in a sorted array.
 |      All elements smaller than the kth element are moved before this element and
 |      all equal or greater are moved behind it. The ordering of the elements in
 |      the two partitions is undefined.
 |      
 |      .. versionadded:: 1.8.0
 |      
 |      Parameters
 |      ----------
 |      kth : int or sequence of ints
 |          Element index to partition by. The kth element value will be in its
 |          final sorted position and all smaller elements will be moved before it
 |          and all equal or greater elements behind it.
 |          The order of all elements in the partitions is undefined.
 |          If provided with a sequence of kth it will partition all elements
 |          indexed by kth of them into their sorted position at once.
 |      
 |          .. deprecated:: 1.22.0
 |              Passing booleans as index is deprecated.
 |      axis : int, optional
 |          Axis along which to sort. Default is -1, which means sort along the
 |          last axis.
 |      kind : {'introselect'}, optional
 |          Selection algorithm. Default is 'introselect'.
 |      order : str or list of str, optional
 |          When `a` is an array with fields defined, this argument specifies
 |          which fields to compare first, second, etc. A single field can
 |          be specified as a string, and not all fields need to be specified,
 |          but unspecified fields will still be used, in the order in which
 |          they come up in the dtype, to break ties.
 |      
 |      See Also
 |      --------
 |      numpy.partition : Return a partitioned copy of an array.
 |      argpartition : Indirect partition.
 |      sort : Full sort.
 |      
 |      Notes
 |      -----
 |      See ``np.partition`` for notes on the different algorithms.
 |      
 |      Examples
 |      --------
 |      >>> a = np.array([3, 4, 2, 1])
 |      >>> a.partition(3)
 |      >>> a
 |      array([2, 1, 3, 4])
 |      
 |      >>> a.partition((1, 3))
 |      >>> a
 |      array([1, 2, 3, 4])
 |  
 |  prod(...)
 |      a.prod(axis=None, dtype=None, out=None, keepdims=False, initial=1, where=True)
 |      
 |      Return the product of the array elements over the given axis
 |      
 |      Refer to `numpy.prod` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.prod : equivalent function
 |  
 |  ptp(...)
 |      a.ptp(axis=None, out=None, keepdims=False)
 |      
 |      Peak to peak (maximum - minimum) value along a given axis.
 |      
 |      Refer to `numpy.ptp` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.ptp : equivalent function
 |  
 |  put(...)
 |      a.put(indices, values, mode='raise')
 |      
 |      Set ``a.flat[n] = values[n]`` for all `n` in indices.
 |      
 |      Refer to `numpy.put` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.put : equivalent function
 |  
 |  ravel(...)
 |      a.ravel([order])
 |      
 |      Return a flattened array.
 |      
 |      Refer to `numpy.ravel` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.ravel : equivalent function
 |      
 |      ndarray.flat : a flat iterator on the array.
 |  
 |  repeat(...)
 |      a.repeat(repeats, axis=None)
 |      
 |      Repeat elements of an array.
 |      
 |      Refer to `numpy.repeat` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.repeat : equivalent function
 |  
 |  reshape(...)
 |      a.reshape(shape, order='C')
 |      
 |      Returns an array containing the same data with a new shape.
 |      
 |      Refer to `numpy.reshape` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.reshape : equivalent function
 |      
 |      Notes
 |      -----
 |      Unlike the free function `numpy.reshape`, this method on `ndarray` allows
 |      the elements of the shape parameter to be passed in as separate arguments.
 |      For example, ``a.reshape(10, 11)`` is equivalent to
 |      ``a.reshape((10, 11))``.
 |  
 |  resize(...)
 |      a.resize(new_shape, refcheck=True)
 |      
 |      Change shape and size of array in-place.
 |      
 |      Parameters
 |      ----------
 |      new_shape : tuple of ints, or `n` ints
 |          Shape of resized array.
 |      refcheck : bool, optional
 |          If False, reference count will not be checked. Default is True.
 |      
 |      Returns
 |      -------
 |      None
 |      
 |      Raises
 |      ------
 |      ValueError
 |          If `a` does not own its own data or references or views to it exist,
 |          and the data memory must be changed.
 |          PyPy only: will always raise if the data memory must be changed, since
 |          there is no reliable way to determine if references or views to it
 |          exist.
 |      
 |      SystemError
 |          If the `order` keyword argument is specified. This behaviour is a
 |          bug in NumPy.
 |      
 |      See Also
 |      --------
 |      resize : Return a new array with the specified shape.
 |      
 |      Notes
 |      -----
 |      This reallocates space for the data area if necessary.
 |      
 |      Only contiguous arrays (data elements consecutive in memory) can be
 |      resized.
 |      
 |      The purpose of the reference count check is to make sure you
 |      do not use this array as a buffer for another Python object and then
 |      reallocate the memory. However, reference counts can increase in
 |      other ways so if you are sure that you have not shared the memory
 |      for this array with another Python object, then you may safely set
 |      `refcheck` to False.
 |      
 |      Examples
 |      --------
 |      Shrinking an array: array is flattened (in the order that the data are
 |      stored in memory), resized, and reshaped:
 |      
 |      >>> a = np.array([[0, 1], [2, 3]], order='C')
 |      >>> a.resize((2, 1))
 |      >>> a
 |      array([[0],
 |             [1]])
 |      
 |      >>> a = np.array([[0, 1], [2, 3]], order='F')
 |      >>> a.resize((2, 1))
 |      >>> a
 |      array([[0],
 |             [2]])
 |      
 |      Enlarging an array: as above, but missing entries are filled with zeros:
 |      
 |      >>> b = np.array([[0, 1], [2, 3]])
 |      >>> b.resize(2, 3) # new_shape parameter doesn't have to be a tuple
 |      >>> b
 |      array([[0, 1, 2],
 |             [3, 0, 0]])
 |      
 |      Referencing an array prevents resizing...
 |      
 |      >>> c = a
 |      >>> a.resize((1, 1))
 |      Traceback (most recent call last):
 |      ...
 |      ValueError: cannot resize an array that references or is referenced ...
 |      
 |      Unless `refcheck` is False:
 |      
 |      >>> a.resize((1, 1), refcheck=False)
 |      >>> a
 |      array([[0]])
 |      >>> c
 |      array([[0]])
 |  
 |  round(...)
 |      a.round(decimals=0, out=None)
 |      
 |      Return `a` with each element rounded to the given number of decimals.
 |      
 |      Refer to `numpy.around` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.around : equivalent function
 |  
 |  searchsorted(...)
 |      a.searchsorted(v, side='left', sorter=None)
 |      
 |      Find indices where elements of v should be inserted in a to maintain order.
 |      
 |      For full documentation, see `numpy.searchsorted`
 |      
 |      See Also
 |      --------
 |      numpy.searchsorted : equivalent function
 |  
 |  setfield(...)
 |      a.setfield(val, dtype, offset=0)
 |      
 |      Put a value into a specified place in a field defined by a data-type.
 |      
 |      Place `val` into `a`'s field defined by `dtype` and beginning `offset`
 |      bytes into the field.
 |      
 |      Parameters
 |      ----------
 |      val : object
 |          Value to be placed in field.
 |      dtype : dtype object
 |          Data-type of the field in which to place `val`.
 |      offset : int, optional
 |          The number of bytes into the field at which to place `val`.
 |      
 |      Returns
 |      -------
 |      None
 |      
 |      See Also
 |      --------
 |      getfield
 |      
 |      Examples
 |      --------
 |      >>> x = np.eye(3)
 |      >>> x.getfield(np.float64)
 |      array([[1.,  0.,  0.],
 |             [0.,  1.,  0.],
 |             [0.,  0.,  1.]])
 |      >>> x.setfield(3, np.int32)
 |      >>> x.getfield(np.int32)
 |      array([[3, 3, 3],
 |             [3, 3, 3],
 |             [3, 3, 3]], dtype=int32)
 |      >>> x
 |      array([[1.0e+000, 1.5e-323, 1.5e-323],
 |             [1.5e-323, 1.0e+000, 1.5e-323],
 |             [1.5e-323, 1.5e-323, 1.0e+000]])
 |      >>> x.setfield(np.eye(3), np.int32)
 |      >>> x
 |      array([[1.,  0.,  0.],
 |             [0.,  1.,  0.],
 |             [0.,  0.,  1.]])
 |  
 |  setflags(...)
 |      a.setflags(write=None, align=None, uic=None)
 |      
 |      Set array flags WRITEABLE, ALIGNED, WRITEBACKIFCOPY,
 |      respectively.
 |      
 |      These Boolean-valued flags affect how numpy interprets the memory
 |      area used by `a` (see Notes below). The ALIGNED flag can only
 |      be set to True if the data is actually aligned according to the type.
 |      The WRITEBACKIFCOPY and flag can never be set
 |      to True. The flag WRITEABLE can only be set to True if the array owns its
 |      own memory, or the ultimate owner of the memory exposes a writeable buffer
 |      interface, or is a string. (The exception for string is made so that
 |      unpickling can be done without copying memory.)
 |      
 |      Parameters
 |      ----------
 |      write : bool, optional
 |          Describes whether or not `a` can be written to.
 |      align : bool, optional
 |          Describes whether or not `a` is aligned properly for its type.
 |      uic : bool, optional
 |          Describes whether or not `a` is a copy of another "base" array.
 |      
 |      Notes
 |      -----
 |      Array flags provide information about how the memory area used
 |      for the array is to be interpreted. There are 7 Boolean flags
 |      in use, only four of which can be changed by the user:
 |      WRITEBACKIFCOPY, WRITEABLE, and ALIGNED.
 |      
 |      WRITEABLE (W) the data area can be written to;
 |      
 |      ALIGNED (A) the data and strides are aligned appropriately for the hardware
 |      (as determined by the compiler);
 |      
 |      WRITEBACKIFCOPY (X) this array is a copy of some other array (referenced
 |      by .base). When the C-API function PyArray_ResolveWritebackIfCopy is
 |      called, the base array will be updated with the contents of this array.
 |      
 |      All flags can be accessed using the single (upper case) letter as well
 |      as the full name.
 |      
 |      Examples
 |      --------
 |      >>> y = np.array([[3, 1, 7],
 |      ...               [2, 0, 0],
 |      ...               [8, 5, 9]])
 |      >>> y
 |      array([[3, 1, 7],
 |             [2, 0, 0],
 |             [8, 5, 9]])
 |      >>> y.flags
 |        C_CONTIGUOUS : True
 |        F_CONTIGUOUS : False
 |        OWNDATA : True
 |        WRITEABLE : True
 |        ALIGNED : True
 |        WRITEBACKIFCOPY : False
 |      >>> y.setflags(write=0, align=0)
 |      >>> y.flags
 |        C_CONTIGUOUS : True
 |        F_CONTIGUOUS : False
 |        OWNDATA : True
 |        WRITEABLE : False
 |        ALIGNED : False
 |        WRITEBACKIFCOPY : False
 |      >>> y.setflags(uic=1)
 |      Traceback (most recent call last):
 |        File "<stdin>", line 1, in <module>
 |      ValueError: cannot set WRITEBACKIFCOPY flag to True
 |  
 |  sort(...)
 |      a.sort(axis=-1, kind=None, order=None)
 |      
 |      Sort an array in-place. Refer to `numpy.sort` for full documentation.
 |      
 |      Parameters
 |      ----------
 |      axis : int, optional
 |          Axis along which to sort. Default is -1, which means sort along the
 |          last axis.
 |      kind : {'quicksort', 'mergesort', 'heapsort', 'stable'}, optional
 |          Sorting algorithm. The default is 'quicksort'. Note that both 'stable'
 |          and 'mergesort' use timsort under the covers and, in general, the
 |          actual implementation will vary with datatype. The 'mergesort' option
 |          is retained for backwards compatibility.
 |      
 |          .. versionchanged:: 1.15.0
 |             The 'stable' option was added.
 |      
 |      order : str or list of str, optional
 |          When `a` is an array with fields defined, this argument specifies
 |          which fields to compare first, second, etc.  A single field can
 |          be specified as a string, and not all fields need be specified,
 |          but unspecified fields will still be used, in the order in which
 |          they come up in the dtype, to break ties.
 |      
 |      See Also
 |      --------
 |      numpy.sort : Return a sorted copy of an array.
 |      numpy.argsort : Indirect sort.
 |      numpy.lexsort : Indirect stable sort on multiple keys.
 |      numpy.searchsorted : Find elements in sorted array.
 |      numpy.partition: Partial sort.
 |      
 |      Notes
 |      -----
 |      See `numpy.sort` for notes on the different sorting algorithms.
 |      
 |      Examples
 |      --------
 |      >>> a = np.array([[1,4], [3,1]])
 |      >>> a.sort(axis=1)
 |      >>> a
 |      array([[1, 4],
 |             [1, 3]])
 |      >>> a.sort(axis=0)
 |      >>> a
 |      array([[1, 3],
 |             [1, 4]])
 |      
 |      Use the `order` keyword to specify a field to use when sorting a
 |      structured array:
 |      
 |      >>> a = np.array([('a', 2), ('c', 1)], dtype=[('x', 'S1'), ('y', int)])
 |      >>> a.sort(order='y')
 |      >>> a
 |      array([(b'c', 1), (b'a', 2)],
 |            dtype=[('x', 'S1'), ('y', '<i8')])
 |  
 |  squeeze(...)
 |      a.squeeze(axis=None)
 |      
 |      Remove axes of length one from `a`.
 |      
 |      Refer to `numpy.squeeze` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.squeeze : equivalent function
 |  
 |  std(...)
 |      a.std(axis=None, dtype=None, out=None, ddof=0, keepdims=False, *, where=True)
 |      
 |      Returns the standard deviation of the array elements along given axis.
 |      
 |      Refer to `numpy.std` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.std : equivalent function
 |  
 |  sum(...)
 |      a.sum(axis=None, dtype=None, out=None, keepdims=False, initial=0, where=True)
 |      
 |      Return the sum of the array elements over the given axis.
 |      
 |      Refer to `numpy.sum` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.sum : equivalent function
 |  
 |  swapaxes(...)
 |      a.swapaxes(axis1, axis2)
 |      
 |      Return a view of the array with `axis1` and `axis2` interchanged.
 |      
 |      Refer to `numpy.swapaxes` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.swapaxes : equivalent function
 |  
 |  take(...)
 |      a.take(indices, axis=None, out=None, mode='raise')
 |      
 |      Return an array formed from the elements of `a` at the given indices.
 |      
 |      Refer to `numpy.take` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.take : equivalent function
 |  
 |  tobytes(...)
 |      a.tobytes(order='C')
 |      
 |      Construct Python bytes containing the raw data bytes in the array.
 |      
 |      Constructs Python bytes showing a copy of the raw contents of
 |      data memory. The bytes object is produced in C-order by default.
 |      This behavior is controlled by the ``order`` parameter.
 |      
 |      .. versionadded:: 1.9.0
 |      
 |      Parameters
 |      ----------
 |      order : {'C', 'F', 'A'}, optional
 |          Controls the memory layout of the bytes object. 'C' means C-order,
 |          'F' means F-order, 'A' (short for *Any*) means 'F' if `a` is
 |          Fortran contiguous, 'C' otherwise. Default is 'C'.
 |      
 |      Returns
 |      -------
 |      s : bytes
 |          Python bytes exhibiting a copy of `a`'s raw data.
 |      
 |      See also
 |      --------
 |      frombuffer
 |          Inverse of this operation, construct a 1-dimensional array from Python
 |          bytes.
 |      
 |      Examples
 |      --------
 |      >>> x = np.array([[0, 1], [2, 3]], dtype='<u2')
 |      >>> x.tobytes()
 |      b'\x00\x00\x01\x00\x02\x00\x03\x00'
 |      >>> x.tobytes('C') == x.tobytes()
 |      True
 |      >>> x.tobytes('F')
 |      b'\x00\x00\x02\x00\x01\x00\x03\x00'
 |  
 |  tofile(...)
 |      a.tofile(fid, sep="", format="%s")
 |      
 |      Write array to a file as text or binary (default).
 |      
 |      Data is always written in 'C' order, independent of the order of `a`.
 |      The data produced by this method can be recovered using the function
 |      fromfile().
 |      
 |      Parameters
 |      ----------
 |      fid : file or str or Path
 |          An open file object, or a string containing a filename.
 |      
 |          .. versionchanged:: 1.17.0
 |              `pathlib.Path` objects are now accepted.
 |      
 |      sep : str
 |          Separator between array items for text output.
 |          If "" (empty), a binary file is written, equivalent to
 |          ``file.write(a.tobytes())``.
 |      format : str
 |          Format string for text file output.
 |          Each entry in the array is formatted to text by first converting
 |          it to the closest Python type, and then using "format" % item.
 |      
 |      Notes
 |      -----
 |      This is a convenience function for quick storage of array data.
 |      Information on endianness and precision is lost, so this method is not a
 |      good choice for files intended to archive data or transport data between
 |      machines with different endianness. Some of these problems can be overcome
 |      by outputting the data as text files, at the expense of speed and file
 |      size.
 |      
 |      When fid is a file object, array contents are directly written to the
 |      file, bypassing the file object's ``write`` method. As a result, tofile
 |      cannot be used with files objects supporting compression (e.g., GzipFile)
 |      or file-like objects that do not support ``fileno()`` (e.g., BytesIO).
 |  
 |  tolist(...)
 |      a.tolist()
 |      
 |      Return the array as an ``a.ndim``-levels deep nested list of Python scalars.
 |      
 |      Return a copy of the array data as a (nested) Python list.
 |      Data items are converted to the nearest compatible builtin Python type, via
 |      the `~numpy.ndarray.item` function.
 |      
 |      If ``a.ndim`` is 0, then since the depth of the nested list is 0, it will
 |      not be a list at all, but a simple Python scalar.
 |      
 |      Parameters
 |      ----------
 |      none
 |      
 |      Returns
 |      -------
 |      y : object, or list of object, or list of list of object, or ...
 |          The possibly nested list of array elements.
 |      
 |      Notes
 |      -----
 |      The array may be recreated via ``a = np.array(a.tolist())``, although this
 |      may sometimes lose precision.
 |      
 |      Examples
 |      --------
 |      For a 1D array, ``a.tolist()`` is almost the same as ``list(a)``,
 |      except that ``tolist`` changes numpy scalars to Python scalars:
 |      
 |      >>> a = np.uint32([1, 2])
 |      >>> a_list = list(a)
 |      >>> a_list
 |      [1, 2]
 |      >>> type(a_list[0])
 |      <class 'numpy.uint32'>
 |      >>> a_tolist = a.tolist()
 |      >>> a_tolist
 |      [1, 2]
 |      >>> type(a_tolist[0])
 |      <class 'int'>
 |      
 |      Additionally, for a 2D array, ``tolist`` applies recursively:
 |      
 |      >>> a = np.array([[1, 2], [3, 4]])
 |      >>> list(a)
 |      [array([1, 2]), array([3, 4])]
 |      >>> a.tolist()
 |      [[1, 2], [3, 4]]
 |      
 |      The base case for this recursion is a 0D array:
 |      
 |      >>> a = np.array(1)
 |      >>> list(a)
 |      Traceback (most recent call last):
 |        ...
 |      TypeError: iteration over a 0-d array
 |      >>> a.tolist()
 |      1
 |  
 |  tostring(...)
 |      a.tostring(order='C')
 |      
 |      A compatibility alias for `tobytes`, with exactly the same behavior.
 |      
 |      Despite its name, it returns `bytes` not `str`\ s.
 |      
 |      .. deprecated:: 1.19.0
 |  
 |  trace(...)
 |      a.trace(offset=0, axis1=0, axis2=1, dtype=None, out=None)
 |      
 |      Return the sum along diagonals of the array.
 |      
 |      Refer to `numpy.trace` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.trace : equivalent function
 |  
 |  transpose(...)
 |      a.transpose(*axes)
 |      
 |      Returns a view of the array with axes transposed.
 |      
 |      Refer to `numpy.transpose` for full documentation.
 |      
 |      Parameters
 |      ----------
 |      axes : None, tuple of ints, or `n` ints
 |      
 |       * None or no argument: reverses the order of the axes.
 |      
 |       * tuple of ints: `i` in the `j`-th place in the tuple means that the
 |         array's `i`-th axis becomes the transposed array's `j`-th axis.
 |      
 |       * `n` ints: same as an n-tuple of the same ints (this form is
 |         intended simply as a "convenience" alternative to the tuple form).
 |      
 |      Returns
 |      -------
 |      p : ndarray
 |          View of the array with its axes suitably permuted.
 |      
 |      See Also
 |      --------
 |      transpose : Equivalent function.
 |      ndarray.T : Array property returning the array transposed.
 |      ndarray.reshape : Give a new shape to an array without changing its data.
 |      
 |      Examples
 |      --------
 |      >>> a = np.array([[1, 2], [3, 4]])
 |      >>> a
 |      array([[1, 2],
 |             [3, 4]])
 |      >>> a.transpose()
 |      array([[1, 3],
 |             [2, 4]])
 |      >>> a.transpose((1, 0))
 |      array([[1, 3],
 |             [2, 4]])
 |      >>> a.transpose(1, 0)
 |      array([[1, 3],
 |             [2, 4]])
 |      
 |      >>> a = np.array([1, 2, 3, 4])
 |      >>> a
 |      array([1, 2, 3, 4])
 |      >>> a.transpose()
 |      array([1, 2, 3, 4])
 |  
 |  var(...)
 |      a.var(axis=None, dtype=None, out=None, ddof=0, keepdims=False, *, where=True)
 |      
 |      Returns the variance of the array elements, along given axis.
 |      
 |      Refer to `numpy.var` for full documentation.
 |      
 |      See Also
 |      --------
 |      numpy.var : equivalent function
 |  
 |  view(...)
 |      a.view([dtype][, type])
 |      
 |      New view of array with the same data.
 |      
 |      .. note::
 |          Passing None for ``dtype`` is different from omitting the parameter,
 |          since the former invokes ``dtype(None)`` which is an alias for
 |          ``dtype('float_')``.
 |      
 |      Parameters
 |      ----------
 |      dtype : data-type or ndarray sub-class, optional
 |          Data-type descriptor of the returned view, e.g., float32 or int16.
 |          Omitting it results in the view having the same data-type as `a`.
 |          This argument can also be specified as an ndarray sub-class, which
 |          then specifies the type of the returned object (this is equivalent to
 |          setting the ``type`` parameter).
 |      type : Python type, optional
 |          Type of the returned view, e.g., ndarray or matrix.  Again, omission
 |          of the parameter results in type preservation.
 |      
 |      Notes
 |      -----
 |      ``a.view()`` is used two different ways:
 |      
 |      ``a.view(some_dtype)`` or ``a.view(dtype=some_dtype)`` constructs a view
 |      of the array's memory with a different data-type.  This can cause a
 |      reinterpretation of the bytes of memory.
 |      
 |      ``a.view(ndarray_subclass)`` or ``a.view(type=ndarray_subclass)`` just
 |      returns an instance of `ndarray_subclass` that looks at the same array
 |      (same shape, dtype, etc.)  This does not cause a reinterpretation of the
 |      memory.
 |      
 |      For ``a.view(some_dtype)``, if ``some_dtype`` has a different number of
 |      bytes per entry than the previous dtype (for example, converting a regular
 |      array to a structured array), then the last axis of ``a`` must be
 |      contiguous. This axis will be resized in the result.
 |      
 |      .. versionchanged:: 1.23.0
 |         Only the last axis needs to be contiguous. Previously, the entire array
 |         had to be C-contiguous.
 |      
 |      Examples
 |      --------
 |      >>> x = np.array([(1, 2)], dtype=[('a', np.int8), ('b', np.int8)])
 |      
 |      Viewing array data using a different type and dtype:
 |      
 |      >>> y = x.view(dtype=np.int16, type=np.matrix)
 |      >>> y
 |      matrix([[513]], dtype=int16)
 |      >>> print(type(y))
 |      <class 'numpy.matrix'>
 |      
 |      Creating a view on a structured array so it can be used in calculations
 |      
 |      >>> x = np.array([(1, 2),(3,4)], dtype=[('a', np.int8), ('b', np.int8)])
 |      >>> xv = x.view(dtype=np.int8).reshape(-1,2)
 |      >>> xv
 |      array([[1, 2],
 |             [3, 4]], dtype=int8)
 |      >>> xv.mean(0)
 |      array([2.,  3.])
 |      
 |      Making changes to the view changes the underlying array
 |      
 |      >>> xv[0,1] = 20
 |      >>> x
 |      array([(1, 20), (3,  4)], dtype=[('a', 'i1'), ('b', 'i1')])
 |      
 |      Using a view to convert an array to a recarray:
 |      
 |      >>> z = x.view(np.recarray)
 |      >>> z.a
 |      array([1, 3], dtype=int8)
 |      
 |      Views share data:
 |      
 |      >>> x[0] = (9, 10)
 |      >>> z[0]
 |      (9, 10)
 |      
 |      Views that change the dtype size (bytes per entry) should normally be
 |      avoided on arrays defined by slices, transposes, fortran-ordering, etc.:
 |      
 |      >>> x = np.array([[1, 2, 3], [4, 5, 6]], dtype=np.int16)
 |      >>> y = x[:, ::2]
 |      >>> y
 |      array([[1, 3],
 |             [4, 6]], dtype=int16)
 |      >>> y.view(dtype=[('width', np.int16), ('length', np.int16)])
 |      Traceback (most recent call last):
 |          ...
 |      ValueError: To change to a dtype of a different size, the last axis must be contiguous
 |      >>> z = y.copy()
 |      >>> z.view(dtype=[('width', np.int16), ('length', np.int16)])
 |      array([[(1, 3)],
 |             [(4, 6)]], dtype=[('width', '<i2'), ('length', '<i2')])
 |      
 |      However, views that change dtype are totally fine for arrays with a
 |      contiguous last axis, even if the rest of the axes are not C-contiguous:
 |      
 |      >>> x = np.arange(2 * 3 * 4, dtype=np.int8).reshape(2, 3, 4)
 |      >>> x.transpose(1, 0, 2).view(np.int16)
 |      array([[[ 256,  770],
 |              [3340, 3854]],
 |      <BLANKLINE>
 |             [[1284, 1798],
 |              [4368, 4882]],
 |      <BLANKLINE>
 |             [[2312, 2826],
 |              [5396, 5910]]], dtype=int16)
 |  
 |  ----------------------------------------------------------------------
 |  Class methods defined here:
 |  
 |  __class_getitem__(...)
 |      a.__class_getitem__(item, /)
 |      
 |      Return a parametrized wrapper around the `~numpy.ndarray` type.
 |      
 |      .. versionadded:: 1.22
 |      
 |      Returns
 |      -------
 |      alias : types.GenericAlias
 |          A parametrized `~numpy.ndarray` type.
 |      
 |      Examples
 |      --------
 |      >>> from typing import Any
 |      >>> import numpy as np
 |      
 |      >>> np.ndarray[Any, np.dtype[Any]]
 |      numpy.ndarray[typing.Any, numpy.dtype[typing.Any]]
 |      
 |      See Also
 |      --------
 |      :pep:`585` : Type hinting generics in standard collections.
 |      numpy.typing.NDArray : An ndarray alias :term:`generic <generic type>`
 |                          w.r.t. its `dtype.type <numpy.dtype.type>`.
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __new__(*args, **kwargs)
 |      Create and return a new object.  See help(type) for accurate signature.
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  T
 |      View of the transposed array.
 |      
 |      Same as ``self.transpose()``.
 |      
 |      Examples
 |      --------
 |      >>> a = np.array([[1, 2], [3, 4]])
 |      >>> a
 |      array([[1, 2],
 |             [3, 4]])
 |      >>> a.T
 |      array([[1, 3],
 |             [2, 4]])
 |      
 |      >>> a = np.array([1, 2, 3, 4])
 |      >>> a
 |      array([1, 2, 3, 4])
 |      >>> a.T
 |      array([1, 2, 3, 4])
 |      
 |      See Also
 |      --------
 |      transpose
 |  
 |  __array_interface__
 |      Array protocol: Python side.
 |  
 |  __array_priority__
 |      Array priority.
 |  
 |  __array_struct__
 |      Array protocol: C-struct side.
 |  
 |  base
 |      Base object if memory is from some other object.
 |      
 |      Examples
 |      --------
 |      The base of an array that owns its memory is None:
 |      
 |      >>> x = np.array([1,2,3,4])
 |      >>> x.base is None
 |      True
 |      
 |      Slicing creates a view, whose memory is shared with x:
 |      
 |      >>> y = x[2:]
 |      >>> y.base is x
 |      True
 |  
 |  ctypes
 |      An object to simplify the interaction of the array with the ctypes
 |      module.
 |      
 |      This attribute creates an object that makes it easier to use arrays
 |      when calling shared libraries with the ctypes module. The returned
 |      object has, among others, data, shape, and strides attributes (see
 |      Notes below) which themselves return ctypes objects that can be used
 |      as arguments to a shared library.
 |      
 |      Parameters
 |      ----------
 |      None
 |      
 |      Returns
 |      -------
 |      c : Python object
 |          Possessing attributes data, shape, strides, etc.
 |      
 |      See Also
 |      --------
 |      numpy.ctypeslib
 |      
 |      Notes
 |      -----
 |      Below are the public attributes of this object which were documented
 |      in "Guide to NumPy" (we have omitted undocumented public attributes,
 |      as well as documented private attributes):
 |      
 |      .. autoattribute:: numpy.core._internal._ctypes.data
 |          :noindex:
 |      
 |      .. autoattribute:: numpy.core._internal._ctypes.shape
 |          :noindex:
 |      
 |      .. autoattribute:: numpy.core._internal._ctypes.strides
 |          :noindex:
 |      
 |      .. automethod:: numpy.core._internal._ctypes.data_as
 |          :noindex:
 |      
 |      .. automethod:: numpy.core._internal._ctypes.shape_as
 |          :noindex:
 |      
 |      .. automethod:: numpy.core._internal._ctypes.strides_as
 |          :noindex:
 |      
 |      If the ctypes module is not available, then the ctypes attribute
 |      of array objects still returns something useful, but ctypes objects
 |      are not returned and errors may be raised instead. In particular,
 |      the object will still have the ``as_parameter`` attribute which will
 |      return an integer equal to the data attribute.
 |      
 |      Examples
 |      --------
 |      >>> import ctypes
 |      >>> x = np.array([[0, 1], [2, 3]], dtype=np.int32)
 |      >>> x
 |      array([[0, 1],
 |             [2, 3]], dtype=int32)
 |      >>> x.ctypes.data
 |      31962608 # may vary
 |      >>> x.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32))
 |      <__main__.LP_c_uint object at 0x7ff2fc1fc200> # may vary
 |      >>> x.ctypes.data_as(ctypes.POINTER(ctypes.c_uint32)).contents
 |      c_uint(0)
 |      >>> x.ctypes.data_as(ctypes.POINTER(ctypes.c_uint64)).contents
 |      c_ulong(4294967296)
 |      >>> x.ctypes.shape
 |      <numpy.core._internal.c_long_Array_2 object at 0x7ff2fc1fce60> # may vary
 |      >>> x.ctypes.strides
 |      <numpy.core._internal.c_long_Array_2 object at 0x7ff2fc1ff320> # may vary
 |  
 |  data
 |      Python buffer object pointing to the start of the array's data.
 |  
 |  dtype
 |      Data-type of the array's elements.
 |      
 |      .. warning::
 |      
 |          Setting ``arr.dtype`` is discouraged and may be deprecated in the
 |          future.  Setting will replace the ``dtype`` without modifying the
 |          memory (see also `ndarray.view` and `ndarray.astype`).
 |      
 |      Parameters
 |      ----------
 |      None
 |      
 |      Returns
 |      -------
 |      d : numpy dtype object
 |      
 |      See Also
 |      --------
 |      ndarray.astype : Cast the values contained in the array to a new data-type.
 |      ndarray.view : Create a view of the same data but a different data-type.
 |      numpy.dtype
 |      
 |      Examples
 |      --------
 |      >>> x
 |      array([[0, 1],
 |             [2, 3]])
 |      >>> x.dtype
 |      dtype('int32')
 |      >>> type(x.dtype)
 |      <type 'numpy.dtype'>
 |  
 |  flags
 |      Information about the memory layout of the array.
 |      
 |      Attributes
 |      ----------
 |      C_CONTIGUOUS (C)
 |          The data is in a single, C-style contiguous segment.
 |      F_CONTIGUOUS (F)
 |          The data is in a single, Fortran-style contiguous segment.
 |      OWNDATA (O)
 |          The array owns the memory it uses or borrows it from another object.
 |      WRITEABLE (W)
 |          The data area can be written to.  Setting this to False locks
 |          the data, making it read-only.  A view (slice, etc.) inherits WRITEABLE
 |          from its base array at creation time, but a view of a writeable
 |          array may be subsequently locked while the base array remains writeable.
 |          (The opposite is not true, in that a view of a locked array may not
 |          be made writeable.  However, currently, locking a base object does not
 |          lock any views that already reference it, so under that circumstance it
 |          is possible to alter the contents of a locked array via a previously
 |          created writeable view onto it.)  Attempting to change a non-writeable
 |          array raises a RuntimeError exception.
 |      ALIGNED (A)
 |          The data and all elements are aligned appropriately for the hardware.
 |      WRITEBACKIFCOPY (X)
 |          This array is a copy of some other array. The C-API function
 |          PyArray_ResolveWritebackIfCopy must be called before deallocating
 |          to the base array will be updated with the contents of this array.
 |      FNC
 |          F_CONTIGUOUS and not C_CONTIGUOUS.
 |      FORC
 |          F_CONTIGUOUS or C_CONTIGUOUS (one-segment test).
 |      BEHAVED (B)
 |          ALIGNED and WRITEABLE.
 |      CARRAY (CA)
 |          BEHAVED and C_CONTIGUOUS.
 |      FARRAY (FA)
 |          BEHAVED and F_CONTIGUOUS and not C_CONTIGUOUS.
 |      
 |      Notes
 |      -----
 |      The `flags` object can be accessed dictionary-like (as in ``a.flags['WRITEABLE']``),
 |      or by using lowercased attribute names (as in ``a.flags.writeable``). Short flag
 |      names are only supported in dictionary access.
 |      
 |      Only the WRITEBACKIFCOPY, WRITEABLE, and ALIGNED flags can be
 |      changed by the user, via direct assignment to the attribute or dictionary
 |      entry, or by calling `ndarray.setflags`.
 |      
 |      The array flags cannot be set arbitrarily:
 |      
 |      - WRITEBACKIFCOPY can only be set ``False``.
 |      - ALIGNED can only be set ``True`` if the data is truly aligned.
 |      - WRITEABLE can only be set ``True`` if the array owns its own memory
 |        or the ultimate owner of the memory exposes a writeable buffer
 |        interface or is a string.
 |      
 |      Arrays can be both C-style and Fortran-style contiguous simultaneously.
 |      This is clear for 1-dimensional arrays, but can also be true for higher
 |      dimensional arrays.
 |      
 |      Even for contiguous arrays a stride for a given dimension
 |      ``arr.strides[dim]`` may be *arbitrary* if ``arr.shape[dim] == 1``
 |      or the array has no elements.
 |      It does *not* generally hold that ``self.strides[-1] == self.itemsize``
 |      for C-style contiguous arrays or ``self.strides[0] == self.itemsize`` for
 |      Fortran-style contiguous arrays is true.
 |  
 |  flat
 |      A 1-D iterator over the array.
 |      
 |      This is a `numpy.flatiter` instance, which acts similarly to, but is not
 |      a subclass of, Python's built-in iterator object.
 |      
 |      See Also
 |      --------
 |      flatten : Return a copy of the array collapsed into one dimension.
 |      
 |      flatiter
 |      
 |      Examples
 |      --------
 |      >>> x = np.arange(1, 7).reshape(2, 3)
 |      >>> x
 |      array([[1, 2, 3],
 |             [4, 5, 6]])
 |      >>> x.flat[3]
 |      4
 |      >>> x.T
 |      array([[1, 4],
 |             [2, 5],
 |             [3, 6]])
 |      >>> x.T.flat[3]
 |      5
 |      >>> type(x.flat)
 |      <class 'numpy.flatiter'>
 |      
 |      An assignment example:
 |      
 |      >>> x.flat = 3; x
 |      array([[3, 3, 3],
 |             [3, 3, 3]])
 |      >>> x.flat[[1,4]] = 1; x
 |      array([[3, 1, 3],
 |             [3, 1, 3]])
 |  
 |  imag
 |      The imaginary part of the array.
 |      
 |      Examples
 |      --------
 |      >>> x = np.sqrt([1+0j, 0+1j])
 |      >>> x.imag
 |      array([ 0.        ,  0.70710678])
 |      >>> x.imag.dtype
 |      dtype('float64')
 |  
 |  itemsize
 |      Length of one array element in bytes.
 |      
 |      Examples
 |      --------
 |      >>> x = np.array([1,2,3], dtype=np.float64)
 |      >>> x.itemsize
 |      8
 |      >>> x = np.array([1,2,3], dtype=np.complex128)
 |      >>> x.itemsize
 |      16
 |  
 |  nbytes
 |      Total bytes consumed by the elements of the array.
 |      
 |      Notes
 |      -----
 |      Does not include memory consumed by non-element attributes of the
 |      array object.
 |      
 |      See Also
 |      --------
 |      sys.getsizeof
 |          Memory consumed by the object itself without parents in case view.
 |          This does include memory consumed by non-element attributes.
 |      
 |      Examples
 |      --------
 |      >>> x = np.zeros((3,5,2), dtype=np.complex128)
 |      >>> x.nbytes
 |      480
 |      >>> np.prod(x.shape) * x.itemsize
 |      480
 |  
 |  ndim
 |      Number of array dimensions.
 |      
 |      Examples
 |      --------
 |      >>> x = np.array([1, 2, 3])
 |      >>> x.ndim
 |      1
 |      >>> y = np.zeros((2, 3, 4))
 |      >>> y.ndim
 |      3
 |  
 |  real
 |      The real part of the array.
 |      
 |      Examples
 |      --------
 |      >>> x = np.sqrt([1+0j, 0+1j])
 |      >>> x.real
 |      array([ 1.        ,  0.70710678])
 |      >>> x.real.dtype
 |      dtype('float64')
 |      
 |      See Also
 |      --------
 |      numpy.real : equivalent function
 |  
 |  shape
 |      Tuple of array dimensions.
 |      
 |      The shape property is usually used to get the current shape of an array,
 |      but may also be used to reshape the array in-place by assigning a tuple of
 |      array dimensions to it.  As with `numpy.reshape`, one of the new shape
 |      dimensions can be -1, in which case its value is inferred from the size of
 |      the array and the remaining dimensions. Reshaping an array in-place will
 |      fail if a copy is required.
 |      
 |      .. warning::
 |      
 |          Setting ``arr.shape`` is discouraged and may be deprecated in the
 |          future.  Using `ndarray.reshape` is the preferred approach.
 |      
 |      Examples
 |      --------
 |      >>> x = np.array([1, 2, 3, 4])
 |      >>> x.shape
 |      (4,)
 |      >>> y = np.zeros((2, 3, 4))
 |      >>> y.shape
 |      (2, 3, 4)
 |      >>> y.shape = (3, 8)
 |      >>> y
 |      array([[ 0.,  0.,  0.,  0.,  0.,  0.,  0.,  0.],
 |             [ 0.,  0.,  0.,  0.,  0.,  0.,  0.,  0.],
 |             [ 0.,  0.,  0.,  0.,  0.,  0.,  0.,  0.]])
 |      >>> y.shape = (3, 6)
 |      Traceback (most recent call last):
 |        File "<stdin>", line 1, in <module>
 |      ValueError: total size of new array must be unchanged
 |      >>> np.zeros((4,2))[::2].shape = (-1,)
 |      Traceback (most recent call last):
 |        File "<stdin>", line 1, in <module>
 |      AttributeError: Incompatible shape for in-place modification. Use
 |      `.reshape()` to make a copy with the desired shape.
 |      
 |      See Also
 |      --------
 |      numpy.shape : Equivalent getter function.
 |      numpy.reshape : Function similar to setting ``shape``.
 |      ndarray.reshape : Method similar to setting ``shape``.
 |  
 |  size
 |      Number of elements in the array.
 |      
 |      Equal to ``np.prod(a.shape)``, i.e., the product of the array's
 |      dimensions.
 |      
 |      Notes
 |      -----
 |      `a.size` returns a standard arbitrary precision Python integer. This
 |      may not be the case with other methods of obtaining the same value
 |      (like the suggested ``np.prod(a.shape)``, which returns an instance
 |      of ``np.int_``), and may be relevant if the value is used further in
 |      calculations that may overflow a fixed size integer type.
 |      
 |      Examples
 |      --------
 |      >>> x = np.zeros((3, 5, 2), dtype=np.complex128)
 |      >>> x.size
 |      30
 |      >>> np.prod(x.shape)
 |      30
 |  
 |  strides
 |      Tuple of bytes to step in each dimension when traversing an array.
 |      
 |      The byte offset of element ``(i[0], i[1], ..., i[n])`` in an array `a`
 |      is::
 |      
 |          offset = sum(np.array(i) * a.strides)
 |      
 |      A more detailed explanation of strides can be found in the
 |      "ndarray.rst" file in the NumPy reference guide.
 |      
 |      .. warning::
 |      
 |          Setting ``arr.strides`` is discouraged and may be deprecated in the
 |          future.  `numpy.lib.stride_tricks.as_strided` should be preferred
 |          to create a new view of the same data in a safer way.
 |      
 |      Notes
 |      -----
 |      Imagine an array of 32-bit integers (each 4 bytes)::
 |      
 |        x = np.array([[0, 1, 2, 3, 4],
 |                      [5, 6, 7, 8, 9]], dtype=np.int32)
 |      
 |      This array is stored in memory as 40 bytes, one after the other
 |      (known as a contiguous block of memory).  The strides of an array tell
 |      us how many bytes we have to skip in memory to move to the next position
 |      along a certain axis.  For example, we have to skip 4 bytes (1 value) to
 |      move to the next column, but 20 bytes (5 values) to get to the same
 |      position in the next row.  As such, the strides for the array `x` will be
 |      ``(20, 4)``.
 |      
 |      See Also
 |      --------
 |      numpy.lib.stride_tricks.as_strided
 |      
 |      Examples
 |      --------
 |      >>> y = np.reshape(np.arange(2*3*4), (2,3,4))
 |      >>> y
 |      array([[[ 0,  1,  2,  3],
 |              [ 4,  5,  6,  7],
 |              [ 8,  9, 10, 11]],
 |             [[12, 13, 14, 15],
 |              [16, 17, 18, 19],
 |              [20, 21, 22, 23]]])
 |      >>> y.strides
 |      (48, 16, 4)
 |      >>> y[1,1,1]
 |      17
 |      >>> offset=sum(y.strides * np.array((1,1,1)))
 |      >>> offset/y.itemsize
 |      17
 |      
 |      >>> x = np.reshape(np.arange(5*6*7*8), (5,6,7,8)).transpose(2,3,1,0)
 |      >>> x.strides
 |      (32, 4, 224, 1344)
 |      >>> i = np.array([3,5,2,2])
 |      >>> offset = sum(i * x.strides)
 |      >>> x[3,5,2,2]
 |      813
 |      >>> offset / x.itemsize
 |      813
 |  
 |  ----------------------------------------------------------------------
 |  Data and other attributes defined here:
 |  
 |  __hash__ = None
```

## Appendix II

```
Help on built-in function array in module numpy:

array(...)
    array(object, dtype=None, *, copy=True, order='K', subok=False, ndmin=0,
          like=None)
    
    Create an array.
    
    Parameters
    ----------
    object : array_like
        An array, any object exposing the array interface, an object whose
        ``__array__`` method returns an array, or any (nested) sequence.
        If object is a scalar, a 0-dimensional array containing object is
        returned.
    dtype : data-type, optional
        The desired data-type for the array. If not given, NumPy will try to use
        a default ``dtype`` that can represent the values (by applying promotion
        rules when necessary.)
    copy : bool, optional
        If true (default), then the object is copied.  Otherwise, a copy will
        only be made if ``__array__`` returns a copy, if obj is a nested
        sequence, or if a copy is needed to satisfy any of the other
        requirements (``dtype``, ``order``, etc.).
    order : {'K', 'A', 'C', 'F'}, optional
        Specify the memory layout of the array. If object is not an array, the
        newly created array will be in C order (row major) unless 'F' is
        specified, in which case it will be in Fortran order (column major).
        If object is an array the following holds.
    
        ===== ========= ===================================================
        order  no copy                     copy=True
        ===== ========= ===================================================
        'K'   unchanged F & C order preserved, otherwise most similar order
        'A'   unchanged F order if input is F and not C, otherwise C order
        'C'   C order   C order
        'F'   F order   F order
        ===== ========= ===================================================
    
        When ``copy=False`` and a copy is made for other reasons, the result is
        the same as if ``copy=True``, with some exceptions for 'A', see the
        Notes section. The default order is 'K'.
    subok : bool, optional
        If True, then sub-classes will be passed-through, otherwise
        the returned array will be forced to be a base-class array (default).
    ndmin : int, optional
        Specifies the minimum number of dimensions that the resulting
        array should have.  Ones will be prepended to the shape as
        needed to meet this requirement.
    like : array_like, optional
        Reference object to allow the creation of arrays which are not
        NumPy arrays. If an array-like passed in as ``like`` supports
        the ``__array_function__`` protocol, the result will be defined
        by it. In this case, it ensures the creation of an array object
        compatible with that passed in via this argument.
    
        .. versionadded:: 1.20.0
    
    Returns
    -------
    out : ndarray
        An array object satisfying the specified requirements.
    
    See Also
    --------
    empty_like : Return an empty array with shape and type of input.
    ones_like : Return an array of ones with shape and type of input.
    zeros_like : Return an array of zeros with shape and type of input.
    full_like : Return a new array with shape of input filled with value.
    empty : Return a new uninitialized array.
    ones : Return a new array setting values to one.
    zeros : Return a new array setting values to zero.
    full : Return a new array of given shape filled with value.
    
    
    Notes
    -----
    When order is 'A' and ``object`` is an array in neither 'C' nor 'F' order,
    and a copy is forced by a change in dtype, then the order of the result is
    not necessarily 'C' as expected. This is likely a bug.
    
    Examples
    --------
    >>> np.array([1, 2, 3])
    array([1, 2, 3])
    
    Upcasting:
    
    >>> np.array([1, 2, 3.0])
    array([ 1.,  2.,  3.])
    
    More than one dimension:
    
    >>> np.array([[1, 2], [3, 4]])
    array([[1, 2],
           [3, 4]])
    
    Minimum dimensions 2:
    
    >>> np.array([1, 2, 3], ndmin=2)
    array([[1, 2, 3]])
    
    Type provided:
    
    >>> np.array([1, 2, 3], dtype=complex)
    array([ 1.+0.j,  2.+0.j,  3.+0.j])
    
    Data-type consisting of more than one element:
    
    >>> x = np.array([(1,2),(3,4)],dtype=[('a','<i4'),('b','<i4')])
    >>> x['a']
    array([1, 3])
    
    Creating an array from sub-classes:
    
    >>> np.array(np.mat('1 2; 3 4'))
    array([[1, 2],
           [3, 4]])
    
    >>> np.array(np.mat('1 2; 3 4'), subok=True)
    matrix([[1, 2],
            [3, 4]])
```

## Appendix III

```
Help on Tensor in module torch object:

class Tensor(torch._C.TensorBase)
 |  Method resolution order:
 |      Tensor
 |      torch._C.TensorBase
 |      builtins.object
 |  
 |  Methods defined here:
 |  
 |  __abs__ = abs(...)
 |  
 |  __array__(self, dtype=None) from torch._tensor.Tensor
 |  
 |  __array_wrap__(self, array) from torch._tensor.Tensor
 |      # Wrap Numpy array again in a suitable tensor when done, to support e.g.
 |      # `numpy.sin(tensor) -> tensor` or `numpy.greater(tensor, 0) -> ByteTensor`
 |  
 |  __contains__(self, element) from torch._tensor.Tensor
 |      Check if `element` is present in tensor
 |      
 |      Args:
 |          element (Tensor or scalar): element to be checked
 |              for presence in current tensor"
 |  
 |  __deepcopy__(self, memo) from torch._tensor.Tensor
 |  
 |  __dir__(self) from torch._tensor.Tensor
 |      Default dir() implementation.
 |  
 |  __dlpack__(self, stream=None) from torch._tensor.Tensor
 |      Creates a DLpack `capsule https://data-apis.org/array-api/latest/design_topics/data_interchange.html#data-interchange`_
 |      of the current tensor to be exported to other libraries.
 |      
 |      This function will be called from the `from_dlpack` method
 |      of the library that will consume the capsule. `from_dlpack` passes the current
 |      stream to this method as part of the specification.
 |      
 |      Args:
 |          stream (integer or None): An optional Python integer representing a
 |          pointer to a CUDA stream. The current stream is synchronized with
 |          this stream before the capsule is created, and since the capsule
 |          shares its storage with the tensor this make it safe to access from
 |          both streams.  If None or -1 is passed then no synchronization is performed.
 |          If 1 (on CUDA) or 0 (on ROCM) then the default stream is used for
 |          synchronization.
 |  
 |  __dlpack_device__(self) -> Tuple[enum.IntEnum, int] from torch._tensor.Tensor
 |  
 |  __floordiv__(self, other) from torch._tensor.Tensor
 |  
 |  __format__(self, format_spec) from torch._tensor.Tensor
 |      Default object formatter.
 |  
 |  __hash__(self) from torch._tensor.Tensor
 |      Return hash(self).
 |  
 |  __ipow__ = pow_(...) from torch._tensor.TensorBase
 |  
 |  __iter__(self) from torch._tensor.Tensor
 |  
 |  __itruediv__ = __idiv__(...)
 |  
 |  __len__(self) from torch._tensor.Tensor
 |      Return len(self).
 |  
 |  __neg__ = neg(...)
 |  
 |  __pos__ = positive(...)
 |  
 |  __pow__ = pow(...) from torch._tensor.TensorBase
 |  
 |  __rdiv__(self, other) from torch._tensor.Tensor
 |  
 |  __reduce_ex__(self, proto) from torch._tensor.Tensor
 |      Helper for pickle.
 |  
 |  __repr__(self, *, tensor_contents=None) from torch._tensor.Tensor
 |      Return repr(self).
 |  
 |  __reversed__(self) from torch._tensor.Tensor
 |      Reverses the tensor along dimension 0.
 |  
 |  __rfloordiv__(self, other) from torch._tensor.Tensor
 |  
 |  __rlshift__(self, other) from torch._tensor.Tensor
 |  
 |  __rmatmul__(self, other) from torch._tensor.Tensor
 |  
 |  __rmod__(self, other) from torch._tensor.Tensor
 |  
 |  __rpow__(self, other) from torch._tensor.Tensor
 |  
 |  __rrshift__(self, other) from torch._tensor.Tensor
 |  
 |  __rsub__(self, other) from torch._tensor.Tensor
 |  
 |  __rtruediv__ = __rdiv__(self, other)
 |  
 |  __setstate__(self, state) from torch._tensor.Tensor
 |  
 |  align_to(self, *names) from torch._tensor.Tensor
 |      Permutes the dimensions of the :attr:`self` tensor to match the order
 |      specified in :attr:`names`, adding size-one dims for any new names.
 |      
 |      All of the dims of :attr:`self` must be named in order to use this method.
 |      The resulting tensor is a view on the original tensor.
 |      
 |      All dimension names of :attr:`self` must be present in :attr:`names`.
 |      :attr:`names` may contain additional names that are not in ``self.names``;
 |      the output tensor has a size-one dimension for each of those new names.
 |      
 |      :attr:`names` may contain up to one Ellipsis (``...``).
 |      The Ellipsis is expanded to be equal to all dimension names of :attr:`self`
 |      that are not mentioned in :attr:`names`, in the order that they appear
 |      in :attr:`self`.
 |      
 |      Python 2 does not support Ellipsis but one may use a string literal
 |      instead (``'...'``).
 |      
 |      Args:
 |          names (iterable of str): The desired dimension ordering of the
 |              output tensor. May contain up to one Ellipsis that is expanded
 |              to all unmentioned dim names of :attr:`self`.
 |      
 |      Examples::
 |      
 |          >>> tensor = torch.randn(2, 2, 2, 2, 2, 2)
 |          >>> named_tensor = tensor.refine_names('A', 'B', 'C', 'D', 'E', 'F')
 |      
 |          # Move the F and E dims to the front while keeping the rest in order
 |          >>> named_tensor.align_to('F', 'E', ...)
 |      
 |      .. warning::
 |          The named tensor API is experimental and subject to change.
 |  
 |  backward(self, gradient=None, retain_graph=None, create_graph=False, inputs=None) from torch._tensor.Tensor
 |      Computes the gradient of current tensor wrt graph leaves.
 |      
 |      The graph is differentiated using the chain rule. If the tensor is
 |      non-scalar (i.e. its data has more than one element) and requires
 |      gradient, the function additionally requires specifying ``gradient``.
 |      It should be a tensor of matching type and location, that contains
 |      the gradient of the differentiated function w.r.t. ``self``.
 |      
 |      This function accumulates gradients in the leaves - you might need to zero
 |      ``.grad`` attributes or set them to ``None`` before calling it.
 |      See :ref:`Default gradient layouts<default-grad-layouts>`
 |      for details on the memory layout of accumulated gradients.
 |      
 |      .. note::
 |      
 |          If you run any forward ops, create ``gradient``, and/or call ``backward``
 |          in a user-specified CUDA stream context, see
 |          :ref:`Stream semantics of backward passes<bwd-cuda-stream-semantics>`.
 |      
 |      .. note::
 |      
 |          When ``inputs`` are provided and a given input is not a leaf,
 |          the current implementation will call its grad_fn (though it is not strictly needed to get this gradients).
 |          It is an implementation detail on which the user should not rely.
 |          See https://github.com/pytorch/pytorch/pull/60521#issuecomment-867061780 for more details.
 |      
 |      Args:
 |          gradient (Tensor or None): Gradient w.r.t. the
 |              tensor. If it is a tensor, it will be automatically converted
 |              to a Tensor that does not require grad unless ``create_graph`` is True.
 |              None values can be specified for scalar Tensors or ones that
 |              don't require grad. If a None value would be acceptable then
 |              this argument is optional.
 |          retain_graph (bool, optional): If ``False``, the graph used to compute
 |              the grads will be freed. Note that in nearly all cases setting
 |              this option to True is not needed and often can be worked around
 |              in a much more efficient way. Defaults to the value of
 |              ``create_graph``.
 |          create_graph (bool, optional): If ``True``, graph of the derivative will
 |              be constructed, allowing to compute higher order derivative
 |              products. Defaults to ``False``.
 |          inputs (sequence of Tensor): Inputs w.r.t. which the gradient will be
 |              accumulated into ``.grad``. All other Tensors will be ignored. If not
 |              provided, the gradient is accumulated into all the leaf Tensors that were
 |              used to compute the attr::tensors.
 |  
 |  detach(...) from torch._C.TensorBase
 |      Returns a new Tensor, detached from the current graph.
 |      
 |      The result will never require gradient.
 |      
 |      This method also affects forward mode AD gradients and the result will never
 |      have forward mode AD gradients.
 |      
 |      .. note::
 |      
 |        Returned Tensor shares the same storage with the original one.
 |        In-place modifications on either of them will be seen, and may trigger
 |        errors in correctness checks.
 |  
 |  detach_(...) from torch._C.TensorBase
 |      Detaches the Tensor from the graph that created it, making it a leaf.
 |      Views cannot be detached in-place.
 |      
 |      This method also affects forward mode AD gradients and the result will never
 |      have forward mode AD gradients.
 |  
 |  dim_order(self) from torch._tensor.Tensor
 |      dim_order() -> tuple
 |      
 |      Returns a tuple of int describing the dim order or physical layout of :attr:`self`.
 |      
 |      Args:
 |          None
 |      
 |      Dim order represents how dimensions are laid out in memory,
 |      starting from the outermost to the innermost dimension.
 |      
 |      Example::
 |          >>> torch.empty((2, 3, 5, 7)).dim_order()
 |          (0, 1, 2, 3)
 |          >>> torch.empty((2, 3, 5, 7), memory_format=torch.channels_last).dim_order()
 |          (0, 2, 3, 1)
 |      
 |      .. warning::
 |          The dim_order tensor API is experimental and subject to change.
 |  
 |  eig(self, eigenvectors=False) from torch._tensor.Tensor
 |  
 |  is_shared(self) from torch._tensor.Tensor
 |      Checks if tensor is in shared memory.
 |      
 |      This is always ``True`` for CUDA tensors.
 |  
 |  istft(self, n_fft: int, hop_length: Optional[int] = None, win_length: Optional[int] = None, window: 'Optional[Tensor]' = None, center: bool = True, normalized: bool = False, onesided: Optional[bool] = None, length: Optional[int] = None, return_complex: bool = False) from torch._tensor.Tensor
 |      See :func:`torch.istft`
 |  
 |  lstsq(self, other) from torch._tensor.Tensor
 |  
 |  lu(self, pivot=True, get_infos=False) from torch._tensor.Tensor
 |      See :func:`torch.lu`
 |  
 |  module_load(self, other, assign=False) from torch._tensor.Tensor
 |      Defines how to transform ``other`` when loading it into ``self`` in :meth:`~nn.Module.load_state_dict`.
 |      
 |      Used when :func:`~torch.__future__.get_swap_module_params_on_conversion` is ``True``.
 |      
 |      It is expected that ``self`` is a parameter or buffer in an ``nn.Module`` and ``other`` is the
 |      value in the state dictionary with the corresponding key, this method defines
 |      how ``other`` is remapped before being swapped with ``self`` via
 |      :func:`~torch.utils.swap_tensors`` in ``module.load_state_dict()``.
 |      
 |      .. note::
 |          This method should always return a new object that is not ``self`` or ``other``.
 |          For example, the default implementation returns ``self.copy_(other).detach()``
 |          if ``assign`` is ``False`` or ``other.detach()`` if ``assign`` is ``True``.
 |      
 |      Args:
 |          other (Tensor): value in state dict with key corresponding to ``self``
 |          assign (bool): the assign argument passed to :meth:`nn.Module.load_state_dict`
 |  
 |  norm(self, p: Union[float, str, NoneType] = 'fro', dim=None, keepdim=False, dtype=None) from torch._tensor.Tensor
 |      See :func:`torch.norm`
 |  
 |  refine_names(self, *names) from torch._tensor.Tensor
 |      Refines the dimension names of :attr:`self` according to :attr:`names`.
 |      
 |      Refining is a special case of renaming that "lifts" unnamed dimensions.
 |      A ``None`` dim can be refined to have any name; a named dim can only be
 |      refined to have the same name.
 |      
 |      Because named tensors can coexist with unnamed tensors, refining names
 |      gives a nice way to write named-tensor-aware code that works with both
 |      named and unnamed tensors.
 |      
 |      :attr:`names` may contain up to one Ellipsis (``...``).
 |      The Ellipsis is expanded greedily; it is expanded in-place to fill
 |      :attr:`names` to the same length as ``self.dim()`` using names from the
 |      corresponding indices of ``self.names``.
 |      
 |      Python 2 does not support Ellipsis but one may use a string literal
 |      instead (``'...'``).
 |      
 |      Args:
 |          names (iterable of str): The desired names of the output tensor. May
 |              contain up to one Ellipsis.
 |      
 |      Examples::
 |      
 |          >>> imgs = torch.randn(32, 3, 128, 128)
 |          >>> named_imgs = imgs.refine_names('N', 'C', 'H', 'W')
 |          >>> named_imgs.names
 |          ('N', 'C', 'H', 'W')
 |      
 |          >>> tensor = torch.randn(2, 3, 5, 7, 11)
 |          >>> tensor = tensor.refine_names('A', ..., 'B', 'C')
 |          >>> tensor.names
 |          ('A', None, None, 'B', 'C')
 |      
 |      .. warning::
 |          The named tensor API is experimental and subject to change.
 |  
 |  register_hook(self, hook) from torch._tensor.Tensor
 |      Registers a backward hook.
 |      
 |      The hook will be called every time a gradient with respect to the
 |      Tensor is computed. The hook should have the following signature::
 |      
 |          hook(grad) -> Tensor or None
 |      
 |      
 |      The hook should not modify its argument, but it can optionally return
 |      a new gradient which will be used in place of :attr:`grad`.
 |      
 |      This function returns a handle with a method ``handle.remove()``
 |      that removes the hook from the module.
 |      
 |      .. note::
 |          See :ref:`backward-hooks-execution` for more information on how when this hook
 |          is executed, and how its execution is ordered relative to other hooks.
 |      
 |      Example::
 |      
 |          >>> v = torch.tensor([0., 0., 0.], requires_grad=True)
 |          >>> h = v.register_hook(lambda grad: grad * 2)  # double the gradient
 |          >>> v.backward(torch.tensor([1., 2., 3.]))
 |          >>> v.grad
 |      
 |           2
 |           4
 |           6
 |          [torch.FloatTensor of size (3,)]
 |      
 |          >>> h.remove()  # removes the hook
 |  
 |  register_post_accumulate_grad_hook(self, hook) from torch._tensor.Tensor
 |      Registers a backward hook that runs after grad accumulation.
 |      
 |      The hook will be called after all gradients for a tensor have been accumulated,
 |      meaning that the .grad field has been updated on that tensor. The post
 |      accumulate grad hook is ONLY applicable for leaf tensors (tensors without a
 |      .grad_fn field). Registering this hook on a non-leaf tensor will error!
 |      
 |      The hook should have the following signature::
 |      
 |          hook(param: Tensor) -> None
 |      
 |      Note that, unlike other autograd hooks, this hook operates on the tensor
 |      that requires grad and not the grad itself. The hook can in-place modify
 |      and access its Tensor argument, including its .grad field.
 |      
 |      This function returns a handle with a method ``handle.remove()``
 |      that removes the hook from the module.
 |      
 |      .. note::
 |          See :ref:`backward-hooks-execution` for more information on how when this hook
 |          is executed, and how its execution is ordered relative to other hooks. Since
 |          this hook runs during the backward pass, it will run in no_grad mode (unless
 |          create_graph is True). You can use torch.enable_grad() to re-enable autograd
 |          within the hook if you need it.
 |      
 |      Example::
 |      
 |          >>> v = torch.tensor([0., 0., 0.], requires_grad=True)
 |          >>> lr = 0.01
 |          >>> # simulate a simple SGD update
 |          >>> h = v.register_post_accumulate_grad_hook(lambda p: p.add_(p.grad, alpha=-lr))
 |          >>> v.backward(torch.tensor([1., 2., 3.]))
 |          >>> v
 |          tensor([-0.0100, -0.0200, -0.0300], requires_grad=True)
 |      
 |          >>> h.remove()  # removes the hook
 |  
 |  reinforce(self, reward) from torch._tensor.Tensor
 |  
 |  rename(self, *names, **rename_map) from torch._tensor.Tensor
 |      Renames dimension names of :attr:`self`.
 |      
 |      There are two main usages:
 |      
 |      ``self.rename(**rename_map)`` returns a view on tensor that has dims
 |      renamed as specified in the mapping :attr:`rename_map`.
 |      
 |      ``self.rename(*names)`` returns a view on tensor, renaming all
 |      dimensions positionally using :attr:`names`.
 |      Use ``self.rename(None)`` to drop names on a tensor.
 |      
 |      One cannot specify both positional args :attr:`names` and keyword args
 |      :attr:`rename_map`.
 |      
 |      Examples::
 |      
 |          >>> imgs = torch.rand(2, 3, 5, 7, names=('N', 'C', 'H', 'W'))
 |          >>> renamed_imgs = imgs.rename(N='batch', C='channels')
 |          >>> renamed_imgs.names
 |          ('batch', 'channels', 'H', 'W')
 |      
 |          >>> renamed_imgs = imgs.rename(None)
 |          >>> renamed_imgs.names
 |          (None, None, None, None)
 |      
 |          >>> renamed_imgs = imgs.rename('batch', 'channel', 'height', 'width')
 |          >>> renamed_imgs.names
 |          ('batch', 'channel', 'height', 'width')
 |      
 |      .. warning::
 |          The named tensor API is experimental and subject to change.
 |  
 |  rename_(self, *names, **rename_map) from torch._tensor.Tensor
 |      In-place version of :meth:`~Tensor.rename`.
 |  
 |  resize(self, *sizes) from torch._tensor.Tensor
 |  
 |  resize_as(self, tensor) from torch._tensor.Tensor
 |  
 |  share_memory_(self) from torch._tensor.Tensor
 |      Moves the underlying storage to shared memory.
 |      
 |      This is a no-op if the underlying storage is already in shared memory
 |      and for CUDA tensors. Tensors in shared memory cannot be resized.
 |      
 |      See :meth:`torch.UntypedStorage.share_memory_` for more details.
 |  
 |  solve(self, other) from torch._tensor.Tensor
 |  
 |  split(self, split_size, dim=0) from torch._tensor.Tensor
 |      See :func:`torch.split`
 |  
 |  stft(self, n_fft: int, hop_length: Optional[int] = None, win_length: Optional[int] = None, window: 'Optional[Tensor]' = None, center: bool = True, pad_mode: str = 'reflect', normalized: bool = False, onesided: Optional[bool] = None, return_complex: Optional[bool] = None) from torch._tensor.Tensor
 |      See :func:`torch.stft`
 |      
 |      .. warning::
 |        This function changed signature at version 0.4.1. Calling with
 |        the previous signature may cause error or return incorrect result.
 |  
 |  storage(self) from torch._tensor.Tensor
 |      storage() -> torch.TypedStorage
 |      
 |      Returns the underlying :class:`TypedStorage`.
 |      
 |      .. warning::
 |      
 |          :class:`TypedStorage` is deprecated. It will be removed in the future, and
 |          :class:`UntypedStorage` will be the only storage class. To access the
 |          :class:`UntypedStorage` directly, use :attr:`Tensor.untyped_storage()`.
 |  
 |  storage_type(self) from torch._tensor.Tensor
 |      storage_type() -> type
 |      
 |      Returns the type of the underlying storage.
 |  
 |  symeig(self, eigenvectors=False) from torch._tensor.Tensor
 |  
 |  to_sparse_coo(self) from torch._tensor.Tensor
 |      Convert a tensor to :ref:`coordinate format <sparse-coo-docs>`.
 |      
 |      Examples::
 |      
 |           >>> dense = torch.randn(5, 5)
 |           >>> sparse = dense.to_sparse_coo()
 |           >>> sparse._nnz()
 |           25
 |  
 |  unflatten(self, dim, sizes) from torch._tensor.Tensor
 |      unflatten(dim, sizes) -> Tensor
 |      
 |      See :func:`torch.unflatten`.
 |  
 |  unique(self, sorted=True, return_inverse=False, return_counts=False, dim=None) from torch._tensor.Tensor
 |      Returns the unique elements of the input tensor.
 |      
 |      See :func:`torch.unique`
 |  
 |  unique_consecutive(self, return_inverse=False, return_counts=False, dim=None) from torch._tensor.Tensor
 |      Eliminates all but the first element from every consecutive group of equivalent elements.
 |      
 |      See :func:`torch.unique_consecutive`
 |  
 |  ----------------------------------------------------------------------
 |  Class methods defined here:
 |  
 |  __torch_function__(func, types, args=(), kwargs=None) from torch._tensor.Tensor
 |      This __torch_function__ implementation wraps subclasses such that
 |      methods called on subclasses return a subclass instance instead of
 |      a ``torch.Tensor`` instance.
 |      
 |      One corollary to this is that you need coverage for torch.Tensor
 |      methods if implementing __torch_function__ for subclasses.
 |      
 |      We recommend always calling ``super().__torch_function__`` as the base
 |      case when doing the above.
 |      
 |      While not mandatory, we recommend making `__torch_function__` a classmethod.
 |  
 |  ----------------------------------------------------------------------
 |  Static methods defined here:
 |  
 |  __torch_dispatch__ = _disabled_torch_dispatch_impl(...)
 |  
 |  ----------------------------------------------------------------------
 |  Readonly properties defined here:
 |  
 |  __cuda_array_interface__
 |      Array view description for cuda tensors.
 |      
 |      See:
 |      https://numba.pydata.org/numba-doc/latest/cuda/cuda_array_interface.html
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |  
 |  __dict__
 |      dictionary for instance variables
 |  
 |  __weakref__
 |      list of weak references to the object
 |  
 |  ----------------------------------------------------------------------
 |  Data and other attributes defined here:
 |  
 |  __array_priority__ = 1000
 |  
 |  ----------------------------------------------------------------------
 |  Methods inherited from torch._C.TensorBase:
 |  
 |  __add__(...)
 |  
 |  __and__(...)
 |  
 |  __bool__(...)
 |  
 |  __complex__(...)
 |  
 |  __delitem__(self, key, /)
 |      Delete self[key].
 |  
 |  __div__(...)
 |  
 |  __eq__(...)
 |      Return self==value.
 |  
 |  __float__(...)
 |  
 |  __ge__(...)
 |      Return self>=value.
 |  
 |  __getitem__(self, key, /)
 |      Return self[key].
 |  
 |  __gt__(...)
 |      Return self>value.
 |  
 |  __iadd__(...)
 |  
 |  __iand__(...)
 |  
 |  __idiv__(...)
 |  
 |  __ifloordiv__(...)
 |  
 |  __ilshift__(...)
 |  
 |  __imod__(...)
 |  
 |  __imul__(...)
 |  
 |  __index__(...)
 |  
 |  __int__(...)
 |  
 |  __invert__(...)
 |  
 |  __ior__(...)
 |  
 |  __irshift__(...)
 |  
 |  __isub__(...)
 |  
 |  __ixor__(...)
 |  
 |  __le__(...)
 |      Return self<=value.
 |  
 |  __long__(...)
 |  
 |  __lshift__(...)
 |  
 |  __lt__(...)
 |      Return self<value.
 |  
 |  __matmul__(...)
 |  
 |  __mod__(...)
 |  
 |  __mul__(...)
 |  
 |  __ne__(...)
 |      Return self!=value.
 |  
 |  __nonzero__(...)
 |  
 |  __or__(...)
 |      Return self|value.
 |  
 |  __radd__(...)
 |  
 |  __rand__(...)
 |  
 |  __rmul__(...)
 |  
 |  __ror__(...)
 |      Return value|self.
 |  
 |  __rshift__(...)
 |  
 |  __rxor__(...)
 |  
 |  __setitem__(self, key, value, /)
 |      Set self[key] to value.
 |  
 |  __sub__(...)
 |  
 |  __truediv__(...)
 |  
 |  __xor__(...)
 |  
 |  abs(...)
 |      abs() -> Tensor
 |      
 |      See :func:`torch.abs`
 |  
 |  abs_(...)
 |      abs_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.abs`
 |  
 |  absolute(...)
 |      absolute() -> Tensor
 |      
 |      Alias for :func:`abs`
 |  
 |  absolute_(...)
 |      absolute_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.absolute`
 |      Alias for :func:`abs_`
 |  
 |  acos(...)
 |      acos() -> Tensor
 |      
 |      See :func:`torch.acos`
 |  
 |  acos_(...)
 |      acos_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.acos`
 |  
 |  acosh(...)
 |      acosh() -> Tensor
 |      
 |      See :func:`torch.acosh`
 |  
 |  acosh_(...)
 |      acosh_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.acosh`
 |  
 |  add(...)
 |      add(other, *, alpha=1) -> Tensor
 |      
 |      Add a scalar or tensor to :attr:`self` tensor. If both :attr:`alpha`
 |      and :attr:`other` are specified, each element of :attr:`other` is scaled by
 |      :attr:`alpha` before being used.
 |      
 |      When :attr:`other` is a tensor, the shape of :attr:`other` must be
 |      :ref:`broadcastable <broadcasting-semantics>` with the shape of the underlying
 |      tensor
 |      
 |      See :func:`torch.add`
 |  
 |  add_(...)
 |      add_(other, *, alpha=1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.add`
 |  
 |  addbmm(...)
 |      addbmm(batch1, batch2, *, beta=1, alpha=1) -> Tensor
 |      
 |      See :func:`torch.addbmm`
 |  
 |  addbmm_(...)
 |      addbmm_(batch1, batch2, *, beta=1, alpha=1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.addbmm`
 |  
 |  addcdiv(...)
 |      addcdiv(tensor1, tensor2, *, value=1) -> Tensor
 |      
 |      See :func:`torch.addcdiv`
 |  
 |  addcdiv_(...)
 |      addcdiv_(tensor1, tensor2, *, value=1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.addcdiv`
 |  
 |  addcmul(...)
 |      addcmul(tensor1, tensor2, *, value=1) -> Tensor
 |      
 |      See :func:`torch.addcmul`
 |  
 |  addcmul_(...)
 |      addcmul_(tensor1, tensor2, *, value=1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.addcmul`
 |  
 |  addmm(...)
 |      addmm(mat1, mat2, *, beta=1, alpha=1) -> Tensor
 |      
 |      See :func:`torch.addmm`
 |  
 |  addmm_(...)
 |      addmm_(mat1, mat2, *, beta=1, alpha=1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.addmm`
 |  
 |  addmv(...)
 |      addmv(mat, vec, *, beta=1, alpha=1) -> Tensor
 |      
 |      See :func:`torch.addmv`
 |  
 |  addmv_(...)
 |      addmv_(mat, vec, *, beta=1, alpha=1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.addmv`
 |  
 |  addr(...)
 |      addr(vec1, vec2, *, beta=1, alpha=1) -> Tensor
 |      
 |      See :func:`torch.addr`
 |  
 |  addr_(...)
 |      addr_(vec1, vec2, *, beta=1, alpha=1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.addr`
 |  
 |  adjoint(...)
 |      adjoint() -> Tensor
 |      
 |      Alias for :func:`adjoint`
 |  
 |  align_as(...)
 |      align_as(other) -> Tensor
 |      
 |      Permutes the dimensions of the :attr:`self` tensor to match the dimension order
 |      in the :attr:`other` tensor, adding size-one dims for any new names.
 |      
 |      This operation is useful for explicit broadcasting by names (see examples).
 |      
 |      All of the dims of :attr:`self` must be named in order to use this method.
 |      The resulting tensor is a view on the original tensor.
 |      
 |      All dimension names of :attr:`self` must be present in ``other.names``.
 |      :attr:`other` may contain named dimensions that are not in ``self.names``;
 |      the output tensor has a size-one dimension for each of those new names.
 |      
 |      To align a tensor to a specific order, use :meth:`~Tensor.align_to`.
 |      
 |      Examples::
 |      
 |          # Example 1: Applying a mask
 |          >>> mask = torch.randint(2, [127, 128], dtype=torch.bool).refine_names('W', 'H')
 |          >>> imgs = torch.randn(32, 128, 127, 3, names=('N', 'H', 'W', 'C'))
 |          >>> imgs.masked_fill_(mask.align_as(imgs), 0)
 |      
 |      
 |          # Example 2: Applying a per-channel-scale
 |          >>> def scale_channels(input, scale):
 |          >>>    scale = scale.refine_names('C')
 |          >>>    return input * scale.align_as(input)
 |      
 |          >>> num_channels = 3
 |          >>> scale = torch.randn(num_channels, names=('C',))
 |          >>> imgs = torch.rand(32, 128, 128, num_channels, names=('N', 'H', 'W', 'C'))
 |          >>> more_imgs = torch.rand(32, num_channels, 128, 128, names=('N', 'C', 'H', 'W'))
 |          >>> videos = torch.randn(3, num_channels, 128, 128, 128, names=('N', 'C', 'H', 'W', 'D'))
 |      
 |          # scale_channels is agnostic to the dimension order of the input
 |          >>> scale_channels(imgs, scale)
 |          >>> scale_channels(more_imgs, scale)
 |          >>> scale_channels(videos, scale)
 |      
 |      .. warning::
 |          The named tensor API is experimental and subject to change.
 |  
 |  all(...)
 |      all(dim=None, keepdim=False) -> Tensor
 |      
 |      See :func:`torch.all`
 |  
 |  allclose(...)
 |      allclose(other, rtol=1e-05, atol=1e-08, equal_nan=False) -> Tensor
 |      
 |      See :func:`torch.allclose`
 |  
 |  amax(...)
 |      amax(dim=None, keepdim=False) -> Tensor
 |      
 |      See :func:`torch.amax`
 |  
 |  amin(...)
 |      amin(dim=None, keepdim=False) -> Tensor
 |      
 |      See :func:`torch.amin`
 |  
 |  aminmax(...)
 |      aminmax(*, dim=None, keepdim=False) -> (Tensor min, Tensor max)
 |      
 |      See :func:`torch.aminmax`
 |  
 |  angle(...)
 |      angle() -> Tensor
 |      
 |      See :func:`torch.angle`
 |  
 |  any(...)
 |      any(dim=None, keepdim=False) -> Tensor
 |      
 |      See :func:`torch.any`
 |  
 |  apply_(...)
 |      apply_(callable) -> Tensor
 |      
 |      Applies the function :attr:`callable` to each element in the tensor, replacing
 |      each element with the value returned by :attr:`callable`.
 |      
 |      .. note::
 |      
 |          This function only works with CPU tensors and should not be used in code
 |          sections that require high performance.
 |  
 |  arccos(...)
 |      arccos() -> Tensor
 |      
 |      See :func:`torch.arccos`
 |  
 |  arccos_(...)
 |      arccos_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.arccos`
 |  
 |  arccosh(...)
 |      acosh() -> Tensor
 |      
 |      See :func:`torch.arccosh`
 |  
 |  arccosh_(...)
 |      acosh_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.arccosh`
 |  
 |  arcsin(...)
 |      arcsin() -> Tensor
 |      
 |      See :func:`torch.arcsin`
 |  
 |  arcsin_(...)
 |      arcsin_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.arcsin`
 |  
 |  arcsinh(...)
 |      arcsinh() -> Tensor
 |      
 |      See :func:`torch.arcsinh`
 |  
 |  arcsinh_(...)
 |      arcsinh_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.arcsinh`
 |  
 |  arctan(...)
 |      arctan() -> Tensor
 |      
 |      See :func:`torch.arctan`
 |  
 |  arctan2(...)
 |      arctan2(other) -> Tensor
 |      
 |      See :func:`torch.arctan2`
 |  
 |  arctan2_(...)
 |      atan2_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.arctan2`
 |  
 |  arctan_(...)
 |      arctan_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.arctan`
 |  
 |  arctanh(...)
 |      arctanh() -> Tensor
 |      
 |      See :func:`torch.arctanh`
 |  
 |  arctanh_(...)
 |      arctanh_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.arctanh`
 |  
 |  argmax(...)
 |      argmax(dim=None, keepdim=False) -> LongTensor
 |      
 |      See :func:`torch.argmax`
 |  
 |  argmin(...)
 |      argmin(dim=None, keepdim=False) -> LongTensor
 |      
 |      See :func:`torch.argmin`
 |  
 |  argsort(...)
 |      argsort(dim=-1, descending=False) -> LongTensor
 |      
 |      See :func:`torch.argsort`
 |  
 |  argwhere(...)
 |      argwhere() -> Tensor
 |      
 |      See :func:`torch.argwhere`
 |  
 |  as_strided(...)
 |      as_strided(size, stride, storage_offset=None) -> Tensor
 |      
 |      See :func:`torch.as_strided`
 |  
 |  as_strided_(...)
 |      as_strided_(size, stride, storage_offset=None) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.as_strided`
 |  
 |  as_strided_scatter(...)
 |      as_strided_scatter(src, size, stride, storage_offset=None) -> Tensor
 |      
 |      See :func:`torch.as_strided_scatter`
 |  
 |  as_subclass(...)
 |      as_subclass(cls) -> Tensor
 |      
 |      Makes a ``cls`` instance with the same data pointer as ``self``. Changes
 |      in the output mirror changes in ``self``, and the output stays attached
 |      to the autograd graph. ``cls`` must be a subclass of ``Tensor``.
 |  
 |  asin(...)
 |      asin() -> Tensor
 |      
 |      See :func:`torch.asin`
 |  
 |  asin_(...)
 |      asin_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.asin`
 |  
 |  asinh(...)
 |      asinh() -> Tensor
 |      
 |      See :func:`torch.asinh`
 |  
 |  asinh_(...)
 |      asinh_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.asinh`
 |  
 |  atan(...)
 |      atan() -> Tensor
 |      
 |      See :func:`torch.atan`
 |  
 |  atan2(...)
 |      atan2(other) -> Tensor
 |      
 |      See :func:`torch.atan2`
 |  
 |  atan2_(...)
 |      atan2_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.atan2`
 |  
 |  atan_(...)
 |      atan_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.atan`
 |  
 |  atanh(...)
 |      atanh() -> Tensor
 |      
 |      See :func:`torch.atanh`
 |  
 |  atanh_(...)
 |      atanh_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.atanh`
 |  
 |  baddbmm(...)
 |      baddbmm(batch1, batch2, *, beta=1, alpha=1) -> Tensor
 |      
 |      See :func:`torch.baddbmm`
 |  
 |  baddbmm_(...)
 |      baddbmm_(batch1, batch2, *, beta=1, alpha=1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.baddbmm`
 |  
 |  bernoulli(...)
 |      bernoulli(*, generator=None) -> Tensor
 |      
 |      Returns a result tensor where each :math:`\texttt{result[i]}` is independently
 |      sampled from :math:`\text{Bernoulli}(\texttt{self[i]})`. :attr:`self` must have
 |      floating point ``dtype``, and the result will have the same ``dtype``.
 |      
 |      See :func:`torch.bernoulli`
 |  
 |  bernoulli_(...)
 |      bernoulli_(p=0.5, *, generator=None) -> Tensor
 |      
 |      Fills each location of :attr:`self` with an independent sample from
 |      :math:`\text{Bernoulli}(\texttt{p})`. :attr:`self` can have integral
 |      ``dtype``.
 |      
 |      :attr:`p` should either be a scalar or tensor containing probabilities to be
 |      used for drawing the binary random number.
 |      
 |      If it is a tensor, the :math:`\text{i}^{th}` element of :attr:`self` tensor
 |      will be set to a value sampled from
 |      :math:`\text{Bernoulli}(\texttt{p\_tensor[i]})`. In this case `p` must have
 |      floating point ``dtype``.
 |      
 |      See also :meth:`~Tensor.bernoulli` and :func:`torch.bernoulli`
 |  
 |  bfloat16(...)
 |      bfloat16(memory_format=torch.preserve_format) -> Tensor
 |      ``self.bfloat16()`` is equivalent to ``self.to(torch.bfloat16)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  bincount(...)
 |      bincount(weights=None, minlength=0) -> Tensor
 |      
 |      See :func:`torch.bincount`
 |  
 |  bitwise_and(...)
 |      bitwise_and() -> Tensor
 |      
 |      See :func:`torch.bitwise_and`
 |  
 |  bitwise_and_(...)
 |      bitwise_and_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.bitwise_and`
 |  
 |  bitwise_left_shift(...)
 |      bitwise_left_shift(other) -> Tensor
 |      
 |      See :func:`torch.bitwise_left_shift`
 |  
 |  bitwise_left_shift_(...)
 |      bitwise_left_shift_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.bitwise_left_shift`
 |  
 |  bitwise_not(...)
 |      bitwise_not() -> Tensor
 |      
 |      See :func:`torch.bitwise_not`
 |  
 |  bitwise_not_(...)
 |      bitwise_not_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.bitwise_not`
 |  
 |  bitwise_or(...)
 |      bitwise_or() -> Tensor
 |      
 |      See :func:`torch.bitwise_or`
 |  
 |  bitwise_or_(...)
 |      bitwise_or_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.bitwise_or`
 |  
 |  bitwise_right_shift(...)
 |      bitwise_right_shift(other) -> Tensor
 |      
 |      See :func:`torch.bitwise_right_shift`
 |  
 |  bitwise_right_shift_(...)
 |      bitwise_right_shift_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.bitwise_right_shift`
 |  
 |  bitwise_xor(...)
 |      bitwise_xor() -> Tensor
 |      
 |      See :func:`torch.bitwise_xor`
 |  
 |  bitwise_xor_(...)
 |      bitwise_xor_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.bitwise_xor`
 |  
 |  bmm(...)
 |      bmm(batch2) -> Tensor
 |      
 |      See :func:`torch.bmm`
 |  
 |  bool(...)
 |      bool(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.bool()`` is equivalent to ``self.to(torch.bool)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  broadcast_to(...)
 |      broadcast_to(shape) -> Tensor
 |      
 |      See :func:`torch.broadcast_to`.
 |  
 |  byte(...)
 |      byte(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.byte()`` is equivalent to ``self.to(torch.uint8)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  cauchy_(...)
 |      cauchy_(median=0, sigma=1, *, generator=None) -> Tensor
 |      
 |      Fills the tensor with numbers drawn from the Cauchy distribution:
 |      
 |      .. math::
 |      
 |          f(x) = \dfrac{1}{\pi} \dfrac{\sigma}{(x - \text{median})^2 + \sigma^2}
 |      
 |      .. note::
 |        Sigma (:math:`\sigma`) is used to denote the scale parameter in Cauchy distribution.
 |  
 |  ccol_indices(...)
 |  
 |  cdouble(...)
 |      cdouble(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.cdouble()`` is equivalent to ``self.to(torch.complex128)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  ceil(...)
 |      ceil() -> Tensor
 |      
 |      See :func:`torch.ceil`
 |  
 |  ceil_(...)
 |      ceil_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.ceil`
 |  
 |  cfloat(...)
 |      cfloat(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.cfloat()`` is equivalent to ``self.to(torch.complex64)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  chalf(...)
 |      chalf(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.chalf()`` is equivalent to ``self.to(torch.complex32)``. See :func:`to`.
 |      
 |      Args:
 |           memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  char(...)
 |      char(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.char()`` is equivalent to ``self.to(torch.int8)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  cholesky(...)
 |      cholesky(upper=False) -> Tensor
 |      
 |      See :func:`torch.cholesky`
 |  
 |  cholesky_inverse(...)
 |      cholesky_inverse(upper=False) -> Tensor
 |      
 |      See :func:`torch.cholesky_inverse`
 |  
 |  cholesky_solve(...)
 |      cholesky_solve(input2, upper=False) -> Tensor
 |      
 |      See :func:`torch.cholesky_solve`
 |  
 |  chunk(...)
 |      chunk(chunks, dim=0) -> List of Tensors
 |      
 |      See :func:`torch.chunk`
 |  
 |  clamp(...)
 |      clamp(min=None, max=None) -> Tensor
 |      
 |      See :func:`torch.clamp`
 |  
 |  clamp_(...)
 |      clamp_(min=None, max=None) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.clamp`
 |  
 |  clamp_max(...)
 |  
 |  clamp_max_(...)
 |  
 |  clamp_min(...)
 |  
 |  clamp_min_(...)
 |  
 |  clip(...)
 |      clip(min=None, max=None) -> Tensor
 |      
 |      Alias for :meth:`~Tensor.clamp`.
 |  
 |  clip_(...)
 |      clip_(min=None, max=None) -> Tensor
 |      
 |      Alias for :meth:`~Tensor.clamp_`.
 |  
 |  clone(...)
 |      clone(*, memory_format=torch.preserve_format) -> Tensor
 |      
 |      See :func:`torch.clone`
 |  
 |  coalesce(...)
 |      coalesce() -> Tensor
 |      
 |      Returns a coalesced copy of :attr:`self` if :attr:`self` is an
 |      :ref:`uncoalesced tensor <sparse-uncoalesced-coo-docs>`.
 |      
 |      Returns :attr:`self` if :attr:`self` is a coalesced tensor.
 |      
 |      .. warning::
 |        Throws an error if :attr:`self` is not a sparse COO tensor.
 |  
 |  col_indices(...)
 |      col_indices() -> IntTensor
 |      
 |      Returns the tensor containing the column indices of the :attr:`self`
 |      tensor when :attr:`self` is a sparse CSR tensor of layout ``sparse_csr``.
 |      The ``col_indices`` tensor is strictly of shape (:attr:`self`.nnz())
 |      and of type ``int32`` or ``int64``.  When using MKL routines such as sparse
 |      matrix multiplication, it is necessary to use ``int32`` indexing in order
 |      to avoid downcasting and potentially losing information.
 |      
 |      Example::
 |          >>> csr = torch.eye(5,5).to_sparse_csr()
 |          >>> csr.col_indices()
 |          tensor([0, 1, 2, 3, 4], dtype=torch.int32)
 |  
 |  conj(...)
 |      conj() -> Tensor
 |      
 |      See :func:`torch.conj`
 |  
 |  conj_physical(...)
 |      conj_physical() -> Tensor
 |      
 |      See :func:`torch.conj_physical`
 |  
 |  conj_physical_(...)
 |      conj_physical_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.conj_physical`
 |  
 |  contiguous(...)
 |      contiguous(memory_format=torch.contiguous_format) -> Tensor
 |      
 |      Returns a contiguous in memory tensor containing the same data as :attr:`self` tensor. If
 |      :attr:`self` tensor is already in the specified memory format, this function returns the
 |      :attr:`self` tensor.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.contiguous_format``.
 |  
 |  copy_(...)
 |      copy_(src, non_blocking=False) -> Tensor
 |      
 |      Copies the elements from :attr:`src` into :attr:`self` tensor and returns
 |      :attr:`self`.
 |      
 |      The :attr:`src` tensor must be :ref:`broadcastable <broadcasting-semantics>`
 |      with the :attr:`self` tensor. It may be of a different data type or reside on a
 |      different device.
 |      
 |      Args:
 |          src (Tensor): the source tensor to copy from
 |          non_blocking (bool): if ``True`` and this copy is between CPU and GPU,
 |              the copy may occur asynchronously with respect to the host. For other
 |              cases, this argument has no effect.
 |  
 |  copysign(...)
 |      copysign(other) -> Tensor
 |      
 |      See :func:`torch.copysign`
 |  
 |  copysign_(...)
 |      copysign_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.copysign`
 |  
 |  corrcoef(...)
 |      corrcoef() -> Tensor
 |      
 |      See :func:`torch.corrcoef`
 |  
 |  cos(...)
 |      cos() -> Tensor
 |      
 |      See :func:`torch.cos`
 |  
 |  cos_(...)
 |      cos_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.cos`
 |  
 |  cosh(...)
 |      cosh() -> Tensor
 |      
 |      See :func:`torch.cosh`
 |  
 |  cosh_(...)
 |      cosh_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.cosh`
 |  
 |  count_nonzero(...)
 |      count_nonzero(dim=None) -> Tensor
 |      
 |      See :func:`torch.count_nonzero`
 |  
 |  cov(...)
 |      cov(*, correction=1, fweights=None, aweights=None) -> Tensor
 |      
 |      See :func:`torch.cov`
 |  
 |  cpu(...)
 |      cpu(memory_format=torch.preserve_format) -> Tensor
 |      
 |      Returns a copy of this object in CPU memory.
 |      
 |      If this object is already in CPU memory and on the correct device,
 |      then no copy is performed and the original object is returned.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  cross(...)
 |      cross(other, dim=None) -> Tensor
 |      
 |      See :func:`torch.cross`
 |  
 |  crow_indices(...)
 |      crow_indices() -> IntTensor
 |      
 |      Returns the tensor containing the compressed row indices of the :attr:`self`
 |      tensor when :attr:`self` is a sparse CSR tensor of layout ``sparse_csr``.
 |      The ``crow_indices`` tensor is strictly of shape (:attr:`self`.size(0) + 1)
 |      and of type ``int32`` or ``int64``. When using MKL routines such as sparse
 |      matrix multiplication, it is necessary to use ``int32`` indexing in order
 |      to avoid downcasting and potentially losing information.
 |      
 |      Example::
 |          >>> csr = torch.eye(5,5).to_sparse_csr()
 |          >>> csr.crow_indices()
 |          tensor([0, 1, 2, 3, 4, 5], dtype=torch.int32)
 |  
 |  cuda(...)
 |      cuda(device=None, non_blocking=False, memory_format=torch.preserve_format) -> Tensor
 |      
 |      Returns a copy of this object in CUDA memory.
 |      
 |      If this object is already in CUDA memory and on the correct device,
 |      then no copy is performed and the original object is returned.
 |      
 |      Args:
 |          device (:class:`torch.device`): The destination GPU device.
 |              Defaults to the current CUDA device.
 |          non_blocking (bool): If ``True`` and the source is in pinned memory,
 |              the copy will be asynchronous with respect to the host.
 |              Otherwise, the argument has no effect. Default: ``False``.
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  cummax(...)
 |      cummax(dim) -> (Tensor, Tensor)
 |      
 |      See :func:`torch.cummax`
 |  
 |  cummin(...)
 |      cummin(dim) -> (Tensor, Tensor)
 |      
 |      See :func:`torch.cummin`
 |  
 |  cumprod(...)
 |      cumprod(dim, dtype=None) -> Tensor
 |      
 |      See :func:`torch.cumprod`
 |  
 |  cumprod_(...)
 |      cumprod_(dim, dtype=None) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.cumprod`
 |  
 |  cumsum(...)
 |      cumsum(dim, dtype=None) -> Tensor
 |      
 |      See :func:`torch.cumsum`
 |  
 |  cumsum_(...)
 |      cumsum_(dim, dtype=None) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.cumsum`
 |  
 |  data_ptr(...)
 |      data_ptr() -> int
 |      
 |      Returns the address of the first element of :attr:`self` tensor.
 |  
 |  deg2rad(...)
 |      deg2rad() -> Tensor
 |      
 |      See :func:`torch.deg2rad`
 |  
 |  deg2rad_(...)
 |      deg2rad_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.deg2rad`
 |  
 |  dense_dim(...)
 |      dense_dim() -> int
 |      
 |      Return the number of dense dimensions in a :ref:`sparse tensor <sparse-docs>` :attr:`self`.
 |      
 |      .. note::
 |        Returns ``len(self.shape)`` if :attr:`self` is not a sparse tensor.
 |      
 |      See also :meth:`Tensor.sparse_dim` and :ref:`hybrid tensors <sparse-hybrid-coo-docs>`.
 |  
 |  dequantize(...)
 |      dequantize() -> Tensor
 |      
 |      Given a quantized Tensor, dequantize it and return the dequantized float Tensor.
 |  
 |  det(...)
 |      det() -> Tensor
 |      
 |      See :func:`torch.det`
 |  
 |  diag(...)
 |      diag(diagonal=0) -> Tensor
 |      
 |      See :func:`torch.diag`
 |  
 |  diag_embed(...)
 |      diag_embed(offset=0, dim1=-2, dim2=-1) -> Tensor
 |      
 |      See :func:`torch.diag_embed`
 |  
 |  diagflat(...)
 |      diagflat(offset=0) -> Tensor
 |      
 |      See :func:`torch.diagflat`
 |  
 |  diagonal(...)
 |      diagonal(offset=0, dim1=0, dim2=1) -> Tensor
 |      
 |      See :func:`torch.diagonal`
 |  
 |  diagonal_scatter(...)
 |      diagonal_scatter(src, offset=0, dim1=0, dim2=1) -> Tensor
 |      
 |      See :func:`torch.diagonal_scatter`
 |  
 |  diff(...)
 |      diff(n=1, dim=-1, prepend=None, append=None) -> Tensor
 |      
 |      See :func:`torch.diff`
 |  
 |  digamma(...)
 |      digamma() -> Tensor
 |      
 |      See :func:`torch.digamma`
 |  
 |  digamma_(...)
 |      digamma_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.digamma`
 |  
 |  dim(...)
 |      dim() -> int
 |      
 |      Returns the number of dimensions of :attr:`self` tensor.
 |  
 |  dist(...)
 |      dist(other, p=2) -> Tensor
 |      
 |      See :func:`torch.dist`
 |  
 |  div(...)
 |      div(value, *, rounding_mode=None) -> Tensor
 |      
 |      See :func:`torch.div`
 |  
 |  div_(...)
 |      div_(value, *, rounding_mode=None) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.div`
 |  
 |  divide(...)
 |      divide(value, *, rounding_mode=None) -> Tensor
 |      
 |      See :func:`torch.divide`
 |  
 |  divide_(...)
 |      divide_(value, *, rounding_mode=None) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.divide`
 |  
 |  dot(...)
 |      dot(other) -> Tensor
 |      
 |      See :func:`torch.dot`
 |  
 |  double(...)
 |      double(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.double()`` is equivalent to ``self.to(torch.float64)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  dsplit(...)
 |      dsplit(split_size_or_sections) -> List of Tensors
 |      
 |      See :func:`torch.dsplit`
 |  
 |  element_size(...)
 |      element_size() -> int
 |      
 |      Returns the size in bytes of an individual element.
 |      
 |      Example::
 |      
 |          >>> torch.tensor([]).element_size()
 |          4
 |          >>> torch.tensor([], dtype=torch.uint8).element_size()
 |          1
 |  
 |  eq(...)
 |      eq(other) -> Tensor
 |      
 |      See :func:`torch.eq`
 |  
 |  eq_(...)
 |      eq_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.eq`
 |  
 |  equal(...)
 |      equal(other) -> bool
 |      
 |      See :func:`torch.equal`
 |  
 |  erf(...)
 |      erf() -> Tensor
 |      
 |      See :func:`torch.erf`
 |  
 |  erf_(...)
 |      erf_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.erf`
 |  
 |  erfc(...)
 |      erfc() -> Tensor
 |      
 |      See :func:`torch.erfc`
 |  
 |  erfc_(...)
 |      erfc_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.erfc`
 |  
 |  erfinv(...)
 |      erfinv() -> Tensor
 |      
 |      See :func:`torch.erfinv`
 |  
 |  erfinv_(...)
 |      erfinv_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.erfinv`
 |  
 |  exp(...)
 |      exp() -> Tensor
 |      
 |      See :func:`torch.exp`
 |  
 |  exp2(...)
 |      exp2() -> Tensor
 |      
 |      See :func:`torch.exp2`
 |  
 |  exp2_(...)
 |      exp2_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.exp2`
 |  
 |  exp_(...)
 |      exp_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.exp`
 |  
 |  expand(...)
 |      expand(*sizes) -> Tensor
 |      
 |      Returns a new view of the :attr:`self` tensor with singleton dimensions expanded
 |      to a larger size.
 |      
 |      Passing -1 as the size for a dimension means not changing the size of
 |      that dimension.
 |      
 |      Tensor can be also expanded to a larger number of dimensions, and the
 |      new ones will be appended at the front. For the new dimensions, the
 |      size cannot be set to -1.
 |      
 |      Expanding a tensor does not allocate new memory, but only creates a
 |      new view on the existing tensor where a dimension of size one is
 |      expanded to a larger size by setting the ``stride`` to 0. Any dimension
 |      of size 1 can be expanded to an arbitrary value without allocating new
 |      memory.
 |      
 |      Args:
 |          *sizes (torch.Size or int...): the desired expanded size
 |      
 |      .. warning::
 |      
 |          More than one element of an expanded tensor may refer to a single
 |          memory location. As a result, in-place operations (especially ones that
 |          are vectorized) may result in incorrect behavior. If you need to write
 |          to the tensors, please clone them first.
 |      
 |      Example::
 |      
 |          >>> x = torch.tensor([[1], [2], [3]])
 |          >>> x.size()
 |          torch.Size([3, 1])
 |          >>> x.expand(3, 4)
 |          tensor([[ 1,  1,  1,  1],
 |                  [ 2,  2,  2,  2],
 |                  [ 3,  3,  3,  3]])
 |          >>> x.expand(-1, 4)   # -1 means not changing the size of that dimension
 |          tensor([[ 1,  1,  1,  1],
 |                  [ 2,  2,  2,  2],
 |                  [ 3,  3,  3,  3]])
 |  
 |  expand_as(...)
 |      expand_as(other) -> Tensor
 |      
 |      Expand this tensor to the same size as :attr:`other`.
 |      ``self.expand_as(other)`` is equivalent to ``self.expand(other.size())``.
 |      
 |      Please see :meth:`~Tensor.expand` for more information about ``expand``.
 |      
 |      Args:
 |          other (:class:`torch.Tensor`): The result tensor has the same size
 |              as :attr:`other`.
 |  
 |  expm1(...)
 |      expm1() -> Tensor
 |      
 |      See :func:`torch.expm1`
 |  
 |  expm1_(...)
 |      expm1_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.expm1`
 |  
 |  exponential_(...)
 |      exponential_(lambd=1, *, generator=None) -> Tensor
 |      
 |      Fills :attr:`self` tensor with elements drawn from the PDF (probability density function):
 |      
 |      .. math::
 |      
 |          f(x) = \lambda e^{-\lambda x}, x > 0
 |      
 |      .. note::
 |        In probability theory, exponential distribution is supported on interval [0, :math:`\inf`) (i.e., :math:`x >= 0`)
 |        implying that zero can be sampled from the exponential distribution.
 |        However, :func:`torch.Tensor.exponential_` does not sample zero,
 |        which means that its actual support is the interval (0, :math:`\inf`).
 |      
 |        Note that :func:`torch.distributions.exponential.Exponential` is supported on the interval [0, :math:`\inf`) and can sample zero.
 |  
 |  fill_(...)
 |      fill_(value) -> Tensor
 |      
 |      Fills :attr:`self` tensor with the specified value.
 |  
 |  fill_diagonal_(...)
 |      fill_diagonal_(fill_value, wrap=False) -> Tensor
 |      
 |      Fill the main diagonal of a tensor that has at least 2-dimensions.
 |      When dims>2, all dimensions of input must be of equal length.
 |      This function modifies the input tensor in-place, and returns the input tensor.
 |      
 |      Arguments:
 |          fill_value (Scalar): the fill value
 |          wrap (bool): the diagonal 'wrapped' after N columns for tall matrices.
 |      
 |      Example::
 |      
 |          >>> a = torch.zeros(3, 3)
 |          >>> a.fill_diagonal_(5)
 |          tensor([[5., 0., 0.],
 |                  [0., 5., 0.],
 |                  [0., 0., 5.]])
 |          >>> b = torch.zeros(7, 3)
 |          >>> b.fill_diagonal_(5)
 |          tensor([[5., 0., 0.],
 |                  [0., 5., 0.],
 |                  [0., 0., 5.],
 |                  [0., 0., 0.],
 |                  [0., 0., 0.],
 |                  [0., 0., 0.],
 |                  [0., 0., 0.]])
 |          >>> c = torch.zeros(7, 3)
 |          >>> c.fill_diagonal_(5, wrap=True)
 |          tensor([[5., 0., 0.],
 |                  [0., 5., 0.],
 |                  [0., 0., 5.],
 |                  [0., 0., 0.],
 |                  [5., 0., 0.],
 |                  [0., 5., 0.],
 |                  [0., 0., 5.]])
 |  
 |  fix(...)
 |      fix() -> Tensor
 |      
 |      See :func:`torch.fix`.
 |  
 |  fix_(...)
 |      fix_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.fix`
 |  
 |  flatten(...)
 |      flatten(start_dim=0, end_dim=-1) -> Tensor
 |      
 |      See :func:`torch.flatten`
 |  
 |  flip(...)
 |      flip(dims) -> Tensor
 |      
 |      See :func:`torch.flip`
 |  
 |  fliplr(...)
 |      fliplr() -> Tensor
 |      
 |      See :func:`torch.fliplr`
 |  
 |  flipud(...)
 |      flipud() -> Tensor
 |      
 |      See :func:`torch.flipud`
 |  
 |  float(...)
 |      float(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.float()`` is equivalent to ``self.to(torch.float32)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  float_power(...)
 |      float_power(exponent) -> Tensor
 |      
 |      See :func:`torch.float_power`
 |  
 |  float_power_(...)
 |      float_power_(exponent) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.float_power`
 |  
 |  floor(...)
 |      floor() -> Tensor
 |      
 |      See :func:`torch.floor`
 |  
 |  floor_(...)
 |      floor_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.floor`
 |  
 |  floor_divide(...)
 |      floor_divide(value) -> Tensor
 |      
 |      See :func:`torch.floor_divide`
 |  
 |  floor_divide_(...)
 |      floor_divide_(value) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.floor_divide`
 |  
 |  fmax(...)
 |      fmax(other) -> Tensor
 |      
 |      See :func:`torch.fmax`
 |  
 |  fmin(...)
 |      fmin(other) -> Tensor
 |      
 |      See :func:`torch.fmin`
 |  
 |  fmod(...)
 |      fmod(divisor) -> Tensor
 |      
 |      See :func:`torch.fmod`
 |  
 |  fmod_(...)
 |      fmod_(divisor) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.fmod`
 |  
 |  frac(...)
 |      frac() -> Tensor
 |      
 |      See :func:`torch.frac`
 |  
 |  frac_(...)
 |      frac_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.frac`
 |  
 |  frexp(...)
 |      frexp(input) -> (Tensor mantissa, Tensor exponent)
 |      
 |      See :func:`torch.frexp`
 |  
 |  gather(...)
 |      gather(dim, index) -> Tensor
 |      
 |      See :func:`torch.gather`
 |  
 |  gcd(...)
 |      gcd(other) -> Tensor
 |      
 |      See :func:`torch.gcd`
 |  
 |  gcd_(...)
 |      gcd_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.gcd`
 |  
 |  ge(...)
 |      ge(other) -> Tensor
 |      
 |      See :func:`torch.ge`.
 |  
 |  ge_(...)
 |      ge_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.ge`.
 |  
 |  geometric_(...)
 |      geometric_(p, *, generator=None) -> Tensor
 |      
 |      Fills :attr:`self` tensor with elements drawn from the geometric distribution:
 |      
 |      .. math::
 |      
 |          P(X=k) = (1 - p)^{k - 1} p, k = 1, 2, ...
 |      
 |      .. note::
 |        :func:`torch.Tensor.geometric_` `k`-th trial is the first success hence draws samples in :math:`\{1, 2, \ldots\}`, whereas
 |        :func:`torch.distributions.geometric.Geometric` :math:`(k+1)`-th trial is the first success
 |        hence draws samples in :math:`\{0, 1, \ldots\}`.
 |  
 |  geqrf(...)
 |      geqrf() -> (Tensor, Tensor)
 |      
 |      See :func:`torch.geqrf`
 |  
 |  ger(...)
 |      ger(vec2) -> Tensor
 |      
 |      See :func:`torch.ger`
 |  
 |  get_device(...)
 |      get_device() -> Device ordinal (Integer)
 |      
 |      For CUDA tensors, this function returns the device ordinal of the GPU on which the tensor resides.
 |      For CPU tensors, this function returns `-1`.
 |      
 |      Example::
 |      
 |          >>> x = torch.randn(3, 4, 5, device='cuda:0')
 |          >>> x.get_device()
 |          0
 |          >>> x.cpu().get_device()
 |          -1
 |  
 |  greater(...)
 |      greater(other) -> Tensor
 |      
 |      See :func:`torch.greater`.
 |  
 |  greater_(...)
 |      greater_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.greater`.
 |  
 |  greater_equal(...)
 |      greater_equal(other) -> Tensor
 |      
 |      See :func:`torch.greater_equal`.
 |  
 |  greater_equal_(...)
 |      greater_equal_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.greater_equal`.
 |  
 |  gt(...)
 |      gt(other) -> Tensor
 |      
 |      See :func:`torch.gt`.
 |  
 |  gt_(...)
 |      gt_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.gt`.
 |  
 |  half(...)
 |      half(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.half()`` is equivalent to ``self.to(torch.float16)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  hardshrink(...)
 |      hardshrink(lambd=0.5) -> Tensor
 |      
 |      See :func:`torch.nn.functional.hardshrink`
 |  
 |  has_names(...)
 |      Is ``True`` if any of this tensor's dimensions are named. Otherwise, is ``False``.
 |  
 |  heaviside(...)
 |      heaviside(values) -> Tensor
 |      
 |      See :func:`torch.heaviside`
 |  
 |  heaviside_(...)
 |      heaviside_(values) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.heaviside`
 |  
 |  histc(...)
 |      histc(bins=100, min=0, max=0) -> Tensor
 |      
 |      See :func:`torch.histc`
 |  
 |  histogram(...)
 |      histogram(input, bins, *, range=None, weight=None, density=False) -> (Tensor, Tensor)
 |      
 |      See :func:`torch.histogram`
 |  
 |  hsplit(...)
 |      hsplit(split_size_or_sections) -> List of Tensors
 |      
 |      See :func:`torch.hsplit`
 |  
 |  hypot(...)
 |      hypot(other) -> Tensor
 |      
 |      See :func:`torch.hypot`
 |  
 |  hypot_(...)
 |      hypot_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.hypot`
 |  
 |  i0(...)
 |      i0() -> Tensor
 |      
 |      See :func:`torch.i0`
 |  
 |  i0_(...)
 |      i0_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.i0`
 |  
 |  igamma(...)
 |      igamma(other) -> Tensor
 |      
 |      See :func:`torch.igamma`
 |  
 |  igamma_(...)
 |      igamma_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.igamma`
 |  
 |  igammac(...)
 |      igammac(other) -> Tensor
 |      See :func:`torch.igammac`
 |  
 |  igammac_(...)
 |      igammac_(other) -> Tensor
 |      In-place version of :meth:`~Tensor.igammac`
 |  
 |  index_add(...)
 |      index_add(dim, index, source, *, alpha=1) -> Tensor
 |      
 |      Out-of-place version of :meth:`torch.Tensor.index_add_`.
 |  
 |  index_add_(...)
 |      index_add_(dim, index, source, *, alpha=1) -> Tensor
 |      
 |      Accumulate the elements of :attr:`alpha` times ``source`` into the :attr:`self`
 |      tensor by adding to the indices in the order given in :attr:`index`. For example,
 |      if ``dim == 0``, ``index[i] == j``, and ``alpha=-1``, then the ``i``\ th row of
 |      ``source`` is subtracted from the ``j``\ th row of :attr:`self`.
 |      
 |      The :attr:`dim`\ th dimension of ``source`` must have the same size as the
 |      length of :attr:`index` (which must be a vector), and all other dimensions must
 |      match :attr:`self`, or an error will be raised.
 |      
 |      For a 3-D tensor the output is given as::
 |      
 |          self[index[i], :, :] += alpha * src[i, :, :]  # if dim == 0
 |          self[:, index[i], :] += alpha * src[:, i, :]  # if dim == 1
 |          self[:, :, index[i]] += alpha * src[:, :, i]  # if dim == 2
 |      
 |      Note:
 |          This operation may behave nondeterministically when given tensors on a CUDA device. See :doc:`/notes/randomness` for more information.
 |      
 |      Args:
 |          dim (int): dimension along which to index
 |          index (Tensor): indices of ``source`` to select from,
 |                  should have dtype either `torch.int64` or `torch.int32`
 |          source (Tensor): the tensor containing values to add
 |      
 |      Keyword args:
 |          alpha (Number): the scalar multiplier for ``source``
 |      
 |      Example::
 |      
 |          >>> x = torch.ones(5, 3)
 |          >>> t = torch.tensor([[1, 2, 3], [4, 5, 6], [7, 8, 9]], dtype=torch.float)
 |          >>> index = torch.tensor([0, 4, 2])
 |          >>> x.index_add_(0, index, t)
 |          tensor([[  2.,   3.,   4.],
 |                  [  1.,   1.,   1.],
 |                  [  8.,   9.,  10.],
 |                  [  1.,   1.,   1.],
 |                  [  5.,   6.,   7.]])
 |          >>> x.index_add_(0, index, t, alpha=-1)
 |          tensor([[  1.,   1.,   1.],
 |                  [  1.,   1.,   1.],
 |                  [  1.,   1.,   1.],
 |                  [  1.,   1.,   1.],
 |                  [  1.,   1.,   1.]])
 |  
 |  index_copy(...)
 |      index_copy(dim, index, tensor2) -> Tensor
 |      
 |      Out-of-place version of :meth:`torch.Tensor.index_copy_`.
 |  
 |  index_copy_(...)
 |      index_copy_(dim, index, tensor) -> Tensor
 |      
 |      Copies the elements of :attr:`tensor` into the :attr:`self` tensor by selecting
 |      the indices in the order given in :attr:`index`. For example, if ``dim == 0``
 |      and ``index[i] == j``, then the ``i``\ th row of :attr:`tensor` is copied to the
 |      ``j``\ th row of :attr:`self`.
 |      
 |      The :attr:`dim`\ th dimension of :attr:`tensor` must have the same size as the
 |      length of :attr:`index` (which must be a vector), and all other dimensions must
 |      match :attr:`self`, or an error will be raised.
 |      
 |      .. note::
 |          If :attr:`index` contains duplicate entries, multiple elements from
 |          :attr:`tensor` will be copied to the same index of :attr:`self`. The result
 |          is nondeterministic since it depends on which copy occurs last.
 |      
 |      Args:
 |          dim (int): dimension along which to index
 |          index (LongTensor): indices of :attr:`tensor` to select from
 |          tensor (Tensor): the tensor containing values to copy
 |      
 |      Example::
 |      
 |          >>> x = torch.zeros(5, 3)
 |          >>> t = torch.tensor([[1, 2, 3], [4, 5, 6], [7, 8, 9]], dtype=torch.float)
 |          >>> index = torch.tensor([0, 4, 2])
 |          >>> x.index_copy_(0, index, t)
 |          tensor([[ 1.,  2.,  3.],
 |                  [ 0.,  0.,  0.],
 |                  [ 7.,  8.,  9.],
 |                  [ 0.,  0.,  0.],
 |                  [ 4.,  5.,  6.]])
 |  
 |  index_fill(...)
 |      index_fill(dim, index, value) -> Tensor
 |      
 |      Out-of-place version of :meth:`torch.Tensor.index_fill_`.
 |  
 |  index_fill_(...)
 |      index_fill_(dim, index, value) -> Tensor
 |      
 |      Fills the elements of the :attr:`self` tensor with value :attr:`value` by
 |      selecting the indices in the order given in :attr:`index`.
 |      
 |      Args:
 |          dim (int): dimension along which to index
 |          index (LongTensor): indices of :attr:`self` tensor to fill in
 |          value (float): the value to fill with
 |      
 |      Example::
 |          >>> x = torch.tensor([[1, 2, 3], [4, 5, 6], [7, 8, 9]], dtype=torch.float)
 |          >>> index = torch.tensor([0, 2])
 |          >>> x.index_fill_(1, index, -1)
 |          tensor([[-1.,  2., -1.],
 |                  [-1.,  5., -1.],
 |                  [-1.,  8., -1.]])
 |  
 |  index_put(...)
 |      index_put(indices, values, accumulate=False) -> Tensor
 |      
 |      Out-place version of :meth:`~Tensor.index_put_`.
 |  
 |  index_put_(...)
 |      index_put_(indices, values, accumulate=False) -> Tensor
 |      
 |      Puts values from the tensor :attr:`values` into the tensor :attr:`self` using
 |      the indices specified in :attr:`indices` (which is a tuple of Tensors). The
 |      expression ``tensor.index_put_(indices, values)`` is equivalent to
 |      ``tensor[indices] = values``. Returns :attr:`self`.
 |      
 |      If :attr:`accumulate` is ``True``, the elements in :attr:`values` are added to
 |      :attr:`self`. If accumulate is ``False``, the behavior is undefined if indices
 |      contain duplicate elements.
 |      
 |      Args:
 |          indices (tuple of LongTensor): tensors used to index into `self`.
 |          values (Tensor): tensor of same dtype as `self`.
 |          accumulate (bool): whether to accumulate into self
 |  
 |  index_reduce(...)
 |  
 |  index_reduce_(...)
 |      index_reduce_(dim, index, source, reduce, *, include_self=True) -> Tensor
 |      
 |      Accumulate the elements of ``source`` into the :attr:`self`
 |      tensor by accumulating to the indices in the order given in :attr:`index`
 |      using the reduction given by the ``reduce`` argument. For example, if ``dim == 0``,
 |      ``index[i] == j``, ``reduce == prod`` and ``include_self == True`` then the ``i``\ th
 |      row of ``source`` is multiplied by the ``j``\ th row of :attr:`self`. If
 |      :obj:`include_self="True"`, the values in the :attr:`self` tensor are included
 |      in the reduction, otherwise, rows in the :attr:`self` tensor that are accumulated
 |      to are treated as if they were filled with the reduction identites.
 |      
 |      The :attr:`dim`\ th dimension of ``source`` must have the same size as the
 |      length of :attr:`index` (which must be a vector), and all other dimensions must
 |      match :attr:`self`, or an error will be raised.
 |      
 |      For a 3-D tensor with :obj:`reduce="prod"` and :obj:`include_self=True` the
 |      output is given as::
 |      
 |          self[index[i], :, :] *= src[i, :, :]  # if dim == 0
 |          self[:, index[i], :] *= src[:, i, :]  # if dim == 1
 |          self[:, :, index[i]] *= src[:, :, i]  # if dim == 2
 |      
 |      Note:
 |          This operation may behave nondeterministically when given tensors on a CUDA device. See :doc:`/notes/randomness` for more information.
 |      
 |      .. note::
 |      
 |          This function only supports floating point tensors.
 |      
 |      .. warning::
 |      
 |          This function is in beta and may change in the near future.
 |      
 |      Args:
 |          dim (int): dimension along which to index
 |          index (Tensor): indices of ``source`` to select from,
 |              should have dtype either `torch.int64` or `torch.int32`
 |          source (FloatTensor): the tensor containing values to accumulate
 |          reduce (str): the reduction operation to apply
 |              (:obj:`"prod"`, :obj:`"mean"`, :obj:`"amax"`, :obj:`"amin"`)
 |      
 |      Keyword args:
 |          include_self (bool): whether the elements from the ``self`` tensor are
 |              included in the reduction
 |      
 |      Example::
 |      
 |          >>> x = torch.empty(5, 3).fill_(2)
 |          >>> t = torch.tensor([[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]], dtype=torch.float)
 |          >>> index = torch.tensor([0, 4, 2, 0])
 |          >>> x.index_reduce_(0, index, t, 'prod')
 |          tensor([[20., 44., 72.],
 |                  [ 2.,  2.,  2.],
 |                  [14., 16., 18.],
 |                  [ 2.,  2.,  2.],
 |                  [ 8., 10., 12.]])
 |          >>> x = torch.empty(5, 3).fill_(2)
 |          >>> x.index_reduce_(0, index, t, 'prod', include_self=False)
 |          tensor([[10., 22., 36.],
 |                  [ 2.,  2.,  2.],
 |                  [ 7.,  8.,  9.],
 |                  [ 2.,  2.,  2.],
 |                  [ 4.,  5.,  6.]])
 |  
 |  index_select(...)
 |      index_select(dim, index) -> Tensor
 |      
 |      See :func:`torch.index_select`
 |  
 |  indices(...)
 |      indices() -> Tensor
 |      
 |      Return the indices tensor of a :ref:`sparse COO tensor <sparse-coo-docs>`.
 |      
 |      .. warning::
 |        Throws an error if :attr:`self` is not a sparse COO tensor.
 |      
 |      See also :meth:`Tensor.values`.
 |      
 |      .. note::
 |        This method can only be called on a coalesced sparse tensor. See
 |        :meth:`Tensor.coalesce` for details.
 |  
 |  inner(...)
 |      inner(other) -> Tensor
 |      
 |      See :func:`torch.inner`.
 |  
 |  int(...)
 |      int(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.int()`` is equivalent to ``self.to(torch.int32)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  int_repr(...)
 |      int_repr() -> Tensor
 |      
 |      Given a quantized Tensor,
 |      ``self.int_repr()`` returns a CPU Tensor with uint8_t as data type that stores the
 |      underlying uint8_t values of the given Tensor.
 |  
 |  inverse(...)
 |      inverse() -> Tensor
 |      
 |      See :func:`torch.inverse`
 |  
 |  ipu(...)
 |      ipu(device=None, non_blocking=False, memory_format=torch.preserve_format) -> Tensor
 |      
 |      Returns a copy of this object in IPU memory.
 |      
 |      If this object is already in IPU memory and on the correct device,
 |      then no copy is performed and the original object is returned.
 |      
 |      Args:
 |          device (:class:`torch.device`): The destination IPU device.
 |              Defaults to the current IPU device.
 |          non_blocking (bool): If ``True`` and the source is in pinned memory,
 |              the copy will be asynchronous with respect to the host.
 |              Otherwise, the argument has no effect. Default: ``False``.
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  is_coalesced(...)
 |      is_coalesced() -> bool
 |      
 |      Returns ``True`` if :attr:`self` is a :ref:`sparse COO tensor
 |      <sparse-coo-docs>` that is coalesced, ``False`` otherwise.
 |      
 |      .. warning::
 |        Throws an error if :attr:`self` is not a sparse COO tensor.
 |      
 |      See :meth:`coalesce` and :ref:`uncoalesced tensors <sparse-uncoalesced-coo-docs>`.
 |  
 |  is_complex(...)
 |      is_complex() -> bool
 |      
 |      Returns True if the data type of :attr:`self` is a complex data type.
 |  
 |  is_conj(...)
 |      is_conj() -> bool
 |      
 |      Returns True if the conjugate bit of :attr:`self` is set to true.
 |  
 |  is_contiguous(...)
 |      is_contiguous(memory_format=torch.contiguous_format) -> bool
 |      
 |      Returns True if :attr:`self` tensor is contiguous in memory in the order specified
 |      by memory format.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): Specifies memory allocation
 |              order. Default: ``torch.contiguous_format``.
 |  
 |  is_distributed(...)
 |  
 |  is_floating_point(...)
 |      is_floating_point() -> bool
 |      
 |      Returns True if the data type of :attr:`self` is a floating point data type.
 |  
 |  is_inference(...)
 |      is_inference() -> bool
 |      
 |      See :func:`torch.is_inference`
 |  
 |  is_neg(...)
 |      is_neg() -> bool
 |      
 |      Returns True if the negative bit of :attr:`self` is set to true.
 |  
 |  is_nonzero(...)
 |  
 |  is_pinned(...)
 |      Returns true if this tensor resides in pinned memory.
 |  
 |  is_same_size(...)
 |  
 |  is_set_to(...)
 |      is_set_to(tensor) -> bool
 |      
 |      Returns True if both tensors are pointing to the exact same memory (same
 |      storage, offset, size and stride).
 |  
 |  is_signed(...)
 |      is_signed() -> bool
 |      
 |      Returns True if the data type of :attr:`self` is a signed data type.
 |  
 |  isclose(...)
 |      isclose(other, rtol=1e-05, atol=1e-08, equal_nan=False) -> Tensor
 |      
 |      See :func:`torch.isclose`
 |  
 |  isfinite(...)
 |      isfinite() -> Tensor
 |      
 |      See :func:`torch.isfinite`
 |  
 |  isinf(...)
 |      isinf() -> Tensor
 |      
 |      See :func:`torch.isinf`
 |  
 |  isnan(...)
 |      isnan() -> Tensor
 |      
 |      See :func:`torch.isnan`
 |  
 |  isneginf(...)
 |      isneginf() -> Tensor
 |      
 |      See :func:`torch.isneginf`
 |  
 |  isposinf(...)
 |      isposinf() -> Tensor
 |      
 |      See :func:`torch.isposinf`
 |  
 |  isreal(...)
 |      isreal() -> Tensor
 |      
 |      See :func:`torch.isreal`
 |  
 |  item(...)
 |      item() -> number
 |      
 |      Returns the value of this tensor as a standard Python number. This only works
 |      for tensors with one element. For other cases, see :meth:`~Tensor.tolist`.
 |      
 |      This operation is not differentiable.
 |      
 |      Example::
 |      
 |          >>> x = torch.tensor([1.0])
 |          >>> x.item()
 |          1.0
 |  
 |  kron(...)
 |      kron(other) -> Tensor
 |      
 |      See :func:`torch.kron`
 |  
 |  kthvalue(...)
 |      kthvalue(k, dim=None, keepdim=False) -> (Tensor, LongTensor)
 |      
 |      See :func:`torch.kthvalue`
 |  
 |  lcm(...)
 |      lcm(other) -> Tensor
 |      
 |      See :func:`torch.lcm`
 |  
 |  lcm_(...)
 |      lcm_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.lcm`
 |  
 |  ldexp(...)
 |      ldexp(other) -> Tensor
 |      
 |      See :func:`torch.ldexp`
 |  
 |  ldexp_(...)
 |      ldexp_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.ldexp`
 |  
 |  le(...)
 |      le(other) -> Tensor
 |      
 |      See :func:`torch.le`.
 |  
 |  le_(...)
 |      le_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.le`.
 |  
 |  lerp(...)
 |      lerp(end, weight) -> Tensor
 |      
 |      See :func:`torch.lerp`
 |  
 |  lerp_(...)
 |      lerp_(end, weight) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.lerp`
 |  
 |  less(...)
 |      lt(other) -> Tensor
 |      
 |      See :func:`torch.less`.
 |  
 |  less_(...)
 |      less_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.less`.
 |  
 |  less_equal(...)
 |      less_equal(other) -> Tensor
 |      
 |      See :func:`torch.less_equal`.
 |  
 |  less_equal_(...)
 |      less_equal_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.less_equal`.
 |  
 |  lgamma(...)
 |      lgamma() -> Tensor
 |      
 |      See :func:`torch.lgamma`
 |  
 |  lgamma_(...)
 |      lgamma_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.lgamma`
 |  
 |  log(...)
 |      log() -> Tensor
 |      
 |      See :func:`torch.log`
 |  
 |  log10(...)
 |      log10() -> Tensor
 |      
 |      See :func:`torch.log10`
 |  
 |  log10_(...)
 |      log10_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.log10`
 |  
 |  log1p(...)
 |      log1p() -> Tensor
 |      
 |      See :func:`torch.log1p`
 |  
 |  log1p_(...)
 |      log1p_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.log1p`
 |  
 |  log2(...)
 |      log2() -> Tensor
 |      
 |      See :func:`torch.log2`
 |  
 |  log2_(...)
 |      log2_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.log2`
 |  
 |  log_(...)
 |      log_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.log`
 |  
 |  log_normal_(...)
 |      log_normal_(mean=1, std=2, *, generator=None)
 |      
 |      Fills :attr:`self` tensor with numbers samples from the log-normal distribution
 |      parameterized by the given mean :math:`\mu` and standard deviation
 |      :math:`\sigma`. Note that :attr:`mean` and :attr:`std` are the mean and
 |      standard deviation of the underlying normal distribution, and not of the
 |      returned distribution:
 |      
 |      .. math::
 |      
 |          f(x) = \dfrac{1}{x \sigma \sqrt{2\pi}}\ e^{-\frac{(\ln x - \mu)^2}{2\sigma^2}}
 |  
 |  log_softmax(...)
 |  
 |  logaddexp(...)
 |      logaddexp(other) -> Tensor
 |      
 |      See :func:`torch.logaddexp`
 |  
 |  logaddexp2(...)
 |      logaddexp2(other) -> Tensor
 |      
 |      See :func:`torch.logaddexp2`
 |  
 |  logcumsumexp(...)
 |      logcumsumexp(dim) -> Tensor
 |      
 |      See :func:`torch.logcumsumexp`
 |  
 |  logdet(...)
 |      logdet() -> Tensor
 |      
 |      See :func:`torch.logdet`
 |  
 |  logical_and(...)
 |      logical_and() -> Tensor
 |      
 |      See :func:`torch.logical_and`
 |  
 |  logical_and_(...)
 |      logical_and_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.logical_and`
 |  
 |  logical_not(...)
 |      logical_not() -> Tensor
 |      
 |      See :func:`torch.logical_not`
 |  
 |  logical_not_(...)
 |      logical_not_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.logical_not`
 |  
 |  logical_or(...)
 |      logical_or() -> Tensor
 |      
 |      See :func:`torch.logical_or`
 |  
 |  logical_or_(...)
 |      logical_or_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.logical_or`
 |  
 |  logical_xor(...)
 |      logical_xor() -> Tensor
 |      
 |      See :func:`torch.logical_xor`
 |  
 |  logical_xor_(...)
 |      logical_xor_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.logical_xor`
 |  
 |  logit(...)
 |      logit() -> Tensor
 |      
 |      See :func:`torch.logit`
 |  
 |  logit_(...)
 |      logit_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.logit`
 |  
 |  logsumexp(...)
 |      logsumexp(dim, keepdim=False) -> Tensor
 |      
 |      See :func:`torch.logsumexp`
 |  
 |  long(...)
 |      long(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.long()`` is equivalent to ``self.to(torch.int64)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  lt(...)
 |      lt(other) -> Tensor
 |      
 |      See :func:`torch.lt`.
 |  
 |  lt_(...)
 |      lt_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.lt`.
 |  
 |  lu_solve(...)
 |      lu_solve(LU_data, LU_pivots) -> Tensor
 |      
 |      See :func:`torch.lu_solve`
 |  
 |  map2_(...)
 |  
 |  map_(...)
 |      map_(tensor, callable)
 |      
 |      Applies :attr:`callable` for each element in :attr:`self` tensor and the given
 |      :attr:`tensor` and stores the results in :attr:`self` tensor. :attr:`self` tensor and
 |      the given :attr:`tensor` must be :ref:`broadcastable <broadcasting-semantics>`.
 |      
 |      The :attr:`callable` should have the signature::
 |      
 |          def callable(a, b) -> number
 |  
 |  masked_fill(...)
 |      masked_fill(mask, value) -> Tensor
 |      
 |      Out-of-place version of :meth:`torch.Tensor.masked_fill_`
 |  
 |  masked_fill_(...)
 |      masked_fill_(mask, value)
 |      
 |      Fills elements of :attr:`self` tensor with :attr:`value` where :attr:`mask` is
 |      True. The shape of :attr:`mask` must be
 |      :ref:`broadcastable <broadcasting-semantics>` with the shape of the underlying
 |      tensor.
 |      
 |      Args:
 |          mask (BoolTensor): the boolean mask
 |          value (float): the value to fill in with
 |  
 |  masked_scatter(...)
 |      masked_scatter(mask, tensor) -> Tensor
 |      
 |      Out-of-place version of :meth:`torch.Tensor.masked_scatter_`
 |      
 |      .. note::
 |      
 |          The inputs :attr:`self` and :attr:`mask`
 |          :ref:`broadcast <broadcasting-semantics>`.
 |      
 |      Example:
 |      
 |          >>> self = torch.tensor([0, 0, 0, 0, 0])
 |          >>> mask = torch.tensor([[0, 0, 0, 1, 1], [1, 1, 0, 1, 1]])
 |          >>> source = torch.tensor([[0, 1, 2, 3, 4], [5, 6, 7, 8, 9]])
 |          >>> self.masked_scatter(mask, source)
 |          tensor([[0, 0, 0, 0, 1],
 |                  [2, 3, 0, 4, 5]])
 |  
 |  masked_scatter_(...)
 |      masked_scatter_(mask, source)
 |      
 |      Copies elements from :attr:`source` into :attr:`self` tensor at positions where
 |      the :attr:`mask` is True. Elements from :attr:`source` are copied into :attr:`self`
 |      starting at position 0 of :attr:`source` and continuing in order one-by-one for each
 |      occurrence of :attr:`mask` being True.
 |      The shape of :attr:`mask` must be :ref:`broadcastable <broadcasting-semantics>`
 |      with the shape of the underlying tensor. The :attr:`source` should have at least
 |      as many elements as the number of ones in :attr:`mask`.
 |      
 |      Args:
 |          mask (BoolTensor): the boolean mask
 |          source (Tensor): the tensor to copy from
 |      
 |      .. note::
 |      
 |          The :attr:`mask` operates on the :attr:`self` tensor, not on the given
 |          :attr:`source` tensor.
 |      
 |      Example:
 |      
 |          >>> self = torch.tensor([[0, 0, 0, 0, 0], [0, 0, 0, 0, 0]])
 |          >>> mask = torch.tensor([[0, 0, 0, 1, 1], [1, 1, 0, 1, 1]])
 |          >>> source = torch.tensor([[0, 1, 2, 3, 4], [5, 6, 7, 8, 9]])
 |          >>> self.masked_scatter_(mask, source)
 |          tensor([[0, 0, 0, 0, 1],
 |                  [2, 3, 0, 4, 5]])
 |  
 |  masked_select(...)
 |      masked_select(mask) -> Tensor
 |      
 |      See :func:`torch.masked_select`
 |  
 |  matmul(...)
 |      matmul(tensor2) -> Tensor
 |      
 |      See :func:`torch.matmul`
 |  
 |  matrix_exp(...)
 |      matrix_exp() -> Tensor
 |      
 |      See :func:`torch.matrix_exp`
 |  
 |  matrix_power(...)
 |      matrix_power(n) -> Tensor
 |      
 |      .. note:: :meth:`~Tensor.matrix_power` is deprecated, use :func:`torch.linalg.matrix_power` instead.
 |      
 |      Alias for :func:`torch.linalg.matrix_power`
 |  
 |  max(...)
 |      max(dim=None, keepdim=False) -> Tensor or (Tensor, Tensor)
 |      
 |      See :func:`torch.max`
 |  
 |  maximum(...)
 |      maximum(other) -> Tensor
 |      
 |      See :func:`torch.maximum`
 |  
 |  mean(...)
 |      mean(dim=None, keepdim=False, *, dtype=None) -> Tensor
 |      
 |      See :func:`torch.mean`
 |  
 |  median(...)
 |      median(dim=None, keepdim=False) -> (Tensor, LongTensor)
 |      
 |      See :func:`torch.median`
 |  
 |  min(...)
 |      min(dim=None, keepdim=False) -> Tensor or (Tensor, Tensor)
 |      
 |      See :func:`torch.min`
 |  
 |  minimum(...)
 |      minimum(other) -> Tensor
 |      
 |      See :func:`torch.minimum`
 |  
 |  mm(...)
 |      mm(mat2) -> Tensor
 |      
 |      See :func:`torch.mm`
 |  
 |  mode(...)
 |      mode(dim=None, keepdim=False) -> (Tensor, LongTensor)
 |      
 |      See :func:`torch.mode`
 |  
 |  moveaxis(...)
 |      moveaxis(source, destination) -> Tensor
 |      
 |      See :func:`torch.moveaxis`
 |  
 |  movedim(...)
 |      movedim(source, destination) -> Tensor
 |      
 |      See :func:`torch.movedim`
 |  
 |  msort(...)
 |      msort() -> Tensor
 |      
 |      See :func:`torch.msort`
 |  
 |  mul(...)
 |      mul(value) -> Tensor
 |      
 |      See :func:`torch.mul`.
 |  
 |  mul_(...)
 |      mul_(value) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.mul`.
 |  
 |  multinomial(...)
 |      multinomial(num_samples, replacement=False, *, generator=None) -> Tensor
 |      
 |      See :func:`torch.multinomial`
 |  
 |  multiply(...)
 |      multiply(value) -> Tensor
 |      
 |      See :func:`torch.multiply`.
 |  
 |  multiply_(...)
 |      multiply_(value) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.multiply`.
 |  
 |  mv(...)
 |      mv(vec) -> Tensor
 |      
 |      See :func:`torch.mv`
 |  
 |  mvlgamma(...)
 |      mvlgamma(p) -> Tensor
 |      
 |      See :func:`torch.mvlgamma`
 |  
 |  mvlgamma_(...)
 |      mvlgamma_(p) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.mvlgamma`
 |  
 |  nan_to_num(...)
 |      nan_to_num(nan=0.0, posinf=None, neginf=None) -> Tensor
 |      
 |      See :func:`torch.nan_to_num`.
 |  
 |  nan_to_num_(...)
 |      nan_to_num_(nan=0.0, posinf=None, neginf=None) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.nan_to_num`.
 |  
 |  nanmean(...)
 |      nanmean(dim=None, keepdim=False, *, dtype=None) -> Tensor
 |      
 |      See :func:`torch.nanmean`
 |  
 |  nanmedian(...)
 |      nanmedian(dim=None, keepdim=False) -> (Tensor, LongTensor)
 |      
 |      See :func:`torch.nanmedian`
 |  
 |  nanquantile(...)
 |      nanquantile(q, dim=None, keepdim=False, *, interpolation='linear') -> Tensor
 |      
 |      See :func:`torch.nanquantile`
 |  
 |  nansum(...)
 |      nansum(dim=None, keepdim=False, dtype=None) -> Tensor
 |      
 |      See :func:`torch.nansum`
 |  
 |  narrow(...)
 |      narrow(dimension, start, length) -> Tensor
 |      
 |      See :func:`torch.narrow`.
 |  
 |  narrow_copy(...)
 |      narrow_copy(dimension, start, length) -> Tensor
 |      
 |      See :func:`torch.narrow_copy`.
 |  
 |  ndimension(...)
 |      ndimension() -> int
 |      
 |      Alias for :meth:`~Tensor.dim()`
 |  
 |  ne(...)
 |      ne(other) -> Tensor
 |      
 |      See :func:`torch.ne`.
 |  
 |  ne_(...)
 |      ne_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.ne`.
 |  
 |  neg(...)
 |      neg() -> Tensor
 |      
 |      See :func:`torch.neg`
 |  
 |  neg_(...)
 |      neg_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.neg`
 |  
 |  negative(...)
 |      negative() -> Tensor
 |      
 |      See :func:`torch.negative`
 |  
 |  negative_(...)
 |      negative_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.negative`
 |  
 |  nelement(...)
 |      nelement() -> int
 |      
 |      Alias for :meth:`~Tensor.numel`
 |  
 |  new(...)
 |  
 |  new_empty(...)
 |      new_empty(size, *, dtype=None, device=None, requires_grad=False, layout=torch.strided, pin_memory=False) -> Tensor
 |      
 |      
 |      Returns a Tensor of size :attr:`size` filled with uninitialized data.
 |      By default, the returned Tensor has the same :class:`torch.dtype` and
 |      :class:`torch.device` as this tensor.
 |      
 |      Args:
 |          size (int...): a list, tuple, or :class:`torch.Size` of integers defining the
 |              shape of the output tensor.
 |      
 |      Keyword args:
 |          dtype (:class:`torch.dtype`, optional): the desired type of returned tensor.
 |              Default: if None, same :class:`torch.dtype` as this tensor.
 |          device (:class:`torch.device`, optional): the desired device of returned tensor.
 |              Default: if None, same :class:`torch.device` as this tensor.
 |          requires_grad (bool, optional): If autograd should record operations on the
 |              returned tensor. Default: ``False``.
 |          layout (:class:`torch.layout`, optional): the desired layout of returned Tensor.
 |              Default: ``torch.strided``.
 |          pin_memory (bool, optional): If set, returned tensor would be allocated in
 |              the pinned memory. Works only for CPU tensors. Default: ``False``.
 |      
 |      Example::
 |      
 |          >>> tensor = torch.ones(())
 |          >>> tensor.new_empty((2, 3))
 |          tensor([[ 5.8182e-18,  4.5765e-41, -1.0545e+30],
 |                  [ 3.0949e-41,  4.4842e-44,  0.0000e+00]])
 |  
 |  new_empty_strided(...)
 |      new_empty_strided(size, stride, dtype=None, device=None, requires_grad=False, layout=torch.strided, pin_memory=False) -> Tensor
 |      
 |      
 |      Returns a Tensor of size :attr:`size` and strides :attr:`stride` filled with
 |      uninitialized data. By default, the returned Tensor has the same
 |      :class:`torch.dtype` and :class:`torch.device` as this tensor.
 |      
 |      Args:
 |          size (int...): a list, tuple, or :class:`torch.Size` of integers defining the
 |              shape of the output tensor.
 |      
 |      Keyword args:
 |          dtype (:class:`torch.dtype`, optional): the desired type of returned tensor.
 |              Default: if None, same :class:`torch.dtype` as this tensor.
 |          device (:class:`torch.device`, optional): the desired device of returned tensor.
 |              Default: if None, same :class:`torch.device` as this tensor.
 |          requires_grad (bool, optional): If autograd should record operations on the
 |              returned tensor. Default: ``False``.
 |          layout (:class:`torch.layout`, optional): the desired layout of returned Tensor.
 |              Default: ``torch.strided``.
 |          pin_memory (bool, optional): If set, returned tensor would be allocated in
 |              the pinned memory. Works only for CPU tensors. Default: ``False``.
 |      
 |      Example::
 |      
 |          >>> tensor = torch.ones(())
 |          >>> tensor.new_empty_strided((2, 3), (3, 1))
 |          tensor([[ 5.8182e-18,  4.5765e-41, -1.0545e+30],
 |                  [ 3.0949e-41,  4.4842e-44,  0.0000e+00]])
 |  
 |  new_full(...)
 |      new_full(size, fill_value, *, dtype=None, device=None, requires_grad=False, layout=torch.strided, pin_memory=False) -> Tensor
 |      
 |      
 |      Returns a Tensor of size :attr:`size` filled with :attr:`fill_value`.
 |      By default, the returned Tensor has the same :class:`torch.dtype` and
 |      :class:`torch.device` as this tensor.
 |      
 |      Args:
 |          fill_value (scalar): the number to fill the output tensor with.
 |      
 |      Keyword args:
 |          dtype (:class:`torch.dtype`, optional): the desired type of returned tensor.
 |              Default: if None, same :class:`torch.dtype` as this tensor.
 |          device (:class:`torch.device`, optional): the desired device of returned tensor.
 |              Default: if None, same :class:`torch.device` as this tensor.
 |          requires_grad (bool, optional): If autograd should record operations on the
 |              returned tensor. Default: ``False``.
 |          layout (:class:`torch.layout`, optional): the desired layout of returned Tensor.
 |              Default: ``torch.strided``.
 |          pin_memory (bool, optional): If set, returned tensor would be allocated in
 |              the pinned memory. Works only for CPU tensors. Default: ``False``.
 |      
 |      Example::
 |      
 |          >>> tensor = torch.ones((2,), dtype=torch.float64)
 |          >>> tensor.new_full((3, 4), 3.141592)
 |          tensor([[ 3.1416,  3.1416,  3.1416,  3.1416],
 |                  [ 3.1416,  3.1416,  3.1416,  3.1416],
 |                  [ 3.1416,  3.1416,  3.1416,  3.1416]], dtype=torch.float64)
 |  
 |  new_ones(...)
 |      new_ones(size, *, dtype=None, device=None, requires_grad=False, layout=torch.strided, pin_memory=False) -> Tensor
 |      
 |      
 |      Returns a Tensor of size :attr:`size` filled with ``1``.
 |      By default, the returned Tensor has the same :class:`torch.dtype` and
 |      :class:`torch.device` as this tensor.
 |      
 |      Args:
 |          size (int...): a list, tuple, or :class:`torch.Size` of integers defining the
 |              shape of the output tensor.
 |      
 |      Keyword args:
 |          dtype (:class:`torch.dtype`, optional): the desired type of returned tensor.
 |              Default: if None, same :class:`torch.dtype` as this tensor.
 |          device (:class:`torch.device`, optional): the desired device of returned tensor.
 |              Default: if None, same :class:`torch.device` as this tensor.
 |          requires_grad (bool, optional): If autograd should record operations on the
 |              returned tensor. Default: ``False``.
 |          layout (:class:`torch.layout`, optional): the desired layout of returned Tensor.
 |              Default: ``torch.strided``.
 |          pin_memory (bool, optional): If set, returned tensor would be allocated in
 |              the pinned memory. Works only for CPU tensors. Default: ``False``.
 |      
 |      Example::
 |      
 |          >>> tensor = torch.tensor((), dtype=torch.int32)
 |          >>> tensor.new_ones((2, 3))
 |          tensor([[ 1,  1,  1],
 |                  [ 1,  1,  1]], dtype=torch.int32)
 |  
 |  new_tensor(...)
 |      new_tensor(data, *, dtype=None, device=None, requires_grad=False, layout=torch.strided, pin_memory=False) -> Tensor
 |      
 |      
 |      Returns a new Tensor with :attr:`data` as the tensor data.
 |      By default, the returned Tensor has the same :class:`torch.dtype` and
 |      :class:`torch.device` as this tensor.
 |      
 |      .. warning::
 |      
 |          :func:`new_tensor` always copies :attr:`data`. If you have a Tensor
 |          ``data`` and want to avoid a copy, use :func:`torch.Tensor.requires_grad_`
 |          or :func:`torch.Tensor.detach`.
 |          If you have a numpy array and want to avoid a copy, use
 |          :func:`torch.from_numpy`.
 |      
 |      .. warning::
 |      
 |          When data is a tensor `x`, :func:`new_tensor()` reads out 'the data' from whatever it is passed,
 |          and constructs a leaf variable. Therefore ``tensor.new_tensor(x)`` is equivalent to ``x.clone().detach()``
 |          and ``tensor.new_tensor(x, requires_grad=True)`` is equivalent to ``x.clone().detach().requires_grad_(True)``.
 |          The equivalents using ``clone()`` and ``detach()`` are recommended.
 |      
 |      Args:
 |          data (array_like): The returned Tensor copies :attr:`data`.
 |      
 |      Keyword args:
 |          dtype (:class:`torch.dtype`, optional): the desired type of returned tensor.
 |              Default: if None, same :class:`torch.dtype` as this tensor.
 |          device (:class:`torch.device`, optional): the desired device of returned tensor.
 |              Default: if None, same :class:`torch.device` as this tensor.
 |          requires_grad (bool, optional): If autograd should record operations on the
 |              returned tensor. Default: ``False``.
 |          layout (:class:`torch.layout`, optional): the desired layout of returned Tensor.
 |              Default: ``torch.strided``.
 |          pin_memory (bool, optional): If set, returned tensor would be allocated in
 |              the pinned memory. Works only for CPU tensors. Default: ``False``.
 |      
 |      Example::
 |      
 |          >>> tensor = torch.ones((2,), dtype=torch.int8)
 |          >>> data = [[0, 1], [2, 3]]
 |          >>> tensor.new_tensor(data)
 |          tensor([[ 0,  1],
 |                  [ 2,  3]], dtype=torch.int8)
 |  
 |  new_zeros(...)
 |      new_zeros(size, *, dtype=None, device=None, requires_grad=False, layout=torch.strided, pin_memory=False) -> Tensor
 |      
 |      
 |      Returns a Tensor of size :attr:`size` filled with ``0``.
 |      By default, the returned Tensor has the same :class:`torch.dtype` and
 |      :class:`torch.device` as this tensor.
 |      
 |      Args:
 |          size (int...): a list, tuple, or :class:`torch.Size` of integers defining the
 |              shape of the output tensor.
 |      
 |      Keyword args:
 |          dtype (:class:`torch.dtype`, optional): the desired type of returned tensor.
 |              Default: if None, same :class:`torch.dtype` as this tensor.
 |          device (:class:`torch.device`, optional): the desired device of returned tensor.
 |              Default: if None, same :class:`torch.device` as this tensor.
 |          requires_grad (bool, optional): If autograd should record operations on the
 |              returned tensor. Default: ``False``.
 |          layout (:class:`torch.layout`, optional): the desired layout of returned Tensor.
 |              Default: ``torch.strided``.
 |          pin_memory (bool, optional): If set, returned tensor would be allocated in
 |              the pinned memory. Works only for CPU tensors. Default: ``False``.
 |      
 |      Example::
 |      
 |          >>> tensor = torch.tensor((), dtype=torch.float64)
 |          >>> tensor.new_zeros((2, 3))
 |          tensor([[ 0.,  0.,  0.],
 |                  [ 0.,  0.,  0.]], dtype=torch.float64)
 |  
 |  nextafter(...)
 |      nextafter(other) -> Tensor
 |      See :func:`torch.nextafter`
 |  
 |  nextafter_(...)
 |      nextafter_(other) -> Tensor
 |      In-place version of :meth:`~Tensor.nextafter`
 |  
 |  nonzero(...)
 |      nonzero() -> LongTensor
 |      
 |      See :func:`torch.nonzero`
 |  
 |  nonzero_static(...)
 |      nonzero_static(input, *, size, fill_value=-1) -> Tensor
 |      
 |      Returns a 2-D tensor where each row is the index for a non-zero value.
 |      The returned Tensor has the same `torch.dtype` as `torch.nonzero()`.
 |      
 |      Args:
 |          input (Tensor): the input tensor to count non-zero elements.
 |      
 |      Keyword args:
 |          size (int): the size of non-zero elements expected to be included in the out
 |              tensor. Pad the out tensor with `fill_value` if the `size` is larger
 |              than total number of non-zero elements, truncate out tensor if `size`
 |              is smaller. The size must be a non-negative integer.
 |          fill_value (int): the value to fill the output tensor with when `size` is larger
 |              than the total number of non-zero elements. Default is `-1` to represent
 |              invalid index.
 |      
 |      Example:
 |      
 |          # Example 1: Padding
 |          >>> input_tensor = torch.tensor([[1, 0], [3, 2]])
 |          >>> static_size = 4
 |          >>> t = torch.nonzero_static(input_tensor, size = static_size)
 |          tensor([[  0,   0],
 |                  [  1,   0],
 |                  [  1,   1],
 |                  [  -1, -1]], dtype=torch.int64)
 |      
 |          # Example 2: Truncating
 |          >>> input_tensor = torch.tensor([[1, 0], [3, 2]])
 |          >>> static_size = 2
 |          >>> t = torch.nonzero_static(input_tensor, size = static_size)
 |          tensor([[  0,   0],
 |                  [  1,   0]], dtype=torch.int64)
 |      
 |          # Example 3: 0 size
 |          >>> input_tensor = torch.tensor([10])
 |          >>> static_size = 0
 |          >>> t = torch.nonzero_static(input_tensor, size = static_size)
 |          tensor([], size=(0, 1), dtype=torch.int64)
 |      
 |          # Example 4: 0 rank input
 |          >>> input_tensor = torch.tensor(10)
 |          >>> static_size = 2
 |          >>> t = torch.nonzero_static(input_tensor, size = static_size)
 |          tensor([], size=(2, 0), dtype=torch.int64)
 |  
 |  normal_(...)
 |      normal_(mean=0, std=1, *, generator=None) -> Tensor
 |      
 |      Fills :attr:`self` tensor with elements samples from the normal distribution
 |      parameterized by :attr:`mean` and :attr:`std`.
 |  
 |  not_equal(...)
 |      not_equal(other) -> Tensor
 |      
 |      See :func:`torch.not_equal`.
 |  
 |  not_equal_(...)
 |      not_equal_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.not_equal`.
 |  
 |  numel(...)
 |      numel() -> int
 |      
 |      See :func:`torch.numel`
 |  
 |  numpy(...)
 |      numpy(*, force=False) -> numpy.ndarray
 |      
 |      Returns the tensor as a NumPy :class:`ndarray`.
 |      
 |      If :attr:`force` is ``False`` (the default), the conversion
 |      is performed only if the tensor is on the CPU, does not require grad,
 |      does not have its conjugate bit set, and is a dtype and layout that
 |      NumPy supports. The returned ndarray and the tensor will share their
 |      storage, so changes to the tensor will be reflected in the ndarray
 |      and vice versa.
 |      
 |      If :attr:`force` is ``True`` this is equivalent to
 |      calling ``t.detach().cpu().resolve_conj().resolve_neg().numpy()``.
 |      If the tensor isn't on the CPU or the conjugate or negative bit is set,
 |      the tensor won't share its storage with the returned ndarray.
 |      Setting :attr:`force` to ``True`` can be a useful shorthand.
 |      
 |      Args:
 |          force (bool): if ``True``, the ndarray may be a copy of the tensor
 |                     instead of always sharing memory, defaults to ``False``.
 |  
 |  orgqr(...)
 |      orgqr(input2) -> Tensor
 |      
 |      See :func:`torch.orgqr`
 |  
 |  ormqr(...)
 |      ormqr(input2, input3, left=True, transpose=False) -> Tensor
 |      
 |      See :func:`torch.ormqr`
 |  
 |  outer(...)
 |      outer(vec2) -> Tensor
 |      
 |      See :func:`torch.outer`.
 |  
 |  permute(...)
 |      permute(*dims) -> Tensor
 |      
 |      See :func:`torch.permute`
 |  
 |  pin_memory(...)
 |      pin_memory() -> Tensor
 |      
 |      Copies the tensor to pinned memory, if it's not already pinned.
 |  
 |  pinverse(...)
 |      pinverse() -> Tensor
 |      
 |      See :func:`torch.pinverse`
 |  
 |  polygamma(...)
 |      polygamma(n) -> Tensor
 |      
 |      See :func:`torch.polygamma`
 |  
 |  polygamma_(...)
 |      polygamma_(n) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.polygamma`
 |  
 |  positive(...)
 |      positive() -> Tensor
 |      
 |      See :func:`torch.positive`
 |  
 |  pow(...)
 |      pow(exponent) -> Tensor
 |      
 |      See :func:`torch.pow`
 |  
 |  pow_(...)
 |      pow_(exponent) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.pow`
 |  
 |  prelu(...)
 |  
 |  prod(...)
 |      prod(dim=None, keepdim=False, dtype=None) -> Tensor
 |      
 |      See :func:`torch.prod`
 |  
 |  put(...)
 |      put(input, index, source, accumulate=False) -> Tensor
 |      
 |      Out-of-place version of :meth:`torch.Tensor.put_`.
 |      `input` corresponds to `self` in :meth:`torch.Tensor.put_`.
 |  
 |  put_(...)
 |      put_(index, source, accumulate=False) -> Tensor
 |      
 |      Copies the elements from :attr:`source` into the positions specified by
 |      :attr:`index`. For the purpose of indexing, the :attr:`self` tensor is treated as if
 |      it were a 1-D tensor.
 |      
 |      :attr:`index` and :attr:`source` need to have the same number of elements, but not necessarily
 |      the same shape.
 |      
 |      If :attr:`accumulate` is ``True``, the elements in :attr:`source` are added to
 |      :attr:`self`. If accumulate is ``False``, the behavior is undefined if :attr:`index`
 |      contain duplicate elements.
 |      
 |      Args:
 |          index (LongTensor): the indices into self
 |          source (Tensor): the tensor containing values to copy from
 |          accumulate (bool): whether to accumulate into self
 |      
 |      Example::
 |      
 |          >>> src = torch.tensor([[4, 3, 5],
 |          ...                     [6, 7, 8]])
 |          >>> src.put_(torch.tensor([1, 3]), torch.tensor([9, 10]))
 |          tensor([[  4,   9,   5],
 |                  [ 10,   7,   8]])
 |  
 |  q_per_channel_axis(...)
 |      q_per_channel_axis() -> int
 |      
 |      Given a Tensor quantized by linear (affine) per-channel quantization,
 |      returns the index of dimension on which per-channel quantization is applied.
 |  
 |  q_per_channel_scales(...)
 |      q_per_channel_scales() -> Tensor
 |      
 |      Given a Tensor quantized by linear (affine) per-channel quantization,
 |      returns a Tensor of scales of the underlying quantizer. It has the number of
 |      elements that matches the corresponding dimensions (from q_per_channel_axis) of
 |      the tensor.
 |  
 |  q_per_channel_zero_points(...)
 |      q_per_channel_zero_points() -> Tensor
 |      
 |      Given a Tensor quantized by linear (affine) per-channel quantization,
 |      returns a tensor of zero_points of the underlying quantizer. It has the number of
 |      elements that matches the corresponding dimensions (from q_per_channel_axis) of
 |      the tensor.
 |  
 |  q_scale(...)
 |      q_scale() -> float
 |      
 |      Given a Tensor quantized by linear(affine) quantization,
 |      returns the scale of the underlying quantizer().
 |  
 |  q_zero_point(...)
 |      q_zero_point() -> int
 |      
 |      Given a Tensor quantized by linear(affine) quantization,
 |      returns the zero_point of the underlying quantizer().
 |  
 |  qr(...)
 |      qr(some=True) -> (Tensor, Tensor)
 |      
 |      See :func:`torch.qr`
 |  
 |  qscheme(...)
 |      qscheme() -> torch.qscheme
 |      
 |      Returns the quantization scheme of a given QTensor.
 |  
 |  quantile(...)
 |      quantile(q, dim=None, keepdim=False, *, interpolation='linear') -> Tensor
 |      
 |      See :func:`torch.quantile`
 |  
 |  rad2deg(...)
 |      rad2deg() -> Tensor
 |      
 |      See :func:`torch.rad2deg`
 |  
 |  rad2deg_(...)
 |      rad2deg_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.rad2deg`
 |  
 |  random_(...)
 |      random_(from=0, to=None, *, generator=None) -> Tensor
 |      
 |      Fills :attr:`self` tensor with numbers sampled from the discrete uniform
 |      distribution over ``[from, to - 1]``. If not specified, the values are usually
 |      only bounded by :attr:`self` tensor's data type. However, for floating point
 |      types, if unspecified, range will be ``[0, 2^mantissa]`` to ensure that every
 |      value is representable. For example, `torch.tensor(1, dtype=torch.double).random_()`
 |      will be uniform in ``[0, 2^53]``.
 |  
 |  ravel(...)
 |      ravel() -> Tensor
 |      
 |      see :func:`torch.ravel`
 |  
 |  reciprocal(...)
 |      reciprocal() -> Tensor
 |      
 |      See :func:`torch.reciprocal`
 |  
 |  reciprocal_(...)
 |      reciprocal_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.reciprocal`
 |  
 |  record_stream(...)
 |      record_stream(stream)
 |      
 |      Marks the tensor as having been used by this stream.  When the tensor
 |      is deallocated, ensure the tensor memory is not reused for another tensor
 |      until all work queued on :attr:`stream` at the time of deallocation is
 |      complete.
 |      
 |      .. note::
 |      
 |          The caching allocator is aware of only the stream where a tensor was
 |          allocated. Due to the awareness, it already correctly manages the life
 |          cycle of tensors on only one stream. But if a tensor is used on a stream
 |          different from the stream of origin, the allocator might reuse the memory
 |          unexpectedly. Calling this method lets the allocator know which streams
 |          have used the tensor.
 |      
 |      .. warning::
 |      
 |          This method is most suitable for use cases where you are providing a
 |          function that created a tensor on a side stream, and want users to be able
 |          to make use of the tensor without having to think carefully about stream
 |          safety when making use of them.  These safety guarantees come at some
 |          performance and predictability cost (analogous to the tradeoff between GC
 |          and manual memory management), so if you are in a situation where
 |          you manage the full lifetime of your tensors, you may consider instead
 |          manually managing CUDA events so that calling this method is not necessary.
 |          In particular, when you call this method, on later allocations the
 |          allocator will poll the recorded stream to see if all operations have
 |          completed yet; you can potentially race with side stream computation and
 |          non-deterministically reuse or fail to reuse memory for an allocation.
 |      
 |          You can safely use tensors allocated on side streams without
 |          :meth:`~Tensor.record_stream`; you must manually ensure that
 |          any non-creation stream uses of a tensor are synced back to the creation
 |          stream before you deallocate the tensor.  As the CUDA caching allocator
 |          guarantees that the memory will only be reused with the same creation stream,
 |          this is sufficient to ensure that writes to future reallocations of the
 |          memory will be delayed until non-creation stream uses are done.
 |          (Counterintuitively, you may observe that on the CPU side we have already
 |          reallocated the tensor, even though CUDA kernels on the old tensor are
 |          still in progress.  This is fine, because CUDA operations on the new
 |          tensor will appropriately wait for the old operations to complete, as they
 |          are all on the same stream.)
 |      
 |          Concretely, this looks like this::
 |      
 |              with torch.cuda.stream(s0):
 |                  x = torch.zeros(N)
 |      
 |              s1.wait_stream(s0)
 |              with torch.cuda.stream(s1):
 |                  y = some_comm_op(x)
 |      
 |              ... some compute on s0 ...
 |      
 |              # synchronize creation stream s0 to side stream s1
 |              # before deallocating x
 |              s0.wait_stream(s1)
 |              del x
 |      
 |          Note that some discretion is required when deciding when to perform
 |          ``s0.wait_stream(s1)``.  In particular, if we were to wait immediately
 |          after ``some_comm_op``, there wouldn't be any point in having the side
 |          stream; it would be equivalent to have run ``some_comm_op`` on ``s0``.
 |          Instead, the synchronization must be placed at some appropriate, later
 |          point in time where you expect the side stream ``s1`` to have finished
 |          work.  This location is typically identified via profiling, e.g., using
 |          Chrome traces produced
 |          :meth:`torch.autograd.profiler.profile.export_chrome_trace`.  If you
 |          place the wait too early, work on s0 will block until ``s1`` has finished,
 |          preventing further overlapping of communication and computation.  If you
 |          place the wait too late, you will use more memory than is strictly
 |          necessary (as you are keeping ``x`` live for longer.)  For a concrete
 |          example of how this guidance can be applied in practice, see this post:
 |          `FSDP and CUDACachingAllocator
 |          <https://dev-discuss.pytorch.org/t/fsdp-cudacachingallocator-an-outsider-newb-perspective/1486>`_.
 |  
 |  relu(...)
 |  
 |  relu_(...)
 |  
 |  remainder(...)
 |      remainder(divisor) -> Tensor
 |      
 |      See :func:`torch.remainder`
 |  
 |  remainder_(...)
 |      remainder_(divisor) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.remainder`
 |  
 |  renorm(...)
 |      renorm(p, dim, maxnorm) -> Tensor
 |      
 |      See :func:`torch.renorm`
 |  
 |  renorm_(...)
 |      renorm_(p, dim, maxnorm) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.renorm`
 |  
 |  repeat(...)
 |      repeat(*sizes) -> Tensor
 |      
 |      Repeats this tensor along the specified dimensions.
 |      
 |      Unlike :meth:`~Tensor.expand`, this function copies the tensor's data.
 |      
 |      .. warning::
 |      
 |          :meth:`~Tensor.repeat` behaves differently from
 |          `numpy.repeat <https://docs.scipy.org/doc/numpy/reference/generated/numpy.repeat.html>`_,
 |          but is more similar to
 |          `numpy.tile <https://docs.scipy.org/doc/numpy/reference/generated/numpy.tile.html>`_.
 |          For the operator similar to `numpy.repeat`, see :func:`torch.repeat_interleave`.
 |      
 |      Args:
 |          sizes (torch.Size or int...): The number of times to repeat this tensor along each
 |              dimension
 |      
 |      Example::
 |      
 |          >>> x = torch.tensor([1, 2, 3])
 |          >>> x.repeat(4, 2)
 |          tensor([[ 1,  2,  3,  1,  2,  3],
 |                  [ 1,  2,  3,  1,  2,  3],
 |                  [ 1,  2,  3,  1,  2,  3],
 |                  [ 1,  2,  3,  1,  2,  3]])
 |          >>> x.repeat(4, 2, 1).size()
 |          torch.Size([4, 2, 3])
 |  
 |  repeat_interleave(...)
 |      repeat_interleave(repeats, dim=None, *, output_size=None) -> Tensor
 |      
 |      See :func:`torch.repeat_interleave`.
 |  
 |  requires_grad_(...)
 |      requires_grad_(requires_grad=True) -> Tensor
 |      
 |      Change if autograd should record operations on this tensor: sets this tensor's
 |      :attr:`requires_grad` attribute in-place. Returns this tensor.
 |      
 |      :func:`requires_grad_`'s main use case is to tell autograd to begin recording
 |      operations on a Tensor ``tensor``. If ``tensor`` has ``requires_grad=False``
 |      (because it was obtained through a DataLoader, or required preprocessing or
 |      initialization), ``tensor.requires_grad_()`` makes it so that autograd will
 |      begin to record operations on ``tensor``.
 |      
 |      Args:
 |          requires_grad (bool): If autograd should record operations on this tensor.
 |              Default: ``True``.
 |      
 |      Example::
 |      
 |          >>> # Let's say we want to preprocess some saved weights and use
 |          >>> # the result as new weights.
 |          >>> saved_weights = [0.1, 0.2, 0.3, 0.25]
 |          >>> loaded_weights = torch.tensor(saved_weights)
 |          >>> weights = preprocess(loaded_weights)  # some function
 |          >>> weights
 |          tensor([-0.5503,  0.4926, -2.1158, -0.8303])
 |      
 |          >>> # Now, start to record operations done to weights
 |          >>> weights.requires_grad_()
 |          >>> out = weights.pow(2).sum()
 |          >>> out.backward()
 |          >>> weights.grad
 |          tensor([-1.1007,  0.9853, -4.2316, -1.6606])
 |  
 |  reshape(...)
 |      reshape(*shape) -> Tensor
 |      
 |      Returns a tensor with the same data and number of elements as :attr:`self`
 |      but with the specified shape. This method returns a view if :attr:`shape` is
 |      compatible with the current shape. See :meth:`torch.Tensor.view` on when it is
 |      possible to return a view.
 |      
 |      See :func:`torch.reshape`
 |      
 |      Args:
 |          shape (tuple of ints or int...): the desired shape
 |  
 |  reshape_as(...)
 |      reshape_as(other) -> Tensor
 |      
 |      Returns this tensor as the same shape as :attr:`other`.
 |      ``self.reshape_as(other)`` is equivalent to ``self.reshape(other.sizes())``.
 |      This method returns a view if ``other.sizes()`` is compatible with the current
 |      shape. See :meth:`torch.Tensor.view` on when it is possible to return a view.
 |      
 |      Please see :meth:`reshape` for more information about ``reshape``.
 |      
 |      Args:
 |          other (:class:`torch.Tensor`): The result tensor has the same shape
 |              as :attr:`other`.
 |  
 |  resize_(...)
 |      resize_(*sizes, memory_format=torch.contiguous_format) -> Tensor
 |      
 |      Resizes :attr:`self` tensor to the specified size. If the number of elements is
 |      larger than the current storage size, then the underlying storage is resized
 |      to fit the new number of elements. If the number of elements is smaller, the
 |      underlying storage is not changed. Existing elements are preserved but any new
 |      memory is uninitialized.
 |      
 |      .. warning::
 |      
 |          This is a low-level method. The storage is reinterpreted as C-contiguous,
 |          ignoring the current strides (unless the target size equals the current
 |          size, in which case the tensor is left unchanged). For most purposes, you
 |          will instead want to use :meth:`~Tensor.view()`, which checks for
 |          contiguity, or :meth:`~Tensor.reshape()`, which copies data if needed. To
 |          change the size in-place with custom strides, see :meth:`~Tensor.set_()`.
 |      
 |      .. note::
 |      
 |          If :func:`torch.use_deterministic_algorithms()` and
 |          :attr:`torch.utils.deterministic.fill_uninitialized_memory` are both set to
 |          ``True``, new elements are initialized to prevent nondeterministic behavior
 |          from using the result as an input to an operation. Floating point and
 |          complex values are set to NaN, and integer values are set to the maximum
 |          value.
 |      
 |      Args:
 |          sizes (torch.Size or int...): the desired size
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              Tensor. Default: ``torch.contiguous_format``. Note that memory format of
 |              :attr:`self` is going to be unaffected if ``self.size()`` matches ``sizes``.
 |      
 |      Example::
 |      
 |          >>> x = torch.tensor([[1, 2], [3, 4], [5, 6]])
 |          >>> x.resize_(2, 2)
 |          tensor([[ 1,  2],
 |                  [ 3,  4]])
 |  
 |  resize_as_(...)
 |      resize_as_(tensor, memory_format=torch.contiguous_format) -> Tensor
 |      
 |      Resizes the :attr:`self` tensor to be the same size as the specified
 |      :attr:`tensor`. This is equivalent to ``self.resize_(tensor.size())``.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              Tensor. Default: ``torch.contiguous_format``. Note that memory format of
 |              :attr:`self` is going to be unaffected if ``self.size()`` matches ``tensor.size()``.
 |  
 |  resize_as_sparse_(...)
 |  
 |  resolve_conj(...)
 |      resolve_conj() -> Tensor
 |      
 |      See :func:`torch.resolve_conj`
 |  
 |  resolve_neg(...)
 |      resolve_neg() -> Tensor
 |      
 |      See :func:`torch.resolve_neg`
 |  
 |  retain_grad(...)
 |      retain_grad() -> None
 |      
 |      Enables this Tensor to have their :attr:`grad` populated during
 |      :func:`backward`. This is a no-op for leaf tensors.
 |  
 |  roll(...)
 |      roll(shifts, dims) -> Tensor
 |      
 |      See :func:`torch.roll`
 |  
 |  rot90(...)
 |      rot90(k, dims) -> Tensor
 |      
 |      See :func:`torch.rot90`
 |  
 |  round(...)
 |      round(decimals=0) -> Tensor
 |      
 |      See :func:`torch.round`
 |  
 |  round_(...)
 |      round_(decimals=0) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.round`
 |  
 |  row_indices(...)
 |  
 |  rsqrt(...)
 |      rsqrt() -> Tensor
 |      
 |      See :func:`torch.rsqrt`
 |  
 |  rsqrt_(...)
 |      rsqrt_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.rsqrt`
 |  
 |  scatter(...)
 |      scatter(dim, index, src) -> Tensor
 |      
 |      Out-of-place version of :meth:`torch.Tensor.scatter_`
 |  
 |  scatter_(...)
 |      scatter_(dim, index, src, *, reduce=None) -> Tensor
 |      
 |      Writes all values from the tensor :attr:`src` into :attr:`self` at the indices
 |      specified in the :attr:`index` tensor. For each value in :attr:`src`, its output
 |      index is specified by its index in :attr:`src` for ``dimension != dim`` and by
 |      the corresponding value in :attr:`index` for ``dimension = dim``.
 |      
 |      For a 3-D tensor, :attr:`self` is updated as::
 |      
 |          self[index[i][j][k]][j][k] = src[i][j][k]  # if dim == 0
 |          self[i][index[i][j][k]][k] = src[i][j][k]  # if dim == 1
 |          self[i][j][index[i][j][k]] = src[i][j][k]  # if dim == 2
 |      
 |      This is the reverse operation of the manner described in :meth:`~Tensor.gather`.
 |      
 |      :attr:`self`, :attr:`index` and :attr:`src` (if it is a Tensor) should all have
 |      the same number of dimensions. It is also required that
 |      ``index.size(d) <= src.size(d)`` for all dimensions ``d``, and that
 |      ``index.size(d) <= self.size(d)`` for all dimensions ``d != dim``.
 |      Note that ``index`` and ``src`` do not broadcast.
 |      
 |      Moreover, as for :meth:`~Tensor.gather`, the values of :attr:`index` must be
 |      between ``0`` and ``self.size(dim) - 1`` inclusive.
 |      
 |      .. warning::
 |      
 |          When indices are not unique, the behavior is non-deterministic (one of the
 |          values from ``src`` will be picked arbitrarily) and the gradient will be
 |          incorrect (it will be propagated to all locations in the source that
 |          correspond to the same index)!
 |      
 |      .. note::
 |      
 |          The backward pass is implemented only for ``src.shape == index.shape``.
 |      
 |      Additionally accepts an optional :attr:`reduce` argument that allows
 |      specification of an optional reduction operation, which is applied to all
 |      values in the tensor :attr:`src` into :attr:`self` at the indices
 |      specified in the :attr:`index`. For each value in :attr:`src`, the reduction
 |      operation is applied to an index in :attr:`self` which is specified by
 |      its index in :attr:`src` for ``dimension != dim`` and by the corresponding
 |      value in :attr:`index` for ``dimension = dim``.
 |      
 |      Given a 3-D tensor and reduction using the multiplication operation, :attr:`self`
 |      is updated as::
 |      
 |          self[index[i][j][k]][j][k] *= src[i][j][k]  # if dim == 0
 |          self[i][index[i][j][k]][k] *= src[i][j][k]  # if dim == 1
 |          self[i][j][index[i][j][k]] *= src[i][j][k]  # if dim == 2
 |      
 |      Reducing with the addition operation is the same as using
 |      :meth:`~torch.Tensor.scatter_add_`.
 |      
 |      .. warning::
 |          The reduce argument with Tensor ``src`` is deprecated and will be removed in
 |          a future PyTorch release. Please use :meth:`~torch.Tensor.scatter_reduce_`
 |          instead for more reduction options.
 |      
 |      Args:
 |          dim (int): the axis along which to index
 |          index (LongTensor): the indices of elements to scatter, can be either empty
 |              or of the same dimensionality as ``src``. When empty, the operation
 |              returns ``self`` unchanged.
 |          src (Tensor): the source element(s) to scatter.
 |      
 |      Keyword args:
 |          reduce (str, optional): reduction operation to apply, can be either
 |              ``'add'`` or ``'multiply'``.
 |      
 |      Example::
 |      
 |          >>> src = torch.arange(1, 11).reshape((2, 5))
 |          >>> src
 |          tensor([[ 1,  2,  3,  4,  5],
 |                  [ 6,  7,  8,  9, 10]])
 |          >>> index = torch.tensor([[0, 1, 2, 0]])
 |          >>> torch.zeros(3, 5, dtype=src.dtype).scatter_(0, index, src)
 |          tensor([[1, 0, 0, 4, 0],
 |                  [0, 2, 0, 0, 0],
 |                  [0, 0, 3, 0, 0]])
 |          >>> index = torch.tensor([[0, 1, 2], [0, 1, 4]])
 |          >>> torch.zeros(3, 5, dtype=src.dtype).scatter_(1, index, src)
 |          tensor([[1, 2, 3, 0, 0],
 |                  [6, 7, 0, 0, 8],
 |                  [0, 0, 0, 0, 0]])
 |      
 |          >>> torch.full((2, 4), 2.).scatter_(1, torch.tensor([[2], [3]]),
 |          ...            1.23, reduce='multiply')
 |          tensor([[2.0000, 2.0000, 2.4600, 2.0000],
 |                  [2.0000, 2.0000, 2.0000, 2.4600]])
 |          >>> torch.full((2, 4), 2.).scatter_(1, torch.tensor([[2], [3]]),
 |          ...            1.23, reduce='add')
 |          tensor([[2.0000, 2.0000, 3.2300, 2.0000],
 |                  [2.0000, 2.0000, 2.0000, 3.2300]])
 |      
 |      .. function:: scatter_(dim, index, value, *, reduce=None) -> Tensor:
 |         :noindex:
 |      
 |      Writes the value from :attr:`value` into :attr:`self` at the indices
 |      specified in the :attr:`index` tensor.  This operation is equivalent to the previous version,
 |      with the :attr:`src` tensor filled entirely with :attr:`value`.
 |      
 |      Args:
 |          dim (int): the axis along which to index
 |          index (LongTensor): the indices of elements to scatter, can be either empty
 |              or of the same dimensionality as ``src``. When empty, the operation
 |              returns ``self`` unchanged.
 |          value (Scalar): the value to scatter.
 |      
 |      Keyword args:
 |          reduce (str, optional): reduction operation to apply, can be either
 |              ``'add'`` or ``'multiply'``.
 |      
 |      Example::
 |      
 |          >>> index = torch.tensor([[0, 1]])
 |          >>> value = 2
 |          >>> torch.zeros(3, 5).scatter_(0, index, value)
 |          tensor([[2., 0., 0., 0., 0.],
 |                  [0., 2., 0., 0., 0.],
 |                  [0., 0., 0., 0., 0.]])
 |  
 |  scatter_add(...)
 |      scatter_add(dim, index, src) -> Tensor
 |      
 |      Out-of-place version of :meth:`torch.Tensor.scatter_add_`
 |  
 |  scatter_add_(...)
 |      scatter_add_(dim, index, src) -> Tensor
 |      
 |      Adds all values from the tensor :attr:`src` into :attr:`self` at the indices
 |      specified in the :attr:`index` tensor in a similar fashion as
 |      :meth:`~torch.Tensor.scatter_`. For each value in :attr:`src`, it is added to
 |      an index in :attr:`self` which is specified by its index in :attr:`src`
 |      for ``dimension != dim`` and by the corresponding value in :attr:`index` for
 |      ``dimension = dim``.
 |      
 |      For a 3-D tensor, :attr:`self` is updated as::
 |      
 |          self[index[i][j][k]][j][k] += src[i][j][k]  # if dim == 0
 |          self[i][index[i][j][k]][k] += src[i][j][k]  # if dim == 1
 |          self[i][j][index[i][j][k]] += src[i][j][k]  # if dim == 2
 |      
 |      :attr:`self`, :attr:`index` and :attr:`src` should have same number of
 |      dimensions. It is also required that ``index.size(d) <= src.size(d)`` for all
 |      dimensions ``d``, and that ``index.size(d) <= self.size(d)`` for all dimensions
 |      ``d != dim``. Note that ``index`` and ``src`` do not broadcast.
 |      
 |      Note:
 |          This operation may behave nondeterministically when given tensors on a CUDA device. See :doc:`/notes/randomness` for more information.
 |      
 |      .. note::
 |      
 |          The backward pass is implemented only for ``src.shape == index.shape``.
 |      
 |      Args:
 |          dim (int): the axis along which to index
 |          index (LongTensor): the indices of elements to scatter and add, can be
 |              either empty or of the same dimensionality as ``src``. When empty, the
 |              operation returns ``self`` unchanged.
 |          src (Tensor): the source elements to scatter and add
 |      
 |      Example::
 |      
 |          >>> src = torch.ones((2, 5))
 |          >>> index = torch.tensor([[0, 1, 2, 0, 0]])
 |          >>> torch.zeros(3, 5, dtype=src.dtype).scatter_add_(0, index, src)
 |          tensor([[1., 0., 0., 1., 1.],
 |                  [0., 1., 0., 0., 0.],
 |                  [0., 0., 1., 0., 0.]])
 |          >>> index = torch.tensor([[0, 1, 2, 0, 0], [0, 1, 2, 2, 2]])
 |          >>> torch.zeros(3, 5, dtype=src.dtype).scatter_add_(0, index, src)
 |          tensor([[2., 0., 0., 1., 1.],
 |                  [0., 2., 0., 0., 0.],
 |                  [0., 0., 2., 1., 1.]])
 |  
 |  scatter_reduce(...)
 |      scatter_reduce(dim, index, src, reduce, *, include_self=True) -> Tensor
 |      
 |      Out-of-place version of :meth:`torch.Tensor.scatter_reduce_`
 |  
 |  scatter_reduce_(...)
 |      scatter_reduce_(dim, index, src, reduce, *, include_self=True) -> Tensor
 |      
 |      Reduces all values from the :attr:`src` tensor to the indices specified in
 |      the :attr:`index` tensor in the :attr:`self` tensor using the applied reduction
 |      defined via the :attr:`reduce` argument (:obj:`"sum"`, :obj:`"prod"`, :obj:`"mean"`,
 |      :obj:`"amax"`, :obj:`"amin"`). For each value in :attr:`src`, it is reduced to an
 |      index in :attr:`self` which is specified by its index in :attr:`src` for
 |      ``dimension != dim`` and by the corresponding value in :attr:`index` for
 |      ``dimension = dim``. If :obj:`include_self="True"`, the values in the :attr:`self`
 |      tensor are included in the reduction.
 |      
 |      :attr:`self`, :attr:`index` and :attr:`src` should all have
 |      the same number of dimensions. It is also required that
 |      ``index.size(d) <= src.size(d)`` for all dimensions ``d``, and that
 |      ``index.size(d) <= self.size(d)`` for all dimensions ``d != dim``.
 |      Note that ``index`` and ``src`` do not broadcast.
 |      
 |      For a 3-D tensor with :obj:`reduce="sum"` and :obj:`include_self=True` the
 |      output is given as::
 |      
 |          self[index[i][j][k]][j][k] += src[i][j][k]  # if dim == 0
 |          self[i][index[i][j][k]][k] += src[i][j][k]  # if dim == 1
 |          self[i][j][index[i][j][k]] += src[i][j][k]  # if dim == 2
 |      
 |      Note:
 |          This operation may behave nondeterministically when given tensors on a CUDA device. See :doc:`/notes/randomness` for more information.
 |      
 |      .. note::
 |      
 |          The backward pass is implemented only for ``src.shape == index.shape``.
 |      
 |      .. warning::
 |      
 |          This function is in beta and may change in the near future.
 |      
 |      Args:
 |          dim (int): the axis along which to index
 |          index (LongTensor): the indices of elements to scatter and reduce.
 |          src (Tensor): the source elements to scatter and reduce
 |          reduce (str): the reduction operation to apply for non-unique indices
 |              (:obj:`"sum"`, :obj:`"prod"`, :obj:`"mean"`, :obj:`"amax"`, :obj:`"amin"`)
 |          include_self (bool): whether elements from the :attr:`self` tensor are
 |              included in the reduction
 |      
 |      Example::
 |      
 |          >>> src = torch.tensor([1., 2., 3., 4., 5., 6.])
 |          >>> index = torch.tensor([0, 1, 0, 1, 2, 1])
 |          >>> input = torch.tensor([1., 2., 3., 4.])
 |          >>> input.scatter_reduce(0, index, src, reduce="sum")
 |          tensor([5., 14., 8., 4.])
 |          >>> input.scatter_reduce(0, index, src, reduce="sum", include_self=False)
 |          tensor([4., 12., 5., 4.])
 |          >>> input2 = torch.tensor([5., 4., 3., 2.])
 |          >>> input2.scatter_reduce(0, index, src, reduce="amax")
 |          tensor([5., 6., 5., 2.])
 |          >>> input2.scatter_reduce(0, index, src, reduce="amax", include_self=False)
 |          tensor([3., 6., 5., 2.])
 |  
 |  select(...)
 |      select(dim, index) -> Tensor
 |      
 |      See :func:`torch.select`
 |  
 |  select_scatter(...)
 |      select_scatter(src, dim, index) -> Tensor
 |      
 |      See :func:`torch.select_scatter`
 |  
 |  set_(...)
 |      set_(source=None, storage_offset=0, size=None, stride=None) -> Tensor
 |      
 |      Sets the underlying storage, size, and strides. If :attr:`source` is a tensor,
 |      :attr:`self` tensor will share the same storage and have the same size and
 |      strides as :attr:`source`. Changes to elements in one tensor will be reflected
 |      in the other.
 |      
 |      If :attr:`source` is a :class:`~torch.Storage`, the method sets the underlying
 |      storage, offset, size, and stride.
 |      
 |      Args:
 |          source (Tensor or Storage): the tensor or storage to use
 |          storage_offset (int, optional): the offset in the storage
 |          size (torch.Size, optional): the desired size. Defaults to the size of the source.
 |          stride (tuple, optional): the desired stride. Defaults to C-contiguous strides.
 |  
 |  sgn(...)
 |      sgn() -> Tensor
 |      
 |      See :func:`torch.sgn`
 |  
 |  sgn_(...)
 |      sgn_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.sgn`
 |  
 |  short(...)
 |      short(memory_format=torch.preserve_format) -> Tensor
 |      
 |      ``self.short()`` is equivalent to ``self.to(torch.int16)``. See :func:`to`.
 |      
 |      Args:
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  sigmoid(...)
 |      sigmoid() -> Tensor
 |      
 |      See :func:`torch.sigmoid`
 |  
 |  sigmoid_(...)
 |      sigmoid_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.sigmoid`
 |  
 |  sign(...)
 |      sign() -> Tensor
 |      
 |      See :func:`torch.sign`
 |  
 |  sign_(...)
 |      sign_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.sign`
 |  
 |  signbit(...)
 |      signbit() -> Tensor
 |      
 |      See :func:`torch.signbit`
 |  
 |  sin(...)
 |      sin() -> Tensor
 |      
 |      See :func:`torch.sin`
 |  
 |  sin_(...)
 |      sin_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.sin`
 |  
 |  sinc(...)
 |      sinc() -> Tensor
 |      
 |      See :func:`torch.sinc`
 |  
 |  sinc_(...)
 |      sinc_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.sinc`
 |  
 |  sinh(...)
 |      sinh() -> Tensor
 |      
 |      See :func:`torch.sinh`
 |  
 |  sinh_(...)
 |      sinh_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.sinh`
 |  
 |  size(...)
 |      size(dim=None) -> torch.Size or int
 |      
 |      Returns the size of the :attr:`self` tensor. If ``dim`` is not specified,
 |      the returned value is a :class:`torch.Size`, a subclass of :class:`tuple`.
 |      If ``dim`` is specified, returns an int holding the size of that dimension.
 |      
 |      Args:
 |        dim (int, optional): The dimension for which to retrieve the size.
 |      
 |      Example::
 |      
 |          >>> t = torch.empty(3, 4, 5)
 |          >>> t.size()
 |          torch.Size([3, 4, 5])
 |          >>> t.size(dim=1)
 |          4
 |  
 |  slice_inverse(...)
 |  
 |  slice_scatter(...)
 |      slice_scatter(src, dim=0, start=None, end=None, step=1) -> Tensor
 |      
 |      See :func:`torch.slice_scatter`
 |  
 |  slogdet(...)
 |      slogdet() -> (Tensor, Tensor)
 |      
 |      See :func:`torch.slogdet`
 |  
 |  smm(...)
 |      smm(mat) -> Tensor
 |      
 |      See :func:`torch.smm`
 |  
 |  softmax(...)
 |      softmax(dim) -> Tensor
 |      
 |      Alias for :func:`torch.nn.functional.softmax`.
 |  
 |  sort(...)
 |      sort(dim=-1, descending=False) -> (Tensor, LongTensor)
 |      
 |      See :func:`torch.sort`
 |  
 |  sparse_dim(...)
 |      sparse_dim() -> int
 |      
 |      Return the number of sparse dimensions in a :ref:`sparse tensor <sparse-docs>` :attr:`self`.
 |      
 |      .. note::
 |        Returns ``0`` if :attr:`self` is not a sparse tensor.
 |      
 |      See also :meth:`Tensor.dense_dim` and :ref:`hybrid tensors <sparse-hybrid-coo-docs>`.
 |  
 |  sparse_mask(...)
 |      sparse_mask(mask) -> Tensor
 |      
 |      Returns a new :ref:`sparse tensor <sparse-docs>` with values from a
 |      strided tensor :attr:`self` filtered by the indices of the sparse
 |      tensor :attr:`mask`. The values of :attr:`mask` sparse tensor are
 |      ignored. :attr:`self` and :attr:`mask` tensors must have the same
 |      shape.
 |      
 |      .. note::
 |      
 |        The returned sparse tensor might contain duplicate values if :attr:`mask`
 |        is not coalesced. It is therefore advisable to pass ``mask.coalesce()``
 |        if such behavior is not desired.
 |      
 |      .. note::
 |      
 |        The returned sparse tensor has the same indices as the sparse tensor
 |        :attr:`mask`, even when the corresponding values in :attr:`self` are
 |        zeros.
 |      
 |      Args:
 |          mask (Tensor): a sparse tensor whose indices are used as a filter
 |      
 |      Example::
 |      
 |          >>> nse = 5
 |          >>> dims = (5, 5, 2, 2)
 |          >>> I = torch.cat([torch.randint(0, dims[0], size=(nse,)),
 |          ...                torch.randint(0, dims[1], size=(nse,))], 0).reshape(2, nse)
 |          >>> V = torch.randn(nse, dims[2], dims[3])
 |          >>> S = torch.sparse_coo_tensor(I, V, dims).coalesce()
 |          >>> D = torch.randn(dims)
 |          >>> D.sparse_mask(S)
 |          tensor(indices=tensor([[0, 0, 0, 2],
 |                                 [0, 1, 4, 3]]),
 |                 values=tensor([[[ 1.6550,  0.2397],
 |                                 [-0.1611, -0.0779]],
 |      
 |                                [[ 0.2326, -1.0558],
 |                                 [ 1.4711,  1.9678]],
 |      
 |                                [[-0.5138, -0.0411],
 |                                 [ 1.9417,  0.5158]],
 |      
 |                                [[ 0.0793,  0.0036],
 |                                 [-0.2569, -0.1055]]]),
 |                 size=(5, 5, 2, 2), nnz=4, layout=torch.sparse_coo)
 |  
 |  sparse_resize_(...)
 |      sparse_resize_(size, sparse_dim, dense_dim) -> Tensor
 |      
 |      Resizes :attr:`self` :ref:`sparse tensor <sparse-docs>` to the desired
 |      size and the number of sparse and dense dimensions.
 |      
 |      .. note::
 |        If the number of specified elements in :attr:`self` is zero, then
 |        :attr:`size`, :attr:`sparse_dim`, and :attr:`dense_dim` can be any
 |        size and positive integers such that ``len(size) == sparse_dim +
 |        dense_dim``.
 |      
 |        If :attr:`self` specifies one or more elements, however, then each
 |        dimension in :attr:`size` must not be smaller than the corresponding
 |        dimension of :attr:`self`, :attr:`sparse_dim` must equal the number
 |        of sparse dimensions in :attr:`self`, and :attr:`dense_dim` must
 |        equal the number of dense dimensions in :attr:`self`.
 |      
 |      .. warning::
 |        Throws an error if :attr:`self` is not a sparse tensor.
 |      
 |      Args:
 |          size (torch.Size): the desired size. If :attr:`self` is non-empty
 |            sparse tensor, the desired size cannot be smaller than the
 |            original size.
 |          sparse_dim (int): the number of sparse dimensions
 |          dense_dim (int): the number of dense dimensions
 |  
 |  sparse_resize_and_clear_(...)
 |      sparse_resize_and_clear_(size, sparse_dim, dense_dim) -> Tensor
 |      
 |      Removes all specified elements from a :ref:`sparse tensor
 |      <sparse-docs>` :attr:`self` and resizes :attr:`self` to the desired
 |      size and the number of sparse and dense dimensions.
 |      
 |      .. warning:
 |        Throws an error if :attr:`self` is not a sparse tensor.
 |      
 |      Args:
 |          size (torch.Size): the desired size.
 |          sparse_dim (int): the number of sparse dimensions
 |          dense_dim (int): the number of dense dimensions
 |  
 |  split_with_sizes(...)
 |  
 |  sqrt(...)
 |      sqrt() -> Tensor
 |      
 |      See :func:`torch.sqrt`
 |  
 |  sqrt_(...)
 |      sqrt_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.sqrt`
 |  
 |  square(...)
 |      square() -> Tensor
 |      
 |      See :func:`torch.square`
 |  
 |  square_(...)
 |      square_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.square`
 |  
 |  squeeze(...)
 |      squeeze(dim=None) -> Tensor
 |      
 |      See :func:`torch.squeeze`
 |  
 |  squeeze_(...)
 |      squeeze_(dim=None) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.squeeze`
 |  
 |  sspaddmm(...)
 |      sspaddmm(mat1, mat2, *, beta=1, alpha=1) -> Tensor
 |      
 |      See :func:`torch.sspaddmm`
 |  
 |  std(...)
 |      std(dim=None, *, correction=1, keepdim=False) -> Tensor
 |      
 |      See :func:`torch.std`
 |  
 |  storage_offset(...)
 |      storage_offset() -> int
 |      
 |      Returns :attr:`self` tensor's offset in the underlying storage in terms of
 |      number of storage elements (not bytes).
 |      
 |      Example::
 |      
 |          >>> x = torch.tensor([1, 2, 3, 4, 5])
 |          >>> x.storage_offset()
 |          0
 |          >>> x[3:].storage_offset()
 |          3
 |  
 |  stride(...)
 |      stride(dim) -> tuple or int
 |      
 |      Returns the stride of :attr:`self` tensor.
 |      
 |      Stride is the jump necessary to go from one element to the next one in the
 |      specified dimension :attr:`dim`. A tuple of all strides is returned when no
 |      argument is passed in. Otherwise, an integer value is returned as the stride in
 |      the particular dimension :attr:`dim`.
 |      
 |      Args:
 |          dim (int, optional): the desired dimension in which stride is required
 |      
 |      Example::
 |      
 |          >>> x = torch.tensor([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10]])
 |          >>> x.stride()
 |          (5, 1)
 |          >>> x.stride(0)
 |          5
 |          >>> x.stride(-1)
 |          1
 |  
 |  sub(...)
 |      sub(other, *, alpha=1) -> Tensor
 |      
 |      See :func:`torch.sub`.
 |  
 |  sub_(...)
 |      sub_(other, *, alpha=1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.sub`
 |  
 |  subtract(...)
 |      subtract(other, *, alpha=1) -> Tensor
 |      
 |      See :func:`torch.subtract`.
 |  
 |  subtract_(...)
 |      subtract_(other, *, alpha=1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.subtract`.
 |  
 |  sum(...)
 |      sum(dim=None, keepdim=False, dtype=None) -> Tensor
 |      
 |      See :func:`torch.sum`
 |  
 |  sum_to_size(...)
 |      sum_to_size(*size) -> Tensor
 |      
 |      Sum ``this`` tensor to :attr:`size`.
 |      :attr:`size` must be broadcastable to ``this`` tensor size.
 |      
 |      Args:
 |          size (int...): a sequence of integers defining the shape of the output tensor.
 |  
 |  svd(...)
 |      svd(some=True, compute_uv=True) -> (Tensor, Tensor, Tensor)
 |      
 |      See :func:`torch.svd`
 |  
 |  swapaxes(...)
 |      swapaxes(axis0, axis1) -> Tensor
 |      
 |      See :func:`torch.swapaxes`
 |  
 |  swapaxes_(...)
 |      swapaxes_(axis0, axis1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.swapaxes`
 |  
 |  swapdims(...)
 |      swapdims(dim0, dim1) -> Tensor
 |      
 |      See :func:`torch.swapdims`
 |  
 |  swapdims_(...)
 |      swapdims_(dim0, dim1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.swapdims`
 |  
 |  t(...)
 |      t() -> Tensor
 |      
 |      See :func:`torch.t`
 |  
 |  t_(...)
 |      t_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.t`
 |  
 |  take(...)
 |      take(indices) -> Tensor
 |      
 |      See :func:`torch.take`
 |  
 |  take_along_dim(...)
 |      take_along_dim(indices, dim) -> Tensor
 |      
 |      See :func:`torch.take_along_dim`
 |  
 |  tan(...)
 |      tan() -> Tensor
 |      
 |      See :func:`torch.tan`
 |  
 |  tan_(...)
 |      tan_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.tan`
 |  
 |  tanh(...)
 |      tanh() -> Tensor
 |      
 |      See :func:`torch.tanh`
 |  
 |  tanh_(...)
 |      tanh_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.tanh`
 |  
 |  tensor_split(...)
 |      tensor_split(indices_or_sections, dim=0) -> List of Tensors
 |      
 |      See :func:`torch.tensor_split`
 |  
 |  tile(...)
 |      tile(dims) -> Tensor
 |      
 |      See :func:`torch.tile`
 |  
 |  to(...)
 |      to(*args, **kwargs) -> Tensor
 |      
 |      Performs Tensor dtype and/or device conversion. A :class:`torch.dtype` and :class:`torch.device` are
 |      inferred from the arguments of ``self.to(*args, **kwargs)``.
 |      
 |      .. note::
 |      
 |          If the ``self`` Tensor already
 |          has the correct :class:`torch.dtype` and :class:`torch.device`, then ``self`` is returned.
 |          Otherwise, the returned tensor is a copy of ``self`` with the desired
 |          :class:`torch.dtype` and :class:`torch.device`.
 |      
 |      Here are the ways to call ``to``:
 |      
 |      .. method:: to(dtype, non_blocking=False, copy=False, memory_format=torch.preserve_format) -> Tensor
 |         :noindex:
 |      
 |          Returns a Tensor with the specified :attr:`dtype`
 |      
 |          Args:
 |              memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |      
 |      .. method:: to(device=None, dtype=None, non_blocking=False, copy=False, memory_format=torch.preserve_format) -> Tensor
 |         :noindex:
 |      
 |          Returns a Tensor with the specified :attr:`device` and (optional)
 |          :attr:`dtype`. If :attr:`dtype` is ``None`` it is inferred to be ``self.dtype``.
 |          When :attr:`non_blocking`, tries to convert asynchronously with respect to
 |          the host if possible, e.g., converting a CPU Tensor with pinned memory to a
 |          CUDA Tensor.
 |          When :attr:`copy` is set, a new Tensor is created even when the Tensor
 |          already matches the desired conversion.
 |      
 |          Args:
 |              memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |      
 |      .. method:: to(other, non_blocking=False, copy=False) -> Tensor
 |         :noindex:
 |      
 |          Returns a Tensor with same :class:`torch.dtype` and :class:`torch.device` as
 |          the Tensor :attr:`other`. When :attr:`non_blocking`, tries to convert
 |          asynchronously with respect to the host if possible, e.g., converting a CPU
 |          Tensor with pinned memory to a CUDA Tensor.
 |          When :attr:`copy` is set, a new Tensor is created even when the Tensor
 |          already matches the desired conversion.
 |      
 |      Example::
 |      
 |          >>> tensor = torch.randn(2, 2)  # Initially dtype=float32, device=cpu
 |          >>> tensor.to(torch.float64)
 |          tensor([[-0.5044,  0.0005],
 |                  [ 0.3310, -0.0584]], dtype=torch.float64)
 |      
 |          >>> cuda0 = torch.device('cuda:0')
 |          >>> tensor.to(cuda0)
 |          tensor([[-0.5044,  0.0005],
 |                  [ 0.3310, -0.0584]], device='cuda:0')
 |      
 |          >>> tensor.to(cuda0, dtype=torch.float64)
 |          tensor([[-0.5044,  0.0005],
 |                  [ 0.3310, -0.0584]], dtype=torch.float64, device='cuda:0')
 |      
 |          >>> other = torch.randn((), dtype=torch.float64, device=cuda0)
 |          >>> tensor.to(other, non_blocking=True)
 |          tensor([[-0.5044,  0.0005],
 |                  [ 0.3310, -0.0584]], dtype=torch.float64, device='cuda:0')
 |  
 |  to_dense(...)
 |      to_dense(dtype=None, *, masked_grad=True) -> Tensor
 |      
 |      Creates a strided copy of :attr:`self` if :attr:`self` is not a strided tensor, otherwise returns :attr:`self`.
 |      
 |      Keyword args:
 |          {dtype}
 |          masked_grad (bool, optional): If set to ``True`` (default) and
 |            :attr:`self` has a sparse layout then the backward of
 |            :meth:`to_dense` returns ``grad.sparse_mask(self)``.
 |      
 |      Example::
 |      
 |          >>> s = torch.sparse_coo_tensor(
 |          ...        torch.tensor([[1, 1],
 |          ...                      [0, 2]]),
 |          ...        torch.tensor([9, 10]),
 |          ...        size=(3, 3))
 |          >>> s.to_dense()
 |          tensor([[ 0,  0,  0],
 |                  [ 9,  0, 10],
 |                  [ 0,  0,  0]])
 |  
 |  to_mkldnn(...)
 |      to_mkldnn() -> Tensor
 |      Returns a copy of the tensor in ``torch.mkldnn`` layout.
 |  
 |  to_padded_tensor(...)
 |      to_padded_tensor(padding, output_size=None) -> Tensor
 |      See :func:`to_padded_tensor`
 |  
 |  to_sparse(...)
 |      to_sparse(sparseDims) -> Tensor
 |      
 |      Returns a sparse copy of the tensor.  PyTorch supports sparse tensors in
 |      :ref:`coordinate format <sparse-coo-docs>`.
 |      
 |      Args:
 |          sparseDims (int, optional): the number of sparse dimensions to include in the new sparse tensor
 |      
 |      Example::
 |      
 |          >>> d = torch.tensor([[0, 0, 0], [9, 0, 10], [0, 0, 0]])
 |          >>> d
 |          tensor([[ 0,  0,  0],
 |                  [ 9,  0, 10],
 |                  [ 0,  0,  0]])
 |          >>> d.to_sparse()
 |          tensor(indices=tensor([[1, 1],
 |                                 [0, 2]]),
 |                 values=tensor([ 9, 10]),
 |                 size=(3, 3), nnz=2, layout=torch.sparse_coo)
 |          >>> d.to_sparse(1)
 |          tensor(indices=tensor([[1]]),
 |                 values=tensor([[ 9,  0, 10]]),
 |                 size=(3, 3), nnz=1, layout=torch.sparse_coo)
 |      
 |      .. method:: to_sparse(*, layout=None, blocksize=None, dense_dim=None) -> Tensor
 |         :noindex:
 |      
 |      Returns a sparse tensor with the specified layout and blocksize.  If
 |      the :attr:`self` is strided, the number of dense dimensions could be
 |      specified, and a hybrid sparse tensor will be created, with
 |      `dense_dim` dense dimensions and `self.dim() - 2 - dense_dim` batch
 |      dimension.
 |      
 |      .. note:: If the :attr:`self` layout and blocksize parameters match
 |                with the specified layout and blocksize, return
 |                :attr:`self`. Otherwise, return a sparse tensor copy of
 |                :attr:`self`.
 |      
 |      Args:
 |      
 |          layout (:class:`torch.layout`, optional): The desired sparse
 |            layout. One of ``torch.sparse_coo``, ``torch.sparse_csr``,
 |            ``torch.sparse_csc``, ``torch.sparse_bsr``, or
 |            ``torch.sparse_bsc``. Default: if ``None``,
 |            ``torch.sparse_coo``.
 |      
 |          blocksize (list, tuple, :class:`torch.Size`, optional): Block size
 |            of the resulting BSR or BSC tensor. For other layouts,
 |            specifying the block size that is not ``None`` will result in a
 |            RuntimeError exception.  A block size must be a tuple of length
 |            two such that its items evenly divide the two sparse dimensions.
 |      
 |          dense_dim (int, optional): Number of dense dimensions of the
 |            resulting CSR, CSC, BSR or BSC tensor.  This argument should be
 |            used only if :attr:`self` is a strided tensor, and must be a
 |            value between 0 and dimension of :attr:`self` tensor minus two.
 |      
 |      Example::
 |      
 |          >>> x = torch.tensor([[1, 0], [0, 0], [2, 3]])
 |          >>> x.to_sparse(layout=torch.sparse_coo)
 |          tensor(indices=tensor([[0, 2, 2],
 |                                 [0, 0, 1]]),
 |                 values=tensor([1, 2, 3]),
 |                 size=(3, 2), nnz=3, layout=torch.sparse_coo)
 |          >>> x.to_sparse(layout=torch.sparse_bsr, blocksize=(1, 2))
 |          tensor(crow_indices=tensor([0, 1, 1, 2]),
 |                 col_indices=tensor([0, 0]),
 |                 values=tensor([[[1, 0]],
 |                                [[2, 3]]]), size=(3, 2), nnz=2, layout=torch.sparse_bsr)
 |          >>> x.to_sparse(layout=torch.sparse_bsr, blocksize=(2, 1))
 |          RuntimeError: Tensor size(-2) 3 needs to be divisible by blocksize[0] 2
 |          >>> x.to_sparse(layout=torch.sparse_csr, blocksize=(3, 1))
 |          RuntimeError: to_sparse for Strided to SparseCsr conversion does not use specified blocksize
 |      
 |          >>> x = torch.tensor([[[1], [0]], [[0], [0]], [[2], [3]]])
 |          >>> x.to_sparse(layout=torch.sparse_csr, dense_dim=1)
 |          tensor(crow_indices=tensor([0, 1, 1, 3]),
 |                 col_indices=tensor([0, 0, 1]),
 |                 values=tensor([[1],
 |                                [2],
 |                                [3]]), size=(3, 2, 1), nnz=3, layout=torch.sparse_csr)
 |  
 |  to_sparse_bsc(...)
 |      to_sparse_bsc(blocksize, dense_dim) -> Tensor
 |      
 |      Convert a tensor to a block sparse column (BSC) storage format of
 |      given blocksize.  If the :attr:`self` is strided, then the number of
 |      dense dimensions could be specified, and a hybrid BSC tensor will be
 |      created, with `dense_dim` dense dimensions and `self.dim() - 2 -
 |      dense_dim` batch dimension.
 |      
 |      Args:
 |      
 |          blocksize (list, tuple, :class:`torch.Size`, optional): Block size
 |            of the resulting BSC tensor. A block size must be a tuple of
 |            length two such that its items evenly divide the two sparse
 |            dimensions.
 |      
 |          dense_dim (int, optional): Number of dense dimensions of the
 |            resulting BSC tensor.  This argument should be used only if
 |            :attr:`self` is a strided tensor, and must be a value between 0
 |            and dimension of :attr:`self` tensor minus two.
 |      
 |      Example::
 |      
 |          >>> dense = torch.randn(10, 10)
 |          >>> sparse = dense.to_sparse_csr()
 |          >>> sparse_bsc = sparse.to_sparse_bsc((5, 5))
 |          >>> sparse_bsc.row_indices()
 |          tensor([0, 1, 0, 1])
 |      
 |          >>> dense = torch.zeros(4, 3, 1)
 |          >>> dense[0:2, 0] = dense[0:2, 2] = dense[2:4, 1] = 1
 |          >>> dense.to_sparse_bsc((2, 1), 1)
 |          tensor(ccol_indices=tensor([0, 1, 2, 3]),
 |                 row_indices=tensor([0, 1, 0]),
 |                 values=tensor([[[[1.]],
 |      
 |                                 [[1.]]],
 |      
 |      
 |                                [[[1.]],
 |      
 |                                 [[1.]]],
 |      
 |      
 |                                [[[1.]],
 |      
 |                                 [[1.]]]]), size=(4, 3, 1), nnz=3,
 |                 layout=torch.sparse_bsc)
 |  
 |  to_sparse_bsr(...)
 |      to_sparse_bsr(blocksize, dense_dim) -> Tensor
 |      
 |      Convert a tensor to a block sparse row (BSR) storage format of given
 |      blocksize.  If the :attr:`self` is strided, then the number of dense
 |      dimensions could be specified, and a hybrid BSR tensor will be
 |      created, with `dense_dim` dense dimensions and `self.dim() - 2 -
 |      dense_dim` batch dimension.
 |      
 |      Args:
 |      
 |          blocksize (list, tuple, :class:`torch.Size`, optional): Block size
 |            of the resulting BSR tensor. A block size must be a tuple of
 |            length two such that its items evenly divide the two sparse
 |            dimensions.
 |      
 |          dense_dim (int, optional): Number of dense dimensions of the
 |            resulting BSR tensor.  This argument should be used only if
 |            :attr:`self` is a strided tensor, and must be a value between 0
 |            and dimension of :attr:`self` tensor minus two.
 |      
 |      Example::
 |      
 |          >>> dense = torch.randn(10, 10)
 |          >>> sparse = dense.to_sparse_csr()
 |          >>> sparse_bsr = sparse.to_sparse_bsr((5, 5))
 |          >>> sparse_bsr.col_indices()
 |          tensor([0, 1, 0, 1])
 |      
 |          >>> dense = torch.zeros(4, 3, 1)
 |          >>> dense[0:2, 0] = dense[0:2, 2] = dense[2:4, 1] = 1
 |          >>> dense.to_sparse_bsr((2, 1), 1)
 |          tensor(crow_indices=tensor([0, 2, 3]),
 |                 col_indices=tensor([0, 2, 1]),
 |                 values=tensor([[[[1.]],
 |      
 |                                 [[1.]]],
 |      
 |      
 |                                [[[1.]],
 |      
 |                                 [[1.]]],
 |      
 |      
 |                                [[[1.]],
 |      
 |                                 [[1.]]]]), size=(4, 3, 1), nnz=3,
 |                 layout=torch.sparse_bsr)
 |  
 |  to_sparse_csc(...)
 |      to_sparse_csc() -> Tensor
 |      
 |      Convert a tensor to compressed column storage (CSC) format.  Except
 |      for strided tensors, only works with 2D tensors.  If the :attr:`self`
 |      is strided, then the number of dense dimensions could be specified,
 |      and a hybrid CSC tensor will be created, with `dense_dim` dense
 |      dimensions and `self.dim() - 2 - dense_dim` batch dimension.
 |      
 |      Args:
 |      
 |          dense_dim (int, optional): Number of dense dimensions of the
 |            resulting CSC tensor.  This argument should be used only if
 |            :attr:`self` is a strided tensor, and must be a value between 0
 |            and dimension of :attr:`self` tensor minus two.
 |      
 |      Example::
 |      
 |          >>> dense = torch.randn(5, 5)
 |          >>> sparse = dense.to_sparse_csc()
 |          >>> sparse._nnz()
 |          25
 |      
 |          >>> dense = torch.zeros(3, 3, 1, 1)
 |          >>> dense[0, 0] = dense[1, 2] = dense[2, 1] = 1
 |          >>> dense.to_sparse_csc(dense_dim=2)
 |          tensor(ccol_indices=tensor([0, 1, 2, 3]),
 |                 row_indices=tensor([0, 2, 1]),
 |                 values=tensor([[[1.]],
 |      
 |                                [[1.]],
 |      
 |                                [[1.]]]), size=(3, 3, 1, 1), nnz=3,
 |                 layout=torch.sparse_csc)
 |  
 |  to_sparse_csr(...)
 |      to_sparse_csr(dense_dim=None) -> Tensor
 |      
 |      Convert a tensor to compressed row storage format (CSR).  Except for
 |      strided tensors, only works with 2D tensors.  If the :attr:`self` is
 |      strided, then the number of dense dimensions could be specified, and a
 |      hybrid CSR tensor will be created, with `dense_dim` dense dimensions
 |      and `self.dim() - 2 - dense_dim` batch dimension.
 |      
 |      Args:
 |      
 |          dense_dim (int, optional): Number of dense dimensions of the
 |            resulting CSR tensor.  This argument should be used only if
 |            :attr:`self` is a strided tensor, and must be a value between 0
 |            and dimension of :attr:`self` tensor minus two.
 |      
 |      Example::
 |      
 |          >>> dense = torch.randn(5, 5)
 |          >>> sparse = dense.to_sparse_csr()
 |          >>> sparse._nnz()
 |          25
 |      
 |          >>> dense = torch.zeros(3, 3, 1, 1)
 |          >>> dense[0, 0] = dense[1, 2] = dense[2, 1] = 1
 |          >>> dense.to_sparse_csr(dense_dim=2)
 |          tensor(crow_indices=tensor([0, 1, 2, 3]),
 |                 col_indices=tensor([0, 2, 1]),
 |                 values=tensor([[[1.]],
 |      
 |                                [[1.]],
 |      
 |                                [[1.]]]), size=(3, 3, 1, 1), nnz=3,
 |                 layout=torch.sparse_csr)
 |  
 |  tolist(...)
 |      tolist() -> list or number
 |      
 |      Returns the tensor as a (nested) list. For scalars, a standard
 |      Python number is returned, just like with :meth:`~Tensor.item`.
 |      Tensors are automatically moved to the CPU first if necessary.
 |      
 |      This operation is not differentiable.
 |      
 |      Examples::
 |      
 |          >>> a = torch.randn(2, 2)
 |          >>> a.tolist()
 |          [[0.012766935862600803, 0.5415473580360413],
 |           [-0.08909505605697632, 0.7729271650314331]]
 |          >>> a[0,0].tolist()
 |          0.012766935862600803
 |  
 |  topk(...)
 |      topk(k, dim=None, largest=True, sorted=True) -> (Tensor, LongTensor)
 |      
 |      See :func:`torch.topk`
 |  
 |  trace(...)
 |      trace() -> Tensor
 |      
 |      See :func:`torch.trace`
 |  
 |  transpose(...)
 |      transpose(dim0, dim1) -> Tensor
 |      
 |      See :func:`torch.transpose`
 |  
 |  transpose_(...)
 |      transpose_(dim0, dim1) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.transpose`
 |  
 |  triangular_solve(...)
 |      triangular_solve(A, upper=True, transpose=False, unitriangular=False) -> (Tensor, Tensor)
 |      
 |      See :func:`torch.triangular_solve`
 |  
 |  tril(...)
 |      tril(diagonal=0) -> Tensor
 |      
 |      See :func:`torch.tril`
 |  
 |  tril_(...)
 |      tril_(diagonal=0) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.tril`
 |  
 |  triu(...)
 |      triu(diagonal=0) -> Tensor
 |      
 |      See :func:`torch.triu`
 |  
 |  triu_(...)
 |      triu_(diagonal=0) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.triu`
 |  
 |  true_divide(...)
 |      true_divide(value) -> Tensor
 |      
 |      See :func:`torch.true_divide`
 |  
 |  true_divide_(...)
 |      true_divide_(value) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.true_divide_`
 |  
 |  trunc(...)
 |      trunc() -> Tensor
 |      
 |      See :func:`torch.trunc`
 |  
 |  trunc_(...)
 |      trunc_() -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.trunc`
 |  
 |  type(...)
 |      type(dtype=None, non_blocking=False, **kwargs) -> str or Tensor
 |      Returns the type if `dtype` is not provided, else casts this object to
 |      the specified type.
 |      
 |      If this is already of the correct type, no copy is performed and the
 |      original object is returned.
 |      
 |      Args:
 |          dtype (dtype or string): The desired type
 |          non_blocking (bool): If ``True``, and the source is in pinned memory
 |              and destination is on the GPU or vice versa, the copy is performed
 |              asynchronously with respect to the host. Otherwise, the argument
 |              has no effect.
 |          **kwargs: For compatibility, may contain the key ``async`` in place of
 |              the ``non_blocking`` argument. The ``async`` arg is deprecated.
 |  
 |  type_as(...)
 |      type_as(tensor) -> Tensor
 |      
 |      Returns this tensor cast to the type of the given tensor.
 |      
 |      This is a no-op if the tensor is already of the correct type. This is
 |      equivalent to ``self.type(tensor.type())``
 |      
 |      Args:
 |          tensor (Tensor): the tensor which has the desired type
 |  
 |  unbind(...)
 |      unbind(dim=0) -> seq
 |      
 |      See :func:`torch.unbind`
 |  
 |  unfold(...)
 |      unfold(dimension, size, step) -> Tensor
 |      
 |      Returns a view of the original tensor which contains all slices of size :attr:`size` from
 |      :attr:`self` tensor in the dimension :attr:`dimension`.
 |      
 |      Step between two slices is given by :attr:`step`.
 |      
 |      If `sizedim` is the size of dimension :attr:`dimension` for :attr:`self`, the size of
 |      dimension :attr:`dimension` in the returned tensor will be
 |      `(sizedim - size) / step + 1`.
 |      
 |      An additional dimension of size :attr:`size` is appended in the returned tensor.
 |      
 |      Args:
 |          dimension (int): dimension in which unfolding happens
 |          size (int): the size of each slice that is unfolded
 |          step (int): the step between each slice
 |      
 |      Example::
 |      
 |          >>> x = torch.arange(1., 8)
 |          >>> x
 |          tensor([ 1.,  2.,  3.,  4.,  5.,  6.,  7.])
 |          >>> x.unfold(0, 2, 1)
 |          tensor([[ 1.,  2.],
 |                  [ 2.,  3.],
 |                  [ 3.,  4.],
 |                  [ 4.,  5.],
 |                  [ 5.,  6.],
 |                  [ 6.,  7.]])
 |          >>> x.unfold(0, 2, 2)
 |          tensor([[ 1.,  2.],
 |                  [ 3.,  4.],
 |                  [ 5.,  6.]])
 |  
 |  uniform_(...)
 |      uniform_(from=0, to=1, *, generator=None) -> Tensor
 |      
 |      Fills :attr:`self` tensor with numbers sampled from the continuous uniform
 |      distribution:
 |      
 |      .. math::
 |          f(x) = \dfrac{1}{\text{to} - \text{from}}
 |  
 |  unsafe_chunk(...)
 |      unsafe_chunk(chunks, dim=0) -> List of Tensors
 |      
 |      See :func:`torch.unsafe_chunk`
 |  
 |  unsafe_split(...)
 |      unsafe_split(split_size, dim=0) -> List of Tensors
 |      
 |      See :func:`torch.unsafe_split`
 |  
 |  unsafe_split_with_sizes(...)
 |  
 |  unsqueeze(...)
 |      unsqueeze(dim) -> Tensor
 |      
 |      See :func:`torch.unsqueeze`
 |  
 |  unsqueeze_(...)
 |      unsqueeze_(dim) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.unsqueeze`
 |  
 |  untyped_storage(...)
 |      untyped_storage() -> torch.UntypedStorage
 |      
 |      Returns the underlying :class:`UntypedStorage`.
 |  
 |  values(...)
 |      values() -> Tensor
 |      
 |      Return the values tensor of a :ref:`sparse COO tensor <sparse-coo-docs>`.
 |      
 |      .. warning::
 |        Throws an error if :attr:`self` is not a sparse COO tensor.
 |      
 |      See also :meth:`Tensor.indices`.
 |      
 |      .. note::
 |        This method can only be called on a coalesced sparse tensor. See
 |        :meth:`Tensor.coalesce` for details.
 |  
 |  var(...)
 |      var(dim=None, *, correction=1, keepdim=False) -> Tensor
 |      
 |      See :func:`torch.var`
 |  
 |  vdot(...)
 |      vdot(other) -> Tensor
 |      
 |      See :func:`torch.vdot`
 |  
 |  view(...)
 |      view(*shape) -> Tensor
 |      
 |      Returns a new tensor with the same data as the :attr:`self` tensor but of a
 |      different :attr:`shape`.
 |      
 |      The returned tensor shares the same data and must have the same number
 |      of elements, but may have a different size. For a tensor to be viewed, the new
 |      view size must be compatible with its original size and stride, i.e., each new
 |      view dimension must either be a subspace of an original dimension, or only span
 |      across original dimensions :math:`d, d+1, \dots, d+k` that satisfy the following
 |      contiguity-like condition that :math:`\forall i = d, \dots, d+k-1`,
 |      
 |      .. math::
 |      
 |        \text{stride}[i] = \text{stride}[i+1] \times \text{size}[i+1]
 |      
 |      Otherwise, it will not be possible to view :attr:`self` tensor as :attr:`shape`
 |      without copying it (e.g., via :meth:`contiguous`). When it is unclear whether a
 |      :meth:`view` can be performed, it is advisable to use :meth:`reshape`, which
 |      returns a view if the shapes are compatible, and copies (equivalent to calling
 |      :meth:`contiguous`) otherwise.
 |      
 |      Args:
 |          shape (torch.Size or int...): the desired size
 |      
 |      Example::
 |      
 |          >>> x = torch.randn(4, 4)
 |          >>> x.size()
 |          torch.Size([4, 4])
 |          >>> y = x.view(16)
 |          >>> y.size()
 |          torch.Size([16])
 |          >>> z = x.view(-1, 8)  # the size -1 is inferred from other dimensions
 |          >>> z.size()
 |          torch.Size([2, 8])
 |      
 |          >>> a = torch.randn(1, 2, 3, 4)
 |          >>> a.size()
 |          torch.Size([1, 2, 3, 4])
 |          >>> b = a.transpose(1, 2)  # Swaps 2nd and 3rd dimension
 |          >>> b.size()
 |          torch.Size([1, 3, 2, 4])
 |          >>> c = a.view(1, 3, 2, 4)  # Does not change tensor layout in memory
 |          >>> c.size()
 |          torch.Size([1, 3, 2, 4])
 |          >>> torch.equal(b, c)
 |          False
 |      
 |      
 |      .. method:: view(dtype) -> Tensor
 |         :noindex:
 |      
 |      Returns a new tensor with the same data as the :attr:`self` tensor but of a
 |      different :attr:`dtype`.
 |      
 |      If the element size of :attr:`dtype` is different than that of ``self.dtype``,
 |      then the size of the last dimension of the output will be scaled
 |      proportionally.  For instance, if :attr:`dtype` element size is twice that of
 |      ``self.dtype``, then each pair of elements in the last dimension of
 |      :attr:`self` will be combined, and the size of the last dimension of the output
 |      will be half that of :attr:`self`. If :attr:`dtype` element size is half that
 |      of ``self.dtype``, then each element in the last dimension of :attr:`self` will
 |      be split in two, and the size of the last dimension of the output will be
 |      double that of :attr:`self`. For this to be possible, the following conditions
 |      must be true:
 |      
 |          * ``self.dim()`` must be greater than 0.
 |          * ``self.stride(-1)`` must be 1.
 |      
 |      Additionally, if the element size of :attr:`dtype` is greater than that of
 |      ``self.dtype``, the following conditions must be true as well:
 |      
 |          * ``self.size(-1)`` must be divisible by the ratio between the element
 |            sizes of the dtypes.
 |          * ``self.storage_offset()`` must be divisible by the ratio between the
 |            element sizes of the dtypes.
 |          * The strides of all dimensions, except the last dimension, must be
 |            divisible by the ratio between the element sizes of the dtypes.
 |      
 |      If any of the above conditions are not met, an error is thrown.
 |      
 |      .. warning::
 |      
 |          This overload is not supported by TorchScript, and using it in a Torchscript
 |          program will cause undefined behavior.
 |      
 |      
 |      Args:
 |          dtype (:class:`torch.dtype`): the desired dtype
 |      
 |      Example::
 |      
 |          >>> x = torch.randn(4, 4)
 |          >>> x
 |          tensor([[ 0.9482, -0.0310,  1.4999, -0.5316],
 |                  [-0.1520,  0.7472,  0.5617, -0.8649],
 |                  [-2.4724, -0.0334, -0.2976, -0.8499],
 |                  [-0.2109,  1.9913, -0.9607, -0.6123]])
 |          >>> x.dtype
 |          torch.float32
 |      
 |          >>> y = x.view(torch.int32)
 |          >>> y
 |          tensor([[ 1064483442, -1124191867,  1069546515, -1089989247],
 |                  [-1105482831,  1061112040,  1057999968, -1084397505],
 |                  [-1071760287, -1123489973, -1097310419, -1084649136],
 |                  [-1101533110,  1073668768, -1082790149, -1088634448]],
 |              dtype=torch.int32)
 |          >>> y[0, 0] = 1000000000
 |          >>> x
 |          tensor([[ 0.0047, -0.0310,  1.4999, -0.5316],
 |                  [-0.1520,  0.7472,  0.5617, -0.8649],
 |                  [-2.4724, -0.0334, -0.2976, -0.8499],
 |                  [-0.2109,  1.9913, -0.9607, -0.6123]])
 |      
 |          >>> x.view(torch.cfloat)
 |          tensor([[ 0.0047-0.0310j,  1.4999-0.5316j],
 |                  [-0.1520+0.7472j,  0.5617-0.8649j],
 |                  [-2.4724-0.0334j, -0.2976-0.8499j],
 |                  [-0.2109+1.9913j, -0.9607-0.6123j]])
 |          >>> x.view(torch.cfloat).size()
 |          torch.Size([4, 2])
 |      
 |          >>> x.view(torch.uint8)
 |          tensor([[  0, 202, 154,  59, 182, 243, 253, 188, 185, 252, 191,  63, 240,  22,
 |                     8, 191],
 |                  [227, 165,  27, 190, 128,  72,  63,  63, 146, 203,  15,  63,  22, 106,
 |                    93, 191],
 |                  [205,  59,  30, 192, 112, 206,   8, 189,   7,  95, 152, 190,  12, 147,
 |                    89, 191],
 |                  [ 43, 246,  87, 190, 235, 226, 254,  63, 111, 240, 117, 191, 177, 191,
 |                    28, 191]], dtype=torch.uint8)
 |          >>> x.view(torch.uint8).size()
 |          torch.Size([4, 16])
 |  
 |  view_as(...)
 |      view_as(other) -> Tensor
 |      
 |      View this tensor as the same size as :attr:`other`.
 |      ``self.view_as(other)`` is equivalent to ``self.view(other.size())``.
 |      
 |      Please see :meth:`~Tensor.view` for more information about ``view``.
 |      
 |      Args:
 |          other (:class:`torch.Tensor`): The result tensor has the same size
 |              as :attr:`other`.
 |  
 |  vsplit(...)
 |      vsplit(split_size_or_sections) -> List of Tensors
 |      
 |      See :func:`torch.vsplit`
 |  
 |  where(...)
 |      where(condition, y) -> Tensor
 |      
 |      ``self.where(condition, y)`` is equivalent to ``torch.where(condition, self, y)``.
 |      See :func:`torch.where`
 |  
 |  xlogy(...)
 |      xlogy(other) -> Tensor
 |      
 |      See :func:`torch.xlogy`
 |  
 |  xlogy_(...)
 |      xlogy_(other) -> Tensor
 |      
 |      In-place version of :meth:`~Tensor.xlogy`
 |  
 |  xpu(...)
 |      xpu(device=None, non_blocking=False, memory_format=torch.preserve_format) -> Tensor
 |      
 |      Returns a copy of this object in XPU memory.
 |      
 |      If this object is already in XPU memory and on the correct device,
 |      then no copy is performed and the original object is returned.
 |      
 |      Args:
 |          device (:class:`torch.device`): The destination XPU device.
 |              Defaults to the current XPU device.
 |          non_blocking (bool): If ``True`` and the source is in pinned memory,
 |              the copy will be asynchronous with respect to the host.
 |              Otherwise, the argument has no effect. Default: ``False``.
 |          memory_format (:class:`torch.memory_format`, optional): the desired memory format of
 |              returned Tensor. Default: ``torch.preserve_format``.
 |  
 |  zero_(...)
 |      zero_() -> Tensor
 |      
 |      Fills :attr:`self` tensor with zeros.
 |  
 |  ----------------------------------------------------------------------
 |  Static methods inherited from torch._C.TensorBase:
 |  
 |  __new__(*args, **kwargs) class method of torch._C.TensorBase
 |      Create and return a new object.  See help(type) for accurate signature.
 |  
 |  ----------------------------------------------------------------------
 |  Data descriptors inherited from torch._C.TensorBase:
 |  
 |  H
 |      Returns a view of a matrix (2-D tensor) conjugated and transposed.
 |      
 |      ``x.H`` is equivalent to ``x.transpose(0, 1).conj()`` for complex matrices and
 |      ``x.transpose(0, 1)`` for real matrices.
 |      
 |      .. seealso::
 |      
 |              :attr:`~.Tensor.mH`: An attribute that also works on batches of matrices.
 |  
 |  T
 |      Returns a view of this tensor with its dimensions reversed.
 |      
 |      If ``n`` is the number of dimensions in ``x``,
 |      ``x.T`` is equivalent to ``x.permute(n-1, n-2, ..., 0)``.
 |      
 |      .. warning::
 |          The use of :func:`Tensor.T` on tensors of dimension other than 2 to reverse their shape
 |          is deprecated and it will throw an error in a future release. Consider :attr:`~.Tensor.mT`
 |          to transpose batches of matrices or `x.permute(*torch.arange(x.ndim - 1, -1, -1))` to reverse
 |          the dimensions of a tensor.
 |  
 |  data
 |  
 |  device
 |      Is the :class:`torch.device` where this Tensor is.
 |  
 |  dtype
 |  
 |  grad
 |      This attribute is ``None`` by default and becomes a Tensor the first time a call to
 |      :func:`backward` computes gradients for ``self``.
 |      The attribute will then contain the gradients computed and future calls to
 |      :func:`backward` will accumulate (add) gradients into it.
 |  
 |  grad_fn
 |  
 |  imag
 |      Returns a new tensor containing imaginary values of the :attr:`self` tensor.
 |      The returned tensor and :attr:`self` share the same underlying storage.
 |      
 |      .. warning::
 |          :func:`imag` is only supported for tensors with complex dtypes.
 |      
 |      Example::
 |          >>> x=torch.randn(4, dtype=torch.cfloat)
 |          >>> x
 |          tensor([(0.3100+0.3553j), (-0.5445-0.7896j), (-1.6492-0.0633j), (-0.0638-0.8119j)])
 |          >>> x.imag
 |          tensor([ 0.3553, -0.7896, -0.0633, -0.8119])
 |  
 |  is_cpu
 |      Is ``True`` if the Tensor is stored on the CPU, ``False`` otherwise.
 |  
 |  is_cuda
 |      Is ``True`` if the Tensor is stored on the GPU, ``False`` otherwise.
 |  
 |  is_ipu
 |      Is ``True`` if the Tensor is stored on the IPU, ``False`` otherwise.
 |  
 |  is_leaf
 |      All Tensors that have :attr:`requires_grad` which is ``False`` will be leaf Tensors by convention.
 |      
 |      For Tensors that have :attr:`requires_grad` which is ``True``, they will be leaf Tensors if they were
 |      created by the user. This means that they are not the result of an operation and so
 |      :attr:`grad_fn` is None.
 |      
 |      Only leaf Tensors will have their :attr:`grad` populated during a call to :func:`backward`.
 |      To get :attr:`grad` populated for non-leaf Tensors, you can use :func:`retain_grad`.
 |      
 |      Example::
 |      
 |          >>> a = torch.rand(10, requires_grad=True)
 |          >>> a.is_leaf
 |          True
 |          >>> b = torch.rand(10, requires_grad=True).cuda()
 |          >>> b.is_leaf
 |          False
 |          # b was created by the operation that cast a cpu Tensor into a cuda Tensor
 |          >>> c = torch.rand(10, requires_grad=True) + 2
 |          >>> c.is_leaf
 |          False
 |          # c was created by the addition operation
 |          >>> d = torch.rand(10).cuda()
 |          >>> d.is_leaf
 |          True
 |          # d does not require gradients and so has no operation creating it (that is tracked by the autograd engine)
 |          >>> e = torch.rand(10).cuda().requires_grad_()
 |          >>> e.is_leaf
 |          True
 |          # e requires gradients and has no operations creating it
 |          >>> f = torch.rand(10, requires_grad=True, device="cuda")
 |          >>> f.is_leaf
 |          True
 |          # f requires grad, has no operation creating it
 |  
 |  is_meta
 |      Is ``True`` if the Tensor is a meta tensor, ``False`` otherwise.  Meta tensors
 |      are like normal tensors, but they carry no data.
 |  
 |  is_mkldnn
 |  
 |  is_mps
 |      Is ``True`` if the Tensor is stored on the MPS device, ``False`` otherwise.
 |  
 |  is_mtia
 |  
 |  is_nested
 |  
 |  is_ort
 |  
 |  is_quantized
 |      Is ``True`` if the Tensor is quantized, ``False`` otherwise.
 |  
 |  is_sparse
 |      Is ``True`` if the Tensor uses sparse COO storage layout, ``False`` otherwise.
 |  
 |  is_sparse_csr
 |      Is ``True`` if the Tensor uses sparse CSR storage layout, ``False`` otherwise.
 |  
 |  is_vulkan
 |  
 |  is_xla
 |      Is ``True`` if the Tensor is stored on an XLA device, ``False`` otherwise.
 |  
 |  is_xpu
 |      Is ``True`` if the Tensor is stored on the XPU, ``False`` otherwise.
 |  
 |  itemsize
 |      Alias for :meth:`~Tensor.element_size()`
 |  
 |  layout
 |  
 |  mH
 |      Accessing this property is equivalent to calling :func:`adjoint`.
 |  
 |  mT
 |      Returns a view of this tensor with the last two dimensions transposed.
 |      
 |      ``x.mT`` is equivalent to ``x.transpose(-2, -1)``.
 |  
 |  name
 |  
 |  names
 |      Stores names for each of this tensor's dimensions.
 |      
 |      ``names[idx]`` corresponds to the name of tensor dimension ``idx``.
 |      Names are either a string if the dimension is named or ``None`` if the
 |      dimension is unnamed.
 |      
 |      Dimension names may contain characters or underscore. Furthermore, a dimension
 |      name must be a valid Python variable name (i.e., does not start with underscore).
 |      
 |      Tensors may not have two named dimensions with the same name.
 |      
 |      .. warning::
 |          The named tensor API is experimental and subject to change.
 |  
 |  nbytes
 |      Returns the number of bytes consumed by the "view" of elements of the Tensor
 |      if the Tensor does not use sparse storage layout.
 |      Defined to be :meth:`~Tensor.numel()` * :meth:`~Tensor.element_size()`
 |  
 |  ndim
 |      Alias for :meth:`~Tensor.dim()`
 |  
 |  output_nr
 |  
 |  real
 |      Returns a new tensor containing real values of the :attr:`self` tensor for a complex-valued input tensor.
 |      The returned tensor and :attr:`self` share the same underlying storage.
 |      
 |      Returns :attr:`self` if :attr:`self` is a real-valued tensor tensor.
 |      
 |      Example::
 |          >>> x=torch.randn(4, dtype=torch.cfloat)
 |          >>> x
 |          tensor([(0.3100+0.3553j), (-0.5445-0.7896j), (-1.6492-0.0633j), (-0.0638-0.8119j)])
 |          >>> x.real
 |          tensor([ 0.3100, -0.5445, -1.6492, -0.0638])
 |  
 |  requires_grad
 |      Is ``True`` if gradients need to be computed for this Tensor, ``False`` otherwise.
 |      
 |      .. note::
 |      
 |          The fact that gradients need to be computed for a Tensor do not mean that the :attr:`grad`
 |          attribute will be populated, see :attr:`is_leaf` for more details.
 |  
 |  retains_grad
 |      Is ``True`` if this Tensor is non-leaf and its :attr:`grad` is enabled to be
 |      populated during :func:`backward`, ``False`` otherwise.
 |  
 |  shape
 |      shape() -> torch.Size
 |      
 |      Returns the size of the :attr:`self` tensor. Alias for :attr:`size`.
 |      
 |      See also :meth:`Tensor.size`.
 |      
 |      Example::
 |      
 |          >>> t = torch.empty(3, 4, 5)
 |          >>> t.size()
 |          torch.Size([3, 4, 5])
 |          >>> t.shape
 |          torch.Size([3, 4, 5])
 |  
 |  volatile
```

## Appendix IV

```
Help on built-in function tensor in module torch:

tensor(...)
    tensor(data, *, dtype=None, device=None, requires_grad=False, pin_memory=False) -> Tensor
    
    Constructs a tensor with no autograd history (also known as a "leaf tensor", see :doc:`/notes/autograd`) by copying :attr:`data`.
    
    .. warning::
    
        When working with tensors prefer using :func:`torch.Tensor.clone`,
        :func:`torch.Tensor.detach`, and :func:`torch.Tensor.requires_grad_` for
        readability. Letting `t` be a tensor, ``torch.tensor(t)`` is equivalent to
        ``t.clone().detach()``, and ``torch.tensor(t, requires_grad=True)``
        is equivalent to ``t.clone().detach().requires_grad_(True)``.
    
    .. seealso::
    
        :func:`torch.as_tensor` preserves autograd history and avoids copies where possible.
        :func:`torch.from_numpy` creates a tensor that shares storage with a NumPy array.
    
    Args:
        data (array_like): Initial data for the tensor. Can be a list, tuple,
            NumPy ``ndarray``, scalar, and other types.
    
    Keyword args:
        dtype (:class:`torch.dtype`, optional): the desired data type of returned tensor.
            Default: if ``None``, infers data type from :attr:`data`.
        device (:class:`torch.device`, optional): the device of the constructed tensor. If None and data is a tensor
            then the device of data is used. If None and data is not a tensor then
            the result tensor is constructed on the current device.
        requires_grad (bool, optional): If autograd should record operations on the
            returned tensor. Default: ``False``.
        pin_memory (bool, optional): If set, returned tensor would be allocated in
            the pinned memory. Works only for CPU tensors. Default: ``False``.
    
    
    Example::
    
        >>> torch.tensor([[0.1, 1.2], [2.2, 3.1], [4.9, 5.2]])
        tensor([[ 0.1000,  1.2000],
                [ 2.2000,  3.1000],
                [ 4.9000,  5.2000]])
    
        >>> torch.tensor([0, 1])  # Type inference on data
        tensor([ 0,  1])
    
        >>> torch.tensor([[0.11111, 0.222222, 0.3333333]],
        ...              dtype=torch.float64,
        ...              device=torch.device('cuda:0'))  # creates a double tensor on a CUDA device
        tensor([[ 0.1111,  0.2222,  0.3333]], dtype=torch.float64, device='cuda:0')
    
        >>> torch.tensor(3.14159)  # Create a zero-dimensional (scalar) tensor
        tensor(3.1416)
    
        >>> torch.tensor([])  # Create an empty tensor (of size (0,))
        tensor([])
```

## Appendix V

```
array(object, dtype=None, *, copy=True, order='K', subok=False, ndmin=0,
          like=None)

    Create an array.

    Parameters
    ----------
    object : array_like
        An array, any object exposing the array interface, an object whose
        ``__array__`` method returns an array, or any (nested) sequence.
        If object is a scalar, a 0-dimensional array containing object is
        returned.
    dtype : data-type, optional
        The desired data-type for the array. If not given, NumPy will try to use
        a default ``dtype`` that can represent the values (by applying promotion
        rules when necessary.)
    copy : bool, optional
        If true (default), then the object is copied.  Otherwise, a copy will
        only be made if ``__array__`` returns a copy, if obj is a nested
        sequence, or if a copy is needed to satisfy any of the other
        requirements (``dtype``, ``order``, etc.).
    order : {'K', 'A', 'C', 'F'}, optional
        Specify the memory layout of the array. If object is not an array, the
        newly created array will be in C order (row major) unless 'F' is
        specified, in which case it will be in Fortran order (column major).
        If object is an array the following holds.

        ===== ========= ===================================================
        order  no copy                     copy=True
        ===== ========= ===================================================
        'K'   unchanged F & C order preserved, otherwise most similar order
        'A'   unchanged F order if input is F and not C, otherwise C order
        'C'   C order   C order
        'F'   F order   F order
        ===== ========= ===================================================

        When ``copy=False`` and a copy is made for other reasons, the result is
        the same as if ``copy=True``, with some exceptions for 'A', see the
        Notes section. The default order is 'K'.
    subok : bool, optional
        If True, then sub-classes will be passed-through, otherwise
        the returned array will be forced to be a base-class array (default).
    ndmin : int, optional
        Specifies the minimum number of dimensions that the resulting
        array should have.  Ones will be prepended to the shape as
        needed to meet this requirement.
    like : array_like, optional
        Reference object to allow the creation of arrays which are not
        NumPy arrays. If an array-like passed in as ``like`` supports
        the ``__array_function__`` protocol, the result will be defined
        by it. In this case, it ensures the creation of an array object
        compatible with that passed in via this argument.

        .. versionadded:: 1.20.0

    Returns
    -------
    out : ndarray
        An array object satisfying the specified requirements.

    See Also
    --------
    empty_like : Return an empty array with shape and type of input.
    ones_like : Return an array of ones with shape and type of input.
    zeros_like : Return an array of zeros with shape and type of input.
    full_like : Return a new array with shape of input filled with value.
    empty : Return a new uninitialized array.
    ones : Return a new array setting values to one.
    zeros : Return a new array setting values to zero.
    full : Return a new array of given shape filled with value.


    Notes
    -----
    When order is 'A' and ``object`` is an array in neither 'C' nor 'F' order,
    and a copy is forced by a change in dtype, then the order of the result is
    not necessarily 'C' as expected. This is likely a bug.

    Examples
    --------
    >>> np.array([1, 2, 3])
    array([1, 2, 3])

    Upcasting:

    >>> np.array([1, 2, 3.0])
    array([ 1.,  2.,  3.])

    More than one dimension:

    >>> np.array([[1, 2], [3, 4]])
    array([[1, 2],
           [3, 4]])

    Minimum dimensions 2:

    >>> np.array([1, 2, 3], ndmin=2)
    array([[1, 2, 3]])

    Type provided:

    >>> np.array([1, 2, 3], dtype=complex)
    array([ 1.+0.j,  2.+0.j,  3.+0.j])

    Data-type consisting of more than one element:

    >>> x = np.array([(1,2),(3,4)],dtype=[('a','<i4'),('b','<i4')])
    >>> x['a']
    array([1, 3])

    Creating an array from sub-classes:

    >>> np.array(np.mat('1 2; 3 4'))
    array([[1, 2],
           [3, 4]])

    >>> np.array(np.mat('1 2; 3 4'), subok=True)
    matrix([[1, 2],
            [3, 4]])
```

## Appendix VI

```
ndarray(shape, dtype=float, buffer=None, offset=0,
            strides=None, order=None)

    An array object represents a multidimensional, homogeneous array
    of fixed-size items.  An associated data-type object describes the
    format of each element in the array (its byte-order, how many bytes it
    occupies in memory, whether it is an integer, a floating point number,
    or something else, etc.)

    Arrays should be constructed using `array`, `zeros` or `empty` (refer
    to the See Also section below).  The parameters given here refer to
    a low-level method (`ndarray(...)`) for instantiating an array.

    For more information, refer to the `numpy` module and examine the
    methods and attributes of an array.

    Parameters
    ----------
    (for the __new__ method; see Notes below)

    shape : tuple of ints
        Shape of created array.
    dtype : data-type, optional
        Any object that can be interpreted as a numpy data type.
    buffer : object exposing buffer interface, optional
        Used to fill the array with data.
    offset : int, optional
        Offset of array data in buffer.
    strides : tuple of ints, optional
        Strides of data in memory.
    order : {'C', 'F'}, optional
        Row-major (C-style) or column-major (Fortran-style) order.

    Attributes
    ----------
    T : ndarray
        Transpose of the array.
    data : buffer
        The array's elements, in memory.
    dtype : dtype object
        Describes the format of the elements in the array.
    flags : dict
        Dictionary containing information related to memory use, e.g.,
        'C_CONTIGUOUS', 'OWNDATA', 'WRITEABLE', etc.
    flat : numpy.flatiter object
        Flattened version of the array as an iterator.  The iterator
        allows assignments, e.g., ``x.flat = 3`` (See `ndarray.flat` for
        assignment examples; TODO).
    imag : ndarray
        Imaginary part of the array.
    real : ndarray
        Real part of the array.
    size : int
        Number of elements in the array.
    itemsize : int
        The memory use of each array element in bytes.
    nbytes : int
        The total number of bytes required to store the array data,
        i.e., ``itemsize * size``.
    ndim : int
        The array's number of dimensions.
    shape : tuple of ints
        Shape of the array.
    strides : tuple of ints
        The step-size required to move from one element to the next in
        memory. For example, a contiguous ``(3, 4)`` array of type
        ``int16`` in C-order has strides ``(8, 2)``.  This implies that
        to move from element to element in memory requires jumps of 2 bytes.
        To move from row-to-row, one needs to jump 8 bytes at a time
        (``2 * 4``).
    ctypes : ctypes object
        Class containing properties of the array needed for interaction
        with ctypes.
    base : ndarray
        If the array is a view into another array, that array is its `base`
        (unless that array is also a view).  The `base` array is where the
        array data is actually stored.

    See Also
    --------
    array : Construct an array.
    zeros : Create an array, each element of which is zero.
    empty : Create an array, but leave its allocated memory unchanged (i.e.,
            it contains "garbage").
    dtype : Create a data-type.
    numpy.typing.NDArray : An ndarray alias :term:`generic <generic type>`
                           w.r.t. its `dtype.type <numpy.dtype.type>`.

    Notes
    -----
    There are two modes of creating an array using ``__new__``:

    1. If `buffer` is None, then only `shape`, `dtype`, and `order`
       are used.
    2. If `buffer` is an object exposing the buffer interface, then
       all keywords are interpreted.

    No ``__init__`` method is needed because the array is fully initialized
    after the ``__new__`` method.

    Examples
    --------
    These examples illustrate the low-level `ndarray` constructor.  Refer
    to the `See Also` section above for easier ways of constructing an
    ndarray.

    First mode, `buffer` is None:

    >>> np.ndarray(shape=(2,2), dtype=float, order='F')
    array([[0.0e+000, 0.0e+000], # random
           [     nan, 2.5e-323]])

    Second mode:

    >>> np.ndarray((2,), buffer=np.array([1,2,3]),
    ...            offset=np.int_().itemsize,
    ...            dtype=int) # offset = 1*itemsize, i.e. skip first element
    array([2, 3])
```

<br>

**References**

[^1]: [Built-in Functions: `help()` — Python 3.12.4 documentation](https://docs.python.org/3/library/functions.html#help).
[^2]: [Help function in Python - GeeksforGeeks](https://www.geeksforgeeks.org/help-function-in-python/).
[^3]: [Python dir() Function](https://www.w3schools.com/python/ref_func_dir.asp).
[^4]: [Built-in Functions: `dir()` — Python 3.12.4 documentation](https://docs.python.org/3/library/functions.html#dir).
[^5]: [Python: Difference between `dir()` and `help()`- GeeksforGeeks](https://www.geeksforgeeks.org/python-difference-between-dir-and-help/).
