---
layout: single
title: "Neyman-Pearson Hypothesis Testing(Statistical Hypothesis Testing)"
date: 2022-10-25 22:11:01 +0800
categories: 
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
 - Hypothesis Test
 - Experiment
---

# Practical Examples for Hypothesis Test

## Example 1

在博客 [1] 中提到了一个在电子元件服从指数分布的假定下，通过对抽出的若干个原件进行测试所得的数据(样本)去判定“元件平均寿命不小于5000个小时”是否成立的问题。

这个问题的相关事项，可以用统计学的语言进行表述：

（1）我们有一个总体，即所考察的那一大批元件的寿命。我们对总体分布做了一个假定，即认为它服从指数分布(参考博客[2])，该分布包含了一个未知参数$\lambda$；

（2）我们从该总体中抽出的样本$X_1,\cdots,X_n$，即抽出的$n$个元件测试出的寿命；

（3）我们有一个命题(即“元件平均寿命不小于5000个小时”)，其正确与否完全取决于未知参数$\lambda$的值，即$1/\lambda\ge5000$。它把参数$\lambda$的所有可能取的值$0<\lambda<\infty$分成两部分：一部分是$H_0=\{\lambda\vert\lambda\le1/5000\}$，一部分是$H_1=\{\lambda\vert\lambda>1/5000\}$。$H_0$内的$\lambda$值使上述命题成立，而$H_1$内的$\lambda$值使上述命题不成立。故我们的命题可以记作$\lambda\in H_0$，简记作$H_0$；

（4）我们的任务是利用所获得的样本$X_1,\cdots,X_n$去判断命题$\lambda\in H_0$是否成立。之所以能这么做，是因为样本中包含了总体分布的信息，也就包含了“$\lambda\in H_0$”是否成立的信息。

在数理统计学上，把类似于“$\lambda\in H_0$”这种命题称为一个“假设”或“统计假设”。

注：“假设”这个词在此就是一个其正确与否有待通过样本去判断的陈述，不要把它和通常意义相混淆。例如，在数学上常说“假设某函数处处连续”之类的话，**是一个所讨论的问题中已被承认的前提或条件**，与此处所讲的完全不同。
{: .notice--warning}

在数理统计学中，通常用“检验”一词来代替上文的“判断”。“检验”一词有动词和名词两种含义。动词含义是指判断全过程的操作，而名词的含义则是指**判断准则**。例如，对本例而言，一个看起来合理的判断准则是“当$\overline{X}\ge C$时就认为假设$\lambda\in H_0$正确，否则就不正确”（$C$是一个适当的常数，后面会讲到关于它的选择）。在这里，“检验”就是一个名词。“认为假设正确”在统计上称为**接受**该假设；“认为假设不正确”在统计上称为**否定**或**拒绝**该假设。到此未知，统计问题可以说已经完成了，至于接受或否定假设之后如何办，就不是统计学所考虑的问题了。

假设检验的问题是很常见的，下面再举几例。

## Example 2

例2：有人给我一根金条，他说其重量为312.4克。我现在拿到一架精密仪器上重复称$n$次，得出结果为$X_1,\cdots,X_n$。我假定：此天平称出的结果服从正态分布$N(\mu,\sigma^2)$，这时我要检验的假设是“$\mu=312.5$”。

在这个例子中，$\sigma$的信息可以是已知的，也可以是未知的。如果$\sigma$未知，则总体分布含有多个参数，但是我们的假设中可以只涉及其中一个。

当然，我们也可以使用这块金子来检验精密仪器的方差。比如，人家告诉我这这架天平的测量方差为$10^{-4}(g^2)$，我怀疑是否如此。此时，我就可以拿这块金子在该天平上称$n$次，得出$X_1,\cdots,X_n$，利用这些数据去检验假设“$\sigma^2=10^{-4}(g^2)$”。仍然假设总体为正态分布$N(\mu,\sigma^2)$，$\mu$就是这件物体的重量，它同样可以是已知的，也可以是未知的。

## Example 3

