---
title: Cubic Bezier Curve Fitting and Third Polynomial Curve Fitting
categories: 
 - Mathematics
 - MATLAB
tags:
 - Geometry
 - Numerical Analysis
 - Optimization
date: 2022-11-24 16:36:32 +0800
last_modified_at: 2024-10-05 21:05:23 +0800
---

# Bezier curve fitting

Schneider P J.在其1990年发表的论文"An algorithm for automatically fitting digitized curves" [1] 中详细地阐述了四个控制点的三阶Bezier曲线的拟合方法。

具有四个控制点的三阶Bezier曲线示意图如下图所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/schematics.png?raw=true" alt="schematics" style="zoom:50%;" />

该Bezier曲线对应的参数方程为：

$$
\begin{split}
Q(t)&=B_0^3(t)V_0+B_1^3(t)V_1+B_2^3(t)V_2+B_3^3(t)V_3\\
&=B_0^3(t)V_0+B_1^3(t)(\alpha_1\hat{t}_1+V_0)+B_2^3(t)(\alpha_2\hat{t}_2+V_3)+B_3^3(t)V_3
\end{split}\label{eqQ}
$$

其中，$B_i^n(t)$是自由度为$n$的Bernstein多项式：

$$
B_i^n(t)=\binom{n}{i}t^i(1-t)^{n-i},\quad i=0,\cdots,n
$$

首先近似计算端点处(即$V_0$和$V_3$处)的切线方向，相当于固定上图中的向量$\hat{t}_1$和$\hat{t}_2$。可以采用的方法：

1. fit a least-squares line to the points in the neighborhood of the endpoints;
2. averaging vectors from the endpoints to the next $n$ points(本文采用的方法);

之后，对X-Y平面内的数据点$d_i$进行参数化，将$d_i$与参数值$u_i$对应，采用的方法是chord-length parameterization(详见博客[5])。

最后采用最小二乘拟合方法求解未知系数$\alpha_1$和$\alpha_2$。最小二乘方法的目标函数为：

$$
S=\vert\vert P-Q(t)\vert\vert^2_2=\sum_{i=1}^n[d_i-Q(u_i)]^2\label{eqS}
$$

其中，$d_i$是给定数据点的$(x,y)$坐标；$u_i$与$d_i$相联系的parameter value。

根据式$\eqref{eqQ}$，可以得到：

$$
\begin{split}
Q(u_i)&=B_0^3(u_i)V_0+B_1^3(u_i)V_1+B_2^3(u_i)V_2+B_3^3(u_i)V_3\\
&=B_0^3(u_i)V_0+B_1^3(u_i)(\alpha_1\hat{t}_1+V_0)+B_2^3(u_i)(\alpha_2\hat{t}_2+V_3)+B_3^3(u_i)V_3
\end{split}
$$

将式$\eqref{eqS}$分别对$\alpha_1$和$\alpha_2$求偏导，并令其为零：

$$
\begin{split}
\dfrac{\partial S}{\partial \alpha_1}&=0\\
\dfrac{\partial S}{\partial \alpha_2}&=0\\
\end{split}
$$

以$\dfrac{\partial S}{\partial \alpha_1}=0$为例进行分析。

$$
\begin{split}
\dfrac{\partial S}{\partial \alpha_1}&=2\sum_{i=1}^n[d_i-Q(u_i)]\dfrac{\partial Q(u_i)}{\partial\alpha_1}\\
&=2\sum_{i=1}^n[d_i-Q(u_i)]\cdot\hat{t}_1B_1^3(u_i)=0
\end{split}
$$

进一步可以得到：

$$
\sum_{i=1}^nd_i\hat{t}_1B_1^3(u_i)=\sum_{i=1}^nQ(u_i)\hat{t}_1B_1^3(u_i)\label{eq1}
$$

为了简化计算，我们记：

$$
\begin{split}
&A_{i,1}=\hat{t}_1B_1^3(u_i)\\
&A_{i,2}=\hat{t}_2B_2^3(u_i)\\
\end{split}
$$

则式$\eqref{eq1}$可以写为：

