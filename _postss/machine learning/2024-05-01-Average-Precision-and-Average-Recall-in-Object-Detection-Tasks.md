---
layout: single
title: The Metrics of Average Precision (AP) and Average Recall (AR) in Object Detection Tasks
categories:
 - Machine Learning
tags:
 - Computer Vision
 - Object Detection
drafted_at: 2024-04-23 14:26:41 +0800
date: 2024-05-01 17:40:09 +0800
last_modified_at0: 2024-05-01 17:40:09 +0800
last_modified_at1: 2024-05-06 10:12:19 +0800
last_modified_at: 2024-05-06 10:12:19 +0800
---

# Introduction
Recently, I've been reading Tsung-Yi Lin[^7] *et al.*'s paper, *Focal Loss for Dense Object Detection*[^8] (Best Student Paper Award in 2017 ICCV). In their ablation experiments for testing Focal Loss, several metrics were adopted to evaluate detectors, like $$\text{AP}$$, $$\text{AP}_{50}$$, $$\text{AP}_{75}$$, $$\text{AP}_{\mathrm{S}}$$, $$\text{AP}_{\mathrm{M}}$$, $$\text{AP}_{\mathrm{L}}$$:

<div id="Lin"></div>

![image-20240423210808300](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404232108792.png)

These metrics are so commonly used in object detection that they didn't give any explicit explanation. But I am totally fresh in this area, and have no idea about them. This is why I write this post.

AP is the abbreviation for Average Precision, but it's actually not the average of detection precision, which looks reasonable according to its literal meaning. Rather, like the notion of AUC for ROC curve (TPR-FPR) in classification task, AP is also computed based on a specific curve, that is precision-recall curve. 

Due to that I ever learned ROC curve in classification problem in detail (see my previous blog[^1]), so when I first knew about AP, I realized that it is a good start to introduce it from the concept of ROC curve. Therefore, in the following text, I would first explain ROC curve briefly. Then, AP and some metrics related to it will be introduced. Besides, AR, i.e., Average Recall, is also usually used for evaluating detectors, and it has the similar calculation method with AP. So, I would make some explanations about it as well.

<br>

# The concepts of ROC curve and AUC in binary classification task

In the binary classification task, a classifier after training can output predicted possibilities (more precisely, say *scores*) for the input observations. Researchers can set a *threshold*, and those observations whose corresponding scores are over/below the specified threshold can be labeled as positive/negative. Then, according to the true labels and corresponding predicted labels for observations, we can obtain a 2-by-2 confusion matrix, classifying each observation as TP (True positive), FN (False negative), FP (False positive), or TN (True negative), and hence TPR (True positive rate, or say *recall*) and FPR (False positive rate) can be calculated:

$$
\text{TPR}\text{ (a.k.a. recall)}=\dfrac{\text{TP}}{\text{TP}+\text{FN}}\label{eq1}
$$

$$
\text{FPR}=\dfrac{\text{FP}}{\text{FP}+\text{TN}}\label{eq2}
$$

By varying the specified threshold, we can obtain different TPR-FPR pairs, and based on which an ROC (Receiver Operating Characteristic) curve, showing how TPR changes as FPR, can be plotted. The area under the ROC curve (also known as AUC), that is the integral of ROC curve over the interval $\text{FPR}\in[0,1]$, is a metric that can reflect the average performance of the classifier.

More detailed information concerning ROC and AUC can be found in my previous blog[^1].
{: .notice--primary}

<br>

# AP and AP-related metrics

## Average Precision (AP): AUC of precision-recall curve

In object detection tasks, the detector usually predicts bounding boxes and corresponding class labels[^2]. AP and some related metrics are to evaluate the performance of detectors predicting bounding boxes. 

Take single object detection. 

The true position of bounding boxes (usually is annotated by hands) is called *ground truth bounding box*, and the predicted position is *predicted bounding box* [^9][^3]:

