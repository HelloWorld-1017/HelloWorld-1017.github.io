---
title: Compare Two Files and Folders in MATLAB
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Programming
date: 2025-07-09 15:12:11 +0800
last_modified_at: 2025-07-11 11:57:00 +0800
---

MATLAB provides an efficient tool to compare two files and folders. We can take a simple example to test it.

Firstly, create two new folders, `folder 1` and `folder 2`. In the `folder 1`, create a script file `script.m`:

```matlab
clc, clear, close all

a = 1;
b = 2;

c = a+b;

save("result.mat", "a", "b", "c")
```

then run it and we can get a `result.mat`.

Similarly, in the `folder 2`, similarly create a `script.m`:

```matlab
clc, clear, close all

a = 1;
b = 2;

c = a*b;

save("result.mat", "a", "b", "c")
```

and likewise we can get a `result.mat`.

Then, we right click the head of `Current Folder` part, and choose `Compare`:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202507111207325.png" alt="image-20250711120704276" style="width:33%;" />

and next select these two folders and click `compare` button:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202507111209788.png" alt="image-20250711120956741" style="width:50%;" />

then we can see the comparison results:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202507111210366.png" alt="image-20250711121053290" style="width:67%;" />

where for `script.m`:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202507111211715.png" alt="image-20250711121135631" style="width:67%;" />

and `result.m`:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202507111212593.png" alt="image-20250711121219531" style="width:67%;" />

The comparison looks very straightforward.

By the way, we can also use the `visdiff` function[^1] to active the comparison:

```matlab
visdiff("folder 1", "folder 2")
```

which is a more convenient way to my mind.

To some extent, for MATLAB-related files (like above `.mat` file), this built-in function of comparison is more compatible and convenient than the software Beyond Compare[^2].

<br>

**References**

[^1]: [MATLAB `visdiff`: Compare two files or folders](https://www.mathworks.com/help/matlab/ref/visdiff.html).
[^2]: [Scooter Software](https://www.scootersoftware.com/).