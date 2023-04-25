---
layout: single
title: The Prime Number Theorem (PNT) from *Prime Obsession* by Derbyshire
date: 2023-04-25 13:19:03 +0800
categories: 
 - Mathematics
tags:
 - Mathematical Analysis
 - Prime Obsession
 - Number Theory
---

# What is Prime?

什么是素数？

如果我们取一个正整数28，什么数能够整除它呢？答案是：1，2，4，7，14，28，我们称正整数28具有六个**因子（factor）**。所有的正整数都有1作为一个因子，并且每个数都有它自己作为一个因子。这两种数都是不太能引起人们兴趣的因子，用数学家们非常喜欢的话来说，它们是**平凡的因子（trivial factors）**；能引起兴趣的因子是剩余的那些：2，4，7，14，这些数被称为**真因子（proper factors）**，我们称正整数28具有4个真因子。

然而，有些正整数没有真因子（只有平凡的因子），例如29，29就是一个**素数（prime number）**。**素数就是没有真因子的数（A prime number is one with no proper factors）**。

1000以内的素数一共有168个：

```matlab
primes(100)
```

```
     2     3     5     7    11    13    17    19    23    29
    31    37    41    43    47    53    59    61    67    71
    73    79    83    89    97   101   103   107   109   113
   127   131   137   139   149   151   157   163   167   173
   179   181   191   193   197   199   211   223   227   229
   233   239   241   251   257   263   269   271   277   281
   283   293   307   311   313   317   331   337   347   349
   353   359   367   373   379   383   389   397   401   409
   419   421   431   433   439   443   449   457   461   463
   467   479   487   491   499   503   509   521   523   541
   547   557   563   569   571   577   587   593   599   601
   607   613   617   619   631   641   643   647   653   659
   661   673   677   683   691   701   709   719   727   733
   739   743   751   757   761   769   773   787   797   809
   811   821   823   827   829   839   853   857   859   863
   877   881   883   887   907   911   919   929   937   941
   947   953   967   971   977   983   991   997
```

经常有人提出异议，正整数1没有被包含在这个或者任何一个其他的素数表中，而1符合素数的定义。严格地讲，1是素数，然而，把1包含在素数中是一个很大的麻烦（nuisance），现代数学家的公式是不把它作为素数（最后一个把1作为素数的著名数学家应该是勒贝格（Henri Lebesgue），他在1899年这么做了）。实际上，甚至把2包含在素数表中也是个麻烦。因此，无数的定义一开头就是“设$p$是任意奇素数（Let $p$ be any odd prime）……”（在所有素数中，只有2是偶数）。不过，将2作为素数勉强还说得过去，但是1不行。因此在后面的讨论中，均不将1作为素数。

如果我们以万数段为单位，确定每个万数段中素数的个数：

```matlab
for i = 1:100
    numbers = (i-1)*1e4+1:i*1e4;
    PrimeIdx = isprime(numbers);
    numPrimes = sum(PrimeIdx);
    fprintf("[%s,%s]",num2str(min(numbers)),num2str(max(numbers)))
    disp(numPrimes)
end
```

```
[1,10000]        1229
[10001,20000]    1033
[20001,30000]    983
...
[970001,980000]   717
[980001,990000]   710
[990001,1000000]  721
```

就会发现，素数越来越稀疏了。

素数最后会稀疏到没有吗（*Do the primes eventually thin out to nothing*）？会存在一个最大的素数吗？欧几里得在公元前300年给出了漂亮的证明（在博客 [2] 中提到过）：**没有最大的素数**。无论从哪个素数开始，我们总是可以得到一个更大的素数。

<br>

# $\pi(N)$?

在回答了“有没有最大的素数”这个问题以后，数学家们好奇的下一件事情就是：我们能不能找到一个规则、一条定律，来描述素数的稀疏去向（*Can we find a rule, a law, to describe the thinning-out*）？有没有一个规则、一个公式能告诉我们，**小于一个给定值$N$的素数有多少个（Is there a rule, a formula, to tell me how many primes there are less than a given number?）？**

做一些简单的计算（其实并不简单……），可以得到：

| $N$                                   | $\pi(N)$               |
| ------------------------------------- | ---------------------- |
| 1,000 （一千）                        | 168                    |
| 1,000,000 （一百万）                  | 78,498                 |
| 1,000,000,000（十亿）                 | 50,847,534             |
| 1,000,000,000,000（一万亿）           | 37,607,912,018         |
| 1,000,000,000,000,000（一千万亿）     | 29,844,570,422,669     |
| 1,000,000,000,000,000,000（一百亿亿） | 24,739,954,287,740,860 |

如果定义函数$\pi(N)$为到$N$为止（包括$N$）的素数的个数，那么我们所面临的主要问题就可以描述为：**有没有什么规则或者简洁的公式能让我们免除逐个计算的麻烦得到$\pi(N)$？**

