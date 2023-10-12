# 点估计的优良性准则


## 引子
从上面点估计的实例可以看出，同一个参数往往有不止一种看起来都合理的估计法，因此，自然会提出优劣比较的问题。

乍一看觉得这个问题很容易回答，设$\hat{\theta}_1$和$\hat{\theta}_2$都用于估计$\theta$，则哪一个误差更小，则哪一种方法是最优的。但在实践中会遇到一些问题：
1. 由于 $\theta$ 本身未知，就不知道估计误差有多大；
2. 最主要的是问题在于：$\hat{\theta}_1$和$\hat{\theta}_2$的值都是根据样本计算出来的。一般情况是，对某些样本，$\hat{\theta}_1$的误差小于$\hat{\theta}_2$，而对另一些样本则反之。<font color='red'>一个从整体上看不好的估计，在个别场合下表现得很好</font>。反之，<font color='red'>一个很不错的估计，由于抽到了不易出现的样本，其表现也可能很差</font>。

因此，在考虑估计量的优劣时，必须<font color='red'>从某种整体性能</font>去衡量它，而不能看它<font color='red'>在个别样本下的表现</font>如何。这里所谓的“整体”性能，有两种意义：

1. 一是指估计量的某种特性，具有这种特性就是好的，否则就是不好的，比如估计量的“无偏性”；
2. 二是指某种具体的数量性指标。两个估计量，指标小的估计量就是较优的，比如“均方误差”

应当注意的是：<font color='red'>这种比较，归根到底，也还是相对性的</font>。具体某种特性的估计是否一定就好？这在一定程度上要看问题的具体情况，不是绝对的。作为比较准则的数量性指标，也有很多种，很有可能，在甲指标之下 $\hat{\theta}_1$ 优于 $\hat{\theta}_2$，而在乙指标下则反之。

> “我们这样说，当然不是认为优良性准则和估计量的优劣比较毫无意义。相反，这些很有意义，且是**参数估计**这个分支科学的**中心问题**。我们是想提醒读者，<font color='red'>不要把这些准则绝对化了，每种准则在某种情况下都有其局限性</font>。”


## 估计量的无偏性
### 无偏性的定义
设某统计总体的分布包含位置参数 $\theta_1,  \cdots, \theta_k$，$X_1, \cdots, X_n$是从该总体中抽出的样本，要估计$g(\theta_1, \cdots, \theta_k)$。$g$为一已知函数，设 $\hat{g}(X_1, \cdots, X_n)$是一个估计量。如果对任何可能的$(\theta_1, \cdots, \theta_k)$，都有

$$
E_{\theta_1, \cdots, \theta_k}[\hat{g}(X_1, \cdots, X_n)]=g(\theta_1, \cdots, \theta_k) \tag{1-1}
$$

则称$\hat{g}$是$g(\theta_1, \cdots, \theta_k)$的一个**无偏估计量**。

### 无偏性的含义

估计量的无偏性有两个含义：

（一） 第一个含义是没有系统性偏差。不论你用什么样的估计量$\hat{g}$去估计$g$，总是时而偏低（对于某些样本），时而偏高（对另一些样本）。无偏性表示，把这些正、负偏差在概率上平均起来，其值为0。比如用传感器去测量信号，误差来源有二：一是传感器本身仪器制造上的问题，使它在称东西时，倾向于给出偏高或者偏低的值，这属于**系统误差**；另一种是操作上和其他随机性原因，使称出的结果有误差，这属于**随机误差**。<font color='red'>无偏性的要求相应于传感器没有系统误差，但随机误差总是存在</font>。因此，无偏估计不等于在任何时候都能给出正确无误的估计；

（二）另一个含义是由定义式(1)结合大数定律引申出的。假设每天把统计量 $\hat{g}(X_1, \cdots, X_n)$ 用一次，第 $i$ 天的样本记为 $\hat{g}(X_1^{(i)}, \cdots, X_n^{(i)})$。则按照大数定律，当$N \rightarrow \infty$时，各次估计的平均值，即$\dfrac1N \sum_{i=1}^N \hat{g}(X_1^{(i)}, \cdots, X_n^{(i)})$，依概率收敛到估计的值 $g(\theta_1, \cdots, \theta_k)$。所以，<font color='red'>如果统计量具有无偏性，则在大量次数使用取平均时，能以接近100%的把握无限逼近被估计的量。如果没有无偏性，那么无论使用多少次，其平均也会与真值保持一定的距离，这个距离就是系统误差</font>。