<p><a href="https://commons.wikimedia.org/wiki/File:Intersection_over_Union_-_object_detection_bounding_boxes.jpg#/media/File:Intersection_over_Union_-_object_detection_bounding_boxes.jpg"><img src="https://upload.wikimedia.org/wikipedia/commons/2/2d/Intersection_over_Union_-_object_detection_bounding_boxes.jpg" alt="Intersection over Union - object detection bounding boxes.jpg" height="450" width="600"></a><br>By Adrian Rosebrock,
 <a href="https://creativecommons.org/licenses/by-sa/4.0" title="Creative Commons Attribution-Share Alike 4.0">CC BY-SA 4.0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=57718561">Link</a>.</p>

Based on them, we can define the notion of Intersection over Union (IoU) as follows[^4]:

<p><a href="https://commons.wikimedia.org/wiki/File:Intersection_over_Union_-_visual_equation.png#/media/File:Intersection_over_Union_-_visual_equation.png"><img src="https://upload.wikimedia.org/wikipedia/commons/c/c7/Intersection_over_Union_-_visual_equation.png" alt="Intersection over Union - visual equation.png" height="468" width="600"></a><br>By Adrian Rosebrock, <a href="https://creativecommons.org/licenses/by-sa/4.0" title="Creative Commons Attribution-Share Alike 4.0">CC BY-SA 4.0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=57718560">Link</a>.</p>

Apparently, different cases will yields different IoU values (range from [0,1]), for example[^5],

<p><a href="https://commons.wikimedia.org/wiki/File:Intersection_over_Union_-_poor,_good_and_excellent_score.png#/media/File:Intersection_over_Union_-_poor,_good_and_excellent_score.png"><img src="https://upload.wikimedia.org/wikipedia/commons/e/e6/Intersection_over_Union_-_poor%2C_good_and_excellent_score.png" alt="Intersection over Union - poor, good and excellent score.png" height="248" width="600"></a><br>By Adrian Rosebrock, <a href="https://creativecommons.org/licenses/by-sa/4.0" title="Creative Commons Attribution-Share Alike 4.0">CC BY-SA 4.0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=57718559">Link</a>.</p>

Here, if adopt different IoU *thresholds*, we can classify the predicted detection results as TP or FP. 

Take the above case. If we set threshold as 0.5, then we have:

$$
\begin{split}
\text{TP} = 2,\ \text{FP} = 1
\end{split}
$$

and if the threshold is 0.8, then:

$$
\begin{split}
\text{TP} = 1,\ \text{FP} = 2
\end{split}
$$

In target detection, where kind of different from constructing the ROC curve based on TPR-FPR pairs in classification task, we hope to obtain a *precision-recall curve* (p-r curve, or $p(r)$​). Among which, the definition of precision is[^10]:

$$
\text{precision} = \dfrac{\text{TP}}{\text{TP}+\text{FP}}\label{eq3}
$$

and the definition of recall is the same as Eq. $\eqref{eq1}$, and FN in Eq. $\eqref{eq1}$ represents the case that "a detector does not detect an object that is present—either by silently failing to detect the object's presence entirely, or by miscalculating the object's location or classification"[^11], or rather, "If a ground-truth bounding box has no TP detection to math with, it is labeled as a false negative FN."[^21]

For aforementioned two cases, assuming that FN is 2 in both cases, then precision-recall pairs are $(0.67,0.5)$ and $(0.33, 0.33)$, respectively. By varying IoU thresholds more densely, more precision-recall pairs can be calculated, and hence $p(r)$ plotted. 

Similar to the definition of AUC made for ROC curve in binary classification task, for object detection, "Average Precision (AP) computes the average value of $p(r)$ over the interval from $r=0$ to $r=1$​​, that is the area under the precision-recall curve"[^12].  

Note that, in practice, the starting point of the integration interval is usually selected as 0.5 rather than 0. This point will be explained later.
{: .notice--warning}

## AP-related metrics: $$\text{AP}^{\text{IoU}=.50}$$, $$\text{AP}^{\text{IoU}=.75}$$, $$\text{AP}^{\text{small}}$$, $$\text{AP}^{\text{medium}}$$, and $$\text{AP}^{\text{large}}$$

COCO (Common Objects in Context) official website provides an webpage to give more detailed information about evaluation metrics[^6], in addition to AP, there are some others related to it:

<div id="table-I"></div>

