MATLAB



# Andrews’ curve

Let $\boldsymbol{x}$ denote a $d$-dimensional datapoint in $\mathbb{R}^d$, we could represent high-dimensional data with a number for each of their dimensions, $$x=\{x_1,x_2,\cdots,x_d\}$$. To visualize them, the Andrews’ curve defines a *finite* Fourier series [^1]:
$$
f_\boldsymbol{x}(t)=\dfrac{x_1}{\sqrt2}+x_2\sine(t)+x_3\cos(t)+x_4\sin(2t)+x_5\cos(2t)+\cdots\label{eq1}
$$
This function is them plotted for $-\pi<t<\pi$. Thus each datapoint may be viewed as a line between $-\pi$ and $\pi$. “A set of points will appear as a set of lines drawn across the plot.” **This formula could be thought of as the projection of the datapoint onto the vector** (refer to the geometric meaning of dot product [^5])

$$
\Big(\dfrac{1}{\sqrt{2}},\sin(t),\cos(t),\sin(2t),\cos(2t),\cdots\Big)
$$

specifically, 



For example, for four-dimensional datapoint:
$$
\begin{split}
f_\boldsymbol{x}(t)&=\dfrac{x_1}{\sqrt2}+x_2\sine(t)+x_3\cos(t)+x_4\sin(2t)\\
&=\begin{bmatrix}
x_1&x_2&x_3&x_4
\end{bmatrix}
\begin{bmatrix}
\dfrac{1}{\sqrt2}\\
\sin(t)\\
\cos(t)\\
\sin(2t)\\
\cos(2t)\\
\end{bmatrix}
\end{split}
$$




data set version
$$
\boldsymbol{f}_\boldsymbol{x}(t)=
\begin{bmatrix}
x_1^{(1)}&x_2^{(1)}&x_3^{(1)}&x_4^{(1)}\\
x_1^{(2)}&x_2^{(2)}&x_3^{(2)}&x_4^{(2)}\\
\vdots&\vdots&\vdots&\vdots\\
x_1^{(n)}&x_2^{(n)}&x_3^{(n)}&x_4^{(n)}\\
\end{bmatrix}
\begin{bmatrix}
\dfrac{1}{\sqrt2}\\
\sin(t)\\
\cos(t)\\
\sin(2t)\\
\cos(2t)\\
\end{bmatrix}
$$

<br>

# MATLAB `andrewplot` function

MATLAB documentation provides an `andrewplot` function and corresponding example to show how to plot Andrews’ curves for `fisheriris` data set [^3]:


```matlab
load fisheriris
figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
ps = andrewsplot(meas,"group",species,"LineWidth",1);
for i = 1:numel(ps)
    ps(i).Color(4) = 0.7;
end
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311082236939.png" alt="image-20231108223611015" style="zoom:67%;" />

`andrewplot` function integrates the calculation and plot for Andrews’ curves, and in whose source code, the lines for calculating shows as follow: 


```matlab
% Compute the terms for the curves.  The constant term goes with the first
% column of X, the lowest freq sin with the 2nd, the lowest freq cos with
% the third, and so on.
t = 0:.001:1;
omega = 2*pi*(1:floor(p/2));
omegaSin = omega(1:floor(p/2));
omegaCos = omega(1:floor((p-1)/2));
A = [ones(1,length(t))./sqrt(2); sin(omegaSin' * t); cos(omegaCos' * t)];
F = X(:,[1 (2:2:p) (3:2:p)])*A;
```

where `X` is local variable for input `meas`, and `p` is the number of feature vector, i.e., $4$.

As can be seen, it is kinda different from Eq. $\eqref{eq1}$, it defines the Fourier series like:
$$
f_\boldsymbol{x}(t)=\dfrac{x_1}{\sqrt2}+x_2\sine(2\pi t)+x_3\cos(2\pi t)+x_4\sin(4\pi t)+x_5\cos(4\pi t)+\cdots\label{eq2}
$$
and the curves are plotted between $t\in[0,1]$. It is okay, and Gnanadesikan’s book (**page 240**) [^4] mentions this point, “Note: Simply by taking $2\pi t$ in place of $t$ in Andrew’s definition one would obtain a set of functions orthonormal on $(0,1)$ instead of $(-\pi,+\pi)$”. But I think Eq. $\eqref{eq1}$ and Eq. $\eqref{eq2}$ are not exactly equivalent, since both variable intervals are not equivalent. So, considering the interval, the following equation is equivalent to Eq. $\eqref{eq1}$: 
$$
f_\boldsymbol{x}(t)=\dfrac{x_1}{\sqrt2}+x_2\sine(2\pi t-\pi)+x_3\cos(2\pi t-\pi)+x_4\sin(4\pi t-2\pi)+x_5\cos(4\pi t-2\pi)+\cdots\label{eq3}
$$
where $t\in[0,1]$. 

We could verify this point. For Eq. $\eqref{eq1}$, we should modify the `andrewplot` function like this:

<div id="modified-andrews"></div>

```matlab
t = -pi:.001:pi;
omega = 1:floor(p/2);
omegaSin = omega(1:floor(p/2));
omegaCos = omega(1:floor((p-1)/2));
A = [ones(1,length(t))./sqrt(2); sin(omegaSin' * t); cos(omegaCos' * t)];
F = X(:,[1 (2:2:p) (3:2:p)])*A;
```

and the corresponding Andrews’ curves are like:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311092017102.png" alt="image-20231109201703038" style="zoom: 67%;" />

As for Eq. $\eqref{eq3}$, we should make modifications like:

```matlab
t = 0:.001:1;
omega = 2*pi*(1:floor(p/2));
omegaSin = omega(1:floor(p/2));
omegaCos = omega(1:floor((p-1)/2));
A = [ones(1,length(t))./sqrt(2);
    sin(omegaSin'*t-(1:numel(omegaSin'))'*pi);
    cos(omegaCos'*t-(1:numel(omegaCos'))'*pi)];
