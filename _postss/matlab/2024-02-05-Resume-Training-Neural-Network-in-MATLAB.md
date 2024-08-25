---
layout: single
title: Resume Training Neural Network in MATLAB
categories:
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Deep Learning Toolbox
 - Computer Vision
date: 2024-02-05 17:29:07 +0800
last_modified_at0: 2024-02-05 17:29:07 +0800
last_modified_at1: 2024-02-10 19:18:13 +0800
last_modified_at2: 2024-04-22 20:50:55 +0800
last_modified_at: 2024-04-22 20:50:55 +0800
---

# Introduction

It always takes a long time to train a "large" deep learning neural network, and in which case specifying checkpoints in the training progress is practical. This method avoids re-training network from scratch if the training progress is interrupted unexpectedly, although it will occupy extra storage space.

MATLAB official example "Resume Training from Checkpoint Network" [^1] shows how to set checkpoints and continue training from a specified checkpoint network in the classic MNIST multi-class classification task. Some details of this example would be discussed in this post.

<br>

# Setting checkpoints while training

In the official example [^1], the complete code of training multi-class classification CNN shows as follows:

<div id="script-1"></div>

```matlab
clc,clear,close all

rng("default")

% Prepare training dataset
[XTrain,YTrain] = digitTrain4DArrayData;

% Define newtwork architecture
layers = [
    imageInputLayer([28 28 1])
    
    convolution2dLayer(3,8,"Padding","same")
    batchNormalizationLayer
    reluLayer    
    maxPooling2dLayer(2,"Stride",2) 
    
    convolution2dLayer(3,16,"Padding","same")
    batchNormalizationLayer
    reluLayer    
    maxPooling2dLayer(2,"Stride",2)
    
    convolution2dLayer(3,32,"Padding","same")
    batchNormalizationLayer
    reluLayer   
    averagePooling2dLayer(7)  
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

% Specify Training Options
options = trainingOptions("sgdm", ...
    "InitialLearnRate",0.1, ...
    "MaxEpochs",20, ...
    "Verbose",false, ...
    "Plots","training-progress", ...
    "Shuffle","every-epoch", ...
    "CheckpointPath",pwd);

% Train the network
net1 = trainNetwork(XTrain,YTrain,layers,options);
```

Among which, setting checkpoints is just realized by specifying a file path to `"CheckpointPath"` property of `trainingOptions` function [^2]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402052127795.png" alt="image-20240205212752721" style="zoom: 67%;" />

```matlab
% Specify Training Options
options = trainingOptions("sgdm", ...
    "InitialLearnRate",0.1, ...
    "MaxEpochs",20, ...
    "Verbose",false, ...
    "Plots","training-progress", ...
    "Shuffle","every-epoch", ...
    "CheckpointPath",pwd);
```

The training progress of running [Script 1](#script-1) shows as follows:

<div id="fig-1"></div>

![image-20240205200322596](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402052003759.png)

After running, there are some `.mat` files in the current folder, and each `.mat` file contains and only contains a neural network variable `net`:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402052004328.png" alt="image-20240205200426267" style="zoom: 67%;" />

Specifically, the file name of each `.mat` file is like:

```
net_checkpoint__<iterations>__<year>_<month>_<date>__<hour>_<minute>_<second>.mat
```

As showed in at the right side of [Fig. 1](#fig-1), there totally are 20 epochs in the entire training progress, and each epoch contains 39 iterations. Correspondingly, there are 20 `.mat` files in the current folder, and the first figure in file name, i.e., 39, 78, 117 or et al., is the iteration number, showing how many iterations the stored network has been trained. 

Or rather, under the default settings, "`trainNetwork` **saves one checkpoint network each epoch** and automatically assigns unique names to the checkpoint files." [^1] If we want to change this point, we could specify two other properties of `trainingOptions` function [^2], i.e., `"CheckpointFrequency"`:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402052256277.png" alt="image-20240205225607185" style="zoom:67%;" />

and `"CheckpointFrequencyUnit"`:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402052256604.png" alt="image-20240205225640531" style="zoom:67%;" />

<br>

# Resume training from checkpoint network

If we want to resume training from the last checkpoint network, we could use the following script to realize it:

<div id="script-2"></div>

```matlab
clc,clear,close all

rng("default")

% Load checkpoint network
load net_checkpoint__780__2024_02_05__20_02_53.mat

% Prepare training dataset
[XTrain,YTrain] = digitTrain4DArrayData;

% Sepcify training options
options = trainingOptions("sgdm", ...
    "InitialLearnRate",0.05, ...
    "MaxEpochs",15, ...
    "Verbose",false, ...
    "Plots","training-progress", ...
    "Shuffle","every-epoch", ...
    "CheckpointPath",pwd);

% Resume training
net2 = trainNetwork(XTrain,YTrain,net.Layers,options);
```

![image-20240205215027916](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402052150113.png)

And of course, the property specifications of `trainingOptions` in the both training progress ([Script 1](#script-1) and [Script 2](#script-2)) don't need to be the same (such as `"InitialLearnRate"` and `"MaxEpochs"`).

In addition, there is a small detail that needs to be noted, that is the iteration number of the file name will be re-counted in the second training progress:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402052203995.png" alt="image-20240205220333904" style="zoom: 67%;" />

<br>

**References**

[^1]: [Resume Training from Checkpoint Network - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/resume-training-from-a-checkpoint-network.html).
[^2]: [MATLAB `trainingOptions`: Options for training deep learning neural network - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ref/trainingoptions.html).