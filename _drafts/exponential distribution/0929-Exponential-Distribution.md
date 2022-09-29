指数分布(Exponential Distribution)是一种常见的连续性随机变量分布，记为$E(\lambda)$。它有一个重要的性质，即“无记忆性”。指数分布的引出可以从两个不同的视角：

- 我们可以从一个构造的密度函数形式出发，证明它满足PDF的性质，并定义为它为指数分布，再从该PDF推导出它的无记忆性；
- 反过来，我们也可以从一个具体应用场景（“无记忆性”的寿命分布）出发，推导出它的CDF和PDF，将其定义为指数分布。从这种角度，可以很自然地将指数分布推广到更一般、在某些场景下更合理的威布尔分布。

<br>

首先，我们定义一个函数：
$$
f(x)=\left\{\begin{split}
&\lambda e^{-\lambda x}, \quad &x>0\\
&0,&x\le0
\end{split}\right.,\quad\lambda>0\label{EPDF}
$$
很容易证明，该函数满足PDF的两个性质：非负性，和在整个定义区间内积分为1。

因此，对$\eqref{EPDF}$进行积分，可以得到它所对应的CDF：
$$
F(x)=\left\{\begin{split}
&1-e^{-\lambda x}, \quad &x>0\\
&0,&x\le0
\end{split}\right.,\quad\lambda>0\label{ECDF}
$$
PDF式$\eqref{EPDF}$和CDF式$\eqref{ECDF}$所代表的分布，我们就定义为指数分布$E(\lambda)$。

对于随机变量$X$，若它满足指数分布，我们可以推出它的一个性质：
$$
\begin{split}
P(x\le X\le x+h\vert x<X)&=P(x\le X\le x+h)/P(x<X)\\
&=\Big[F(x+h)-F(x)\Big]/\Big[{1-F(x)}\Big]\\
&=\Big[e^{-\lambda x}(1-e^{-\lambda h})\Big]/e^{-\lambda x}\\
&=1-e^{-\lambda h}
\end{split}\notag
$$

即：
$$
P(x\le X\le x+h\vert X>x)=1-e^{-\lambda h}\label{eq3}
$$
式$\eqref{eq3}$表明，已知$X>x$的条件下，$x\le X\le x+h$的概率等于$1-e^{-\lambda h}$，与$x$无关。

若令$h\rightarrow 0$，易证：
$$
\lim\limits_{h\rightarrow 0}P(x\le X\le x+h\vert X>x)/h=\lambda\label{eq4}
$$
==中值==

==in matlab==

<br>

现从另一个角度推导指数分布。

假设有一大批生产的电子元件，其寿命$X$为随机变量。假设这批电子元件“无老化”，即元件在时刻$x$尚在工作的条件下，其失效率保持为某个常数$\lambda$，且有$\lambda>0$，并且与$x$无关”。“失效率”就是单位时间$h$内失效的概率，令$h\rightarrow0$，则该假设可以使用表示为：
$$
\lim\limits_{h\rightarrow 0}P(x\le X\le x+h\vert X>x)/h=\lambda\notag
$$
该式和式$\eqref{eq4}$是一致的，可以解释为：元件在时刻$x$尚正常工作，表示其寿命大于$x$，即$X>x$；在$x$处，长为$h$的时间段内失效，即$x\le X\le x+h$。把这个条件概率除以时间段长度$h$，即得到在$x$时刻的**平均失效率**，再令$h\rightarrow0$，得到**瞬时失效率**$\lambda$。

将上式进行简单的变形，可以得到：
$$
\lim\limits_{h\rightarrow 0} \dfrac{F(x+h)-F(x)}{h\Big[1-F(x)\Big]}=\lambda\notag
$$
即：
$$
F'(x)/\Big[1-F(x)\Big]=\lambda\label{eq5}
$$
进而可以得到：
$$
F'(x)+\lambda F(x)-\lambda=0\notag
$$
该微分方程的通解为$F(x)=1-Ce^{-\lambda x}\ (x>0)$，又因为当$x\le0$时$F(x)=0$，因此最终可以得到：
$$
F(x)=1-e^{-\lambda x}\ (x>0)\label{eq6}
$$
对其求导，可以得到：
$$
f(x)=\lambda e^{-\lambda x}\ (x>0)\label{eq7}
$$
式$\eqref{eq6}$和式$\eqref{eq7}$和指数分布的CDF和PDF，即式$\eqref{ECDF}$和式$\eqref{EPDF}$，是一致的。

因此，从这个推导的过程可见，指数分布描述了无老化时的寿命分布。但是“无老化”是不可能的，因而指数分布只是一种近似，对于**寿命比较长的元件的初期老化现象**，指数分布可以比较确切地描述其寿命分布情况。又比如人的寿命，一般在50岁或60岁之前，由于生理上老化而死亡的因素是次要的，若排除那些意外情况，人的寿命分布在这个阶段也应该接近指数分布。

<br>

## Weibull Distribution

若考虑老化，则应取失效率随时间而上升，微分方程$\eqref{eq5}$的右端项不能为常数，故应取为$x$的一个增函数，例如$\lambda x^m$，其中$\lambda>0$，$m>0$为常数，此时有：
$$
F'(x)/\Big[1-F(x)\Big]=\lambda x^m
$$
该微分方程与初始条件$F(0)=0$结合，可以得到：
$$
F(x)=1-\exp({-\dfrac{\lambda}{(m+1)}x^{m+1}})\notag
$$
取$\alpha=m+1\ (\alpha>1)$，并将$\lambda/(m+1)$记为$\lambda$，则有：
$$
F(x)=1-e^{\lambda x^{\alpha}}\ (x>0)\label{eq9}
$$
当$x\le 0$时$F(x)=0$。对上式子求导，可以得到：
$$
f(x)=\lambda\alpha x^{\alpha-1}e^{\lambda x^\alpha}\ (x>0)\label{eq10}
$$
式$\eqref{eq9}$和$\eqref{eq10}$分别称为威布尔分布的CDF和PDF。威布尔分布与指数分布一样，在可靠性统计分析中占有重要的地位。实际上，**指数分布就是威布尔分布当$\alpha=1$的一个特例**。





<br>

for modeling the breaking strength of materials

==用于排队论==

**参考**

[1] [Exponential Distribution - MathWorks](https://ww2.mathworks.cn/help/stats/exponential-distribution.html).

[2] [Weibull Distribution - MathWorks](https://ww2.mathworks.cn/help/stats/weibull-distribution.html).