F = X(:,[1 (2:2:p) (3:2:p)])*A;
```

and the Andrews’ curves are:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311092254038.png" alt="image-20231109225448964" style="zoom:67%;" />

==scale, important, later==

As can be seen, Eq. $\eqref{eq1}$ and Eq. $$\eqref{eq3}$$ are equivalent, and the only difference is the range of interval. So at this point, I think MATLAB `andrewplot` function is not that correct. Many references also take iris data set as an example to illustrate Andrews’ curve, and more important, they all adopt Eq. $\eqref{eq1}$ to calculate, like Paul’s paper [^6]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311092304243.png" alt="image-20231109230442127" style="zoom:50%;" />

and Rip’s Blog [^7]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311092306755.png" alt="image-20231109230613681" style="zoom: 67%;" />

Therefore, in the following text, I would use [this modified `andrewplot` function](#modified-andrews) to illustrate ideas. And by the way, ==output `F`==



<br>

# Original Andrews’ paper

Original Andrews’ paper [^2] provides some properties of this method: 

## Average curve

(1) The function representation preserves means. If $\bar{\boldsymbol{x}}$ is the mean of a set of $n$ multivariate observations $\boldsymbol{x}_i$, then the function corresponding to $\bar{\boldsymbol{x}}$ is the pointwise mean of the functions corresponding to the $n$ observations:
$$
f_{\bar{\boldsymbol{x}}}(t)=\dfrac1n\sum_{i=1}^n f_{x_i}(t)
$$
As a result, the average will appear like an average in this plot.

the definition of functions in Eq. xxx is linear in the $p$ variables, xxx, so that the centroid of the observations will correspond to an “average curve” on the function plot [^4].

```matlab
clc,clear,close all

load fisheriris
figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
ps = andrewsplot(meas,"group",species,"LineWidth",1);
for i = 1:numel(ps)
    ps(i).Color(4) = 0.7;
end
xlim([-pi,pi])

% Calculate Andrews' curve for each sample
[~,p] = size(meas);
t = -pi:.001:pi;
omega = 1:floor(p/2);
omegaSin = omega(1:floor(p/2));
omegaCos = omega(1:floor((p-1)/2));
A = [ones(1,length(t))./sqrt(2); sin(omegaSin' * t); cos(omegaCos' * t)];
F = meas(:,[1 (2:2:p) (3:2:p)])*A;

% Calculate sample mean vector 
setosa_mean = mean(meas(strcmp(species,"setosa"),:));
versicolor_mean = mean(meas(strcmp(species,"versicolor"),:));
virginica_mean = mean(meas(strcmp(species,"virginica"),:));

