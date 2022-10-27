Experiment

# 正态总体分布均值的检验

假设$X_1,\cdots,X_n$是抽自正态总体$N(\theta,\sigma^2)$，本小节讨论有关均值$\theta$的假设检验问题。在应用上常见的形式有($\theta_0$是一个给定的数)：

1. $H_0$：$\theta\ge\theta_0$，$H_1$：$\theta<\theta_0$；
2. $H'_0$：$\theta\le\theta_0$，$H'_1$：$\theta>\theta_0$；
3. $H''_0$：$\theta=\theta_0$，$H_1''$：$\theta'\ne\theta_0$；

这里，$H_0$，$H'_0$，$H''_0$都为原假设，$H_1$，$H'_1$，$H''_1$为对立假设。下面分为两种情况进行讨论：

## 方差$\sigma^2$已知

### 检验问题1

先考虑检验问题1。以$\bar{X}$记作样本均值，$\bar{X}$是$\theta$的估计。因此，$\bar{X}$越大，直观上看与原假设$H_0$越符合。反之，$\bar{X}$越小，则与对立假设$H_1$越符合。由此，可以得出一个直观上合理的检验$\Phi$：
$$
\Phi: 当\bar{X}\ge C时接受原假设H_0,当\bar{X}<C时否定H_0\label{eq1}
$$
要定出常数$C$，使检验有给定的水平$\alpha$，为此要考虑$\Phi$的功效函数$\beta_\Phi(\theta)$：
$$
\beta_\Phi(\theta)=P_\theta(\bar{X}<C)=P_\theta(\sqrt{n}(\bar{X}-\theta)/\sigma<\sqrt{n}(C-\theta)/\sigma)
$$
当总体有正态分布$N(\theta,\sigma^2)$时，$\sqrt{n}(\bar{X}-\theta)/\sigma$服从标准正态分布$N(0,1)$，以$\Phi$记其分布函数，有：
$$
\beta_\Phi(\theta)=\Phi(\sqrt{n}(C-\theta)/\sigma)\label{eq3}
$$
当$\theta$增加时，$\sqrt{n}(C-\theta)/\sigma$下降，故$\beta_\Phi(\theta)$也下降，这样一来，在原假设成立时(即$\theta\ge\theta_0$时)，只需要使$\beta_\Phi(\theta_0)=\alpha$即可。按照上$\alpha$分位点的记法，应当取$C$满足：
$$
\begin{split}
&\sqrt{n}(C-\theta_0)/\sigma=u_{1-\alpha}=-u_\alpha\\
\Rightarrow&C=\theta_0-\sigma u_{\alpha}/\sqrt{n}
\end{split}\label{eq2}
$$
式$\eqref{eq1}$和式$\eqref{eq2}$的结合，决定了检验$\Phi$。将式$\eqref{eq2}$代入式$\eqref{eq3}$，得到检验$\Phi$：
$$
\Phi: 当\bar{X}\ge\theta_0-\sigma u_{\alpha}/\sqrt{n}时接受原假设H_0,否则就否定H_0\label{eq10}
$$
及其功效函数为：
$$
\beta_\Phi(\theta)=\Phi(\sqrt{n}(\theta_0-\theta)/\sigma-u_\alpha)
$$
**其实功效函数就是为了找到得到常数$C$的，最终使用的时候，我们得到一个检验$\Phi$就可以了。**
{: notice--warning}

当备择假设成立时(即当$\theta<\theta_0$时)，$\beta_\Phi(\theta)$越大越好。那么，如何使$\beta_\Phi(\theta)$大呢？从式$\eqref{eq4}$进行分析，并且根据分布函数是非降的性质，可以得到以下几条结论：