如果将$N/\pi(N)$，则可以得到：

| $N$                       | $\pi(N)$               | $N/\pi(N)$ | $\mathrm{Diff}(N/\pi(N))$ |
| ------------------------- | ---------------------- | ---------- | ------------------------- |
| 1,000                     | 168                    | 5.9524     | 5.9524                    |
| 1,000,000                 | 78,498                 | 12.7392    | 6.7868                    |
| 1,000,000,000             | 50,847,534             | 19.6665    | 6.9273                    |
| 1,000,000,000,000         | 37,607,912,018         | 26.5901    | 6.9236                    |
| 1,000,000,000,000,000     | 29,844,570,422,669     | 33.6247    | 7.0346                    |
| 1,000,000,000,000,000,000 | 24,739,954,287,740,860 | 40.4204    | 6.7957                    |

可以看到，$N/\pi(N)$的值以7为增量逐步递增；更确切地说，**以在6.8和7.0之间波动的一个数逐步递增**。这对我们来说可能并不是很精彩，但是当一个**数学家**看到这样一张表时，就像一盏明灯照亮了他的头脑，一个特别的词涌上他的心头！！！（*This might not strike you as very wonderful, but a large light bulb goes on over a mathematician’s head when he sees a table like that, and a particular word comes into his mind.*）

# Exponential functions

**指数函数（Exponential functions）**在数学中非常重要。例如，对于指数函数$f(N)=5^N$：

| $N$  | $f(N)=5^N$ |
| ---- | ---------- |
| 1    | 5          |
| 2    | 25         |
| 3    | 125        |
| 4    | 625        |

它就反映出了所有指数函数都具有的一个非常重要的特点：如果我们把自变量以一行行有规律地**加**的方法递增，再把函数规则应用于它们，如果它产生的结果（因变量）以一行行有规律的**乘**的方法递增，那么我们看到的就是一个指数函数（注：这里的有规律是指每次加或乘**相同的数**）。（*If you pick your arguments so that they go up by regular **addition** from row to row, and then apply the function rule to them, and if it turns out that the resulting values go up by regular **multiplication** from row to row, you are looking at an **exponential function**.“Regular” here means that **the same number** is being added, or multiplied, each time.*）对于指数函数$f(N)=5^N$，自变量每次增加1，而函数值则以每次乘5的方式增加。这里的5并没有什么特别的地方，实际上选择每个数都可以构成一个指数函数，$f(N)=5^N$只是指数函数家族（a family of exponential functions）中的一员。

数学家们有一个比较喜欢的词：**“典范型”（“canonical form）**。当我们遇到这样一种状况：某种现象（例如指数函数所具有的上述特点）可以用许多不同的方式表示，通常会有一种方式会被数学家们选来代表整个现象（*... in which a certain phenomenon (in this case an exponential function) can show up in many different ways, there is generally one way mathematicians **prefer to represent** the whole phenomenon.*）。指数函数的典范性就是含有的乘数是自然常数$\mathrm{e}=2.71828...$（natural constant，有时也被称作是欧拉数，Euler number；字母$\mathrm{e}$就是为了纪念欧拉），即$f(N)=\mathrm{e}^N$：

| $N$  | $f(N)=\mathrm{e}^N$ |
| ---- | ---------- |
| 1    | 2.7183         |
| 2    | 7.3891         |
| 3    | 20.0855        |
| 4    | 54.5982        |

<br>

# Log functions

数学家们很喜欢把东西**逆反**过来：把它们翻转过来（*Mathematicians are very keen on **inverting** things—turning them inside out*）。对一个函数的自变量和因变量逆反过来的操作实际上就是在讨论**反函数（inverse function）**。关于反函数的一个常识是：**不是所有的函数都具有反函数，但是严格单调的函数一定具有反函数**。很幸运，指数函数就属于严格单调的函数，因而一定具有反函数。

我们将上面的自然指数函数的表格调转过来（左右两列互换）：

| $f^{-1}(N)$（自变量） | $N$（因变量） |
| ---- | ---------- |
| 2.7183 | 1        |
| 7.3891 | 2        |
| 20.0855 | 3       |
| 54.5982 | 4             |

我们可以看到，当前的函数具有以下和指数函数恰好相反特点：当自变量以**乘法**递增时，它的函数值以**加法**递增。我们就称这样的指数函数的反函数为**对数函数（log function）**，并且定义$y=\mathrm{e}^x$的反函数为自然对数函数$x=\ln(y)$。

<br>

# The Prime Number Theorem (PNT)

此时，我们再回到前面所得到的这张表：