### 无偏性的使用价值

估计量的无偏性是一个优良的性质，但是，在一个具体的问题中，无偏性的使用价值如何，还必须结合这个问题的具体情况考察。

实例1：如果你经常去一家水果店买水果，而店用的称是无系统误差的，这等于说，店里在称上现实的重量是你所买的东西的真是重量的无偏估计。尽管在具体某一次购买中店里可能少给或者多给了你一些，从长期的平均看，无偏性保证了双方都不吃亏。在这个例子中，考察无偏性就有很现实的意义。

实例2：假设工厂每周进一批原料，在投入使用前，实验室会对原料中的某些成分含量的百分率 $p$ 做一个估计，根据估计值 $\hat{p}$ 采取相应的工艺调整措施。无论 $\hat{p}$ 比真正的 $p$ 偏高还是偏低，都会有损产品质量。在这个例子中，即使 $\hat{p}$ 是 $p$ 的无偏估计，在长期使用中，估计的正、负偏差的效应不能抵消。因此，在这个例子中，估计量 $\hat{p}$ 的无偏性实际上并不具备实用意义。


## 最小方差无偏估计

一个参数往往不只有一个无偏估计，从这些众多的无偏估计中，我们想要挑出最优的。这涉及到两个问题：

1. 为优良性指定一个<font color='red'>准则</font>；
2. 在已定的准则下，<font color='red'>如何</font>去找到最优者；

### 均方误差
设 $X_1, \cdots, X_n$ 是从某一带参数 $\theta$ 的总体中抽出的样本，要估计$\theta$ 。如果我们估计量 $\hat{\theta}(X_1, \cdots, X_n)$，则其误差为 $\hat{\theta}(X_1, \cdots, X_n)-\theta$。这个误差随样本 $X_1, \cdots, X_n$ 的具体值而定，也是随机的，因而其本身无法取为优良指标。我们把它平方以消除符号，得 $(\hat{\theta}(X_1, \cdots, X_n)-\theta)^2$，然后取它得均值，即取

$$
M_{\hat{\theta}}(\theta)=E_{\theta}\bigl[\hat{\theta}(X_1, \cdots, X_n)-\theta\bigr] ^2  \tag{2-1}
$$
作为 $\hat{\theta}$ 的误差大小从整体角度的一个衡量。这个量越小，就表示 $\hat{\theta}$ 的误差平均来讲比较小，因而也越优秀。$M_{\hat{\theta}}(\theta)$ 就称为估计量 $\theta$ 的“均方误差”（误差平方的平均）。均方误差小并不能保证 $\hat{\theta}$ 在每次使用时一定给出小的误差，它有时可以有较大的误差，但这种情况出现的机会比较少。

根据方差的一种计算形式：$Var(X)=E(X^2)-(EX)^2$，可以将式(2-1)写作

$$
\begin{aligned}
M_{\hat{\theta}}(\theta)
=& Var_{\theta}(\hat{\theta}-\theta) +\bigl[E_{\theta}(\hat{\theta}-\theta)\bigr]^2\\
=& Var_{\theta}(\hat{\theta}) +\bigl[E_{\theta}(\hat{\theta})-\theta\bigr]^2
\end{aligned}
$$

式(2-2)表明均方误差由两部分构成：
-  $Var_{\theta}(\hat{\theta})$ ，即 $\hat{\theta}$ 的方差，表示 $\hat{\theta}$ 自身变异的程度；
-  $E_{\theta}(\hat{\theta})-\theta$，表示估计量 $\hat{\theta}$ 的系统偏差。如果 $\hat{\theta}$ 为 $\theta$ 的<font color='red'>无偏估计</font>，则该项为0，这时有：$$M_{\hat{\theta}}(\theta)=Var_{\theta}(\hat{\theta})$$



均方误差并不是唯一可供选择的准则。比如，平均绝对误差 $E_{\theta}|\hat{\theta}(X_1,\cdots,X_n)-\theta|$，以及许多别的准则，看来都很合理，且在某些场合下有独特的优势，但是由于平方这个函数在数学上最容易处理，使得均方误差是这些准则中应用和研究得最多的。

### 最小方差无偏估计
从前面的讨论可以看到，如果<font color='red'>（1）局限于无偏估计的范围</font>，且<font color='red'>（2）采用均方误差的准则</font>，则两个无偏估计 $\hat{\theta}_1$ 和 $\hat{\theta}_2$ 的比较总结为其方差的比较：方差小的估计量较优。


