---
layout: single
title: Parent Container of Components
date: 2022-08-07 13:59:01 +0800
categories:
 - MATLAB
tags: 
 - MATLAB App Building
toc: false
---

<br>

之前想要在 MATLAB App Designer 中实现混淆矩阵的绘制，但是使用 Axes 组件和 Image 组件都无法承载混淆矩阵，会出现报错。

后来看到一篇官方文档 [Display Graphics in App Designer - Mathworks](https://ww2.mathworks.cn/help/matlab/creating_guis/graphics-support-in-app-designer.html)，其中提到：

![image-20220807140952787](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220807140952787.png?raw=true)

也就是说，不同的 graphics function 的 parent container 是不同的。

对于混淆矩阵而言，可以在 [ConfusionMatrixChart Properties - Mathworks](https://ww2.mathworks.cn/help/stats/mlearnlib.graphics.chart.confusionmatrixchart-properties.html) 中查看它所支持的 Parent container：

![image-20220807141552129](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220807141552129.png?raw=true)

于是代码可以写成：

```matlab
...
% SVM confusion matrix
cm1 = confusionchart(app.Tab_svm, truelabels, SVMPrediction);
cm1.XLabel = '预测标签';
cm1.YLabel = '真实标签';
cm1.RowSummary = 'row-normalized';
cm1.ColumnSummary = 'column-normalized';
...
```

其中 `app.Tab_svm` 是一个 Tab 对象，`truelabels`  是样本真实标签，`SVMPrediction` 是样本预测标签。最终效果：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220807142129026.png?raw=true" alt="image-20220807142129026" style="zoom:67%;" />

<br>

同样的，对于其他组件，比如 Grid Layout

![image-20220807142407059](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220807142407059.png?raw=true)

也需要放在规定的 Parent container 中，见 [Control grid layout manager behavior - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/matlab.ui.container.gridlayout-properties.html) 

![image-20220807142723289](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20220807142723289.png?raw=true)
