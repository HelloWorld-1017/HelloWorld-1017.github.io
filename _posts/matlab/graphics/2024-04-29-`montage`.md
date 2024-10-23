---
title: MATLAB `montage` Function
categories:
 - MATLAB
 - Machine Learning
tags:
 - MATLAB Image Processing and Computer Vision
 - MATLAB Image Processing Toolbox
 - MATLAB Data Import and Analysis
 - MATLAB Medical Imaging Toolbox
date: 2024-04-29 13:00:59 +0800
last_modified_at: 2024-10-05 22:13:13 +0800
---

# Introduction

MATLAB `montage` function is to "display multiple image frames as rectangular montage"[^1]. It is an efficient way to use this function to organize a set of images, to show a development process, make a comparison between images, or just display several images belonging to a certain collection. 

Like in the field of studying discharge and arc, Zong *et al.* shows the arc development process along an insulator in their paper[^4]:

![image-20240428144341765](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404281444805.png)

And, in the filed of deep learning, especially computer vision, `montage` function can be used to arrange and display several images from an identical image data set, just like Goodfellow *et al.* did in their classical paper, *Generative adversarial nets*[^5]:

![image-20240428145329298](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404281453517.png)

Before, I ever learned some MATLAB examples about deep learning for images, such as *Train Generative Adversarial Network (GAN)*[^6] and *Train Wasserstein GAN with Gradient Penalty (WGAN-GP)*[^7] (see blogs [^8] and [^9]). In these examples,  `imtile` function (combine multiple image frames into one rectangular tiled image)[^10], `rescale` function (scale range of array elements (to $[0,1]$ by default) )[^11], and `image` function (display image from array)[^12] are combined to realize multiple image layout. And finally, we also should use `axis off` to hide the axis. 

Both `imtile` and `image` functions are from basic MATLAB Graphics Toolbox, so above workflow is not that concise. Rather, `montage` function is from Image Processing Toolbox, therefore providing a more professional and elegant way as will be shown in the following text. Therefore, I would take some notes about `montage` function in this post. 

All of following examples are from `montage` official documentation[^1], but in the documentation, examples and `motage` properties are described separately to some extent. Some examples are more appropriate to illustrate some certain properties, so I re-organize contents in the documentation, and intentionally ignore something that I think not commonly used. Basically, the differences between these examples lie in which kind of data structure storing images the `montage` function read from, and whether or not the images have the same type and size. 

<br>

# MATLAB `montage` function

## Example 1: create montage from multi-frame image (3-D array)

`montage` function can directly accept the image array as input. Take gray images, which have only one single color channel, as an example:

```matlab
clc,clear,close all

% Load an MRI dataset
load mristack

% Display the dataset
% `montage` treats the data as a multiframe image and displays each slice
figure("Color","w")
img = montage(mristack);
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190137578.png" alt="image-20240419013707480" style="zoom:50%;" />

where code `load mristack` is used to load an MRI (Magnetic Resonance Imaging) data set, which only includes a 3-D `uint8`-class array `mristack` storing the pixel data of 21 gray images:

```
>> whos mristack
  Name            Size                  Bytes  Class    Attributes
  mristack      256x256x21            1376256  uint8              
```

and `img` is a `Image`-class variable:

```
>> whos img
  Name      Size            Bytes  Class                              Attributes
  img       1x1                 8  matlab.graphics.primitive.Image            
```

We can specify the number of images to be displayed by setting `"Indices"` property, like showing the first seven images for example:

```matlab
clc,clear,close all

% Load an MRI dataset
load mristack

% Display the first seven images
figure("Color","w")
img = montage(mristack,"Indices",1:7);
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190151991.png" alt="image-20240419015107679" style="zoom: 50%;" />

## Example 2: create montage containing images of different types and sizes

`montage` function also can be used to process and display images with different types (colorful or gray images) and sizes (with different resolutions):

<div id="script-1"></div>

```matlab
clc,clear,close all

% Read several images of different types and sizes into the workspace.
imRGB = imread("peppers.png");
imGray = imread("coins.png");

% Display a montage containing all of the images
figure("Color","w")
img = montage({imRGB,imGray,"cameraman.tif"});
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190203172.png" alt="image-20240419020307894" style="zoom:50%;" />

where

```
>> whos
  Name          Size                Bytes  Class                              Attributes
  imGray      246x300               73800  uint8                                     
  imRGB       384x512x3            589824  uint8                                     
  img           1x1                     8  matlab.graphics.primitive.Image           
```

As can be seen, `imGray` is a 2-D array representing a gray image, while `imRGB` is a 3-D array representing an RGB image. And if we read `"cameraman.tif"` into the workspace, we could find it is also a gray array, but whose size is different from `"coins.png"`:

```
>> imGray2 = imread("cameraman.tif");
>> whos imGray2
  Name           Size             Bytes  Class    Attributes
  imGray2      256x256            65536  uint8              
```

In this case, we can have a look at what properties `"BackgroundColor"` (default value is `"black"`) and `"BorderSize"` (default value is `[0 0]`) determine:

```matlab
clc,clear,close all

% Read several images of different types and sizes into the workspace.
imRGB = imread("peppers.png");
imGray = imread("coins.png");

% Display a montage containing all of the images
figure("Color","w")
img = montage({imRGB,imGray,"cameraman.tif"}, ...
    "BackgroundColor","b","BorderSize",[200,100]);
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190248584.png" alt="image-20240419024811391" style="zoom:50%;" />

## Example 3: create montage from several image files