% Calculate average Andrews' curve
setosa_curve_mean = mean(F(strcmp(species,"setosa"),:));
versicolor_curve_mean = mean(F(strcmp(species,"versicolor"),:));
virginica_curve_mean = mean(F(strcmp(species,"virginica"),:));

plot(t,setosa_curve_mean,"LineWidth",3, ...
    "Color","b","DisplayName","Average curve (setosa)")
plot(t,versicolor_curve_mean,"LineWidth",3, ...
    "Color","g","DisplayName","Average curve (versicolor)")
plot(t,virginica_curve_mean,"LineWidth",3, ...
    "Color","r","DisplayName","Average curve (virginica)")
legend("Location","northwest")
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311092359468.png" alt="image-20231109235907402" style="zoom:67%;" />

```
>> disp(mean(setosa_mean*A-setosa_curve_mean)), disp(mean(versicolor_mean*A-versicolor_curve_mean)), disp(mean(virginica_mean*A-virginica_curve_mean))
   1.5762e-04
   3.8031e-04
   4.5705e-04
```





## Preserves distances

The function representation preserves distances. One measure of the distance between two functions that seems in accord with distance as judged by the human eye is:
$$
\vert\vert f_\boldsymbol{x}(t)-f_\boldsymbol{y}(t)\vert\vert_{L_2}^2=\int_{-\pi}^\pi[f_\boldsymbol{x}(t)-f_\boldsymbol{y}(t)]^2\mathrm{d}t
$$


