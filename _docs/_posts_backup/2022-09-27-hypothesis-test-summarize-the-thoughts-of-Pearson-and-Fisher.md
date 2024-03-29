---
layout: single
title: 【Hypothesis Test 1】Summarize the Thoughts of Pearson and Fisher
date: 2022-09-27 16:47:51 +0800
categories: 
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
 - Experiment
---

# Introduction

假设有一大批产品要由工厂卖给商店，但是这批产品的废品率$p$未知，工厂与商店协商了一个数字$p'$，例如$p^{\prime}=0.02$，双方约定$p\le p'$时，商店就接受这批产品，否则就拒收。由于$p$未知，并且假定不可能进行全面的检验以确定$p$，因此**无法确切地知道**是否该接受这批货。于是双方同意采用抽样检验的方法：从这批产品中随机抽取出$n$个产品，以$X$记其中废品的个数，根据$X$值，用某种双方都同意的规则，去决定商店是否接受这批产品。

假设$n$与整批产品的个数相比很小，于是可足够准确地假定$X$服从二项分布$B(n,p)$。这样，就可以把上述的实际问题归结为一个理论问题：样本$X\sim B(n,p)$，要根据$X$的观察值，对命题$H$：$p\le p'$做出“是”或“否”的判断。在统计术语中，把这种需要根据样本去推断其正确与否的命题称为**统计假设**（简称**假设**）。通过样本对一个假设做出“是”或“否”的判断的*程序*，称为**检验**这个假设，具体的判断规则称为该假设的一个**检验**。检验的结果若是肯定该命题，则称**接受**这个假设，其反面则是**否定**或**拒绝**这个假设。

✏注意：此处的“接受”和“否定”的用语，他反应的是当事者**在所面对的样本证据下**，对该命题所采取的一种**态度和倾向性**，以至某种必须或自愿采取的行动，而不是在逻辑上“证明”了该命题的正确或不正确。这自然是因为样本具有随机性。
{: .notice--warning}

实际问题化为统计假设检验问题去处理，一般都与上述例子类似，可以概括为以下几条：

（1）明确所要处理的问题，问题的回答只能是“是”或者“否”。（在本例中，为“是否接受这批产品？”）；

（2）设计适当的观察或试验以**取得**样本$X$，$X$的概率分布（通常是通过这个分布的参数或数字特征，如本例中的$p$）必须与问题有一种确定的联系。确切地说，知道了$X$的分布（或其参数、数字特征），就能明确无误地回答所提问题。

（3）把问题的一种回答，例如“是”，作为一个命题。这个命题转化到样本$X$的分布上，就能得到后者（或其参数、数字特征）的一个等价命题，称为一个假设；

（4）根据样本$X$的具体值，按照一定的规则，做出接受或否定假设的决定，回到原问题，就等于回答为“是”或“否”。

假设检验是一种有重要应用价值的**统计推断(Statistical Inference)**形式。从理论上说，它是数理统计学的一个重要分支。假设检验方法的理论和系统发展，始于20世纪初，在历史上经历了以下一些重大事件：

- 1900年，K. Pearson提出拟合优度$\chi^2$检验；
- 1920s，R.A.Fisher提出显著性检验；
- 1928年起，J.Neyman和E.S.Pearson的理论；
- 1950年，A.Wald的统计判决理论
- Bayes方法

Neyman-Pearson关于假设检验的理论（NP理论），是建立在**概率的频率解释**基础上、关于假设检验的一套形式比较完美的数学理论，通过适当的表述方式，可以把Pearson和Fisher的工作包括到这个理论中去讨论。这样做在数学上较易处理，但是作为一个初次接触假设检验的初学者来说，很有必要了解一下Pearson和Fisher这些大师的思想，因为他们都是**从很实际的角度出发来考虑问题的**。对他们的工作的学习，对假设检验中一些基本概念的理解很有帮助。从历史的角度说，NP理论不能算是另起炉灶，而是对他们的工作的继承和发展。

<br>

# The Thoughts of Pearson, Goodness of Fit Test

1938年，K. Pearson的儿子，本身也是注明统计学家的E. S. Pearson，曾在一本关于他父亲的生平和工作的著作中，提到K. Pearson对统计的任务的看法是“To predict from past what will happen in the future”，以及在19世纪和20世纪之交，统计的当务之急是“What needed was a method for translating observed data into a predictive model”。Pearson所谓的“past”，就是指已有的观察数据，“future”则是指未来观察的可能的结果。想要做到由过去预测未来，必须用一个统计模型，确切地说，就是一条分布（密度）曲线，去拟合已有的数据，然后用拟合的分布去计算在未来的观察中出现种种值的可能性的大小。

这种思想就像用样本拟合了一个GMM后，GMM就成为了一个生成模型。
{: .notice--primary}

为此，Pearson提出了后来以他的名字命名的曲线系，希望在这个系统中，找出一条曲线，与已有的观测数据去进行拟合。在此需要处理以下两个问题：

- 如何从曲线系中确定一条曲线？
- 如何估量拟合的程度？