例3：某工厂一种产品的一项质量指标假定服从正态分布$N(\mu_1,\sigma^2)$。现在，对其制作工艺做了若干变化，我想通过样本来检验一下“结果质量是否起了变化或者有了改进”。

注：这个例子和下面的描述相当具有实用意义。
{: .notice--primary}

假定修改工艺后，质量指标仍服从正态分布，且**只均值可能有变，而方差不变**，即服从$N(\mu_2,\sigma^2)$。我把要检验的假设定为：

$$
H_0:\{\mu_1=\mu_2\}
$$

或者(设均值大者为优)：

$$
H_0':\{\mu_1\ge\mu_2\}
$$

选$H_0$，是针对“质量起了变化”的说法。由于我们不能凭空说$\mu_1$不能$\mu_0$，我们只能先做假设$H_0$。如果经过检验，$H_0$被否定了，那么我们就可以承认质量起了变化，不然只能维持$H_0$。那么，为什么不取$\{\mu_1\ne\mu_2\}$作为假设去检验？从表面上看，这么做没有问题，因为这两种提法从实质上看知识表述方式不同。==但是，我们有不这么做的理由，这一点需要用到后面的知识进行解释。==

选$H_0'$，则是针对“质量有了改进”的说法，与上文类似。

本例中的$\sigma^2$可以是已知的，也可以是未知的。又“工艺变换前后质量方差一样”是一个人们可能会质疑的假定，因为在通常情况下，质量的改进也常反映在其波动变小上，即方差会小些）。如果假定前后方差并非一致，则会得到贝伦斯——费歇尔检验问题，这是数理统计学中一个著名的问题，其区间估计问题在博客中 [3] 有所提及，这个问题还没有很好地解决。

如果不认为质量的平均值有多大的改变，其改变发生在方差上，则假定在工艺改进前后质量指标的分布分别为$N(\mu_1,\sigma_1^2)$和$N(\mu_2,\sigma_2^2)$。这时，要检验的假设可以定为“$\sigma_1^2=\sigma_2^2$”或“$\sigma_1^2\le\sigma_2^2$”。

## Example 4

例4：甲、乙两位棋手下棋，共下$n$局，甲$m$胜$n-m$负(假设无和局)，根据这一结果，对两位棋手的棋艺是否有差别做出判断。

若以$p$记每局中甲胜的概率，则乙胜的概率为$1-p$。假定每局的结果独立(这很接近事实，除非其中一位或两位选手心理素质差，以致已赛的结果显著影响他的情绪)，则若以$X$记在$n$局中甲胜的局数，那么则有$X\sim B(n,p)$。我们的问题可提为：检验假设“$p=1/2$”。

## Example 5

例5：有一颗供赌博或其他用途的骰子，我们怀疑它是否均匀，要用投掷若干次的结果去检验它。若以掷出点数的概率分布来表示，所要检验的内容可表为假设：

$$
H_0:p_1=p_2=\cdots=p_6=1/6\notag
$$

这里，$p_i$是骰子掷出点数$i$点的概率。这意味着把骰子的均匀性解释为：它掷出任何一点的机会都相同。

<br>

# Terminologies

从上述诸例中，我们明确了假设检验问题的提法。下面就介绍假设检验中几个常用的名词。

## Null hypothesis and Alternative hypothesis

在假设检验中，常常把一个被检验的假设叫做原假设(Null hypothesis)，而其对立面就叫做对立假设。如在例1中，原假设为：$H_0=\{\lambda\vert\lambda\le1/5000\}$，故其对立假设为：$H_1=\{\lambda\vert\lambda>1/5000\}$。原假设的“原”字，字面上可解释为“原本有的”。如在例2中，可以说$\mu=312.5$原本就不存在问题，只是因为有人怀疑，才提出了也存在$\mu\ne312.5$的可能。$\mu=312.5$为“原有”的，而$\mu\ne312.5$是“后来的”。这样的解释也并非总是合适的。其实，对于“原”字也不必硬加一种解释。

