---
layout: single
title: Word Cloud in MATLAB
date: 2022-10-02 11:03:17 +0800
categories: 
 - Programming
 - Machine Learning
tags:
 - MATLAB
 - MATLAB Text Analytics Toobox
 - MATLAB Graphics
---

# Example 1: Visualize Text Data Using Word Clouds

本示例来自：[Visualize Text Data Using Word Clouds - MathWorks](https://ww2.mathworks.cn/help/textanalytics/ug/visualize-text-data-using-word-clouds.html)，展示了从.csv文件中读取文本数据并创建词云的过程。

首先读取.csv文件：

```matlab
filename = "factoryReports.csv";
tbl = readtable(filename, 'TextType', 'string');
```

table变量`tbl`的结构和内容如下所示：

![image-20221002093538628](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221002093538628.png)

本示例主要是根据各种条件创建`tbl.Description`列的词云：

```matlab
textData = tbl.Description;
```

（1）直接创建`tbl.Description`列的词云：

```matlab
figure
wordcloud(textData);
title("Factory Reports")
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/pic1.jpg" alt="pic1" style="zoom:67%;" />

（2）根据`tbl.Category`列的标签分别对`tbl.Description`列创建词云：

```matlab
figure
labels = tbl.Category;

subplot(1,2,1)
idx = labels == "Leak";
wordcloud(textData(idx), 'Color', 'blue');
title("Leak")

subplot(1,2,2)
idx = labels == "Mechanical Failure";
wordcloud(textData(idx), 'Color', 'magenta');
title("Mechanical Failure")
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/pic2.jpg" alt="pic2" style="zoom:67%;" />

在这里，设置了`wordcloud`函数的`Color`属性设置出现频次较少的单词的颜色，如果想要设置出现频次较多的单词的颜色，需要设置`wordcloud`函数的`HighlightColor`属性看，例如：

```matlab
figure
tiledlayout(1,2)

nexttile
wordcloud(textData(idx), 'HighlightColor', 'blue');
title("Cost > $100")
idx = cost > 1000;

nexttile
wordcloud(textData(idx), 'HighlightColor', 'red');
title("Cost > $1,000")
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/pic3.jpg" alt="pic3" style="zoom:67%;" />

（3）`WordCloudChart`属性

`wordcloud`函数可以返回`WordCloudChart`对象：

```matlab
figure
wc = wordcloud(textData);
title("Factory Reports")
```

```matlab
wc = 

  WordCloudChart (Factory Reports) with properties:

           WordData: [1×315 string]
           SizeData: [1×315 double]
    MaxDisplayWords: 100

  Show all properties

                   Box: off
                 Color: [1×3 double]
              FontName: 'Helvetica'
      HandleVisibility: 'on'
        HighlightColor: [1×3 double]
         InnerPosition: [1×4 double]
                Layout: [0×0 matlab.ui.layout.LayoutOptions]
             LayoutNum: 1
       MaxDisplayWords: 100
         OuterPosition: [1×4 double]
                Parent: [1×1 Figure]
              Position: [1×4 double]
    PositionConstraint: 'outerposition'
                 Shape: 'oval'
              SizeData: [1×315 double]
             SizePower: 0.5000
          SizeVariable: ''
           SourceTable: [0×0 table]
                 Title: 'Factory Reports'
         TitleFontName: 'Helvetica'
                 Units: 'normalized'
               Visible: on
              WordData: [1×315 string]
          WordVariable: ''
```

可以通过`.`语法设置属性，如：

```matlab
figure
wc = wordcloud(textData);
wc.MaxDisplayWords = 3;
title("Factory Reports")
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/pic4.jpg" alt="pic4" style="zoom: 67%;" />

<br>

# Example 2: Create Word Cloud With String Arrays

本示例来自：[Create Word Cloud With String Arrays - MathWorks](https://ww2.mathworks.cn/help/matlab/creating_plots/create-word-cloud-with-string-arrays.html)，展示的是从.txt文件提取文本数据并创建词云的过程，包含了一些最基本的文本数据处理步骤。

`sonnets.txt`文件中保存的是莎士比亚的十四行诗：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221002104149524.png" alt="image-20221002104149524" style="zoom:67%;" />

首先，使用`fileread`函数读取`sonnets.txt`文件：

```matlab
sonnets = fileread('sonnets.txt');
```

```matlab
>> whos sonnets
  Name         Size                 Bytes  Class    Attributes

  sonnets      1x100266            200532  char
```

之后，将`sonnets`转换为`string`数据类型：

```matlab
sonnets = string(sonnets);
```

```matlab
>> whos sonnets
  Name         Size             Bytes  Class     Attributes

  sonnets      1x1             200678  string
```

此时的`sonnets`变量中包含很多的换行符：

![image-20221002104921134](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221002104921134.png)

使用`splitlines`函数将其分行：

```matlab
sonnets = splitlines(sonnets);
```

```matlab
>> whos sonnets
  Name            Size             Bytes  Class     Attributes
  sonnets      2625x1             320806  string
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221002105229472.png" alt="image-20221002105229472" style="zoom:67%;" />

之后，将一些标点符号替换为空格：

```matlab
p = ["." "?" "!" "," ";" ":"];
sonnets = replace(sonnets, p, " ");
```

然后，将`sonnets`分割成string array，其中的每一个元素都是individual words：

```matlab
sonnets = join(sonnets);
sonnets = split(sonnets);
```

```matlab
>> whos sonnets
  Name             Size             Bytes  Class     Attributes

  sonnets      17712x1             976416  string
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221002105732324.png" alt="image-20221002105732324" style="zoom:67%;" />

移除掉字母小于5个的单词：

```matlab
sonnets(strlength(sonnets) < 5) = [];
```

最后，将`sonnets`转换为categorical array，并绘制词云：

```matlab
C = categorical(sonnets);
figure
wordcloud(C);
title("Sonnets Word Cloud")
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/pic.jpg" alt="pic" style="zoom:67%;" />

<br>

**Reference**

[1] [Visualize Text Data Using Word Clouds - MathWorks](https://ww2.mathworks.cn/help/textanalytics/ug/visualize-text-data-using-word-clouds.html).

[2] [Create Word Cloud With String Arrays - MathWorks](https://ww2.mathworks.cn/help/matlab/creating_plots/create-word-cloud-with-string-arrays.html).

[3] [wordcloud - MathWorks](https://ww2.mathworks.cn/help/textanalytics/ref/ldamodel.wordcloud.html).



