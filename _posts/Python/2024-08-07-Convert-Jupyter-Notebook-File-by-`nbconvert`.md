---
title: "Convert Jupyter Notebook File to HTML, Markdown, and Python Script File by `nbconvert` Tool"
categories:
 - Python
 - Web Development
tags:
 - Python Jupyter Notebook
 - HTML
 - Markdown
 - Jekyll
date: 2024-08-07 16:54:21 +0800
last_modified_at: 2024-08-07 16:54:21 +0800
---

## Introduction

Python `nbconvert` tool is to convert Jupyter Notebook file, i.e. `.ipynb` file, to other static formats, like HTML, Markdown ect[^1]. I am mainly interested in `.ipynb`-to-`.html` conversion, so I decide to record it down in this post. Having said that, I also tried others.

`nbconvert` provides users two ways to realize conversion, “using as a command line tool”[^2] and “using `nbconvert` as a library” (i.e. import `nbconvert` in a `.py` file)[^3]. The former is more straightforward to me, so I only test those commands in the documentation[^2].

I create an example file named `notebook.ipynb` in advance, and use following commands to make corresponding conversion. Here are results. 

<br>

## Conversion to HTML file

When converting Jupyter Notebook file to HTML file, we can choose different templates:

```powershell
jupyter nbconvert --to html notebook.ipynb
jupyter nbconvert --to html --template lab notebook.ipynb
jupyter nbconvert --to html --template classic notebook.ipynb
jupyter nbconvert --to html --template basic notebook.ipynb
jupyter nbconvert --to html --embed-images notebook.ipynb
```

and corresponding generated HTML webpages are (I’ve uploaded them into my website folder):

- Default style: [http://helloworld-1017.github.io/webpages/2024-08-07/notebook\_default.html](http://helloworld-1017.github.io/webpages/2024-08-07/notebook_default.html).
- `--template lab` (the same as default setting): [http://helloworld-1017.github.io/webpages/2024-08-07/notebook\_lab.html](http://helloworld-1017.github.io/webpages/2024-08-07/notebook_lab.html).
- `--template classic`: [http://helloworld-1017.github.io/webpages/2024-08-07/notebook\_classic.html](http://helloworld-1017.github.io/webpages/2024-08-07/notebook_classic.html).
- `--template basic`: [http://helloworld-1017.github.io/webpages/2024-08-07/notebook\_basic.html](http://helloworld-1017.github.io/webpages/2024-08-07/notebook_basic.html).
- `--embed-images`: [http://helloworld-1017.github.io/webpages/2024-08-07/notebook\_embed-images.html](http://helloworld-1017.github.io/webpages/2024-08-07/notebook_embed-images.html).

<br>

## Conversion to Markdown file

Convert to Markdown file by:

```powershell
jupyter nbconvert --to markdown notebook.ipynb
```

after it, a `notebook.md` file and a subfolder `notebook_files` appear in the current folder. Attached image files are stored in `notebook_files` (in this case there’s only one image, i.e. `notebook_2_0.svg`), and the generated Markdown file `notebook.md` looks very normative, showing as follows:

````markdown
```python
a = 1
b = 2
print(a, b)
```

    1 2



```python
c = a+b
print(c)
```

    3



```python
import matplotlib.pyplot as plt
%config InlineBackend.figure_format = 'svg'

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


​    
![svg](notebook_files/notebook_2_0.svg)
​    


# Caption 1

## Caption 1.1

### Caption 1.1.1

#### Caption 1.1.1.1

This is a markdown block.


```python
from IPython.display import Image

Image(url="https://upload.wikimedia.org/wikipedia/commons/9/94/Animation_Sieve_of_Eratosth.gif?20061230143851")
```




<img src="https://upload.wikimedia.org/wikipedia/commons/9/94/Animation_Sieve_of_Eratosth.gif?20061230143851"/>



Above GIF is abtained from Wikipedia entry "[Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)" to show Sieve of Eratosthenes for finding all prime numbers up to any given limit.
````

In my opinion, this way is more suitable for Jekyll website workflow than directly generating HTML file: although above HTML files indeed look more like Jupyter Notebook, there are plenty of code for styling, which may not compatible with particular Jekyll template, whereas Markdown file is much cleaner.

<br>

## Conversion to Python script file

Convert to executable Python script file by:

```powershell
jupyter nbconvert --to script notebook.ipynb
```

then we’ll get a `notebook.py`:

```python
#!/usr/bin/env python
# coding: utf-8

# In[1]:


a = 1
b = 2
print(a, b)


# In[2]:


c = a+b
print(c)


# In[3]:


import matplotlib.pyplot as plt
get_ipython().run_line_magic('config', "InlineBackend.figure_format = 'svg'")

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


# # Caption 1
# 
# ## Caption 1.1
# 
# ### Caption 1.1.1
# 
# #### Caption 1.1.1.1
# 
# This is a markdown block.

# In[4]:


from IPython.display import Image

Image(url="https://upload.wikimedia.org/wikipedia/commons/9/94/Animation_Sieve_of_Eratosth.gif?20061230143851")


# Above GIF is abtained from Wikipedia entry "[Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)" to show Sieve of Eratosthenes for finding all prime numbers up to any given limit.
```

<br>

## Conversion to other file formats

In addition to aforementioned three file formats, there’re also some others. However, to make these conversion processes available, some extra softwares or modules are needed, error occurs otherwise. Due to they are not necessary to me right now, I just record them here, with no providing remedy.

(1) LaTeX

```powershell
jupyter nbconvert --to latex notebook.ipynb
jupyter nbconvert --to latex --template report notebook.ipynb
jupyter nbconvert --to latex --template report --LatexPreprocessor.title "xxxx" --LatexPreprocessor.date "xxxx" --LatexPreprocessor.author_names "xxx" notebook.ipynb
```

```
FileNotFoundError: Inkscape executable not found
```

(2) PDF

```powershell
jupyter nbconvert --to pdf notebook.ipynb
```

```
FileNotFoundError: Inkscape executable not found
```

(3) WebPDF

```powershell
jupyter nbconvert --to webpdf notebook.ipynb
```

```
RuntimeError: Playwright is not installed to support Web PDF conversion. Please install `nbconvert[webpdf]` to enable.
```

(4) Ascii doc

```powershell
jupyter nbconvert --to asciidoc notebook.ipynb
```

```
nbconvert.utils.pandoc.PandocMissing: Pandoc wasn't found.
Please check that pandoc is installed:
https://pandoc.org/installing.html
```

<br>

## Convert multiple notebook files

Besides, we can convert several notebook files at once, which can be found in corresponding section[^4] of the documentation.

<br>

**References**

[^1]: [nbconvert: Convert Notebooks to other formats — nbconvert 7.16.4 documentation](https://nbconvert.readthedocs.io/en/latest/index.html).

[^2]: [Using as a command line tool — nbconvert 7.16.4 documentation](https://nbconvert.readthedocs.io/en/latest/usage.html).
[^3]: [Using nbconvert as a library — nbconvert 7.16.4 documentation](https://nbconvert.readthedocs.io/en/latest/nbconvert_library.html).
[^4]: [Using as a command line tool: Converting multiple notebooks — nbconvert 7.16.4 documentation](https://nbconvert.readthedocs.io/en/latest/usage.html#converting-multiple-notebooks).