1. $\theta$越小，$\beta_\Phi(\theta)$越大。直观的解释是：$\theta$越小，则离原假设越远，越容易和原假设分辨开，即犯第二类错误的概率就越小，因此$\beta_\Phi(\theta)$就越大。当$\theta<\theta_0$但很接近$\theta_0$时(仍在备择假设处)，$\beta_\Phi(\theta)\approx\alpha$。而$\alpha$一般是很小的数，这时犯第二类错误的概率$1-\beta_{\Phi}(\theta)\approx1-\alpha$很接近1；
2. 对固定的$\theta<\theta_0$，$\sigma$越大，$\beta_\Phi(\theta)$越小。直观的解释是：$\sigma$越大，表示误差的方差就越大，$\theta$与$\theta_0$的差别被“淹没”在误差之中，不容易被监测出，因而犯第二次错误的概率就大了；
3. $\alpha$越大，则$u_\alpha$越小，而$\beta_\Phi(\theta)$。直观的解释是：$\alpha$越大，表示能容许的第一类错误的概率增大，这时，作为不长，第二类错误的概率有所降低，即$\beta_\Phi(\theta)$应增加。这里就可以明白看出两种错误概率的矛盾关系；

如果我们提出要求：“犯第二类错误的概率要小于指定的$\beta>0$”，该怎么办呢？这等于要求：
$$
\beta_\Phi(\theta)\ge1-\beta,\ (\theta<\theta_0)\label{eq5}
$$
但是，当$\theta<\theta_0$但$\theta$接近$\theta_0$时，有：$\beta_\Phi(\theta)\approx\alpha$，而因为$\alpha$、$\beta$都很小，并且一般有$\alpha<1-\beta$(由下图可以看到)，这就导致了矛盾：式$\eqref{eq5}$无法达到。

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/9c49ff5d6dd614cbaa0ce6a848e5475.jpg" alt="9c49ff5d6dd614cbaa0ce6a848e5475" style="zoom: 33%;" />

我们只能放松要求，要求对某个指定的$\theta_1<\theta_0$，有(如上图所示)：
$$
\beta_\Phi(\theta)\ge1-\beta,\ (\theta<\theta_1)\label{eq6}
$$
因为$\beta_\Phi(\theta)$随着$\theta$的增加而下降，上式就等价于要求：
$$
\beta_\Phi(\theta_1)\ge1-\beta
$$
按照式$\eqref{eq4}$：
$$
\Phi(\sqrt{n}(\theta_0-\theta_1)/\sigma-u_\alpha)\ge1-\beta
$$
即要求：
$$
\sqrt{n}(\theta_0-\theta_1)/\sigma-u_\alpha\ge u_\beta
$$
即：
$$
n\ge\sigma^2(u_\alpha+u_\beta)^2/(\theta_0-\theta_1)^2\label{eq7}
$$
也就是说，样本大小至少达到式$\eqref{eq7}$右边这么大，才可以达到$\eqref{eq6}$的要求。另外，式$\eqref{eq6}$中的$\theta_1$的选择，需要根据实际需要而定，它表明对$\theta_1$这样接近于$\theta_0$的值而言，无论接受还是否定原假设都不要紧。式$\eqref{eq7}$中$n$与$\sigma^2$成正比，即当方差$\sigma^2$越大时，为达到一定的分辨率(在此可以用$\vert\theta_0-\theta_1\vert$来刻画)，所需要的样本数就越多。





### 检验问题2

对于检验问题2，遵循和上面相同的步骤。

（1）首先，列写检验$\Phi$：
$$
\Phi: 当\bar{X}\le C时接受原假设H'_0,当\bar{X}>C时否定H'_0\label{eq8}
$$
（2）选取$\theta_0$合适的点估计，仍然选择样本均值$\bar{X}$；

