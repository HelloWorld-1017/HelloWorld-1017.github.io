---
title: PyTorch `torch.dot` Function
toc: false
categories:
 - Python
tags:
 - Python PyTorch
 - PyTorch Warnings and Errors
date: 2024-07-19 15:35:00 +0800
last_modified_at: 2024-07-19 15:35:00 +0800
---

As PyTorch documentation puts it, `torch.dot` function is to compute dot product of two 1D tensors[^1]:

<div class="quote--left" markdown="1">


`torch.dot`:

Computes the dot product of two 1D tensors.

NOTE: Unlike NumPy’s dot, torch.dot intentionally only supports computing the dot product of two 1D tensors with the same number of elements.

**Parameters**

- **input** (*Tensor*) – first tensor in the dot product, must be 1D.
- **other** (*Tensor*) – second tensor in the dot product, must be 1D.

**Keyword Arguments**

**out** ([*Tensor*, *optional*) – the output tensor.

</div>

We can see that `torch.dot` function is only available for 1D tensor:

```python
import torch

a, b = torch.tensor([1, 2]), torch.tensor([3, 4])
c = torch.dot(a, b)
print(a, b, c)
```

```
tensor([1, 2]) tensor([3, 4]) tensor(11)
```

but not for column vector (2D tensor):

```python
a, b = torch.tensor([[1], [2]]), torch.tensor([[3], [4]])
c = torch.dot(a, b)
print(a, b, c)
```

```
---------------------------------------------------------------------------
RuntimeError                              Traceback (most recent call last)
Cell In[2], line 2
      1 a, b = torch.tensor([[1], [2]]), torch.tensor([[3], [4]])
----> 2 c = torch.dot(a, b)
      3 print(a, b, c)

RuntimeError: 1D tensors expected, but got 2D and 2D tensors
```

or row vector (2D tensor):

```python
a, b = torch.tensor([[1, 2]]), torch.tensor([[3, 4]])
c = torch.dot(a, b)
print(a, b, c)
```

```
---------------------------------------------------------------------------
RuntimeError                              Traceback (most recent call last)
Cell In[3], line 2
      1 a, b = torch.tensor([[1, 2]]), torch.tensor([[3, 4]])
----> 2 c = torch.dot(a, b)
      3 print(a, b, c)

RuntimeError: 1D tensors expected, but got 2D and 2D tensors
```

The differences between 1D and 2D tensors should be noted[^2].

To put it bluntly, kind of weird 😂

<br>

**References**

[^1]: [`torch.dot` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.dot.html).
[^2]: [1D Array vs. Row Vector and Column Vector in Python - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2024-07-19/10-26-37.html).