为了解决第一个问题，就引出了他的矩估计法。关于第二个问题，Pearson引出了一个统计量——$\chi^2$统计量$k=k(X_1,\cdots,X_n;F)$，以反映数据$X_1,\cdots,X_n$及所拟合的分布曲线$F$之间的偏离。$k$越小，拟合越好，如果对一组具体观察数据算出$k$的值为$k_0$，则根据Pearson在1900年证明的一个极限定理，可以近似算出概率$P(k\ge k_0)$。这个数可称为**拟合优度**。因为这个数越大，则产生像$k_0$这么大或更大的偏离的机会越大，因而实际得到$k_0$这么大的偏离的机会越多，进而得到$k_0$这么大偏离这件事并不稀奇。

到此为止，还没有假设检验的含义，只不过是定义了一个反映拟合程度优劣的指标——拟合优度。如果必须做出“是否录用曲线F”的决定，则必须定下一个**阈值**$\alpha$（如$\alpha=0.01,0.05,0.1$等），规定当拟合优度小于$\alpha$时，就不录用$F$，否则就录用$F$。

至此，就可以把问题提成假设检验的形式：

- 假设$H$：$X_1,\cdots,X_n$是从具有分布$F$的总体中抽出的样本。

- 检验的方法是：指定阈值$\alpha$，算出拟合优度$p$，当$p<\alpha$时否定$H$，当$p\ge\alpha$时接受$H$。

一般地，如果我们有一个理论、假说等，需要通过实践去检验，则只要能设计一种观察或试验，使其结果$X$当理论或假说成立时有确定的分布$F$，则转化为上述的假设检验问题，其中$X_1,\cdots,X_n$是$X$的独立观察值。检验方法可以用上述的Pearson $\chi^2$检验法，**也可用种种不同的方法定义$X_1,\cdots,X_n$与分布$F$之间的偏离**，从而引出种种不同的检验法。这些都可以称为**拟合优度检验**。由 K.Pearson开创的这个方向上的工作，是假设检验的一个重要组成部分。

<br>

# The Thoughts of Fisher, Significance Test

1919年，Fisher进入Rothamsted农业试验站，那里有K. Pearson领导的一个统计学家小组，Fisher在此从事统计学和遗传学方面的研究工作。他通过田间试验研究**试验设计**，与此结合，对由试验数据做出归纳式推断的基本原理做了探讨，他的成果后来大都总结在他的著作《The Design of Experiments》中，此书前三章着重讨论了一些基本观点，其中包括他提出的**显著性检验**，下面就是一个Fisher仔细讨论过的例子。

女士品茶试验：一种饮料牛奶与茶按一定比例混合而成，可以先倒茶后加牛奶（TM），或反过来（MT）。某女士声称，她可以鉴别饮料是TM还是MT。现设计如下的试验，来检验她的说法是否可信，准备8杯饮料，TM和MT各半，把它们随机地排成一列，让该女士依次品尝，并告诉她TM和MT各有4杯，然后请她指出哪4杯是TM。**假设她全说对了**。

Fisher的推理过程如下，他引进一个假设$H$：该女士并无鉴别力。当$H$正确时，不论该女士如何做，她事实上只能从所提供的8杯中随机地挑选4杯作为TM，这个概率是$1/C_8^4=1/70$。因此，若该女士果真全部挑对，则我们必须承认，下述两种情况必发生其一：

（1）$H$不成立，即该女士的确有一定的鉴别力；

（2）发生了一件其概率只有$1/70$的事件；

显然，第二种情况比较稀奇，因而我们有相当的理由承认第一种可能性。或者说，“该女士全挑对”这个结果，是一个不利于假设$H$的**显著的证据**。据此，我们否定$H$。这样一种推理过程就是**显著性检验**。

如果该女士该女士只说对了3杯，则表面上看，4杯说对3杯，成绩不错。但是我们需要计算一下，纯粹“出于碰巧而得到这个以至更好的成绩”，其机会有多大。在$H$成立时，挑中的杯数$\ge 3$的概率为$1/C_8^4+(C_4^3\times C_4^1)/C_8^4=17/70\approx0.243$。发生一个概率为0.243的事件并不稀奇。因此，试验结果没有提供不利于$H$的显著证据。

自然，人们可以说，$1/70$的概率虽然不大，但是这个结果在一次试验中发生了并非不可能，这个说法无法驳倒。**人们对于这种问题的态度，与事情的重要性及可能的后果有关**。要得到一个判断的决定，就必须指定一个阈值$\alpha$（如$\alpha=0.01,0.05,0.1$等），只有在算出的概率（即上文的$1/70$，0.243）小于$\alpha$时，才认为**结果是显著的**，即提供了不利于$H$的显著证据，并导致否定$H$。如在此例中，若取$\alpha=0.01$，即使4杯全队，也不认为结果显著；而若取$\alpha=0.05$，则认为是显著的。这里并无矛盾，因为$\alpha$值是约定的，$\alpha$称为检验所用的**显著性水平**，$\alpha$越低，获得显著结果越难，所导致的否定$H$的结论越可信。

根据这个例子，可以把Fisher显著性检验的思想归纳为以下几点：

（1）有一个明确的命题（假设）$H$；

