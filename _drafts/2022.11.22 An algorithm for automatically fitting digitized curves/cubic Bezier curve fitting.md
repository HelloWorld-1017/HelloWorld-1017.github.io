1. Begin computing approximate tangents at the endpoints of the digitized curve

   - fit a least-squares line to the points in the neighborhood of the endpoints
   - averaging vectors from the endpoints to the next $n$ points

2. assign an initial parameter value $u_i$ to each points $d_i$, using chord-length parameterization




$$
S=\vert\vert P-Q(t)\vert\vert^2_2=\sum_{i=1}^n[d_i-Q(u_i)]^2\label{eqS}
$$
其中：
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
&=\sum_{i=1}^n\Big(B_0^3(u_i)V_0A_{i,1}+\alpha_1A_{i,1}^2+V_0B_1^3(u_i)A_{i,1}+\alpha_2A_{i,1}A_{i,2}+B_2^3(u_i)V_3A_{i,1}+B_3^3(u_i)V_3A_{i,1}\Big)\\
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
求解上述方程组，即可以得到$\alpha_1$和$\alpha_2$的值。



