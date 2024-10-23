---
title: Color Palettes in R Package `ggsci`
categories: 
 - Design
 - R
 - MATLAB
tags:
 - MATLAB Graphics
date: 2023-01-10 20:17:19 +0800
last_modified_at: 2024-09-06 08:05:56 +0800
---

# Introduction

前两天找论文图像配色的时候发现了R语言的一个配色包`ggsci`[^1][^2]，这个包通过总结一些著名期刊的论文插图配色，设置了几个palettes。

官网中给出了获取palette中色彩RGB值的方式，在安装了R语言和RStudio后，输入指定的代码即可。

<div class="notice--primary" markdown="1">

**R语言安装包时常用的代码**

（1）安装指定包，如安装`ggssci`

```R
install.packages("ggsci")
```

（2） 查看已经安装的包

```R
as.data.frame(installed.packages())$Package
```

本博客就记录一下`ggsci`中所包含palettes的RGB值。

</div>

<br>

#  NPG (Nature Publishing Group)

The NPG palette is inspired by the plots in the journals published by *Nature Publishing Group*: 

```R
library("ggsci")

mypal <- pal_npg("nrc", alpha = 1)(10)
mypal
# [1] "#E64B35FF" "#4DBBD5FF" "#00A087FF" "#3C5488FF" "#F39B7FFF" "#8491B4FF" "#91D1C2FF" "#DC0000FF" "#7E6148FF" "#B09C85FF"

library("scales")
show_col(mypal)
```

![image-20230107180738968](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107180738968.png?raw=true)

虽然我之前没有接触过R语言，R语言及其IDE都是刚刚安装的，但是上面这部分代码还是比较好理解的。主要介绍一下代码：

```R
mypal <- pal_npg("nrc", alpha = 1)(10)
```

其中：

（1）`pal_npg`，指定了使用NPG palette

（2）`"nrc"`，这个属性指定了palette type，不同的palette的type选项是不同的，对于NPG而言，只有`"nrc"`这一个选项。具体的`type`属性可以在官方网站[^1]中查看

![image-20230110135137608](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110135137608.png?raw=true)

（3）`alpha`参数取值范围为$(0,1]$，`alpha = 1`表示颜色的透明度为opaque，即不透明。上面我们得到的颜色一共有十六进制数，前六位对应RGB tuple，后两位就对应着透明度。如果我们将透明度设置为0.6，则有：

```R
library("ggsci")

mypal <- pal_npg("nrc", alpha = 0.6)(10)
mypal

library("scales")
show_col(mypal)
```

![image-20230110145226108](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110145226108.png?raw=true)

我们也很容易推出，颜色透明度的调节也是离散的，间隔为$1/255$。**在下文中，我们均只展示opaque的颜色**。

（4）`pal_npg`函数后面的`(10)`表示展示palette中颜色的数量。`"nrc"`类型的NPG只有10种颜色，如果设置超过10，如设置：

```R
mypal <- pal_npg("nrc", alpha = 0)(12)
```

则会报warning：

```
Warning message:
This manual palette can handle a maximum of 10 values. You have supplied 12. 
```

通过这种方式得到palette的RGB数组后，我们就可以很方便地将其应用到其他地方。

但是，MATLAB中的函数大多数是不接受以十六进制表示的RGB值，因此我们可以借助MATLAB File Exchange 中Chad Greene提供的函数[^3]将十六进制转换为RGB三元数组，并且采用官方文档常用的可视化`peaks`函数的方式可视化palette：

```matlab
clc, clear, close all

mypal = ["E64B35"; "4DBBD5"; "00A087";
    "3C5488"; "F39B7F"; "8491B4";
    "91D1C2"; "DC0000"; "7E6148"; "B09C85"];

mypal = arrayfun(@(x)hex2rgb(x), mypal, 'UniformOutput', false);
mypal = cat(1, mypal{:});

figure
axes
surf(peaks(37))
colormap(mypal)
colorbar
```

```
mypal =
    0.9020    0.2941    0.2078
    0.3020    0.7333    0.8353
         0    0.6275    0.5294
    0.2353    0.3294    0.5333
    0.9529    0.6078    0.4980
    0.5176    0.5686    0.7059
    0.5686    0.8196    0.7608
    0.8627         0         0
    0.4941    0.3804    0.2824
    0.6902    0.6118    0.5216
```

![image-20230108111241527](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230108111241527.png?raw=true)

本部分的讨论适用于下文所有的palette，完全一致。

<br>

# AAAS (American Association for the Advancement of Science)

The AAAS palette is inspired by the plots in the journals published by *American Association for the Advancement of Science*:

```R
library("ggsci")

mypal <- pal_aaas("default", alpha = 1)(10)
mypal
# [1] "#3B4992FF" "#EE0000FF" "#008B45FF" "#631879FF" "#008280FF" "#BB0021FF" "#5F559BFF" "#A20056FF" "#808180FF" "#1B1919FF"

library("scales")
show_col(mypal)
```

![image-20230107180916214](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107180916214.png?raw=true)

```
mypal =
    0.2314    0.2863    0.5725
    0.9333         0         0
         0    0.5451    0.2706
    0.3882    0.0941    0.4745
         0    0.5098    0.5020
    0.7333         0    0.1294
    0.3725    0.3333    0.6078
    0.6353         0    0.3373
    0.5020    0.5059    0.5020
    0.1059    0.0980    0.0980
```

![image-20230110151759410](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110151759410.png?raw=true)

<br>

# NEJM (The New England Journal of Medicine)

The NEJM palette is inspired by the plots in *The New England Journal of Medicine*:

```R
library("ggsci")

mypal <- pal_nejm("default", alpha = 1)(8)
mypal
# [1] "#BC3C29FF" "#0072B5FF" "#E18727FF" "#20854EFF" "#7876B1FF" "#6F99ADFF" "#FFDC91FF" "#EE4C97FF"

library("scales")
show_col(mypal)
```

![image-20230107181053174](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107181053174.png?raw=true)

```
mypal =
    0.7373    0.2353    0.1608
         0    0.4471    0.7098
    0.8824    0.5294    0.1529
    0.1255    0.5216    0.3059
    0.4706    0.4627    0.6941
    0.4353    0.6000    0.6784
    1.0000    0.8627    0.5686
    0.9333    0.2980    0.5922
```

![image-20230110152021105](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110152021105.png?raw=true)

<br>

# Lancet (Lancet journals)

The Lancet palette is inspired by the plots in *Lancet journals*, such as *Lancet Oncology*:

