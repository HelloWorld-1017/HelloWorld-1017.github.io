---
title: "Ways of Visualizing PyTorch Neural Network Structure: with the help of `torchsummary`, `torchinfo`, `netron`, and `tensorboardX` packages respectively"
categories:
 - Python
tags:
 - Python PyTorch
 - PyTorch Warnings and Errors
date: 2024-07-25 10:42:24 +0800
last_modified_at: 2024-07-25 10:42:24 +0800
---

In blog[^1], I make a simple pre-trained ResNet-101 in `torchvision.models` subpackage. But I found it’s not intuitive to inspect its structure just by printing parameters of each layer, so I tried to find some visualization methods. At last, mainly referring to two blogs[^2][^3], I record some visualization ways in this post.

<br>

# `print` function

Requirements:

- `print` function.

```python
from torchvision import models
from torchvision.models import ResNet101_Weights

resnet101 = models.resnet101(weights=ResNet101_Weights.IMAGENET1K_V1)
print(resnet101)
```

```
ResNet(
  (conv1): Conv2d(3, 64, kernel_size=(7, 7), stride=(2, 2), padding=(3, 3), bias=False)
  (bn1): BatchNorm2d(64, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
  (relu): ReLU(inplace=True)
  (maxpool): MaxPool2d(kernel_size=3, stride=2, padding=1, dilation=1, ceil_mode=False)
  (layer1): Sequential(
    (0): Bottleneck(
      (conv1): Conv2d(64, 64, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(64, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(64, 64, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(64, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(64, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
      (downsample): Sequential(
        (0): Conv2d(64, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
        (1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      )
    )
    (1): Bottleneck(
      (conv1): Conv2d(256, 64, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(64, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(64, 64, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(64, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(64, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (2): Bottleneck(
      (conv1): Conv2d(256, 64, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(64, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(64, 64, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(64, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(64, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
  )
  (layer2): Sequential(
    (0): Bottleneck(
      (conv1): Conv2d(256, 128, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(128, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(128, 128, kernel_size=(3, 3), stride=(2, 2), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(128, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(128, 512, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
      (downsample): Sequential(
        (0): Conv2d(256, 512, kernel_size=(1, 1), stride=(2, 2), bias=False)
        (1): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      )
    )
    (1): Bottleneck(
      (conv1): Conv2d(512, 128, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(128, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(128, 128, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(128, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(128, 512, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (2): Bottleneck(
      (conv1): Conv2d(512, 128, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(128, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(128, 128, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(128, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(128, 512, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (3): Bottleneck(
      (conv1): Conv2d(512, 128, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(128, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(128, 128, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(128, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(128, 512, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
  )
  (layer3): Sequential(
    (0): Bottleneck(
      (conv1): Conv2d(512, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(2, 2), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
      (downsample): Sequential(
        (0): Conv2d(512, 1024, kernel_size=(1, 1), stride=(2, 2), bias=False)
        (1): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      )
    )
    (1): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (2): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (3): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (4): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (5): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (6): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (7): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (8): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (9): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (10): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (11): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (12): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (13): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (14): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (15): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (16): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (17): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (18): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (19): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (20): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (21): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (22): Bottleneck(
      (conv1): Conv2d(1024, 256, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(256, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(256, 1024, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(1024, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
  )
  (layer4): Sequential(
    (0): Bottleneck(
      (conv1): Conv2d(1024, 512, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(512, 512, kernel_size=(3, 3), stride=(2, 2), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(512, 2048, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(2048, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
      (downsample): Sequential(
        (0): Conv2d(1024, 2048, kernel_size=(1, 1), stride=(2, 2), bias=False)
        (1): BatchNorm2d(2048, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      )
    )
    (1): Bottleneck(
      (conv1): Conv2d(2048, 512, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(512, 512, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(512, 2048, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(2048, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
    (2): Bottleneck(
      (conv1): Conv2d(2048, 512, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn1): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv2): Conv2d(512, 512, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1), bias=False)
      (bn2): BatchNorm2d(512, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (conv3): Conv2d(512, 2048, kernel_size=(1, 1), stride=(1, 1), bias=False)
      (bn3): BatchNorm2d(2048, eps=1e-05, momentum=0.1, affine=True, track_running_stats=True)
      (relu): ReLU(inplace=True)
    )
  )
  (avgpool): AdaptiveAvgPool2d(output_size=(1, 1))
  (fc): Linear(in_features=2048, out_features=1000, bias=True)
)
```

<br>

# `torchsummary` package

Requirements[^4]:

- `torchsummary` package: install by `pip install torchsummary`.

```python
from torchvision import models
from torchvision.models import ResNet101_Weights

resnet101 = models.resnet101(weights=ResNet101_Weights.IMAGENET1K_V1)

from torchsummary import summary
summary(resnet101.cuda(), (3, 224, 224))
```

<div class="notice--warning" markdown="1">
Don’t forget to allocate model to GPU by `.cuda()`[^6], otherwise an error will occur:

```python
# ...

from torchsummary import summary
summary(resnet101, (3, 224, 224))
```

```
RuntimeError: Input type (torch.cuda.FloatTensor) and weight type (torch.FloatTensor) should be the same
```

</div>