原假设又常称为“零假设”或“消解假设”(英文都为Null Hypothesis)。这个名词的含义拿例3中的假设$H_0:\mu_1=\mu_2$来解释最为贴切。因为$\mu_1-\mu_2$反映工艺变化后所产生的效应，这个假设$H_0$把这个效应化为零了，或者说把这个效应“消解”了。但同样地，在有些情况下这个名词也并非贴切，因此也有不少人不喜欢用这个名称

对立假设(alternative hypothesis)就是与原假设对立的意思。这个词既可以指全体，也可以指一个或一些特殊的情况。例如，对于例1，我们说对立假设为$\lambda>1/5000$，这里指全体，但是也可以说$\lambda-1.5$是一个对立假设，这无非是指1.5这个值是对立假设的一个成员。对立假设也常称为“备择假设”，其含义是：在抛弃原假设后可供选择的假设。

## Test statistic, Region of acceptance, Region of rejection, and Critical value

在检验一个假设时所使用的统计量称为检验统计量(Test statistic)。仍以例1来说，前面已经提到了一个在直观上合理的检验：当$\overline{X}\ge C$时接受原假设，不然就否定，这里使用到的检验统计量就是$\overline{X}$

使原假设得到接受的那些样本$(X_1,\cdots,X_n)$所在的区域$A$，称为该检验的接受域；而使原假设被否定的那些样本所构成的区域$R$，则称为该检验的否定域。否定域有时也称为拒绝域、临界域。比如，在例1中，刚才所提到的检验的接受域为：

$$
A=\{(X_1,\cdots,X_n)\vert X_1+\cdots+X_n\ge nC\}\notag
$$

否定域为：

$$
R=\{(X_1,\cdots,X_n)\vert X_1+\cdots+X_n<nC\}\notag
$$

$A$与$R$互补，知其一即知其二。**确定一个检验，就等价于指定其接受域或否定域**。

在上述检验中，$C$这个值处于一个特殊的地位：$\overline{X}$一旦超过$C$这个界线，结论就由接受变为否定。这个值$C$称为**<u>检验统计量</u>$\overline{X}$的临界值(Critical value)**。当心中明确了用什么统计量时，也可以说是“**<u>检验</u>的临界值**”。例如，若心中已经明确使用统计量$X_1+\cdots+X_n$，则临界值$nC$，也可以有不止有一个临界值。比如在例1中，若要检验的原假设改为“$\lambda=1/5000$”，则一个合理的检验法是：当$C_1\le\overline{X}\le C_2$时接受；不然就否定。这时，$C_1$，$C_2$是两个适当选定的常数，它们都是临界值。

## Simple hypothesis and Composite hypothesis

不论是原假设还是对立假设，若其中只含有一个**参数值**，则称为简单假设(Simple hypothesis)；否则称为复合假设(Composite hypothesis)。

如在例1中，原假设$\lambda\le1/5000$包含所有大于0而且不超过$1/5000$的$\lambda$值，它是复合的；对立假设$\lambda>1/5000$也是复合的。

例2的情况稍微有些复杂，若$\sigma^2$已知，则原假设只含有参数$\mu$的一个值312.5，因此是一个简单假设；若$\sigma^2$未知，则原假设包含了所有形如$(312.5,\sigma^2)$($\sigma^2$任意)的参数值，因此是复合的。这里的要点是：**在决定一个假设是简单还是复合时，要考虑到总体分布中的一切参数，而不只是直接出现在假设中那部分参数**。如在例2中，$\sigma^2$虽然不出现在假设中，但因为它是总体分布的未知参数，故仍要考虑进来。这种参数(如此处的$\sigma^2$)在数理统计学上称为赘余参数(Nuisance Parameter)。在区间估计中也经常用到这个名词，如在正态总体$N(\mu,\sigma^2)$中，$\mu$和$\sigma^2$都未知，要做$\mu$的区间估计，这时$\sigma^2$就是赘余参数。

## Test function

功效函数(Test function)是假设检验中最重要的概念之一。在下面可以看到：同一个原假设可以有许多检验方法。其中自然有优劣之分。这种区分的依据，就取决于检验的功效函数。

再考虑例1，并设我们取定了如下的检验：

$$
\Phi:当\overline{X}\ge C时接受，不然就否定\label{eq1}
$$

