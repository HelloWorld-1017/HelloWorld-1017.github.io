---
layout: single
title: Array Size of MATLAB `dlarray`
categories:
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
toc: false
drafted_at: 2021-03-16 07:23:14 +0800
date: 2024-03-25 19:29:31 +0800
last_modified_at0: 2024-03-25 19:29:31 +0800
last_modified_at: 2024-03-25 19:29:31 +0800
---

While conducting deep learning in MATLAB, `dlarray` function[^1] is to convert the array type dataset to `dlarray` that available for custom training loop, and meanwhile, we could specify the data format by it. However, there is a small detail that should be noted, `dlarray` function will automatically ***permute*** the high-dimensional array when we specify the data format and the last dimension label is not `"B"` (denoting "batch" or rather "batch size"), to make the converted `dlarray`-type array the last dimension always `"B"`. For example, the following two script show the difference of array size of specifying data format as `"CB"` and `"BC"` for two-dimensional array:

```matlab
clc,clear,close all
rng("default")

a = randn(3,10);
fprintf("size(a): %d %d\n",size(a))

a1 = dlarray(a); % Without specifying data format
fprintf("size(a1): %d %d, Dimension labels: %s\n",size(a1),dims(a1))

a2 = dlarray(a,"CB");
fprintf("size(a2): %d %d, Dimension labels: %s\n",size(a2),dims(a2))

a3 = dlarray(a,"BC");
fprintf("size(a3): %d %d, Dimension labels: %s\n",size(a3),dims(a3))
```

```
size(a): 3 10
size(a1): 3 10, Dimension labels: 
size(a2): 3 10, Dimension labels: CB
size(a3): 10 3, Dimension labels: CB
```

`dims` function[^2] is to display the dimension labels of the input `dlarray`.
{: .notice--primary}

and that of specifying data format as `"SSCB"` and `"SSBC"` for four-dimensional array:

```matlab
clc,clear,close all
rng("default")

b = rand(3,3,10,7);
fprintf("size(b): %d %d %d %d\n",size(b))

b1 = dlarray(b); % Without specifying data format
fprintf("size(b1): %d %d %d %d, Dimension labels: %s\n",size(b1),dims(b1))

b2 = dlarray(b,"SSCB");
fprintf("size(b2): %d %d %d %d, Dimension labels: %s\n",size(b2),dims(b2))

b3 = dlarray(b,"SSBC");
fprintf("size(b3): %d %d %d %d, Dimension labels: %s\n",size(b3),dims(b3))
```

```
size(b): 3 3 10 7
size(b1): 3 3 10 7, Dimension labels: 
size(b2): 3 3 10 7, Dimension labels: SSCB
size(b3): 3 3 7 10, Dimension labels: SSCB
```

<br>

**References**

[^1]: [MATLAB `dlarray`: Deep learning array for customization - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/dlarray.html).
[^2]: [MATLAB `dims`: Dimension labels of dlarray - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/dlarray.dims.html).
