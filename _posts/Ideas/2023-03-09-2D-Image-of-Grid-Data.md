---
title: "2D Image of Grid Data"
toc: false
categories: 
 - Ideas
 - Uncertainty
 - MATLAB
 - Electrical Engineering
 - Machine Learning
 - Finite Element Simulation
 - Physics
tags:
 - Computational Fluid Dynamics
 - MATLAB Graphics
 - Circuit Breaker
date: 2023-03-09 22:24:25 +0800
last_modified_at: 2024-07-17 12:25:38 +0800
---

博客[^1] 介绍了MATLAB提供的一个示例[^2]，该示例使用在建模Solenoid时，使用了外部导入的FEM数据，包括磁链数据`flux_linkage`和电磁力数据`force`：

```
>> flux_linkage
flux_linkage =
         0         0         0         0         0
    0.0085    0.0079    0.0075    0.0071    0.0067
    0.0171    0.0160    0.0151    0.0143    0.0137
    0.0254    0.0239    0.0226    0.0215    0.0206
    0.0330    0.0312    0.0297    0.0283    0.0271
    0.0396    0.0377    0.0360    0.0345    0.0331
    0.0452    0.0433    0.0415    0.0399    0.0384
    0.0495    0.0478    0.0461    0.0446    0.0431
    0.0526    0.0512    0.0498    0.0485    0.0472
    0.0545    0.0537    0.0528    0.0519    0.0508
    0.0554    0.0553    0.0551    0.0548    0.0542
```

```
>> force
force =
         0         0         0         0         0
   -0.6000   -0.5000   -0.4000   -0.3000   -0.3000
   -2.3000   -2.0000   -1.7000   -1.4000   -1.2000
   -4.9000   -4.3000   -3.7000   -3.2000   -2.7000
   -8.3000   -7.3000   -6.4000   -5.5000   -4.7000
  -12.2000  -10.7000   -9.4000   -8.2000   -7.2000
  -16.2000  -14.4000  -12.7000  -11.3000  -10.0000
  -20.0000  -17.9000  -15.9000  -14.3000  -12.9000
  -23.3000  -20.9000  -18.8000  -17.1000  -15.7000
  -25.7000  -23.1000  -21.1000  -19.4000  -18.2000
  -26.5000  -24.1000  -22.2000  -20.9000  -20.1000
```

这两个变量都是11行5列，行对应的是电流`current`，而列对应的是行程`x`：

```
>> current
current =
0    0.1000    0.2000    0.3000    0.4000    0.5000    0.6000    0.7000    0.8000    0.9000    1.0000
```

```
>> x
x =
   1.0e-03 *
         0    0.0500    0.1000    0.1500    0.2000
```

官方示例在呈现这两个数据是采用三维曲面的形式，例如对于磁链网格数据：

```matlab
% Plot 'Flux linkage'
surf(x,current,flux_linkage,'FaceColor',[1 0 0],'FaceAlpha',0.5);
% Plot settings
title('Flux Linkaget')
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('Flux linkage (Wb)')
```

![image-20230309192711187](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230309192711187.png?raw=true)

并且为了后续将磁链网格数据关于电流和行程求偏导，对这个网格数据进行了最小二乘多项式拟合，并对比了原始的和拟合的磁链网格三维图像：

```matlab
% Calculate partial derivatives for block parameterization in terms of
% dPhi(i,x)/dx and dPhi(i,x)/di. To do this, use least squares to find
% a smooth differentiable function fit to flux.
[b,a]=meshgrid(x,current+1e-5); % 1e-5 offset to avoid zero current; b and a, 11-by-5
a=a(:); b=b(:); data_coeff = flux_linkage(:);% Unwrapped to column vectors
X = [a.^3 b.*a.^2 a.^2 a b a.*b]; % X, 55-by-6
Coeff = (X'*X)\(X'*data_coeff);% Solve normal equation to get least square solution, ie Coeff; Coeff, 6-by-1
flux_linkage2 = reshape(X*Coeff,length(current),length(x));% flux_linkage2, 11-by-5.

view(-37.5,30)
hold(gca,"on")
% Plot 'Flux linkage'
surf(x,current,flux_linkage,'FaceColor',[1 0 0],'FaceAlpha',0.5);
% Plot 'Polynomial fit'
surf(x,current,flux_linkage2,'FaceColor',[0 0 1],'FaceAlpha',0.5);
% Plot settings
title('Flux Linkage vs. Current and Displacement')
xlabel('Displacement (m)')
ylabel('Current (A)')
zlabel('Flux linkage (Wb)')
axis([0 2e-4 0 1 0 0.06])
legend({'Flux Linkage Data','Polynomial Fit'},'Location','Best')
grid on
hold(gca, "off")
```