$$
\sum_{i=1}^nd_iA_{i,1}=\sum_{i=1}^nQ(u_i)A_{i,1}\label{eq2}
$$

将式$\eqref{eq2}$的右端展开，可以得到：

$$
\begin{split}
\mathrm{Right}&=\sum_{i=1}^n\Big(B_0^3(u_i)V_0+B_1^3(u_i)(\alpha_1\hat{t}_1+V_0)+B_2^3(u_i)(\alpha_2\hat{t}_2+V_3)+B_3^3(u_i)V_3\Big)A_{i,1}\\
&=\sum_{i=1}^n\Big(A_{i,1}B_0^3(u_i)V_0+\alpha_1A_{i,1}^2+A_{i,1}B_1^3(u_i)V_0+\alpha_2A_{i,1}A_{i,2}+A_{i,1}B_2^3(u_i)V_3+A_{i,1}B_3^3(u_i)V_3\Big)\\
\end{split}
$$

于是，式$\eqref{eq1}$可以改写为：

$$
\begin{split}
(\sum_{i=1}^nA_{i,1}^2)\alpha_1+(\sum_{i=1}^nA_{i,1}A_{i,2})\alpha_2&=\sum_{i=1}^n\Big(d_i-(B_0^3(u_i)V_0+B_1^3(u_i)V_0+B_2^3(u_i)V_3+B_3^3(u_i)V_3)\Big)A_{i,1}
\end{split}\label{eq3}
$$

同理，由$\dfrac{\partial S}{\partial \alpha_2}=0$可以得到：

$$
\begin{split}
(\sum_{i=1}^nA_{i,1}A_{i,2})\alpha_1+(\sum_{i=1}^nA_{i,2}^2)\alpha_2&=\sum_{i=1}^n\Big(d_i-(B_0^3(u_i)V_0+B_1^3(u_i)V_0+B_2^3(u_i)V_3+B_3^3(u_i)V_3)\Big)A_{i,2}
\end{split}\label{eq4}
$$

由式$\eqref{eq3}$和$\eqref{eq4}$可以构成方程组：

$$
\begin{bmatrix}
\sum_{i=1}^nA_{i,1}^2 & \sum_{i=1}^nA_{i,1}A_{i,2}\\
\sum_{i=1}^nA_{i,1}A_{i,2} & \sum_{i=1}^nA_{i,2}^2
\end{bmatrix}\begin{bmatrix}\alpha_1\\ \alpha_2\end{bmatrix}=
\begin{bmatrix}
\sum_{i=1}^n\Big(d_i-(B_0^3(u_i)V_0+B_1^3(u_i)V_0+B_2^3(u_i)V_3+B_3^3(u_i)V_3)\Big)A_{i,1}\\
\sum_{i=1}^n\Big(d_i-(B_0^3(u_i)V_0+B_1^3(u_i)V_0+B_2^3(u_i)V_3+B_3^3(u_i)V_3)\Big)A_{i,2}
\end{bmatrix}\\
$$

求解上述方程组，即可得到$\alpha_1$和$\alpha_2$的值。

<br>

# Third polynomial fitting with endpoints constrain

由四个控制点拟合的函数是三阶多项式，实际上，我们可以直接使用三阶多项式在XY平面进行最小二乘拟合，并限制端点的值相同。

假设三阶多项式为：

$$
P_3(x)=k_3x^3+k_2x^2+k_1x+k_0
$$

拟合的数据点为$P_i(x_i,y_i)$，则可以得到最小二乘拟合问题：