如果我们使用这个检验，则原假设$H_0:\lambda\le1/5000$被接受或者被否定都是随机事件，因为其发生与否，要看样本$X_1,\cdots,X_n$如何，而样本是随机的。在这里，原假设被否定的概率为：

$$
\beta_\Phi(\lambda)=P_\lambda(\overline{X}<C)
$$

这里，$P_\lambda$是指事件$\{\overline{X}<C\}$的概率是在总体分布值为$\lambda$时去计算的。至此，我们只知道样本的**总体分布**为指数分布，并且有了抽样分布$P_\lambda(\overline{X}<C)$的一个表示式，我们并不知道$\overline{X}$的**抽样分布**是什么分布。在博客 [4] 中提到过：若$X_1,\cdots,X_n$独立，且均服从指数分布，则$X=2\lambda(X_1+\cdots+X_n)\sim\chi_{2n}^2$。因此，如果使用$K_{2n}$表示$\chi_{2n}^2$分布，则有：

$$
\begin{split}
\beta_\Phi(\lambda)&=P_\lambda(\overline{X}<C)\\
&=P_\lambda(X_1+\cdots+X_n<nC)\\
&=P_\lambda(2\lambda(X_1+\cdots+X_n)<2\lambda nC)\\
&=K_{2n}(2\lambda nC)
\end{split}\label{eq2}
$$

$K_{2n}(2\lambda nC)$与$\lambda$有关，并且随着$\lambda$的上升而增加。$\lambda$越大，则$K_{2n}(2\lambda nC)$越大，表示事件$\{\overline{X}<C\}$发生的概率越大，我们就越应该否定。因此，检验法$\eqref{eq1}$就是一个良好的检验法。式$\eqref{eq2}$就称为检验$\eqref{eq1}$的功效函数。

下面给出功效函数一般的定义：

> 定义：设总体分布包含若干个未知参数$\theta_1,\cdots,\theta_k$。$H_0$是关于这些参数的原假设，设有了样本$X_1,\cdots,X_n$，而$\Phi$是基于这些样本而对$H_0$所做的一个检验。则称检验$\Phi$的功效函数为：
> 
> $$
> \beta_\Phi(\theta_1,\cdots,\theta_k)=P_{\theta_1,\cdots,\theta_k}(在检验\Phi之下，H_0被否定)
> $$
> 
> 功效函数是关于未知参数$\theta_1,\cdots,\theta_k$的函数。

容易明白：

1. 当某一特定参数值$(\theta_1^0,\cdots,\theta_k^0)$使$H_0$成立时，我们希望$\beta_\Phi(\theta_1^0,\cdots,\theta_k^0)$尽可能小(见下文式$\eqref{eq3}$)，即当$H_0$成立时，我们不希望否定它；反之，若$(\theta_1^0,\cdots,\theta_k^0)$属于对立假设，我们希望$\beta_\Phi(\theta_1^0,\cdots,\theta_k^0)$尽可能大(见下文式$\eqref{eq4}$，即当$H_0$不成立时，我们希望否定它)；
2. 同一个原假设的两个检验$\Phi_1$，$\Phi_2$哪一个更好地符合了上述的要求，哪一个就更好。（这一点很重要，从这一点我们就可以比较检验法的优劣）；

由于当$(\theta_1,\cdots,\theta_k)$属于对立假设时，我们希望功效函数值$\beta_\Phi(\theta_1,\cdots,\theta_k)$尽可能大，故在$(\theta_1,\cdots,\theta_k)$属于对立假设时，称$\beta_\Phi(\theta_1,\cdots,\theta_k)$为检验$\Phi$在$(\theta_1,\cdots,\theta_k)$处的“功效”，这个成熟只用于对立假设处，因为当$(\theta_1,\cdots,\theta_k)$属于原假设时，$\beta_\Phi(\theta_1,\cdots,\theta_k)$以小为好，这时如果再称它为“功效”，从字面上讲就有些不太合适了。

## Type I and Type II errors, Significance level

再检验一个假设$H_0$时，有可能犯以下两类错误之一：

