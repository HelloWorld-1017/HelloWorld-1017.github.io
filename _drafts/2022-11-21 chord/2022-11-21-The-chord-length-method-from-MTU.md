如果一条数据点的内插曲线(interpolating curve)非常接近data polygon，那么在两个相邻数据点之间的内插曲线段的长度将非常接近这两个数据点之间chord的长度，并且内插曲线的总长度也将非常接近data polygon的总长度。

chord，弦，是一条线段。
{: .notice--primary}

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221121212640561.png" alt="image-20221121212640561" style="zoom: 50%;" />

在上图中，内插曲线的每一个curve segment都和supporting chord非常接近。因此，如果按照弦长分布细分区域，那么参数将会是arc-length parameterization(==添加超链接：XXX==)的近似值，这就是chord length或者说chordal method的优点。

<br>

假设数据点为$D_0,D_1,\cdots,D_n$，那么数据点$D_{i-1}$和$D_i$之间的长度就是$\vert D_i-D_{i-1}\vert$，data polygon的长度$L$就是这些弦长的加和，即：
$$
L=\sum_{i=1}^n\vert D_i-D_{i-1}\vert
$$
数据点$D_0$到数据点$D_k$的弦长与data polygon长度之比$L_k$为：
$$
L_k=\dfrac{\sum_{i=1}^k\vert D_i-D_{i-1}\vert}{L}
$$
因此，如果我们想要得到内插曲线的arc-length parameterization，则必须根据比例$L_k$划分区域。更准确地讲，如果域为$[0,1]$，那么参数$t_k$应该位于$L_k$值处，即：
$$
\begin{split}
t_0&=0\\
t_k&=\dfrac1L(\sum_{i=1^k}\vert D_i-D_{i-1}\vert)\\
t_n&=1\\
\end{split}
$$
其中，$L$为data polygon的总长度。通过这种方式，将参数域划分为弦长的比率。

我们看一个例子。

假设我们有四个数据点($n=3,\ i=0,1,2,3$)：
$$
D_0=(0,0),\ D_1=(1,2),\ D_2=(3,4),\ D_3=(4,0)
$$
则每一个chord的长度分别为：
$$
\begin{split}
\vert D_1-D_0\vert&=\sqrt5\approx2.2361\\ 
\vert D_2-D_1\vert&=2\sqrt2\approx2.8284\\
\vert D_3-D_2\vert&=\sqrt{17}\approx4.1231\\
\end{split}
$$
总长度为：
$$
L=\sqrt5+2\sqrt2+\sqrt{17}\approx9.1876
$$
最后，我们得到相应的参数：
$$
\begin{split}
t_0 &= 0\\
t_1 &= \dfrac{\vert D_1-D_0\vert}{L}\approx0.2434\\
t_2 &= \dfrac{\vert D_1-D_0\vert+\vert D_2-D_1\vert}{L}\approx0.5512\\
t_3 &= 1
\end{split}
$$


如果参数域不是$[0,1]$，而是更一般的区间$[a,b]$呢？







注意到$L_k$是区间$[0,1]$之间的ratio，由于