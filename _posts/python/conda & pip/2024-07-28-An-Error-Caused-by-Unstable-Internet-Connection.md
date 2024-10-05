---
title: "An Error Caused by Unstable Internet Connection when Installing Python Package: `ERROR: THESE PACKAGES DO NOT MATCH THE HASHES FROM THE REQUIREMENTS FILE.`"
toc: false
categories:
 - Python
tags:
 - Python Warnings and Errors
 - Python pip
date: 2024-07-28 19:48:44 +0800
last_modified_at: 2024-10-05 20:54:50 +0800
---

In blog[^1], when I tried to caption images by the image-captioning model, ImageCaptioning.pytorch[^2], I found I needed to install package `scikit-image` in advance:

```powershell
pip install scikit-image
```

but after a long while, I got an error:

```
Collecting scikit-image
  Using cached scikit_image-0.24.0-cp311-cp311-win_amd64.whl.metadata (14 kB)
Requirement already satisfied: numpy>=1.23 in g:\pythonlearning\venv\lib\site-packages (from scikit-image) (1.26.4)
Collecting scipy>=1.9 (from scikit-image)
  Using cached scipy-1.14.0-cp311-cp311-win_amd64.whl.metadata (60 kB)
Requirement already satisfied: networkx>=2.8 in g:\pythonlearning\venv\lib\site-packages (from scikit-image) (3.2.1)
Requirement already satisfied: pillow>=9.1 in g:\pythonlearning\venv\lib\site-packages (from scikit-image) (10.2.0)
Collecting imageio>=2.33 (from scikit-image)
  Using cached imageio-2.34.2-py3-none-any.whl.metadata (4.9 kB)
Collecting tifffile>=2022.8.12 (from scikit-image)
  Using cached tifffile-2024.7.24-py3-none-any.whl.metadata (31 kB)
Requirement already satisfied: packaging>=21 in g:\pythonlearning\venv\lib\site-packages (from scikit-image) (24.1)
Collecting lazy-loader>=0.4 (from scikit-image)
  Using cached lazy_loader-0.4-py3-none-any.whl.metadata (7.6 kB)
Using cached scikit_image-0.24.0-cp311-cp311-win_amd64.whl (12.8 MB)
Using cached imageio-2.34.2-py3-none-any.whl (313 kB)
Using cached lazy_loader-0.4-py3-none-any.whl (12 kB)
Downloading scipy-1.14.0-cp311-cp311-win_amd64.whl (44.7 MB)
   ━━━━━━━━━━━━━━━━━━━━╺━━━━━━━━━━━━━━━━━━━ 22.8/44.7 MB 27.3 kB/s eta 0:13:24
Using cached tifffile-2024.7.24-py3-none-any.whl (226 kB)
ERROR: THESE PACKAGES DO NOT MATCH THE HASHES FROM THE REQUIREMENTS FILE. If you have updated the package versions, please update the hashes. Otherwise, examine the package contents carefully; someone may have tampered with them.
    unknown package:
        Expected sha256 5b083c8940028bb7e0b4172acafda6df762da1927b9091f9611b0bcd8676f2bc
             Got        a5b45b36e97482fc9c9f423cb8b213e1967622bed720474c1462073d9c654263
```

according to the error message, at first I tried to update `hashes`, `pip install hashes`, to solve it, but it doesn’t help, and the same error occurs again. I looked for possible solutions on Internet, and found Ritabrata reported a similar error on Stack Overflow[^3] and his own answer[^4]:

<div class="quote--left" markdown="1">

After much deliberation, I could figure this out with the help of a colleague.

Our Root cause analysis is as follows --- When we download a library, the server itself sends a SHA to be verified post download, to prevent tampering with the library. Now, due to **poor internet** connection, the library was getting corrupted while downloading and hence the sha mismatch happened. It sounds incredibly weird to me since I assumed pip would have detected this failure and prompted that the library download failed.

Anyway, we ran the same docker image on a VM and it worked like a charm.

</div>

Internet connection is unstable. I think it’s true, because I even feel that it costs longer time to install than PyTorch! So, I decide to change installing source using `pip install` with `-i` option[^5]:

<div class="quote--left" markdown="1">

`-i`, `--index-url` `<url>`

Base URL of the Python Package Index (default [https://pypi.org/simple](https://pypi.org/simple)). This should point to a repository compliant with PEP 503 (the simple repository API) or a local directory laid out in the same format.

(environment variable: `PIP_INDEX_URL`, `PIP_PYPI_URL`)

</div>

 and the source I choose is Tsinghua Open Source Mirror[^6]:

```powershell
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple scikit-image
```

At last, it solves the problem, installing `scikit-image` successfully and very quickly.

<br>

**References**

[^1]: [Caption Images by A Pretrained Image-Captioning Model](https://helloworld-1017.github.io/2024-07-28/19-10-54.html).
[^2]: [deep-learning-with-pytorch/ImageCaptioning.pytorch](https://github.com/deep-learning-with-pytorch/ImageCaptioning.pytorch).

[^3]: [python - Sha256 Mismatch for pip install on fresh docker image](https://stackoverflow.com/questions/62726398/sha256-mismatch-for-pip-install-on-fresh-docker-image).
[^4]: [https://stackoverflow.com/a/62737561/22763127](https://stackoverflow.com/a/62737561/22763127).
[^5]: [`pip install`: `-i`, `--index-url` `<url>`](https://pip.pypa.io/en/stable/cli/pip_install/#cmdoption-i).
[^6]: [pypi](https://mirrors.tuna.tsinghua.edu.cn/help/pypi/).