如果 $\hat{\theta}$ 为 $g(\theta)$ 的一个无偏估计，且它的方差对 $\theta$ 的任何可能取的值，都比任何其他的无偏估计的方差小，或至多等于它，则在“方差越小越好”的准则下， $\hat{\theta}$ 就是最好的，它称为 $\theta$ 的“最小方差无偏估计”，简记为**MVU估计**(Minimum Variance Unbiased)。

> **定义**
> 设 $\hat{\theta}$ 为 $g(\theta)$ 的一个无偏估计。若对 $g(\theta)$  的任何一个无偏估计 $\hat{\theta}_1$，都有$$Var_{\theta}(\hat{\theta}) \le Var_{\theta}(\hat{\theta}_1)$$对 $\theta$ 的任何可能取的值都成立，则称 $\hat{\theta}$ 为 $g(\theta)$ 的一个最小方差无偏估计（MVU估计）。

那么<font color='blue'>如何去寻找MVU估计呢？</font> 数理统计学给出了一些方法，这里介绍其中一个，该方法的思想如下：先研究一下在 $g(\theta)$ 的<font color='red'>一切无偏估计</font>中，方差最小能达到多少？如果我们求出了这样一个方差的下界，那么如果某个估计 $\hat{\theta}$ 的方差达到这个下界，那它必定就是MVU估计。

### 求MVU估计的一种方法：克拉美·劳不等式
#### 克拉美·劳不等式
我们只考虑<font color='red'>单参数</font>的情况。假设总体的概率密度函数 $f(x,\theta)$ 只包含一个参数 $\theta$，$X_1,\cdots, X_n$ 为从该总体中抽出的样本，要估计 $g(\theta)$。记
$$
I(\theta)=\int\biggr[\Bigr(\dfrac{\partial f(x,\theta)}{\partial \theta}\Bigl)^2/f(x,\theta)\biggl]dx
$$

其中，积分的范围为 $x$ 可取的范围。例如，对指数分布总体，为 $0\lt x\lt \infty$；对正态总体，则 $-\infty \lt x\lt \infty$。

> 如果总体分布是离散的，那么式(2-3)改写为
> $$
> I(\theta)=\sum_i \Bigr(\dfrac{\partial f(a_i,\theta)}{\partial \theta}\Bigl)^2/f(a_i,\theta)
> $$
> 这里，求和符号 $\sum_i$ 遍及总体的全部可能值 $a_1, a_2, \cdots$。下面基于<font color='red'>连续的情况</font>进行讨论，对离散的情况，只需要进行相应的修改。

**克拉美-劳不等式**
在一定条件下，对 $g(\theta)$ 的任一无偏估计 $\hat{g}=\hat{g}(X_1, \cdots, X_n)$，有
$$
\mathrm{Var}_{\theta}(\hat{g})\ge\bigr(g^{\prime}(\theta)\bigl)^2/(nI\bigr(\theta)\bigr)
$$
其中 $n$ 为样本大小。

不等式(2-5)的右边$\textcolor{red} {\bigr(g^{\prime}(\theta)\bigl)^2/(nI\bigr(\theta)\bigr)}$给出了 $g(\theta)$ 的无偏估计的方差的一个下界。如果 $g(\theta)$ 的某个无偏估计的方差正好达到了不等式(2-5)的右端，那它就是 $g(\theta)$ 的MVU估计。