（3）当总体有正态分布$N(\theta,\sigma^2)$时，$\sqrt{n}(\bar{X}-\theta)/\sigma$服从标准正态分布$N(0,1)$，以$\Phi$记其分布函数，有：
$$
\begin{split}
\beta_\Phi(\theta)&=P(\bar{X}>C)=1-P(\bar{X}\le C)\\
&=1-P(\sqrt{n}(\bar{X}-\theta)/\sigma\le \sqrt{n}(C-\theta)/\sigma)\\
&=1-\Phi(\sqrt{n}(C-\theta)/\sigma))\\
&=\Phi(\sqrt{n}(\theta-C)/\sigma))\\
\end{split}
$$
（4）在原假设成立时(即$\theta\le\theta_0$时)，使$\beta_\Phi(\theta_0)=\alpha$成立即可，即：
$$
\begin{split}
&\sqrt{n}(\theta_0-C)/\sigma=u_{1-\alpha}=-u_\alpha\\
\Rightarrow&C=\theta_0+\sigma u_{\alpha}/\sqrt{n}
\end{split}\label{eq9}
$$
（5）根据式$\eqref{eq8}$和$\eqref{eq9}$，可以得到检验$\Phi$：
$$
\Phi: 当\bar{X}\le\theta_0+\sigma u_{\alpha}/\sqrt{n}时接受原假设H_0,否则就否定H_0\label{eq11}
$$
及其水平为$\alpha$的功效函数：
$$
\beta_\Phi(\theta)=\Phi(\sqrt{n}(\theta-\theta_0)/\sigma-u_\alpha)
$$
（6）若要求$\beta_\Phi(\theta)\ge1-\beta,\ (\theta\ge\theta_1)$，则选定大于但接近的$\theta_1>\theta_0$，要求：
$$
\beta_\Phi(\theta_1)=\Phi(\sqrt{n}(\theta_1-\theta_0)/\sigma-u_\alpha)\ge1-\beta
$$
则有：
$$
\begin{split}
&\sqrt{n}(\theta_1-\theta_0)/\sigma-u_\alpha=u_\beta\\
\Rightarrow&n\ge\sigma^2(u_\alpha+u_\beta)^2/(\theta_0-\theta_1)^2
\end{split}
$$
与式$\eqref{eq7}$一致。

### 总结1和2

观察式$\eqref{eq10}$和$\eqref{eq11}$，如果样本$(X_1,\cdots,X_n)$使得：
$$
\theta_0-\sigma u_{\alpha}/\sqrt{n}\le\bar{X}\le\theta_0+\sigma u_{\alpha}/\sqrt{n}\label{eq12}
$$
则按照检验问题1的提法，应当接受$H_0:\theta\ge\theta_0$；而按照检验问题2的提法，则应当接受$H'_0:\theta\le\theta_0$。从常理看，两者是矛盾的。但其实，这反映了**统计推断(包括参数估计和假设检验)**的一个特点：它不是按照那种“非此即彼”的逻辑。这类现象其实很常见，比如：

1. 做一个参数$\theta$的点估计，根据同一组样本你可以做出若干不同的估计，比如矩估计、极大似然估计和最大后验估计，讲起来都有其合理性；
2. 做区间估计时，不仅可以用不同的轴枢变量导出不同的估计，即使使用同一个轴枢变量，界限可以有不同的选择，直线系数可以有高低，都可能导致不同的区间。

这些我们都不认为有矛盾，此处亦然。关键在于原假设的选定并非任意，而要看问题中提法上的“倾向性”。这一点可以通过下面的例子进行解释。

假定某工厂生产一种产品，其质量指标服从正态分布$N(\theta,\sigma^2)$，且假定$\sigma^2$已知。$\theta$为平均质量指标，设$\theta$越大，质量越好，而$\theta_0$为达到优级的界限。某商店经常从该工厂进货，商店提出的条件是按批次验收，只有通过检验的批次才被接受。于是，就有以下两种情况：

