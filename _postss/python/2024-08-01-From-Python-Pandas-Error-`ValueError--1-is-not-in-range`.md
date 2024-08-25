---
title: "From Python Pandas Error `ValueError: -1 is not in range` to Two Kinds of Pandas Series Indexing Methods: *label-based indexing* (`loc`) and *position-based indexing* (`iloc`)"
toc: false
categories:
 - Python
tags:
 - Python Pandas
 - Python Pandas Warnings and Errors
date: 2024-08-01 16:33:44 +0800
last_modified_at: 2024-08-01 16:33:44 +0800
---

Yesterday, I encountered an error, `ValueError: -1 is not in range`, when I tried to index Python Pandas Series data using `[-1]`, and I found many on-line references but didn’t get a valid solution. Today, I look up McKinney’s book, *Python for Data Analysis*, and find he mention this point in Subchapter 5.4 *Integer Indexes*[^1]. By reading McKinney’s introduction, I realize there are two methods to index Pandas Series elements due to its special data structure. And above error is caused by the fact that Pandas confuses the two. In the following text, I’ll record it in detail.

Firstly, create a variable `ser` whose type is fundamental Pandas Series, i.e. `pandas.core.series.Series`:

<div id="script-1"></div>

```python
import pandas as pd
import numpy as np

ser = pd.Series(np.arange(3.))
ser, type(ser)
```

<div id="result-1"></div>

```
(0    0.0
 1    1.0
 2    2.0
 dtype: float64,
 pandas.core.series.Series)
```

At this time, if we want to select the last element in `ser` using `ser[-1]`, the error `ValueError: -1 is not in range` will occur:

```python
ser[-1]
```

```
ValueError                                Traceback (most recent call last)
File G:\...\venv\Lib\site-packages\pandas\core\indexes\range.py:391, in RangeIndex.get_loc(self, key, method, tolerance)
    390 try:
--> 391     return self._range.index(new_key)
    392 except ValueError as err:

ValueError: -1 is not in range

The above exception was the direct cause of the following exception:

KeyError                                  Traceback (most recent call last)
Cell In[10], line 1
----> 1 ser[-1]

...

KeyError: -1
```

The reason is that Pandas cannot correctly infer if users want to use *label-based indexing* or *position-based indexing* in this case. Specifically, code `ser = pd.Series(np.arange(3.))` doesn’t specify `index` attribute (used for *label-based indexing*) when creating a Pandas Series, so it automatically generates index labels from 0 to 1 [as we can see](#result-1). So, when we execute `ser[-1]`, Pandas mistakenly thinks we are selecting element by such index label, i.e. *label-based indexing* method, rather than *position-based indexing*, which is used for built-in Python lists and tuples. This is why Pandas finds `-1` is not in index range.

<div class="notice--primary" markdown="1">

To verify this point, I new a Series `ser2`, whose index label is `-1`, and create `ser3` by concatenating `ser` and `ser2` together:

```python
ser2 = pd.Series([4], index=[-1])
ser3 = pd.concat([ser, ser2])
ser3
```

```
 0    0.0
 1    1.0
 2    2.0
-1    4.0
dtype: float64
```

at this time, we could index the so-called “last” element by:

```python
ser3[-1]
```

```
4.0
```

</div>

To avoid this kind of ambiguity, we could directly create a non-integer indexed Series at the beginning by explicitly specifying `index` attribute, for example:

```python
ser4 = pd.Series(np.arange(3.), index=['a', 'b' ,'c'])
ser4
```

```
a    0.0
b    1.0
c    2.0
dtype: float64
```

then we can select the last element by *position-based indexing* method:

```python
ser4[-1]
```

```
2.0
```

<div class="notice--primary" markdown="1">

Or, by *label-based indexing*:

```python
ser4['c']
```

```
2.0
```

</div>

Or, we can still do the same as [above case](#script-1) when creating Series, but use `iloc` function to tell Pandas that `-1` denotes a position, rather than a label:

```python
ser = pd.Series(np.arange(3.))
ser, ser.iloc[-1]
```

```
(0    0.0
 1    1.0
 2    2.0
 dtype: float64,
 2.0)
```

By the way, it’s a good chance tell `iloc` from `loc`. The `iloc` function[^2] is to:

<div class="quote--left" markdown="1">

Purely integer-location based indexing for selection by **position**.

`.iloc[]` is primarily **integer position based** (from `0` to `length-1` of the axis), but may also be used with a boolean array.

</div>

whereas `loc`[^3]:

<div class="quote--left" markdown="1">

Access a group of rows and columns by **label(s)** or a boolean array.

`.loc[]` is primarily **label based**, but may also be used with a boolean array.

</div>

We can verify and compare their functions in a special case:

```python
ser = pd.Series(np.arange(4.), index=[-1,0,1,2])
ser, ser.iloc[-1], ser.loc[-1]
```

```
(-1    0.0
  0    1.0
  1    2.0
  2    3.0
 dtype: float64,
 3.0,
 0.0)
```

<br>

**References**

[^1]: [Python for Data Analysis: Data Wrangling with Pandas, Numpy, and IPython (Second Edition)](https://nibmehub.com/opac-service/pdf/read/Python%20for%20Data%20Analysis%20_%20data%20wrangling%20with%20Pandas-%20NumPy-%20and%20IPython.pdf), Wes McKinney, pp. 145-146.
[^2]: [`pandas.DataFrame.iloc` — pandas 2.2.2 documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.iloc.html).
[^3]: [`pandas.DataFrame.loc` — pandas 2.2.2 documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.loc.html).