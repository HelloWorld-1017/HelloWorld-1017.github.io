---
title: The Number of Newborns in China
toc: false
categories:
 - Python
 - Sociology
tags:
 - Python Graphics
 - Python Matplotlib
date: 2024-08-16 12:03:07 +0800
last_modified_at: 2024-11-03 10:55:59 +0800
---

```python
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import host_subplot
%config InlineBackend.figure_format = 'svg'

import numpy as np

years = np.array(range(1980, 2024))
num = np.array([1776, 2064, 2229.6, 2052, 2049.8,
      2195.6, 2374, 2508, 2445, 2396,
      2373.5, 2250, 2112.6, 2119.6, 2097.7,
      2051.8, 2056.6, 2028, 1933.5, 1826.5,
      1765, 1696, 1641, 1594, 1588,
      1612, 1580.8, 1590.5, 1604, 1587,
      1588, 1604, 1635, 1640, 1687,
      1655, 1786, 1723, 1523, 1465,
      1200, 1062, 956, 902])/100
num_diff = np.diff(num)

ax1 = host_subplot(111)
ax2 = ax1.twinx()

ax1.plot(years, num, linewidth=1.5, c='r', zorder=2, label='Number')
ax1.scatter([2016, 2023], [17.86, 9.02], zorder=3, s=10)
ax1.text(2016, 17.86, '(2016, 17.86)', fontsize=10)
ax1.text(2013, 9.02, '(2023, 9.02)', fontsize=10)

ax2.bar(years[1::], num_diff, color='blue', alpha=0.3, label='Diff', zorder=1)

ax1.set_xlabel('Year')
ax1.set_ylabel('Number')
ax2.set_ylabel('Diff')
plt.title('Newborns in China (Million)')
ax1.legend(labelcolor="linecolor")

plt.savefig("fig.png", dpi=900, bbox_inches='tight')
plt.show()
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411031054533.png" alt="fig" style="width:67%;" />

<br>

**References**

- [出生人口](https://baike.baidu.com/item/%E5%87%BA%E7%94%9F%E4%BA%BA%E5%8F%A3/22919309).