| $N$                       | $\pi(N)$               | $N/\pi(N)$ | $\mathrm{Diff}(N/\pi(N))$ |
| ------------------------- | ---------------------- | ---------- | ------------------------- |
| 1,000                     | 168                    | 5.9524     | 5.9524                    |
| 1,000,000                 | 78,498                 | 12.7392    | 6.7868                    |
| 1,000,000,000             | 50,847,534             | 19.6665    | 6.9273                    |
| 1,000,000,000,000         | 37,607,912,018         | 26.5901    | 6.9236                    |
| 1,000,000,000,000,000     | 29,844,570,422,669     | 33.6247    | 7.0346                    |
| 1,000,000,000,000,000,000 | 24,739,954,287,740,860 | 40.4204    | 6.7957                    |

就可以看到：$N$以**乘法**（系数1000）的模式递增，而$N/\pi(N)$以**加法**（增量近似为7）的方式递增，这是有些类似对数函数的！！！此时，我们再做一个简单的操作，取$\ln(N)$作为自变量，$N/\pi(N)$为因变量，则有：

| $\ln(N)$ | $N/\pi(N)$ | $(\ln(N)-N/\pi(N))/(N/\pi(N))$（% error） |
| -------- | ---------- | ----------------------------------------- |
| 6.9078   | 5.9524     | 16.0507                                   |
| 13.8155  | 12.7392    | 8.4487                                    |
| 20.7233  | 19.6665    | 5.3736                                    |
| 27.6310  | 26.5901    | 3.9146                                    |
| 34.5388  | 33.6247    | 2.7185                                    |
| 41.4465  | 40.4204    | 2.5386                                    |

这样，自变量和因变量**都**以某种**加法**的模式递增；并且我们直接认为$\ln(N)$​接近于$N/\pi(N)$似乎也是合理的，并且$N$越大，就越成比例地接近。

对于这样一种关系，数学家们有个特别的写法：

$$
\dfrac{N}{\pi(N)}\sim \ln N
$$

即：$N$除以$\pi (N)$**渐进地趋于**$\ln N$（*N over pi of N **tends asymptotically** to log N.*）。

如果根据一般的代数规则改写这个式子，就会得到：

$$
\pi(N)\sim \dfrac{N}{\ln N}\label{eq1}
$$

式$\eqref{eq1}$是一个很重要的结果，被称为是“**素数定理**”，并且不是“素数的一个定理（**a** prime number theorem）”，而是“素数定理（**The** Prime Number Theorem）”，数论专家经常将它简写为PNT。

<br>

# Consequences of PNT

在数学界，有这样一种观念，即**对数观念（logarithmic sense）**：在处理不大于某个数值较大的$N$的**所有数**时，我们认为这些数大多数在大小上都和$N$相似（*when dealing with **all the numbers** up to **some large N**, most of those numbers resemble N in size*）。例如，假如我们要处理1到10,000亿（13位）的所有数，90%以上都有12位或者更多位，就这这方面而言，它们与10,000亿的相似性，要远远大于与1000（4位）这种数的相似性。

在对数观念至下，如果我们**假设**PNT是成立的，则PNT可以有两个推论：

（1）如果1到$N$有$N/\ln N$个素数，那么这个范围内的素数的平均密度就是$1/\ln N$；并且，由于这个范围内的大部分数在大小上都与$N$相似，因此可以推断出：在$N$附近的素数的密度是$1/\ln N$，换句话说，在一个大数$N$附近，一个数是素数的概率为$1/\ln N$：

$$
\text{The probability that N is prime is}\sim\dfrac1{\ln N}\label{eq2}
$$

（2）根据同样粗略的逻辑，我们可以**估计**第$N$个素数的大小。对于某个大数$K$，考虑从$1\sim K$的范围（$K$是未知的）。如果这个范围的素数的个数是$C$，那么平均来说（on average），我们最有可能在$K/C$处发现第一个素数，在$2K/C$处发现第二个素数，在$NK/C$处发现第$N$个素数。如果PNT成立，则实际上有$C=K/\ln K$，因此第$N$个素数应该会出现在$NK/(K/\ln K)=N\ln K$附近；又因为在这个范围内的大部分数在大小上都与$K$相似，我们就可以将$K$和$N$互换，那么第$N$个素数就是$\sim N\ln N$，即：

$$
\text{The N-th prime number is}\sim N\ln N\label{eq3}
$$

虽然这看起来靠不住（fishy），但实际上是一个不坏的估计（not a bad estimate），并且会依据波浪线原则成比例地变得越来越好。

式$\eqref{eq2}$和$\eqref{eq3}$不仅是PNT地推论，实际上，**PNT也是它们的一个推论**。这两个结果都与PNT同等重要，并且都可以被看作是PNT的另一种表述方法。

<br>

**References**

[1] Derbyshire J. Prime obsession: Bernhard Riemann and the greatest unsolved problem in mathematics[M]. Joseph Henry Press, 2003.

[2] [Take a Little Think of Monte Carlo Simulation - What a starry night~](http://whatastarrynight.com/mathematics/uncertainty/Take-a-Little-Think-of-Monte-Carlo-Simulation/).