```R
library("ggsci")

mypal <- pal_lancet("lanonc", alpha = 1)(9)
mypal
# [1] "#00468BFF" "#ED0000FF" "#42B540FF" "#0099B4FF" "#925E9FFF" "#FDAF91FF" "#AD002AFF" "#ADB6B6FF" "#1B1919FF"

library("scales")
show_col(mypal)
```

![image-20230107181307592](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107181307592.png?raw=true)

```
mypal =
         0    0.2745    0.5451
    0.9294         0         0
    0.2588    0.7098    0.2510
         0    0.6000    0.7059
    0.5725    0.3686    0.6235
    0.9922    0.6863    0.5686
    0.6784         0    0.1647
    0.6784    0.7137    0.7137
    0.1059    0.0980    0.0980
```

![image-20230108110610029](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230108110610029.png?raw=true)

# JAMA (The Journal of the American Medical Association)

The JAMA palette is inspired by the plots in *The Journal of the American Medical Association*:

```R
library("ggsci")

mypal <- pal_jama("default", alpha = 1)(7)
mypal
# [1] "#374E55FF" "#DF8F44FF" "#00A1D5FF" "#B24745FF" "#79AF97FF" "#6A6599FF" "#80796BFF"

library("scales")
show_col(mypal)
```

![image-20230107181635587](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107181635587.png?raw=true)

```
mypal =
    0.2157    0.3059    0.3333
    0.8745    0.5608    0.2667
         0    0.6314    0.8353
    0.6980    0.2784    0.2706
    0.4745    0.6863    0.5922
    0.4157    0.3961    0.6000
    0.5020    0.4745    0.4196
```

![image-20230108110315852](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230108110315852.png?raw=true)

<br>

# JCO (Journal of Clinical Oncology)

The JCO palette is inspired by the the plots in *Journal of Clinical Oncology*:

```R
library("ggsci")

mypal <- pal_jco("default", alpha = 1)(10)
mypal
# [1] "#0073C2FF" "#EFC000FF" "#868686FF" "#CD534CFF" "#7AA6DCFF" "#003C67FF" "#8F7700FF" "#3B3B3BFF" "#A73030FF" "#4A6990FF"

library("scales")
show_col(mypal)
```

![image-20230107181737598](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107181737598.png?raw=true)

```
mypal =
         0    0.4510    0.7608
    0.9373    0.7529         0
    0.5255    0.5255    0.5255
    0.8039    0.3255    0.2980
    0.4784    0.6510    0.8627
         0    0.2353    0.4039
    0.5608    0.4667         0
    0.2314    0.2314    0.2314
    0.6549    0.1882    0.1882
    0.2902    0.4118    0.5647
```

![image-20230110152417412](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110152417412.png?raw=true)

<br>

# UCSCGB (UCSC Genome Browser)