$$
\begin{split}
&S=\vert\vert P-P_3(x)\vert\vert_2\\
\mathrm{s.t}&\left\{
\begin{split}
&P_3(x_1)=y_1\\
&P_3(x_n)=y_n
\end{split}
\right.
\end{split}
$$

使用拉格朗日乘子法将上式带等式约束的优化问题转换为无约束的优化问题：

$$
\min\ Q=\min\sum_{i=1}^n(y_i-P_3(x_i))^2+\lambda_1\big[P_3(x_1)-y_1\big]+\lambda_2\big[P_3(x_n)-y_n\big]
$$

经过推导，可以得到：

$$
\begin{split}
\dfrac{\partial Q}{\partial k_3}&=0\Rightarrow(2\sum x_i^6)k_3+(2\sum x_i^5)k_2+(2\sum x_i^4)k_1+(2\sum x_i^3)k_0+x_1^3\lambda_1+x_n^3\lambda_2=2\sum x_i^3y_i\\
\dfrac{\partial Q}{\partial k_2}&=0\Rightarrow(2\sum x_i^5)k_3+(2\sum x_i^4)k_2+(2\sum x_i^3)k_1+(2\sum x_i^2)k_0+x_1^2\lambda_1+x_n^2\lambda_2=2\sum x_i^2y_i\\
\dfrac{\partial Q}{\partial k_1}&=0\Rightarrow(2\sum x_i^4)k_3+(2\sum x_i^3)k_2+(2\sum x_i^2)k_1+(2\sum x_i)k_0+x_1\lambda_1+x_n\lambda_2=2\sum x_iy_i\\
\dfrac{\partial Q}{\partial k_0}&=0\Rightarrow(2\sum x_i^3)k_3+(2\sum x_i^2)k_2+(2\sum x_i)k_1+2nk_0+\lambda_1+\lambda_2=2\sum y_i\\
\dfrac{\partial Q}{\partial\lambda_1}&=0\Rightarrow k_3x_1^3+k_2x_1^2+k_1x_1+k_0=y_1\\
\dfrac{\partial Q}{\partial\lambda_0}&=0\Rightarrow k_3x_n^3+k_2x_n^2+k_1x_n+k_0=y_n\\
\end{split}
$$

求解上述等式构成的恰定方程组，即可得到$k_3,k_2,k_1,k_0$以及$\lambda_1,\lambda_2$的值。

<br>

# Statistical measures for regression model

曲线拟合问题本质上属于回归问题，我们可以使用一些统计指标评价拟合的优度。

假设数据点的坐标为$(x_i,y_i)$，回归模型的预测点为$(x_i, \hat{y}_i)$，共有$n$个数据点。

残差平方和(The sum of squares due to error, SSE)：

$$
\mathrm{SSE}=\sum_{i=1}^n(y_i-\hat{y}_i)^2
$$

均方差(Means squared error, MSE)：

$$
\mathrm{MSE}=\mathrm{SSE}/n=\dfrac{1}{n}\sum_{i=1}^n(y_i-\hat{y}_i)^2
$$

平均绝对误差(Mean absolute error, MAE)：

$$
\mathrm{MAE}=\dfrac{1}{n}\sum_{i=1}^n\vert y_i-\hat{y}_i\vert
$$

均方根误差(Root mean squared error, RMSE)：

$$
\mathrm{RMSE}=\sqrt{\mathrm{MSE}}=\sqrt{\mathrm{SSE}/n}=\sqrt{\dfrac{1}{n}\sum_{i=1}^n(y_i-\hat{y}_i)^2}
$$

> 均方根(Root mean squared, RMS)
>
> 将RMSE中的误差值换成数据的值，就可以得到均方根RMS的定义:
> 
> $$
> \mathrm{RMS}=\sqrt{\dfrac{1}{n}\sum_{i=1}^n y_i^2}
> $$
> 
> 而如果更改为：
> 
> $$
> S=\sqrt{\dfrac{1}{n-1}\sum_{i=1}^n(y_i-\overline{y})^2},\quad \overline{y}=\dfrac1n\sum_{i=1}^ny_i
> $$
> 
> 就得到了样本标准差(Sample standard deviation)的定义。
>
> 这里想要强调的是，本小节所定义的统计measure有关于误差(error)的，有关于残差(residuals)的，两者是不一样的概念([Errors and residuals - Wikipedia](https://en.wikipedia.org/wiki/Errors_and_residuals))。上面所定义的measure都是关于误差。

回归平方和(Sum of squares of the regression, SSR)，即测试数据与原始数据均值之差的平方和：

$$
\mathrm{SSR}=\sum_{i=1}^n(\hat{y}_i-\overline{y})^2
$$

偏差平方和(Total sum of squares, SST)：

$$
\mathrm{SST}=\sum_{i=1}^n(y_i-\overline{y})^2
$$

并且有：

$$
\mathrm{SST}=\mathrm{SSE}+\mathrm{SSR}\label{SSTER}
$$

确定系数(Coefficient of determination, R-squared)：

$$
\mathrm{R-squrare}=\mathrm{\dfrac{SSR}{SST}}=\mathrm{\dfrac{SST-SSE}{SST}}=1-\mathrm{\dfrac{SSE}{SST}}
$$

等价形式是：

$$
R^2=1-\dfrac{\sum(\hat{y}_i-y_i)^2}{\sum(y_i-\overline{y})^2}\label{Rsquare}
$$

注：式$\eqref{SSTER}$以及后面的推导仅针对线性回归成立 [4]，而式$\eqref{Rsquare}$是最终的计算公式，对于其他函数拟合形式都成立。
{: .notice--warning}

<br>

# Code implementation

下面的代码实现了上述两种曲线拟合方法(Bezier曲线拟合，和三阶多项式拟合)，并用RMSE评价两个拟合模型。

## $y=e^x,\ x\in[0,1]$

拟合$[0,1]$之间的指数函数：

```matlab
clc, clear, close all

% Given data points in X-Y plane
x = linspace(0, 1, 20000);
y = exp(x);

% Function B^n_i(t)
Bni = @(n, i, t) nchoosek(n, i)*t^i*(1-t)^(n-i);

% Two Endpoints V0 and V3
V0 = [x(1), y(1)];
V3 = [x(end), y(end)];

% Calculate the tangent slopes in of the two endpoints
[ka1, ka2] = helperTangentSlop(x, y, 10);
theta1 = atan(ka1);
theta2 = atan(ka2);
b1 = y(1)-ka1*x(1);
b2 = y(end)-ka2*x(end);
% Tangent lines of the two endpoints
tangentline1 = ka1*x+b1;
tangentline2 = ka2*x+b2;
% Unit tangent vector of the two endpoints
t_hat1 = [cos(theta1), sin(theta1)];
t_hat2 = -[cos(theta2), sin(theta2)];
% The endpoints of unit tangent vectors
t_hat1_end = V0+t_hat1;
t_hat2_end = V3+t_hat2;

% Chord-length parameterization
ts = helperParameterization(x, y);

% Construct and solve the linear equations
d = [x; y]';
c11 = sum(t_hat1.*arrayfun(@(x) Bni(3,1,x),ts).*t_hat1.*arrayfun(@(x) Bni(3,1,x),ts), "all");
c12 = sum(t_hat1.*arrayfun(@(x) Bni(3,1,x),ts).*t_hat2.*arrayfun(@(x) Bni(3,2,x),ts), "all");
c21 = sum(t_hat1.*arrayfun(@(x) Bni(3,1,x),ts).*t_hat2.*arrayfun(@(x) Bni(3,2,x),ts), "all");
c22 = sum(t_hat2.*arrayfun(@(x) Bni(3,2,x),ts).*t_hat2.*arrayfun(@(x) Bni(3,2,x),ts), "all");
right1 = sum((d - ((arrayfun(@(x) Bni(3,0,x),ts)+arrayfun(@(x) Bni(3,1,x),ts)).*V0 + ...
    (arrayfun(@(x) Bni(3,2,x),ts)+arrayfun(@(x) Bni(3,3,x),ts)).*V3)).*t_hat1.*arrayfun(@(x) Bni(3,1,x),ts), "all");
right2 = sum((d - ((arrayfun(@(x) Bni(3,0,x),ts)+arrayfun(@(x) Bni(3,1,x),ts)).*V0 + ...
    (arrayfun(@(x) Bni(3,2,x),ts)+arrayfun(@(x) Bni(3,3,x),ts)).*V3)).*t_hat2.*arrayfun(@(x) Bni(3,2,x),ts), "all");
Left = [c11, c12;
    c21, c22];
Right = [right1; right2];
alphas = inv(Left)*Right;

% Fitting control points in the two tangent line
V1 = V0+t_hat1*alphas(1);
V2 = V3+t_hat2*alphas(2);

% Fitting curve
BezierCurve = arrayfun(@(x) Bni(3,0,x),ts).*V0+arrayfun(@(x) Bni(3,1,x),ts).*V1+...
    arrayfun(@(x) Bni(3,2,x),ts).*V2+arrayfun(@(x) Bni(3,3,x),ts).*V3;
[SSE1, MSE1, RMSE1, SSR1, SST1, Rsquare1] = helperStatisticalMeasures(BezierCurve(:, 2), y');

% Fit by 3-rd order polynomial
C = [2*sum(x.^6), 2*sum(x.^5),  2*sum(x.^4),  2*sum(x.^3), x(1)^3, x(end)^3;
    2*sum(x.^5), 2*sum(x.^4),  2*sum(x.^3),  2*sum(x.^2), x(1)^2, x(end)^2;
    2*sum(x.^4), 2*sum(x.^3),  2*sum(x.^2),  2*sum(x.^1), x(1), x(end);
    2*sum(x.^3), 2*sum(x.^2),  2*sum(x.^1),  2*numel(x), 1, 1;
    x(1)^3, x(1)^2, x(1), 1, 0, 0;
    x(end)^3, x(end)^2, x(end), 1, 0, 0];
B = [2*sum(x.^3.*y); 2*sum(x.^2.*y); 2*sum(x.*y); 2*sum(x); y(1); y(end)];
coeffs = inv(C)*B;
fitcurve2 = coeffs(1)*x.^3+coeffs(2)*x.^2+coeffs(3)*x+coeffs(4);
[SSE2, MSE2, RMSE2, SSR2, SST2, Rsquare2] = helperStatisticalMeasures(fitcurve2(:), y');

% Plot schematic
figure
ax = gca;
hold(ax, "on")
box(ax, "on")
axis(ax, "equal")
ax.LineWidth = 1.2;
LineWidth = 1.5;
plot(x, y, LineWidth=1.5, DisplayName="Data curve", Color=[7, 84, 213]/255)
scatter([V0(1), V3(1)], [V0(2), V3(2)], "filled", "k", "DisplayName", "Endpoints(V0 and V3)")

plot([V0(1), t_hat1_end(1)], [V0(2), t_hat1_end(2)], LineWidth=2.5, LineStyle="--", ...
    DisplayName="Tangent vector of the left endpoint")
plot([V3(1), t_hat2_end(1)], [V3(2), t_hat2_end(2)], LineWidth=2.5, LineStyle="--", ...
    DisplayName="Tangent vector of the right endpoint")

scatter([V1(1), V2(1)], [V1(2), V2(2)], "filled", "r", "DisplayName", "Fitting control points(V1 and V2)")

plot(BezierCurve(:, 1), BezierCurve(:, 2), LineWidth=1.5, ...
    DisplayName="Bezier curve", Color=[249, 82, 107]/255)
plot(x, fitcurve2, LineWidth=1.5, DisplayName="Third order polynomial curve")
sbt = sprintf("RMSE(Bezier): %.4f, RMSE(3-rd order polynomial): %.4f", RMSE1, RMSE2);
title("Curve fitting", sbt)
legend("Location", "best")


% Calculate the average tangent slope at the endpoints
function [ka1, ka2] = helperTangentSlop(x, y, pieceLength)
k1 = zeros(1, pieceLength);
k2 = zeros(1, pieceLength);
for i = 1:pieceLength
    k1(i) = (y(i+1)-y(1))/(x(i+1)-x(1));
    k2(i) = (y(end)-y(end-i))/(x(end)-x(end-i));
end
ka1 = mean(k1);
ka2 = mean(k2);
end

% Chord-length parameterization function
function ts = helperParameterization(x, y)
ChordLength = @(x, y) sqrt(sum((x-y).^2));
chords = zeros(1, width(x)-1);
for i = 1:numel(x)-1
    chords(i) = ChordLength([x(i), y(i)], [x(i+1), y(i+1)]);
end
ts = cumsum(chords)/sum(chords);
ts = [0, ts]';
end

% Calculate the statistical measures
function [SSE, MSE, RMSE, SSR, SST, Rsquare] = helperStatisticalMeasures(yhat, y)
SSE = sum((yhat-y).^2);       % The sum of sauqres due to error
MSE = mean((yhat-y).^2);      % Mean squared error
RMSE = sqrt(MSE);             % Root mean squared error
SSR = sum((yhat-mean(y)).^2); % Sum of squares of the regression
SST = sum((y-mean(y)).^2);    % Total sum of squares
Rsquare = 1-(sum((yhat-y).^2)/(sum((y-mean(y)).^2)));         % Coefficient of determination
end

```

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221124161259979.png?raw=true" alt="image-20221124161259979" style="zoom:50%;" />

可以看到，两种拟合方法都基本与数据曲线重合。

## $y=e^x,\ x\in[0,3]$

拟合$[0,3]$之间的指数函数：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221124161542666.png?raw=true" alt="image-20221124161542666" style="zoom:50%;" />

此时，虽然Bezier曲线拟合的RMSE也不是很大，但是在图像上可以看到与数据曲线有着比较明显的差距，而直接使用三阶多项式拟合仍然基本与数据曲线重合。

## $y=e^x,\ x\in[-2,5]$

拟合$[-2,5]$之间的指数函数：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221124161839202.png?raw=true" alt="image-20221124161839202" style="zoom:50%;" />

当进一步扩大区间的左右端点，直接使用三阶多项式拟合的方法有一段与真实数据点偏离很大，而Bezier曲线仍然能基本拟合出数据曲线的形状。

## $y=\sin(x),\ x\in[0,6]$

拟合$[0,6]$之间的sine函数：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221124162221222.png?raw=true" alt="image-20221124162221222" style="zoom:50%;" />

## $y=\sin(x),\ x\in[-16, 10]$

拟合$[-16,10]$之间的sine函数：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20221124162424773.png?raw=true" alt="image-20221124162424773" style="zoom:50%;" />

此时，两种拟合方法的拟合效果均不好，但是Bezier曲线拟合的方法还是更好一些。

<br>

# Conclusion

通过以上对于具体数据点的拟合，我们可以得出以下初步的结论：

1. 四个控制点的Bezier曲线拟合，和直接使用三阶多项式拟合的拟合方法，最终得到的都是三阶多项式函数。区别在于，Schneider P J所述的Bezier曲线拟合方法，能够限制左右端点处的斜率，这在某些情况下是优点(比如拟合$y=e^x,\ x\in[-2,5]$和拟合$y=e^x,\ x\in[-2,5]$时)，但是在某些情况下，这种限制是有害的(比如拟合$y=e^x,\ x\in[0,3]$时)；
2. 由于两种方法得到的都是三阶多项式函数，因此当数据点呈现出明显的周期性时，它们都不能很好地拟合出这样的趋势(比如拟合$y=\sin(x),\ x\in[-16, 10]$时)。

<br>

**Reference**

[1] Schneider P J. An algorithm for automatically fitting digitized curves[J]. Graphics gems, 1990, 1: 612-626.

[2] [Raph Leviens's blog: Fitting cubic Bézier curves](https://raphlinus.github.io/curves/2021/03/11/bezier-fitting.html).

[3] [#深度解析# SSR，MSE，RMSE，MAE、SSR、SST、R-squared、Adjusted R-squared误差的区别 - 知乎](https://zhuanlan.zhihu.com/p/355345621).

[4] [Sum of Squares Total, Sum of Squares Regression and Sum of Squares Error - 365 Data science](https://365datascience.com/tutorials/statistics-tutorials/sum-squares/).

[5] [The Chord Length Method(Chord-length Parameterization) from MTU - What a starry night~](https://helloworld-1017.github.io/mathematics/The-chord-length-method-from-MTU/).

