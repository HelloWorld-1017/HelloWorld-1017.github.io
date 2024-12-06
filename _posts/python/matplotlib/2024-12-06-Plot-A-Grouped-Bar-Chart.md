---
title: Plot A Grouped Bar Chart using Python Matplotlib
toc: false
categories:
 - Python
tags:
 - Python Graphics
 - Python Matplotlib
date: 2024-12-06 11:07:11 +0800
last_modified_at: 2024-12-06 11:07:11 +0800 
---

A Python Matplotlib official example[^1] shows how to plot a grouped bar chart:

```python
# data from https://allisonhorst.github.io/palmerpenguins/

import matplotlib.pyplot as plt
import numpy as np
%config InlineBackend.figure_format = 'svg'

species = ("Adelie", "Chinstrap", "Gentoo")
penguin_means = {
    'Bill Depth': (18.35, 18.43, 14.98),
    'Bill Length': (38.79, 48.83, 47.50),
    'Flipper Length': (189.95, 195.82, 217.19),
}

x = np.arange(len(species))  # the label locations
width = 0.25  # the width of the bars
multiplier = 0

fig, ax = plt.subplots(layout='constrained')

for attribute, measurement in penguin_means.items():
    offset = width * multiplier
    rects = ax.bar(x + offset, measurement, width, label=attribute)
    ax.bar_label(rects, padding=3)
    multiplier += 1

# Add some text for labels, title and custom x-axis tick labels, etc.
ax.set_ylabel('Length (mm)')
ax.set_title('Penguin attributes by species')
ax.set_xticks(x + width, species)
ax.legend(loc='upper left', ncols=3)
ax.set_ylim(0, 250)

plt.savefig("fig.png", dpi=900, bbox_inches='tight')
plt.show()
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202412061110529.png" alt="fig" style="width:67%;" />

As can be seen, putting multiple sets of bars of one class in parallel is realized by an "offset".

<div class="notice--primary" markdown="1">

By default, bar charts will completely overlap together if we use `bar` function one by one:

```python
import matplotlib.pyplot as plt
import numpy as np
%config InlineBackend.figure_format = 'svg'

species = ("Adelie", "Chinstrap", "Gentoo")
penguin_means = {
    'Bill Depth': (18.35, 18.43, 14.98),
    'Bill Length': (38.79, 48.83, 47.50),
    'Flipper Length': (189.95, 195.82, 217.19),
}

fig, ax = plt.subplots(layout='constrained')

for attribute, measurement in penguin_means.items():
    plt.bar(species, measurement, alpha=0.2)

ax.set_ylabel('Length (mm)')
ax.set_title('Penguin attributes by species')
ax.set_ylim(0, 250)

plt.savefig("fig.png", dpi=900, bbox_inches='tight')
plt.show()
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202412061118253.png" alt="fig" style="width:67%;" />

</div>

To step further, we can change the width of a bar to leave a gap between two adjacent bars:

```python
# ...

for attribute, measurement in penguin_means.items():
    # ...
    rects = ax.bar(x + offset, measurement, 0.15, label=attribute)
    # ...

# ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202412061129629.png" alt="fig" style="width:67%;" />

and if we just want to change the bar width with no leaving gap, we can simply change `width` variable, for example:

```python
# ...

width = 0.15  # the width of the bars

# ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202412061132798.png" alt="fig" style="width:67%;" />

<br>

**References**

[^1]: [Grouped bar chart with labels](https://matplotlib.org/stable/gallery/lines_bars_and_markers/barchart.html#sphx-glr-gallery-lines-bars-and-markers-barchart-py).
