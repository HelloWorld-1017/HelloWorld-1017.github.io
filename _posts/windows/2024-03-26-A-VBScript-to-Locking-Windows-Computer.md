---
title: A VBScript to Lock Windows Computer
toc: false
categories:
 - Windows
 - VBScript
date: 2024-03-26 10:23:11 +0800
last_modified_at: 2024-03-26 10:23:11 +0800
modification_history:
 - 2024-03-26 10:23:11 +0800
---

`lock.vbs`:

```vb
Dim WSHShell

Set WSHShell=WScript.CreateObject("WScript.Shell")

WSHShell.Run "Rundll32.exe user32.dll,LockWorkStation", 0
```