> 记
> 
> $$
> \begin{aligned}S&=S(X_1, \cdots, X_n, \theta)\\
> &=\sum_{i=1}^n\dfrac{\partial \ln f(X_i,\theta)}{\partial \theta}\\
> &=\sum_{i=1}^n\dfrac{\partial f(X_i,\theta)}{\partial \theta}/f(X_i,\theta)
> \end{aligned}
> $$
> 
> 因为 $f(x,\theta)$ 为概率密度，有$$\int f(x,\theta)\mathrm{d}x=1\tag{2-7}$$两边对 $\theta$ 求导，并<font color='red'>假定左边求导可搬到积分号内</font>（条件之一），有$$\int\dfrac{\partial f(x,\theta)}{\partial \theta}\mathrm{d}x=0\tag{2-8}$$因此，
> 
> $$
> \begin{aligned}E_{\theta}\Bigr[\dfrac{\partial f(X_i,\theta)}{\partial \theta}/f(X_i,\theta)\Bigl]
> &=\int\Bigr(\dfrac{\partial f(x,\theta)}{\partial \theta}/f(x,\theta) \Bigl)f(x,\theta)\mathrm{d}x\\
> &=\int\Bigr(\dfrac{\partial f(x_i,\theta)}{\partial \theta}\Bigl)\mathrm{d}x\\
> &=0
> \end{aligned}
> $$
> 
> 于是，由于<font color='red'>$X_1,\cdots, X_n$的独立性</font>，有
> 
> $$
> \begin{aligned}
> \mathrm{Var}_{\theta}(S)&=\sum_{i=1}^n \mathrm{Var}_{\theta}\Bigr(\dfrac{\partial f(X_i,\theta)}{\partial \theta}/f(X_i,\theta) \Bigl)\\
> &=\sum_{i=1}^n E_{\theta}\Bigr(\dfrac{\partial f(X_i,\theta)}{\partial \theta}/f(X_i,\theta) \Bigl)^2\\
> &=n\int\Bigr[\dfrac{\partial f(x,\theta)}{\partial \theta}/f(x_i,\theta) \Bigl]^2f(x,\theta)\mathrm{d}x\\
> &=nI(\theta)
> \end{aligned}
> $$
> 
> 根据协方差的重要性质：<font color='blue'>$\Bigr[ \mathrm{Cov}(X,Y)\Bigl]^2\le\mathrm{Var}(X)^2\mathrm{Var}(Y)^2$</font>，则有
> 
> $$
> \Bigr[ \mathrm{Cov}_{\theta}(\hat{g},Y)\Bigl]^2\le\mathrm{Var}_{\theta}(\hat{g})\cdot \mathrm{Var}_{\theta}(S)=nI(\theta)\cdot \mathrm{Var}_{\theta}(\hat{g})
> $$
> 
> 有根据协方差的另一条性质，<font color='blue'>$\mathrm{COV}(X,Y)=E(XY)-E(X)E(Y)$</font>，则有：
> 
> $$
> \begin{aligned}
> \mathrm{Cov}_{\theta}(\hat{g},S)&=E(\hat{g}\cdot S)-E(\hat{g})E(S)
> \end{aligned}
> $$
> 
> 又根据式(2-9)，有$E(S)=0$，于是可以得到
> 
> $$
> \begin{aligned}
> \mathrm{Cov}_{\theta}(\hat{g},S)
> &=E(\hat{g}\cdot S)\\
> &=\int\cdots\int \hat{g}(x_1,\cdots,x_n)\sum_{i=1}^n\biggr[\dfrac{\partial f(x_i,\theta)}{\partial \theta}/f(x_i,\theta)\biggl]\cdot\prod_{i=1}^n f(x_i,\theta)\mathrm{d}x_1\cdots\mathrm{d}x_n
> \end{aligned}
> $$
> 
> 由<font color='blue'>乘积的导数公式</font>可知
> 
> $$
> \sum_{i=1}^n\biggr[\dfrac{\partial f(x_i,\theta)}{\partial \theta}/f(x_i,\theta)\biggl]\cdot\prod_{i=1}^n f(x_i,\theta)=\dfrac{\partial f(x_1,\theta)\cdots f(x_n, \theta)}{\partial \theta}
> $$
> 
> 代入式(2-12)，并<font color='red'>假定对 $\theta$ 求偏导数可以移到积分号外面</font>（这又是一个条件），则有
> 
> $$
> \mathrm{Cov}_{\theta}(\hat{g},S)=\dfrac{\partial}{\partial \theta}\int\cdots\int \hat{g}(x_1,\cdots,x_n)f(x_1,\theta)\cdots f(x_n,\theta)\mathrm{d}x_1\cdots\mathrm{x}_n
> $$
> 
> 式(2-13)右边的积分就是 $E_\theta(\hat{g})$，又因 $\hat{g}$为 $g(\theta)$ 的无偏估计，因此这个积分就是 $g(\theta)$，所以式(2-13)可以写作：
> 
> $$
> \mathrm{Cov}_{\theta}(\hat{g},S)=g^{\prime}(\theta)
> $$
> 
> 将式(2-14)带入式(2-11)，于是就可以得到克拉美·劳不等式(2-5)。
> Q.E.D.

