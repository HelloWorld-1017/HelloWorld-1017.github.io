---
title: Condition Monitoring and Prognostics based on Vibration Signals in MATLAB
categories: 
 - MATLAB
 - Machine Learning
 - Mathematics
 - Signals and Systems
 - Time Series Analysis
tags:
 - MATLAB Predictive Maintenance Toolbox
 - Probability Theory and Mathematical Statistics
 - Remaining Useful Life (RUL)
 - System Identification
date: 2022-09-21 19:46:45 +0800
last_modified_at: 2024-10-05 15:00:08 +0800
---

# Introduction

本博客中的示例来自MATLAB Predictive Maintenance Toolbox，*Condition Monitoring and Prognostics Using Vibration Signals*[^1]。该示例使用振动信号的频域特征（mean peak frequency）进行轴承的故障诊断和预测，使用的模型是一个**时间序列二阶模型**，本质上也是拟合参数的问题，即不断使用新数据进行参数估计，估计完模型参数后进行预测。但实际上，这个例子更像是系统辨识的例子：

<div class="quote--left" markdown="1">

This example uses functionality from Signal Processing Toolbox™ and System Identification Toolbox™, and does not require Predictive Maintenance Toolbox™.[^1]

</div>

另外需要强调的是，该示例使用的训练数据也是从健康状态到故障状态全过程的数据。

<br>

# Work flow

## Data visualization

`pdmBearingConditionMonitoringData.mat`文件中的数据内容：

```
Name                  Size               Bytes  Class     Attributes
  data                600x1             96062400  cell                
  defectDepthVec      600x1                 4800  double              
  expTime             600x1                 4800  double
```

其中，

- 变量`data`中包含着多个不同health conditions的震动信号片段，每个元素对应1秒的数据，采样率为20kHz；
- 变量`defectDepthVec`为相应的故障程度，为逐渐增大的数值；
- 变量`expTime`为对应的时间，单位是minutes。

绘制故障程度随时间的变化曲线：

```matlab
plot(expTime, defectDepthVec);
xlabel('Time (min)');
ylabel('Defect depth (m)');
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918154729742.png?raw=true" alt="image-20220918154729742" style="zoom:50%;" />

绘制健康状态的震动信号（第一条信号）和故障状态的震动信号（最后一条信号）：

```matlab
time = linspace(0, 1, fs)';

% healthy bearing signal
subplot(2, 1, 1);
plot(time,data{1});
xlabel('Time(s)');
ylabel('Acceleration(m/s^2)');
legend('Healthy bearing signal');

% faulty bearing signal
subplot(2, 1, 2);
plot(time,data{end});
xlabel('Time(s)');
ylabel('Acceleration(m/s^2)');
legend('Faulty bearing signal');
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918155029014.png?raw=true" alt="image-20220918155029014" style="zoom:50%;" />

<br>

## Feature extraction

用于轴承诊断的典型特征包括时域特征（方均根值、峰值、信号峭度等等）或者频域特征（峰频率，平均频率等等）。

在数据探索阶段，可以绘制震动信号的谱，看一看震动信号在时域、频域或者时频域的特点，这有利于探索能够反映故障发展的特征。

首先，计算健康数据的频谱，窗口长度为500，重叠度为90%（即450各数据点），并且设置FFT的点数为512。

```matlab
[~, fvec, tvec ,P0] = spectrogram(data{1}, 500, 450, 512, fs);
```

其中，`P0`为频谱，`fvec`为频率向量，`tvec`为时间向量。

绘制轴承健康状态下的震动信号的频谱图：

```matlab
clf;
imagesc(tvec, fvec, P0)
xlabel('Time(s)');
ylabel('Frequency(Hz)');
title('Healthy Bearing Signal Spectrogram');
colorbar
axis xy
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918160505064.png?raw=true" alt="image-20220918160505064" style="zoom:50%;" />

之后，计算并绘制轴承故障状态下震动信号的频谱图：

```matlab
[~, fvec, tvec, Pfinal] = spectrogram(data{end}, 500, 450, 512, fs);
imagesc(tvec, fvec, Pfinal)
xlabel('Time(s)');
ylabel('Frequency(Hz)');
title('Faulty Bearing Signal Spectrogram');
colorbar
axis xy
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918160655675.png?raw=true" alt="image-20220918160655675" style="zoom:50%;" />

可以看到，此时的信号能量集中的更高的频率。

因此，在健康状态下和故障状态下震动信号的频谱是不同的，可以用于故障诊断。在本例中，从频谱中提取mean peak frequencies作为health indicator。

