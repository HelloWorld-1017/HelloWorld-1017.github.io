电子振荡电路一般至少含有两个储能元件和一个非线性元件。本文所介绍的范德坡(Van del Pol)电路是一种典型的非线性振荡电路，它是由一个线性电感、一个线性电容和一个非线性电阻构成，如下图所示。

![image-20220819181910505](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220819181910505.png)

其中，非线性电阻为电流控制型，伏安特性为：
$$
u_R=\dfrac13i_R^3-i_R\notag
$$
该非线性电阻有一段具有负电阻性质：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220820105039909.png" alt="image-20220820105039909" style="zoom:50%;" />

以 $u_c$  和 $i_R$ 为状态变量，则可以写出状态方程：
$$
\left\{
\begin{split}
\dfrac{\mathrm{d}u_C}{\mathrm{d}t}&=-\dfrac1Ci_L\\
\dfrac{\mathrm{d}i_L}{\mathrm{d}t}&=\dfrac1L\Big[u_C-(\dfrac13i_L^3-i_L)\Big]
\end{split}\label{raw}
\right.
$$
为了使用量纲为一的量，令 $\tau=\dfrac1{\sqrt{LC}}t$，此时 $\tau$ 为量纲一的量。于是有：
$$
\begin{split}
\dfrac{\mathrm{d}u_C}{\mathrm{d}t}&=\dfrac{\mathrm{d}u_C}{\mathrm{d}\tau}\dfrac{\mathrm{d}\tau}{\mathrm{d}t}=\dfrac1{\sqrt{LC}}\dfrac{\mathrm{d}u_C}{\mathrm{d}\tau}\\
\dfrac{\mathrm{d}i_L}{\mathrm{d}t}&=\dfrac{\mathrm{d}i_L}{\mathrm{d}\tau}\dfrac{\mathrm{d}\tau}{\mathrm{d}t}=\dfrac1{\sqrt{LC}}\dfrac{\mathrm{d}i_L}{\mathrm{d}\tau}
\end{split}\notag
$$
另外，令
$$
\varepsilon=\sqrt{\dfrac C L}\notag
$$
则式 $\eqref{raw}$ 可以改写为：
$$
\left\{
\begin{split}
\dfrac{\mathrm{d}u_C}{\mathrm{d}\tau}&=-\dfrac1\varepsilon i_L\\
\dfrac{\mathrm{d}i_L}{\mathrm{d}\tau}&=\varepsilon\Big[u_C-(\dfrac13i_L^3-i_L)\Big]
\end{split}\notag
\right.
$$
再令 $x_1=i_L$，$x_2=\dfrac{\mathrm{d}i_L}{\mathrm{d}t}$，则上式可以简化为：

注意：这里的状态变量并不是 $u_C$ 和 $i_L$。
{: .notice--warning}
$$
\left\{
\begin{split}
\dfrac{\mathrm{d}x_1}{\mathrm{d}t}&=x_2\\
\dfrac{\mathrm{d}x_2}{\mathrm{d}t}&=\varepsilon(1-x_1^2)x_2-x_1
\end{split}\label{simplified}
\right.
$$
方程 $\eqref{simplified}$ 中仅有一个参数 $\varepsilon=\sqrt{\dfrac C L}$。根据不同的 $\varepsilon$ 值，可以画出该方程不同的相图，就可以了解该电子振荡电路的定性性质。