（1）根据过去较长一段时间的记录，商店相信该厂产品质量总的来说是好的，当然这不排斥偶尔也出现较差的批次。于是，双方约定把$\theta\ge\theta_0$作为原假设并选定一个较低的检验水平$\alpha$，例如$\alpha=0.05$甚至$0.01$。这么做对工厂有利，因为这保证了优质的批次(即$\theta_0\ge\theta_0$)只会以很低的概率$\alpha$被拒收(即发生第一类错误)，而非优质的批次仍能以不小的概率被接受(即发生第二类错误)。从商店的角度考虑，它们也认为这样做并非不利：一是因为该厂产品质量一贯表现很好，故检验可以放款一些，要有很强的证据(即$\bar{X}<\theta_0-\sigma u_\alpha/\sqrt{n}$)才否定$\theta\ge\theta_0$；二是因为，既然大多数批次质量都是优等的，取较小的$\alpha$，保证了这样的批次能以很大的机会通过检验，这对商店有利；有因为质量差的批次本来就不多，即使这样的批次有较大比例混过检验，影响也不大；

（2）反之，如果以往一段时期的记录表明，工厂的产品质量并不很好，这样，商店就可能坚持以$\theta\le\theta_0$作为原假设，并选定一个较小的水平$\alpha$。这样做，表明商店要求要有较强的证据(即$\bar{X}>\theta_0+\sigma u_\alpha/\sqrt{n}$)才能相信这批产品质量为优。等于说一个人一向表现不好，则必须有较显著的表现才能相信他的确有进步。这样做就达到了把$100(1-\alpha)%$的非优批次拒之门外的目的。

由此可见(从以商店为主动的一方看)，同一个问题(即$\theta\ge\theta_0$与否)，**由于对背景的了解不同而采取了不同的态度**，具体是通过选择何者作为原假设来体现的。至此，也就不难理解当样本满足$\eqref{eq12}$时，两个假设$H_0$和$H'_0$都能接受的表面矛盾：你的产品质量一贯很好时，我认为这组样本尚未构成这批产品非优的有利证据；你的产品质量一贯不好时，我认为这同一样本尚未构成这批产品为优的有力证据。仅仅是出发点不同，并无矛盾可言。

### 检验问题3

最后，对于检验问题3：$H''_0$：$\theta=\theta_0$，$H_1''$：$\theta'\ne\theta_0$，直观上看合理的检验规则是：当$\theta$的估计值$\bar{X}$离$\theta_0$较远时否定$H''_0$，不然就接受$H''_0$，即检验$\Phi''$为：
$$
\Phi'': 当\vert\bar{X}-\theta_0\vert\le C时接受H''_0，不然就接受H''_0
$$
使检验$\Phi''$有指定的水平$\alpha$，这等于要求该检验的功效函数：
$$
\begin{split}
\beta_{\Phi''}(\theta)&=P(\vert\bar{X}-\theta_0\vert>C)\\
&=1-P(\vert\bar{X}-\theta_0\vert\le C)\\
&=1-P(\vert\sqrt{n}(\bar{X}-\theta_0)/\sigma\vert\le \sqrt{n}C/\sigma)\\
&=1-\Big(\Phi(\sqrt{n}C/\sigma)-\Phi(-\sqrt{n}C/\sigma)\Big)\\
&=2-2\Phi(\sqrt{n}C/\sigma)
\end{split}
$$
功效函数在$\theta_0$处取值为$\alpha$，则有：
$$
\begin{split}
&\beta_{\Phi''}(\theta_0)=2-2\Phi(\sqrt{n}C/\sigma)=\alpha\\
\Rightarrow&\Phi(\sqrt{n}C/\sigma)=1-\dfrac{\alpha}2\\
\Rightarrow&\sqrt{n}C/\sigma=u_{\alpha/2}\\
\Rightarrow&C=\sigma u_{\alpha/2}/\sqrt{n}
\end{split}
$$
最终，可以得到检验函数$\Phi''$为：
$$
\Phi'': 当\vert\bar{X}-\theta_0\vert\le\sigma u_{\alpha/2}/\sqrt{n}时接受H''_0，不然就接受H''_0
$$
功效函数为：
$$
\begin{split}
\beta_{\Phi''}(\theta)&=2-2\Phi(u_{\alpha/2})=\alpha
\end{split}
$$

### 总结