设频谱为$P(t,\omega)$，peak frequency可以表示为：

$$
PeakFreq(t)=\arg\max_\omega P(t,\omega)\notag
$$

则mean peak frequency为peak frequency的均值：

$$
meanPeakFreq=\dfrac1T\int_0^TPeakFreq(t)\mathrm{d}t\notag
$$

计算健康震动信号的mean peak frequency：

```matlab
[~, I0] = max(P0);               % Find out where the peak frequencies are located.
meanPeakFreq0 = mean(fvec(I0))  % Calculate mean peak frequency.
```

```
meanPeakFreq0 =
  666.4602
```

之后计算故障震动信号的mean peak frequency：

```matlab
[~, Ifinal] = max(Pfinal);
meanPeakFreqFinal = mean(fvec(Ifinal))
```

```
meanPeakFreqFinal =
   2.8068e+03
```

可以看到mean peak frequency从大概650Hz增加到了将近3kHz。

之后，可以再探索一下中间阶段震动信号的mean peak frequency：

```matlab
[~, fvec, tvec, Pmiddle] = spectrogram(data{end/2}, 500, 450, 512, fs);
imagesc(tvec, fvec, Pmiddle)
xlabel('Time(s)');
ylabel('Frequency(Hz)');
title('Bearing Signal Spectrogram');
colorbar
axis xy
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918161757316.png?raw=true" alt="image-20220918161757316" style="zoom:50%;" />

可以看到，图像中布满了高频噪声。这个现象是由原始震动和由小缺陷引起的震动所共同引起的。为了计算mean peak frequency，需要将数据进行滤波处理，移除这些高频噪声，再次进行可视化：

```matlab
dataMiddleFilt = medfilt1(data{end/2}, 3);

[~, fvec, tvec, Pmiddle] = spectrogram(dataMiddleFilt, 500, 450, 512, fs);
imagesc(tvec, fvec, Pmiddle)
xlabel('Time(s)');
ylabel('Frequency(Hz)');
title('Filtered Bearing Signal Spectrogram');
colorbar
axis xy
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918162333303.png?raw=true" alt="image-20220918162333303" style="zoom:50%;" />

之后，对所有的震动信号进行相同的特征提取步骤：

```matlab
% Define a progress bar.
h = waitbar(0, 'Start to extract features');
% Initialize a vector to store the extracted mean peak frequencies.
meanPeakFreq = zeros(numSamples,1);
for k = 1:numSamples
    % Get most up-to-date data.
    curData = data{k};
    % Apply median filter.
    curDataFilt = medfilt1(curData,3);
    % Calculate spectrogram.
    [~,fvec,tvec,P_k] = spectrogram(curDataFilt,500,450,512,fs);
    % Calculate peak frequency at each time instance.
    [~,I] = max(P_k);
    meanPeakFreq(k) = mean(fvec(I));
    % Show progress bar indicating how many samples have been processed.
    waitbar(k/numSamples,h,'Extracting features');
end
close(h);
```

并绘制mean peak frequencies随时间变化的趋势：

```matlab
plot(expTime, meanPeakFreq);
xlabel('Time(min)');
ylabel('Mean peak frequency (Hz)');
grid on;
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918162622715.png?raw=true" alt="image-20220918162622715" style="zoom:50%;" />



## Condition monitoring and prognostics

把mean peak frequency当作time series，我们可以估计一个关于mean peak frequency的时间序列模型，使用这个模型预测未来值。使用前200个mean peak frequency值创建一个初始时间序列模型，之后一旦有有了10个新值，就使用后100个值更新时间序列模型。这种更新时间序列模型的batch mode可以捕捉instantaneous trends。更新的时间序列模型用于预测后面10个步长的数据。

```matlab
tStart = 200;               % Start Time
timeSeg = 100;              % Length of data for building dynamic model
forecastLen = 10;           % Define forecast time horizon
batchSize = 10;             % Define batch size for updating the dynamic model
```

为了进行预测性维修，我们需要一个阈值来决定何时停掉机器。在这个例子中，我们基于仿真得到的轴承健康情况和故障情况的统计数据（保存在`pdmBearingConditionMonitoringStatistics.mat`文件中）得到这个阈值。

`pdmBearingConditionMonitoringStatistics.mat`文件的数据内容如下所示：

```
Name               Size            Bytes  Class     Attributes

  dataFaulty       100x1               800  double              
  dataNormal       100x1               800  double              
  pFaulty         3001x1             24008  double              
  pFreq           3001x1             24008  double              
  pNormal         3001x1             24008  double