```
----------------------------------------------------------------
        Layer (type)               Output Shape         Param #
================================================================
            Conv2d-1         [-1, 64, 112, 112]           9,408
       BatchNorm2d-2         [-1, 64, 112, 112]             128
              ReLU-3         [-1, 64, 112, 112]               0
         MaxPool2d-4           [-1, 64, 56, 56]               0
            Conv2d-5           [-1, 64, 56, 56]           4,096
       BatchNorm2d-6           [-1, 64, 56, 56]             128
              ReLU-7           [-1, 64, 56, 56]               0
            Conv2d-8           [-1, 64, 56, 56]          36,864
       BatchNorm2d-9           [-1, 64, 56, 56]             128
             ReLU-10           [-1, 64, 56, 56]               0
           Conv2d-11          [-1, 256, 56, 56]          16,384
      BatchNorm2d-12          [-1, 256, 56, 56]             512
           Conv2d-13          [-1, 256, 56, 56]          16,384
      BatchNorm2d-14          [-1, 256, 56, 56]             512
             ReLU-15          [-1, 256, 56, 56]               0
       Bottleneck-16          [-1, 256, 56, 56]               0
           Conv2d-17           [-1, 64, 56, 56]          16,384
      BatchNorm2d-18           [-1, 64, 56, 56]             128
             ReLU-19           [-1, 64, 56, 56]               0
           Conv2d-20           [-1, 64, 56, 56]          36,864
      BatchNorm2d-21           [-1, 64, 56, 56]             128
             ReLU-22           [-1, 64, 56, 56]               0
           Conv2d-23          [-1, 256, 56, 56]          16,384
      BatchNorm2d-24          [-1, 256, 56, 56]             512
             ReLU-25          [-1, 256, 56, 56]               0
       Bottleneck-26          [-1, 256, 56, 56]               0
           Conv2d-27           [-1, 64, 56, 56]          16,384
      BatchNorm2d-28           [-1, 64, 56, 56]             128
             ReLU-29           [-1, 64, 56, 56]               0
           Conv2d-30           [-1, 64, 56, 56]          36,864
      BatchNorm2d-31           [-1, 64, 56, 56]             128
             ReLU-32           [-1, 64, 56, 56]               0
           Conv2d-33          [-1, 256, 56, 56]          16,384
      BatchNorm2d-34          [-1, 256, 56, 56]             512
             ReLU-35          [-1, 256, 56, 56]               0
       Bottleneck-36          [-1, 256, 56, 56]               0
           Conv2d-37          [-1, 128, 56, 56]          32,768
      BatchNorm2d-38          [-1, 128, 56, 56]             256
             ReLU-39          [-1, 128, 56, 56]               0
           Conv2d-40          [-1, 128, 28, 28]         147,456
      BatchNorm2d-41          [-1, 128, 28, 28]             256
             ReLU-42          [-1, 128, 28, 28]               0
           Conv2d-43          [-1, 512, 28, 28]          65,536
      BatchNorm2d-44          [-1, 512, 28, 28]           1,024
           Conv2d-45          [-1, 512, 28, 28]         131,072
      BatchNorm2d-46          [-1, 512, 28, 28]           1,024
             ReLU-47          [-1, 512, 28, 28]               0
       Bottleneck-48          [-1, 512, 28, 28]               0
           Conv2d-49          [-1, 128, 28, 28]          65,536
      BatchNorm2d-50          [-1, 128, 28, 28]             256
             ReLU-51          [-1, 128, 28, 28]               0
           Conv2d-52          [-1, 128, 28, 28]         147,456
      BatchNorm2d-53          [-1, 128, 28, 28]             256
             ReLU-54          [-1, 128, 28, 28]               0
           Conv2d-55          [-1, 512, 28, 28]          65,536
      BatchNorm2d-56          [-1, 512, 28, 28]           1,024
             ReLU-57          [-1, 512, 28, 28]               0
       Bottleneck-58          [-1, 512, 28, 28]               0
           Conv2d-59          [-1, 128, 28, 28]          65,536
      BatchNorm2d-60          [-1, 128, 28, 28]             256
             ReLU-61          [-1, 128, 28, 28]               0
           Conv2d-62          [-1, 128, 28, 28]         147,456
      BatchNorm2d-63          [-1, 128, 28, 28]             256
             ReLU-64          [-1, 128, 28, 28]               0
           Conv2d-65          [-1, 512, 28, 28]          65,536
      BatchNorm2d-66          [-1, 512, 28, 28]           1,024
             ReLU-67          [-1, 512, 28, 28]               0
       Bottleneck-68          [-1, 512, 28, 28]               0
           Conv2d-69          [-1, 128, 28, 28]          65,536
      BatchNorm2d-70          [-1, 128, 28, 28]             256
             ReLU-71          [-1, 128, 28, 28]               0
           Conv2d-72          [-1, 128, 28, 28]         147,456
      BatchNorm2d-73          [-1, 128, 28, 28]             256
             ReLU-74          [-1, 128, 28, 28]               0
           Conv2d-75          [-1, 512, 28, 28]          65,536
      BatchNorm2d-76          [-1, 512, 28, 28]           1,024
             ReLU-77          [-1, 512, 28, 28]               0
       Bottleneck-78          [-1, 512, 28, 28]               0
           Conv2d-79          [-1, 256, 28, 28]         131,072
      BatchNorm2d-80          [-1, 256, 28, 28]             512
             ReLU-81          [-1, 256, 28, 28]               0
           Conv2d-82          [-1, 256, 14, 14]         589,824
      BatchNorm2d-83          [-1, 256, 14, 14]             512
             ReLU-84          [-1, 256, 14, 14]               0
           Conv2d-85         [-1, 1024, 14, 14]         262,144
      BatchNorm2d-86         [-1, 1024, 14, 14]           2,048
           Conv2d-87         [-1, 1024, 14, 14]         524,288
      BatchNorm2d-88         [-1, 1024, 14, 14]           2,048
             ReLU-89         [-1, 1024, 14, 14]               0
       Bottleneck-90         [-1, 1024, 14, 14]               0
           Conv2d-91          [-1, 256, 14, 14]         262,144
      BatchNorm2d-92          [-1, 256, 14, 14]             512
             ReLU-93          [-1, 256, 14, 14]               0
           Conv2d-94          [-1, 256, 14, 14]         589,824
      BatchNorm2d-95          [-1, 256, 14, 14]             512
             ReLU-96          [-1, 256, 14, 14]               0
           Conv2d-97         [-1, 1024, 14, 14]         262,144
      BatchNorm2d-98         [-1, 1024, 14, 14]           2,048
             ReLU-99         [-1, 1024, 14, 14]               0
      Bottleneck-100         [-1, 1024, 14, 14]               0
          Conv2d-101          [-1, 256, 14, 14]         262,144
     BatchNorm2d-102          [-1, 256, 14, 14]             512
            ReLU-103          [-1, 256, 14, 14]               0
          Conv2d-104          [-1, 256, 14, 14]         589,824
     BatchNorm2d-105          [-1, 256, 14, 14]             512
            ReLU-106          [-1, 256, 14, 14]               0
          Conv2d-107         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-108         [-1, 1024, 14, 14]           2,048
            ReLU-109         [-1, 1024, 14, 14]               0
      Bottleneck-110         [-1, 1024, 14, 14]               0
          Conv2d-111          [-1, 256, 14, 14]         262,144
     BatchNorm2d-112          [-1, 256, 14, 14]             512
            ReLU-113          [-1, 256, 14, 14]               0
          Conv2d-114          [-1, 256, 14, 14]         589,824
     BatchNorm2d-115          [-1, 256, 14, 14]             512
            ReLU-116          [-1, 256, 14, 14]               0
          Conv2d-117         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-118         [-1, 1024, 14, 14]           2,048
            ReLU-119         [-1, 1024, 14, 14]               0
      Bottleneck-120         [-1, 1024, 14, 14]               0
          Conv2d-121          [-1, 256, 14, 14]         262,144
     BatchNorm2d-122          [-1, 256, 14, 14]             512
            ReLU-123          [-1, 256, 14, 14]               0
          Conv2d-124          [-1, 256, 14, 14]         589,824
     BatchNorm2d-125          [-1, 256, 14, 14]             512
            ReLU-126          [-1, 256, 14, 14]               0
          Conv2d-127         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-128         [-1, 1024, 14, 14]           2,048
            ReLU-129         [-1, 1024, 14, 14]               0
      Bottleneck-130         [-1, 1024, 14, 14]               0
          Conv2d-131          [-1, 256, 14, 14]         262,144
     BatchNorm2d-132          [-1, 256, 14, 14]             512
            ReLU-133          [-1, 256, 14, 14]               0
          Conv2d-134          [-1, 256, 14, 14]         589,824
     BatchNorm2d-135          [-1, 256, 14, 14]             512
            ReLU-136          [-1, 256, 14, 14]               0
          Conv2d-137         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-138         [-1, 1024, 14, 14]           2,048
            ReLU-139         [-1, 1024, 14, 14]               0
      Bottleneck-140         [-1, 1024, 14, 14]               0
          Conv2d-141          [-1, 256, 14, 14]         262,144
     BatchNorm2d-142          [-1, 256, 14, 14]             512
            ReLU-143          [-1, 256, 14, 14]               0
          Conv2d-144          [-1, 256, 14, 14]         589,824
     BatchNorm2d-145          [-1, 256, 14, 14]             512
            ReLU-146          [-1, 256, 14, 14]               0
          Conv2d-147         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-148         [-1, 1024, 14, 14]           2,048
            ReLU-149         [-1, 1024, 14, 14]               0
      Bottleneck-150         [-1, 1024, 14, 14]               0
          Conv2d-151          [-1, 256, 14, 14]         262,144
     BatchNorm2d-152          [-1, 256, 14, 14]             512
            ReLU-153          [-1, 256, 14, 14]               0
          Conv2d-154          [-1, 256, 14, 14]         589,824
     BatchNorm2d-155          [-1, 256, 14, 14]             512
            ReLU-156          [-1, 256, 14, 14]               0
          Conv2d-157         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-158         [-1, 1024, 14, 14]           2,048
            ReLU-159         [-1, 1024, 14, 14]               0
      Bottleneck-160         [-1, 1024, 14, 14]               0
          Conv2d-161          [-1, 256, 14, 14]         262,144
     BatchNorm2d-162          [-1, 256, 14, 14]             512
            ReLU-163          [-1, 256, 14, 14]               0
          Conv2d-164          [-1, 256, 14, 14]         589,824
     BatchNorm2d-165          [-1, 256, 14, 14]             512
            ReLU-166          [-1, 256, 14, 14]               0
          Conv2d-167         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-168         [-1, 1024, 14, 14]           2,048
            ReLU-169         [-1, 1024, 14, 14]               0
      Bottleneck-170         [-1, 1024, 14, 14]               0
          Conv2d-171          [-1, 256, 14, 14]         262,144
     BatchNorm2d-172          [-1, 256, 14, 14]             512
            ReLU-173          [-1, 256, 14, 14]               0
          Conv2d-174          [-1, 256, 14, 14]         589,824
     BatchNorm2d-175          [-1, 256, 14, 14]             512
            ReLU-176          [-1, 256, 14, 14]               0
          Conv2d-177         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-178         [-1, 1024, 14, 14]           2,048
            ReLU-179         [-1, 1024, 14, 14]               0
      Bottleneck-180         [-1, 1024, 14, 14]               0
          Conv2d-181          [-1, 256, 14, 14]         262,144
     BatchNorm2d-182          [-1, 256, 14, 14]             512
            ReLU-183          [-1, 256, 14, 14]               0
          Conv2d-184          [-1, 256, 14, 14]         589,824
     BatchNorm2d-185          [-1, 256, 14, 14]             512
            ReLU-186          [-1, 256, 14, 14]               0
          Conv2d-187         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-188         [-1, 1024, 14, 14]           2,048
            ReLU-189         [-1, 1024, 14, 14]               0
      Bottleneck-190         [-1, 1024, 14, 14]               0
          Conv2d-191          [-1, 256, 14, 14]         262,144
     BatchNorm2d-192          [-1, 256, 14, 14]             512
            ReLU-193          [-1, 256, 14, 14]               0
          Conv2d-194          [-1, 256, 14, 14]         589,824
     BatchNorm2d-195          [-1, 256, 14, 14]             512
            ReLU-196          [-1, 256, 14, 14]               0
          Conv2d-197         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-198         [-1, 1024, 14, 14]           2,048
            ReLU-199         [-1, 1024, 14, 14]               0
      Bottleneck-200         [-1, 1024, 14, 14]               0
          Conv2d-201          [-1, 256, 14, 14]         262,144
     BatchNorm2d-202          [-1, 256, 14, 14]             512
            ReLU-203          [-1, 256, 14, 14]               0
          Conv2d-204          [-1, 256, 14, 14]         589,824
     BatchNorm2d-205          [-1, 256, 14, 14]             512
            ReLU-206          [-1, 256, 14, 14]               0
          Conv2d-207         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-208         [-1, 1024, 14, 14]           2,048
            ReLU-209         [-1, 1024, 14, 14]               0
      Bottleneck-210         [-1, 1024, 14, 14]               0
          Conv2d-211          [-1, 256, 14, 14]         262,144
     BatchNorm2d-212          [-1, 256, 14, 14]             512
            ReLU-213          [-1, 256, 14, 14]               0
          Conv2d-214          [-1, 256, 14, 14]         589,824
     BatchNorm2d-215          [-1, 256, 14, 14]             512
            ReLU-216          [-1, 256, 14, 14]               0
          Conv2d-217         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-218         [-1, 1024, 14, 14]           2,048
            ReLU-219         [-1, 1024, 14, 14]               0
      Bottleneck-220         [-1, 1024, 14, 14]               0
          Conv2d-221          [-1, 256, 14, 14]         262,144
     BatchNorm2d-222          [-1, 256, 14, 14]             512
            ReLU-223          [-1, 256, 14, 14]               0
          Conv2d-224          [-1, 256, 14, 14]         589,824
     BatchNorm2d-225          [-1, 256, 14, 14]             512
            ReLU-226          [-1, 256, 14, 14]               0
          Conv2d-227         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-228         [-1, 1024, 14, 14]           2,048
            ReLU-229         [-1, 1024, 14, 14]               0
      Bottleneck-230         [-1, 1024, 14, 14]               0
          Conv2d-231          [-1, 256, 14, 14]         262,144
     BatchNorm2d-232          [-1, 256, 14, 14]             512
            ReLU-233          [-1, 256, 14, 14]               0
          Conv2d-234          [-1, 256, 14, 14]         589,824
     BatchNorm2d-235          [-1, 256, 14, 14]             512
            ReLU-236          [-1, 256, 14, 14]               0
          Conv2d-237         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-238         [-1, 1024, 14, 14]           2,048
            ReLU-239         [-1, 1024, 14, 14]               0
      Bottleneck-240         [-1, 1024, 14, 14]               0
          Conv2d-241          [-1, 256, 14, 14]         262,144
     BatchNorm2d-242          [-1, 256, 14, 14]             512
            ReLU-243          [-1, 256, 14, 14]               0
          Conv2d-244          [-1, 256, 14, 14]         589,824
     BatchNorm2d-245          [-1, 256, 14, 14]             512
            ReLU-246          [-1, 256, 14, 14]               0
          Conv2d-247         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-248         [-1, 1024, 14, 14]           2,048
            ReLU-249         [-1, 1024, 14, 14]               0
      Bottleneck-250         [-1, 1024, 14, 14]               0
          Conv2d-251          [-1, 256, 14, 14]         262,144
     BatchNorm2d-252          [-1, 256, 14, 14]             512
            ReLU-253          [-1, 256, 14, 14]               0
          Conv2d-254          [-1, 256, 14, 14]         589,824
     BatchNorm2d-255          [-1, 256, 14, 14]             512
            ReLU-256          [-1, 256, 14, 14]               0
          Conv2d-257         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-258         [-1, 1024, 14, 14]           2,048
            ReLU-259         [-1, 1024, 14, 14]               0
      Bottleneck-260         [-1, 1024, 14, 14]               0
          Conv2d-261          [-1, 256, 14, 14]         262,144
     BatchNorm2d-262          [-1, 256, 14, 14]             512
            ReLU-263          [-1, 256, 14, 14]               0
          Conv2d-264          [-1, 256, 14, 14]         589,824
     BatchNorm2d-265          [-1, 256, 14, 14]             512
            ReLU-266          [-1, 256, 14, 14]               0
          Conv2d-267         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-268         [-1, 1024, 14, 14]           2,048
            ReLU-269         [-1, 1024, 14, 14]               0
      Bottleneck-270         [-1, 1024, 14, 14]               0
          Conv2d-271          [-1, 256, 14, 14]         262,144
     BatchNorm2d-272          [-1, 256, 14, 14]             512
            ReLU-273          [-1, 256, 14, 14]               0
          Conv2d-274          [-1, 256, 14, 14]         589,824
     BatchNorm2d-275          [-1, 256, 14, 14]             512
            ReLU-276          [-1, 256, 14, 14]               0
          Conv2d-277         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-278         [-1, 1024, 14, 14]           2,048
            ReLU-279         [-1, 1024, 14, 14]               0
      Bottleneck-280         [-1, 1024, 14, 14]               0
          Conv2d-281          [-1, 256, 14, 14]         262,144
     BatchNorm2d-282          [-1, 256, 14, 14]             512
            ReLU-283          [-1, 256, 14, 14]               0
          Conv2d-284          [-1, 256, 14, 14]         589,824
     BatchNorm2d-285          [-1, 256, 14, 14]             512
            ReLU-286          [-1, 256, 14, 14]               0
          Conv2d-287         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-288         [-1, 1024, 14, 14]           2,048
            ReLU-289         [-1, 1024, 14, 14]               0
      Bottleneck-290         [-1, 1024, 14, 14]               0
          Conv2d-291          [-1, 256, 14, 14]         262,144
     BatchNorm2d-292          [-1, 256, 14, 14]             512
            ReLU-293          [-1, 256, 14, 14]               0
          Conv2d-294          [-1, 256, 14, 14]         589,824
     BatchNorm2d-295          [-1, 256, 14, 14]             512
            ReLU-296          [-1, 256, 14, 14]               0
          Conv2d-297         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-298         [-1, 1024, 14, 14]           2,048
            ReLU-299         [-1, 1024, 14, 14]               0
      Bottleneck-300         [-1, 1024, 14, 14]               0
          Conv2d-301          [-1, 256, 14, 14]         262,144
     BatchNorm2d-302          [-1, 256, 14, 14]             512
            ReLU-303          [-1, 256, 14, 14]               0
          Conv2d-304          [-1, 256, 14, 14]         589,824
     BatchNorm2d-305          [-1, 256, 14, 14]             512
            ReLU-306          [-1, 256, 14, 14]               0
          Conv2d-307         [-1, 1024, 14, 14]         262,144
     BatchNorm2d-308         [-1, 1024, 14, 14]           2,048
            ReLU-309         [-1, 1024, 14, 14]               0
      Bottleneck-310         [-1, 1024, 14, 14]               0
          Conv2d-311          [-1, 512, 14, 14]         524,288
     BatchNorm2d-312          [-1, 512, 14, 14]           1,024
            ReLU-313          [-1, 512, 14, 14]               0
          Conv2d-314            [-1, 512, 7, 7]       2,359,296
     BatchNorm2d-315            [-1, 512, 7, 7]           1,024
            ReLU-316            [-1, 512, 7, 7]               0
          Conv2d-317           [-1, 2048, 7, 7]       1,048,576
     BatchNorm2d-318           [-1, 2048, 7, 7]           4,096
          Conv2d-319           [-1, 2048, 7, 7]       2,097,152
     BatchNorm2d-320           [-1, 2048, 7, 7]           4,096
            ReLU-321           [-1, 2048, 7, 7]               0
      Bottleneck-322           [-1, 2048, 7, 7]               0
          Conv2d-323            [-1, 512, 7, 7]       1,048,576
     BatchNorm2d-324            [-1, 512, 7, 7]           1,024
            ReLU-325            [-1, 512, 7, 7]               0
          Conv2d-326            [-1, 512, 7, 7]       2,359,296
     BatchNorm2d-327            [-1, 512, 7, 7]           1,024
            ReLU-328            [-1, 512, 7, 7]               0
          Conv2d-329           [-1, 2048, 7, 7]       1,048,576
     BatchNorm2d-330           [-1, 2048, 7, 7]           4,096
            ReLU-331           [-1, 2048, 7, 7]               0
      Bottleneck-332           [-1, 2048, 7, 7]               0
          Conv2d-333            [-1, 512, 7, 7]       1,048,576
     BatchNorm2d-334            [-1, 512, 7, 7]           1,024
            ReLU-335            [-1, 512, 7, 7]               0
          Conv2d-336            [-1, 512, 7, 7]       2,359,296
     BatchNorm2d-337            [-1, 512, 7, 7]           1,024
            ReLU-338            [-1, 512, 7, 7]               0
          Conv2d-339           [-1, 2048, 7, 7]       1,048,576
     BatchNorm2d-340           [-1, 2048, 7, 7]           4,096
            ReLU-341           [-1, 2048, 7, 7]               0
      Bottleneck-342           [-1, 2048, 7, 7]               0
AdaptiveAvgPool2d-343           [-1, 2048, 1, 1]               0
          Linear-344                 [-1, 1000]       2,049,000
================================================================
Total params: 44,549,160
Trainable params: 44,549,160
Non-trainable params: 0
----------------------------------------------------------------
Input size (MB): 0.57
Forward/backward pass size (MB): 429.73
Params size (MB): 169.94
Estimated Total Size (MB): 600.25
----------------------------------------------------------------
```

