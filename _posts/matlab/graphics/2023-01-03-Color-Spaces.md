---
title: Color Spaces in MATLAB
categories: 
 - MATLAB
 - Design
tags:
 - MATLAB Graphics
 - MATLAB Image Processing Toolbox
 - Computer Vision
date: 2023-01-03 22:33:31 +0800
last_modified_at: 2024-08-11 16:32:23 +0800
---

# Introduction

在图像识别和图像处理的过程中，人们通常会将彩色RGB图像转化为灰度图像，之后再进行处理，这样做可以减少图像原始数据量，后续处理的计算量也更少。

从更宽泛的角度讲，将RGB图像转化为灰度图像属于图像色彩空间之间的转换，因此博客的后面简要地介绍了各种的色彩空间以及色彩空间之间的转换。

<br>

# `rgb2gray` function in MALTAB 

MATLAB提供了将RGB图像转化为灰度图像的函数`rgb2gray`[^1]：

<div class="quote--left" markdown="1">

`rgb2gray` function converts RGB images to grayscale by **eliminating the hue (色调) and saturation (饱和度) information while retaining the luminance (亮度)**. 

</div>

尽管没有办法完全理解这段话，但是不影响使用这个简单的函数，下面就简单尝试了官方文档提供的两个示例。

## Example 1: Convert RGB Image to Grayscale Image

```matlab
clc, clear, close all

figure("Units", "pixels", "Position", [280,251,1303,541])
tiledlayout(1,2)

% RGB figure
nexttile
RGB = imread('peppers.png');
imshow(RGB)

% Grayscale figure
nexttile
I = rgb2gray(RGB);
imshow(I)
```

![image-20230103071958718](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230103071958718.png?raw=true)

图片转换前后的变量类型和size：

```
>> whos
  Name        Size                Bytes  Class    Attributes
  I         384x512              196608  uint8              
  RGB       384x512x3            589824  uint8     
```

## Example 2: Convert RGB Colormap to Grayscale Colormap

在第二个例子中，MATLAB首先读取了图像文件`corn.tif`，该文件包含了一个indexed image (索引图象) with an RGB colormap。

```matlab
[X, map] = imread('corn.tif');
```

此时，workspace中有两个变量`X`，`map`，分别表示indxed image，和colormap：

```
>> whos
  Name        Size              Bytes  Class     Attributes

  X         415x312            129480  uint8               
  map       256x3                6144  double              
```

我们首先对比一下不使用和使用colormap信息的图像效果：

```matlab
figure("Units", "pixels", "Position", [215,276,761,352])
tiledlayout(1,2)
nexttile
imshow(X)
colorbar

nexttile
imshow(X, map)
colorbar
```

![image-20230103082043311](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230103082043311.png?raw=true)

之后，将RGB colormap转换为grayscale colormap后再展示图像：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230103102855145.png?raw=true" alt="image-20230103102855145" style="zoom:50%;" />

对于indexed image和colormap的使用，我并不熟悉，此处不进行详细地探讨。

## Conversion formula

MATLAB的`rgb2gray`的转化算法是[^1]：

<div class="quote--left" markdown="1">
`rgb2gray` converts RGB values to grayscale values by forming a weighted sum of the $R$, $G$, and $B$ components:
$$
0.298936021293775 * R + 0.587043074451121 * G + 0.114020904255103 * B\notag
$$

