---
title: The Problem of PicGo Log File Becoming Too Huge
toc: false
categories:
 - Windows
tags:
 - Markdown
 - Typora
date: 2025-01-05 10:57:33 +0800
last_modified_at: 2025-01-06 11:08:41 +0800
---

Few days ago, I found the C drive storage space of my computer (Windows system) suddenly lost over 60 GB. The first thing came to my mind was that there were too many temporary files generated during use. So, I cleaned the C drive using built-in system tool[^1], but it didn’t work.

Later on, I thought perhaps it’s because there were too many cache files for a certain program, and the Windows system can’t recognize them according to the rules. I firstly guessed the program is Typora, because I always use it to write blogs and I remember that, although I set to upload inserted images to GitHub repo[^4] via PicGo[^5], Typora still make a backup for the image locally every time. So, I found the image storage directory[^2], `C:\Users\<user_name>\AppData\Roaming\Typora\typora-user-images`, but its size is only 126 MB. 

Note: The folder `C:\Users\<user_name>\AppData` is a hidden folder.
{: .notice--warning}

Although it’s not caused by Typora, the direction was correct. So next, I sorted files and folders in the directory `C:\Users\<user_name>\AppData\Roaming\` by Date and check them one by one. And luckily, I found a very huge folder, `C:\Users\<user_name>\AppData\Roaming\picgo` with size 283 GB. This folder stores the cache files of aforementioned PicGo, and under this folder, there is a single file `picgo.log`, whose size approaches 283 GB. It is the reason! It is the log file of PicGo, and its problem of occupying too many storage space is a bug which others ever reported[^3].

I feel very comfortable after deleting this mega file 😁 And it doesn’t affect the subsequent image uploading.

By the way, in the last two or three months, my computer at times encountered the blue screen of death, and then it would restart instantly. This process always happened so fast that I couldn’t write down the error code. Right now, I guess probably this problem is also attributed to the above PicGo bug. I’ll see in future if the guess is right.

<br>

**References**

[^1]: [How to Clear Cache in Windows 11](https://www.lifewire.com/clear-cache-windows-11-6749594).
[^2]: [Typora设置图片保存位置\_typora中图片跟文档保存在同一个文件下](https://blog.csdn.net/hhy1213/article/details/120609790).
[^3]: [Bug: picgo.log文件过大 · Issue #935 · Molunerfinn/PicGo](https://github.com/Molunerfinn/PicGo/issues/935).

[^4]: [HelloWorld-1017/blog-images-1](https://github.com/HelloWorld-1017/blog-images-1).
[^5]: [PicGo is Here](https://picgo.github.io/PicGo-Doc/zh/guide/).