<br>

# `torchinfo` package

Requirements[^5]:

- `torchinfo` package: install by `pip install torchinfo`.

```python
from torchvision import models
from torchvision.models import ResNet101_Weights

resnet101 = models.resnet101(weights=ResNet101_Weights.IMAGENET1K_V1)

from torchinfo import summary
summary(resnet101, (1, 3, 224, 224))
```

```
==========================================================================================
Layer (type:depth-idx)                   Output Shape              Param #
==========================================================================================
ResNet                                   [1, 1000]                 --
├─Conv2d: 1-1                            [1, 64, 112, 112]         9,408
├─BatchNorm2d: 1-2                       [1, 64, 112, 112]         128
├─ReLU: 1-3                              [1, 64, 112, 112]         --
├─MaxPool2d: 1-4                         [1, 64, 56, 56]           --
├─Sequential: 1-5                        [1, 256, 56, 56]          --
│    └─Bottleneck: 2-1                   [1, 256, 56, 56]          --
│    │    └─Conv2d: 3-1                  [1, 64, 56, 56]           4,096
│    │    └─BatchNorm2d: 3-2             [1, 64, 56, 56]           128
│    │    └─ReLU: 3-3                    [1, 64, 56, 56]           --
│    │    └─Conv2d: 3-4                  [1, 64, 56, 56]           36,864
│    │    └─BatchNorm2d: 3-5             [1, 64, 56, 56]           128
│    │    └─ReLU: 3-6                    [1, 64, 56, 56]           --
│    │    └─Conv2d: 3-7                  [1, 256, 56, 56]          16,384
│    │    └─BatchNorm2d: 3-8             [1, 256, 56, 56]          512
│    │    └─Sequential: 3-9              [1, 256, 56, 56]          16,896
│    │    └─ReLU: 3-10                   [1, 256, 56, 56]          --
│    └─Bottleneck: 2-2                   [1, 256, 56, 56]          --
│    │    └─Conv2d: 3-11                 [1, 64, 56, 56]           16,384
│    │    └─BatchNorm2d: 3-12            [1, 64, 56, 56]           128
│    │    └─ReLU: 3-13                   [1, 64, 56, 56]           --
│    │    └─Conv2d: 3-14                 [1, 64, 56, 56]           36,864
│    │    └─BatchNorm2d: 3-15            [1, 64, 56, 56]           128
│    │    └─ReLU: 3-16                   [1, 64, 56, 56]           --
│    │    └─Conv2d: 3-17                 [1, 256, 56, 56]          16,384
│    │    └─BatchNorm2d: 3-18            [1, 256, 56, 56]          512
│    │    └─ReLU: 3-19                   [1, 256, 56, 56]          --
│    └─Bottleneck: 2-3                   [1, 256, 56, 56]          --
│    │    └─Conv2d: 3-20                 [1, 64, 56, 56]           16,384
│    │    └─BatchNorm2d: 3-21            [1, 64, 56, 56]           128
│    │    └─ReLU: 3-22                   [1, 64, 56, 56]           --
│    │    └─Conv2d: 3-23                 [1, 64, 56, 56]           36,864
│    │    └─BatchNorm2d: 3-24            [1, 64, 56, 56]           128
│    │    └─ReLU: 3-25                   [1, 64, 56, 56]           --
│    │    └─Conv2d: 3-26                 [1, 256, 56, 56]          16,384
│    │    └─BatchNorm2d: 3-27            [1, 256, 56, 56]          512
│    │    └─ReLU: 3-28                   [1, 256, 56, 56]          --
├─Sequential: 1-6                        [1, 512, 28, 28]          --
│    └─Bottleneck: 2-4                   [1, 512, 28, 28]          --
│    │    └─Conv2d: 3-29                 [1, 128, 56, 56]          32,768
│    │    └─BatchNorm2d: 3-30            [1, 128, 56, 56]          256
│    │    └─ReLU: 3-31                   [1, 128, 56, 56]          --
│    │    └─Conv2d: 3-32                 [1, 128, 28, 28]          147,456
│    │    └─BatchNorm2d: 3-33            [1, 128, 28, 28]          256
│    │    └─ReLU: 3-34                   [1, 128, 28, 28]          --
│    │    └─Conv2d: 3-35                 [1, 512, 28, 28]          65,536
│    │    └─BatchNorm2d: 3-36            [1, 512, 28, 28]          1,024
│    │    └─Sequential: 3-37             [1, 512, 28, 28]          132,096
│    │    └─ReLU: 3-38                   [1, 512, 28, 28]          --
│    └─Bottleneck: 2-5                   [1, 512, 28, 28]          --
│    │    └─Conv2d: 3-39                 [1, 128, 28, 28]          65,536
│    │    └─BatchNorm2d: 3-40            [1, 128, 28, 28]          256
│    │    └─ReLU: 3-41                   [1, 128, 28, 28]          --
│    │    └─Conv2d: 3-42                 [1, 128, 28, 28]          147,456
│    │    └─BatchNorm2d: 3-43            [1, 128, 28, 28]          256
│    │    └─ReLU: 3-44                   [1, 128, 28, 28]          --
│    │    └─Conv2d: 3-45                 [1, 512, 28, 28]          65,536
│    │    └─BatchNorm2d: 3-46            [1, 512, 28, 28]          1,024
│    │    └─ReLU: 3-47                   [1, 512, 28, 28]          --
│    └─Bottleneck: 2-6                   [1, 512, 28, 28]          --
│    │    └─Conv2d: 3-48                 [1, 128, 28, 28]          65,536
│    │    └─BatchNorm2d: 3-49            [1, 128, 28, 28]          256
│    │    └─ReLU: 3-50                   [1, 128, 28, 28]          --
│    │    └─Conv2d: 3-51                 [1, 128, 28, 28]          147,456
│    │    └─BatchNorm2d: 3-52            [1, 128, 28, 28]          256
│    │    └─ReLU: 3-53                   [1, 128, 28, 28]          --
│    │    └─Conv2d: 3-54                 [1, 512, 28, 28]          65,536
│    │    └─BatchNorm2d: 3-55            [1, 512, 28, 28]          1,024
│    │    └─ReLU: 3-56                   [1, 512, 28, 28]          --
│    └─Bottleneck: 2-7                   [1, 512, 28, 28]          --
│    │    └─Conv2d: 3-57                 [1, 128, 28, 28]          65,536
│    │    └─BatchNorm2d: 3-58            [1, 128, 28, 28]          256
│    │    └─ReLU: 3-59                   [1, 128, 28, 28]          --
│    │    └─Conv2d: 3-60                 [1, 128, 28, 28]          147,456
│    │    └─BatchNorm2d: 3-61            [1, 128, 28, 28]          256
│    │    └─ReLU: 3-62                   [1, 128, 28, 28]          --
│    │    └─Conv2d: 3-63                 [1, 512, 28, 28]          65,536
│    │    └─BatchNorm2d: 3-64            [1, 512, 28, 28]          1,024
│    │    └─ReLU: 3-65                   [1, 512, 28, 28]          --
├─Sequential: 1-7                        [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-8                   [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-66                 [1, 256, 28, 28]          131,072
│    │    └─BatchNorm2d: 3-67            [1, 256, 28, 28]          512
│    │    └─ReLU: 3-68                   [1, 256, 28, 28]          --
│    │    └─Conv2d: 3-69                 [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-70            [1, 256, 14, 14]          512
│    │    └─ReLU: 3-71                   [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-72                 [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-73            [1, 1024, 14, 14]         2,048
│    │    └─Sequential: 3-74             [1, 1024, 14, 14]         526,336
│    │    └─ReLU: 3-75                   [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-9                   [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-76                 [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-77            [1, 256, 14, 14]          512
│    │    └─ReLU: 3-78                   [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-79                 [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-80            [1, 256, 14, 14]          512
│    │    └─ReLU: 3-81                   [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-82                 [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-83            [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-84                   [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-10                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-85                 [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-86            [1, 256, 14, 14]          512
│    │    └─ReLU: 3-87                   [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-88                 [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-89            [1, 256, 14, 14]          512
│    │    └─ReLU: 3-90                   [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-91                 [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-92            [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-93                   [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-11                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-94                 [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-95            [1, 256, 14, 14]          512
│    │    └─ReLU: 3-96                   [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-97                 [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-98            [1, 256, 14, 14]          512
│    │    └─ReLU: 3-99                   [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-100                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-101           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-102                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-12                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-103                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-104           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-105                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-106                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-107           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-108                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-109                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-110           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-111                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-13                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-112                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-113           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-114                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-115                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-116           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-117                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-118                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-119           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-120                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-14                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-121                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-122           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-123                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-124                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-125           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-126                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-127                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-128           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-129                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-15                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-130                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-131           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-132                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-133                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-134           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-135                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-136                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-137           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-138                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-16                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-139                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-140           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-141                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-142                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-143           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-144                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-145                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-146           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-147                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-17                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-148                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-149           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-150                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-151                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-152           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-153                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-154                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-155           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-156                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-18                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-157                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-158           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-159                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-160                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-161           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-162                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-163                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-164           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-165                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-19                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-166                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-167           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-168                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-169                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-170           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-171                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-172                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-173           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-174                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-20                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-175                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-176           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-177                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-178                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-179           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-180                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-181                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-182           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-183                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-21                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-184                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-185           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-186                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-187                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-188           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-189                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-190                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-191           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-192                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-22                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-193                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-194           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-195                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-196                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-197           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-198                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-199                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-200           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-201                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-23                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-202                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-203           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-204                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-205                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-206           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-207                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-208                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-209           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-210                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-24                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-211                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-212           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-213                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-214                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-215           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-216                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-217                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-218           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-219                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-25                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-220                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-221           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-222                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-223                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-224           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-225                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-226                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-227           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-228                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-26                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-229                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-230           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-231                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-232                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-233           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-234                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-235                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-236           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-237                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-27                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-238                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-239           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-240                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-241                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-242           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-243                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-244                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-245           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-246                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-28                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-247                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-248           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-249                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-250                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-251           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-252                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-253                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-254           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-255                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-29                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-256                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-257           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-258                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-259                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-260           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-261                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-262                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-263           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-264                  [1, 1024, 14, 14]         --
│    └─Bottleneck: 2-30                  [1, 1024, 14, 14]         --
│    │    └─Conv2d: 3-265                [1, 256, 14, 14]          262,144
│    │    └─BatchNorm2d: 3-266           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-267                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-268                [1, 256, 14, 14]          589,824
│    │    └─BatchNorm2d: 3-269           [1, 256, 14, 14]          512
│    │    └─ReLU: 3-270                  [1, 256, 14, 14]          --
│    │    └─Conv2d: 3-271                [1, 1024, 14, 14]         262,144
│    │    └─BatchNorm2d: 3-272           [1, 1024, 14, 14]         2,048
│    │    └─ReLU: 3-273                  [1, 1024, 14, 14]         --
├─Sequential: 1-8                        [1, 2048, 7, 7]           --
│    └─Bottleneck: 2-31                  [1, 2048, 7, 7]           --
│    │    └─Conv2d: 3-274                [1, 512, 14, 14]          524,288
│    │    └─BatchNorm2d: 3-275           [1, 512, 14, 14]          1,024
│    │    └─ReLU: 3-276                  [1, 512, 14, 14]          --
│    │    └─Conv2d: 3-277                [1, 512, 7, 7]            2,359,296
│    │    └─BatchNorm2d: 3-278           [1, 512, 7, 7]            1,024
│    │    └─ReLU: 3-279                  [1, 512, 7, 7]            --
│    │    └─Conv2d: 3-280                [1, 2048, 7, 7]           1,048,576
│    │    └─BatchNorm2d: 3-281           [1, 2048, 7, 7]           4,096
│    │    └─Sequential: 3-282            [1, 2048, 7, 7]           2,101,248
│    │    └─ReLU: 3-283                  [1, 2048, 7, 7]           --
│    └─Bottleneck: 2-32                  [1, 2048, 7, 7]           --
│    │    └─Conv2d: 3-284                [1, 512, 7, 7]            1,048,576
│    │    └─BatchNorm2d: 3-285           [1, 512, 7, 7]            1,024
│    │    └─ReLU: 3-286                  [1, 512, 7, 7]            --
│    │    └─Conv2d: 3-287                [1, 512, 7, 7]            2,359,296
│    │    └─BatchNorm2d: 3-288           [1, 512, 7, 7]            1,024
│    │    └─ReLU: 3-289                  [1, 512, 7, 7]            --
│    │    └─Conv2d: 3-290                [1, 2048, 7, 7]           1,048,576
│    │    └─BatchNorm2d: 3-291           [1, 2048, 7, 7]           4,096
│    │    └─ReLU: 3-292                  [1, 2048, 7, 7]           --
│    └─Bottleneck: 2-33                  [1, 2048, 7, 7]           --
│    │    └─Conv2d: 3-293                [1, 512, 7, 7]            1,048,576
│    │    └─BatchNorm2d: 3-294           [1, 512, 7, 7]            1,024
│    │    └─ReLU: 3-295                  [1, 512, 7, 7]            --
│    │    └─Conv2d: 3-296                [1, 512, 7, 7]            2,359,296
│    │    └─BatchNorm2d: 3-297           [1, 512, 7, 7]            1,024
│    │    └─ReLU: 3-298                  [1, 512, 7, 7]            --
│    │    └─Conv2d: 3-299                [1, 2048, 7, 7]           1,048,576
│    │    └─BatchNorm2d: 3-300           [1, 2048, 7, 7]           4,096
│    │    └─ReLU: 3-301                  [1, 2048, 7, 7]           --
├─AdaptiveAvgPool2d: 1-9                 [1, 2048, 1, 1]           --
├─Linear: 1-10                           [1, 1000]                 2,049,000
==========================================================================================
Total params: 44,549,160
Trainable params: 44,549,160
Non-trainable params: 0
Total mult-adds (Units.GIGABYTES): 7.80
==========================================================================================
Input size (MB): 0.60
Forward/backward pass size (MB): 259.72
Params size (MB): 178.20
Estimated Total Size (MB): 438.52
==========================================================================================
```

