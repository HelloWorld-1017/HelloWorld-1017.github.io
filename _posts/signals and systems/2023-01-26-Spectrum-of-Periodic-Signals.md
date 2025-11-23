---
title: Spectrum of Periodic Signals
categories: 
 - Signals and Systems
 - MATLAB
tags:
 - MATLAB Object-Oriented Programming
 - MATLAB Signal Processing Toolbox
date: 2023-01-26 17:10:11 +0800
last_modified_at: 2025-11-23 16:58:14 -0500
---

# Unilateral Spectrum and Bilateral Spectrum of Periodic Signals

在博客[Fourier Series of Periodic Signals](http://whatastarrynight.com/signals%20and%20systems/matlab/Fourier-Series-of-Periodic-Signals/)中，我们介绍了周期信号的三角形式的傅里叶级数：

> $$
> f(t)=a_0+\sum_{n=1}^\infty a_n\cos(n\Omega t)+\sum_{n=1}^\infty b_n\sin(n\Omega t)
> $$
>
> 其中傅里叶系数为：
> 
> $$
> \begin{split}
> &a_n=\dfrac2T\int_{-T/2}^{T/2}f(t)\cos(n\Omega t)\mathrm{d}t\quad(n=0,1,2,\cdots)\\
> &b_n=\dfrac2T\int_{-T/2}^{T/2}f(t)\sin(n\Omega t)\mathrm{d}t\quad(n=1,2,\cdots)\\
> \end{split}\label{eq2}
> $$
> 
> 余弦形式的傅里叶级数为：
> 
> $$
> f(t)=\dfrac{A_0}2+\sum_{n=1}^\infty A_n\cos(n\Omega t+\varphi_n)
> $$
> 
> 其中：
> 
> $$
> \left\{
> \begin{split}
> A_n&=\sqrt{a_n^2+b_n^2}\\
> \varphi_n&=-\arctan\dfrac{b_n}{a_n}
> \end{split}
> \right.
> $$

指数形式的傅里叶级数：

> $$
> f(t)=\sum_{n=-\infty}^{\infty}F_n\mathrm{e}^{\mathrm{j}n\Omega t}
> $$
>
> 其中：
> 
> $$
> \begin{split}
> F_n&=\dfrac1T\int_{-T/2}^{T/2}f(t)\mathrm{e}^{-\mathrm{j}n\Omega t}\mathrm{d}t,\quad n=0,\pm1,\pm2,\cdots
> \end{split}\label{eq3}
> $$

以及两者之间的关系（左端为指数形式，右端为余弦形式）：

> $$
> \begin{split}
> \vert F_n\vert&=\dfrac12{A_n}\\
> \Phi&=\varphi
> \end{split}
> $$

周期信号分解后，绘制出各分量的幅度和相位随频率的变化（将幅度和相位分量用一定高度的直线表示），就可以得到周期信号的**幅度谱**和**相位谱**。其中，幅度谱反映了信号不同频率分量的大小。

三角形式与指数形式的傅里叶级数所对应的频谱分别是单边谱（单边幅度谱，单边相位谱）和双边谱（双边幅度谱，双边相位谱）。

![image-20230125183057330](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230125183057330.png?raw=true)

注：绘制双边谱并不意味着我们现实生活中存在负的频率，而是因为引入复数以后，正频率和负频率是一对。在数学上看，负数运算比三角函数的运算简单得多。
{: .notice--primary}

<br>

# Relation Between Unilateral and Bilateral Spectrum

（1）$\vert F_n\vert$是$n$的偶函数，双边幅度谱的谱线高度为单边幅度谱的一半，且关于纵轴对称；**而直流分量值不变**。

（2）$\Phi_n$是$n$的奇函数，双边相位谱可以由单边相位谱直接关于零点奇对称得到；

<br>

# Spectrum of Periodic Rectangle Pulse

## Periodic Rectangle Pulse

有一幅度为1，周期为$T$，脉冲宽度为$\tau$的周期矩形脉冲，如图所示：

![image-20220710135204578](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220710135204578.png?raw=true)

求其三角型傅里叶级数和指数型傅里叶级数。

## Trianglular Form (Cosine Form) Fourier Series

由于周期矩形脉冲$g_\tau(t)$为偶函数，因此式$\eqref{eq2}$中的$b_n$项积分为0，只需要计算余弦系数分量$a_n$：

$$
\begin{align*}
a_n&=\dfrac{2}{T}\int^{\frac{\tau}{2}}_{-\frac{\tau}{2}}\cos(n\Omega t)\mathrm{d}t\\
&=\dfrac{2}{n\Omega T}\int^{\frac{\tau}{2}}_{-\frac{\tau}{2}}\cos(n\Omega t)\mathrm{d}(n\Omega t)\\
&=\dfrac{2}{n\pi}\sin(n\Omega\dfrac{\tau}{2})\\
&=\dfrac{2}{n\pi}\sin(n\pi \dfrac{\tau}{T})\\
&=\dfrac{2\tau}{T}\mathrm{Sa}(n\pi \dfrac{\tau}{T})\quad (n=0,1,2,\cdots)
\end{align*}
$$

式中，$\mathrm{Sa}(x)=\dfrac{\sin x}{x}$为抽样函数。于是，周期矩形脉冲$g_\tau(t)$的三角形式傅里叶级数为：

$$
g_T(t)=\dfrac{\tau}{T}+\sum^{\infty}_{n=1}\dfrac{2\tau}{T}\mathrm{Sa}(n\pi \dfrac{\tau}{T})\cos(n\Omega t)\label{eq4}
$$

该公式也是余弦形式的傅里叶级数，因此可以直接根据它来绘制周期信号$g_T(t)$的单边频谱。

## Exponential Form (Cosine Form) Fourier Series

根据式$\eqref{eq3}$，可以计算得到周期矩形脉冲$g_T(t)$的傅里叶系数$F_n$为：

$$
\begin{align*}
F_n&=\dfrac{1}{T}\int^{\frac{\tau}{2}}_{-\frac{\tau}{2}}e^{-\mathrm{j}n\Omega t}\mathrm{d}t\\
&=\dfrac{-1}{\mathrm{j}n\Omega T}e^{-\mathrm{j}n\Omega t}|^{\frac{\tau}{2}}_{-\frac{\tau}{2}}\\
&=\dfrac{1}{\mathrm{j}n2\pi}[e^{\mathrm{j}n\Omega \frac{\tau}{2}}-e^{-\mathrm{j}n\Omega \frac{\tau}{2}}]\\
&=\dfrac{1}{n\pi}\dfrac{[e^{\mathrm{j}n\Omega \frac{\tau}{2}}-e^{-\mathrm{j}n\Omega \frac{\tau}{2}}]}{2j}\\
&=\dfrac{1}{n\pi}\sin(n\Omega \frac{\tau}{2})\\
&=\dfrac{\Omega \tau}{2\pi}\dfrac{\sin(n\Omega \frac{\tau}{2})}{n\Omega \frac{\tau}{2}}\\
&=\dfrac{\tau}{T}\mathrm{Sa}(n\pi\dfrac{\tau}{T})\qquad n=0,\pm 1, \pm 2,\cdots
\end{align*}
$$

周期矩形脉冲$g_T(t)$的虚指数形式傅里叶级数：

$$
g_T(t)=\sum^{\infty}_{n=-\infty}\dfrac{\tau}{T}\mathrm{Sa}(n\pi\dfrac{\tau}{T})e^{\mathrm{j}n\Omega t}\label{eq5}
$$

## Spectrum of Periodic Rectangle Pulse

总结式$\eqref{eq4}$和式$\eqref{eq5}$得到结论：

>给定的周期矩形脉冲$g_T(t)$的三角函数形式级数和虚指数函数级数分别为：
>
>$$
>\begin{align*}
>三角函数（余弦）形式傅里叶级数：& g_T(t) =\dfrac{\tau}{T}+\sum^{\infty}_{n=1}\dfrac{2\tau}{T}\mathrm{Sa}(n\pi \dfrac{\tau}{T})\cos(n\Omega t)\\
>虚指数函数形式傅里叶级数：& g_T(t) =\sum^{\infty}_{n=-\infty}\dfrac{\tau}{T}\mathrm{Sa}(n\pi\dfrac{\tau}{T})\mathrm{e}^{\mathrm{j}n\Omega t}
>\end{align*}
>$$

可以看到，周期矩形脉冲$g_T(t)$的相位谱均为0，因此，我们只需要绘制出单边幅度谱和双边幅度谱即可。

我们考虑两种趋势下的频谱变化情况：

**（1）$\tau$不变，增大$T$的值**

![image-20230126174004648](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230126174004648.png?raw=true)

> ```matlab
> clc, clear, close all
> 
> figure
> tiledlayout(3,2)
> for i = [4,8,16]
>     nexttile
>     a = RectanglePulse(1,i,20,20);
>     a.Plot;
> 
>     nexttile
>     a.PlotUniSpec;
>     hold on
>     a.PlotBiSpec;
> end
> ```
>
> 在上面的代码中，我定义了一个`RectanglePulse`类，类的定义见文末的附录。

可以看到：当保持$\tau$不变，而$T$增大时，则频谱的的幅度下降，间隔$\Omega$减小，频谱变密。我们可以合理猜想：当$T\rightarrow\infty$时，谱线间隔$\Omega=\dfrac{2\pi}T\rightarrow0$，谱线幅度$\rightarrow0$，周期信号的**连续频谱**过渡为非周期信号的**连续频谱**。

**（2）$T$不变，减小$\tau$的值**

![image-20230126174331163](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230126174331163.png?raw=true)

> ```matlab
> clc, clear, close all
> 
> figure
> tiledlayout(3,2)
> for i = [8,4,2]
>     nexttile
>     a = RectanglePulse(i,20,20,20);
>     a.Plot;
> 
>     nexttile
>     a.PlotUniSpec;
>     hold on
>     a.PlotBiSpec;
> end
> ```

可以看到：随着时域波形的压缩，周期矩形脉冲的**频域展宽**（“频域展宽”是指零点和零点之间的距离扩展）。

> 幅度$\dfrac{\tau}{T}$减小；$T$不变，所以$\Omega$不变；零点间距$\dfrac{2\pi}{\tau}$增大，所以零点间的谱线数增加。

另外，根据这个例子，我们也可以看到周期信号频谱的特点：

（1）**离散性**：以基频$\Omega=\dfrac{2\pi}{T}$为间隔的若干离散谱线组成；

（2）**谐波性**：谱线仅含有基频$\Omega$的整数倍分量；

（3）**收敛性**：整体趋势减小；

<br>

#  Appendix: `RectanglePulse` Class

```matlab
classdef RectanglePulse < handle
    properties
        tau = 1;         % Rectangle pulse width
        Period  % Period
        Omega   % Fundamental frequency
        Delays  % Pulse delay position
        rectanglePulse % Time-domain waveform
        tlim    % Time limit
        flim    % Frequency limit
        time    % Time vector
    end

    methods
        % Constructor
        function obj = RectanglePulse(tau, Period, tlim, flim)
            % Initialize
            obj.tau = tau;
            obj.tlim = tlim;
            obj.flim = flim;

            % Calculate period and angular frequency
            obj.Period = Period;
            obj.Omega = 2*pi/obj.Period;

            % Obtain time vector
            obj.time = -obj.tlim:0.01:obj.tlim;

            % Consturct periodic rectangle pulse
            % Refer to https://ww2.mathworks.cn/help/signal/ug/signal-generation-and-visualization.html#SignalGenerationExample-4
            RightDelays = 0:obj.Period:max(obj.time);
            LeftDelays = -fliplr(RightDelays);
            obj.Delays = [LeftDelays(1:end-1), RightDelays];
            obj.rectanglePulse = pulstran(obj.time,obj.Delays,@rectpuls,tau);
        end

        % Plot periodic rectangle pulse
        function Plot(obj)
            plot(obj.time, obj.rectanglePulse, 'k')
            box(gca, "on")
            xlabel('t')
            ylabel('f(t)')
            set(gca, 'YTick', [0,1])
            set(gca, 'Xtick', obj.Delays)
            title(['$\tau=$',num2str(obj.tau), ...
                '$, T=$', num2str(obj.Period), ...
                '$, T/\tau=$', num2str(obj.Period/obj.tau)], 'Interpreter', 'latex')
            set(gca, 'FontSize', 13)
        end

        % Plot Unilateral Spectrum for cosine form series
        function PlotUniSpec(obj)
            Unifreq = 0:obj.Omega:obj.flim;
            n = Unifreq/obj.Omega;
            an = 2*obj.tau/obj.Period*Sa(n*pi*obj.tau/obj.Period);
            stem(Unifreq, an, 'filled', 'MarkerSize', 4, ...
                'DisplayName', 'Unilateral Spectrum')
            xlabel('$\Omega$ (Hz)', 'Interpreter', 'latex')
            ylabel('Amplitude')
            title(['$\Omega=$', num2str(obj.Omega)], 'Interpreter', 'latex')
            legend();
            set(gca, 'FontSize', 13)
        end

        % Plot Bilateral Spectrum for exponential form series
        function PlotBiSpec(obj)
            Unifreq = 0:obj.Omega:obj.flim;
            Bifreq = [-fliplr(Unifreq), Unifreq];
            n = Bifreq/obj.Omega;
            an = obj.tau/obj.Period*Sa(n*pi*obj.tau/obj.Period);
            obj.Omega = 2*pi/obj.Period;
            stem(Bifreq, an, 'filled', 'MarkerSize', 4, ...
                'DisplayName', 'Bilateral Spectrum')
            xlabel('$\Omega$ (Hz)', 'Interpreter', 'latex')
            ylabel('Amplitude')
            ylim([-0.2,1])
            title(['$\Omega=$', num2str(obj.Omega)], 'Interpreter', 'latex')
            legend();
            set(gca, 'FontSize', 13)
        end
    end
end

% Reconstruct sinc function
% Refer to: https://ww2.mathworks.cn/help/signal/ref/sinc.html
function y = Sa(x)
y = sinc(x/pi);
end
```

<br>

**References**

[1] [信号与线性系统分析 吴大正 郭宝龙 - bilibili](https://www.bilibili.com/video/BV16E411E7PA/?spm_id_from=333.337.search-card.all.click)



