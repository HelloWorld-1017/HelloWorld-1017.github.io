---
title: "PyTorch Tensor's `requires_grad` Attribute, `detach` and `detach_` Method"
categories:
 - Python
 - Machine Learning
tags:
 - Python PyTorch
date: 2024-07-18 12:21:50 +0800
last_modified_at: 2024-07-18 18:16:44 +0800
---

# `requires_grad` attribute

Let $y(x)=x^2+3x+2$, what is the result of $\dfrac{\mathrm{d}y}{\mathrm{d}x}\Big\vert_{x=3}$? We can calculate it with the help of PyTorch automatic differentiation:

<div id="script-1"></div>

```python
import torch

x = torch.tensor(3.0,requires_grad=True)
y = x**2+3*x+2 # y = x^2+3x+2

print("y:", y)

# dy/dx
y.backward()

print("x.grad:", x.grad)
```

```
y: tensor(20., grad_fn=<AddBackward0>)
x.grad: tensor(9.)
```

After `y.backward`, the value of $\mathrm{d}y/\mathrm{d}x$ is stored in `grad` attribute of `x` variable.[^5]
{: .notice--primary}

It should be noted that, in above process, `requires_grad` attribute must be set to `True` when creating variable `x` by `torch.tensor` function. As `requires_grad` entry in PyTorch documentation:

<div class="quote--left" markdown="1">

**`torch.Tensor.requires_grad`**[^1]

Is `True` if gradients need to be computed for this Tensor, `False` otherwise.

</div>

Actually, a tensor’s attribute `requires_grad` is `False` by default when the tensor is created by `torch.tensor`. Still take above case, if we don’t specify `requires_grad` as `True`, an error will occur:

<div id="script-2"></div>

```python
import torch

x = torch.tensor(3.0) # with default `requires_grad` value
y = x**2+3*x+2 # y = x^2+3x+2

print("y:", y)

# dy/dx
y.backward()

print("x.grad:", x.grad)
```

```
Cell In[5], line 9
      6 print("y:", y)
      8 # dy/dx
----> 9 y.backward()
     11 print("x.grad:", x.grad)

...
...

RuntimeError: element 0 of tensors does not require grad and does not have a grad_fn
```

So, it is necessary to set `requires_grad=True` at this case to guarantee that gradient computation, i.e. `y.backward()`[^2], can be successfully made.

<br>

# `detach` and `detach_` method

In fact, we can check the difference of `requires_grad` attribute of `x` variable in [Script 1](#script-1) and [Script 2](#script-2) by directly printing variable:

```python
x = torch.tensor(3.0)
print(x)

x = torch.tensor(3.0,requires_grad=True)
print(x)
```

```
tensor(3.)
tensor(3., requires_grad=True)
```

On the other hand, if a variable’s `requires_grad` is `True`, then other variables computed based on this variable will have a `grad_fn` attribute, and `grad_fn` attribute relates to specific arithmetic operation. For example:

```python
# Case 1
x = torch.tensor(3.0,requires_grad=True)
y = x**2+3*x+2
z = (y+1)/2-0.5
print(y)
print(z)

# Case 2
x = torch.tensor(3.0)
y = x**2+3*x+2
z = (y+1)/2-0.5
print(y)
print(z)
```

```
tensor(20., grad_fn=<AddBackward0>)
tensor(10., grad_fn=<SubBackward0>)
tensor(20.)
tensor(10.)
```

Actually, for computation process at Case 1, we should realize that a PyTorch computational graph is constructed[^6], and automatic differentiation relies on the computational graph. And, it can be imagined that constructing computational graph and making it get involved in subsequent computations will increase time and space complexity. This is why I think `requires_grad` is `False` by default.

On the other hand, many built-in PyTorch functions, or operations, would construct computational graph automatically. If we don’t plan using computational graph, we can detach a tensor from the graph through method `detach` or `detach_`:

<div class="quote--left" markdown="1">
**`torch.Tensor.detach`**[^3]

Returns a new Tensor, detached from the current graph.

The result will never require gradient.

This method also affects forward mode AD gradients and the result will never have forward mode AD gradients.

<br>

**`torch.Tensor.detach_`**[^4]

Detaches the Tensor from the graph that created it, making it a leaf. Views cannot be detached in-place.

This method also affects forward mode AD gradients and the result will never have forward mode AD gradients.

</div>

As can be seen, `detach` and `detach_` have similar functions, and the difference between them is that `detach` will new a same tensor and detach this copy from the computational graph, but the original tensor is still in the graph; while `detach_` will detach the original tensor per se from the graph. For example:

**(1) `detach` method**

```python
import torch

x = torch.tensor(3.0,requires_grad=True)
print('x: ', x)

y = x**2+3*x+2
print('y (before detach): ', y)

z = y.detach()
print('y (after detach): ', y)
print('z: ', z)

y.backward()
print('x.grad:', x.grad)

z.backward()
```

```
x:  tensor(3., requires_grad=True)
y (before detach):  tensor(20., grad_fn=<AddBackward0>)
y (after detach):  tensor(20., grad_fn=<AddBackward0>)
z:  tensor(20.)
x.grad: tensor(9.)
---------------------------------------------------------------------------
RuntimeError                              Traceback (most recent call last)
Cell In[34], line 16
     13 y.backward()
     14 print('x.grad:', x.grad)
---> 16 z.backward()

...
...

RuntimeError: element 0 of tensors does not require grad and does not have a grad_fn
```

`detach` method doesn’t detach `y` from the graph, and hence `y.backward()` is still available, but `z.backward()` is not available, where `z` is the new tensor when executing `y.detach()`.

**(2) `detach_` method**

```python
import torch

x = torch.tensor(3.0,requires_grad=True)
print('x: ', x)

y = x**2+3*x+2
print('y (before detach_): ', y)

z = y.detach_()
print('y (after detach_): ', y)
print('z: ', z)

y.backward()
```

```
x:  tensor(3., requires_grad=True)
y (before detach_):  tensor(20., grad_fn=<AddBackward0>)
y (after detach_):  tensor(20.)
z:  tensor(20.)
---------------------------------------------------------------------------
RuntimeError                              Traceback (most recent call last)
Cell In[37], line 13
     10 print('y (after detach_): ', y)
     11 print('z: ', z)
---> 13 y.backward()

...
...

RuntimeError: element 0 of tensors does not require grad and does not have a grad_fn
```

`detach_` method detaches `y` from the graph, hence `y.backward()` not available.

<br>

**References**

[^1]: [`torch.Tensor.requires_grad` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.Tensor.requires_grad.html).
[^2]: [`torch.Tensor.backward` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.Tensor.backward.html).
[^3]: [`torch.Tensor.detach` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.Tensor.detach.html).
[^4]: [`torch.Tensor.detach_` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.Tensor.detach_.html).
[^5]: [`torch.Tensor.grad` — PyTorch 2.3 documentation](https://pytorch.org/docs/stable/generated/torch.Tensor.grad.html).
[^6]: [Simple Gradient Descend (GD) and Stochastic Gradient Descend (SGD) Methods Selecting Optimum Weight of Linear Model - WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/2023-04-04/10-04-03.html).
