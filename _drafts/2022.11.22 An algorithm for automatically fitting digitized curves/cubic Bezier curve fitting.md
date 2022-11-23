Schneider P J.在其1990年发表的论文"An algorithm for automatically fitting digitized curves" [1] 中详细地阐述了四个控制点的三阶Bezier曲线的拟合方法。

具有四个控制点的三阶Bezier曲线示意图如下图所示：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/schematics.png" alt="schematics" style="zoom:50%;" />

对应的参数方程为：
$$
\begin{split}
Q(t)&=B_0^3(t)V_0+B_1^3(u_i)V_1+B_2^3(t)V_2+B_3^3(t)V_3\\
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

之后，对X-Y平面内的数据点$d_i$进行参数化，将$d_i$与参数值$u_i$对应，采用的方法是chord-length parameterization(详见：[The Chord Length Method(Chord-length Parameterization) from MTU](http://whatastarrynight.com/mathematics/The-chord-length-method-from-MTU/))。

最后，采用最小二乘的方法求解未知系数$\alpha_1$和$\alpha_2$。

最小二乘方法的目标函数为：

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
下面以$\dfrac{\partial S}{\partial \alpha_1}=0$为例进行分析。
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
A_{i,1}=\hat{t}_1B_1^3(u_i)\\
A_{i,2}=\hat{t}_2B_2^3(u_i)\\
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

**Reference**

[1] Schneider P J. An algorithm for automatically fitting digitized curves[J]. Graphics gems, 1990, 1: 612-626.

[2] [Raph Leviens's blog: Fitting cubic Bézier curves](https://raphlinus.github.io/curves/2021/03/11/bezier-fitting.html).