```

绘制健康轴承和故障轴承震动信号的mean peak frequency的概率分布：

```matlab
plot(pFreq, pNormal, 'g--', pFreq, pFaulty, 'r', LineWidth=1.5);
xlabel('Mean peak frequency(Hz)');
ylabel('Probability Distribution');
legend('Normal Bearing','Faulty Bearing');
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220918223647977.png?raw=true" alt="image-20220918223647977" style="zoom:50%;" />

基于图像，我们将mean peak frequency的阈值设置为2000 Hz，以分辨轴承的正常状态和故障状态，同时最大化轴承的使用。

```matlab
threshold = 2000;
```

之后，计算采样间隔，并将其单位转换为秒（原本的单位是分钟）。

```matlab
samplingTime = 60*(expTime(2)-expTime(1));                  % unit: seconds
```

之后使用`iddata`函数将`meanPeakFreq`前`tStart`（200个）数据转换为`iddata`类型的变量`tsFeature`：

```matlab
tsFeature = iddata(meanPeakFreq(1:tStart), [], samplingTime);
```

`iddata`函数[^3]将数据转换为可以在时域和频域内进行system identification(系统辨识)的数据类型。
{: .notice--primary}

之后绘制出这200个initial mean peak frequency data：

```matlab
plot(tsFeature.y)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220919091520424.png?raw=true" alt="image-20220919091520424" style="zoom:50%;" />

图像表明，初始数据大致是常数加上一定的噪声。这是预期内的，因为在初始时刻轴承是健康的，mean peak frequency不会大幅度地变化。

然后，使用前200个数据去拟合一个second-order state-space model：

```matlab
past_sys = ssest(tsFeature, 2, 'Ts', samplingTime, 'Form', 'canonical')
```

```
past_sys =
  Discrete-time identified state-space model:
    x(t+Ts) = A x(t) + K e(t)
       y(t) = C x(t) + e(t)
 
  A = 
            x1       x2
   x1        0        1
   x2   0.9605  0.03942
 
  C = 
       x1  x2
   y1   1   0
 
  K = 
              y1
   x1  -0.003899
   x2   0.003656
 
Sample time: 600 seconds
  
Parameterization:
   CANONICAL form with indices: 2.
   Disturbance component: estimate
   Number of free coefficients: 4
   Use "idssdata", "getpvec", "getcov" for parameters and their uncertainties.
   
Status:                                               
Estimated using SSEST on time domain data "tsFeature".
Fit to estimation data: 0.2763% (prediction focus)    
FPE: 640, MSE: 602.7  
```

`ssest`函数的官方文档见参考[^2]。
{: .notice--primary}

可以看到，这个initial estimated dynamic model的拟合效果不好。拟合效果的评判指标是normalized root mean square error (NRMSE)（即上面的`Fit to estimation data: 0.2763%(prediction focus)`，计算公式为：

$$
NRMSE=1-\dfrac{\vert\vert x_{true}-x_{pred}\vert\vert}{\vert\vert x_{true}-mean(x_{true})\vert\vert}\notag
$$

这个数值越大越好。而初始的前200个数据点大致是常数和噪声的叠加，此时$x_{pred}\approx mean(x_{true})$，此时NRMSE接近于0。

为了验证这个模型，绘制autocorrelation of residuals：

```matlab
resid(tsFeature, past_sys)
```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220919094941951.png?raw=true" alt="image-20220919094941951" style="zoom:50%;" />

图像表明，残差是不相关的，得到的模型是有效的。

之后，使用该模型`past_sys`预测未来10个点并计算标准差：

```matlab
[yF, ~, ~, yFSD] = forecast(past_sys, tsFeature, forecastLen);
```

并绘制图像（过去值，预测值，故障阈值，95%置信区间）：

```matlab
tHistory = expTime(1:tStart); % The initial 200 time stamps
forecastTimeIdx = (tStart+1):(tStart+forecastLen); 
tForecast = expTime(forecastTimeIdx);% 200~210 time stamps

% Plot historical data, forecast value and 95% confidence interval.
plot(tHistory, meanPeakFreq(1:tStart), 'b',...
     tForecast, yF.OutputData, 'kx',...
     [tHistory; tForecast], threshold*ones(1,length(tHistory)+forecastLen), 'r--',...
     tForecast, yF.OutputData+1.96*yFSD, 'g--',...
     tForecast, yF.OutputData-1.96*yFSD, 'g--');

ylim([400, 1.1*threshold]);
ylabel('Mean peak frequency (Hz)');
xlabel('Time (min)');
legend({'Past Data', 'Forecast', 'Failure Threshold', '95% C.I'},...
    'Location', 'northoutside', 'Orientation', 'horizontal');
