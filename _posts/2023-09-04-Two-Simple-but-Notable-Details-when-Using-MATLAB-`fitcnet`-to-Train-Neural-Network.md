---
layout: single
title: Two Simple-but-Notable Details when Using MATLAB `fitcnet` to Train Neural Network
date: 2023-09-04 09:31:03 +0800
categories:
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Statistics and Machine Learning Toolbox
---



# Introduction on `fitcnet` function

In MATLAB, utilising `fitcnet` function [1] is easy method to build (and hence train and test) a fully connected neural network. For instance, we could optionally construct a 4-3-4-3 layers neural network for realising the classification at `fisheriris` dataset:

```matlab
clc,clear,close all

load fisheriris.mat
cv = cvpartition(species,"HoldOut",0.4,"Stratify",true);
species = table2array(cell2table(species));
meas = array2table(meas);
dataTable = addvars(meas,species,'After',"meas4");

trainingDataTable = dataTable(cv.training,:);
testDataTable = dataTable(cv.test,:);

mdl = fitcnet(...
    trainingDataTable,"species", ...
    "LayerSizes",[3,4], ...
    "Activations","relu", ...
    "Standardize",true, ...
    "LossTolerance",1e-6 ... % default value, 1e-6
    );
%     "Verbose",1);
pred = mdl.predict(testDataTable(:,1:4));
accu = sum(strcmp(pred,table2array(testDataTable(:,5))))/numel(testDataTable(:,5));
disp(accu)

figure
hold(gca,"on"),grid(gca,"on"),box(gca,"on")
plot(mdl.TrainingHistory.Iteration,mdl.TrainingHistory.TrainingLoss, ...
    "LineWidth",1.5,"LineStyle","-","Marker","o")
title(sprintf("Training loss:%.8f",mdl.TrainingHistory.TrainingLoss(end)))
xlabel("Interation")
ylabel("Training loss")
xlim([0,mdl.TrainingHistory.Iteration(end)])
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230904000012841.png?raw=true" alt="image-20230904000012841" style="zoom:50%;" />

The property of `"LossTolerance",1e-6` shows that the training process of this network stops when training loss is equal or less than the specified value `1e-6` (although is `1e-6` is default value, specifying it explicitly is a better practice). This is so literally obvious that users possibly neglect two details about stopping condition of network, which are I want to point out in this blog. 

<br>

# `GradientTolerance` property

To begin with, we could find this network will stop before training loss is equal or less than `1e-6` in some cases, like:

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230904001424267.png?raw=true" alt="image-20230904001424267" style="zoom:50%;" />

The reason for this phenomenon is that the gradient is extremely small so that MATLAB believe the network is well-trained and unnecessary to continue training. Actually, we could define what is “extremely small” for gradient by property `GradientTolerance`, whose default value is `1e-6` as well:

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230904002111936.png?raw=true" alt="image-20230904002111936" style="zoom:50%;" />

We could verify it in the above case:

```
>> mdl.TrainingHistory.Gradient(end-1:end)
ans =
   1.0e-05 *
   0.918975375158474
   0.016944200306518
```

<br>

# Validation concerned properties `ValidationData`, `ValidationPatience` and `ValidationChecks`

Another thing I want to mention is about validation and test. In some scenes, we may want to look into the corresponding TEST loss of model at different training stages, but we do not and also could not expect to make the test samples get involved in the training process, otherwise the problem of data leakage will happen. A seemingly correct way is by setting `ValidationData` property, like this:

```matlab
...
mdl = fitcnet(...
    trainingDataTable,"species", ...
    "LayerSizes",[3,4], ...
    "Activations","relu", ...
    "Standardize",true, ...
    "LossTolerance",1e-6, ... % default value, 1e-6
    "GradientTolerance",1e-6, ... % default value, 1e-6
    "ValidationData",testDataTable... 
    );

pred = mdl.predict(testDataTable(:,1:4));
accu = sum(strcmp(pred,table2array(testDataTable(:,5))))/numel(testDataTable(:,5));
disp(accu)

