---
layout: single
title: Entropy, Cross entropy, KL Divergence and Their Relation
categories: 
 - Mathematics
 - Machine Learning
 - Signals and Systems
 - Uncertainty
 - MATLAB
tags:
 - MATLAB Graphics
 - Operations Research
date: 2023-04-09 14:25:33 +0800
last_modified_at0: 2023-04-09 14:25:33 +0800
last_modified_at1: 2024-04-23 12:50:52 +0800
last_modified_at: 2024-04-23 12:50:52 +0800
---

# Entropy

## Definition

熵（entropy）是度量一个系统不确定性（uncertainty）的量，定义为：

$$
S(v)=-\sum_{i}p(v_i)\log p(v_i)\label{eq1}
$$

其中，$p(v_i)$表示系统处于状态$v_i$的概率。从**信息论（information theory）**的角度看，$S(v)$是用于消除不确定性所需要的信息量（...is the amount of information is needed for removing the uncertainty）。

## Two-state system

假设有两个不确定系统$S_1$和$S_2$，这两个系统都有两种可能的状态：

$$
v_1,v_2\notag
$$

这两种状态相互互斥。

系统$S_1$处于这两种状态的的概率分别是：

$$
\begin{split}
p(v_1)&=0.6\\
p(v_2)&=0.4
\end{split}\notag
$$

则对于系统$S_1$，用于消除不确定性所需要的信息量，即熵为：

$$
S_1(v)=-(0.6\log(0.6)+0.4\log(0.4))=0.6730\notag
$$

而系统$S_2$处于这两种状态的概率分别为：

$$
\begin{split}
p(v_1)&=0.9\\
p(v_2)&=0.1
\end{split}\notag
$$

则对于系统$S_2$，其熵为：

$$
S_2(v)=-(0.9\log(0.9)+0.1\log(0.1))=0.3251\notag
$$

可以看到，系统$S_1$的熵大于系统$S_2$的熵，这表明消除系统$S_1$的不确定性需要更多的信息量。这也非常好理解，因为系统$S_2$的不确定性更小，因为它处于状态$v_1$的可能性非常大，概率为0.9.

对于这样一个只具有两个状态的系统，实际上仅仅需要得知$p(v_1)$的值，就可以计算出整个系统的熵（因为$p(v_2)=1-p(v_1)$），因此我们可以很简单地绘制出$p(v_1)$取不同值时熵的大小：

![image-20230407154104139](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230407154104139.png?raw=true)

注：绘图脚本见附录A。
{: .notice--primary}

熵的最大值，即0.6931，在$p(v_1)=0.5,p(v_2)=0.5$时取到，此时的系统不确定性最大，需要最多的信息才能消除系统的不确定性。

实际上，由于关系$p(v_2)=1-p(v_1)$的存在，我们可以从数学上推导出上面的图像。首先，为方便起见，我们记$p(v_1)=x$，则有$p(v_2)=1-x$，则系统的熵为：

$$
\begin{split}
S(x)=&-(x\log(x)+(1-x)\log(1-x)),\ x\in[0,1]
\end{split}\label{eq2states}
$$

进一步有：

$$
S'(x)=-\log(\dfrac{x}{1-x})\notag
$$

$$
S'(\dfrac12)=0\notag
$$

并且：

$$
\begin{split}
&if\ x\in(0,1/2),\ s'(x)>0\\
&if\ x\in(1/2,1),\ s'(x)<0\\
\end{split}\notag
$$

因此，$S(x)$就是在$x=1/2$处取得极大值，且在区间$x\in(0,1/2)$递增，而在区间$x\in(1/2,1)$递减。

而当$x\rightarrow0$和$x\rightarrow1$时，分别有：

$$
\begin{split}
&\lim_{x\rightarrow0}S(x)=-\lim_{x\rightarrow0}x\log x=0\\
&\lim_{x\rightarrow1}S(x)=-\lim_{x\rightarrow1}(1-x)\log(1-x)=0
\end{split}\notag
$$

最终，对于这个具有两个状态的系统，可以得到两个结论：

1. 熵总是非负的；
2. 熵的最大值在$p(v_1)=0.5,p(v_2)=0.5$时取到，最大值为0.6931；

## Three-state system

同样地，对于具有三个状态的系统，可以绘制出类似的图像：

![image-20230408171722004](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230408171722004.png?raw=true)