grid on
```

![gif1](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/gif1.gif?raw=true)

注：这里在计算95%置信区间时使用的方式是直接乘上1.96，这是查正态分布表得到的。这里默认的区间估计的对象是什么？具体是如何查找的？目前还不是很清楚。
{: .notice--warning}

之后，随着出现新的观测点（10个）而更新模型参数，并且重新估计预测值，并且创建一个alarm，如果信号或者预测值超过了故障阈值（2000 Hz）就报警：

```matlab
figure
ax = subplot(1, 1, 1);

for tCur = tStart:batchSize:numSamples % batchSize = 10;

    %  latest features into iddata object.
    tsFeature = iddata(meanPeakFreq((tCur-timeSeg+1):tCur), [], samplingTime);

    % Update system parameters when new data comes in. Use previous model
    % parameters as initial guesses.
    sys = ssest(tsFeature, past_sys);
    past_sys = sys;

    % Forecast the output of the updated state-space model. Also compute
    % the standard deviation of the forecasted output.
    [yF, ~, ~, yFSD]  = forecast(sys, tsFeature, forecastLen);

    % Find the time corresponding to historical data and forecasted values.
    tHistory = expTime(1:tCur);
    forecastTimeIdx = (tCur+1):(tCur+forecastLen);
    tForecast = expTime(forecastTimeIdx);

    cla(ax)
    hold(ax, 'on')
    % Plot historical data, forecasted mean peak frequency value and 95%
    % confidence interval.
    plot(ax, tHistory, meanPeakFreq(1:tCur),'b',...
        tForecast, yF.OutputData,'kx',...
        [tHistory; tForecast], threshold*ones(1,length(tHistory)+forecastLen), 'r--',...
        tForecast, yF.OutputData+1.96*yFSD,'g--',...
        tForecast, yF.OutputData-1.96*yFSD,'g--');

    ylim([400, 1.1*threshold]);
    ylabel('Mean peak frequency (Hz)');
    xlabel('Time (min)');
    legend({'Past Data', 'Forecast', 'Failure Threshold', '95% C.I'},...
        'Location','northoutside','Orientation','horizontal');
    grid on;

    % Display an alarm when actual monitored variables or forecasted values exceed
    % failure threshold.
    if(any(meanPeakFreq(tCur-batchSize+1:tCur)>threshold))
        disp('Monitored variable exceeds failure threshold');
        break;
    elseif(any(yF.y>threshold))
        % Estimate the time when the system will reach failure threshold.
        tAlarm = tForecast(find(yF.y>threshold,1));
        disp(['Estimated to hit failure threshold in ' num2str(tAlarm-tHistory(end)) ' minutes from now.']);
        break;
    end
    %     pause(0.1)
end
```

![gif1](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/gif1.gif?raw=true)

此时的时间序列模型：

```matlab
sys
```

```
sys =
  Discrete-time identified state-space model:
    x(t+Ts) = A x(t) + K e(t)
       y(t) = C x(t) + e(t)
 
  A = 
           x1      x2
   x1       0       1
   x2  0.2624   0.746
 
  C = 
       x1  x2
   y1   1   0
 
  K = 
           y1
   x1  0.3902
   x2  0.3002
 
Sample time: 600 seconds
  
Parameterization:
   CANONICAL form with indices: 2.
   Disturbance component: estimate
   Number of free coefficients: 4
   Use "idssdata", "getpvec", "getcov" for parameters and their uncertainties.

Status:                                               
Estimated using SSEST on time domain data "tsFeature".
Fit to estimation data: 92.53% (prediction focus)     
FPE: 499.3, MSE: 442.7    
```

可以看到，模型的预测拟合优度达到92.53%，并且正确地捕捉了趋势。用训练集训练出的最终的这个模型，就可以进行实际的预测。

<br>

# In closing

在这个例子中，时间序列预测模型实际上就是一个second-order state-space model，其中的核心步骤是根据数据使用`ssest`函数拟合出这个动态模型的参数，实际上就是拟合出一个二阶函数。

<br>

**References**

[^1]: [Condition Monitoring and Prognostics Using Vibration Signals](https://ww2.mathworks.cn/help/predmaint/ug/condition-monitoring-and-prognostics-using-vibration-signals.html).
[^2]: [`ssest`: Estimate state-space model using time-domain or frequency-domain data](https://ww2.mathworks.cn/help/ident/ref/ssest.html).

[^3]: [`iddata`: Input-output data and its properties for system identification in the time or frequency domain](https://www.mathworks.com/help/ident/ref/iddata.html).
