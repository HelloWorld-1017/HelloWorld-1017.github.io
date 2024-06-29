---
layout: single
title: Export High Resolution Graphics in Python using Matplotlib `pyplot.savefig` Function
toc: false
categories:
 - Python
tags:
 - Python Graphics
 - Python matplotlib
drafted_at: 2024-05-25 10:00:02 +0800
date: 2024-05-25 11:09:18 +0800
last_modified_at0: 2024-05-25 11:09:18 +0800
last_modified_at: 2024-05-25 11:09:18 +0800
---

In Python, we can use Matplotlib `pyplot.savefig` function[^1] to export graphics, and specify dpi (dots per inch)[^2] of the figure. Take the Matplotlib official example *Bar color demo*[^3] as an example:

```python
# https://matplotlib.org/stable/gallery/lines_bars_and_markers/bar_colors.html#sphx-glr-gallery-lines-bars-and-markers-bar-colors-py

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

# Save the figure
plt.savefig("image.png",dpi=300)

# Show the figure
plt.show()
```

300 dpi (65 KB):

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405251020016.png" alt="image" style="zoom: 50%;" />

600 dpi (149 KB):

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405251021222.png" alt="image" style="zoom: 50%;" />

1800 dpi (665 KB):

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405251022274.png" alt="image" style="zoom:50%;" />

Compared with the way of directly copying image (in Spyder software) by right clicking on the image and then choosing `Copy Image` (the result shows as follows), we can get a much clearer image by `pyplot.savefig` function:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405251050815.png" alt="image-20240525104951321" style="zoom:200%;" />

this feature is the same as in MATLAB. 

However, it should be noted that, `pyplot.savefig` should be used BEFORE `pyplot.show`; if choose the opposite order:

```python
# ...

# Show the figure
plt.show()

# Save the figure
plt.savefig("image.png",dpi=300)
```

the exported image is empty:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405251023449.png" alt="image" style="zoom:50%;" />

As described in Matplotlib documentation[^4], this is because `pyplot.show` function will close the figure: 

"If you want an image file as well as a user interface window, use `pyplot.savefig` before `pyplot.show`. At the end of (a blocking) `show()` the figure is closed and thus unregistered from pyplot. Calling `pyplot.savefig` afterwards would save a new and thus empty figure. This limitation of command order does not apply if the show is non-blocking or if you keep a reference to the figure and use `Figure.savefig`."

<br>

# References

[^1]: [`matplotlib.pyplot.savefig` — Matplotlib 3.9.0 documentation](https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.savefig.html).
[^2]: [Dots per inch - Wikipedia](https://en.wikipedia.org/wiki/Dots_per_inch).
[^3]: [Bar color demo — Matplotlib 3.9.0 documentation](https://matplotlib.org/stable/gallery/lines_bars_and_markers/bar_colors.html#sphx-glr-gallery-lines-bars-and-markers-bar-colors-py).
[^4]: [`matplotlib.pyplot.show` — Matplotlib 3.9.0 documentation](https://matplotlib.org/stable/api/_as_gen/matplotlib.pyplot.show.html).