<br>

# `netron` package

Requirements[^7][^8]:

- `onnx` package: `pip install onnx`.
- `netron` package: `pip install netron`.

```python
import torch
from torchvision import models
from torchvision.models import ResNet101_Weights

resnet101 = models.resnet101(weights=ResNet101_Weights.IMAGENET1K_V1)

x = torch.randn(1, 3, 224, 224) 
modelFile = "./resnet101.pth"

import torch.onnx
torch.onnx.export(resnet101, x, modelFile)

import netron
netron.start(modelFile)
```

```
Serving './resnet101.pth' at http://localhost:8080
('localhost', 8080)
```

Code `torch.onnx.export(resnet101, x, modelFile)` will output a `.pth` file `resnet101.pth` (178 MB) in the folder. And we can see a neural network structure graph at `http://localhost:8080`, and save it as an SVG file `_resnet101.pth.svg` showing as follows.

![_resnet101.pth](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407241324309.svg)

<br>

# `tensorboardX` package

Requirements[^9][^10]:

- `tensorboardX` package: install by `pip install tensorboardX`.
- `tensorboard` package: install by `pip install tensorboard`.

```python
import torch
from torchvision import models
from torchvision.models import ResNet101_Weights

resnet101 = models.resnet101(weights=ResNet101_Weights.IMAGENET1K_V1)
x = torch.randn(1, 3, 224, 224)

from tensorboardX import SummaryWriter
with SummaryWriter(log_dir='') as sw:
    sw.add_graph(resnet101, (x,))
    sw.close()
```