$$
\begin{array}{ll}
\hline
\text{Average Precision (AP):} & \\
\text{AP}& \text{AP at IoU}=.50:.05:.95 \text{ (primary challenge metric)}\\
\text{AP}^{\text{IoU}=.50} & \text{AP at IoU=.50 (PASCAL VOC metric)}\\
\text{AP}^{\text{IoU}=.75} & \text{AP at IoU=.75 (strict metric)}\\
\hline
\text{AP Across Scales:} & \\
\text{AP}^{\text{small}} &  \text{AP for small objects: area} < 32^2;\\
\text{AP}^{\text{medium}} & \text{AP for medium objects: } 32^2 < \text{area} < 96^2;\\
\text{AP}^{\text{large}} & \text{AP for large objects: area} > 96^2;\\
\hline
\text{Average Recall (AR):} & \\
\text{AR}^{\text{max=1}} & \text{AR given 1 detection per image;}\\
\text{AR}^{\text{max=10}}  &  \text{AR given 10 detections per image;}\\
\text{AR}^{\text{max=100}} &  \text{AR given 100 detections per image;}\\
\hline
\text{AR Across Scales:} & \\
\text{AR}^{\text{small}} & \text{AR for small objects: area <} 32^2;\\
\text{AR}^{\text{medium}} & \text{AR for medium objects: } 32^2 < \text{area} < 96^2;\\
\text{AR}^{\text{large}} & \text{AR for large objects: area} > 96^2;\\
\hline
\end{array}\notag
$$

