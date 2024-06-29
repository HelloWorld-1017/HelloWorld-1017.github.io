---
layout: single
title: Linear Estimation for Loop Running Time in MATLAB
categories:
 - MATLAB
tags:
 - MATLAB Software Development Tools
 - MATLAB Language Fundamentals
toc: false
date: 2024-03-25 17:20:09 +0800
last_modified_at0: 2024-03-25 17:20:09 +0800
last_modified_at1: 2024-03-26 09:40:29 +0800
last_modified_at: 2024-03-26 09:40:29 +0800
---

In MATLAB, the loop running time can be linearly estimated using the following code:

```matlab
clc,clear,close all

numEpochs = 100;

start = tic;
for epoch = 1:numEpochs
    A = rand(12000,4400);
    B = rand(12000,4400);

    if ~mod(epoch,10)
        elapsedTime = duration(0,0,toc(start),"Format","hh:mm:ss");
        estimatedRemainingTime = (numEpochs/epoch-1)*elapsedTime; % Linear estimation
        currentTime = datetime("now","format","dd/MM/yyyy HH:mm:ss"); % Attention here: "dd/MM/yyyy HH:mm:ss", not "dd/MM/yyyy hh:mm:ss"
        ETA = currentTime+estimatedRemainingTime;

        fprintf("%s/%s (%.2f%%), Elapsed time: %s, Estimated remaining time: %s, Current time: %s, ETA: %s\n", ...
            num2str(epoch),num2str(numEpochs),epoch/numEpochs*100, ...
            elapsedTime,estimatedRemainingTime, ...
            currentTime,ETA);
    end
end
```

```
10/100 (10.00%), Elapsed time: 00:00:09, Estimated remaining time: 00:01:29, Current time: 25/03/2024 05:01:40, ETA: 25/03/2024 05:03:09
20/100 (20.00%), Elapsed time: 00:00:19, Estimated remaining time: 00:01:18, Current time: 25/03/2024 05:01:50, ETA: 25/03/2024 05:03:08
30/100 (30.00%), Elapsed time: 00:00:29, Estimated remaining time: 00:01:08, Current time: 25/03/2024 05:01:59, ETA: 25/03/2024 05:03:07
40/100 (40.00%), Elapsed time: 00:00:38, Estimated remaining time: 00:00:58, Current time: 25/03/2024 05:02:09, ETA: 25/03/2024 05:03:07
50/100 (50.00%), Elapsed time: 00:00:48, Estimated remaining time: 00:00:48, Current time: 25/03/2024 05:02:19, ETA: 25/03/2024 05:03:07
60/100 (60.00%), Elapsed time: 00:00:58, Estimated remaining time: 00:00:38, Current time: 25/03/2024 05:02:28, ETA: 25/03/2024 05:03:07
70/100 (70.00%), Elapsed time: 00:01:07, Estimated remaining time: 00:00:29, Current time: 25/03/2024 05:02:38, ETA: 25/03/2024 05:03:07
80/100 (80.00%), Elapsed time: 00:01:17, Estimated remaining time: 00:00:19, Current time: 25/03/2024 05:02:48, ETA: 25/03/2024 05:03:07
90/100 (90.00%), Elapsed time: 00:01:27, Estimated remaining time: 00:00:09, Current time: 25/03/2024 05:02:57, ETA: 25/03/2024 05:03:07
100/100 (100.00%), Elapsed time: 00:01:36, Estimated remaining time: 00:00:00, Current time: 25/03/2024 05:03:07, ETA: 25/03/2024 05:03:07
```

where `elapsedTime` and `estimatedRemainingTime` are `duration` data type[^2], and `currentTime` and `ETA` are `datetime` data type[^3]:

```
>> whos elapsedTime estimatedRemainingTime currentTime ETA
  Name                        Size            Bytes  Class       Attributes

  ETA                         1x1                46  datetime              
  currentTime                 1x1                46  datetime              
  elapsedTime                 1x1                24  duration              
  estimatedRemainingTime      1x1                24  duration              
```

Anyway, the ability to perform arithmetic operations between  `duration` and `datetime` data types makes it convenient to estimate loop end time.

<br>

**References**

- [MATLAB `tic`: Start stopwatch timer - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/tic.html).

[^2]: [MATLAB `duration`: Lengths of time in fixed-length units - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/duration.html).
[^3]: [MATLAB `datetime`: Arrays that represent points in time - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/datetime.html).
