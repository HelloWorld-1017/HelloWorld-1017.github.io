==差相关系数这一部分==

# For Univariate

## Variance

有一类数字特征可以**刻画随机变量在其中心位置附近散布(scatter)程度的数字特征**，其中最重要的是方差。

设随机变量$X$有均值$a=E(X)$。试验中，$X$的取值不一定恰好是$a$，而会有所偏离。因为$X$随机的，因此偏离量$X-a$也是随机的。我们要取偏离$X-a$的某种具有代表性的数字，来刻画这个偏离**即散布的程度的大小**。我们不能取$X-a$的均值，因为$E(X-a)=E(X)-a=0$，这表明正负偏离彼此抵消了。一种解决的办法是取$\vert X-a\vert$以消除符号的影响，再取其平均值$E(\vert X-a\vert)$，作为变量$X$取值的散布程度的数字特征。这个量$E(\vert X-a\vert)$叫做$X$(或其分布)的**平均绝对差**，是常用于刻画散布程度的数字特征之一。但是，由于绝对值在数学上不太方便，人们就考虑了另一种做法：先把$X-a$平方以消去符号，然后取其均值得到$E(X-a)^2$，把它作为$X$取值散布度的衡量。这个量就叫做$X$的**方差**(“差”的“方”)。

> 定义1(方差，Variance；标准差，Standard deviation)
>
> 设$X$为随机变量，分布为$F$，则：
> $$
> \mathrm{Var}(X)=E(X-EX)^2\label{variance}
> $$
> 称为$X$(或其分布)的**方差**，其平方根$\sqrt{\mathrm{Var}(X)}$(取正值)称为$X$(或其分布)的标准差。

暂记$EX=a$，由于$(X-a)^2=X^2-2aX+a^2$，则按照期望的性质，有：
$$
\mathrm{Var}(X)=E(X^2-2aX+a^2)=E(X^2)-2aE(X)-E(a^2)=E(X^2)-(EX)^2\notag
$$
即：
$$
\mathrm{Var}(X)=E(X^2)-(EX)^2
$$
方差的这个形式在计算上往往比较方便。

方差之所以称为刻画散布度的最重要的数字特征，原因之一就是它具有一些优良的数学性质，反映在以下几个重要的定理之中。

> 定理1
>
> 1. 常数的方差为0；
> 2. 若$c$为常数，则$\mathrm{Var}(X+c)=\mathrm{Var}(X)$；
> 3. 若$c$为常数，则$\mathrm{Var}(cX)=c^2\mathrm{Var}(X)$

> 定理2
>
> **独立**随机变量之和的方差等于各变量的方差之和，即：
> $$
> \mathrm{Var}(X_1+X_2+\cdots+X_n)=\mathrm{Var}(X_1)+\cdots+\mathrm{Var}(X_n)
> $$


另外，假设$X$为一个随机变量，且有$E(X)=a$，而$\mathrm{Var}(X)=\sigma^2$。记$Y=(X-a)/\sigma$，则容易得到$E(Y)=0$，并且按照定理1可以得到$\mathrm{Var}(Y)=1$。这样，对$X$做一个线性变换后，得到一个具有均值0、方差1的随机变量$Y$，常称为$Y$是$X$的**标准化**。

注：这种操作在数据处理时经常使用。
{: .notice--primary}

