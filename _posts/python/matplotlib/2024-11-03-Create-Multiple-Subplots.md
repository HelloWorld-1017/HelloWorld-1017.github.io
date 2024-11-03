---
title: Create Multiple Subplots using Python Matplotlib `plt.subplots`
toc: false
categories:
 - Python
tags:
 - Python Graphics
 - Python Matplotlib
date: 2024-11-03 13:17:21 +0800
last_modified_at: 2024-11-03 13:17:21 +0800
---

```python
import matplotlib.pyplot as plt
%config InlineBackend.figure_format = 'svg'
import numpy as np

x = np.linspace(0, 2 * np.pi, 400)
y = np.sin(x ** 2)

fig, axs = plt.subplots(2, 2)
axs[0, 0].plot(x, y)
axs[0, 0].set_title("main")
axs[1, 0].plot(x, y**2)
axs[1, 0].set_title("shares x with main")
axs[1, 0].sharex(axs[0, 0])
axs[0, 1].plot(x + 1, y + 1)
axs[0, 1].set_title("unrelated")
axs[1, 1].plot(x + 2, y + 2)
axs[1, 1].set_title("also unrelated")
fig.tight_layout()

plt.savefig("fig1.png", dpi=900, bbox_inches='tight')
plt.show()
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411031653433.png" alt="fig1" style="width:67%;" />

<br>

```python
import matplotlib.pyplot as plt
%config InlineBackend.figure_format = 'svg'
import numpy as np

x = np.linspace(0, 2 * np.pi, 400)
y = np.sin(x ** 2)

fig, axs = plt.subplots(2, 2)
axs[0, 0].plot(x, y)
axs[0, 0].set_title('Axis [0, 0]')
axs[0, 1].plot(x, y, 'tab:orange')
axs[0, 1].set_title('Axis [0, 1]')
axs[1, 0].plot(x, -y, 'tab:green')
axs[1, 0].set_title('Axis [1, 0]')
axs[1, 1].plot(x, -y, 'tab:red')
axs[1, 1].set_title('Axis [1, 1]')

for ax in axs.flat:
    ax.set(xlabel='x-label', ylabel='y-label')

# Hide x labels and tick labels for top plots and y ticks for right plots.
for ax in axs.flat:
    ax.label_outer()

plt.savefig("fig2.png", dpi=900, bbox_inches='tight')
plt.show()
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202411031653310.png" alt="fig2" style="width:67%;" />

<br>

**References**

- [Creating multiple subplots using `plt.subplots`](https://matplotlib.org/stable/gallery/subplots_axes_and_figures/subplots_demo.html).
- [`matplotlib.pyplot.subplots`](https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.subplots.html#matplotlib.pyplot.subplots).
- [How to Create Multiple Subplots in Matplotlib in Python?](https://www.geeksforgeeks.org/how-to-create-multiple-subplots-in-matplotlib-in-python/#).
