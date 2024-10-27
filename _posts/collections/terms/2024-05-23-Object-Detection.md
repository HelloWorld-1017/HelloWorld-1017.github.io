---
title: Terminologies and Methods in Object Detection
categories:
 - Collections
 - Machine Learning
tags:
 - Computer Vision
 - Object Detection
date: 2024-05-23 09:39:02 +0800
last_modified_at: 2024-10-16 15:08:44 +0800
---

# Fundamentals

- **backbone (network)**: refers to the feature-extracting network that processes input data into a certain feature representation.[^1][^2]
- **Region-based approach** (**region proposal algorithm**)
  - The region-based approach is also known as the region proposal algorithm, which extracts an adequate number of regions from the image. ... Region proposal is used as a preprocessing stage or even the key step in many computer vision issues. The algorithm extracts a pool of appropriate regions, which are likely to contain objects, from an image. The extracted regions are shown as a bounding box or a segmented candidate.[^3]
  - In the region-based approach, all pixels that correspond to an object are grouped together and are marked to indicate that they belong to one region. This process is called segmentation. Pixels are assigned to regions using some criterion that distinguishes them from the rest of the image.[^4]
  - Region Based Convolutional Neural Networks: The original goal of R-CNN was to take an input image and produce a set of bounding boxes as output, where each bounding box contains an object and also the category (e.g. car or pedestrian) of the object.[^5]

<br>

# Annotation methods (annotation styles)

- **HBB** (**Horizontal Bounding Box**) vs. **OBB** (**Oriented Bounding Box**)[^6]

  <img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405230852865.png" alt="image-20240523085016249" style="zoom: 80%;" />

- **Bounding Box**, **Diamond Polygon**, and **Full Instance Segmentation**[^9]

  <img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405230918563.png" alt="image-20240523091820425" style="zoom: 80%;" />

<br>

# Methods

- **Few-Shot Learning**[^7]
  - Few-Shot Learning is a machine learning framework in which an AI model learns to make accurate predictions by training on a very small number of labeled examples. It’s typically used to train models for classification tasks when suitable training data is scarce.
  - One-Shot Learning: where there is only one labeled example of each class to be learned.
  - Zero-Shot Learning: where there are no labeled examples at all.
  - While one-shot learning is essentially just a challenging variant of FSL, zero-shot learning is a distinct learning problem that necessitates its own unique methodologies.
- **Linear Warmup**
  - Linear Warmup is a learning rate schedule where we linearly increase the learning rate from a low rate to a constant rate thereafter. This reduces volatility in the early stages of training.[^8]
  - "... Additionally, we used a linear warmup period over 1K iterations."[^9]
- **Cross-dataset validations**[^10][^11]
- **Synthetic data**
  - AI.Reverie simulation platform[^9]: [AI.Reverie](https://www.youtube.com/channel/UCpCBf7i5uxWZi4o9LgIyEcQ).

<br>

**References**

[^1]: [What Does Backbone Mean in Neural Networks?](https://www.baeldung.com/cs/neural-network-backbone).
[^2]: [deep learning - What does backbone mean in a neural network?](https://stackoverflow.com/questions/59868132/what-does-backbone-mean-in-a-neural-network#:~:text=Backbone%20is%20a%20term%20used,models%20to%20generate%20segmented%20masks.).
[^3]: [A comprehensive and systematic review on classical and deep learning based region proposal algorithms](https://www.sciencedirect.com/science/article/abs/pii/S0957417421014366).
[^4]: [MachineVision\_Chapter3.pdf](https://cse.usf.edu/~r1k/MachineVisionBook/MachineVision.files/MachineVision_Chapter3.pdf).
[^5]: [Region Based Convolutional Neural Networks](https://en.wikipedia.org/wiki/Region_Based_Convolutional_Neural_Networks).
[^6]: Ding, Jian, et al. "Object detection in aerial images: A large-scale benchmark and challenges." *IEEE transactions on pattern analysis and machine intelligence* 44.11 (2021): 7778-7796, available at: [(PDF) Object Detection in Aerial Images: A Large-Scale Benchmark and Challenges](https://www.researchgate.net/publication/349583747_Object_Detection_in_Aerial_Images_A_Large-Scale_Benchmark_and_Challenges), or [Object Detection in Aerial Images: A Large-Scale Benchmark and Challenges](https://ieeexplore.ieee.org/abstract/document/9560031).
[^7]: [What Is Few-Shot Learning?](https://www.ibm.com/topics/few-shot-learning).
[^8]: [Linear Warmup Explained](https://paperswithcode.com/method/linear-warmup).
[^9]: Shermeyer, Jacob, et al. "Rareplanes: Synthetic data takes flight." *Proceedings of the IEEE/CVF Winter Conference on Applications of Computer Vision*. 2021, available at: [WACV 2021 Open Access Repository](https://openaccess.thecvf.com/content/WACV2021/html/Shermeyer_RarePlanes_Synthetic_Data_Takes_Flight_WACV_2021_paper.html).
[^10]: Xia, Gui-Song, et al. "DOTA: A large-scale dataset for object detection in aerial images." *Proceedings of the IEEE conference on computer vision and pattern recognition*. 2018, available at: [CVPR 2018 Open Access Repository](https://openaccess.thecvf.com/content_cvpr_2018/html/Xia_DOTA_A_Large-Scale_CVPR_2018_paper.html).
[^11]: Torralba, Antonio, and Alexei A. Efros. "Unbiased look at dataset bias." *CVPR 2011*. IEEE, 2011, available at: [Unbiased look at dataset bias](https://ieeexplore.ieee.org/abstract/document/5995347), or [datasets\_cvpr11.pdf](https://people.csail.mit.edu/torralba/publications/datasets_cvpr11.pdf).