关于方差和标准差的MATLAB计算，详见博客[MATLAB var, std, and cov Functions - What a starry night ~](http://whatastarrynight.com/programming/mathematics/MATLAB-var-std-cov-functions/)

## Moments

### Definition

在博客[Point Estimation - What a starry night ~](http://whatastarrynight.com/mathematics/Point-Estimation/)中提到过使用经验矩估计理论矩的点估计方式，其中的理论矩就是指随机变量的矩。

> 定义2：
>
> 设 $X$ 为随机变量，$c$ 为常数，$k$ 为正整数，则量 $E[(X-c)^k]$ 称为 $X$ 关于 $c$ 点的 $k$ 阶矩。
>
> 比较重要的有两种情况：
>
> （1）$c=0$，这时 $\alpha_k=E(X^k)$ 称为 $X$ 的 **$k$ 阶原点矩**；
>
> （2）$c=E(X)$，这时 $\mu_k=E[(X-EX)^k]$ 称为 $X$ 的 **$k$ 阶中心矩**；

一阶原点矩就是期望。一阶中心矩 $\mu_1=0$，二阶中心矩 $\mu_2=E[(X-EX)^2]$ 就是 $X$ 的方差 $\mathrm{Var}(X)$。在统计学中，高于四阶的矩极少使用，三、四阶矩有些应用，但是也不是很多。

### Central 3rd moment,  Skewness

3阶中心矩$\mu_3$的应用之一就是用它去衡量**分布**是否有偏。假设$X$的概率密度函数为$f(x)$，若$f(x)$关于某点$a$对称，即：
$$
f(a+x)=f(a-x)
$$
则有$EX=a$，且$\mu_k=E[(X-EX)^3]=0$。如果$\mu_3\ne0$，那么$f(x)$一定不是关于点$a$对称的，那么如果$\mu_3>0$，则称该分布为正偏或右偏；如果$\mu_3<0$，则称分布为负偏或左偏。据此，假如我们想知道随机变量分布是不是正态分布，也可以使用$\mu_3$来进行判断。因为对于正态分布而言有$\mu_3=0$，因此如果$\mu_3$显著异于零，则该分布就与正态分布有较大偏离。

由于$\mu_3$的因次是$X$的因次的三次方，为抵消这一点，以$X$的标准差的三次方，即$\mu_2^{3/2}$去除$\mu_3$，其商：
$$
\beta_1=\mu_3/\mu_2^{3/2}\label{skewness}
$$
称为$X$或其分布的**偏度系数**。

### Central 4th moment, Kurtosis

4阶中心矩$\mu_4$的应用之一是衡量分布(密度)在均值附近的陡峭程度。因为$\mu_4=E[(X-EX)^4]$，容易看出，若$X$的取值在概率上很集中在$E(X)$附近，则$\mu_4$将倾向于小，否则就倾向于大。为抵消尺度影响，类似$\mu_3$的情况，以标准差的四次方即$\mu_2^2$去除，得到：
$$
\beta_2=\mu_4/\mu_2^2\label{kurtosis}
$$
称为$X$或其分布的**峰度系数**。

若$X\sim N(\mu,\sigma^2)$，则$\beta_2=3$(若要计算出这个数字，需要进行比较多的计算，此处从略，主要就是利用Gamma函数来计算正态分布函数的$k$阶原点矩，其中$k=1,2,3,4$)，与$\mu$和$\sigma^2$无关，为了迁就这一点，也常定义$\mu_4/\mu_2^2-3$为峰度系数，以使正态分布有峰度系数0。

注：也有称为$\mu_4/\mu_2^2-3$为超峰度([excess kurtosis](https://en.wikipedia.org/wiki/Kurtosis#Excess_kurtosis))
{: .notice--primary}

“峰度”这个名词，单从表面上看，易引起误解。比如，我们都知道，就正态分布$N(\mu,\sigma^2)$而言，$\sigma^2$越小，密度函数在$\mu$点处的“高峰”就越高且越陡峭，那么，为什么所有的正态分布又都有同一风度系数？这岂不是不与这个名词的直觉含义不符？原因在于：$\mu_4$在除以$\mu_2$后已失去了因次，即与$X$的直觉含义不符？原因在于：$\mu_4$在除以$\mu_2$后已经失去了因次，即与$X$的单位无关。或者换句话说，两个变量$X$，$Y$，谁的峰度大，**不能直接比其密度函数，而要调整到方差为$1$后再去比较**。也就是说，找两个常数$c_1$，$c_2$，使$c_1X$和$c_2Y$的方差为1，再比较其密度的“陡峭程度”如何。在这个共同的标准之下，“峰度”这一个词语就好理解了。

### Calculate skewness and kutosis in MATLAB

MATLAB就提供了计算数值序列偏度的函数：[skewness - MathWorks](https://ww2.mathworks.cn/help/stats/skewness.html)，以及用于计算峰度的函数：[kurtosis - MathWorks](https://ww2.mathworks.cn/help/stats/kurtosis.html)，下面将分别介绍。

需要注意的是，下面所算出的偏度和峰度仍是序列所属分布的属性，并不是将序列直接`plot`出来的图像的属性。
{: .notice--primary}

计算偏度的函数`skewness`的计算公式为：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221023161843839.png" alt="image-20221023161843839" style="zoom:67%;" />

它的计算思想是与式$\eqref{skewness}$是一致的，只是计算的不是理论矩，而是样本矩，当样本越多，样本矩就越接近理论矩。

```matlab
clc, clear, close all

y1 = randn(1, 1e6);
sk1 = skewness(y1, 1);
disp(sk1)

y2 = 2*randn(1, 1e6)+1;
sk2 = skewness(y2, 1);
disp(sk2)
```

```matlab
0.0028
-0.0026
```

可以看到，由$N(0,1)$和$N(1,4)$所生成的随机数序列，其偏度都接近于0。

计算峰度的函数`kurtosis`的计算公式为：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20221023165243415.png" alt="image-20221023165243415" style="zoom: 67%;" />

其实现与式$\eqref{kurtosis}$也是一致的，同样使用的是样本矩进行计算。

```matlab
clc, clear, close all

y1 = randn(1, 1e6);
sk1 = kurtosis(y1, 1);
disp(sk1)

y2 = 2*randn(1, 1e6)+1;
sk2 = kurtosis(y2, 1);
disp(sk2)
```

```matlab
3.0009
2.9991
```

可以看到，由$N(0,1)$和$N(1,4)$所生成的随机数序列峰度是一致的，均为3，并且没有使用上文所述的$\mu_4/\mu_2^2-3$计算公式。

<br>

# For Multivariate

那么，描述多维随机变量散布程度的数字特征是什么呢？

以二维情况为例，设$(X,Y)$为二维随机变量。$X$和$Y$本身都是一维随机变量，可以定义其均值和方差，在本小节，我们记：
$$
E(X)=m_1,\ E(Y)=m_2,\ \mathrm{Var}(X)=\sigma_1^2,\ \mathrm{Y}=\sigma_2^2\label{eq2}
$$
在多维随机变量的情形，我们更感兴趣的数字特征是**反映分量之间的关系的那种量**，其中最重要的是协方差和相关系数。

## Covariance

> 定义3(协方差，Covariance)
>
> 定义$E[(X-m_1)(Y-m_2)]$为$X$，$Y$的协方差，并记为$\mathrm{Cov}(X,Y)$。

“协”即“协同”的意思。式$\eqref{variance}$所定义的单随机变量$X$的方差是$X-m_1$与$X-m_1$的乘积的期望，现在把一个$X-m_1$换成$Y-m_2$，其形式接近方差，又有二者的参与，由此得出协方差的名称。由定义也可以看出，$\mathrm{Cov}(X,Y)$与$X$与$Y$的数学无关，即：
$$
\mathrm{Cov}(X,Y)=\mathrm{Cov}(Y,X)
$$
由定义也可以直接得出协方差的一些简单的性质。

> 协方差的性质
>
> （1）若$c_1$，$c_2$，$c_3$，$c_4$都是常数，则：
> $$
> \mathrm{Cov}(c_1X+c_2,c_3Y+c_4)=c_1c_2\mathrm{Cov}(X,Y)
> $$
> （2）
> $$
> \mathrm{Cov}(X,Y)=E(XY)-m_1m_2\label{eq1}
> $$

> 定理3：
>
> 1. 若$X$，$Y$独立，则$\mathrm{Cov}(X,Y)=0$；
> 2. $[\mathrm{Cov}(X,Y)]^2\le\sigma_1^2\sigma_2^2$。等号当且仅当$X$，$Y$之间具有严格的线性关系(即存在常数$a$和$b$，使得$Y=a+bX$)时成立。

## Covariance Matrix

上面介绍的协方差描述了两个随机变量，或者说多维随机向量分量之间的关系，但是得到一个标量，并不能**完全**表征出分量之间的相关关系，因此就引出了协方差矩阵(covariance matrix, AKA auto-covariance matrix, dispersion matrix, variance matrix, or variance-covariance matrix)的概念。

随机向量的协方差矩阵通常表示为$\mathrm{K_{XX}}$或者$\Sigma$。假设有一随机(列)向量$X=(X_1,X_2,\cdots,X_n)^T$，其中$X_i$为单个的随机变量，则协方差矩阵$\mathrm{K_{XX}}$中每一个元素为：
$$
\mathrm{K}_{X_iX_j}=\mathrm{Cov}(X_i,X_j)=E\Big[(X_i-EX_i)(X_j-EX_j)\Big]\label{covariancematrix}
$$
比如，对于二维随机向量$X=(X_1,X_2)^T$，有：
$$
\mathrm{K_{XX}}=\begin{bmatrix}
\mathrm{Cov}(X_1,X_1)&\mathrm{Cov}(X_1,X_2)\\
\mathrm{Cov}(X_2,X_1)&\mathrm{Cov}(X_2,X_2)\\
\end{bmatrix}\notag
$$

关于协方差矩阵的MATLAB计算，详见博客[MATLAB var, std, and cov Functions - What a starry night ~](http://whatastarrynight.com/programming/mathematics/MATLAB-var-std-cov-functions/)



## Correlation

定理3给“相关系数”的定义打下了基础。

>  定义4(相关系数，Correlation)
>
> 定义$\mathrm{Cov}(X,Y)/(\sigma_1\sigma_2)$为$X$，$Y$的相关系数，并记作$\mathrm{Corr}(X,Y)$。

形式上，可以把相关系数看作“标准尺度下的协方差”。变量$X$，$Y$作为$(X-m_1)(Y-m_2)$的均值，依赖于$X$和$Y$的度量单位，选择适当的单位使$X$，$Y$的方差都为1，则协方差就是相关系数。这样就能更好地反映$X$，$Y$之间的关系，不受单位的影响。

由定理3可以立即得到：

> 定理4
>
> 1. 若$X$，$Y$独立，则$\mathrm{Corr}(X,Y)=0$；
> 2. $-1\le \mathrm{Corr}(X,Y)\le1$，或$\vert\mathrm{Corr}(X,Y)\vert\le1$，等号当且仅当$X$和$Y$有严格线性关系时达到。

下面对这个定理，做出一些重要的解释。

（1）当$\mathrm{Corr}(X,Y)=0$时，称$X$，$Y$**不相关**。但是定理4只是说明了“$\mathrm{Corr}(X,Y)=0$”是“$X$，$Y$独立”的必要条件，但是并不是充分条件，即由“$\mathrm{Corr}(X,Y)=0$”无法推出“$X$，$Y$独立”。下面就是一个简单的例子。

设$(X,Y)$服从单位圆的均匀分布，即其PDF为：
$$
f(x,y)=\left\{
\begin{split}
&\pi^{-1},\ &\mathrm{if}\ x^2+y^2<1\\
&0,\ &\mathrm{if}\ x^2+y^2\ge1
\end{split}
\right.
$$
可以很容易地得到$X$，$Y$有着同样地的边缘概率分布$g(x)$：
$$
g(x)=\left\{
\begin{split}
&2\pi^{-2}\sqrt{1-x^2},\ &\mathrm{if}\ \vert x\vert<1\\
&0,\ &\mathrm{if}\ \vert x\vert\ge1
\end{split}
\right.
$$
函数$g(x)$关于0对称，因此其均值为0，故$EX=EY=0$。于是根据式$\eqref{eq1}$，有：
$$
\mathrm{Cov}(X,Y)=E(XY)=\dfrac1\pi\iint_{S}xy\mathrm{d}x\mathrm{d}y=0
$$
即$\mathrm{Cov}(X,Y)=0$。但是$X$，$Y$并不独立，因为其联合概率密度$f(x,y)$并不等于其边缘密度之积$g(x)g(y)$。

（2）线性系数也常称为“线性相关系数”。这是因为，实际上相关系数并不是刻画了$X$，$Y$之间“一般”关系的程度，而只是“线性关系”的程度。这种说法的根据之一就在于，当且仅当$X$，$Y$有严格的线性关系时，才有$\vert\mathrm{Corr}(X,Y)\vert$达到最大值1。可以容易地举出一个例子说明：即使$X$与$Y$有某种严格但是非线性关系时，$\vert\mathrm{Corr}(X,Y)\vert$不仅不必为1，还可以为0。

比如，设$X\sim R(-1/2,1/2)$，即区间$[-1/2,1/2]$内的均匀分布，而$Y=\cos X$，$Y$与$X$有严格的关系。但是$E(X)=0$，根据式$\eqref{eq1}$有：
$$
\mathrm{Cov}(X,Y)=E(XY)=E(X\cos X)=\int_{-1/2}^{1/2}x\cos x\mathrm{d}x=0
$$
因此，有$\mathrm{Corr}(X,Y)$。虽说$X$，$Y$“不相关”，但是它们之间却有着严格的关系$Y=\cos X$。足见相关系数所描述的相关只是指线性而言，一旦超出这个范围，其概念就失去了意义。

（3）如果$0<\vert\mathrm{Corr}(X,Y)\vert<1$，则解释为：$X$，$Y$之间有“一定程度的”线性关系而非严格的线性关系。比如在下面的三个图像当中，我们都假定$(X,Y)$服从所画出的区域内$A$的均匀分布。在这三个图中，$X$，$Y$都没有严格的线性关系，因为$X$的值并不能决定$Y$的值(即$X$和$Y$之间并不是函数关系，当然也就没有严格的线性关系了)。但是，从这三个图中，我们能够“感觉”到，$X$，$Y$之间存在着一种线性“趋势”。这种趋势，在图(a)中比较显著且都是正向的($X$增加时$Y$倾向于增加)，这相应于$\mathrm{Corr}(X,Y)$比较显著地大于0；在图(b)中，这种线性趋势比(a)更明显，程度更大，反映在$\vert\mathrm{Corr}(X,Y)\vert$比(a)的情况更大，但是是负向的。至于图(c)，则多少有一点线性倾向，但已甚微——$\vert\mathrm{Corr}(X,Y)\vert$虽然仍大于零，但是已接近零。

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20221024083151754.png" alt="image-20221024083151754" style="zoom:67%;" />

（4）上面提到的“线性相关”的意义，还可以从最小二乘法的角度去解释。假设有两个随机变量$X$，$Y$，现在想用$X$的某一线性函数$a+bX$来逼近$Y$，问：要选择怎样的常数$a$，$b$才能使逼近的程度最高？这个逼近程度，用最小二乘的观点来解释，即要使$E[(Y-a-bX)^2]$达到最小。

仍沿用$\eqref{eq2}$的记号：
$$
E[(Y-a-bX)^2]=E\Big\{[(Y-m_2)-b(X-m_1)-(a-(m_2-bm_1))]^2\Big\}
$$
令$c=a-(m_2-bm_1)$

则有：
$$
\begin{split}
E[(Y-a-bX)^2]=&E[(Y-m_2)-b(X-m_1)-c]^2\\
=&E\Big[(Y-m_2)^2+b^2(X-m_1)^2+c^2-\\
&2b(Y-m_2)(X-m_1)+2bc(X-m_1)-2c(Y-m_2)\Big]\\
=&\sigma_2^2+b^2\sigma_1^2-2b\mathrm{Cov}(X,Y)+c^2
\end{split}\label{eq3}
$$

为了使这个式子达到最小，需要取：
$$
\begin{split}
&c=0\Rightarrow a=m_2-bm_1\\
&b=\mathrm{Cov}(X,Y)/\sigma_1^2=\sigma_1\sigma_2\mathrm{Corr}(X,Y)/\sigma_1^2=\sigma_1^{-1}\sigma_2\mathrm{Corr}(X,Y)
\end{split}
$$
记$\mathrm{Corr}(X,Y)$为$\rho$，则得到的最佳线性逼近为：
$$
\begin{split}
L(X)&=(m_2-bm_1)+bX\\
&=m_2-\sigma_1^{-1}\sigma_2\rho m_1+\sigma_1^{-1}\sigma_2\rho X
\end{split}\label{eq2}
$$
由式$\eqref{eq3}$，这一逼近的剩余是：
$$
\begin{split}
E\Big[(Y-L(X))^2\Big]=&\sigma_2^2+b^2\sigma_1^2-2b\mathrm{Cov}(X,Y)\\
=&\sigma_2^2(1-\rho^2)
\end{split}
$$
如果$\rho=\pm1$，则$E\Big[(Y-L(X))^2\Big]=0$，而$Y=L(X)$。这时，$X$与$Y$就有严格的线性关系。正如前文所述：

- 若$0<\vert\rho\vert<1$，则$\vert\rho\vert$越接近1，则剩余越小，说明$L(X)$与$Y$的接近程度越大，即$X$、$Y$之间的线性关系的“程度”越大；
- 反之，$\vert\rho\vert$越小，则二者的线性关系程度越小；
- 当$\rho=0$时，剩余为$\sigma_2^2$，这时$X$的线性作用已毫不存在。因为仅取一个与$X$无关的常数$m_2$，已经可以把$Y$逼近到$\sigma_2^2$的剩余，因为$E(Y-m_2)^2=\sigma_2^2$。

由于相关系数只能刻画线性关系的程度，而不能刻画一般关系的函数相依关系的程度，在概率论中还引进了另外一些相关指标，以补救这个缺点。但是，这些指标都未能在应用中推开，究其原因，除了这些指标在性质上比较复杂之外，还有一个重要的原因：在统计学应用中，最重要二维分布时二维正态分布。而对二维正态分布而言，相关系数是$X$、$Y$的相关性的一个完美的刻画，没有上面指出的缺点，其根据有两条：

- 若$(X,Y)$为二维正态分布，则即使允许使用任何函数$M(X)$去逼近$Y$（仍然以$E\Big[(Y-M(X))^2\Big]$最小为准则），则所得到的最佳逼近仍然是由式$\eqref{eq2}$决定的$L(X)$。因此，在这个场合下，只需要考虑线性逼近已经足够，而这种逼近的程度完全由相关系数所决定；
- 当$(X,Y)$为二维正态分布时，由$\mathrm{Corr}(X,Y)=0$就能够推出$X$、$Y$独立。即在这一场合，独立与不相关是一回事，而前文指出，这在一般情况下并不成立。

<br>

**Reference**

[1] 概率论与数理统计. 陈希孺编著. 合肥: 中国科学技术大学出版社, 2009.2(2019.8重印).

