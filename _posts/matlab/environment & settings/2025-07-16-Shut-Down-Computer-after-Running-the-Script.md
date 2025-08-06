---
title: Shut Down Windows Computer after Running the Script in MATLAB --- `system("shutdown -s")`
toc: false
categories:
 - MATLAB
 - Windows
tags:
 - MATLAB Environment and Settings
date: 2025-07-16 18:51:03 +0800
last_modified_at: 2025-08-06 11:59:25 +0800
---

In MATLAB, we can add the following code at the end of the script file:


```matlab
system("shutdown -s")
```

to shut down the Windows computer after running the script, where the `system` function is to “execute operating system command and return output”[^1].

<br>

**References**

- [`shutdown`](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/shutdown).

[^1]: [MATLAB `system`: Execute operating system command and return output](https://www.mathworks.com/help/matlab/ref/system.html).
