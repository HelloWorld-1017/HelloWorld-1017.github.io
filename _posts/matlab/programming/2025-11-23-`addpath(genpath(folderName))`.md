---
title: Add All Functions and Classes Under Subfolders into MATLAB Search Path --- `addpath(genpath(folderName))`
toc: false
categories:
 - MATLAB
tags:
 - MATLAB Programming
location: Buffalo, United States
date: 2025-11-23 17:01:08 -0500
last_modified_at: 2025-11-28 16:09:09 -0500
---

When programming in MATLAB, to facilitate organization, sometimes we may put some functions or classes under folders or some subfolders. And at this time, in order to use these functions or classes in the scripts of current folder, i.e., `pwd`, we need to use `addpath` function[^2] to add them into the search path. However, a single `addpath` function can't import functions under subfolders. For example, here I new a `folders` folder in the current folder, and under this path, new three subfolders `folder 1`, `folder 2`, and `folder 3`. In which, I define a simple function `helperAdd` in `folders/folder 3`:

```matlab
function c = helperAdd(a, b)
c = a+b;
end
```

Right now, the whole structure looks like this:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251126145752149.png" alt="image-20251126145745024" style="width:20%;" />

Then, at this time, in the `script.m` file of current folder, I try to use `addpath('folders')` to import all functions under `folders` such that I can call `helperAdd`:

```matlab
clc, clear, close all

addpath('folders')

c = helperAdd(1, 2)
```

but an error occurs:

```
helperAdd is not found in the current folder or on the MATLAB path, but exists in:
    C:\Users\admin\Desktop\draft\test genpath\folders\folder 3

Change the MATLAB current folder or add its folder to the MATLAB path.
Error in script (line 5)
c = helperAdd(1, 2) 
```

MATLAB says that it can find the `helperAdd`, but can't call it since now `helperAdd` is still not in the search path.

To solve this problem, we need to use another function `genpath`[^1], i.e.,

```matlab
clc, clear, close all

addpath(genpath('folders'))

c = helperAdd(1, 2)
```

then we'll get a right output:

```
c =
     3
```

The `genpath` function is to[^1]:

<div class="quote--left" markdown="1">
`p = genpath(folderName)` returns a character vector containing a search path that includes `folderName` and <i class="emphasize">multiple levels of subfolders</i> below `folderName`. `p` does not include folders named `private`, folders that begin with the `@` character (class folders), folders that begin with the `+` character (namespace folders), folders named `resources`, or subfolders within any of these.

</div>

Like in this case, `p = genpath('folders')` will produce a results:

```
p =
    'folders;folders\folder 1;folders\folder 2;folders\folder 3;'
```

then the outer `addpath` function thereby could add all subfolder into the search path.

<br>

**References**

[^1]: [MATLAB `genpath`: Generate search path](https://www.mathworks.com/help/matlab/ref/genpath.html).
[^2]: [MATLAB `addpath`: Add folders to search path](https://www.mathworks.com/help/matlab/ref/addpath.html).