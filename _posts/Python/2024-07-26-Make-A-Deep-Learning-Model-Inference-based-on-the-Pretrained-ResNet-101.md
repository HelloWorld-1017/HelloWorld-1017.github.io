---
title: Make A Deep Learning Model Inference based on the Pretrained ResNet-101
toc: false
categories:
 - Python
 - Machine Learning
tags:
 - Python PyTorch
 - <i>Deep Learning with PyTorch</i>
 - Computer Vision
date: 2024-07-26 15:58:39 +0800
last_modified_at: 2024-07-27 11:24:26 +0800
---

Stevens et al.’s book, *Deep Learning with PyTorch*[^1] (on Subchapter 2.1, *A pretrained network that recognizes the subject of an image*), provides a simple example showing how to realize model inference based on the pretrained ResNet-101. The complete script shows as follows:

```python
import torch
from torchvision import models
from torchvision.models import ResNet101_Weights
from PIL import Image
from torchvision import transforms

# Obtain pretrained ResNet-101
resnet101 = models.resnet101(weights=ResNet101_Weights.IMAGENET1K_V1)


# Define image preprocess pipeline
preprocess = transforms.Compose([
    transforms.Resize(256),
    transforms.CenterCrop(224),
    transforms.ToTensor(),
    transforms.Normalize(
        mean=[0.485, 0.456, 0.406],
        std=[0.229, 0.224, 0.225]
    )
])


# Load an image and preprocess it
img = Image.open("bobby.jpg") # img.size: (1280, 720)
# img # Show the image inline
# img.show() # Show the image in a new pop-up viewer window
img_t = preprocess(img) # img_t.shape: (torch.Size([3, 224, 224])
batch_t = torch.unsqueeze(img_t, 0)# batch_t.shape: torch.Size([1, 3, 224, 224]))


# NOTE: Put the network in `eval()` mode to do inference
resnet101.eval()
out = resnet101(batch_t) # out.shape: torch.Size([1, 1000])


# Load labels from `.txt` file (1,000 labels)
with open('imagenet_classes.txt') as f:
    labels = [line.strip() for line in f.readlines()] 


# Determine the index corresponding to the maximum score in the `out` tensor
_, index = torch.max(out,1) # index: tensor([207])
percentage = torch.nn.functional.softmax(out, dim=1)[0]*100 # percentage.shape: torch.Size([1000])
(labels[index[0]], percentage[index[0]].item()) # ('golden retriever', 96.57185363769531)


# Determine the indexes corresponding to the top-5 maximum score in the `out` tensor
_, indices = torch.sort(out, descending=True)
[(labels[idx], percentage[idx].item()) for idx in indices[0][:5]]
# [('golden retriever', 96.57185363769531),
#  ('Labrador retriever', 2.6082706451416016),
#  ('cocker spaniel, English cocker spaniel, cocker', 0.2699621915817261),
#  ('redbone', 0.17958936095237732),
#  ('tennis ball', 0.10991999506950378)]
```

**Required files**

- `bobby.jpg`: [dlwpt-code/data/p1ch2/bobby.jpg at master · deep-learning-with-pytorch/dlwpt-code](https://github.com/deep-learning-with-pytorch/dlwpt-code/blob/master/data/p1ch2/bobby.jpg).

  <img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407271120489.jpg" alt="bobby" style="zoom:50%;" />

- `imagenet_classes.txt`: [dlwpt-code/data/p1ch2/imagenet_classes.txt at master · deep-learning-with-pytorch/dlwpt-code](https://github.com/deep-learning-with-pytorch/dlwpt-code/blob/master/data/p1ch2/imagenet_classes.txt).

**Notes**

- Image preprocess step: we have to preprocess the input images so they are the right size and so that their values (colors) sit roughly in the same numerical range. In order to do that, the `torchvision` module provides `transforms`, which allow us to quickly define pipelines of basic preprocessing functions[^1].
- `torch.unsqueeze`: Returns a new tensor with a dimension of size one inserted at the specified position[^2].
- *inference*: The process of running a trained model on new data is called *inference* in deep learning circles[^1].
- `labels = [line.strip() for line in f.readlines()]`:
  - `readlines()` method: Return all lines in the file, as a list where each line is an item in the list object[^4].
  - `strip()` method: The `strip()` method removes any leading, and trailing whitespaces[^3].
- `torch.max`: Returns a namedtuple `(values, indices)` where `values` is the maximum value of each row of the `input` tensor in the given dimension `dim`. And `indices` is the index location of each maximum value found (argmax)[^5].

<br>

**References**

[^1]: [Deep Learning with PyTorch](https://isip.piconepress.com/courses/temple/ece_4822/resources/books/Deep-Learning-with-PyTorch.pdf), Eli Stevens, Luca Antiga, and Thomas Viehmann, 2020, GitHub repository: [deep-learning-with-pytorch](https://github.com/deep-learning-with-pytorch/dlwpt-code), pp. 22-27.
[^2]: [`torch.unsqueeze` — PyTorch 2.4 documentation](https://pytorch.org/docs/stable/generated/torch.unsqueeze.html).
[^3]: [Python String `strip()` Method](https://www.w3schools.com/python/ref_string_strip.asp).
[^4]: [Python File `readlines() `Method](https://www.w3schools.com/python/ref_file_readlines.asp).
[^5]: [`torch.max` — PyTorch 2.4 documentation](https://pytorch.org/docs/stable/generated/torch.max.html).