The UCSCGB palette is from the colors used by [UCSC Genome Browser](https://genome.ucsc.edu/) for representing chromosomes. This palette (interpolated, with alpha) is intensively used in visualizations generated by Circos.

```R
library("ggsci")

mypal <- pal_ucscgb("default", alpha = 1)(26)
mypal
# [1] "#FF0000FF" "#FF9900FF" "#FFCC00FF" "#00FF00FF" "#6699FFFF" "#CC33FFFF" "#99991EFF" "#999999FF" "#FF00CCFF" "#CC0000FF" "#FFCCCCFF"
# [12] "#FFFF00FF" "#CCFF00FF" "#358000FF" "#0000CCFF" "#99CCFFFF" "#00FFFFFF" "#CCFFFFFF" "#9900CCFF" "#CC99FFFF" "#996600FF" "#666600FF"
# [23] "#666666FF" "#CCCCCCFF" "#79CC3DFF" "#CCCC99FF"

library("scales")
show_col(mypal)
```

![image-20230107181932500](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107181932500.png?raw=true)

```
mypal =
    1.0000         0         0
    1.0000    0.6000         0
    1.0000    0.8000         0
         0    1.0000         0
    0.4000    0.6000    1.0000
    0.8000    0.2000    1.0000
    0.6000    0.6000    0.1176
    0.6000    0.6000    0.6000
    1.0000         0    0.8000
    0.8000         0         0
    1.0000    0.8000    0.8000
    1.0000    1.0000         0
    0.8000    1.0000         0
    0.2078    0.5020         0
         0         0    0.8000
    0.6000    0.8000    1.0000
         0    1.0000    1.0000
    0.8000    1.0000    1.0000
    0.6000         0    0.8000
    0.8000    0.6000    1.0000
    0.6000    0.4000         0
    0.4000    0.4000         0
    0.4000    0.4000    0.4000
    0.8000    0.8000    0.8000
    0.4745    0.8000    0.2392
    0.8000    0.8000    0.6000
```

![image-20230110153321481](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110153321481.png?raw=true)

<br>

# D3 (D3.js)

The D3 palette is from the categorical colors used by [D3.js](https://d3js.org/) (version 3.x and before). There are four palette types (`category10`, `category20`, `category20b`, `category20c`) available.

## `category10`

```R
library("ggsci")

mypal <- pal_d3("category10", alpha = 1)(10)
mypal
# [1] "#1F77B4FF" "#FF7F0EFF" "#2CA02CFF" "#D62728FF" "#9467BDFF" "#8C564BFF" "#E377C2FF" "#7F7F7FFF" "#BCBD22FF" "#17BECFFF"

library("scales")
show_col(mypal)
```

![image-20230107182033100](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107182033100.png?raw=true)

```
mypal =
    0.1216    0.4667    0.7059
    1.0000    0.4980    0.0549
    0.1725    0.6275    0.1725
    0.8392    0.1529    0.1569
    0.5804    0.4039    0.7412
    0.5490    0.3373    0.2941
    0.8902    0.4667    0.7608
    0.4980    0.4980    0.4980
    0.7373    0.7412    0.1333
    0.0902    0.7451    0.8118
```

![image-20230110153537200](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110153537200.png?raw=true)

## `category20`

```R
library("ggsci")

mypal <- pal_d3("category20", alpha = 1)(20)
mypal
# [1] "#1F77B4FF" "#FF7F0EFF" "#2CA02CFF" "#D62728FF" "#9467BDFF" "#8C564BFF" "#E377C2FF" "#7F7F7FFF" "#BCBD22FF" "#17BECFFF" "#AEC7E8FF"
# [12] "#FFBB78FF" "#98DF8AFF" "#FF9896FF" "#C5B0D5FF" "#C49C94FF" "#F7B6D2FF" "#C7C7C7FF" "#DBDB8DFF" "#9EDAE5FF"

library("scales")
show_col(mypal)
```

![image-20230107182230369](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107182230369.png?raw=true)

```
mypal =
    0.1216    0.4667    0.7059
    1.0000    0.4980    0.0549
    0.1725    0.6275    0.1725
    0.8392    0.1529    0.1569
    0.5804    0.4039    0.7412
    0.5490    0.3373    0.2941
    0.8902    0.4667    0.7608
    0.4980    0.4980    0.4980
    0.7373    0.7412    0.1333
    0.0902    0.7451    0.8118
    0.6824    0.7804    0.9098
    1.0000    0.7333    0.4706
    0.5961    0.8745    0.5412
    1.0000    0.5961    0.5882
    0.7725    0.6902    0.8353
    0.7686    0.6118    0.5804
    0.9686    0.7137    0.8235
    0.7804    0.7804    0.7804
    0.8588    0.8588    0.5529
    0.6196    0.8549    0.8980
```

![image-20230110153724238](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110153724238.png?raw=true)

## `category20b`

```R
library("ggsci")

mypal <- pal_d3("category20b", alpha = 1)(20)
mypal
# [1] "#393B79FF" "#637939FF" "#8C6D31FF" "#843C39FF" "#7B4173FF" "#5254A3FF" "#8CA252FF" "#BD9E39FF" "#AD494AFF" "#A55194FF" "#6B6ECFFF"
# [12] "#B5CF6BFF" "#E7BA52FF" "#D6616BFF" "#CE6DBDFF" "#9C9EDEFF" "#CEDB9CFF" "#E7CB94FF" "#E7969CFF" "#DE9ED6FF"

library("scales")
show_col(mypal)
```

![image-20230107182319305](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107182319305.png?raw=true)

```
mypal =
    0.2235    0.2314    0.4745
    0.3882    0.4745    0.2235
    0.5490    0.4275    0.1922
    0.5176    0.2353    0.2235
    0.4824    0.2549    0.4510
    0.3216    0.3294    0.6392
    0.5490    0.6353    0.3216
    0.7412    0.6196    0.2235
    0.6784    0.2863    0.2902
    0.6471    0.3176    0.5804
    0.4196    0.4314    0.8118
    0.7098    0.8118    0.4196
    0.9059    0.7294    0.3216
    0.8392    0.3804    0.4196
    0.8078    0.4275    0.7412
    0.6118    0.6196    0.8706
    0.8078    0.8588    0.6118
    0.9059    0.7961    0.5804
    0.9059    0.5882    0.6118
    0.8706    0.6196    0.8392
```

![image-20230110154116265](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110154116265.png?raw=true)

## `category20c`

```R
library("ggsci")

mypal <- pal_d3("category20c", alpha = 1)(20)
mypal
# [1] "#3182BDFF" "#E6550DFF" "#31A354FF" "#756BB1FF" "#636363FF" "#6BAED6FF" "#FD8D3CFF" "#74C476FF" "#9E9AC8FF" "#969696FF" "#9ECAE1FF"
# [12] "#FDAE6BFF" "#A1D99BFF" "#BCBDDCFF" "#BDBDBDFF" "#C6DBEFFF" "#FDD0A2FF" "#C7E9C0FF" "#DADAEBFF" "#D9D9D9FF"

library("scales")
show_col(mypal)
```

![image-20230107182402054](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107182402054.png?raw=true)

```
mypal =
    0.1922    0.5098    0.7412
    0.9020    0.3333    0.0510
    0.1922    0.6392    0.3294
    0.4588    0.4196    0.6941
    0.3882    0.3882    0.3882
    0.4196    0.6824    0.8392
    0.9922    0.5529    0.2353
    0.4549    0.7686    0.4627
    0.6196    0.6039    0.7843
    0.5882    0.5882    0.5882
    0.6196    0.7922    0.8824
    0.9922    0.6824    0.4196
    0.6314    0.8510    0.6078
    0.7373    0.7412    0.8627
    0.7412    0.7412    0.7412
    0.7765    0.8588    0.9373
    0.9922    0.8157    0.6353
    0.7804    0.9137    0.7529
    0.8549    0.8549    0.9216
    0.8510    0.8510    0.8510
```

![image-20230110154327190](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110154327190.png?raw=true)

<br>

# Locuszoom

The LocusZoom palette is based on the colors used by [LocusZoom](http://locuszoom.org/)：

LocusZoom是用于可视化全基因组关联分析（Genome wide association study，GWAS）的工具。
{: .notice--primary}

```R
library("ggsci")

mypal <- pal_locuszoom("default", alpha = 1)(7)
mypal
# [1] "#D43F3AFF" "#EEA236FF" "#5CB85CFF" "#46B8DAFF" "#357EBDFF" "#9632B8FF" "#B8B8B8FF"

library("scales")
show_col(mypal)
```

![image-20230107182638917](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107182638917.png?raw=true)

```
mypal =
    0.8314    0.2471    0.2275
    0.9333    0.6353    0.2118
    0.3608    0.7216    0.3608
    0.2745    0.7216    0.8549
    0.2078    0.4941    0.7412
    0.5882    0.1961    0.7216
    0.7216    0.7216    0.7216
```

![image-20230110154518836](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110154518836.png?raw=true)

<br>

# IGV (Integrative Genomics Viewer)

The IGV palette is from the colors used by [Integrative Genomics Viewer](http://software.broadinstitute.org/software/igv/) for representing chromosomes. There are two palette types (`default`, `alternating`) available.

## `default`

```R
library("ggsci")

mypal <- pal_igv("default", alpha = 1)(51)
mypal
# [1] "#5050FFFF" "#CE3D32FF" "#749B58FF" "#F0E685FF" "#466983FF" "#BA6338FF"
# [7] "#5DB1DDFF" "#802268FF" "#6BD76BFF" "#D595A7FF" "#924822FF" "#837B8DFF"
# [13] "#C75127FF" "#D58F5CFF" "#7A65A5FF" "#E4AF69FF" "#3B1B53FF" "#CDDEB7FF"
# [19] "#612A79FF" "#AE1F63FF" "#E7C76FFF" "#5A655EFF" "#CC9900FF" "#99CC00FF"
# [25] "#A9A9A9FF" "#CC9900FF" "#99CC00FF" "#33CC00FF" "#00CC33FF" "#00CC99FF"
# [31] "#0099CCFF" "#0A47FFFF" "#4775FFFF" "#FFC20AFF" "#FFD147FF" "#990033FF"
# [37] "#991A00FF" "#996600FF" "#809900FF" "#339900FF" "#00991AFF" "#009966FF"
# [43] "#008099FF" "#003399FF" "#1A0099FF" "#660099FF" "#990080FF" "#D60047FF"
# [49] "#FF1463FF" "#00D68FFF" "#14FFB1FF"

library("scales")
show_col(mypal)
```

![image-20230107182814332](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107182814332.png?raw=true)

```
mypal =

    0.3137    0.3137    1.0000
    0.8078    0.2392    0.1961
    0.4549    0.6078    0.3451
    0.9412    0.9020    0.5216
    0.2745    0.4118    0.5137
    0.7294    0.3882    0.2196
    0.3647    0.6941    0.8667
    0.5020    0.1333    0.4078
    0.4196    0.8431    0.4196
    0.8353    0.5843    0.6549
    0.5725    0.2824    0.1333
    0.5137    0.4824    0.5529
    0.7804    0.3176    0.1529
    0.8353    0.5608    0.3608
    0.4784    0.3961    0.6471
    0.8941    0.6863    0.4118
    0.2314    0.1059    0.3255
    0.8039    0.8706    0.7176
    0.3804    0.1647    0.4745
    0.6824    0.1216    0.3882
    0.9059    0.7804    0.4353
    0.3529    0.3961    0.3686
    0.8000    0.6000         0
    0.6000    0.8000         0
    0.6627    0.6627    0.6627
    0.8000    0.6000         0
    0.6000    0.8000         0
    0.2000    0.8000         0
         0    0.8000    0.2000
         0    0.8000    0.6000
         0    0.6000    0.8000
    0.0392    0.2784    1.0000
    0.2784    0.4588    1.0000
    1.0000    0.7608    0.0392
    1.0000    0.8196    0.2784
    0.6000         0    0.2000
    0.6000    0.1020         0
    0.6000    0.4000         0
    0.5020    0.6000         0
    0.2000    0.6000         0
         0    0.6000    0.1020
         0    0.6000    0.4000
         0    0.5020    0.6000
         0    0.2000    0.6000
    0.1020         0    0.6000
    0.4000         0    0.6000
    0.6000         0    0.5020
    0.8392         0    0.2784
    1.0000    0.0784    0.3882
         0    0.8392    0.5608
    0.0784    1.0000    0.6941
```

![image-20230110154732528](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110154732528.png?raw=true)

## `alternating`

```R
library("ggsci")

mypal <- pal_igv("alternating", alpha = 1)(2)
mypal
# [1] "#5773CCFF" "#FFB900FF"

library("scales")
show_col(mypal)
```

![image-20230107183033024](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107183033024.png?raw=true)

```
mypal =
    0.3412    0.4510    0.8000
    1.0000    0.7255         0
```

![image-20230110154851215](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110154851215.png?raw=true)

<br>

# UChicago (The University of Chicago)

The UChicago palette is based on [the colors used by the University of Chicago](https://news.uchicago.edu/sites/default/files/attachments/_uchicago.identity.guidelines.pdf) . There are three palette types (`default`, `light`, `dark`) available.

## `default`

```R
library("ggsci")

mypal <- pal_uchicago("default", alpha = 1)(9)
mypal
# [1] "#800000FF" "#767676FF" "#FFA319FF" "#8A9045FF" "#155F83FF" "#C16622FF" "#8F3931FF" "#58593FFF" "#350E20FF"

library("scales")
show_col(mypal)
```

![image-20230107183425569](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107183425569.png?raw=true)

```
mypal =

    0.5020         0         0
    0.4627    0.4627    0.4627
    1.0000    0.6392    0.0980
    0.5412    0.5647    0.2706
    0.0824    0.3725    0.5137
    0.7569    0.4000    0.1333
    0.5608    0.2235    0.1922
    0.3451    0.3490    0.2471
    0.2078    0.0549    0.1255
```

![image-20230110155118300](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110155118300.png?raw=true)

## `light`

```R
library("ggsci")

mypal <- pal_uchicago("light", alpha = 1)(9)
mypal
# [1] "#800000FF" "#D6D6CEFF" "#FFB547FF" "#ADB17DFF" "#5B8FA8FF" "#D49464FF" "#B1746FFF" "#8A8B79FF" "#725663FF"

library("scales")
show_col(mypal)
```

![image-20230107183513730](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107183513730.png?raw=true)

```
mypal =
    0.5020         0         0
    0.8392    0.8392    0.8078
    1.0000    0.7098    0.2784
    0.6784    0.6941    0.4902
    0.3569    0.5608    0.6588
    0.8314    0.5804    0.3922
    0.6941    0.4549    0.4353
    0.5412    0.5451    0.4745
    0.4471    0.3373    0.3882
```

![image-20230110155313662](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110155313662.png?raw=true)

## `dark`

```R
library("ggsci")

mypal <- pal_uchicago("dark", alpha = 1)(9)
mypal
# [1] "#800000FF" "#767676FF" "#CC8214FF" "#616530FF" "#0F425CFF" "#9A5324FF" "#642822FF" "#3E3E23FF" "#350E20FF"

library("scales")
show_col(mypal)
```

![image-20230107183606275](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107183606275.png?raw=true)

```
mypal =
    0.5020         0         0
    0.4627    0.4627    0.4627
    0.8000    0.5098    0.0784
    0.3804    0.3961    0.1882
    0.0588    0.2588    0.3608
    0.6039    0.3255    0.1412
    0.3922    0.1569    0.1333
    0.2431    0.2431    0.1373
    0.2078    0.0549    0.1255
```

![image-20230110155445325](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110155445325.png?raw=true)

<br>

# Star Trek (Film)

This palette is inspired by the (uniform) colors in *Star Trek*:

```R
library("ggsci")

mypal <- pal_startrek("uniform", alpha = 1)(7)
mypal
# [1] "#CC0C00FF" "#5C88DAFF" "#84BD00FF" "#FFCD00FF" "#7C878EFF" "#00B5E2FF" "#00AF66FF"

library("scales")
show_col(mypal)
```

![image-20230107183719487](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107183719487.png?raw=true)

```
mypal =

    0.8000    0.0471         0
    0.3608    0.5333    0.8549
    0.5176    0.7412         0
    1.0000    0.8039         0
    0.4863    0.5294    0.5569
         0    0.7098    0.8863
         0    0.6863    0.4000
```

![image-20230110155730766](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110155730766.png?raw=true)

<br>

# Tron Legacy (Film)

This palette is inspired by the colors used in *Tron Legacy*. It is suitable for displaying data when using a dark theme:

```R
library("ggsci")

mypal <- pal_tron("legacy", alpha = 1)(7)
mypal
# [1] "#FF410DFF" "#6EE2FFFF" "#F7C530FF" "#95CC5EFF" "#D0DFE6FF" "#F79D1EFF" "#748AA6FF"

library("scales")
show_col(mypal)
```

![image-20230107183834191](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107183834191.png?raw=true)

```
mypal =
    1.0000    0.2549    0.0510
    0.4314    0.8863    1.0000
    0.9686    0.7725    0.1882
    0.5843    0.8000    0.3686
    0.8157    0.8745    0.9020
    0.9686    0.6157    0.1176
    0.4549    0.5412    0.6510
```

![image-20230110164655319](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110164655319.png?raw=true)

<br>

# Futurama (TV show)

This palette is inspired by the colors used in the TV show *Futurama*:

```R
library("ggsci")

mypal <- pal_futurama("planetexpress", alpha = 1)(12)
mypal
# [1] "#FF6F00FF" "#C71000FF" "#008EA0FF" "#8A4198FF" "#5A9599FF" "#FF6348FF" "#84D7E1FF" "#FF95A8FF" "#3D3B25FF"
# [10] "#ADE2D0FF" "#1A5354FF" "#3F4041FF"

library("scales")
show_col(mypal)
```

![image-20230107184811680](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107184811680.png?raw=true)

```
mypal =
    1.0000    0.4353         0
    0.7804    0.0627         0
         0    0.5569    0.6275
    0.5412    0.2549    0.5961
    0.3529    0.5843    0.6000
    1.0000    0.3882    0.2824
    0.5176    0.8431    0.8824
    1.0000    0.5843    0.6588
    0.2392    0.2314    0.1451
    0.6784    0.8863    0.8157
    0.1020    0.3255    0.3294
    0.2471    0.2510    0.2549
```

![image-20230110164836276](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110164836276.png?raw=true)



<br>

# Rick and Morty (TV show)

This palette is inspired by the colors used in the TV show *Rick and Morty*:

```R
library("ggsci")

mypal <- pal_rickandmorty("schwifty", alpha = 1)(12)
mypal
# [1] "#FAFD7CFF" "#82491EFF" "#24325FFF" "#B7E4F9FF" "#FB6467FF" "#526E2DFF" "#E762D7FF" "#E89242FF" "#FAE48BFF"
# [10] "#A6EEE6FF" "#917C5DFF" "#69C8ECFF"

library("scales")
show_col(mypal)
```

![image-20230107184919859](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107184919859.png?raw=true)

```
mypal =
    0.9804    0.9922    0.4863
    0.5098    0.2863    0.1176
    0.1412    0.1961    0.3725
    0.7176    0.8941    0.9765
    0.9843    0.3922    0.4039
    0.3216    0.4314    0.1765
    0.9059    0.3843    0.8431
    0.9098    0.5725    0.2588
    0.9804    0.8941    0.5451
    0.6510    0.9333    0.9020
    0.5686    0.4863    0.3647
    0.4118    0.7843    0.9255
```

![image-20230110165201487](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110165201487.png?raw=true)

<br>

# The Simpsons (TV show)

This palette is inspired by the colors used in the TV show *The Simpsons*:

```R
library("ggsci")

mypal <- pal_simpsons("springfield", alpha = 1)(16)
mypal
# [1] "#FED439FF" "#709AE1FF" "#8A9197FF" "#D2AF81FF" "#FD7446FF" "#D5E4A2FF" "#197EC0FF" "#F05C3BFF" "#46732EFF"
# [10] "#71D0F5FF" "#370335FF" "#075149FF" "#C80813FF" "#91331FFF" "#1A9993FF" "#FD8CC1FF"

library("scales")
show_col(mypal)
```

![image-20230107185041128](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107185041128.png?raw=true)

```
mypal =
    0.9961    0.8314    0.2235
    0.4392    0.6039    0.8824
    0.5412    0.5686    0.5922
    0.8235    0.6863    0.5059
    0.9922    0.4549    0.2745
    0.8353    0.8941    0.6353
    0.0980    0.4941    0.7529
    0.9412    0.3608    0.2314
    0.2745    0.4510    0.1804
    0.4431    0.8157    0.9608
    0.2157    0.0118    0.2078
    0.0275    0.3176    0.2863
    0.7843    0.0314    0.0745
    0.5686    0.2000    0.1216
    0.1020    0.6000    0.5765
    0.9922    0.5490    0.7569
```

![image-20230110165325547](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110165325547.png?raw=true)

<br>

# GSEA(GSEA GenePattern)

The GSEA palette (continuous) is inspired by the heatmaps generated by [GSEA GenePattern](https://software.broadinstitute.org/cancer/software/genepattern/).

```R
library("ggsci")

mypal <- pal_gsea("default", alpha = 1)(12)
mypal
# [1] "#4500ACFF" "#2600D1FF" "#6B58EEFF" "#8787FFFF" "#C6C0FFFF" "#D4D4FFFF" "#FFBFE5FF" "#FF8888FF" "#FF707FFF"
# [10] "#FF5959FF" "#EE3F3FFF" "#D60C00FF"

library("scales")
show_col(mypal)
```

![image-20230107185159554](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107185159554.png?raw=true)

```
mypal =
    0.2706         0    0.6745
    0.1490         0    0.8196
    0.4196    0.3451    0.9333
    0.5294    0.5294    1.0000
    0.7765    0.7529    1.0000
    0.8314    0.8314    1.0000
    1.0000    0.7490    0.8980
    1.0000    0.5333    0.5333
    1.0000    0.4392    0.4980
    1.0000    0.3490    0.3490
    0.9333    0.2471    0.2471
    0.8392    0.0471         0
```

![image-20230110165447161](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110165447161.png?raw=true)

<br>

# Material Design (Google)

The Material Design color palettes are from the Material Design color guidelines[^5].

**Material Design** (codenamed **Quantum Paper**) is a [design language](https://en.wikipedia.org/wiki/Design_language) developed by [Google](https://en.wikipedia.org/wiki/Google) in 2014. Expanding on the "cards" that debuted in [Google Now](https://en.wikipedia.org/wiki/Google_Now), Material Design uses more grid-based layouts, responsive animations and transitions, padding, and depth effects such as lighting and shadows. Google announced Material Design on June 25, 2014, at the 2014 [Google I/O](https://en.wikipedia.org/wiki/Google_I/O) conference.[^4]
{: .notice--primary}

Material Design是Google在2014年提出的设计规范，它所涵盖的内容非常广泛，颜色部分的设计只是其中一小部分。`ggsci`的Material Design色卡参考了Material Design，但是颜色的十六进制代码有细微的差异。

## (1) `red`

```R
library("ggsci")

mypal <- pal_material("red", alpha = 1)(10)
mypal
# [1] "#FFEBEDFF" "#FFCCD2FF" "#EE9999FF" "#E57272FF" "#EE5250FF" "#F34335FF" "#E53934FF" "#D22E2EFF" "#C52727FF" "#B71B1BFF"

library("scales")
show_col(mypal)
```

![image-20230107185312320](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107185312320.png?raw=true)

```
mypal =
    1.0000    0.9216    0.9294
    1.0000    0.8000    0.8235
    0.9333    0.6000    0.6000
    0.8980    0.4471    0.4471
    0.9333    0.3216    0.3137
    0.9529    0.2627    0.2078
    0.8980    0.2235    0.2039
    0.8235    0.1804    0.1804
    0.7725    0.1529    0.1529
    0.7176    0.1059    0.1059
```

![image-20230110165639600](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110165639600.png?raw=true)

## (2) `pink`

```R
library("ggsci")

mypal <- pal_material("pink", alpha = 1)(10)
mypal
# [1] "#FCE4EBFF" "#F8BAD0FF" "#F38EB1FF" "#F06192FF" "#EB3F79FF" "#E91E63FF" "#D81A5FFF" "#C1185AFF" "#AC1357FF" "#870D4EFF"

library("scales")
show_col(mypal)
```

![image-20230107185408241](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107185408241.png?raw=true)

```
mypal =
    0.9882    0.8941    0.9216
    0.9725    0.7294    0.8157
    0.9529    0.5569    0.6941
    0.9412    0.3804    0.5725
    0.9216    0.2471    0.4745
    0.9137    0.1176    0.3882
    0.8471    0.1020    0.3725
    0.7569    0.0941    0.3529
    0.6745    0.0745    0.3412
    0.5294    0.0510    0.3059
```

![image-20230110165812946](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110165812946.png?raw=true)

## (3) `purple`

```R
library("ggsci")

mypal <- pal_material("purple", alpha = 1)(10)
mypal
# [1] "#F2E5F4FF" "#E0BEE6FF" "#CD92D8FF" "#B967C7FF" "#AB46BBFF" "#9B26B0FF" "#8D24AAFF" "#7A1FA1FF" "#6A1A99FF" "#4A138CFF"

library("scales")
show_col(mypal)
```

![image-20230107185504824](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107185504824.png?raw=true)

```
mypal =
    0.9490    0.8980    0.9569
    0.8784    0.7451    0.9020
    0.8039    0.5725    0.8471
    0.7255    0.4039    0.7804
    0.6706    0.2745    0.7333
    0.6078    0.1490    0.6902
    0.5529    0.1412    0.6667
    0.4784    0.1216    0.6314
    0.4157    0.1020    0.6000
    0.2902    0.0745    0.5490
```

![image-20230110165937697](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110165937697.png?raw=true)

## (4) `deep-purple`

```R
library("ggsci")

mypal <- pal_material("deep-purple", alpha = 1)(10)
mypal
# [1] "#ECE6F6FF" "#D1C4E9FF" "#B29DDAFF" "#9474CCFF" "#7E57C1FF" "#6639B7FF" "#5E34B1FF" "#512CA7FF" "#45269FFF" "#311A92FF"

library("scales")
show_col(mypal)
```

![image-20230107185558420](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107185558420.png?raw=true)

```
mypal =
    0.9255    0.9020    0.9647
    0.8196    0.7686    0.9137
    0.6980    0.6157    0.8549
    0.5804    0.4549    0.8000
    0.4941    0.3412    0.7569
    0.4000    0.2235    0.7176
    0.3686    0.2039    0.6941
    0.3176    0.1725    0.6549
    0.2706    0.1490    0.6235
    0.1922    0.1020    0.5725
```

![image-20230110215229976](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110215229976.png?raw=true)

## (5) `indigo`

```R
library("ggsci")

mypal <- pal_material("indigo", alpha = 1)(10)
mypal
# [1] "#E7EAF6FF" "#C5CAE9FF" "#9FA7D9FF" "#7985CBFF" "#5B6BBFFF" "#3F51B4FF" "#3948ABFF" "#303F9FFF" "#273492FF" "#19227EFF"

library("scales")
show_col(mypal)
```

![image-20230107185650465](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107185650465.png?raw=true)

```
mypal =
    0.9059    0.9176    0.9647
    0.7725    0.7922    0.9137
    0.6235    0.6549    0.8510
    0.4745    0.5216    0.7961
    0.3569    0.4196    0.7490
    0.2471    0.3176    0.7059
    0.2235    0.2824    0.6706
    0.1882    0.2471    0.6235
    0.1529    0.2039    0.5725
    0.0980    0.1333    0.4941
```

![image-20230110215350884](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110215350884.png?raw=true)

## (6) `blue`

```R
library("ggsci")

mypal <- pal_material("blue", alpha = 1)(10)
mypal
# [1] "#E3F2FDFF" "#BADEFAFF" "#90CAF8FF" "#64B4F6FF" "#41A5F4FF" "#2096F2FF" "#1E87E5FF" "#1976D2FF" "#1465BFFF" "#0C46A0FF"

library("scales")
show_col(mypal)
```

![image-20230107185755776](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107185755776.png?raw=true)

```
mypal =
    0.8902    0.9490    0.9922
    0.7294    0.8706    0.9804
    0.5647    0.7922    0.9725
    0.3922    0.7059    0.9647
    0.2549    0.6471    0.9569
    0.1255    0.5882    0.9490
    0.1176    0.5294    0.8980
    0.0980    0.4627    0.8235
    0.0784    0.3961    0.7490
    0.0471    0.2745    0.6275
```

![image-20230110215502225](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110215502225.png?raw=true)

## (7) `light-blue`

```R
library("ggsci")

mypal <- pal_material("light-blue", alpha = 1)(10)
mypal
# [1] "#E0F4FEFF" "#B2E5FCFF" "#80D3F9FF" "#4EC3F7FF" "#28B6F6FF" "#02A9F3FF" "#029AE5FF" "#0187D1FF" "#0177BDFF" "#00579AFF"

library("scales")
show_col(mypal)
```

![image-20230107185835704](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107185835704.png?raw=true)

```
mypal =
    0.8784    0.9569    0.9961
    0.6980    0.8980    0.9882
    0.5020    0.8275    0.9765
    0.3059    0.7647    0.9686
    0.1569    0.7137    0.9647
    0.0078    0.6627    0.9529
    0.0078    0.6039    0.8980
    0.0039    0.5294    0.8196
    0.0039    0.4667    0.7412
         0    0.3412    0.6039
```

![image-20230110215635252](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110215635252.png?raw=true)

## (8) `cyan`

```R
library("ggsci")

mypal <- pal_material("cyan", alpha = 1)(10)
mypal
# [1] "#DFF7F9FF" "#B2EBF2FF" "#7FDEEAFF" "#4CD0E0FF" "#26C5D9FF" "#00BBD3FF" "#00ACC0FF" "#0097A6FF" "#00838EFF" "#005F64FF"

library("scales")
show_col(mypal)
```

![image-20230107185918621](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107185918621.png?raw=true)

```
mypal =
    0.8745    0.9686    0.9765
    0.6980    0.9216    0.9490
    0.4980    0.8706    0.9176
    0.2980    0.8157    0.8784
    0.1490    0.7725    0.8510
         0    0.7333    0.8275
         0    0.6745    0.7529
         0    0.5922    0.6510
         0    0.5137    0.5569
         0    0.3725    0.3922
```

![image-20230110215739554](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110215739554.png?raw=true)

## (9) `teal`

```R
library("ggsci")

mypal <- pal_material("teal", alpha = 1)(10)
mypal
# [1] "#DFF2F1FF" "#B2DFDAFF" "#7FCBC4FF" "#4CB6ACFF" "#26A599FF" "#009687FF" "#00887AFF" "#00796BFF" "#00685BFF" "#004C3FFF"

library("scales")
show_col(mypal)
```

![image-20230107190002436](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107190002436.png?raw=true)

```
mypal =
    0.8745    0.9490    0.9451
    0.6980    0.8745    0.8549
    0.4980    0.7961    0.7686
    0.2980    0.7137    0.6745
    0.1490    0.6471    0.6000
         0    0.5882    0.5294
         0    0.5333    0.4784
         0    0.4745    0.4196
         0    0.4078    0.3569
         0    0.2980    0.2471
```

![image-20230110215956190](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110215956190.png?raw=true)

## (10) `green`

```R
library("ggsci")

mypal <- pal_material("green", alpha = 1)(10)
mypal
# [1] "#E7F4E9FF" "#C7E5C9FF" "#A5D6A6FF" "#80C684FF" "#66BA6AFF" "#4CAE50FF" "#439F46FF" "#388D3BFF" "#2D7D32FF" "#1A5E1FFF"

library("scales")
show_col(mypal)
```

![image-20230107190053988](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107190053988.png?raw=true)

```
mypal =
    0.9059    0.9569    0.9137
    0.7804    0.8980    0.7882
    0.6471    0.8392    0.6510
    0.5020    0.7765    0.5176
    0.4000    0.7294    0.4157
    0.2980    0.6824    0.3137
    0.2627    0.6235    0.2745
    0.2196    0.5529    0.2314
    0.1765    0.4902    0.1961
    0.1020    0.3686    0.1216
```

![image-20230110220210602](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110220210602.png?raw=true)

## (11) `light-green`

```R
library("ggsci")

mypal <- pal_material("light-green", alpha = 1)(10)
mypal
# [1] "#F1F8E9FF" "#DCECC7FF" "#C5E0A5FF" "#ADD480FF" "#9BCC65FF" "#8BC34AFF" "#7BB241FF" "#679F38FF" "#548B2EFF" "#33681EFF"

library("scales")
show_col(mypal)
```

![image-20230107190141869](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107190141869.png?raw=true)

```
mypal =
    0.9451    0.9725    0.9137
    0.8627    0.9255    0.7804
    0.7725    0.8784    0.6471
    0.6784    0.8314    0.5020
    0.6078    0.8000    0.3961
    0.5451    0.7647    0.2902
    0.4824    0.6980    0.2549
    0.4039    0.6235    0.2196
    0.3294    0.5451    0.1804
    0.2000    0.4078    0.1176
```

![image-20230110220112586](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110220112586.png?raw=true)

## (12) `lime`

```R
library("ggsci")

mypal <- pal_material("lime", alpha = 1)(10)
mypal
# [1] "#F8FAE6FF" "#F0F3C3FF" "#E5ED9BFF" "#DCE674FF" "#D3E057FF" "#CCDC39FF" "#BFCA33FF" "#AEB32BFF" "#9E9D24FF" "#817717FF"

library("scales")
show_col(mypal)
```

![image-20230107190223020](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107190223020.png?raw=true)

```
mypal =
    0.9725    0.9804    0.9020
    0.9412    0.9529    0.7647
    0.8980    0.9294    0.6078
    0.8627    0.9020    0.4549
    0.8275    0.8784    0.3412
    0.8000    0.8627    0.2235
    0.7490    0.7922    0.2000
    0.6824    0.7020    0.1686
    0.6196    0.6157    0.1412
    0.5059    0.4667    0.0902
```

![image-20230110220327314](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110220327314.png?raw=true)

## (13) `yellow`

```R
library("ggsci")

mypal <- pal_material("yellow", alpha = 1)(10)
mypal
# [1] "#FFFDE6FF" "#FFF8C4FF" "#FFF49DFF" "#FFF176FF" "#FFED58FF" "#FFEB3AFF" "#FDD834FF" "#FABF2CFF" "#F8A725FF" "#F47F17FF"

library("scales")
show_col(mypal)
```

![image-20230107193509183](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107193509183.png?raw=true)

```
mypal =
    1.0000    0.9922    0.9020
    1.0000    0.9725    0.7686
    1.0000    0.9569    0.6157
    1.0000    0.9451    0.4627
    1.0000    0.9294    0.3451
    1.0000    0.9216    0.2275
    0.9922    0.8471    0.2039
    0.9804    0.7490    0.1725
    0.9725    0.6549    0.1451
    0.9569    0.4980    0.0902
```

![image-20230110220446616](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110220446616.png?raw=true)

## (14) `amber`

```R
library("ggsci")

mypal <- pal_material("amber", alpha = 1)(10)
mypal
# [1] "#FFF8E0FF" "#FFEBB2FF" "#FFDF81FF" "#FFD44EFF" "#FFCA27FF" "#FFC006FF" "#FFB200FF" "#FF9F00FF" "#FF8E00FF" "#FF6E00FF"

library("scales")
show_col(mypal)
```

![image-20230107190428547](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107190428547.png?raw=true)

```
mypal =
    1.0000    0.9725    0.8784
    1.0000    0.9216    0.6980
    1.0000    0.8745    0.5059
    1.0000    0.8314    0.3059
    1.0000    0.7922    0.1529
    1.0000    0.7529    0.0235
    1.0000    0.6980         0
    1.0000    0.6235         0
    1.0000    0.5569         0
    1.0000    0.4314         0
```

![image-20230110220659860](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110220659860.png?raw=true)

## (15) `orange`

```R
library("ggsci")

mypal <- pal_material("orange", alpha = 1)(10)
mypal
# [1] "#FFF2DFFF" "#FFDFB2FF" "#FFCC7FFF" "#FFB74CFF" "#FFA626FF" "#FF9800FF" "#FA8C00FF" "#F47B00FF" "#EE6C00FF" "#E55100FF"

library("scales")
show_col(mypal)
```

![image-20230107190537393](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107190537393.png?raw=true)

```
mypal =
    1.0000    0.9490    0.8745
    1.0000    0.8745    0.6980
    1.0000    0.8000    0.4980
    1.0000    0.7176    0.2980
    1.0000    0.6510    0.1490
    1.0000    0.5961         0
    0.9804    0.5490         0
    0.9569    0.4824         0
    0.9333    0.4235         0
    0.8980    0.3176         0
```

![image-20230110220758735](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110220758735.png?raw=true)

## (16) `deep-orange`

```R
library("ggsci")

mypal <- pal_material("deep-orange", alpha = 1)(10)
mypal
# [1] "#FAE9E6FF" "#FFCCBBFF" "#FFAB91FF" "#FF8A65FF" "#FF7043FF" "#FF5721FF" "#F3511EFF" "#E54A19FF" "#D84314FF" "#BF350CFF"

library("scales")
show_col(mypal)
```

![image-20230107190619158](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107190619158.png?raw=true)

```
mypal =
    0.9804    0.9137    0.9020
    1.0000    0.8000    0.7333
    1.0000    0.6706    0.5686
    1.0000    0.5412    0.3961
    1.0000    0.4392    0.2627
    1.0000    0.3412    0.1294
    0.9529    0.3176    0.1176
    0.8980    0.2902    0.0980
    0.8471    0.2627    0.0784
    0.7490    0.2078    0.0471
```

![image-20230110220911294](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110220911294.png?raw=true)

## (17) `brown`

```R
library("ggsci")

mypal <- pal_material("brown", alpha = 1)(10)
mypal
# [1] "#EEEBE9FF" "#D7CCC7FF" "#BBAAA4FF" "#A0877FFF" "#8C6D63FF" "#795447FF" "#6C4C40FF" "#5D3F37FF" "#4D332DFF" "#3E2622FF"

library("scales")
show_col(mypal)
```

![image-20230107190723867](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107190723867.png?raw=true)

```
mypal =
    0.9333    0.9216    0.9137
    0.8431    0.8000    0.7804
    0.7333    0.6667    0.6431
    0.6275    0.5294    0.4980
    0.5490    0.4275    0.3882
    0.4745    0.3294    0.2784
    0.4235    0.2980    0.2510
    0.3647    0.2471    0.2157
    0.3020    0.2000    0.1765
    0.2431    0.1490    0.1333
```

![image-20230110221004239](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110221004239.png?raw=true)

## (18) `grey`

```R
library("ggsci")

mypal <- pal_material("grey", alpha = 1)(10)
mypal
# [1] "#F9F9F9FF" "#F4F4F4FF" "#EDEDEDFF" "#DFDFDFFF" "#BDBDBDFF" "#9E9E9EFF" "#747474FF" "#606060FF" "#414141FF" "#202020FF"

library("scales")
show_col(mypal)
```

![image-20230107190832170](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107190832170.png?raw=true)

```
mypal =
    0.9765    0.9765    0.9765
    0.9569    0.9569    0.9569
    0.9294    0.9294    0.9294
    0.8745    0.8745    0.8745
    0.7412    0.7412    0.7412
    0.6196    0.6196    0.6196
    0.4549    0.4549    0.4549
    0.3765    0.3765    0.3765
    0.2549    0.2549    0.2549
    0.1255    0.1255    0.1255
```

![image-20230110221113463](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110221113463.png?raw=true)

## (19) `blue-grey`

```R
library("ggsci")

mypal <- pal_material("blue-grey", alpha = 1)(10)
mypal
# [1] "#EBEEF1FF" "#CED8DCFF" "#B0BEC5FF" "#90A4ADFF" "#78909BFF" "#5F7D8BFF" "#536D79FF" "#455964FF" "#37464EFF" "#263238FF"

library("scales")
show_col(mypal)
```

![image-20230107190920083](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230107190920083.png?raw=true)

```
mypal =
    0.9216    0.9333    0.9451
    0.8078    0.8471    0.8627
    0.6902    0.7451    0.7725
    0.5647    0.6431    0.6784
    0.4706    0.5647    0.6078
    0.3725    0.4902    0.5451
    0.3255    0.4275    0.4745
    0.2706    0.3490    0.3922
    0.2157    0.2745    0.3059
    0.1490    0.1961    0.2196
```

![image-20230110221222634](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230110221222634.png?raw=true)

<br>

**References**

[^1]: [Scientific Journal and Sci-Fi ThemedColor Palettes for ggplot2 - ggsci](https://nanx.me/ggsci/articles/ggsci.html).
[^2]: [nanxstats/ggsci: Scientific journal and sci-fi themed color palettes for ggplot2 (github.com)](https://github.com/nanxstats/ggsci).
[^3]: [`rgb2hex` and `hex2rgb` - File Exchange - MATLAB Central](https://ww2.mathworks.cn/matlabcentral/fileexchange/46289-rgb2hex-and-hex2rgb?s_tid=srchtitle_convert%20hex%20to%20RGB_1).
[^4]: [Material Design - Wikipedia](https://en.wikipedia.org/wiki/Material_Design).
[^5]: [The color system - Material Design](https://m2.material.io/design/color/the-color-system.html#color-usage-and-palettes).



