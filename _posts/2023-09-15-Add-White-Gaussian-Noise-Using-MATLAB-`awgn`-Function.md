---
layout: single
title: Add White Gaussian Noise Using MATLAB `awgn` Function
date: 2023-09-15 01:28:07 +0800
categories:
 - MATLAB
 - Signals and Systems
 - Machine Learning
tags:
 - MATLAB Communications Toolbox
toc: false
---

MATLAB provides an easy function to add white Gaussian noise into original signals, i.e. `awgn` [1], and whose documentation shows an example to illustrate how to use it:

```matlab
t = (0:0.1:60)';
x = sawtooth(t);

SNR_dB = 10;
y = awgn(x,SNR_dB,'measured');
plot(t,[x y])
legend('Original Signal','Signal with AWGN')
```

<img src="https://raw.githubusercontent.com/Ma1017/blog-images/main/image-20230914233316928.png" alt="image-20230914233316928" style="zoom:50%;" />

However, the documentation does not list the detailed calculation formula, and recently I plan to use this function in my research, so I want to get into it. 

I have debugged the `awgn`  function step by step while running this example, and found that the main calculation codes are shown as follows: 

```matlab
function [y,noisePower] = awgn(sig,reqSNR,varargin)
% MATLAB version: 9.12.0.1884302 (R2022a)
...
sigPower = sum(abs(sig(:)).^2)/numel(sig); % linear (line 79)
...
reqSNR = 10^(reqSNR/10); % linear (line 128)
...
noisePower = sigPower/reqSNR; % linear (line 131)
...
noise = sqrt(noisePower)* randn(size(sig)); % linear (line 152)
...
y = sig + noise; % linear (line 156)
end
```

If we suppose that $x$  and $noise$ represent input signal `sig` and additive white Gaussian noise, respectively, $\mathrm{SNR}_{\mathrm{dB}}$ is SNR (Signal-to-noise ratio) [2] in decibel unit `reqSNR`, we could obtain the computation expression:

$$
noise \sim \sqrt{\dfrac{(1/n)\sum\vert x_i\vert^2}{10^{\mathrm{SNR_{dB}}/10}}}\times\mathscr{N}(0,1)
$$

i.e., 

$$
\begin{split}
noise & \sim \sqrt{\dfrac{P_{\mathrm{signal}}}{\mathrm{SNR}}}\times\mathscr{N}(0,1)\\
& \sim \sqrt{\dfrac{P_{\mathrm{signal}}}{P_{\mathrm{signal}}/P_{\mathrm{noise}}}}\times\mathscr{N}(0,1)\\
& \sim \mathscr{N}(0,P_{\mathrm{noise}})
\end{split}
$$

Which means that the noise is random sampled from $\mathscr{N}(0,P_{\mathrm{noise}})$, where $P_{\mathrm{noise}}$ is power of noise term. We could verify it in an easy way:

```matlab
P_signal = sum(x.^2)/numel(x);
P_noise1 = P_signal/10^(SNR_dB/10); % P_signal/SNR
P_noise2 = sum((y-x).^2)/numel(x); % P_noise calculated from noise
disp(P_signal)
disp(P_noise1)
disp(P_noise1-P_noise2)
```

```
0.3319
0.0332
2.8030e-04
```

Note that in this example, the power of signal is calculated on input signal: 

$$
P_\mathrm{signal} = \dfrac1n\sum\vert x_i\vert^2
$$

as the `signalpower` property of `awgn` function is set to `‘measured’`. Actually, we could specify other double value for `signalpower` property:

<img src="https://raw.githubusercontent.com/Ma1017/blog-images/main/image-20230915002737115.png" alt="image-20230915002737115" style="zoom:50%;" />

> The documentation does not provide the default setting for `signalpower` property, but we could find that the default value is `1` from whose source code:
>
> ![image-20230915003016283](https://raw.githubusercontent.com/Ma1017/blog-images/main/image-20230915003016283.png)

For instance, we could specify `signalpower`  is `0.8`:

```matlab
t = (0:0.1:60)';
x = sawtooth(t);

SNR_dB = 10;
sigPower = 0.8;
y = awgn(x,SNR_dB,sigPower);

P_signal = 10^(sigPower/10); % NOTE well here: unit of sigPower is dB
P_noise1 = P_signal/10^(SNR_dB/10); % P_signal/SNR
P_noise2 = sum((y-x).^2)/numel(x); % P_noise calculated from noise
disp(P_signal)
disp(P_noise1)
disp(P_noise1-P_noise2)
```

```
1.2023
0.1202
0.0083
```

We could find that, although we set `sigPower` to `0.8`, the value of `P_signal` is `1.203` instead. The reason is `awgn` function set default unit for `sigPower` to dB:

<img src="https://raw.githubusercontent.com/Ma1017/blog-images/main/image-20230915010819218.png" alt="image-20230915010819218" style="zoom:50%;" />

So, if we want to set `sigPower` to `0.8` watts, we should specified as follow:

```matlab
t = (0:0.1:60)';
x = sawtooth(t);

SNR_dB = 10;
sigPower = 0.8;
y = awgn(x,SNR_dB,sigPower,'linear');

P_signal = sigPower; % unit of sigPower is watt
P_noise1 = P_signal/10^(SNR_dB/10); % P_signal/SNR
P_noise2 = sum((y-x).^2)/numel(x); % P_noise calculated from noise
disp(P_signal)
disp(P_noise1)
disp(P_noise1-P_noise2)
```

```
0.8000
0.0800
6.9677e-04
```

<br>

**References**

[1] [awgn - MathWorks](https://www.mathworks.com/help/comm/ref/awgn.html).

[2] [Signal-to-noise ratio - Wikipedia](https://en.wikipedia.org/wiki/Signal-to-noise_ratio).