其实可以证明：检验$\Phi$和检验$\Phi'$分别是检验问题1和2的水平为$\alpha$的一致最优检验，而$\Phi''$则不然，它不是检验问题3的水平为$\alpha$的一致最优检验。甚至可以证明：检验问题3的一致最优检验根本不存在。直观上这一点也不难解释：问题1和2使“单侧”的，即对立假设和原假设各据一侧，这时，检验法则只需要照顾一边即可。而检验问题3是“双侧”的，即对立假设分据原假设的两边，这迫使检验法则采取一种折衷的形态，这就损害了它的最优性。

以上我们讨论了检验问题1~3当方差已知的情况，但在实际使用中，方差一般是未知的。

## 方差$\sigma^2$未知

仍以检验问题1为例。这时，从原则上看，制定检验$\Phi$的思想(式$\eqref{eq1}$)仍然适用，但困难在于，式$\eqref{eq9}$所决定的常数$C$依赖于未知参数$\sigma$，无法确定。因此，需要在上述思想上做一定的修改。

Step1：首先，还是列写









我们把检验$\eqref{eq10}$的未化简得形式在这里重新写一遍：
$$
\Phi: 当\sqrt{n}(\bar{X}-\theta_0)\sigma\ge -u_{\alpha}时接受原假设H_0,否则否定H_0
$$
这里得$\sigma$未知，我们可以考虑使用其估计值$S$进行替代，其中：
$$
S^2=\dfrac1{n-1}\sum_{i=1}^n(X_i-\bar{X})^2
$$
为样本方差。但在用$S$替代$\sigma$之后，分布起了变化：由正态分布变为自由度为$n-1$的$t$分布(详见博客：[Chi-square Distribution, Student’s t Distribution, and F Distribution - What a starry night~](http://whatastarrynight.com/mathematics/programming/Chi-square-and-t-and-F-Distribution/#chi-square-distribution-students-t-distribution-f-distribution))，因而常数$u_\alpha$也要修改为$t_{n-1}(\alpha)$。经过这一修改，我们可以得到检验：
$$
\Psi: 当\sqrt{n}(\bar{X}-\theta_0)S \ge -t_{n-1}(\alpha)时接受原假设H_0,否则就否定H_0
$$
其水平为$\alpha$。

> 我们必须来证明这一点。要证明这一点，首先需要关于“水平”的定义：
>
> 定义：设$\Phi$是原假设$H_0$的一个检验，$\beta_\Phi(\theta_1,\cdots,\theta_k)$为其功效函数，$\alpha$为常数($0\le\alpha\le1$)，如果：
>
> $$
> \beta_\Phi(\theta_1,\cdots,\theta_k)\le\alpha\ (对任何(\theta_1,\cdots,\theta_k)\in H_0)
> $$
>
> 则称$\Phi$为$H_0$的一个水平为$\alpha$的检验，或者说检验$\Phi$的水平为$\alpha$。
>
> 考虑检验$\Psi$的功效函数：
> $$
> \beta_{\Psi}(\theta,\sigma)=P_{\theta,\sigma}(\sqrt{n}(\bar{X}-\theta_0)/S<-t_{n-1}(\alpha))
> $$
> 可以证明，该功效函数：
>
> - 只依赖于$\delta=(\theta-\theta_0)/\sigma$，它是$\delta$的下降函数；
> - 当$\delta=0$时，即$\theta=\theta_0$时，该功效函数的值为$\alpha$；
>
> 第二条比较好证明，因为当$\theta=\theta_0$时，统计量$\sqrt{n}(\bar{X}-\theta_0)/S\sim t_{n-1}$，再根据





# 两个正态总体均值差的检验

假设$X_1,\cdots,X_n$是从正态分布$N(\theta_1,\sigma^2)$中抽出的样本，$Y_1,\cdots,Y_m$是从正态分布总体$N(\theta_2,\sigma^2)$中抽出的样本。$\theta_1$和$\theta_2$均未知









# 正态分布方差的检验

