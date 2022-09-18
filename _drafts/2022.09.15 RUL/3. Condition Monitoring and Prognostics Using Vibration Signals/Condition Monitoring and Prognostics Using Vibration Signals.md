[Condition Monitoring and Prognostics Using Vibration Signals](https://ww2.mathworks.cn/help/predmaint/ug/condition-monitoring-and-prognostics-using-vibration-signals.html)



# Introduction

也是从健康状态到故障状态全过程的数据

# Work Flow

## Data Visualization

`pdmBearingConditionMonitoringData.mat`文件中的数据内容：

```matlab
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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220918154729742.png" alt="image-20220918154729742" style="zoom:50%;" />

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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220918155029014.png" alt="image-20220918155029014" style="zoom:50%;" />

<br>

## Feature Extraction

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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220918160505064.png" alt="image-20220918160505064" style="zoom:50%;" />

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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220918160655675.png" alt="image-20220918160655675" style="zoom:50%;" />

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

```matlab
meanPeakFreq0 =
  666.4602
```

之后计算故障震动信号的mean peak frequency：

```matlab
[~, Ifinal] = max(Pfinal);
meanPeakFreqFinal = mean(fvec(Ifinal))
```

```matlab
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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220918161757316.png" alt="image-20220918161757316" style="zoom:50%;" />

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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220918162333303.png" alt="image-20220918162333303" style="zoom:50%;" />

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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220918162622715.png" alt="image-20220918162622715" style="zoom:50%;" />



## Condition Monitoring and Prognostics

把mean peak frequency当作time series，我们可以估计一个关于mean peak frequency的时间序列模型，使用这个模型预测未来值。使用前200个mean peak frequency值创建一个初始时间序列模型，之后一旦有有了10个新值，就使用后100个值更新时间序列模型。这种更新时间序列模型的batch mode可以捕捉instantaneous trends。更新的时间序列模型用于预测后面10个步长的数据。

```matlab
tStart = 200;               % Start Time
timeSeg = 100;              % Length of data for building dynamic model
forecastLen = 10;           % Define forecast time horizon
batchSize = 10;             % Define batch size for updating the dynamic model
```

为了进行预测性维修，我们需要一个阈值来决定何时停掉机器。在这个例子中，我们基于仿真得到的轴承健康情况和故障情况的统计数据（保存在`pdmBearingConditionMonitoringStatistics.mat`文件中）得到这个阈值。

`pdmBearingConditionMonitoringStatistics.mat`文件的数据内容如下所示：

```matlab
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

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220918223647977.png" alt="image-20220918223647977" style="zoom:50%;" />

基于图像，我们将mean peak frequency的阈值设置为2000Hz，以分辨轴承的正常状态和故障状态，同时最大化轴承的使用。

```matlab
threshold = 2000;
```

之后，计算采样间隔，并将其单位转换为秒（原本的单位是分钟）。

```matlab
samplingTime = 60*(expTime(2)-expTime(1));                  % unit: seconds
```

==iddata函数==
