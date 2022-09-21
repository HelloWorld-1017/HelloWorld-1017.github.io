



# Introduction

本示例来自MATLAB Predictive Maintenance Toolbox：[Wind Turbine High-Speed Bearing Prognosis](https://ww2.mathworks.cn/help/predmaint/ug/wind-turbine-high-speed-bearing-prognosis.html)



也是从健康到故障的全过程数据

指数退化模型

单调性

# Workflow

## Data Import

`WindTurbineHighSpeedBearingPrognosis-Data-main`文件夹中所有的.mat文件都保存着相似的数据，例如`data-20130310T030102Z.mat`文件保存着两个变量`tach`和`vibration`：

```matlab
  Name                Size              Bytes  Class     Attributes

  tach             2461x1               19688  double              
  vibration      585936x1             4687488  double       
```

使用`fileEnsembleDatastore`来装载并处理`WindTurbineHighSpeedBearingPrognosis-Data-main`文件夹中的.mat文件。

```matlab
hsbearing = fileEnsembleDatastore(...
    fullfile('.', 'WindTurbineHighSpeedBearingPrognosis-Data-main'), ...
    '.mat');
hsbearing.DataVariables = ["vibration", "tach"];
hsbearing.IndependentVariables = "Date";
hsbearing.SelectedVariables = ["Date", "vibration", "tach"];
hsbearing.ReadFcn = @helperReadData;
hsbearing.WriteToMemberFcn = @helperWriteToHSBearing;
```

其中，需要自定义读取函数`hsbearing.ReadFcn`——`helperReadData`：

```matlab
function data = helperReadData(filename, variables)
% Read data variables for the fileEnsemble
%
% Inputs:
% filename  - a string of the file name to read from.
% variables - a string array containing variable names to read.
%             It must be a subset of DataVariables specified
%             in fileEnsembleDatastore.
% Output:
% data      - return a table with a single row

% Copyright 2017-2018 The MathWorks, Inc.

data = table;
mfile = matfile(filename); % Allows partial loading
for ct = 1:numel(variables)
    if strcmp(variables{ct}, "Date")
        % Extract the datetime information from the file names
        % as the independent variable of the ensemble datastore
        [~, fname] = fileparts(filename);
        token = regexp(fname, 'data-(\w+)', 'tokens');
        data.Date = datetime(token{1}{1}, 'InputFormat', 'yyyyMMdd''T''HHmmss''Z''');
    else
        val = mfile.(variables{ct});
        % Convert non-scalar values into a single cell
        if numel(val) > 1
            val = {val};
        end
        data.(variables{ct}) = val;
    end
end
end
```

该函数使用正则表达式将.mat文件的文件名解析为`Date`，并读取.mat文件的`tach`变量和`vibration`变量。

同样地，自定义写入函数`hsbearing.WriteToMemberFcn`——`helperWriteToHSBearing`：

```matlab
function helperWriteToHSBearing(filename, data)
% Write data to the fileEnsemble
% Inputs:
% filename - a string of the file name to write to.
% data     - a structure
save(filename, '-append', '-struct', 'data');
end
```

写入函数的内容是很固定的，很多例子中都是使用的这个函数，实现的功能就是以`‘-append’`的方式向.mat文件中写入数据，而不是覆盖。

之后，创建tall array：

```matlab
tall(hsbearing)
```

```matlab
tall(hsbearing)
ans =
  M×3 tall table
           Date                vibration             tach      
    ___________________    _________________    _______________
    2013-03-07 01:57:46    {585936×1 double}    {2446×1 double}
    2013-03-08 02:34:21    {585936×1 double}    {2411×1 double}
    2013-03-09 02:33:43    {585936×1 double}    {2465×1 double}
             :                     :                   :
             :                     :                   :
```

`WindTurbineHighSpeedBearingPrognosis-Data-main`文件夹中一共有50个.mat文件，从2013-03-07到2013-04-25每天记录一条数据。

## Data Exploration

首先查看50个`vibration`信号在时域内的图像：

```matlab
reset(hsbearing)
tstart = 0;
figure
hold on
while hasdata(hsbearing)
    data = read(hsbearing);
    v = data.vibration{1};
    t = tstart + (1:length(v))/fs;
    % Downsample the signal to reduce memory usage
    plot(t(1:10:end), v(1:10:end))
    tstart = t(end);
end
hold off
xlabel('Time (s), 6 second per day, 50 days in total')
ylabel('Acceleration (g)')
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220917191329583.png" alt="image-20220917191329583" style="zoom:50%;" />

从这里可以看出，振动信号的幅度有增大的趋势。

在频域内，Spectral kurtosis（谱峭度）是风机诊断的有力工具，可视化频谱，并且将谱峭度`SK`和对应的频率`F`写入到.mat文件：

```matlab
hsbearing.DataVariables = ["vibration", "tach", "SpectralKurtosis"];
colors = parula(50);
figure
hold on
reset(hsbearing)
day = 1;
while hasdata(hsbearing)
    data = read(hsbearing);
    data2add = table;
    
    % Get vibration signal and measurement date
    v = data.vibration{1};
    
    % Compute spectral kurtosis with window size = 128
    wc = 128;
    [SK, F] = pkurtosis(v, fs, wc);
    data2add.SpectralKurtosis = {table(F, SK)};
    
    % Plot the spectral kurtosis
    plot3(F, day*ones(size(F)), SK, 'Color', colors(day, :))
    
    % Write spectral kurtosis values
    writeToLastMemberRead(hsbearing, data2add);
    
    % Increment the number of days
    day = day + 1;
end
hold off
xlabel('Frequency (Hz)')
ylabel('Time (day)')
zlabel('Spectral Kurtosis')
grid on
view(-45, 30)
cbar = colorbar;
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220917191944285.png" alt="image-20220917191944285" style="zoom:50%;" />

可以看到，随着machine condition degrades，在10kHz处的谱峭度逐渐增加。谱峭度的均值，标准差可以成为很好的统计特征。

## Feature Extraction

提取特征，并写入.mat文件：

```matlab
% Pre-assign the feature names in DataVariables before writing them into the fileEnsembleDatastore.
hsbearing.DataVariables = [hsbearing.DataVariables; ...
    "Mean"; "Std"; "Skewness"; "Kurtosis"; "Peak2Peak"; ...
    "RMS"; "CrestFactor"; "ShapeFactor"; "ImpulseFactor"; "MarginFactor"; "Energy"; ...
    "SKMean"; "SKStd"; "SKSkewness"; "SKKurtosis"];

% Compute feature values for each ensemble member
hsbearing.SelectedVariables = ["vibration", "SpectralKurtosis"];
reset(hsbearing)
while hasdata(hsbearing)
    data = read(hsbearing);
    v = data.vibration{1};
    SK = data.SpectralKurtosis{1}.SK;
    features = table;
    
    % Time Domain Features
    features.Mean = mean(v);
    features.Std = std(v);
    features.Skewness = skewness(v);
    features.Kurtosis = kurtosis(v);
    features.Peak2Peak = peak2peak(v);
    features.RMS = rms(v);
    features.CrestFactor = max(v)/features.RMS;
    features.ShapeFactor = features.RMS/mean(abs(v));
    features.ImpulseFactor = max(v)/mean(abs(v));
    features.MarginFactor = max(v)/mean(abs(v))^2;
    features.Energy = sum(v.^2);
    
    % Spectral Kurtosis related features
    features.SKMean = mean(SK);
    features.SKStd = std(SK);
    features.SKSkewness = skewness(SK);
    features.SKKurtosis = kurtosis(SK);
    
    % write the derived features to the corresponding file
    writeToLastMemberRead(hsbearing, features);
end
```

之后，读取所有的特征，写入`featureTable`，并转换为`timetable`：

```matlab
% Select the independent variable Date and all the extracted features to construct the feature table
hsbearing.SelectedVariables = ["Date", "Mean", "Std", "Skewness", "Kurtosis", "Peak2Peak", ...
    "RMS", "CrestFactor", "ShapeFactor", "ImpulseFactor", "MarginFactor", "Energy", ...
    "SKMean", "SKStd", "SKSkewness", "SKKurtosis"];
 
 featureTable = gather(tall(hsbearing));
 
 featureTable = table2timetable(featureTable);
```

![image-20220917192825680](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220917192825680.png)

## Feature Postprocessing

提取出的特征通常混杂着噪声，相反趋势的噪声有时可能不利于RUL预测。另外，特征性能的指标之一单调性对噪声不鲁棒。因此，使用具有5步滞后窗口的(lag window of 5 steps)因果滑动平均滤波(causal moving mean filter)对特征数据进行平滑处理，其中“因果”是指平滑时不使用未来值：

```matlab
variableNames = featureTable.Properties.VariableNames;
featureTableSmooth = varfun(@(x) movmean(x, [5 0]), featureTable);
featureTableSmooth.Properties.VariableNames = variableNames;
```

可视化其中一个特征`SKMean`平滑前后的效果：

```matlab
figure
hold on
plot(featureTable.Date, featureTable.SKMean)
plot(featureTableSmooth.Date, featureTableSmooth.SKMean)
hold off
xlabel('Time')
ylabel('Feature Value')
legend('Before smoothing', 'After smoothing')
title('SKMean')
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220917193710182.png" alt="image-20220917193710182" style="zoom:50%;" />

移动平均平滑引入了信号的时间延迟，但是可以通过在RUL预测中选择适当的阈值来减轻延迟效应。

## Training Data

这部分分割数据集，将前20天收集到的数据作为训练数据。

```matlab
breaktime = datetime(2013, 3, 27);
breakpoint = find(featureTableSmooth.Date < breaktime, 1, 'last');
trainData = featureTableSmooth(1:breakpoint, :);
```

后续的特征重要性排序(feature importance ranking)都是基于训练数据进行的。

## Feature Importance Ranking

在本例中，使用单调性(monotonicity)作为评价特征的指标。第$i$个特征$x_i$的单调性可以使用下面的公式进行计算：
$$
Monotonicity(x_i)=\dfrac1m\sum_{j=1}^m\dfrac{\vert number\ of\ positive\ diff(x_i^j)-number\ of\ negative\ diff(x_i^j)\vert}{n-1}
$$
其中，$n$是测量点的数量，本例中$n=50$；$m$是机器的个数，本例中$m=1$，$x_i^j$是第$j$个机器的第$i$个特征；$diff(x_i^j)=x_i^j(t)-x_i^j(t-1)$。

计算特征的单调性，并进行排序：

```matlab
% Since moving window smoothing is already done, set 'WindowSize' to 0 to
% turn off the smoothing within the function
featureImportance = monotonicity(trainData, 'WindowSize', 0);
helperSortedBarPlot(featureImportance, 'Monotonicity');
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220917194942179.png" alt="image-20220917194942179" style="zoom:50%;" />

可以看到，`Kurtosis`是单调性最高的特征。

将单调性大于0.3的特征选取出来，用于下一部分将要进行的特征融合：

```matlab
trainDataSelected = trainData(:, featureImportance{:,:}>0.3);
featureSelected = featureTableSmooth(:, featureImportance{:,:}>0.3)
```

一共选取出5个特征

```matlab
>> featureSelected.Properties.VariableNames
ans =
  1×5 cell array
    {'Mean'}    {'Kurtosis'}    {'ShapeFactor'}    {'MarginFactor'}    {'SKStd'}
```

## Dimension Reduction and Feature Fusion

本部分将特征融合，即进行特征降维。

首先对特征进行标准化，之后计算PCA系数：

```matlab
meanTrain = mean(trainDataSelected{:,:});
sdTrain = std(trainDataSelected{:,:});
trainDataNormalized = (trainDataSelected{:,:} - meanTrain)./sdTrain;
coef = pca(trainDataNormalized);
```

之后，使用均值、标准差和前面的两个主成分的系数处理整个训练集：

```matlab
PCA1 = (featureSelected{:,:} - meanTrain) ./ sdTrain * coef(:, 1);
PCA2 = (featureSelected{:,:} - meanTrain) ./ sdTrain * coef(:, 2);
```

然后，在二维主成分空间中可视化数据：

```matlab
figure
numData = size(featureTable, 1);
scatter(PCA1, PCA2, [], 1:numData, 'filled')
xlabel('PCA 1')
ylabel('PCA 2')
cbar = colorbar;
ylabel(cbar, ['Time (' timeUnit ')'])
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220917200157978.png" alt="image-20220917200157978" style="zoom:50%;" />

图像表明，第一主成分随着机器接近故障而逐渐增加，因此可以将第一主成分视作融合的health indicator：

```matlab
healthIndicator = PCA1;
```

查看第一主成分随时间变化曲线：

```matlab
figure
plot(featureSelected.Date, healthIndicator, '-o')
xlabel('Time')
title('Health Indicator')
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220917200617427.png" alt="image-20220917200617427" style="zoom:50%;" />

## Fit Exponential Degradation Models for Remaining Useful Life (RUL) Estimation

指数退化模型(exponential degradation model)定义为：
$$
h(t)=\phi+\theta\exp(\beta t+\varepsilon-\dfrac{\sigma^2}{2})\notag
$$
其中，

- $h(t)$是health indicator随时间变化方程，就是要拟合的上面那条曲线；

- $\phi$是截距，为常数项；

- $\theta$和$\beta$是随机变量，决定了模型的斜率，其中$\theta$服从对数正态分布，$\beta$是高斯分布。在每一个时间步长$t$，$\theta$和$\beta$的分布都会基于是$h(t)$的latest observation更新先验分布。

- $\varepsilon$是高斯噪声，服从$N(0,\sigma^2)$；

- 指数部分的$-\dfrac{\sigma^2}2$项使得$h(t)$的期望满足：
$$
E[h(t)\vert\theta,\beta]=\phi+\theta\exp(\beta t)\label{eq2}
$$

本部分就是基于第一主成分（即health indicator）变化曲线拟合上述指数退化模型。

首先，将Health indicator的第一个值置为0：

```matlab
healthIndicator = healthIndicator - healthIndicator(1);
```

阈值（超过阈值就可以认为是故障了）的选择通常是基于机器的历史记录，或者是相关领域的知识。由于在本例中没有历史数据集，因此就选`helathIndicator`中的最后一个值作为阈值。建议根据平滑（历史）数据选择阈值，以部分缓解平滑的延迟效应。

```matlab
threshold = healthIndicator(end);
```

如果可以得到历史数据，使用`exponetialDegradationModel`提供的`fit`方法去估计先验和截距。但是，本数据集没有历史数据。因此，斜率参数$\theta$和$\beta$的先验就随便选取，但是要有大的方差，使得模型最大程度地依靠观测数据进行更新。这里选取$E(\theta)=1,Var(\theta)=1e6,E(\beta)=1,Var(\beta)=1e6$。

另外，根据公式$\eqref{eq2}$可以得出：
$$
E[h(0)]=\phi+E(\theta)=0\notag
$$
因此令$\phi=-1$，使得模型可以从0开始，与`healthIndicator`保持一致。

Health indicator变化与噪声变化之间的关系可推导为：
$$
\Delta h(t)\approx(h(t)-\phi)\Delta\varepsilon(t)\notag
$$
这里假设：当health indicator接近`threshold`时，噪声的标准偏差会引起health indicator 10%的变化。因此，噪声的标准偏差可以表示为$\dfrac{10\%\cdot threshold}{threshold-\phi}$。

另外，只说明还提供评估significance of the slope的功能。一旦health indicator出现了一个significant slope，模型就会忘记previous observations，并且基于原始的先验分布重新开始估计。这个监测算法的敏感性可以通过`SlopeDetectionLevel`进行设置，如果`p`值小于`SlopeDetectionLevel`，则 the slope is declared to be detected。

```matlab
% Create an exponential degradation model with the parameters discussed above
mdl = exponentialDegradationModel(...
    'Theta', 1, ...
    'ThetaVariance', 1e6, ...
    'Beta', 1, ...
    'BetaVariance', 1e6, ...
    'Phi', -1, ...
    'NoiseVariance', (0.1*threshold/(threshold + 1))^2, ...
    'SlopeDetectionLevel', 0.05);
```

之后使用`update`函数和`predictRUL`函数进行更新和预测，并进行更新过程的可视化：

```matlab
% Keep records at each iteration
totalDay = length(healthIndicator) - 1;
estRULs = zeros(totalDay, 1);
trueRULs = zeros(totalDay, 1);
CIRULs = zeros(totalDay, 2);
pdfRULs = cell(totalDay, 1);

% Create figures and axes for plot updating
figure
ax1 = subplot(2, 1, 1);
ax2 = subplot(2, 1, 2);

for currentDay = 1:totalDay
    
    % Update model parameter posterior distribution
    update(mdl, [currentDay healthIndicator(currentDay)])
    
    % Predict Remaining Useful Life
    [estRUL, CIRUL, pdfRUL] = predictRUL(mdl, ...
                                         [currentDay healthIndicator(currentDay)], ...
                                         threshold);
    trueRUL = totalDay - currentDay + 1;
    
    % Updating RUL distribution plot
    helperPlotTrend(ax1, currentDay, healthIndicator, mdl, threshold, timeUnit);
    helperPlotRUL(ax2, trueRUL, estRUL, CIRUL, pdfRUL, timeUnit)
    
    % Keep prediction results
    estRULs(currentDay) = estRUL;
    trueRULs(currentDay) = trueRUL;
    CIRULs(currentDay, :) = CIRUL;
    pdfRULs{currentDay} = pdfRUL;
    
    % Pause 0.1 seconds to make the animation visible
    pause(0.2)
end
```

![gif1](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/gif1.gif)

也就是说，模型每观测到一个观测量（ie Health indicator）都会对模型更新（使用`update`函数），并且使用`predictRUL`函数对目前的RUL进行预测。**更新的过程实际上就是对指数函数参数估计的过程**。

可视化部分使用了两个自定义函数：

`helperPlotTrend`函数：

```matlab
function helperPlotTrend(ax, currentDay, healthIndicator, mdl, threshold, timeUnit)
%HELPERPLOTTREND helper function to refresh the trending plot

%  Copyright 2018 The MathWorks, Inc.
t = 1:size(healthIndicator, 1);
HIpred = mdl.Phi + mdl.Theta*exp(mdl.Beta*(t - mdl.InitialLifeTimeValue));
HIpredCI1 = mdl.Phi + ...
    (mdl.Theta - sqrt(mdl.ThetaVariance)) * ...
    exp((mdl.Beta - sqrt(mdl.BetaVariance))*(t - mdl.InitialLifeTimeValue));
HIpredCI2 = mdl.Phi + ...
    (mdl.Theta + sqrt(mdl.ThetaVariance)) * ...
    exp((mdl.Beta + sqrt(mdl.BetaVariance))*(t - mdl.InitialLifeTimeValue));

cla(ax)
hold(ax, 'on')
plot(ax, t, HIpred)% Predictive RUL
plot(ax, [t NaN t], [HIpredCI1 NaN, HIpredCI2], '--')% Confidence interval
plot(ax, t(1:currentDay), healthIndicator(1:currentDay, :))% Real health indicator
plot(ax, t, threshold*ones(1, length(t)), 'r') % Threshold
hold(ax, 'off')
if ~isempty(mdl.SlopeDetectionInstant)
    title(ax, sprintf('Day %d: Degradation detected!\n', currentDay))
else
    title(ax, sprintf('Day %d: Degradation NOT detected.\n', currentDay))
end
ylabel(ax, 'Health Indicator')
xlabel(ax, ['Time (' timeUnit ')'])
legend(ax, 'Degradation Model', 'Confidence Interval', ...
    'Health Indicator', 'Threshold', 'Location', 'Northwest')
end
```

`helperPlotRUL`函数：

```matlab
function helperPlotRUL(ax, trueRUL, estRUL, CIRUL, pdfRUL, timeUnit)
%HELPERPLOTRULDISTRIBUTION helper function to refresh the distribution plot

%  Copyright 2018 The MathWorks, Inc.
cla(ax)
hold(ax, 'on')
plot(ax, pdfRUL{:,1}, pdfRUL{:,2})
plot(ax, [estRUL estRUL], [0 pdfRUL{find(pdfRUL{:,1} >= estRUL, 1), 2}])
plot(ax, [trueRUL trueRUL], [0 pdfRUL{find(pdfRUL{:,1} >= trueRUL, 1), 2}], '--')
idx = pdfRUL{:,1} >= CIRUL(1) & pdfRUL{:,1}<=CIRUL(2);
area(ax, pdfRUL{idx, 1}, pdfRUL{idx, 2}, ...
    'FaceAlpha', 0.2, 'FaceColor', 'g', 'EdgeColor', 'none');
hold(ax, 'off')
ylabel(ax, 'PDF')
xlabel(ax, ['Time (' timeUnit ')'])
legend(ax, 'pdf of RUL', 'Estimated RUL', 'True RUL', 'Confidence Interval')
end
```

## Performance Analysis

















predictRUL for 退化模型。



**参考**

[1] [Wind Turbine High-Speed Bearing Prognosis - MathWorks](https://ww2.mathworks.cn/help/predmaint/ug/wind-turbine-high-speed-bearing-prognosis.html).





