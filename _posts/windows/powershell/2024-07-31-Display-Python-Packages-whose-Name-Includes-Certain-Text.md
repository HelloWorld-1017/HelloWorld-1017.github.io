---
title: "Display Python Packages whose Name Includes Certain Text: PowerShell commands `findstr`, `Select-String`, and pipeline operator `|`"
toc: false
categories:
 - Windows
 - Python
tags:
 - Python pip
 - PowerShell
date: 2024-07-31 11:07:11 +0800
last_modified_at: 2024-07-31 11:07:11 +0800
---

If we want to display Python packages whose name includes certain text, like “torch”, we can use following command:

```powershell
pip list | findstr "torch"
```

```
torch                             2.3.1+cu121
torchaudio                        2.3.1+cu121
torchinfo                         1.8.0
torchsummary                      1.5.1
torchvision                       0.18.1+cu121
```

where command `findstr`  [^1] is to:

<div class="quote--left" markdown="1">

Searches for patterns of text in files.

</div>

or use native PowerShell command (i.e. cmdlet) `Select-String`[^2], which is more powerful and suitable for PowerShell:

```powershell
pip list | Select-String "torch"
```

```
torch                             2.3.1+cu121
torchaudio                        2.3.1+cu121
torchinfo                         1.8.0
torchsummary                      1.5.1
torchvision                       0.18.1+cu121
```

<div class="quote--left" markdown="1">

The `Select-String` cmdlet uses regular expression matching to search for text patterns in input strings and files. **You can use `Select-String` similar to `grep` in UNIX or `findstr.exe` in Windows.**

`Select-String` is based on lines of text. By default, `Select-String` finds the first match in each line and, for each match, it displays the file name, line number, and all text in the line containing the match. You can direct `Select-String` to find multiple matches per line, display text before and after the match, or display a Boolean value (True or False) that indicates whether a match is found.

`Select-String` can display all the text matches or stop after the first match in each input file. `Select-String` can be used to display all text that doesn't match the specified pattern.

You can also specify that `Select-String` should expect a particular character encoding, such as when you're searching files of Unicode text. `Select-String` uses the byte-order-mark (BOM) to detect the encoding format of the file. If the file has no BOM, it assumes the encoding is UTF8.

</div>

In above two cases, symbol `|` is the pipeline operator[^3], which is used to take the output of previous command to next command as the input:

<div class="quote--left" markdown="1">

A pipeline is a series of commands connected by pipeline operators (`|`) (ASCII 124). Each pipeline operator sends the results of the preceding command to the next command.

The output of the first command can be sent for processing as input to the second command. And that output can be sent to yet another command [like `Command-1 | Command-2 | Command-3`]. The result is a complex command chain or *pipeline* that's composed of a series of simple commands.

...

In a pipeline, the commands are processed *in order* from left to right. The processing is handled as a single operation and output is displayed as it's generated.

</div>

<br>

**References**

[^1]: [`findstr` \| Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/findstr).
[^2]: [`Select-String` (Microsoft.PowerShell.Utility) - PowerShell \| Microsoft Learn](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-string?view=powershell-7.4).
[^3]: [about Pipelines - PowerShell \| Microsoft Learn](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pipelines?view=powershell-7.4).
