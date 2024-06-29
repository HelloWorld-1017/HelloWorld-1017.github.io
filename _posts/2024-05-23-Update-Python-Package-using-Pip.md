---
layout: single
title: Update Python Package using Pip
toc: false
categories:
 - Python
tags:
 - Python pip
 - Python matplotlib
drafted_at: 2024-05-22 23:16:41 +0800
date: 2024-05-23 13:20:47 +0800
last_modified_at0: 2024-05-23 13:20:47 +0800
last_modified_at: 2024-05-23 13:20:47 +0800
---

These days I'm re-learning Python. I think it's good to start from scientific drawing, so I find a simple example, *Bar color demo*[^1], in Python Matplotlib documentation, showing as follows:

<div id="script-1"></div>

```python
import matplotlib.pyplot as plt

fig, ax = plt.subplots()

fruits = ['apple', 'blueberry', 'cherry', 'orange']
counts = [40, 100, 30, 55]
bar_labels = ['red', 'blue', '_red', 'orange']
bar_colors = ['tab:red', 'tab:blue', 'tab:red', 'tab:orange']

ax.bar(fruits, counts, label=bar_labels, color=bar_colors)

ax.set_ylabel('fruit supply')
ax.set_title('Fruit supply by kind and color')
ax.legend(title='Fruit color')

plt.show()
```

After running this script, I got a figure:

![image-20240522230440898](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405222305479.png)

but it is different from that showed in the official documentation: the legend doesn't display correctly. 

I tried another example, *Grouped bar chart with labels*[^2], and the problem exists the same. So I guess it is caused by mismatched version. The Python and relevant packages in my computer were installed over a year ago, and the version of Matplotlib package is `3.5.2`:

```
In: import matplotlib
In: matplotlib.__version__

Out: '3.5.2'
```

but the documentation which I refer to now is the latest stable version `3.9`, so [the script](#script-1) cannot be executed expectedly. Therefore, I decide to update Matplotlib package, and the used command is[^3]:

```
pip install --upgrade matplotlib --user
```

> NOTE: `--user` option cannot be neglected, otherwise an error will occur:
>
> ```
> ERROR: Could not install packages due to an OSError: [WinError 5] 拒绝访问。: 'D:\\Softwares\\anaconda3\\Lib\\site-packages\\~umpy\\core\\_multiarray_tests.cp39-win_amd64.pyd'
> Consider using the `--user` option or check the permissions.
> ```

After successfully updating and restarting the kernel, Matplotlib package becomes version `3.9.0`:

```
In: import matplotlib
In: matplotlib.__version__

Out: '3.9.0'
```

At this time, the generated image is correct if running [the script](#script-1) again:

![image-20240522232501433](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405222325548.png)

<br>

# References

[^1]: [Bar color demo — Matplotlib 3.9.0 documentation](https://matplotlib.org/stable/gallery/lines_bars_and_markers/bar_colors.html#sphx-glr-gallery-lines-bars-and-markers-bar-colors-py).
[^2]: [Grouped bar chart with labels — Matplotlib 3.9.0 documentation](https://matplotlib.org/stable/gallery/lines_bars_and_markers/barchart.html#sphx-glr-gallery-lines-bars-and-markers-barchart-py).
[^3]: [完美解决：ERROR: Could not install packages due to an EnvironmentError: [WinError 5] 拒绝访问_could not install shim-CSDN博客](https://blog.csdn.net/weixin_43939159/article/details/109165715).
