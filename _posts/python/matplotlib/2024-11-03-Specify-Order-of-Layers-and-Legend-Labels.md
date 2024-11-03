---
title: Specify Order of Layers and Legend Labels using Python Matplotlib
toc: false
categories:
 - Python
tags:
 - Python Graphics
 - Python Matplotlib
date: 2024-11-03 11:03:59 +0800
last_modified_at: 2024-11-03 11:03:59 +0800
---

Specify oder of layers by `zorder` property[^1]:

```python
import matplotlib.pyplot as plt
%config InlineBackend.figure_format = 'svg'

import numpy as np

x = np.linspace(0, 7.5, 100)

plt.figure()
plt.rcParams['lines.linewidth'] = 5

plt.plot(x, np.sin(x), label='zorder=2', zorder=2)
plt.plot(x, np.sin(x+0.5), label='zorder=3',  zorder=3)
plt.axhline(0, label='zorder=2.5', color='lightgrey', zorder=2.5)
plt.title('Custom order of elements')

l = plt.legend(loc='upper right')
l.set_zorder(2.5)

plt.savefig("fig1.png", dpi=900, bbox_inches='tight')
plt.show()
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411031128147.png" alt="fig1" style="width:67%;" />

<br>

Specify oder of legend labels[^2]:

```python
import matplotlib.pyplot as plt
%config InlineBackend.figure_format = 'svg'

import numpy as np

x = np.linspace(0, 7.5, 100)

plt.figure()
plt.rcParams['lines.linewidth'] = 5

plt.plot(x, np.sin(x), label='line0')
plt.plot(x, np.sin(x+0.5), label='line1')
plt.axhline(0, label='line2', color='lightgrey')
plt.title('Custom order of legend labels')

handles, labels = plt.gca().get_legend_handles_labels() 
order = [1, 2, 0] 
plt.legend([handles[i] for i in order], [labels[i] for i in order], loc='upper right') 

plt.savefig("fig2.png", dpi=900, bbox_inches='tight')
plt.show()
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411031146193.png" alt="fig2" style="width:67%;" />

<br>

**References**

[^1]: [Zorder Demo](https://matplotlib.org/stable/gallery/misc/zorder_demo.html).
[^2]: [How to Change Order of Items in Matplotlib Legend?](https://www.geeksforgeeks.org/how-to-change-order-of-items-in-matplotlib-legend/).