$$
\begin{split}
&\vert\vert f_\boldsymbol{x}(t)-f_\boldsymbol{y}(t)\vert\vert_{L_2}^2
=\int_{-\pi}^\pi[f_\boldsymbol{x}(t)-f_\boldsymbol{y}(t)]^2\mathrm{d}t\\
=&\int_{-\pi}^\pi
\Big[(x_1-y_1)\dfrac1{\sqrt2}+(x_2-y_2)\sin(t)+(x_3-y_3)\cos(t)+\cdots\Big]^2\mathrm{d}t\\
=&\pi\sum_{i=1}^p(x_i-y_i)^2
\end{split}
$$
[Fourier Series of Periodic Signals - What a starry night~](https://helloworld-1017.github.io/2023-01-25/17-25-27.html)



```matlab
idx1 = 7;
idx2 = 71;
sum((F(idx1,:)-F(idx2,:)).^2*0.001)
pi*sum((meas(idx1,:)-meas(idx2,:)).^2)
```

```
ans =
   48.8254
ans =
   48.8203
```



Moreover, this distance is proportional to the familiar Euclidean distance between the corresponding points since:
$$
\vert\vert f_\boldsymbol{x}(t)-f_\boldsymbol{y}(t)\vert\vert_{L_2}=\pi\vert\vert \boldsymbol{x}-\boldsymbol{y}\vert\vert^2=\pi\sum_{i=1}^k(x_i-y_i)^2
$$
Because this relation, close points will appear as close functions and distant points as distant functions. Thus multivariate clusters and outliers may be identified visually from the plot of the function. It is this distance-preserving property that determined the coefficient $1/\sqrt2$ and restricts the coefficients of $t$ to integers.



## Yields one-dimensional projections

The representation yields one-dimensional projections. For a particular value of $t=t_0$, the function value $f_{\boldsymbol{x}}(t_0)$ is proportional to the length of the projection of the vector $(x_1,\cdots,x_k)$ on the vector:
$$
f_{\boldsymbol{1}}(t_0)=\begin{bmatrix}
1/\sqrt{2}&\sin(t_0)&\cos(t_0)&\sin(2t_0)&\cos(2t_0)&\cdots
\end{bmatrix}
$$
since:
$$
f_{\boldsymbol{x}}(t_0)=\Big(\boldsymbol{x}^\prime f_\boldsymbol{1}(t_0)/[f_{\boldsymbol{1}}^\prime(t_0)f_{\boldsymbol{1}}(t_0)]\Big)\cdot[f_{\boldsymbol{1}}^\prime(t_0)f_{\boldsymbol{1}}(t_0)]
$$
The projection on this one-dimensional space may reveal clusterings, outlier patterns, or other peculiarities that occur in this subspace and which may be otherwise obscured by other dimensions. The advantage of this plot is that a continuum of such one-dimensional projections is plotted on one graph.



## preserves variances

The representation preserves variances. If the components of the data uncorrelated with common variance $\sigma^2$ then the function value at $t$, $f_x(t)$, has variance:

if mutually uncorrelated
$$
\begin{split}
\mathrm{Var}[f_{\boldsymbol{x}}(t)]
&=\mathrm{Var}[x_1\dfrac1{\sqrt2}+x_2\sin^2(t)+x_3\cos^2(t)+x_4\sin^2(2t)+x_5\cos^2(2t)+\cdots]\\
&=\mathrm{Var}(x_1)\dfrac12+\mathrm{Var}(x_2)\sin^2(t)+\mathrm{Var}(x_3)\cos^2(t)+\mathrm{Var}(x_4)\sin^2(2t)+\mathrm{Var}(x_5)\cos^2(2t)+\cdots\\
&=\sigma_1^2\dfrac12+\sigma_2^2\sin^2(t)+\sigma_3^2\cos^2(t)+\sigma_4^2\sin^2(2t)+\sigma_5^2\cos^2(2t)+\cdots
\end{split}
$$

and further if has common variance, i.e., $$\sigma_1^2=\sigma_2^2=\cdots=\sigma^2$$, we have:
$$
\mathrm{Var}[f_{\boldsymbol{x}}(t)]=\sigma^2(\dfrac12+\sin^2(t)+\cos^2(t)+\sin^2(2t)+\cos^2(2t)+\cdots)\\
$$




If $k$ is odd this reduces to a constant, $\dfrac12\sigma^2k$, for example, if $k=3$, we have:
$$
\mathrm{Var}[f_{\boldsymbol{x}}(t)]=\sigma^2(\dfrac12+\sin^2(t)+\cos^2(t))=\dfrac32\sigma^2
$$
 if $k$ is even, the variance lies between $\dfrac12\sigma^2(k-1)$ and $\dfrac12\sigma^2(k+1)$, for example, if $k=4$
$$
\dfrac32\sigma^2<\mathrm{Var}[f_{\boldsymbol{x}}(t)]=\sigma^2(\dfrac12+\sin^2(t)+\cos^2(t)+\sin^2(2t))=\sigma^2(\dfrac32+\sin^2(2t))<\dfrac52\sigma^2
$$
In the former case, the variance does not depend on $t$, while in the latter case, the relative dependence on $t$ is slight and decreases as $k$ increases. Thus the variability of the plotted function is almost constant across the graph. This standard deviation of $f$ is denoted by $\sigma_f$ where it appears on the plots. <u>This facilitates the interpretation of the plot as outlined in the next section.</u>

```matlab
clc,clear,close all

rng("default")
features = rand(150,3);

% Calculate Andrews' curve for each sample
[n,p] = size(features);
t = -pi:.001:pi;
omega = 1:floor(p/2);
omegaSin = omega(1:floor(p/2));
omegaCos = omega(1:floor((p-1)/2));
A = [ones(1,length(t))./sqrt(2); sin(omegaSin' * t); cos(omegaCos' * t)];
F = features(:,[1 (2:2:p) (3:2:p)])*A;

disp(var(features)-1/12),disp(mean(var(F)-(1.5/12)))
```

```
>> disp(var(features,0,1)-1/12),disp(mean(var(F,0,1)-(1.5/12)))
    0.0057   -0.0066   -0.0040
   -0.0024
```

But it should be noted that, the assumption that the variance of each component is 



## Clustering

If some plotted functions form a band by remaining close together for all values of $t$, then the corresponding points are close together in the Euclidean metric. Such a band represents a cluster of data points. If a group of functions come close together for only one or a few values of $t$, then the corresponding points are close in the directions defined by the corresponding points vectors $\boldsymbol{f}_\boldsymbol{1}(t)$. Thus it is possible to identify clusters of points even when some additional variables are present.







## Conduct hypothesis test or to construct confidence interval



confidence interval [^11]





[`prctile`: Percentiles of data set - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/prctile.html).





## Re-ordering the features

It can be seen from Eq. $\eqref{eq1}$ that, the order of $$\{x_1,x_2,\cdots,x_d\}$$ would results different projections and hence influence the Andrews’ curve we calculate. For example, for iris data set, there exist $24$ combinations for feature component $[x_1,x_2,x_3,x_4]$, and different combinations correspond to different shapes of Andrews’ curves:

```matlab
clc,clear,close all

load fisheriris
P = flipud(perms(1:4));

figure("Position",[0.27, 0.05, 2.17, 1.28]*1e3)
tiledlayout(4,6,"TileSpacing","tight")

for j = 1:height(P)
    data = meas(:,P(j,:));
    nexttile
    hold(gca,"on"),box(gca,"on"),grid(gca,"on")
    ps = andrewsplot(data,"group",species,"LineWidth",1);
    for i = 1:numel(ps)
        ps(i).Color(4) = 0.7;
    end
    xlim([-pi,pi])
    titleName = sprintf("(%s) ",num2str(j))+"$x_"+num2str(P(j,1))+"x_"+num2str(P(j,2))+"x_"+num2str(P(j,3))+"x_"+num2str(P(j,4))+"$";
    title(titleName,"Interpreter","latex","FontSize",15);
    legend("Location","north","Orientation","horizontal")
end
exportgraphics(gcf,"pic.jpg","Resolution",600)
```

<div id="figure-1"></div>

![pic](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311111356934.jpg)

Paul’s paper [^6] presented the Andrews’ curves of combinations $x_2x_4x_1x_3$, $x_3x_1x_2x_4$, $x_4x_3x_1x_2$, and $x_3x_4x_2x_1$, which correspond to above subfigures [Fig. 1-(11)](#figure-1), [Fig. 1-(13)](#figure-1), [Fig. 1-(23)](#figure-1), and [Fig. 1-(18)](#figure-1), and concluded: compared with [Fig. 1-(11)](#figure-1), the cases of [Fig. 1-(13)](#figure-1) and  [Fig. 1-(18)](#figure-1) putting the important factor $x_3$ at the lowest frequency essentially amounts to a shift in the curves; whereas in [Fig. 1-(11)](#figure-1), $x_3$ influences the plots via **the highest frequency** and consequently **gives a better visual separation over this range of projections**.

I speculate what Paul want to express that relating “important factors” to high frequency could induce an obvious separation visually, and therefore a better choice. To achieve this goal, “one would suggest grouping strongly correlated variables together and putting strongly discriminating variables at the extreme frequency of sines and cosines.”

However, Paul’s paper didn’t give detailed information about how to determine the “importance” of factors, and how to group strongly correlated variables; he just mentioned that one could refer to Krzanowski’s book, *Principles of multivariate analysis: A User’s Perspective* [^9]. But I have no access to it.

So, I think that one of the most common way to determine whether or not a feature is discriminative is to calculate the its sample variance: the bigger the variance is, the more discriminative the feature is. For iris data set, we could get: 

```
>> var(meas)
ans =
    0.6857    0.1900    3.1163    0.5810
```

The results shows that, according to Paul’s opinion, the most appropriate feature order is $x_2x_4x_1x_3$, and this case exactly corresponds to [Fig. 1-(11)](#figure-1). So, **I think ranking features by variance value is an easy and not bad choice.** Furthermore, if we calculate the correlation coefficients of features using MATLAB `corrcoef` [^10], we could find $x_1$, $x_3$, and $x_4$ are indeed highly correlated:

```
>> corrcoef(meas)
ans =
    1.0000   -0.1176    0.8718    0.8179
   -0.1176    1.0000   -0.4284   -0.3661
    0.8718   -0.4284    1.0000    0.9629
    0.8179   -0.3661    0.9629    1.0000
```

It confirmed the Paul’s viewpoint again.

On another hand, when I looked into how to re-order the features on the Internet, I found another reference [^8] points out that, “Andrews curves are order dependent. The first few variables tend to dominate, so it is a good idea to **put the most important variables first**. Some analysts recommend running a principle components analysis first and generating Andrews curves for the principle components.” It is contrary to Paul’s paper.

To make a comparison, I reduce the number of features from $4$ to $2$ by PCA (Principle Components Analysis) method, and ordering them in $(\text{1st principle component, 2nd principle component})$ and $(\text{2nd principle component, 1st principle component})$, respectively, showing as follows:

```matlab
clc,clear,close all

load fisheriris.mat

[coeff,score,latent,tsquared,explained,mu] = pca(meas);

features1 = meas*coeff(:,1:2);

figure("Position",[602.33,375,1054.67,420])
tiledlayout(1,2)
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
ps = andrewsplot(features1,"group",species,"LineWidth",1);
for i = 1:numel(ps)
    ps(i).Color(4) = 0.7;
end
xlim([-pi,pi])
legend("Location","north","Orientation","horizontal")
title("Order: 1st principle component, 2nd principle component")

features2 = fliplr(features1);
nexttile
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
ps = andrewsplot(features2,"group",species,"LineWidth",1);
for i = 1:numel(ps)
    ps(i).Color(4) = 0.7;
end
xlim([-pi,pi])
legend("Location","north","Orientation","horizontal")
title("Order: 2nd principle component, 1st principle component")
exportgraphics(gcf,"pic-2.jpg","Resolution",600)
```

![pic-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311112130948.jpg)

As can be seen, Paul’s way, that is put the most important variables **last**, could make the separation between “setosa” class and another two classes more clear. At this point, I think reference [^8] probably wrong. Having said that, determining the order based on principle components provided by reference [^8] is indeed a feasible approach.

<br>

选取三个空间，然后选取不同的$t$值，绘制出不同的三维坐标；但是并不是向量，











<br>

## Normalization

 



```matlab
clc,clear,close all

load fisheriris
meas = normalise(meas);

figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
ps = andrewsplot(meas,"group",species,"LineWidth",1);
for i = 1:numel(ps)
    ps(i).Color(4) = 0.7;
end
xlim([-pi,pi])
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311141044874.png" alt="image-20231114104438690" style="zoom: 67%;" />







# Methods for statistical data analysis of multivariate observations

Gnanadesikan’s book, *Methods for Statistical Data Analysis of Multivariate Observations* [^4], 







<br>

**References**

[^1]: [Andrews plot - Wikipedia](https://en.wikipedia.org/wiki/Andrews_plot).
[^2]: Andrews, David F. "Plots of high-dimensional data." *Biometrics* (1972): 125-136, available at: [Plots of High-Dimensional Data on JSTOR](https://www.jstor.org/stable/2528964).
[^3]: [MATLAB `andrewsplot`: Andrews plot - MathWorks China](https://ww2.mathworks.cn/help/stats/andrewsplot.html).
[^4]: Gnanadesikan, Ram. *Methods for statistical data analysis of multivariate observations*. John Wiley & Sons, 2011, **page 240-244**, available at: [Methods for Statistical Data Analysis of Multivariate Observations](http://ndl.ethernet.edu.et/bitstream/123456789/33247/1/R.%20Gnanadesikan_1997.pdf).
[^5]: [Geometric and Algebraic Definition of Dot Product (Inner Product) - What a starry night~](https://helloworld-1017.github.io/2022-06-09/21-07-09.html).

[^6]: Embrechts, Paul, and Agnes M. Herzberg. "Variations of Andrews' plots." *International Statistical Review/Revue Internationale de Statistique* (1991): 175-194, available at: [Variations of Andrews' Plots on JSTOR](https://www.jstor.org/stable/1403442).
[^7]: [Andrews Curves - Rip's Applied Mathematics Blog](https://rip94550.wordpress.com/2011/10/03/andrews-curves/).
[^8]: [andrews.pdf](https://www.itl.nist.gov/div898/software/dataplot/refman1/ch2/andrews.pdf).
[^9]: Krzanowski, Wojtek J. *Principles of multivariate analysis*. Oxford University Press, 2000.
[^10]: [`corrcoef`: Correlation coefficients - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/corrcoef.html).
[^11]: [Interval Estimation: Pivot Method - What a starry night~](https://helloworld-1017.github.io/2022-09-21/19-15-11.html).





Methods for assessing multivariate normality. Bell Laboratories Memorandum



Garcıa-Osorio, César, and Colin Fyfe. "Visualization of high-dimensional data via orthogonal curves." *Journal of Universal Computer Science* 11.11 (2005): 1806-1819, available at: [Visualization of High-dimensional Data via Orthogonal Curves](https://www.jucs.org/jucs_11_11/visualization_of_high_dimensional/jucs_11_11_1806_1819_garc_a_osorio.pdf).