figure
hold(gca,"on"),grid(gca,"on"),box(gca,"on")
plot(mdl.TrainingHistory.Iteration,mdl.TrainingHistory.TrainingLoss, ...
    "LineWidth",1.5,"LineStyle","-","Marker","o","DisplayName","Training loss")
plot(mdl.TrainingHistory.Iteration,mdl.TrainingHistory.ValidationLoss, ...
    "LineWidth",1.5,"LineStyle","-","Marker","square","DisplayName","Test loss")
title(sprintf("Training loss:%.8f",mdl.TrainingHistory.TrainingLoss(end)))
xlabel("Interation")
ylabel("Training loss")
xlim([0,mdl.TrainingHistory.Iteration(end)])
legend
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230904085425364.png?raw=true" alt="image-20230904085425364" style="zoom:50%;" />

But we could find from the results that the aforementioned phenomenon, i.e., the network stops training before training loss reduce to the `LossTolerance`, happens more frequently, although the gradient dose not reduce to the `GradientTolerance` value.

This is because that once we set `ValidationData` property, the validation dataset will influence the training progress DEFINITELY, despite the fact that we just want to observe whose loss. Or rather, at this time, the stopping condition is determined by validation loss in a way, and depending on `ValidationPatience` property:

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230904010258981.png?raw=true" alt="image-20230904010258981" style="zoom:50%;" />

According official introduction in the above figure, default value `6` of  `ValidationPatience` means if the situation which validation loss is greater than or equal to the minimum validation loss computed so far happens at least 6 times IN A ROW, the network will stop training and return a trained network, regardless of settings of `LossTolerance` and `GradientTolerance`. This point could also be verified by read-only `ValidationChecks` property:

```
>> mdl.TrainingHistory.ValidationChecks'
ans =
  Columns 1 through 18
     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0     0
  Columns 19 through 25
     0     1     2     3     4     5     6
```

Which means that the loss we observed now is VALIDATION loss, not test loss. But on the other hand, based on this property and whose explanation, we could figure out that setting `ValidationChecks` at `Inf` could realise what we expected, that is keeping these samples packed in `ValidationData` away from training process and just observing whose loss.

```matlab
clc,clear,close all

load fisheriris.mat
cv = cvpartition(species,"HoldOut",0.4,"Stratify",true);
species = table2array(cell2table(species));
meas = array2table(meas);
dataTable = addvars(meas,species,'After',"meas4");

trainingDataTable = dataTable(cv.training,:);
testDataTable = dataTable(cv.test,:);

mdl = fitcnet(...
    trainingDataTable,"species", ...
    "LayerSizes",[3,4], ...
    "Activations","relu", ...
    "Standardize",true, ...
    "LossTolerance",1e-6, ...% default value, 1e-6
    "GradientTolerance",1e-6, ...% default value, 1e-6
    "ValidationData",testDataTable, ... 
    "ValidationPatience",Inf... % default value, 6
    );

pred = mdl.predict(testDataTable(:,1:4));
accu = sum(strcmp(pred,table2array(testDataTable(:,5))))/numel(testDataTable(:,5));
disp(accu)

figure
hold(gca,"on"),grid(gca,"on"),box(gca,"on")
plot(mdl.TrainingHistory.Iteration,mdl.TrainingHistory.TrainingLoss, ...
    "LineWidth",1.5,"LineStyle","-","Marker","o","DisplayName","Training loss")
plot(mdl.TrainingHistory.Iteration,mdl.TrainingHistory.ValidationLoss, ...
    "LineWidth",1.5,"LineStyle","-","Marker","square","DisplayName","Test loss")
title(sprintf("Training loss:%.8f",mdl.TrainingHistory.TrainingLoss(end)))
xlabel("Interation")
ylabel("Training loss")
xlim([0,mdl.TrainingHistory.Iteration(end)])
legend
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230904091321131.png?raw=true" alt="image-20230904091321131" style="zoom:50%;" />

At this time, we could find more noticeable overfitting phenomenon from which.

<br>

**References**

[1] [fitcnet - MathWorks](https://ww2.mathworks.cn/help/stats/fitcnet.html).