（2）设计一定的试验，观察某变量$X$，$X$要有这样的性质：当$H$成立时，$X$有已知的分布。如在本例中，若以$X$记该女士猜对的杯数，则$X$有超几何分布：

$$
P(X=i)=\dfrac{C_4^iC_4^{4-i}}{C_8^4},\ (i=0,1,\cdots,4)\notag
$$

（3）根据$H$和$X$的具体内容，对$X$的值排一个次序，使越靠前的值，越对$H$不利。在本例中，这个排法是4,3,2,1,0。

（4）以$x$记$X$的观察值，按（2）中求出的分布，**把$x$和比$x$更靠前的值的概率之和求出来**，暂记为$p_x$，$p_x$越小，试验结果$x$越不利于$H$。

（5）算出$p_x$后，统计学家的工作也就完成了。他可以把$p_x$（连同其得出过程）报告给主事人，让后者去估量它的含义。如果必须提出明确结论，则必须事先给出（由主事者自定或有关主事者协商）显著性水平$\alpha$，当$p_x<\alpha$时否定$H$，当$p_x>\alpha$时接受$H$。

<br>

“显著性检验”这个名词还可以从更实际的意义上去理解。在工农业生产中，假设检验问题常在这种情况下出现：有两个处理（如两种工艺流程、两个种子品种、两种施肥方法等）$A$和$B$。$A$是原有的，已用了相当长的一个时期；$B$是新的，设想是一种改进。我们要通过试验来判断$B$是否优于$A$，于是引进假设$H$：$A$与$B$效果一样。

我们心目中当然是希望否定$H$，但只有实验结果表明$B$的**优势是显著的**时，才有根据这样做。而“显著的”必须按照前述的观点去解释。下面的例子（也出自Fisher）清楚地说明了这一点。

为比较$A$与$B$两种施肥方法何者为优，选择15块一般大小的地，把每块地分成形状、大小一样的两块，随机地将其中一小块分配给$A$，另一小块分配给$B$。各小块产量如下：

$$
\begin{split}
\mathrm{A}&\quad188&\quad96&\quad168&\quad176&\quad153&\quad172&\quad177&\quad163&\quad146&\quad173&\quad186&\quad168&\quad177&\quad184&\quad96\\
\mathrm{B}&\quad139&\quad163&\quad160&\quad160&\quad147&\quad149&\quad149&\quad122&\quad132&\quad144&\quad130&\quad144&\quad102&\quad124&\quad144\\
\mathrm{A-B}&\quad49&\quad-67&\quad8&\quad16&\quad6&\quad23&\quad28&\quad41&\quad14&\quad29&\quad56&\quad24&\quad75&\quad60&\quad-48\\
\end{split}\notag
$$

算出$\sum(A-B)=314$。现在要在假设{$H$：$A$与$B$效果一样}之下，把可能的试验结果按对$H$不利的程度排序。

在$H$成立时，每块地内$A-B$值不为0并非由于$A$与$B$效果不同，而是由于两小块地的差别。但随机化的结果，每一块地有同等可能$1/2$的几率分配给$A$或$B$。因此，如在第一块地，以随机化结果不同，$A-B$可以是49，也可以使$-49$，要看较好地那小块地分配给$A$还是$B$。这样一来，这个试验的全部可能$\sum(A-B)$值有$2^{15}$个：

$$
\pm(49)\pm(-67)\pm(8)\cdots\pm(60)\pm(-48)\notag
$$

实际得出的值314只是$2^{15}$种的一种。当$A$与$B$的效果有较大差别时（越对假设$H$不利），$\vert\sum(A-B)\vert$应取大值。于是，按其绝对值大小，把$2^{15}$个排成一列：

$$
x_1,x_2,\cdots,x_{2^{15}}\notag
$$

这$2^{15}$个值，在$H$成立的前提下，为等可能，即每个值出现的概率都是$2^{-15}$。找出$m$，使得$x_m=314$，则314及比值对$H$更不利的值，在$H$成立时出现的机会只有$p_{314}=m/2^{15}$。本例可具体算出$p<0.0001$。因此，即使在$\alpha=0.0001$的显著性水平下，也有理由否定$H$。这样，试验结果提供了很显著的证据，不利于$H$。又由于$314>0$，因此结论是：有很显著的证据表明$A$优于$B$。

<br>

Fisher的理论中缺少一件很重要的东西：同一个假设可以用很多不同的方法检验，如何比较其优劣？考虑到这个问题，就需要建立合理的比较准则，并在这种准则下找最优者。Fisher没有考虑这个问题，因此他虽然在开创假设检验这个方向上起了重大作用，却未能建立一套形式完美的数学理论。比对于女士鉴别饮料的例子，可以把试验做一点修改：不告诉该女士TM和MT各有四杯，而让她一一指明8杯中的每一杯是TM或MT，按她说对的杯数去下判断。在直观上，看前来修改后的设计比原来的好。但在怎样的意义下好？如何确切地论证？这并不是一目了然的。J.Neyman和E.S.Pearson的理论补足了这一点。

<br>

**参考**

[1] 数理统计学教程. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.7(2021.10重印).





























