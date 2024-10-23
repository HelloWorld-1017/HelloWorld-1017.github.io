---
title: MATLAB error, Deep Learning Toolbox, Invalid input data. Invalid number of spatial dimensions. Layer expects 0 but received 1.
toc: false
categories: 
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
 - MATLAB Warnings and Errors
date: 2022-06-08 17:08:09 +0800
last_modified_at: 2024-10-23 20:11:06 +0800
---

> **报错记录**
>
> 工具箱：MATLAB Deep Learning Toolbox
>
> 报错: Invalid input data. Invalid number of spatial dimensions. Layer expects 0 but received 1.


在使用MATLAB Deep Learning Toolbox在构建神经网络时，想要使用featureInputLayer函数构建神经网络的特征输入层，用于接收数值特征，但是在进行custom training loop过程中使用forward函数时报错。

精简后的测试代码：

```matlab
clc, clear

% define network
net = featureInputLayer(4, 'Name', 'inputLayer');
% convert layer graph to dlnetwork object
net = dlnetwork(net);

% specify formatted batch input
input = randn(4, 16);% 4, the number of the features; 16, batch size;
input = dlarray(input, 'SB');

% forward
result = forward(net, input);
```
完整报错信息：

```
Error using dlnetwork/validateForwardInputs
Layer 'inputLayer': Invalid input data. Invalid number of spatial dimensions. Layer expects 0 but received 1.

Error in dlnetwork/forward (line 555)
            [x, doForwardExampleInputs] = validateForwardInputs(net, x, "forward");

Error in test2 (line 13)
result = forward(net, input);
```
报错原因：

dlarray函数使用错误。根据MATLAB `dlarray`函数官方文档 [[1]](#ref)，当神经网络的输入为特征向量时，数值要转换为"CB"格式的dlarray，而不是"SB"格式(我想当然认为是“Spatial-Batch"格式)。

![image-20220710122651510](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220710122651510.png?raw=true)

因此，只需要将原代码的第10行改写如下代码即可。

```matlab
input = dlarray(input, 'CB');
```

<br>

<div id="ref"></div>

**References**

[1] [`dlarray`: Deep learning array for customization - What a starry night~](https://ww2.mathworks.cn/help/deeplearning/ref/dlarray.html).