1. $H_0$正确，但是被否定了；
2. $H_0$不正确，但被接受了；

可能犯哪一种错误，要视总体分布中有关的参数值而定。比如在例1中，若参数$\lambda=0.0001$(即当寿命为$10000$小时)，我们只可能犯第一种错误(Type I error)；如果参数$\lambda=0.001$(即当寿命为$1000$小时)，则只可能犯第二类错误(Type II error)。

若以$\theta_1,\cdots,\theta_k$记总体分布的参数，$\beta_\Phi(\theta_1,\cdots,\theta_k)$为检验$\Phi$的功效函数，则犯第一、二类错误的概率$\alpha_{1\Phi}(\theta_1,\cdots,\theta_k)$和$\alpha_{2\Phi}(\theta_1,\cdots,\theta_k)$分别为：

$$
\alpha_{1\Phi}(\theta_1,\cdots,\theta_k)=\left\{
\begin{split}
&\beta_\Phi(\theta_1,\cdots,\theta_k),\ &\mathrm{if}\ (\theta_1,\cdots,\theta_k)\in H_0\\
&0,\ &\mathrm{if}\ (\theta_1,\cdots,\theta_k)\in H_1\\
\end{split}
\right.\label{eq3}
$$

$$
\alpha_{2\Phi}(\theta_1,\cdots,\theta_k)=\left\{
\begin{split}
&0,\ &\mathrm{if}\ (\theta_1,\cdots,\theta_k)\in H_0\\
&1-\beta_\Phi(\theta_1,\cdots,\theta_k),\ &\mathrm{if}\ (\theta_1,\cdots,\theta_k)\in H_1\\
\end{split}
\right.\label{eq4}
$$

这里，$H_1$是对立假设。

在检验一个假设$H_0$(对立假设$H_1$)时，我们希望犯两种错误的概率就尽可能小(上文提到过这一点)，但是这两方面的要求是矛盾的。正如在区间估计中，想要增大置信系数，就会使区间长度变大而降低精度(见：博客 [3])，反之亦然。在区间估计的理论中，是用“保一望二”的原则解决了这个问题，即尽可能使置信系数达到指定值，在这个限制之下使区间精度尽可能大。同样地，在建设检验中也这么做：先保证第一类错误的概率不超过某一个指定值$\alpha$($\alpha$通常较小，最常用的是$\alpha=0.05$和0.01，有时也会用到0.001,0.10，以至0.20等值)，在这个限制下，使第二类错误的概率尽可能小。

> 定义：设$\Phi$是原假设$H_0$的一个检验，$\beta_\Phi(\theta_1,\cdots,\theta_k)$为其功效函数，$\alpha$为常数($0\le\alpha\le1$)，如果：
> 
> $$
> \beta_\Phi(\theta_1,\cdots,\theta_k)\le\alpha\ (对任何(\theta_1,\cdots,\theta_k)\in H_0)\label{eq5}
> $$
> 
> 则称$\Phi$为$H_0$的一个水平为$\alpha$的检验，或者说检验$\Phi$的水平为$\alpha$。

显然，和区间估计类似，若$\alpha$为$\Phi$的水平，而$\alpha_1>\alpha$，则$\alpha_1$也是检验$\Phi$的水平。这样，一个检验的水平并不唯一。为了克服这个不方便的地方，通常只要可能，就取最小可能的水平作为检验的水平。不少著作中就直接把水平定位为满足$\eqref{eq5}$式的最小的。这样做，唯一性的问题就解决了，固然是好，但是有时我们只知道式$\eqref{eq5}$，而无法证明$\alpha$已经达到最小，这时在这种定义下，就不能称$\alpha$为$\Phi$的水平，而不知如何称呼。因此我们还是使用此处的定义方式，但有这样一个默契：只要可能，尽可能找最小的$\alpha$。

上述“**固定(或限制)第一类错误概率的原则**”，是目前假设检验中一种流行的做法。也许会问：为什么不固定第二类错误率而在这个前提下尽量减小第一类错误的概率？这么做并非不可以，但是大家通常约定在一个原则下讨论问题，并且从实用的观点看，在多数假设检验问题中，第一类错误被认为更有害，更需要控制。但在某些情况下，确实第二类错误的危害更大，有时有必要控制这个概率。换句话说，“控制第一类错误概率”的原则也并非是绝对的，可视情况的需要而变通。

## Uniformly most powerful test(UMP test)

> 定义：设设$\Phi$是原假设$H_0$的一个水平为$\alpha$的检验，$\beta_\Phi(\theta_1,\cdots,\theta_k)$为其功效函数。若对**任何**其他一个水平为$\alpha$的检验$g$，必有：
> 
> $$
>\beta_\Phi(\theta_1,\cdots,\theta_k)\ge\beta_g(\theta_1,\cdots,\theta_k)\quad (对任何(\theta_1,\cdots,\theta_k)\in H_1)
> $$
> 
> 这里$H_1$为对立假设，则称$\Phi$是假设问题$H_0:H_1$的一个水平为$\alpha$的一致最优检验(Uniformly most powerful test, UMP test)。

简单地说，水平$\alpha$的一致最优检验，就是在一切水平为$\alpha$的检验中，其功效函数在对立假设$H_1$上处处达到最大者；或者说，是在一切其第一类错误概率不超过$\alpha$的检验中，第二类错误处处达到最小者。这里难就难在“处处”两个字，当然，“一致最优”中的“一致”，就是指这个“处处”而言的。

拿两个检验$\Phi_1$和$\Phi_2$的比较来谈。设原假设$H_0$为$\theta\le1$，对立假设$H_1$为$\theta>1$。设$\Phi_1$和$\Phi_2$都是水平$\alpha$的检验(下图中的两条函数曲线刚好在$\theta_1$处相交)，其功效函数分别如下图的实线和虚线所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/2dcb6e7ce651fdd8447101e79540957.jpg?raw=true" alt="2dcb6e7ce651fdd8447101e79540957" style="zoom: 25%;" />

是不是最优一致假设，主要看在对立假设处。在这张图中的对立假设$\theta_1$处，$\beta_{\Phi_1}$大于$\beta_{\Phi_2}$；而在$\theta_2$处，$\beta_{\Phi_2}$大于$\beta_{\Phi_1}$。因此，在这两个检验$\Phi_1$和$\Phi_2$中，没有一个在对立假设处处优于另外一个。

**由于水平$\alpha$的检验非常多，其中能有一个最优一致者就不是常见的情况，而是较少的例外**。更确切地说，只在总体分布只依赖于一个参数$\theta$，而原假设$H_0$是$\theta\le\theta_0$或$H_0$是$\theta\ge\theta_0$地情形，且对总体分布地形式有一定的限制时，一致最优检验才存在。其他情况则是稀有的例外。由于一致最优检验的条件太高，在假设检验理论中也引入了另一些优良准则，这里不做介绍。

本文所讲的假设检验理论的基本概念，特别是：

1. 限制第一类错误概率的原则；
2. 一致最优检验；

是J·奈曼和英国统计学家E·S·皮尔逊(K·皮尔逊的儿子)合作，自1828年起开始引进的。基于这些概念所发展的假设检验理论，一般称为奈曼——皮尔逊理论(NP理论)。

<br>

**Reference**

[1] [What is Mathematical Statistics? - What a starry night~](https://helloworld-1017.github.io/mathematics/what-is-mathematical-statistics/).

[2] [Exponential Distribution and Weibull Distribution - What a starry night~](https://helloworld-1017.github.io/mathematics/matlab/Exponential-Distribution-and-Weibull-Distribution/).

[3] [Interval Estimation – Pivot Method - What a starry night~](https://helloworld-1017.github.io/mathematics/Interval-Estimation-pivot-method/#example-2-normal-distribution-interval-estimation-of--mu_1-mu_2).

[4] [Chi-square Distribution, Student’s t Distribution, and F Distribution - What a starry night~](https://helloworld-1017.github.io/mathematics/matlab/Chi-square-and-t-and-F-Distribution/#properties-of-chi-square-distribution).

[5] 概率论与数理统计. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.2(2019.8重印).
