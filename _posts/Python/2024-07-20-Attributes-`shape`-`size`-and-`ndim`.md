---
title: "Numpy Array and PyTorch Tensor's Attributes: `shape`, `size`, and `ndim` "
categories:
 - Python
tags:
 - Python NumPy
 - Python PyTorch
date: 2024-07-20 17:30:00 +0800
last_modified_at: 2024-07-20 17:30:00 +0800
---

# NumPy array

<div class="quote--left" markdown="1">
<br>
`numpy.shape(a)`[^1]: Return the shape of an array.

- Parameters:
  - `a`: *array\_like*. Input array.
- Returns:
  - `shape`: *tuple of ints*. The elements of the shape tuple give the lengths of the corresponding array dimensions.

<br>

`ndarray.size`[^2]: Number of elements in the array. Equal to `np.prod(a.shape)`, i.e., the product of the array’s dimensions.

<br>

`ndarray.ndim`[^5]: Number of array dimensions.

</div>

**Examples**

```python
import numpy as np

a = np.array([[1,2,3,4], [5,6,7,8]])
print(a)
print(a.shape, np.shape(a))
print(a.size, np.size(a))
print(a.ndim, np.ndim(a))
```

```
[[1 2 3 4]
 [5 6 7 8]]
(2, 4) (2, 4)
8 8
2 2
```

<br>

# PyTorch tensor

<div class="quote--left" markdown="1">
<br>

`torch.Tensor.shape`[^3]: Returns the size of the `self` tensor. Alias for `size`.

<br>

`torch.Tensor.size`[^4] (Tensor.size(*dim=None*) → torch.Size or int): Returns the size of the `self` tensor. If `dim` is not specified, the returned value is a `torch.Size`, a subclass of [`tuple`](https://docs.python.org/3/library/stdtypes.html#tuple). If `dim` is specified, returns an int holding the size of that dimension.

Parameters

- **dim** ([*int*](https://docs.python.org/3/library/functions.html#int)*,* *optional*) – The dimension for which to retrieve the size.

<br>

`torch.Tensor.ndim`[^6]: Alias for [`dim()`](https://pytorch.org/docs/stable/generated/torch.Tensor.dim.html#torch.Tensor.dim).

<br>

`torch.Tensor.dim`[^7]: Returns the number of dimensions of `self` tensor.

</div>

**Examples**

```python
import torch

a = torch.tensor([[1,2,3,4], [5,6,7,8]])
print(a, a.shape)
print(a.size(), a.size(dim=0), a.size(dim=1))
print(a.ndim, a.dim())
```

```
tensor([[1, 2, 3, 4],
        [5, 6, 7, 8]]) torch.Size([2, 4])
torch.Size([2, 4]) 2 4
2 2
```

<br>

**References**

[^1]: [`numpy.shape` — NumPy v1.26 Manual](https://numpy.org/doc/1.26/reference/generated/numpy.shape.html).
[^2]: [`numpy.ndarray.size` — NumPy v1.26 Manual](https://numpy.org/doc/1.26/reference/generated/numpy.ndarray.size.html#numpy.ndarray.size).
[^3]: [`torch.Tensor.size` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.Tensor.size.html).
[^4]: [`torch.Tensor.shape` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.Tensor.shape.html).
[^5]: [`numpy.ndarray.ndim` — NumPy v1.26 Manual](https://numpy.org/doc/1.26/reference/generated/numpy.ndarray.ndim.html#numpy.ndarray.ndim).
[^6]: [`torch.Tensor.ndim` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.Tensor.ndim.html#torch.Tensor.ndim).
[^7]: [`torch.Tensor.dim` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.Tensor.dim.html#torch.Tensor.dim).