![image-20230309193656850](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230309193656850.png?raw=true)

<br>

但是今天看了一篇文献[^3]，这篇论文为使用机器学习技术求解PDEs（Partial Differential Equations），即*Scientific Machine Learning*领域（or *machine learning for physical sciences* or *data driven science*），提供了一个新的benchmark，很有意思。

这篇论文在描述类似的一个因变量随两个自变量变化时，采用的是用颜色区分的二维图像，例如：

![image-20230309193928500](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230309193928500.png?raw=true)

仿照这种形式，我重新对上述示例中的数据进行了绘制。一共绘制了三个图像，第一个是原始数据的图像，第二个是拟合数据的图像；由于得到了显示的拟合公式，因此就可以细分网格，对拟合数据的图像进行平滑，因此第三个是平滑后的拟合数据图像：

```matlab
clc,clear,close all

load data.mat

% Calculate fitting polynomials and create corresponding flux data grid
[b, a]=meshgrid(x,current+1e-5); % 1e-5 offset to avoid zero current
a=a(:); % Current
b=b(:); % Stroke
data_coeff = flux_linkage(:);
X = [a.^3 b.*a.^2 a.^2 a b a.*b]; % X, 55-by-6
Coeff = (X'*X)\(X'*data_coeff);% 6-by-1
flux_linkage1 = reshape(X*Coeff,length(current),length(x));% flux_linkage1

% Create smoothed flux linakge data grid
new_current = linspace(0,1,200)'; % Current 
new_stroke = linspace(0,0.2e-3,200)';% Stroke
[b, a]=meshgrid(new_stroke, new_current+1e-5); % 1e-5 offset to avoid zero current
a = a(:);
b = b(:);
new_X = [a.^3 b.*a.^2 a.^2 a b a.*b];
flux_linkage2 = reshape(new_X*Coeff,length(new_current),length(new_stroke));

figure('Position',[149,360,1339,396])
tiledlayout(1,3)

nexttile
axis(gca,"equal")
imagesc(current, x, flux_linkage)
xlabel("Current")
ylabel("Stroke")
title("Flux Linkage Data")
colormap("jet")
colorbar
set(gca, "YDir", "normal")

nexttile
axis(gca,"equal")
imagesc(current,x,flux_linkage1)
xlabel("Current")
ylabel("Stroke")
title("Polynomial Fit")
colormap("jet")
colorbar
set(gca, "YDir", "normal")

nexttile
axis(gca,"equal")
imagesc(new_current,new_stroke,flux_linkage2)
xlabel("Current")
ylabel("Stroke")
title("Smoothed Polynomial Fit")
colormap("jet")
colorbar
set(gca, "YDir", "normal")
```

![image-20230309194820001](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230309194820001.png?raw=true)

这种图形的表现形式更加得紧凑；并且将数据表现为这样的图像后，就可能有更多的应用。

例如，文献[^4]就将时间序列编码成矩阵数据后，将其表示为图像（利用Gramian Angular Fields（GAF）和Markov Transition Fields （MTF）方法），之后依据图像信息训练了一个CNN分类器：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230309222100713.png?raw=true" alt="image-20230309222100713" style="zoom: 33%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230309222119453.png?raw=true" alt="image-20230309222119453" style="zoom: 33%;" />

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230309222136502.png?raw=true" alt="image-20230309222136502" style="zoom: 33%;" />

还是一个比较有意思的工作。

<br>

**References**

[^1]: [Build a Solenoid Parameterized with FEM Data using MATLAB Simulink - What a starry night~](https://helloworld-1017.github.io/2022-08-28/14-49-01.html).
[^2]: [Solenoid Parameterized with FEM Data - MathWorks](https://ww2.mathworks.cn/help/sps/ug/solenoid-parameterized-with-fem-data.html).
[^3]: [PDEBENCH: An Extensive Benchmark for Scientific Machine Learning](https://arxiv.org/abs/2210.07182).
[^4]: [Encoding Time Series as Images for Visual Inspection and Classification Using Tiled Convolutional Neural Networks](https://www.researchgate.net/publication/275970614_Encoding_Time_Series_as_Images_for_Visual_Inspection_and_Classification_Using_Tiled_Convolutional_Neural_Networks).