注：绘图脚本见附录B。
{: .notice--primary}

类似地，如果记$p(v_1)=x$，$p(v_2)=y$，则$p(v_3)=1-x-y$，则系统的熵可以表示为：

$$
S(x,y)=-(x\log x+y\log y+(1-x-y)\log(1-x-y))\label{xyEntropy}
$$

这个二元函数的图像为：

![image-20230408174829067](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230408174829067.png?raw=true)

注：绘图脚本见附录C。
{: .notice--primary}

对于这样一个二元函数，我们下面证明它同样具有以下两个性质：

1. 熵存在最值点；
2. 熵总是非负的；

首先寻找函数$S(x,y)$的驻点；对$S(x,y)$求偏导数有：

$$
\begin{split}
S'_x=-(\log x-\log(1-x-y))\\
S'_y=-(\log y-\log(1-x-y))\\
\end{split}\notag
$$

令$S_x(x,y)$和$S_y(x,y)$等于0，可以求得函数有一个驻点：$(1/3,1/3)$。

之后求取二阶偏导数，有：

$$
\begin{split}
S''_{xx}&=-(\dfrac1x+\dfrac1{1-x-y})\\
S''_{xy}&=-(\dfrac1{1-x-y})\\
S''_{yy}&=-(\dfrac1y+\dfrac1{1-x-y})\\
\end{split}\notag
$$

在驻点$(1/3,1/3)$处，有：

$$
\begin{split}
S''_{xx}(1/3,1/3)&=-6=A\\
S''_{xy}(1/3,1/3)&=-3=B\\
S''_{yy}(1/3,1/3)&=-3=C\\
\end{split}\notag
$$

于是可以得到：

$$
AC-B^2=9>0,\ A<0\notag
$$

因此，熵在$(1/3,1/3)$取得极大值，极大值为$1.0986$。并且，根据式$\eqref{xyEntropy}$，我们可以得到该二元函数的三条边界线：

