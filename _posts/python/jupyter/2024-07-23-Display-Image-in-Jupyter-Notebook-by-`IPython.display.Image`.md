---
title: Display Image in Jupyter Notebook by `IPython.display.Image`
toc: false
categories:
 - Python
tags:
 - Python Jupyter Notebook
 - IPython
date: 2024-07-23 17:19:57 +0800
last_modified_at: 2024-08-07 16:44:34 +0800
---

```python
from IPython.display import Image

Image('Camus.jpg', width=600)
```

![image-20240723172400292](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407231724762.png)

where `'Camus.jpg'` is a local image in current folder.

Besides, `Image` function is also available for displaying remote image via specific URL by syntax like `Image(url="<image_url>")` or simple `Image("<image_url>")`.

<br>

**References**

[1] [python - How to set image size to display in Ipython.display? - Stack Overflow](https://stackoverflow.com/questions/69654877/how-to-set-image-size-to-display-in-ipython-display).