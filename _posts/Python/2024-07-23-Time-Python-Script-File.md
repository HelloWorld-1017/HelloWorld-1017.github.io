---
title: Time Python Script File by PowerShell Commands `Measure-Command` and Python `cProfile` Module
toc: false
categories:
 - Python
 - PowerShell
tags:
 - <i>Python Cookbook</i>
date: 2024-07-23 11:48:09 +0800
last_modified_at: 2024-07-23 11:48:09 +0800
---

In Subsection “14.13 Profiling and Timing Your Program” of David Beazley and Brian K. Jones’s book *Python Cookbook*[^1], some methods are provided to get Python code execution time. Before introducing how to time code snippets, authors firstly give two ways of timing whole Python script.

The first one is using Unix `time` command (the similar command on Windows PowerShell is `Measure-Command`[^2] as will be showed), and the second is by Python `cProfile` module[^3].

<br>

To test both methods, I create a `.py` file `example.py`:

```python
# example.py

for i in range(int(1E9)): 
    i += 1
```

**(1) PowerShell `Measure-Command` command**

```powershell
Measure-Command {python example.py}
```

```
Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 33
Milliseconds      : 347
Ticks             : 333478729
TotalDays         : 0.000385970751157407
TotalHours        : 0.00926329802777778
TotalMinutes      : 0.555797881666667
TotalSeconds      : 33.3478729
TotalMilliseconds : 33347.8729
```

**(2) Python `cProfile` module**

```powershell
python -m cProfile example.py
```

```
         3 function calls in 49.644 seconds

   Ordered by: cumulative time

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.000    0.000   49.644   49.644 {built-in method builtins.exec}
        1   49.644   49.644   49.644   49.644 example.py:1(<module>)
        1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
```

<br>

As can be seen, both two timing methods only execute script file one time, so they’re time-saving, but meanwhile their test errors are relatively large. Therefore, they’re naturally more suitable for timing a whole script file rather than code snippets (actually above `example.py` is more like code snippet, and hence not that appropriate for illustrating both methods). 

<br>

**References**

[^1]: [Python cookbook (Third edition)](https://d.cxcore.net/Python/Python_Cookbook_3rd_Edition.pdf), David M. Beazley and Brian K. Jones, 2013, pp. 587-588.

[^2]: [`Measure-Command` (Microsoft.PowerShell.Utility) - PowerShell \| Microsoft Learn](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-command?view=powershell-7.4).
[^3]: [The Python Profilers — Python 3.12.4 documentation](https://docs.python.org/3/library/profile.html).