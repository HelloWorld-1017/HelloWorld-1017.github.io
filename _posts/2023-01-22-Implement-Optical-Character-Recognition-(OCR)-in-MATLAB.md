---
layout: single
title:  Implement Optical Character Recognition (OCR) in MATLAB
date: 2023-01-22 11:51:32 +0800
categories: 
 - MATLAB
tags:
 - MATLAB Image Processing Toolbox
 - MATLAB Data Import and Analysis
---

# MATLAB `ocr` Function

MATLAB软件本身提供了一个用于文字识别（Optical Character Recognition，OCR）的函数：[ocr - MathWorks](https://ww2.mathworks.cn/help/vision/ref/ocr.html)，并且在文档中提供了几个演示示例。

我在电影 *Before Sunrise* 中截了一张图：

![image-20230121122733171](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230121122733171.png?raw=true)

并保存为`before_sunrise.png`文件，测试一下`ocr`函数的使用效果。

## Rocognize Text Within an Image

第一种使用方法是将整张图片传入到`ocr`函数中进行文字识别，并将识别出文字的部分用Bounding Boxes框出，并标记出相应的识别置信度：

```matlab
clc, clear, close all

% Read image
image = imread("before_sunrise.png");

% Implement OCR
ocrResults = ocr(image);
disp(ocrResults.Text)

% Diplay Bounding Boxes of Words and Recognition Confidences
Iocr = insertObjectAnnotation(image, "rectangle", ...
    ocrResults.WordBoundingBoxes, ...
    ocrResults.WordConfidences);
imshow(Iocr);
```

文字识别的结果保存在变量`ocrResults`中：

```matlab
>> ocrResults
ocrResults = 
  ocrText with properties:
                      Text: 'L“\\iL'i\i↵↵ ↵↵» fcﬁnﬂg↵L \ . 4↵↵'
    CharacterBoundingBoxes: [33×4 double]
      CharacterConfidences: [33×1 single]
                     Words: {8×1 cell}
         WordBoundingBoxes: [8×4 double]
           WordConfidences: [8×1 single]
```

```matlab
>> ocrResults.Text
ans =
    'L“\\iL'i\i
     
      
     
     » fcﬁnﬂg
     L \ . 4
     
     '
```

最终标记的图像：

![image-20230121123533892](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230121123533892.png?raw=true)

可以看到整体的识别效果是比较差的，不像官方示例展示得那么优秀。

## Recognize Text in Regions of Interest (ROI)

另一种识别是用户用方框标记出识别的矩形范围（即Regions of Interest，ROI），使用`ocr`函数进行局部识别。这种方式的关键点是使用[`drawrectangle`函数](https://ww2.mathworks.cn/help/images/ref/drawrectangle.html)绘制出ROI：

注：`ocr`函数的官方文档中提到了这种使用方式：[ocr: Recognize Text in Regions of Interest (ROI)](https://ww2.mathworks.cn/help/vision/ref/ocr.html#bt79suo)，但是使用的是语句`roi = round(getPosition(imrect))`。[`imrect`函数](https://ww2.mathworks.cn/help/images/ref/imrect.html)，[`getPosition`函数](https://ww2.mathworks.cn/help/images/ref/imroi.getposition.html)和这里所使用的的`drawrectangle`函数都来自MATLAB Image Processing Toolbox，并且两种方法都能够实现ROI的获取，但是在2022a版本的MATLAB中，前两个函数都是Not recommended的状态。
{: .notice--warning}

```matlab
clc, clear, close all

% Read image
image = imread("before_sunrise.png");

% Implement OCR in Regions of Interest (ROI)
imshow(image)
roi = drawrectangle;
ocrResults = ocr(image, roi.Position);

% Diplay Bounding Boxes of Words and Recognition Confidences
Iocr = insertObjectAnnotation(image, "rectangle", ...
    ocrResults.WordBoundingBoxes, ...
    ocrResults.WordConfidences);
imshow(Iocr);
```

选中图片中的英文台词进行识别，结果为：

```matlab
>> ocrResults.Text
ans =
    'Baby, let's forget about this pride
     
     '
```

![image-20230121151028239](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230121151028239.png?raw=true)

图片中整个中英文台词进行识别，结果为：

```matlab
>> ocrResults.Text
ans =
    '$51 iJ:¥ﬁ1I".|E\iE.'RE§T'E
     
     Baby, let's forget about this pride
     
     '
```

![image-20230121151142973](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230121151142973.png?raw=true)

可以看到，`ocr`函数本身是不支持识别中文的，但是可以安装相关的语言包，具体可以参考文档：[ocr: Language](https://ww2.mathworks.cn/help/vision/ref/ocr.html#bu76sfz)，[Install OCR Language Data Files Packages](https://ww2.mathworks.cn/help/vision/ug/ocr-language-data-files.html).

<br>

# Call Baidu Cloud OCR API in MATLAB

## Rocognize Text Within an Image

除了是用MATLAB提供的`ocr`函数外，用户还可以在MATLAB中调用外部API。在博客后面的部分，我参考博客[MATLAB如何调用百度云文字识别API-肆拾伍的博客](https://blog.csdn.net/qq_43157190/article/details/103554864)（后简称参考博客）创建并调用了百度云文字识别API。

首先按照参考博客的步骤在百度云中创建一个文字识别应用：

![image-20230121152713018](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230121152713018.png?raw=true)

记录下`API Key`和`Secret Key`（相当于账户和密码）。

之后参照文档[通用参考：鉴权认证机制 - 百度AI开放平台](https://ai.baidu.com/ai-doc/REFERENCE/Ck3dwjhhu)获得对应的Access Token。这里采用的是参考博客中的做法，在MATLAB中使用`webread`函数获取：

```matlab
% Obtain access token
api_key = '*****************';
secret_key = '*****************';
url_token = ['https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=', api_key, '&client_secret=', secret_key];
token = webread(url_token);
token = token.access_token;
```

百度云的API文档（[文字识别OCR：调用方式](https://cloud.baidu.com/doc/OCR/s/Ck3h7y2ia)）说明图片经过`base64`编码和`urlencode`后传入：

![image-20230121153429604](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230121153429604.png?raw=true)

在将图片转换为`base64`编码时可以使用MATLAB File Exchange中Katz写的[`base64file`函数](https://ww2.mathworks.cn/matlabcentral/fileexchange/24514-base64-image-encoder?s_tid=srchtitle_base64file_4)：

```matlab
function base64string = base64file(file)
%BASE64FILE encode a file in base64
%
% base64 = base64file(filename) returns the file's contents as a
%  base64-encoded string
%
% This file uses the base64 encoder from the Apache Commons Codec, 
% http://commons.apache.org/codec/ and distrubed with MATLAB under the
% Apache License http://commons.apache.org/license.html

% Copyright 2009 The MathWorks, Inc.

fid = fopen(file,'rb');
bytes = fread(fid);
fclose(fid);
encoder = org.apache.commons.codec.binary.Base64;
base64string = char(encoder.encode(bytes))';
```

脚本文件中读取图片文件并转换编码：

```matlab
% Read image and convert it to base64 code
filname = fullfile(pwd, "before_sunrise.png");
base64string = base64file(filname);
```

此时代表图片信息的`base64string`就是一个`char`数据类型：

![image-20230121154306074](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230121154306074.png?raw=true)

然后使用[`webwrite`函数](https://ww2.mathworks.cn/help/matlab/ref/webwrite.html)将post到指定网站：

```matlab
% Post via API
webb = ['https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic?access_token=' token];
ocrResults = webwrite(webb, 'image', base64string, ...
    'Content-Type', 'application/x-www-form-urlencoded');
```

此时，变量`orcResults`就是从web service上返回的response：

```matlab
>> ocrResults
ocrResults = 
  struct with fields:
        words_result: [3×1 struct]
    words_result_num: 3
              log_id: 1.6167e+18
```

其中`words_result`字段就是文字识别的结果：

```
>> ocrResults.words_result.words
ans =
    'bibii'
ans =
    '宝贝让我们忘记虚荣'
ans =
    'Baby,let's forget about this pride'
```

结果是比较准确的，并且可以识别中文。

> 但实际上中间还遇到了一些问题。第一次使用的时候是无法返回识别信息的，返回的response是：
>
> ```matlab
> ocrResults = 
>   struct with fields:
>     error_code: 18
>      error_msg: 'Open api qps request limit reached'
> ```
>
> 错误码信息可以在百度云的官方文档中查到：[文字识别OCR：错误码 ](https://ai.baidu.com/ai-doc/OCR/dk3h7y5vr)，错误码`18`代表并发限制超过免费额度：
>
> ![image-20230121155213056](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230121155213056.png?raw=true)
>
> 但实际上哪怕是百度云所提供的免费额度也是需要开通的（见博客：[百度OCR API识别失败：Open api qps request limit reached 错误也许在这-小风alter的博客](https://blog.csdn.net/weixin_44298740/article/details/117560495)），我们可以在百度云的控制台看到领取的额度信息：
>
> ![image-20230121120853848](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230121120853848.png?raw=true)

这部分完整代码如下：

```matlab
% Obtain access token
api_key = '*****************';
secret_key = '*****************';
url_token = ['https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=', api_key, '&client_secret=', secret_key];
token = webread(url_token);
token = token.access_token;

% Read image and convert it to base64 code
filname = fullfile(pwd, "before_sunrise.png");
base64string = base64file(filname);

% Post via API
webb = ['https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic?access_token=' token];
ocrResults = webwrite(webb, 'image', base64string, ...
    'Content-Type', 'application/x-www-form-urlencoded');
ocrResults.words_result.words
```

## Recognize Text in ROI

在之前使用`ocr`函数时，我们使用`drawrectagle`函数创建了一个[`Rectangle`对象](https://ww2.mathworks.cn/help/images/ref/images.roi.rectangle.html)，之后将`Rectangle`的`Position`参数传入到`roc`函数中以指定ROI。但实际上，`Rectangle`对象中并不包含区域的图像信息，即类似于表征图像RGB的`double`数组。

例如，执行下面的代码：

```matlab
image = imread("before_sunrise.png");
img = imshow(image);
roi = drawrectangle;
```

```matlab
img = 
  Image with properties:
           CData: [1079×1920×3 uint8]
    CDataMapping: 'direct'

  Show all properties
```

拉取矩形区域后：

```matlab
roi = 
            AspectRatio: 0.1904
               Children: [0×0 GraphicsPlaceholder]
                  Color: [0 0.4470 0.7410]
            ContextMenu: [1×1 ContextMenu]
              Deletable: 1
            DrawingArea: 'auto'
              EdgeAlpha: 1
              FaceAlpha: 0.2000
         FaceSelectable: 1
       FixedAspectRatio: 0
       HandleVisibility: 'on'
    InteractionsAllowed: 'all'
                  Label: ''
             LabelAlpha: 1
         LabelTextColor: [0 0 0]
           LabelVisible: 'on'
              LineWidth: 2.2500
             MarkerSize: 6
                 Parent: [1×1 Axes]
               Position: [631.2500 941.2500 … ]
              Rotatable: 0
          RotationAngle: 0
               Selected: 0
          SelectedColor: 'none'
            StripeColor: 'none'
                    Tag: ''
                   Type: 'images.roi.rectangle'
               UserData: []
               Vertices: [4×2 double]
                Visible: on
```

可以看到，变量`roi`中并包含类似变量`img`中`CData`的字段。

因此，获取ROI区域图像信息的操作（类似于图像的“与”操作）应该是在`ocr`函数内部进行的。但是，当我们调用外部API进行文字识别时，并不能使用`ocr`函数，也就不能利用其便利性。

一种实现的方式是：

- 使用鼠标拉取ROI区域并进行截图：MATLAB本身并不提供这样的函数，需要使用Java的一些函数和功能（参考：[Matlab如何实现截屏与屏幕录制 - 知乎](https://zhuanlan.zhihu.com/p/28724241)）

- 将截图保存为一个暂时的图像文件，获得它的`base64`编码后再将其删除。这一步了参考上文Katz在为[`base64file`函数](https://ww2.mathworks.cn/matlabcentral/fileexchange/24514-base64-image-encoder?s_tid=srchtitle_base64file_4)提供的使用示例：

  ![image-20230121173822788](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230121173822788.png?raw=true)

- 将图像的`base64`编码post到web server中，获取response，并提取识别结果

这其中比较复杂的部分就是截图ROI的实现，之前我并没有遇到过相关的需求，也没有编写过相关代码。因此，这部分的功能实现就先搁置在这里，等有所需要时再进一步研究。

<br>

**References**

[1] [MATLAB如何调用百度云文字识别API-肆拾伍的博客](https://blog.csdn.net/qq_43157190/article/details/103554864)

[2] [`base64file` - MATLAB File Exchange](https://ww2.mathworks.cn/matlabcentral/fileexchange/24514-base64-image-encoder?s_tid=srchtitle_base64file_4).
