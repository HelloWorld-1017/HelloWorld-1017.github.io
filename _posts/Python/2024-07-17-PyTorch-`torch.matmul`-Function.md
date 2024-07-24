---
title: PyTorch `torch.matmul` (Matrix Multiplication) Function
toc: false
categories:
 - Python
 - Machine Learning
tags:
 - Python PyTorch
 - PyTorch Warnings and Errors
date: 2024-07-17 16:48:12 +0800
last_modified_at: 2024-07-17 16:48:12 +0800
---

PyTorch `torch.matmul` function[^1] is to conduct “Matrix product of two tensors.” Considering two tensors `a` and `b`, we can use `a.matmul(b)` or `torch.matmul(a,b)` to calculate their matrix product if their dimensions match. For example:

```python
import torch

a = torch.arange(1,13).reshape(4,3) # 4-by-3
b = torch.arange(1,4) # 1-by-3
c = a.matmul(b)
d = torch.matmul(a,b)

print(a)
print(b)
print(c)
print(d)
print(a.shape)
print(b.shape)
print(c.shape)
print(d.shape)
```

```
tensor([[ 1,  2,  3],
        [ 4,  5,  6],
        [ 7,  8,  9],
        [10, 11, 12]])
tensor([1, 2, 3])
tensor([14, 32, 50, 68])
tensor([14, 32, 50, 68])
torch.Size([4, 3])
torch.Size([3])
torch.Size([4])
torch.Size([4])
```

However, if we exchange the position of `a` and `b`, an error will occur:

```python
b.matmul(a)
```

```
----> 1 b.matmul(a)

RuntimeError: mat1 and mat2 shapes cannot be multiplied (1x3 and 4x3)
```

```python
torch.matmul(b,a)
```

```
----> 1 torch.matmul(b,a)

RuntimeError: mat1 and mat2 shapes cannot be multiplied (1x3 and 4x3)
```

<br>

**References**

[^1]: [`torch.matmul` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.matmul.html).