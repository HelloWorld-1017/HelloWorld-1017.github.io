---
title: Redirection Operators `>` and `>>` in Windows PowerShell
toc: false
classes: wide
categories:
 - Windows
 - Python
 - PowerShell
date: 2024-07-11 11:44:01 +0800
last_modified_at: 2024-07-15 17:28:15 +0800
---

For Windows PowerShell, `>` and `>>` are redirection operators[^1] used to redirect output[^2]:

<div class="quote--left" markdown="1">

By default, PowerShell sends output to the PowerShell host. Usually this is the console application. However, you can redirect the output to a text file and you can redirect error output to the regular output stream.

You can use the following methods to redirect output:

- Use the `Out-File` cmdlet, ......
- Use the `Tee-Object` cmdlet, ......
- Use the PowerShell redirection operators. Redirecting the output of a PowerShell command (cmdlet, function, script) using the redirection operator (`>`) is functionally equivalent to piping to `Out-File` with no extra parameters. PowerShell 7.4 changed the behavior of the redirection operator when used to redirect the **stdout** stream of a native command.

......

`>`: Send specified stream to a file.

`>>`: **Append** specified stream to a file.

`>&1`: *Redirects* the specified stream to the **Success** stream.

</div>

That is, redirection operators redirect output that would be printed in PowerShell host to a file *instead* (which also means that those outputs don’t appear on PowerShell host any more). 

Take outputting Python package list to `.txt` file as an example. I create a new Python virtual environment using `venv` module[^3], and new two text files in which, i.e. `packages1.txt` and `packages2.txt`, whose content are the same:

```
Package list

```

NOTE: There is a empty line intentionally put at the end of the file.
{: .notice--primary}

Then, I use operators `>` and `>>` to redirect output to `packages1.txt` and `packages2.txt`, respectively.

**(1) By `>`**

```powershell
pip list > packages1.txt
```

`packages1.txt`

```
Package    Version
---------- -------
pip        24.0
setuptools 65.5.0

```

**(2) By `>>`**

```powershell
pip list >> packages2.txt
```

`packages2.txt`

```
Package list
Package    Version
---------- -------
pip        24.0
setuptools 65.5.0

```

As expected, operator `>` overwrites the original file, while `>>` appends output at the end of the original file.

<br>

**References**

[^1]: [about Operators - PowerShell \| Microsoft Learn](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.4#redirection-operators).
[^2]: [about Redirection - PowerShell \| Microsoft Learn](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_redirection?view=powershell-7.4).
[^3]: [Create Python Virtual Environment by Python venv - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-09/15-49-08.html).