不等式(2-5)是瑞典统计学家H·克拉美([Harald Cramé](https://en.wikipedia.org/wiki/Harald_Cram%C3%A9r))和印度统计学家C·R·劳([C. R. Rao](https://en.wikipedia.org/wiki/C._R._Rao))在1945~1946年各自独立得出的，故文献中一般称为克拉美·劳不等式。<font color='red'>克拉美·劳不等式在数理统计学中有多方面的应用，这里的MVU估计就是其中之一</font>。

克拉美·劳不等式<font color='red'>并不直接给出找MVU估计的方法</font>，它使用的方式是：先由直观或其他途径找出一个可能是最好的无偏估计，然后计算其方差，看是否达到克拉美·劳不等式右端的界限，如果达到了，就是MVU估计。并且**在推导的同时，还得仔细验证不等式的推导过程中的所有条件是否全满足，这有时是不太容易的**。

#### 费歇尔信息量
式(2-5)中 $I(\theta)$ 这个量，即式 (2-3)，最初是由英国统计学家R·A·费歇尔（[Ronald Aylmer Fisher](https://en.wikipedia.org/wiki/Ronald_Fisher)）在20世纪20年代提出的（早于克拉美·劳不等式），后人称之为“费歇尔信息量”（Fisher information）。费歇尔信息量 $I(\theta)$ 出现在克拉美·劳不等式中并非偶然的巧合，我们再观察一下克拉美·劳不等式

$$
\mathrm{Var}_{\theta}(\hat{g})\ge\bigr(g^{\prime}(\theta)\bigl)^2/(n\textcolor{red}{I\bigr(\theta)}\bigr)
$$

从这个式子我们可以对“信息量”有一个更直观的理解： $I(\theta)$ 越大，则不等式右边的下界就越低，表示 $g(\theta)$ 的无偏估计更有可能达到较小的方差，即有可能被估计得更准确一些；另一方面，$g(\theta)$ 是通过样本去估计的，$g(\theta)$ 能估计得更准，表示样本所含有得信息量越大。一共有 $n$ 个样本，如果把总信息量说成是不等式右边的分母 $nI(\theta)$，则一个样本正好占有信息量 $I(\theta)$。

$I(\theta)$这个量在数理统计学中很重要，有很多方面的应用。

#### 例题
*注：以下的推导过程均<font color='red'>**不**</font>验证克拉美·劳不等式的推导过程中的所有条件是否满足，但其实这是一个相当重要且并不容易的工作。*

>例1：设 $X_1, X_2, \cdots, X_n$ 为抽自正态总体 $N(\theta, \sigma^2)$的 $n$ 个样本，$\sigma^2$ 已知（因而只有一个参数 $\theta$），说明样本均值 $\bar{X}$ 是 $\theta$ 的MVU估计。

解：正态分布函数的概率密度函数形式

$$
f(x, \theta)=(\sqrt{2\pi}\sigma)^{-1}\exp\Big( -\dfrac{(x-\theta)^2}{2\sigma^2}\Big)
$$

进一步有：

$$
\dfrac{\partial f(x,\theta)}{\partial \theta}=(\sqrt{2\pi}\sigma)^{-1}\exp\Big( -\dfrac{(x-\theta)^2}{2\sigma^2}\Big)\dfrac1{\sigma^2}(x-\theta)
$$

根据公式(2-3)，可以得到

$$
\begin{aligned}
I(\theta)&=\int^{+\infty}_{-\infty}\biggr[\Bigr(\dfrac{\partial f(x,\theta)}{\partial \theta}\Bigl)^2/f(x,\theta)\biggl]\mathrm{d}x\\
&=\int^{+\infty}_{-\infty}\biggr[\dfrac{(x-\theta)^2}{\sqrt{2\pi}\sigma^5}\exp
\Big( -\dfrac{(x-\theta)^2}{2\sigma^2}\Big)\biggl]\mathrm{d}x\\
&=2(\sqrt{\pi}\sigma^2)^{-1}\int^{+\infty}_{-\infty}\biggr[(\dfrac{x-\theta}{\sqrt{2}\sigma})^2
\exp\Big( -(\dfrac{x-\theta}{\sqrt{2}\sigma})^2\Big)\biggl]
\mathrm{d}\Big[\dfrac{(x-\theta)}{\sqrt{2}\sigma}\Big]\\
&=2(\sqrt{\pi}\sigma^2)^{-1}\int^{+\infty}_{-\infty}t^2\exp(-t^2)\mathrm{d}t\\
&=2(\sqrt{\pi}\sigma^2)^{-1}\int^{+\infty}_{0}t\exp(-t^2)\mathrm{d}t^2\\
&=2(\sqrt{\pi}\sigma^2)^{-1}\int^{+\infty}_{0}z^{1/2}\exp(-z)\mathrm{d}tz\\
\end{aligned}
$$

根据 [$\Gamma$ 函数的定义及递推关系式](https://blog.csdn.net/weixin_44983951/article/details/125573046?csdn_share_tail=%7B%22type%22:%22blog%22,%22rType%22:%22article%22,%22rId%22:%22125573046%22,%22source%22:%22weixin_44983951%22%7D&ctrtid=vb3K9)，上式可以写作：

$$
\begin{aligned}
I(\theta)&=2(\sqrt{\pi}\sigma^2)^{-1}\Gamma(3/2)\\
&=2(\sqrt{\pi}\sigma^2)^{-1}\times\dfrac12\sqrt{\pi}\\
&=\dfrac1{\sigma^2}
\end{aligned}
$$

样本均值 $\bar{X}$ 是估计正态分布均值的无偏估计量，故 $g(\theta)=\theta$。于是代入到克拉美·劳不等式的右边，得到

$$
右端=\bigr(g^{\prime}(\theta)\bigl)^2/(nI\bigr(\theta)\bigr)=\dfrac1{n\cdot\dfrac1{\sigma^2}}=\dfrac{\sigma^2}{n}
$$

而样本均值 $\bar{X}$ 作为一种<font color='blue'>无偏</font>估计量，它的<font color='blue'>均方误差</font>，也即克拉美·劳不等式的左端项为
$$
左端=\mathrm{Var}(\bar{X})=\dfrac1n\mathrm{Var}(X_1)=\dfrac1n\sigma^2
$$

于是，可以得出结论：样本均值 $\overline{X}$ 是 $\theta$ 的MVU估计。


> **使用克拉美·劳不等式求解单参数的MVU估计的步骤**
>
> 1. 检验克拉美·劳不等式推导过程中的所有条件是否满足（上述解题没有说明，但重要且困难）
> 2. 根据待估计函数的概率密度函数形式 $f(x,\theta)$ 计算$\dfrac{\partial f(x,\theta)}{\partial \theta}$，进而计算**费歇尔信息**$\bm{I(\theta)}$
> 3. 由直观或其他途径找出一个可能是最好的<font color='red'>无偏</font>估计 $g(\theta)$（必须保证是无偏估计），并计算 $\bm{g^{\prime}(\theta)}$
> 4. 根据步骤2和步骤3计算出的**费歇尔信息**$\bm{I(\theta)}$和 $\bm{g^{\prime}(\theta)}$ 计算克拉美·劳不等式的右端项，即**克拉美·劳下界**
> 5. 计算<font color='red'>无偏</font>估计的<font color='red'>均方误差</font>
> 5. 观察计算出的均方误差是否到达不等式右端的**克拉美·劳下界**，若达到，则该估计就是MVU估计，否则不是。


#### 使用克拉美·劳不等式的条件
克拉美·劳不等式在表述和推导的过程中，需要满足一系列的条件。
在表述中，就包含了要求 <font color='red'> $\dfrac{\partial f(x,\theta)}{\partial \theta}$ 存在</font> 和 <font color='red'>  $g^{\prime}(\theta)$ 存在</font> 的条件。

## 估计量的相合性与渐近正态性
### 相合性
> **定义3.1：大数定理**
> 若 $X_1, X_2, \cdots, X_n, \cdots$ 独立同分布，其公共均值为 $\theta$。记 $\bar{X_n}=\frac1n
> \sum_{i=1}^nX_i$，则对 $\forall \varepsilon\gt 0$，有
> 
> $$
> \lim \limits_{n\rightarrow \infty} P(\bigl| \bar{X_n} -\theta\bigr|\ge \varepsilon)=0. \tag{3-1}
> $$

如果从估计的观点对式 (3-1) 做一个解释。如果我们把 $X_1, X_2, \cdots, X_n$ 看作从某一总体中抽出的样本，抽样的目的是估计该总体的均值 $\theta$。概率 $P(\bigl| \bar{X_n} -\theta\bigr|\ge \varepsilon)$ 表示“当样本大小为 $n$ 时，样本均值 $\bar{X_n}$ 这个估计与真值 $\theta$ 的偏离大于等于 $\varepsilon$ ”的可能性。而式 (3-1) 表明，随着 $n$ 的增加，这种可能性越来越小，最终趋近于0。也就是说，只要样本大小 $n$ 足够大，用样本均值去估计总体均值，其误差可以任意小。在数理统计学上，就把 $\bar{X_n}$ 称为 $\theta$ 的相合估计，也就是说，随着样本大小的增加，被估计的量与估计量逐渐“合”在一起了。

> **定义3.2：相合估计**
> 假设总体分布依赖于参数 $\theta_1, \cdots, \theta_k$, $g(\theta_1, \cdots, \theta_k)$ 是 $\theta_1, \cdots, \theta_k$ 的一个给定函数。设 $X_1, \cdots, X_n$ 是从该总体中抽出的样本，$T(X_1, \cdots, X_n)$ 是函数 $g(\theta_1, \cdots, \theta_k)$ 的一个估计量，如果对 $\forall \varepsilon\gt 0$，有
> 
> $$
> \lim \limits_{n\rightarrow \infty}
> P_{\theta_1, \cdots, \theta_k}\Bigr(\big|
> T(X_1, \cdots, X_n)-g(\theta_1, \cdots, \theta_k)
> \big|\ge \varepsilon\Big)=0
> $$
> 
> 而且对于 $(\theta_1, \cdots, \theta_k)$ 一切可能取的值都成立，则称$T(X_1, \cdots, X_n)$ 是函数 $g(\theta_1, \cdots, \theta_k)$ 的一个**相合估计**。


记号 $P_{\theta_1, \cdots, \theta_k}$ 的意义，表示概率实在参数值为 $(\theta_1, \cdots, \theta_k)$ 时去计算的。

相合性是对一个估计量<font color='red'>**最**基本</font>的要求。如果一个估计量没有相合性，那么，无论样本数量多么大，我们也不可能把未知参数估计到任意预定的精度。这种估计量显然是不可取的。

###  渐近正态性
估计量是样本 $X_1, X_2, \cdots, X_n$ 的函数，其<font color='red'>确切的</font>分布需要用到概率轮的相关方法去求。除了若干简单的情况以外，这通常是难以实现的。比如，样本均值算是最简单的统计量，它的分布也不容易求得。

可是，正如中心极限定理中所阐述的，当 $n$ 很大时，**和**的分布渐近于正态分布。理论上可以证明，这个性质不是**和**所独有的，<font color='red'>许多形状复杂的统计量，当样本大小 $n\rightarrow \infty$ 时，其分布都渐近于正态分布</font>。这称为统计量的**渐近正态性**。至于哪些统计量具有渐近正态性，其确切形式是什么，这些都是很高深的理论问题。

### 估计量的大样本性质 vs. 小样本性质
估计量的相合性和渐近正态性称为估计量的**大样本性质**，指的是：这种性质都是对样本 $n\rightarrow \infty$ 来谈的。<font color='red'>对一个固定的  $n$，相合性和渐近正态性都无意义。</font>

与此相对，估计量的无偏性概念是对固定的样本大小来谈的，不需要样本大小区域无穷，这种性质称为**小样本性质**。

总之，大样本性质、小样本性质之分并不在于样本的具体大小如何，而在于样本大小是否趋于无穷。

<br>

# 点估计优良性评估实例

由上文中点估计实例我们可以得到，对于总体分布为正态分布的样本，使用不同的点估计方法得到的对于均值 $\mu$ 和方差 $\sigma^2$ 的估计量，下面分别对它们的优良性做出评估。

**（1）矩估计法**

对于均值 $\mu$ 和方差 $\sigma^2$，有：

$$
\begin{align*}
\hat{\mu}&=\overline{X}=\dfrac1n\sum_{i=1}^nX_i\\
\hat{\sigma^2}&=S^2=\dfrac1{n-1}\sum_{i=1}^n(\overline{X}-X_i)^2
\end{align*}
$$

**（2）极大似然估计法**

对于均值 $\mu$ 和方差 $\sigma^2$

$$
\begin{align*}
\hat{\mu}&=\dfrac1n\sum_{i=1}^nX_i\\
\hat{\sigma^2}&=\dfrac1{n}\sum_{i=1}^n(\overline{X}-X_i)^2
\end{align*}
$$



**（3）贝叶斯估计法**

对于均值 $\mu$，有



# Conclusion

矩估计法，MLE都是建立方程组。

