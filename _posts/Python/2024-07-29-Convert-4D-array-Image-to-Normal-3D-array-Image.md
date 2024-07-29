---
title: Convert 4D-array Image (with RGBA Channels) to Normal 3D-array Image
toc: false
categories:
 - Python
tags:
 - Python Imaging Library
 - PyTorch Warnings and Errors
 - Python os
 - Computer Vision
date: 2024-07-29 11:37:06 +0800
last_modified_at: 2024-07-29 11:37:06 +0800
---

Blog[^1] takes following images to test an image-captioning model:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407272109504.png" alt="image-20240727210900379" style="zoom:67%;" />

However, when I added the following image, `R66.png`, to be tested:

![R66](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407282102356.png)

I got an error saying:

```
Traceback (most recent call last):
  File "G:\...\ImageCaptioning.pytorch-master\eval.py", line 136, in <module>
    loss, split_predictions, lang_stats = eval_utils.eval_split(
                                          ^^^^^^^^^^^^^^^^^^^^^^
  File "G:\...\ImageCaptioning.pytorch-master\eval_utils.py", line 84, in eval_split
    data = loader.get_batch(split)
           ^^^^^^^^^^^^^^^^^^^^^^^
  File "G:\...\ImageCaptioning.pytorch-master\dataloaderraw.py", line 115, in get_batch
    img = Variable(preprocess(img))
                   ^^^^^^^^^^^^^^^
  File "G:\...\venv\Lib\site-packages\torchvision\transforms\transforms.py", line 95, in __call__
    img = t(img)
          ^^^^^^
  File "G:\...\venv\Lib\site-packages\torch\nn\modules\module.py", line 1532, in _wrapped_call_impl
    return self._call_impl(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "G:\...\venv\Lib\site-packages\torch\nn\modules\module.py", line 1541, in _call_impl
    return forward_call(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "G:\...\venv\Lib\site-packages\torchvision\transforms\transforms.py", line 277, in forward
    return F.normalize(tensor, self.mean, self.std, self.inplace)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "G:\...\venv\Lib\site-packages\torchvision\transforms\functional.py", line 350, in normalize
    return F_t.normalize(tensor, mean=mean, std=std, inplace=inplace)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "G:\...\venv\Lib\site-packages\torchvision\transforms\_functional_tensor.py", line 926, in normalize
    return tensor.sub_(mean).div_(std)
           ^^^^^^^^^^^^^^^^^
RuntimeError: The size of tensor a (4) must match the size of tensor b (3) at non-singleton dimension 0
```

which prompts that, besides RGB channels this image file has an additional alpha channel[^2], that is the image is a 4D array (RGBA). So, it cannot be normally processed by certain function. We can verify this point by printing image array size:

```python
from PIL import Image
import numpy as np
import os

folder_path = '.'
for file_name in os.listdir(folder_path):  
    image_path = os.path.join(folder_path, file_name)
    
    if file_name.endswith(('.png', '.jpg')):  
        image = Image.open(image_path)
        print("%-19s: %s" % (file_name, np.array(image).shape))
```

<div id="figures-information"></div>

```
Camus.jpg          : (900, 1321)
horse.jpg          : (1220, 1500, 3)
moon.jpg           : (1800, 2880, 3)
QingFengChuiFu.jpg : (1080, 1920, 3)
R66.png            : (1800, 2880, 4)
sunset.jpg         : (1200, 1920, 3)
Tommy.jpg          : (3412, 5118, 3)
YourName.jpg       : (1200, 1920, 3)
zebra.jpg          : (256, 316, 3)
```

To avoid above error, we could use `.convert` function[^3] to convert RGBA image to RGB image:

```python
image = Image.open("R66.png").convert('RGB')
print(np.array(image).shape)
image.save("R66_RGB.png")
```

```
(1800, 2880, 3)
```

After conversion, the image-captioning model can caption it normally:

<div id="caption"></div>

```
".\data\images\new_images\R66_RGB.png": a close up of a yellow and orange cat
```

But, in this caption the only right part is “orange” 😂 Having said that, anyway, this image become a valid input for the model.

<br>

By the way, due to that `R66.png` is only the image with `.png` extension among [those figures](#figures-information), so I suspect that PNG file may be always an image with RGBA channel, but [above result](#caption) illustrates it’s not a right guess.

<br>

**References**

[^1]: [Caption Images by a Pretrained Image-Captioning Model - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-28/19-10-54.html).
[^2]: [https://stackoverflow.com/a/58497441/22763127](https://stackoverflow.com/a/58497441/22763127).
[^3]: [Image Module: `Image.convert()` - Pillow (PIL Fork) 10.4.0 documentation](https://pillow.readthedocs.io/en/stable/reference/Image.html#PIL.Image.Image.convert).