After running above script, a sub-folder `runs` appears in the folder. Then, use command `tensorboard --logdir` to read log data from `runs` folder:

```powershell
tensorboard --logdir 'G:\...\...\Deep Learning with PyTorch\runs'
```

```
TensorFlow installation not found - running with reduced feature set.
Serving TensorBoard on localhost; to expose to the network, use a proxy or pass --bind_all
TensorBoard 2.17.0 at http://localhost:6006/ (Press CTRL+C to quit)
```

At this time, we can open `http://localhost:6006/` to inspect ResNet-101 structure.

![image-20240724150404662](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407241504870.png)

and similarly, save the graph as a PNG file:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407241503648.png" alt="Jul24_14-54-58_DESKTOP-5H3A2GV (1)" style="zoom:67%;" />

<br>

**References**

[^1]: [Available Pre-trained Deep Learning Models in torchvision.models Subpackage - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-24/11-17-37.html).
[^2]: [超实用的7种 pytorch 网络可视化方法，进来收藏一波\_torch模型可视化-CSDN博客](https://blog.csdn.net/Wenyuanbo/article/details/118937790).
[^3]: [第七章：PyTorch可视化 — 深入浅出PyTorch](https://datawhalechina.github.io/thorough-pytorch/%E7%AC%AC%E4%B8%83%E7%AB%A0/index.html).
[^4]: [pytorch 网络可视化(一)：torchsummary-CSDN博客](https://blog.csdn.net/Wenyuanbo/article/details/118514709).
[^5]: [7.1 可视化网络结构 — 深入浅出PyTorch](https://datawhalechina.github.io/thorough-pytorch/%E7%AC%AC%E4%B8%83%E7%AB%A0/7.1%20%E5%8F%AF%E8%A7%86%E5%8C%96%E7%BD%91%E7%BB%9C%E7%BB%93%E6%9E%84.html#torchinfo).
[^6]: [https://github.com/sksq96/pytorch-summary/issues/57#issuecomment-597998375](https://github.com/sksq96/pytorch-summary/issues/57#issuecomment-597998375).
[^7]: [pytorch 网络可视化(五)：netron\_netron不显示输出-CSDN博客](https://blog.csdn.net/Wenyuanbo/article/details/118736258).
[^8]: [lutzroeder/netron: Visualizer for neural network, deep learning and machine learning models](https://github.com/lutzroeder/netron).
[^9]: [pytorch 网络可视化(四)：tensorboardX\_tensorboardx 2.0 兼容的 tensorboard-CSDN博客](https://blog.csdn.net/Wenyuanbo/article/details/118605418).
[^10]: [7.3 使用TensorBoard可视化训练过程 — 深入浅出PyTorch](https://datawhalechina.github.io/thorough-pytorch/%E7%AC%AC%E4%B8%83%E7%AB%A0/7.3%20%E4%BD%BF%E7%94%A8TensorBoard%E5%8F%AF%E8%A7%86%E5%8C%96%E8%AE%AD%E7%BB%83%E8%BF%87%E7%A8%8B.html).