It's not hard to figure out that, the metrics $$\text{AP}_{50}$$, $$\text{AP}_{75}$$, $$\text{AP}_{\mathrm{S}}$$, $$\text{AP}_{\mathrm{M}}$$, and $$\text{AP}_{\mathrm{L}}$$ in [Lin's paper](#Lin) correspond to $$\text{AP}^{\text{IoU}=.50}$$, $$\text{AP}^{\text{IoU}=.75}$$, $$\text{AP}^{\text{small}}$$, $$\text{AP}^{\text{medium}}$$, and $$\text{AP}^{\text{large}}$$ in the above table, respectively.

After learning previous content, it's OK for me to understand what do $$\text{AP}$$, $$\text{AP}_{\mathrm{S}}$$, $$\text{AP}_{\mathrm{M}}$$ and $$\text{AP}_{\mathrm{L}}$$ mean and how they work. For example, for those metrics belonging to "AP Across Scales" part, AP-related metrics are used to judge whether or not detectors behave well for detecting small ($$\text{area}< 32^2$$), medium ($$32^2<\text{area}<96^2$$), and large ($$\text{area}>96^2$$) objects. 

However, I still feel confused about $\text{AP}^{\text{IoU}=.50}$ and $\text{AP}^{\text{IoU}=.75}$. I've found some other references, but they all point out that AP metrics are computed based on the precision-recall curve[^13][^14], but how to determine a precision-recall curve based on only one precision-recall pair which is calculated by setting IoU threshold as 0.5 or 0.75? So finally, I make a guess that, maybe in these cases, precision-recall curve is horizontal line. Or rather, the precision always keeps the same with the precision value calculated based on setting threshold as 0.5/0.75 although recall changes, so that the area under the precision-recall curve is simply rectangular. 

<br>

# AR and AR-related metrics

## Average Recall (AR): AUC of recall-IoU curve

As can be seen from [Table I](#table-I), besides AP, COCO detection challenge also take AR-related metrics. 

AR is the abbreviation for Average Regression. According to Zenggyu's blog[^15], like how we create the precision-recall curve while calculating AP, we can obtain a series of recall values by varying IoU thresholds. A recall-IoU curve can be plotted based on recall-IoU pairs, and the AUC of this recall-IoU curve is so-called AR, which can be expressed as (in continuous form):

$$
\text{AR}=2\int_{0.5}^1\text{recall}(o)\mathrm{d}o\label{eq4}
$$

where $o$ is IoU threshold and $\text{recall}(o)$ is the corresponding recall.

Eq. $\eqref{eq4}$ is consistent with the paper, *What makes for effective detection proposals?*[^16], which is referred by COCO evaluation documentation[^6] when introducing AR metric (actually it is the paper proposing AR metrics):

<div id="fig-1"></div>

![image-20240429145404206](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404291455333.png)

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404291456720.png" alt="image-20240429145600528" style="zoom: 67%;" />

## AR-related metrics: $\text{AR}^{\text{max}={1}}$, $\text{AR}^{\text{max}={10}}$, and $\text{AR}^{\text{max}={100}}$

If understand AP, it's not difficult to understand how AR is computed. However, as for the specific meaning of "$\text{AR}^{\text{max}={\text{X}}}$: AR given X (1/10/100) detection(s) per image" in [Table I](#table-I), I am not that sure. 

Some references explain about them, like Picsellia's blog[^17]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404291512386.png" alt="image-20240429151253166" style="zoom: 67%;" />

which says that "X" is the *confidence threshold* that used to determined whether a prediction is considered a true positive or false positive, and that will influence recall values. But it seems not much clear, at least for me. Didn't we take IoU threshold as the threshold to determine recall when plotting the recall-IoU curve?

So, I read Hosang's paper[^16] again, and I find that, "X" in "$\text{AR}^{\text{max}={\text{X}}}$ : AR given X (1/10/100) detection(s) per image" may represent the number of *proposals*. 

From Ma's paper[^18], "Object proposal aims to generate a certain amount of candidate bounding boxes to determine the potential objects and their locations in an image, which is widely applied to many visual tasks for pre-processing, e.g., object detection, segmentation, object discovery, and 3D match." Therefore, I think that a candidate bounding box can be viewed as a *proposal*.

Although I haven't conducted any specific target detection work, after searching some references, I guess that there exists a type of object detection neural network, may called Region Proposal Network (RPN)[^19], which can generate multiple proposals with different scores for a single image. Therefore, if we calculate AR based on the proposal with the highest score for each image, then the AR metric in this case is so-called $\text{AR}^{\text{max}={\text{1}}}$; similarly, if we calculate AR based on the proposals with the first 100 highest score for each image, then $\text{AR}^{\text{max}={\text{100}}}$; and so on. It's not hard to conclude that, if the RPN is not that bad, as X increases (corresponding to a stricter test for detectors), metric $\text{AR}^{\text{max}={\text{X}}}$ usually has a tendency to increase, as shown as another figure in Hosang's paper[^16]:

![image-20240429161846668](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404291618053.png)

<br>

# By the way ...

## The integration interval when calculating AP and AR

One thing that should be noted that, although theoretically, we can calculate the precision-recall/recall-IoU threshold curve across the interval of IoU threshold ranging from 0 to 1, in practice we usually choose the interval starting from 0.5 to calculate AP/AR, shown as [Table I](#table-I) and [Fig. 1](#fig-1), the example of calculating AP and that of AR. 

About this point, a footnote in Hosang's paper[^16] provides a fairly clear explanation; there is no need to discuss more:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405011846633.png" alt="image-20240501184542483" style="zoom:67%;" />

## mAP and mAR

As mentioned before, many detectors could not only predict the positions of bounding boxes, but also  the labels (categories) for objects in the boxes. Therefore, if we calculate APs/ARs for all categories, and then average their sum, we can obtain the metric Mean Average Precision (mAP)**/**Mean Average Recall (mAR).

That being said, the nuance between AP/AR and mAP/mAR would be deliberately neglected at times, like COCO detection challenge[^2][^6]:

"AP is averaged over all categories. Traditionally, this is called "mean average precision" (mAP). We make no distinction between AP and mAP (and likewise AR and mAP) and assume the difference is clear from context."

However, it doesn't mean that AP for each category doesn't matter. For example, Hosang's paper[^16] made a detailed comparison and analysis for APs at category level:

![image-20240501194038559](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405011941493.png)

So, although COCO detection evaluation webpage[^6] says their code doesn't emphasize the difference between AP and mAP, I think COCO API[^20] still supports computing and outputting AP for each category while evaluating detectors. I would verify this point further if I have the opportunity to deal with specific object detection task.

<br>

# References

[^1]: [Receiver Operating Characteristic (ROC) Curve in MATLAB - What a starry night~](https://helloworld-1017.github.io/2023-01-06/13-37-31.html).
[^2]: [mAP (mean Average Precision) might confuse you! \| by Shivy Yohanandan \| Towards Data Science](https://towardsdatascience.com/map-mean-average-precision-might-confuse-you-5956f1bfa9e2).
[^3]: [Intersection over Union - object detection bounding boxes - Jaccard index - Wikipedia](https://en.wikipedia.org/wiki/Jaccard_index#/media/File:Intersection_over_Union_-_object_detection_bounding_boxes.jpg).
[^4]: [Intersection over Union - visual equation - Jaccard index - Wikipedia](https://en.wikipedia.org/wiki/Jaccard_index#/media/File:Intersection_over_Union_-_visual_equation.png).
[^5]: [Intersection over Union - poor, good and excellent score - Jaccard index - Wikipedia](https://en.wikipedia.org/wiki/Jaccard_index#/media/File:Intersection_over_Union_-_poor,_good_and_excellent_score.png).
[^6]: [COCO - Common Objects in Context](https://cocodataset.org/#detection-eval).
[^7]: [Tsung-Yi Lin](https://tsungyilin.info/).
[^8]: Lin, Tsung-Yi, et al. "Focal loss for dense object detection." *Proceedings of the IEEE international conference on computer vision*. 2017, available at: [[1708.02002] Focal Loss for Dense Object Detection](https://arxiv.org/abs/1708.02002).
[^9]: [Jaccard index - Wikipedia](https://en.wikipedia.org/wiki/Jaccard_index).
[^10]: [Precision and recall - Wikipedia](https://en.wikipedia.org/wiki/Precision_and_recall).
[^11]: Miller, Dimity, et al. "What’s in the black box? the false negative mechanisms inside object detectors." *IEEE Robotics and Automation Letters* 7.3 (2022): 8510-8517, available at: [[2203.07662] What's in the Black Box? The False Negative Mechanisms Inside Object Detectors](https://arxiv.org/abs/2203.07662).
[^12]: [Evaluation measures (information retrieval): Average Precision  - Wikipedia](https://en.wikipedia.org/wiki/Evaluation_measures_(information_retrieval)#Average_precision).

[^13]: [Evaluation Metrics for Object detection algorithms \| by Vijay Dubey \| Medium](https://medium.com/@vijayshankerdubey550/evaluation-metrics-for-object-detection-algorithms-b0d6489879f3).
[^14]: [The PASCAL Visual Object Classes Challenge 2012 (VOC2012) Development Kit](http://host.robots.ox.ac.uk/pascal/VOC/voc2012/htmldoc/devkit_doc.html#SECTION00050000000000000000).
[^15]: [Zenggyu的博客 - An Introduction to Evaluation Metrics for Object Detection](https://blog.zenggyu.com/posts/en/2018-12-16-an-introduction-to-evaluation-metrics-for-object-detection/index.html).
[^16]: Hosang, Jan, et al. "What makes for effective detection proposals?." *IEEE transactions on pattern analysis and machine intelligence* 38.4 (2015): 814-830, available at: [[1502.05082] What makes for effective detection proposals?](https://arxiv.org/abs/1502.05082).
[^17]: [COCO Evaluation metrics explained — Picsellia](https://www.picsellia.com/post/coco-evaluation-metrics-explained).
[^18]: Ma, Jianxiang, et al. "Object-level proposals." *Proceedings of the IEEE international conference on computer vision*. 2017, available at: [ICCV 2017 Open Access Repository](https://openaccess.thecvf.com/content_iccv_2017/html/Ma_Object-Level_Proposals_ICCV_2017_paper.html).
[^19]: [Region Proposal Network (RPN) in Object Detection - GeeksforGeeks](https://www.geeksforgeeks.org/region-proposal-network-rpn-in-object-detection/).
[^20]: [cocodataset/cocoapi: COCO API - Dataset @ http://cocodataset.org/](https://github.com/cocodataset/cocoapi).
[^21]: Sun, Xian, et al. "FAIR1M: A benchmark dataset for fine-grained object recognition in high-resolution remote sensing imagery." *ISPRS Journal of Photogrammetry and Remote Sensing* 184 (2022): 116-130, available at: [FAIR1M: A benchmark dataset for fine-grained object recognition in high-resolution remote sensing imagery - ScienceDirect](https://www.sciencedirect.com/science/article/pii/S0924271621003269).