Actually, all of three images in [Script 1](#script-1), `peppers.png`, `coins.png`, and `cameraman.tif`, are in the MATLAB default searching path, so it's okay if we use `montage` in the following way:

```matlab
clc,clear,close all

% Display a montage containing all of the images
figure("Color","w")
img = montage({'peppers.png','coins.png','cameraman.tif'});
```

At this point, it is also an example showing how to create montage from image files. 

The official documentation provides a more detailed example to show this way. Besides, it also shows the function of `"Size"` property and `"DisplayRange"` property:

```matlab
clc,clear,close all

% Create a string array containing a series of file names
fileFolder = fullfile(matlabroot,"toolbox","images","imdata");
dirOutput = dir(fullfile(fileFolder,"AT3_1m4_*.tif"));
fileNames = string({dirOutput.name});

% Display the images as a rectangular montage
% Specify the shape of the montage as a 2-by-5 rectangle.
fig1 = figure("Color","w");
montage(fileNames,"Size",[2,5]);
title("Specify the shape of the montage as a 2-by-5 rectangle")

% Adjust the contrast of the images in the montage (ONLY functional for gray images)
fig2 = figure("Color","w");
montage(fileNames,"Size",[2,5],"DisplayRange",[75,200]);
title("Adjust the contrast of the images in the montage")
```

The first montage is:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190314079.png" alt="image-20240419031443577" style="zoom:50%;" />

and the second one is:

![image-20240419031504971](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190315260.png)

And `fileNames` is a `1×10 string array`:

```
>> fileNames
fileNames = 
  1×10 string array
    "AT3_1m4_01.tif"    "AT3_1m4_02.tif"    "AT3_1m4_03.tif"    "AT3_1m4_04.tif"    "AT3_1m4_05.tif"    "AT3_1m4_06.tif"    "AT3_1m4_07.tif"    "AT3_1m4_08.tif"    "AT3_1m4_09.tif"    "AT3_1m4_10.tif"
```

Note that, as described in the official documentation, `"DisplayRange"` is to "*Display range of grayscale images in array `I`, specified as 1-by-2 vector of the form `[low high]`. All pixel values less than or equal to `low` display as black. All pixel values greater than or equal to `high` display as white. If you specify an empty matrix (`[]`), then `montage` uses the minimum and maximum pixel values of the images.*" So, this property is ONLY functional when showing gray images. If some images in the montage is colorful, MATLAB will throw a warning, "Warning: Montage image is a color image. `DisplayRange` parameter will be ignored. ".

## Example 4: create montage from image datastore

`mongtage` function is also available for `ImageDatastore` object, for example:

```matlab
clc,clear,close all

% Create an ImageDatastore object containing a series of ten images from 
% the Image Processing Toolbox™ sample image folder.
fileFolder = fullfile(matlabroot,"toolbox","images","imdata");
imds = imageDatastore(fullfile(fileFolder,"AT3*"));

% Display the contents of the datastore as a montage
figure("Color","w")
montage(imds)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202404190348761.png" alt="image-20240419034823309" style="zoom:50%;" />

where

```
>> whos
  Name            Size            Bytes  Class                                 Attributes
  fileFolder      1x1               246  string                                       
  imds            1x1                 8  matlab.io.datastore.ImageDatastore           
```

`imageDatastore` function is listed in the "MATLAB Data Import and Analysis" part, and used to "manage a collection of image files, where each individual image fits in memory, but the entire collection of images does not necessarily fit."[^2] It frequently appears in the workflow of MATLAB deep learning related to images. Therefore, this feature of `montage` function makes it convenient to show the images managed by `imageDatastore` object, like in the target detection example *Object Detection Using YOLO v3 Deep Learning*[^3].

<br>

# References

[^1]: [MATLAB `montage`: Display multiple image frames as rectangular montage - MathWorks](https://ww2.mathworks.cn/help/images/ref/montage.html).
[^2]: [MATLAB `imageDatastore`: Datastore for image data - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/matlab.io.datastore.imagedatastore.html).
[^3]: [Object Detection Using YOLO v3 Deep Learning - MathWorks](https://ww2.mathworks.cn/help/vision/ug/object-detection-using-yolo-v3-deep-learning.html).

[^4]: Zong, Chunyu, et al. "AC flashover characteristics and arc development process of glaze ice-covered insulators in natural environment." International Journal of Electrical Power & Energy Systems 135 (2022): 107559, available at: [AC flashover characteristics and arc development process of glaze ice-covered insulators in natural environment - ScienceDirect](https://www.sciencedirect.com/science/article/pii/S0142061521007948).

[^5]: Goodfellow, Ian, et al. "Generative adversarial nets." *Advances in neural information processing systems* 27 (2014), available at: [Generative Adversarial Nets](https://proceedings.neurips.cc/paper_files/paper/2014/hash/5ca3e9b122f61f8f06494c97b1afccf3-Abstract.html).
[^6]: [Train Generative Adversarial Network (GAN) - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/train-generative-adversarial-network.html).
[^7]: [Train Wasserstein GAN with Gradient Penalty (WGAN-GP) - MathWorks](https://ww2.mathworks.cn/help/deeplearning/ug/trainwasserstein-gan-with-gradient-penalty-wgan-gp.html).
[^8]: [Train Generative Adversarial Network (GAN) in MATLAB - What a starry night~](https://helloworld-1017.github.io/2022-10-09/08-10-11.html).
[^9]: [Train Wassertein GAN with Gradient with Gradient Penalty (WGAN-GP) in MATLAB - What a starry night~](https://helloworld-1017.github.io/2022-10-09/21-28-21.html).

[^10]: [MATLAB `imtile`: Combine multiple image frames into one rectangular tiled image - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/imtile.html).
[^11]: [MATLAB `rescale`: Scale range of array elements - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/rescale.html).
[^12]: [MATLAB `image`: Display image from array - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/image.html).