The coefficients used to calculate grayscale values in `rgb2gray` are identical to those used to calculate luminance (E'y) in Rec.ITU-R BT.601-7[^2] after rounding to 3 decimal places. Rec.ITU-R BT.601-7 calculates E'y using this formula:

$$
0.299 * R + 0.587 * G + 0.114 * B\notag
$$

</div>

Rec.ITU-R BT.601-7是ITU-R（Radiocommunication Sector of International Telecommunication Union）所发布的一项关于Broadcasting service (television)的标准。

<br>

# `rgb2ntsc` function in MATLAB (YIQ color space)

`rgb2ntsc`函数[^6]的作用是：Convert RGB color values to NTSC color space，其基本语法是：

```matlab
YIQ = rgb2ntsc(RGB)
```

<div class="quote--left" markdown="1">
`YIQ = rgb2ntsc(RGB)` converts the red, green, and blue values of an RGB image to luminance (*Y*) and chrominance (*I* and *Q*) values of an NTSC image.

...

In the NTSC color space, the luminance is the grayscale signal used to display pictures on monochrome (black and white) televisions. The other components carry the hue and saturation information. The value `0` corresponds to the absence of the component, while the value `1` corresponds to full saturation of the component.

`rgb2ntsc` defines the NTSC components using

$$
\begin{bmatrix}
Y\\I\\Q
\end{bmatrix}=
\begin{bmatrix}
0.299 & 0.587 & 0.114\\
0.596 & -0.274 & -0.322\\
0.211 & -0.523 & 0.312\\
\end{bmatrix}
\begin{bmatrix}
R\\G\\B
\end{bmatrix}\notag
$$

</div>

对于`rgb2ntsc`函数而言，它的输出（即Converted YIQ color values）和输入的size保持一致，其含义分别为：

<div class="quote--left" markdown="1">

- *Y*: **Luma**, or **brightness of the image**. Values are in the range [0, 1], where 0 specifies black and 1 specifies white. Colors increase in brightness as *Y* increases.
- *I*: **In-phase**, which is approximately the amount of **<u>blue</u>** or **<u>orange</u>** tones in the image. *I* in the range [-0.5959, 0.5959], where negative numbers indicate blue tones and positive numbers indicate orange tones. As the magnitude of *I* increases, the saturation of the color increases.
- *Q*: **Quadrature**, which is approximately the amount of **<u>green</u>** or **<u>purple</u>** tones in the image. *Q* in the range [-0.5229, 0.5229], where negative numbers indicate green tones and positive numbers indicate purple tones. As the magnitude of *Q* increases, the saturation of the color increases.

</div>

仍然使用官方示例进行展示。

首先是分别查看YIQ空间的三个分量：

```matlab
RGB = imread('board.tif');
YIQ = rgb2ntsc(RGB);

% Three components in YIQ Color Space
figure("Units", "pixels", "Position", [369,141,1010,580])
nexttile
imshow(YIQ(:,:,1));
title('Luminance in YIQ Color Space');
nexttile
imshow(YIQ(:,:,2));
title('In-phase in YIQ Color Space');
nexttile
imshow(YIQ(:,:,3));
title('Quadrature in YIQ Color Space');
```

![image-20230103120045773](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230103120045773.png?raw=true)

我们可以对比一下`rgb2gray`转换函数的效果：

```matlab
% Constrast differenct conversion function
figure("Units", "pixels", "Position", [369,141,1010,580])
nexttile
imshow(RGB)
title('RGB Color Space')
nexttile
imshow(rgb2gray(RGB))
title('Converted by rgb2gray function')
nexttile
imshow(YIQ(:,:,1));
title('Luminance in YIQ Color Space');
```

![image-20230103120210328](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230103120210328.png?raw=true)

```
>> mean(double(rgb2gray(RGB))/255-YIQ(:, :, 1), "all")
ans =
   6.7028e-06
```

可以看到，`rgb2gray`的输出值在[0, 255]之间，而`rgb2ntsc`每一个分量的输出值在[0,1]之间，两者统一到同一标准下是几乎相同的，这也验证了两个转换公式的一致性[^7]。

<div class="quote--left" markdown="1">

The RGB color space represents images as an *m*-by-*n*-by-3 numeric array whose elements specify the intensity values of the red, green, and blue color channels. The range of numeric values depends on the data type of the image.

- For `single` or `double` arrays, RGB values range from [0, 1].
- For `uint8` arrays, RGB values range from [0, 255].
- For `uint16` arrays, RGB values range from [0, 65535].

</div>

<br>

# Various color spaces

`rgb2ntsc`函数的官方文档提到了两个概念：NTSC(Natioanl Television System Committee) color space和YIQ color space (valuses)，从表述来看，两者似乎是一致的。但我查找了一些资料，发现和文档所述有所冲突。

NTSC Color Space[^8]就认为NTSC Color Space代表1953年引入的一种RGB color space，它的色域(color gamut)比sRGB宽得多。维基百科词条YIQ中的这段描述[^14]：

<div class="quote--left" markdown="1">

**NTSC 1953 colorimetry**

These formulas approximate the conversion between the original 1953 color NTSC specification and YIQ.

**From RGB to YIQ**:

$$
\begin{bmatrix}
Y\\I\\Q
\end{bmatrix}\approx
\begin{bmatrix}
0.299 & 0.587 & 0.114\\
0.5959 & -0.2746 & -0.3213\\
0.2115 & -0.5227 & 0.3112\\
\end{bmatrix}
\begin{bmatrix}
R\\G\\B
\end{bmatrix}\notag
$$

**From YIQ to RGB**:

$$
\begin{bmatrix}
R\\G\\B
\end{bmatrix}\approx
\begin{bmatrix}
1 & 0.956 & 0.619\\
1 & -0.272 & -0.647\\
1 & -1.106 & 1.703\\
\end{bmatrix}
\begin{bmatrix}
Y\\I\\Q
\end{bmatrix}\notag
$$

Note that the top row is identical to that of the YUV color space

$$
\begin{bmatrix}
R\\G\\B
\end{bmatrix}=
\begin{bmatrix}
1\\1\\1
\end{bmatrix}\Rightarrow
\begin{bmatrix}
Y\\I\\Q
\end{bmatrix}=
\begin{bmatrix}
1\\0\\0
\end{bmatrix}\notag
$$

</div>

也认为RGB就是original 1953 color NTSC specification，他们都不认为NTSC color space和YIQ是一致的。综上，我个人是倾向于认为NTSC Color Space这个表述很宽泛，就是指NTSC这个组织所规定的色彩空间，并且在不同的场合所指代的色彩空间是不一样的。除此之外，其他色彩空间也存在这样的问题：

<div class="quote--left" markdown="1">

The scope of the terms Y′UV, YUV, YCbCr, YPbPr, etc., is sometimes ambiguous and overlapping.[^13]

</div>

<br>

# Supported color spaces in MATLAB

MATLAB的Image Processing Toolbox单独撰写了一个专题，讲解工具箱所支持的色彩空间以及不同色彩空间之间的转换[^9].

<div class="quote--left" markdown="1">

**(1) RGB**

The RGB color space represents images as an *m*-by-*n*-by-3 numeric array whose elements specify the intensity values of the red, green, and blue color channels. The range of numeric values depends on the data type of the image.

- **Linear RGB**:  Linear RGB values are raw data obtained from a camera sensor. The value of R, G, and B are directly proportional to the amount of light that illuminates the sensor. Preprocessing of raw image data, such as white balance, color balance, and chromatic aberration compensation, are performed on linear RGB values.
- **sRGB**: sRGB values apply a nonlinear function, called gamma correction, to linear RGB values. Images are frequently displayed in the sRGB color space because they appear brighter and colors are easier to distinguish.
- **Adobe RGB (1998)**：  Adobe RGB (1998) RGB values apply gamma correction to linear RGB values using a simple power function.

**(2) HSV**

The HSV (Hue, Saturation, Value) color space corresponds better to how people experience color than the RGB color space does. For example, this color space is often used by people who are selecting colors, such as paint or ink color, from a color wheel or palette.

- *H*:  Hue, which corresponds to **the color’s position on a color wheel**. *H* is in the range [0, 1]. As *H* increases, colors transition from red to orange, yellow, green, cyan, blue, magenta, and finally back to red. Both 0 and 1 indicate red.
- *S*: Saturation, which is **the amount of hue or departure from neutral**. *S* is in the range [0, 1]. As *S* increases, colors vary from unsaturated (shades of gray) to fully saturated (no white component).
- *V*: Value, which is **the maximum value** among the red, green, and blue components of a specific color. *V* is in the range [0, 1]. As *V* increases, the corresponding colors become increasingly brighter.

![image-20230103131746724](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230103131746724.png?raw=true)

**(3) Deviced-independent Color Spaces**[^5]

**CIE 1976 XYZ** and **CIE 1976 L\*a\*b\*** are device-independent color spaces developed by the International Commission on Illumination, known by the acronym CIE. These color spaces model colors according to the typical sensitivity of the three types of cone cells in the human eye.

- The XYZ color space is the original model developed by the CIE. The *Y* channel represents the luminance of a color. The *Z* channel approximately relates to the amount of blue in an image, but the value of *Z* in the XYZ color space is not identical to the value of B in the RGB color space. The *X* channel does not have a clear color analogy. However, if you consider the XYZ color space as a 3-D coordinate system, then *X* values lie along the axis that is orthogonal to the *Y* (luminance) axis and the *Z* axis.[^10]

- The L\*a\*b\* color space provides a more perceptually uniform color space than the XYZ model. **Colors in the L\*a\*b\* color space can exist outside the RGB gamut (the valid set of RGB colors)**. For example, when you convert the L\*a\*b\* value [100, 100, 100] to the RGB color space, the returned value is [1.7682, 0.5746, 0.1940], which is not a valid RGB color. For more information, see [Determine If L\*a\*b\* Value Is in RGB Gamut](https://ww2.mathworks.cn/help/images/use-color-space-conversion-to-handle-out-of-gamut-colors.html).[^11]


**(4) YCbCr**[^4]

The YCbCr color space is widely used for digital video. In this format, luminance information is stored as a single component (*Y*) and chrominance information is stored as two color-difference components (*Cb* and *Cr*). Cb and Cr represent the difference between a reference value and the blue or red component, respectively. 

**YUV, another color space widely used for digital video, is very similar to YCbCr but not identical.**

**(5) YIQ**

The National Television Systems Committee (NTSC) defines a color space known as YIQ. This color space is used in televisions in the United States. This color space separates grayscale information from color data, so the same signal can be used for both color and black and white television sets.

</div>

<br>

# Why use different color spaces?

不同色彩空间之间也可以进行转换，比如说上面提到的各种的转换函数，有些甚至就是简单的线性转换，那为什么还要引入这么多的色彩空间呢？这是因为不同的色彩空间的用处不同，可能某种色彩空间在某些应用场景下就非常有优势，比如MATLAB文档中提到的计算方便、理解直观等优势。

<div class="quote--left" markdown="1">

... because they present color information in ways that make certain calculations more convenient

... or because they provide a way to identify colors that is more intuitive. For example, the RGB color space defines a color as the percentages of red, green, and blue hues mixed together. Other color models describe colors by their hue (shade of color), saturation (amount of gray or pure color), and luminance (intensity, or overall brightness).

</div>

再比如YIQ的Wikipedia词条[^12]中提到的：

<div class="quote--left" markdown="1">

The YIQ system is intended to take advantage of human color-response characteristics. The eye is more sensitive to changes in the orange-blue (I) range than in the purple-green range (Q)—therefore less bandwidth is required for Q than for I.

</div>

以及YIQ色彩空间在image processing transformations中的优势：

<div class="quote--left" markdown="1">

The YIQ representation is sometimes employed in color image processing transformations. For example, applying a histogram equalization directly to the channels in an RGB image would alter the color balance of the image. Instead, the histogram equalization is applied to the Y channel of the YIQ or YUV representation of the image, which only normalizes the brightness levels of the image.

</div>

<br>

# Something else ...

在学习YIQ色彩空间时，感觉I和Q所代表的的含义——In-phase和Quadrature——陌生但熟悉。找了一下之前学习的文献，发现这两个概念出现在参考[^3]中。这篇论文将electromagnetic in-phase and quadrature signal data作为训练集训练了一个semi-supervised GAN，实现了end-to-end electromagnetic signal classification。

![image-20230103222341337](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230103222341337.png?raw=true)

这个信号应该不是图像信号，但是也使用了In-phase和Quadrature的概念，目前不太清楚两者有什么联系，先仅仅是记录在这里。

<br>

**Reference**

[^1]: [rgb2gray - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/rgb2gray.html).
[^2]: [Studio encoding parameters of digital television for standard 4:3 and wide-screen 16:9 aspect ratios (itu.int)](https://extranet.itu.int/brdocsearch/R-REC/R-REC-BT/R-REC-BT.601/R-REC-BT.601-7-201103-I/R-REC-BT.601-7-201103-I!!PDF-E.pdf).
[^3]: Zhou H, Jiao L, Zheng S, et al. Generative adversarial network-based electromagnetic signal classification: A semi-supervised learning framework[J]. China Communications, 2020, 17(10): 157-169, available at: [https://ieeexplore.ieee.org/abstract/document/9248524](https://ieeexplore.ieee.org/abstract/document/9248524).
[^4]: [rgb2ycbcr - MathWorks](https://ww2.mathworks.cn/help/images/ref/rgb2ycbcr.html).
[^5]: [Device-Independent Color Spaces  - MathWorks](https://ww2.mathworks.cn/help/images/device-independent-color-spaces.html).
[^6]: [rgb2ntsc - MathWorks](https://ww2.mathworks.cn/help/images/ref/rgb2ntsc.html).
[^7]: [Understanding Color Spaces and Color Space Conversion: RGB - MathWorks](https://ww2.mathworks.cn/help/images/understanding-color-spaces-and-color-space-conversion.html#mw_7bb4a637-62c8-4e41-8376-785c243782a7).
[^8]: [NTSC Color Space](https://www.saji8k.com/displays/color-space/ntsc-1953/#:~:text=%EE%80%80NTSC%20Color%20Space%EE%80%81%20The%20%EE%80%80NTSC%20Color%20Space%EE%80%81%20is,in%20modern%20displays%2C%20it%20is%20commonly%20used%20to).
[^9]: [Understanding Color Spaces and Color Space Conversion - MathWorks](https://ww2.mathworks.cn/help/images/understanding-color-spaces-and-color-space-conversion.html).
[^10]: [rgn2xyz - MathWorks](https://ww2.mathworks.cn/help/images/ref/rgb2xyz.html).
[^11]: [rgb2lab - MathWorks](https://ww2.mathworks.cn/help/images/ref/rgb2lab.html).
[^12]: [YIQ - Wikipedia](https://en.wikipedia.org/wiki/YIQ).
[^13]: [Y′UV - Wikipedia](https://en.wikipedia.org/wiki/Y%E2%80%B2UV).
[^14]: [YIQ: NTSC 1953 colorimetry - Wikipedia](https://en.wikipedia.org/wiki/YIQ#NTSC_1953_colorimetry).

