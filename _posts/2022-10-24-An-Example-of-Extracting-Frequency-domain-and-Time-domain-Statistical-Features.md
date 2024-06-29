---
layout: single
title: An Example of Extracting Frequency-domain and Time-domain Statistical Features
date: 2022-10-24 14:58:46 +0800
categories: 
 - MATLAB
 - Signals and Systems
tags:
 - MATLAB Signal Processing Toolbox
---

# Introduction

博客[Generate Synthetic Signals Using Conditional GAN in MATLAB - What a starry night~](http://whatastarrynight.com/programming/machine learning/Generate-Synthetic-Signals-Using-Conditional-GAN-in-MATLAB/#feature-extraction)中分析了一个在MATLAB中使用CGAN生成pump振动信号的示例。该示例中包含了一段提取振动信号时域特征和频域特征的代码，本文以其中一条振动信号为例详细分析这段代码的功能。

<br>

# Time-domain Profile

首先，绘制振动信号的时域波形：

```matlab
load simulatedDataset.mat

flow1 = flow(:, 1);
flow1 = flow1-mean(flow1);
plot(flow1)
set(gca, "XLim", [0, numel(flow1)-1])
xlabel("Observations")
ylabel("Signal")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221024131228983.png?raw=true" alt="image-20221024131228983" style="zoom:50%;" />

注意，在提取频域特征之前，需要信号的偏移，使信号在零值附近波动，上图展示了这一点。

<br>

# Spectrum , `pspectrum` Function

之后，提取信号的频域特征，首先需要得到信号的频谱，这里使用的是`pspectrum`函数：

`pspectrum`函数官方文档：[pspectrum - MathWorks](https://ww2.mathworks.cn/help/signal/ref/pspectrum.html).
{: .notice--primary}

```matlab
[flowSpectrum, flowFrequencies] = pspectrum(flow1, 1000, 'FrequencyLimits', [2 250]);
```

其中：

- 输入的`1000`是信号采样率；`FrequencyLimits`表示Frequency band limits；
- 输出的`flowSpectrum`表示信号的功率谱，`flowFrequencies`表示功率谱所对应的频率；

可以简单看一下频谱的图像：

```matlab
plot(flowFrequencies, flowSpectrum)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221024133757786.png?raw=true" alt="image-20221024133757786" style="zoom: 50%;" />

但其实，`pspectrum`函数本身也可以进行绘图：

```matlab
pspectrum(flow1, 1000, 'FrequencyLimits', [2 250])
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221024135228834.png?raw=true" alt="image-20221024135228834" style="zoom:50%;" />

但是可以看到两者的差别。

之所以差别如此巨大，是因为`[flowSpectrum, flowFrequencies] = pspectrum(flow1, 1000, 'FrequencyLimits', [2 250]);`所返回的`flowSpectrum`并不是以dB为单位的，如果想要得到和`pspectrum`绘制一致的图像，需要使用`pow2db`函数将功率转换为dB的单位：

```matlab
figure('Units', 'pixels', 'Position', [391,284,1105,420])
tiledlayout(1, 2)
nexttile
pspectrum(flow1, 1000, 'FrequencyLimits', [2 250])
nexttile
plot(flowFrequencies, pow2db(flowSpectrum))
set(gca, "XLim", [0, 250])
grid(gca, "on")
box(gca, "on")
xlabel("Frequency")
ylabel("Power Specturm")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221024135406917.png?raw=true" alt="image-20221024135406917" style="zoom:67%;" />

两者就是一致的了。但是本示例在提取频域特征的时候，还是使用的原始的单位，并不使用dB单位，即基于该图像进行提取：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221024133757786.png?raw=true" alt="image-20221024133757786" style="zoom: 50%;" />

<br>

# Extract Time-domain and  Frequency-domain Features

在得到功率谱`flowSpectrum`和对应的频率`flowFrequencies`就可以进行特征提取了：

```matlab
ci = extractCI(flow1, flowSpectrum, flowFrequencies);
```

使用的函数为`extractCI`函数：

```matlab
function ci = extractCI(flow, flowP, flowF)
% Compute signal statistical characteristics.

% Find frequency of peak magnitude in power spectrum
pMax = max(flowP);
fPeak = min(flowF(flowP==pMax));

% Compute power in low-frequency range 10 Hz-20 Hz
fRange = flowF >= 10 & flowF <= 20;
pLow = sum(flowP(fRange));

% Compute power in mid-frequency range 40 Hz-60 Hz
fRange = flowF >= 40 & flowF <= 60;
pMid = sum(flowP(fRange));

% Compute power in high-frequency range >100 Hz
fRange = flowF >= 100;
pHigh = sum(flowP(fRange));

% Find frequency of spectral kurtosis peak
[pKur,fKur] = pkurtosis(flow, 1000);
pKur = fKur(pKur == max(pKur));
pKurtosis =  pKur(1);

% Compute flow cumulative sum range
csFlow = cumsum(flow);
csFlowRange = max(csFlow)-min(csFlow);
qCSRange = csFlowRange;

% Collect features and feature values in cell array.
qMean = mean(flow);
qVar = var(flow);
qSkewness = skewness(flow);
qKurtosis = kurtosis(flow);
qPeak2Peak = peak2peak(flow);
qCrest = peak2rms(flow);
qRMS = rms(flow);
qMAD = mad(flow);

ci = [fPeak, pLow, pMid, pHigh, pKurtosis, ...
    qMean, qVar, qSkewness, qKurtosis, ...
    qPeak2Peak, qCrest, qRMS, qMAD, qCSRange];
end
```

该函数的输入输出很明晰，不再赘述。

## (1) Frequency of peak magnitude in power spectrum

代码片段：

```matlab
% Find frequency of peak magnitude in power spectrum
pMax = max(flowP);
fPeak = min(flowF(flowP==pMax));
```

提取频谱中的最大值点的横纵坐标(即频率和幅值)：

```matlab
figure
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
plot(flowF, flowP)
scatter(fPeak, pMax, "filled")
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221024141038963.png?raw=true" alt="image-20221024141038963" style="zoom:67%;" />

但是也可以看到，最后只将频率`fPeak`作为特征之一。

## (2~4) Power in Low-frequency, mid-frequency, and high-frequency

代码片段：

```matlab
% Compute power in low-frequency range 10 Hz-20 Hz
fRange = flowF >= 10 & flowF <= 20;
pLow = sum(flowP(fRange));
% Compute power in mid-frequency range 40 Hz-60 Hz
fRange = flowF >= 40 & flowF <= 60;
pMid = sum(flowP(fRange));
% Compute power in high-frequency range >100 Hz
fRange = flowF >= 100;
pHigh = sum(flowP(fRange));
```

计算低频(10-20 Hz)、中频(40-60 Hz)、高频(>100 Hz)频谱能量和。

## (5) Frequency of spectral kurtosis peak, `pkurtosis` Function

代码片段：

```matlab
% Find frequency of spectral kurtosis peak
[pKur, fKur] = pkurtosis(flow, 1000);
pKur = fKur(pKur == max(pKur));
pKurtosis =  pKur(1);
```

提取谱峰度的峰频率，使用了MATLAB的`pkurtosis`函数。

`pkurtosis`函数官方文档：[pkurtosis - MathWorks](https://ww2.mathworks.cn/help/signal/ref/pkurtosis.html).
{: .notice--primary}

其中：

- 输入中的`1000`，为采样率；

- `pKur`为谱峰度(Spectral kurtosis, SK)，使用的是短时傅里叶变换(short-time Fourier transform, STFT)进行计算：

  <img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221024142817121.png?raw=true" alt="image-20221024142817121" style="zoom: 80%;" />

- `fKur`为frequencies for `pKur`；

之后，将`fKur`作为特征之一。

## (6) Flow cumulative sum range

之后，就是计算信号的时域特征了。首先是信号的累计和范围(cumulative sum range)：

```matlab
% Compute flow cumulative sum range
csFlow = cumsum(flow);
csFlowRange = max(csFlow)-min(csFlow);
qCSRange = csFlowRange;
```

## (7-14) Other statistical time-domain features

```matlab
qMean = mean(flow);
qVar = var(flow);
qSkewness = skewness(flow);
qKurtosis = kurtosis(flow);
qPeak2Peak = peak2peak(flow);
qCrest = peak2rms(flow);
qRMS = rms(flow);
qMAD = mad(flow);
```

其中：

- ```matlab
  qMean = mean(flow);
  qVar = var(flow);
  qSkewness = skewness(flow);
  qKurtosis = kurtosis(flow);
  ```

  计算的是信号的均值、方差、偏度、峰度；

- ```matlab
  qPeak2Peak = peak2peak(flow);
  ```

  计算的是信号的峰峰值，其实就是Maximum-to-minimum difference；

- ```matlab
  qCrest = peak2rms(flow);
  ```

  计算的是Peak-magnitude-to-RMS ratio：

  ![image-20221024144235942](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221024144235942.png?raw=true)

- ```matlab
  qRMS = rms(flow);
  ```
  
  计算的是信号的均方根值(Root-mean-square value):
  
  ![image-20221024144437125](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221024144437125.png?raw=true)
  
- ```matlab
  qMAD = mad(flow);
  ```

  计算的是平均绝对偏差(mean absolute deviation)。

<br>