$$
\left\{
\begin{split}
&x=0\\
&y=0\\
&1-x-y=0
\end{split}
\right.\notag
$$

我们可以通过极限的方式分析接近这三条边界时的熵。

(a) 当$x\rightarrow0$时，有：

$$
\lim_{x\rightarrow0}S(x,y)=-(y\log y+(1-y)\log(1-y))\label{eqa}
$$

(b) 当$y\rightarrow0$时，有：

$$
\lim_{y\rightarrow0}S(x,y)=-(x\log x+(1-x)\log(1-x))\label{eqb}
$$

(c) 当$(1-x-y)\rightarrow0$时，有：

$$
\lim_{(1-x-y)\rightarrow0}S(x,y)=-(x\log x+(1-x)\log(1-x))\label{eqc}
$$

可以看到，式$\eqref{eqa}$，$\eqref{eqb}$，和$\eqref{eqc}$的函数和两状态系统熵的计算式$\eqref{eq2states}$是类似的，因此在这三条边界上，最大值为0.6931，最小值为0。从垂直于三个边界的视角观看这个二维函数的图像，同样可以看出这一点：

![image-20230408180456045](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230408180456045.png?raw=true)

注：绘图脚本见附录E。
{: .notice--primary}

综上所述，具有三个状态的系统的熵的最大值为1.0986，且熵值总是非负的。

## Multi-state system

更一般的情况，对于具有$n$个状态的系统，熵的计算公式就是最开始的定义式$\eqref{eq1}$：

$$
S(v)=-\sum_{i}(-p(v_i)\log(v_i))\notag
$$

我们同样可以证明熵具有最大值，且在$p(v_1)=p(v_2)=\cdots=p(v_n)=\dfrac1n$时取到，最大值为$\log n$，只需要使用拉格朗日乘子法[^1]求解这样一个极值问题：

$$
\begin{split}
&\min_{p(v_i)}\ \sum_{i}(-p(v_i)\log(v_i))\\
&s.t.\ \sum_ip(v_i)=1
\end{split}\notag
$$

此处从略。而关于非负性的证明也是非常简单的[^4]：

![image-20230408183203054](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230408183203054.png?raw=true)

<br>

# Cross Entropy

分布$A$和分布$B$之间的交叉熵定义为：

$$
H(A,B)=-\sum_i p_A(v_i)\log p_B(v_i)\label{eq2}
$$

在机器学习中，交叉熵经常被作为分类问题的损失函数。

## Binary classification 

对于二分类问题（0-1分类问题），**单个样本**的交叉熵损失函数为：

$$
\begin{split}
\mathrm{Loss}&=-\sum_{i=0}^1p(v_i)\log \hat{p}(v_i)\\
\end{split}\notag
$$

其中，$p(v_i)$表示该样本属于分类$v_i$的概率，而$\hat{p}(v_i)$表示模型预测该样本属于分类$v_i$的概率。由于是二分类问题，我们可以将上式进一步展开为：

$$
\begin{split}
\mathrm{Loss}&=-\Big(p(v_0)\log \hat{p}(v_0)+p(v_1)\log \hat{p}(v_1)\Big)\\
&=-\Big(p(v_0)\log \hat{p}(v_0)+(1-p(v_0))\log (1-\hat{p}(v_0))\Big)
\end{split}\label{eq4}
$$

其中，$p(v_0)$表示样本为类别0的概率，$\hat{p}(v_0)$​表示模型预测样本为0的概率。

> 二分类交叉熵的另一种表达形式为：
>
> $$
> \mathrm{Loss}=\left\{
> \begin{split}
> &-\log\hat{p}(v_0),\quad&p(v_0)=1\\
> &-\log (1-\hat{p}(v_0)),\quad&\text{otherwise}\\
> \end{split}
> \right.
> $$
> 
> 或者：
> 
> $$
> \mathrm{Loss}=\left\{
> \begin{split}
> &-\log\hat{p}(v_1),\quad&p(v_1)=1\\
> &-\log (1-\hat{p}(v_1)),\quad&\text{otherwise}\\
> \end{split}
> \right.
> $$

如果是$N$个样本，则相应的交叉熵损失函数为：

$$
\begin{split}
\mathrm{Loss}&=-\dfrac1N\sum_{j=0}^N\Big(p_j(v_0)\log \hat{p}(v_0)+(1-p_j(v_0))\log (1-\hat{p}_j(v_0))\Big)
\end{split}\notag
$$

假如我们现在4个样本，样本标签为：

$$
\mathrm{Real}: 0,1,1,0\notag
$$

并且有模型$M$，该模型预测样本为类别0的概率以及最终的预测结果为：

$$
\begin{split}
p(v_0):&0.1,\quad0.2,\quad0.3,\quad0.9\\
\mathrm{Prediction}:&1,\quad1,\quad1,\quad0\\
\end{split}\notag
$$

模型$M$交叉熵损失值为：

$$
\mathrm{Loss}_M=-\dfrac14(\log0.1+\log0.8+\log0.7+\log0.9)=0.7469\notag
$$

以及模型$N$：

$$
\begin{split}
p(v_0):&0.4,\quad0.2,\quad0.3,\quad0.9\\
\mathrm{Prediction}:&1,\quad1,\quad1,\quad0\\
\end{split}\notag
$$

$$
\mathrm{Loss}_N=-\dfrac14(\log0.4+\log0.8+\log0.7+\log0.9)=0.4004\notag
$$

以及模型$G$：

$$
\begin{split}
p(v_0):&0.1,\quad0.8,\quad0.9,\quad0.1\\
\mathrm{Prediction}:&1,\quad0,\quad0,\quad1\\
\end{split}\notag
$$

$$
\mathrm{Loss}_M=-\dfrac14(\log0.1+\log0.2+\log0.1+\log0.1)=2.1293\notag
$$

```matlab
clc,clear,close all

Loss_M = helperCalcualteLoss([0,1,1,0],[0.1,0.2,0.3,0.9]);
Loss_N = helperCalcualteLoss([0,1,1,0],[0.4,0.2,0.3,0.9]);
Loss_G = helperCalcualteLoss([0,1,1,0],[0.1,0.8,0.9,0.1]);

disp(Loss_M)
disp(Loss_N)
disp(Loss_G)

function Loss = helperCalcualteLoss(r,phat0)
pv0 = 1-r;
Loss = -mean(pv0.*log(phat0)+(1-pv0).*log(1-phat0));
end
```

```
0.7469
0.4004
2.1293
```

可以看到：

- 模型$M$和模型$N$预测对了三个样本的标签，并且预测标签都是相同的，唯一的差别对于第一个样本的预测概率。相比模型$M$，模型$N$更倾向于认为第一个样本为类别0，也更加接近真实的标签，因此模型$N$的交叉熵更低，更加优秀；
- 相比于模型$M$和模型$N$，模型$G$的效果更差，全部预测错误，因此具有最高的交叉熵；

综上，从上面这个二分类问题的小例子可以看出交叉熵能够作为二分类问题的损失函数，用于优化模型。

## Multi-class classification

类似地，多分类问题（$M$个分类）的交叉熵损失函数为：

$$
\begin{split}
\mathrm{Loss}&=-\dfrac1N\sum_{j=0}^N\sum_{i=0}^Mp_j(v_i)\log \hat{p}_j(v_i)\\
\end{split}\notag
$$

其中，$p_j(v_i)$是第$j$个样本属于分类$v_i$的概率，$\hat{p}_j(v_i)$是模型预测第$j$个样本属于类别$v_i$的概率。可以看到，二分类到多分类的交叉熵损失函数的推广是非常自然的，这里就不再赘述。

在实际使用代码进行计算时，需要注意一点。对于多分类问题，我们不太可能像$\eqref{eq4}$一样展开成类似$1-p(v_0)-\cdots$的形式，这反而会增加编程时的难度；实际上，对于二分类问题，将$p(v_1)\log \hat{p}(v_1)$展开成$(1-p(v_0))\log (1-\hat{p}(v_0))$同样也增加了编程时的难度。更方便的处理方式是直接将模型对于每一类的预测概率都计算出来，之后直接做矩阵运算。例如，对于上面二分类的问题可以这样处理：

```matlab
clc,clear,close all

Loss_M = helperCalcualteLoss([0,1,1,0],[0.1,0.2,0.3,0.9],1-[0.1,0.2,0.3,0.9]);
Loss_N = helperCalcualteLoss([0,1,1,0],[0.4,0.2,0.3,0.9],1-[0.4,0.2,0.3,0.9]);
Loss_G = helperCalcualteLoss([0,1,1,0],[0.1,0.8,0.9,0.1],1-[0.1,0.8,0.9,0.1]);

disp(Loss_M)
disp(Loss_N)
disp(Loss_G)

function Loss = helperCalcualteLoss(r,phat0,phat1)
pv1 = r;
pv0 = 1-r;
Loss = -mean(pv0.*log(phat0)+pv1.*log(phat1));
end
```

```
0.7469
0.4004
2.1293
```

<br>

对于多分类问题，还有一个小细节：对于神经网络而言，模型的输出层输出的值并不是“概率”，并不能直接拿来计算，因为输出层：

- 每个神经元输出的值可能是正数（甚至超过1）也可能是负数；
- 所有神经元输出的值相加不是1；

因此对于多分类问题，在神经网络输出层的后面通常会连接一个Softmax层，再进行计算交叉熵损失。Softmax层的作用是将输出层的输出值都压缩在$(0,1)$之间，而相对大小的关系不变，并且加和为1。另一方面，**由于将所有的输出值都压缩在$(0,1)$之间，就一定能够保证交叉熵损失始终是正数**（参考上文关于熵的非负性的证明）；对于二分类问题，输出层后所连接的Sigmoid函数也起着类似的作用。

<br>

# KL Divergence

用于度量一种概率分布$A$和参考概率分布$B$之间的差异程度的KL散度定义为[^3]：

$$
\begin{split}
D_{\mathrm{KL}}(A\vert\vert B)&=\sum_ip_A(v_i)\log\dfrac{p_A(v_i)}{p_B(v_i)}\\
&=\sum_i p_A(v_i)\log p_A(v_i)-p_A(v_i)\log p_B(v_i)
\end{split}\label{eq3}
$$

其中，等式右端的第一项是分布$A$的熵（的相反数），第二项可以看作是分布$B$关于分布$A$的期望值（the second term can be interpreted as the expectation of distribution B in terms of A），KL散度描述了分布$A$相对于分布$B$的差异性（describes how different B is from A from the perspective of A）。需要注意的是，分布$A$通常代表数据的分布，即measured distribution，而分布$B$代表理论分布（theoretical distribution）或者假设分布（hypothetical distribution）。这意味着，我们是从观测的数据出发来度量其和理论分布之间的差异（That means, you always start from what you observed.）。

<br>

# The relationship between entropy, cross entropy, and KL divergence

总结熵$\eqref{eq1}$，交叉熵$\eqref{eq2}$，KL散度$\eqref{eq3}$的定义：

$$
\begin{split}
S(A)&=-\sum_{i}p_A(v_i)\log p_A(v_i)\\
H(A,B)&=-\sum_i p_A(v_i)\log p_B(v_i)\\
D_{\mathrm{KL}}(A\vert\vert B)&=\sum_i p_A(v_i)\log p_A(v_i)-p_A(v_i)\log p_B(v_i)\\
\end{split}\notag
$$

我们可以得到关于分布$A$和分布$B$三者之间的关系，即：

$$
H(A,B)=D_{\mathrm{KL}}(A\vert\vert B)+S(A)
$$

**如果$S_A$是一个常数，那么最小化$H(A,B)$就等价于最小化$D_{\mathrm{KL}}(A\vert\vert B)$**。那么，怎么使得熵$S_A$是一个常数呢？

在机器学习的任务中，我们通常会有一份数据集（记作$P(\mathcal{D})$），表示我们需要所解决的问题，而学习的目标是使得估计的模型的分布（记作$P(model)$）尽可能地接近的真实分布$P(truth)$。我们可以用观测到的数据$P(\mathcal{D})$近似地表示所有数据地真实分布，即最终的学习目标为：

$$
P(model)\approx P(truth)\approx P(D)
$$

就需要最小化$D_{\mathrm{KL}}(P\mathcal{(D)}\vert\vert P(model))$。而在实际中，由于数据集$\mathcal{D}$是给定的，我们可以认为熵$S(D)$是一个词常数。因此，最小化$D_{\mathrm{KL}}(P\mathcal{(D)}\vert\vert P(model))$就等价于最小化$H(\mathcal{D}\vert\vert model)$。

在上文的分类任务中，我们实际上是想要使得模型预测的分布与数据集的分布的差异尽能得小，而衡量分布的差异需要使用KL散度，但是我们使用的却是交叉熵。而为什么**可以使用**交叉熵来衡量分布的差异？这部分的解释就给出了答案。

<br>

# Appendix

## Appendix A

```matlab
clc,clear,close all

p1 = 1e-3:0.001:1-1e-3;
p2 = 1-p1;
entropy = -(p1.*log(p1)+p2.*log(p2));
[maxEngropy,pos] = max(entropy);

figure('Units','pixels','Position',[439.66,521.66,1448.66,420])
tiledlayout(1,3,'TileSpacing','tight')
nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
view(3)
plot3(p1,p2,entropy, ...
    'LineWidth',1.5,'Color',[7,84,213]/255, ...
    'DisplayName','Entropy')
plot(p1,p2, ...
    'Color','g','LineWidth',1.5,'LineStyle','--', ...
    'DisplayName','$p(v_2)=1-p(v_1)$')
scatter3(p1(pos),p2(pos),maxEngropy, ...
    'filled','MarkerFaceColor',[249, 82, 107]/255,...
    'DisplayName','Maximum entropy')
legend('Interpreter','latex','Location','best')
xlabel('$p(v_1)$','Interpreter','latex')
ylabel('$p(v_2)$','Interpreter','latex')
zlabel('Entropy','Interpreter','latex')
title('Entropy as function of $p(v_1)$ and $p(v_2)$','Interpreter','latex')

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot(p1,entropy, ...
    'Color',[7,84,213]/255,'LineWidth',1.5,...
    'DisplayName','Entropy')
scatter(p1(pos),maxEngropy, ...
    'filled','MarkerFaceColor',[249, 82, 107]/255,...
    'DisplayName','Maximum entropy')
legend('Interpreter','latex','Location','southeast')
xlabel('$p(v_1)$','Interpreter','latex')
ylabel('Entropy','Interpreter','latex')
title('Entropy as function of $p(v_1)$','Interpreter','latex')

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot(p2,entropy, ...
    'Color',[7,84,213]/255,'LineWidth',1.5,...
    'DisplayName','Entropy')
scatter(p2(pos),maxEngropy, ...
    'filled','MarkerFaceColor',[249, 82, 107]/255,...
    'DisplayName','Maximum entropy')
legend('Interpreter','latex','Location','southeast')
xlabel('$p(v_2)$','Interpreter','latex')
ylabel('Entropy','Interpreter','latex')
title('Entropy as function of $p(v_2)$','Interpreter','latex')
```

## Appendix B

```matlab
clc, clear, close all

pRange = 1e-3:5e-3:1-1e-3;
[p1,p2] = meshgrid(pRange);
p3 = 1-p1-p2; % Plane: p1+p2+p3=1
p3(p3<0) = nan;% prevent producing complex number in matrix C
entropy = -(p1.*log(p1)+p2.*log(p2)+p3.*log(p3));

figure('Units','pixels','Position',[671.67,473.67,1015.33,420])
tiledlayout(1,2)
nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
view(3)
surf(p1,p2,p3,entropy, ...
    'FaceAlpha',0.9,...
    'DisplayName','Entropy', ...
    'EdgeColor','none')
[xPos,yPos] = find(entropy==max(max(entropy)));
xPos = xPos(1);
yPos = yPos(1);
scatter3(p1(xPos,yPos),p2(xPos,yPos),p3(xPos,yPos), ...
    100,'filled','MarkerFaceColor','g',...
    'DisplayName','Maximum entropy')

% % Plot area border
% x = 0:0.01:1;
% y = 1-x;
% z = zeros(1,numel(x));
% plot3(x,y,z, ...
%     'LineWidth',3,'Color','r',...
%     'DisplayName','$p(v_1)+p(v_2)=1$') % x-y border
% plot3(x,z,y,'LineWidth',3,'Color',[0.8,0.8,0.8],...
%     'DisplayName','$p(v_1)+p(v_3)=1$') % x-z border
% plot3(z,x,y,'LineWidth',3,'Color',[0,0,0],...
%     'DisplayName','$p(v_2)+p(v_3)=1$') % y-z border

% Figure settings
legend('Location','best','Interpreter','latex')
colorbar
colormap("jet")
title('Entropy as function of $p(v_1)$, $p(v_2)$, and $p(v_3)$', ...
    'Interpreter','latex')
xlabel('$p(v_1)$','Interpreter','latex')
ylabel('$p(v_2)$','Interpreter','latex')
zlabel('$p(v_3)$','Interpreter','latex')
xlim([0,1])
ylim([0,1])
zlim([0,1])

nexttile
hold(gca,"on")
box(gca,"on")
imagesc(pRange,pRange,entropy)
scatter(p1(xPos,yPos),p2(xPos,yPos), ...
    100,'filled','MarkerFaceColor','g')
legend('Maximum entropy')
set(gca, "YDir", "normal")
colorbar
title('Entropy as function of $p(v_1)$ and $p(v_2)$', ...
    'Interpreter','latex')
xlabel('$p(v_1)$','Interpreter','latex')
ylabel('$p(v_2)$','Interpreter','latex')
```

这段代码是在三维空间$p(v_1)$-$p(v_2)$-$p(v_3)$中绘制的，图像的颜色表示熵的大小，使用语句`surf(p1,p2,p3,entropy)`实现，仅仅计算了$p(v_1)+p(v_2)+p(v_3)=1$平面上的数值。

除此之外，还有另一种实现方式，是计算出整个立方体区域的的熵，然后使用`slice`函数切取并绘制出$p(v_1)+p(v_2)+p(v_3)=1$的平面[^2][^5]：

![image-20230408172002241](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20230408172002241.png?raw=true)

由于`slice`函数相当于将计算切片和绘图集成到一个函数中了，因此在（1）设置曲面绘图属性和（2）寻找熵的最大值时需要稍微注意一下：

```matlab
[p1,p2,p3] = meshgrid(0.01:0.01:1);
entropy = -(p1.*log(p1)+p2.*log(p2)+p3.*log(p3));
[xsurf,ysurf] = meshgrid(0.01:0.01:1);
zsurf = 1-xsurf-ysurf;

...

s = slice(p1,p2,p3,entropy,xsurf,ysurf,zsurf);
s.EdgeColor = 'none';
[xPos,yPos] = find(s.CData==max(max(s.CData)));
xPos = xPos(1);
yPos = yPos(1);
scatter3(s.XData(xPos,yPos),s.YData(xPos,yPos),s.ZData(xPos,yPos), ...
    100,'filled','MarkerFaceColor','g')
```

## Appendix C

```matlab
clc, clear, close all

x = 1e-3:5e-3:1-1e-3;
y = x;

[X,Y] = meshgrid(x,y);
Z = (1-X-Y);
Z(Z<0) = nan;
entropy = -(X.*log(X)+Y.*log(Y)+Z.*log(Z));

figure('Units','pixels','Position',[671.67,473.67,1015.33,420])
tiledlayout(1,2)
nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
view(3)
surf(X,Y,entropy,'EdgeColor','none')
colorbar
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
zlabel('S(x,y)','Interpreter','latex')
title('$S(x,y)=x\log x+y\log y+(1-x-y)\log (1-x-y)$', ...
    'Interpreter','latex')
xlim([0,1])
ylim([0,1])

nexttile
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
imagesc(x,y,entropy)
colorbar
xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
title('$S(x,y)=x\log x+y\log y+(1-x-y)\log (1-x-y)$', ...
    'Interpreter','latex')
xlim([0,1])
ylim([0,1])
```

## Appendix E

```matlab
clc, clear, close all


figure('Units','pixels','Position',[505,462.33,1839.33,419.99])
tiledlayout(1,4)
nexttile
view(3)
helperPlotEntropy
title('$S(x,y)=x\log x+y\log y+(1-x-y)\log (1-x-y)$', ...
    'Interpreter','latex')

nexttile
view(90,0)
helperPlotEntropy
title('View from the angle perpendicular to $x=0$',...
    'Interpreter','latex')

nexttile
view(180,0)
helperPlotEntropy
title('View from the angle perpendicular to $y=0$',...
    'Interpreter','latex')

nexttile
view(135,0)
helperPlotEntropy
title('View from the angle perpendicular to $1-x-y=0$',...
    'Interpreter','latex')

function helperPlotEntropy
x = 1e-3:5e-3:1-1e-3;
y = x;

[X,Y] = meshgrid(x,y);
Z = (1-X-Y);
Z(Z<0) = nan;

func = @(x,y,z) -(x.*log(x)+y.*log(y)+z.*log(z));

entropy = func(X,Y,Z);

hold(gca,"on")
box(gca,"on")
grid(gca,"on")

surf(X,Y,entropy, ...
    'EdgeColor','none', ...
    'FaceAlpha',0.9)

% Plot entropy at border x=0
x0 = 1e-3*ones(1,numel(x));
y0 = y;
z0 = 1-x0-y0;
entropy0 = func(x0,y0,z0);
plot3(x0,y0,entropy0, ...
    'LineWidth',2,'Color','r')

% Plot entropy at border y=0
x1 = x;
y1 = 1e-3*ones(1,numel(y));
z1 = 1-x1-y1;
entropy1 = func(x1,y1,z1);
plot3(x1,y1,entropy1, ...
    'LineWidth',2,'Color','g')

% Plot entropy at border 1-x-y=0
x2 = x;
y2 = 1-x;
z2 = 1-x2-y2+1e-3;
entropy2 = func(x2,y2,z2);
plot3(x2,y2,entropy2, ...
    'LineWidth',2,'Color','b')

xlabel('$x$','Interpreter','latex')
ylabel('$y$','Interpreter','latex')
zlabel('S(x,y)','Interpreter','latex')
set(gca,'FontSize',12)
xlim([0,1])
ylim([0,1])
end
```

<br>

# References

- [kullback leibler - What is the difference between Cross-entropy and KL divergence? - Cross Validated](https://stats.stackexchange.com/questions/357963/what-is-the-difference-between-cross-entropy-and-kl-divergence).
- [两种方法证明二元函数极值取得的充分性 - 知乎](https://zhuanlan.zhihu.com/p/362415195).
- [Extrema of functions of two variables: necessary and sufficient conditions - Mathematics Stack Exchange](https://math.stackexchange.com/questions/1280588/extrema-of-functions-of-two-variables-necessary-and-sufficient-conditions).

[^1]: [Solve Under-determined Equations - What a starry night~](https://helloworld-1017.github.io/2022-10-06/12-57-41.html).
[^2]: [MATLAB `slice`: Volume slice planes - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/slice.html?requestedDomain=en).
[^3]: [KL Divergence and its Relation to MLE - What a starry night~](https://helloworld-1017.github.io/2022-12-03/21-33-21.html).
[^4]: [lec2.pdf - CMU](https://www.cs.cmu.edu/~aarti/Class/10704_Spring15/lecs/lec2.pdf).
[^5]: [Creating 3-D Plots: Slices through 3-D Volumes - MathWorks](https://ww2.mathworks.cn/help/matlab/visualize/creating-3-d-plots.html#Creating3DPlotsDefaultCmapExample-6).
