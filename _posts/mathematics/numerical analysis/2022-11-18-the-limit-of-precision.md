---
title: The Limit of Precision
categories: 
 - Mathematics
tags:
 - Numerical Analysis
date: 2022-11-18 22:22:22 +0800
last_modified_at: 2024-10-05 21:25:29 +0800
---

>  当使用有限精度的计算机内存来表示真实、无穷精度数字的时候，舍入误差不可避免。尽管我们希望在长的计算中生成的较小的误差对于结果仅有较小的影响，但是事实表明在很多情况下仅仅是一厢情愿。简单算法，诸如高斯消去或者微分方程的求解方法，能够把极微小的误差放大到极大的规模。事实上，本书的一个主要议题就是使读者*<u>意识到</u>*：**由于计算机所造成的小误差使得计算面临不可靠的危险，并且要知道如何避免或最小化这样的危险**。[1]
>
>  ——《数值分析》Sauer

# Introduction

数值分析的一个目标是在给定的精度级别中估计结果。使用双精度意味着我们使用52位精度（大约16位十进制数字）来保存和操作数字。

但是，用计算机计算得到的答案总能有16位 *正确的* 有效数字吗？答案是否定的：**利用双精度的计算机不能得到16位正确的有效数字，即便使用最好的算法**。

<br>

# Difficulties Solving Multiple Roots

## Explanation

这篇博客中的示例和思想均来自 Sauer 的《数值分析》，我尝试基于 MATLAB 软件实现和验证这些思想和见解。但是，在使用计算机进行实现的过程中，我并没有得到作者所述的现象。我试图分析一下其中的原因，先写在前面。

首先，从数学上定义 *精确到小数点后 $p$ 位* 的含义：

>如果误差小于 $0.5\times 10^{-p}$，则称**解精确到小数点后 $p$ 位**。

二分法是求解方程数值根最简单的一种方法，具体内容与实现见博客：[迭代法求解非线性方程(组)](http://whatastarrynight.com/mathematics/Solve-nonliear-system-using-iterative-method/#%E4%BA%8C%E5%88%86%E6%B3%95)。二分法的误差上限和迭代次数之间有着明确的数学关系：

> **二分法的迭代次数**
>
> 假设区间 $[a, b]$ 是初始区间，在 $n$ 次二分之后，得到的最终区间 $[a_n, b_n]$ 的长度为 $(b-a)/2^n$ ，选择中点 $x_c = (a_n+b_n)/2 $ 作为解的最优估计，与真实值之间的误差不会超过区间长度的一半，即在经过 $n$ 步二分法操作后，有：
> 
> $$
> 求解误差=\vert x_c-r \vert<\dfrac{b-a}{2^{n+1}}\label{eq1}
> $$
> 
> 并且有：
> 
> $$
> 计算次数=n+2\notag
> $$
> 
> 因此，二分法的迭代次数的确定非常简单，只需要确定期望的精度就可以通过公式 $\eqref{eq1}$ 计算所需要的迭代次数。
>
> BTW，二分法的迭代次数和误差精度之间具有明确的数学关系，这是二分法的优点之一。对于一些更有效的算法，我们通常很难估计迭代次数和精度之间的关系。

我们可以得到：对于下面将要提到的使用二分法的数值求根的例子，对于函数 $f(x)=x^3-2x^2+\dfrac43x-\dfrac8{27}$ ，使用二分法求解函数的数值根，假设二分法的求解区间为 $[0, 1]$ ，如果想要得到的数值解精确到小数点后6位，则根据上述分析，二分法的迭代次数 $n$ 满足：

$$
\varepsilon<\dfrac{1-0}{2^{n+1}}<0.5\times10^{-6}\notag
$$

即 

$$
n\ge\lceil\log_2(2\times10^6)\rceil-1=20\notag
$$

即，在这个问题中，二分法需要至少迭代 20 次才可以达到预期误差精度。

但是在《数值分析》书中，Sauer 指出：当真正使用**有限精度（双精度）**的计算机求解上述问题时，算法迭代 17 次就停止了，并不能保证精确到小数点后 6 位，出现这种异常的根本原因是：在迭代过程的最后一次迭代中，区间中点 $c_n$ 对于计算机而言满足 $f(c_n)=机器0$ ，是一个**数值根**，因此算法就提前终止了。于是作者得出结论：虽然双精度的计算机的机器误差(即相对误差上限)为 $2^{-52}$ ，相当于十进制的 $2.22\times10^{-16}$，但是使用二分法我们并不能得到 16 位正确的小数位，甚至不能得到 6 位正确的小数位。盲目相信计算机是会面临一些危险的。

但是，我在根据二分法的原理实现的时候并没有出现上述迭代提前中断的情况， 算法正常迭代了20次 ，最终到达了我们想要的误差精度。那么，为什么我和 Sauer 得到的结果不同呢？

我个人认为，二分法的迭代过程提前中断实际上很难出现。因为迭代过程提前中断，就意味着在计算机看来，区间中点 $c_n$ 满足 $f(c_n)=机器0$ ，如果在代码中使用的是 `==` 逻辑运算符来判断

```matlab
    ...
    if fun(c) == 0
        root = c;
        return
    end
    ...
```

那么这实际上是一个非常严苛的条件，计算机很难满足，于是就会将迭代过程继续下去。

但是，为什么 Sauer 得到了那样的结果呢？

我猜想，可能  Sauer 本人在编程时，可能使用的是类似下面的代码

```matlab
    ...
    if abs(func(c) - 0) <= 0.5*eps
        root = c;
        return
    end
	...
```

即，当 $c_n$ 的函数值和 0 之间的距离小于机器精度的一半时，就 “认为” $f(c_n)$ 的值是机器零，$c_n$ 就是数值根。在使用这种逻辑判断语句下，最终就出现了仅迭代 17 次的情况，我在后面就采用了这样的实现方式。

在实际编程中，我们应该尽量避免使用 `==` 逻辑运算符，但这个编程实例告诉我们，有时使用 `==` 反而会达到比较好的效果。

⭐⭐⭐**The only mistakes are things done in ignorance**.⭐⭐⭐
{: .notice--warning}

## Example 1

使用二分法计算函数 

$$
f(x)=x^3-2x^2+\dfrac43x-\dfrac8{27} \label{eq2}
$$


的根，精确到小数点后6位。

式 $\eqref{eq1}$ 的函数 $f(x)$ 可以化简为 $f(x) = (x-\dfrac23)^2$，$x=\dfrac23$ 是函数的三重根。函数图像如下图所示：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220714132122813.png?raw=true" style="zoom: 50%;" />

```matlab
% MATLAB script
clc, clear, close all

% Plot function curve
a = 0.4; b = 1;
x = a:0.01:b;
y = (x-2/3).^3;

LineWidth = 1.7;
Interpreter = 'latex';
plot(x, y, LineWidth=LineWidth), hold on
hline = plot([a, b],[0, 0], ...
    'LineStyle','--', ...
    LineWidth=LineWidth,...
    Color="#7F7F7F"...
    ); hold on
scatter(2/3, 0, 57, 'filled', MarkerFaceColor=[200, 92, 92]/255)
xlabel('$x$', Interpreter=Interpreter)
ylabel('$f(x)$', Interpreter=Interpreter)
title('Function curve')
```

在区间 $[0,1]$ 内使用二分法寻找方程的数值根：

```matlab
a = 0; 
b = 1; 
epsilon = 5e-7; 
maxIteration = 200;
func = @(x) (x-2/3).^3;

[root, num, list_x, range_list] = BisectionMethod(func, a, b, epsilon, maxIteration);

function [root, num, list_x, range_list] = BisectionMethod(func, a, b, epsilon, maxIteration)
% Record the convergence process of x0
list_x = [];
% Record the interval length of each iteration
range_list = [];
num = 0;

% If upper and lower bounds of interval are wrong
if a > b || func(a) * func(b) > 0 || abs(a - b) < epsilon
    warning('Boundary setting error.')
    return
end

if func(a) * func(b) == 0
    if func(a) == 0
        root = a;
        return
    else
        root = b;
        return
    end
end

while (b-a)/2 > epsilon
    c = (a + b) / 2;
    list_x(num+1) = c;
    range_list(num+1) = abs(a-b);
    num = num + 1;
    
%     if func(c) == 0
    if abs(func(c)-0) <= 0.5*eps
        root = c;
        return
    end

    if func(a) * func(c) < 0
        b = c;
    elseif func(a) * func(c) > 0
        a = c;
    end

    if num >= maxIteration
        warning("There maybe exists solution, but the algorithm does not converge.")
    end
end
root = (b+a)/2;
end
```

输出迭代过程中的区间中点，即数值根的迭代过程：

```matlab
>> format long
>> list_x

list_x =

  Columns 1 through 4
   0.500000000000000   0.750000000000000   0.625000000000000   0.687500000000000

  Columns 5 through 8
   0.656250000000000   0.671875000000000   0.664062500000000   0.667968750000000

  Columns 9 through 12
   0.666015625000000   0.666992187500000   0.666503906250000   0.666748046875000

  Columns 13 through 16
   0.666625976562500   0.666687011718750   0.666656494140625   0.666671752929688

  Column 17
   0.666664123535156
```

最终的数值根为 $c_{17}=0.666\ 664\ 123\cdots$，与解析根 $x=\dfrac23=0.666\ 666\ 666\cdots$ 做对比，可以看到我们并没有得到精确到小数点后六位。

前面提到，二分法提前终止的原因是 $c_n$ 对于计算机而言满足 $f(c_n)=机器0$ ，是一个数值根。但这其实反映出的是一个更深层次的原因：**双精度算数无法在根附近足够精确地计算函数值 $f$** 。



## The definition and meaning of forward error and backward error

前向误差和后向误差分析属于经典的误差分析理论。后向误差分析理论是由[James  H. Wilkinson](https://en.wikipedia.org/wiki/James_H._Wilkinson)(1919-1986)所建立和发展的([Error analysis: Backward error analysis - Wikipedia](https://en.wikipedia.org/wiki/Error_analysis_(mathematics)#Backward_error_analysis))，在本博客的后面，我们也会提到一个由Wilkinson所提出的一个多项式求解问题，即Wilkinson polynomial求解问题。
{: .notice--primary}

如果从另一个角度看待上面的示例，当最终的数值根为 $c = 0.666\ 664\ 123\ 535\ 156$ 时，它函数值为 $f(c) = -1.644774851224724\times 10^{-17}$。

假设一个函数， $f$ 是一个根，即 $f(r) = 0$ 。假设 $x_a$ 是 $r$ 的近似值，那么对于根求解问题，近似值 $x_a$ 的**后向误差**是 $\vert f(x_a)\vert$ ，**前向误差**是 $\vert r-x_a\vert$。

>后向和前向的概念是针对问题求解过程而言的。对于一般的问题，我们认为求解过程可以简化为下面的这种形式：
>
>$$
>定义问题的数据(信息)\rightarrow\fbox{求解过程}\rightarrow 解\notag
>$$
>
>对于方程数值求根问题，“问题的信息”就是方程，“求解过程”就是数值算法：
>
>$$
>方程\rightarrow\fbox{方程求解算法}\rightarrow 解\notag
>$$
>
>**后向**误差是指在**输入**一侧的误差，即为 $\vert f(x_a)\vert $ ，而**前向**误差就是**输出**一侧的误差，即 $\vert r-x_a\vert$。

在定义了前向误差和后向误差的概念之后，我们就可以重新描述上面所遇到的困难。

对于上述二分法求根的示例，后向误差已经在 $1\times10^{-16}$ 之下，而前向误差在 $3\times 10^{-6}$ 附近。此时，**后向误差已经小于双精度计算机的机器精度 $\varepsilon_{mach} \approx 2.2\times10^{-16}$ ，因此后向误差就不能被可靠降低，因此也就导致了前向误差不能减小**。

从图像上看，函数 $f(x)=x^3-2x^2+\dfrac43x-\dfrac8{27}$ 在三重根 $x = \dfrac23$ 附近非常非常平缓。后向误差在垂直方向上进行度量，而前向误差在水平方向上进行度量，因此前者要比后者小得多。

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220714132122813.png?raw=true" style="zoom: 50%;" />

**前向误差与后向误差的讨论与数值算法的终止条件有关**。方程求根问题是为了找到方程 $f(x) = 0$ 的根 $r$，假设我们的算法可以生成一个近似解 $x_a$ ，我们如何确定这个解有多好？如何确定我们是否可以停止迭代呢？

前向误差与后向误差就提供了两个标准，一是判断前向误差 $\vert x_a - r\vert$ 是否足够小，二是判断后向误差 $\vert f(x_a)\vert$  是否足够小。当然，当我们找到的 $x_a$ 就等于 $r$ 时，前向误差和后向误差都为0，但是这种情况在数值计算领域几乎很难遇到。在更多情况下，我们需要选择前向误差**或**后向误差作为一个标准。

究竟是选择前向误差还是后向误差，这其实取决于我们所面临的问题和使用的方法。比如，对于二分法求根问题，两种误差都可以观察到；而对于 FPI 法，前向误差需要我们对根有着**先验的估计**（如同公式$\eqref{eq1}$ ），因此不容易得到，而后向误差显然更容易计算。

<br>

## Example 2: Wilkinson Polynomial

前面讲述了在函数的多重根附近进行数值求解所遇到的困难，但实际上当函数不存在多重根时，仍然可能会出现问题。

一个难以进行数值求解的单根例子是威尔金森在其论著中进行讨论的式子，后来被人们称为**威尔金森多项式**：

$$
W(x)=(x-1)(x-2)\cdots (x-20)\notag
$$

将其展开，可以得到：

```matlab
clear, clc
syms x
y = 1;
for i = 1:20
    y = y*(x-i);
end
s = expand(y)
```

可以得到：

```matlab
>> s

s =
x^20 - 210*x^19 + 20615*x^18 - 1256850*x^17 + 53327946*x^16 - 1672280820*x^15 + 40171771630*x^14 - 756111184500*x^13 + 11310276995381*x^12 - 135585182899530*x^11 + 1307535010540395*x^10 - 10142299865511450*x^9 + 63030812099294896*x^8 - 311333643161390640*x^7 + 1206647803780373360*x^6 - 3599979517947607200*x^5 + 8037811822645051776*x^4 - 12870931245150988800*x^3 + 13803759753640704000*x^2 - 8752948036761600000*x + 2432902008176640000
```

威尔金森多项式的根很干净，只有从1到20之间的整数，但是如果使用数值算法对它的分解形式进行求根，最终会由于近似相等、大数字的消去而产生误差。

Sauer 在书中使用 “MATLAB 的最高性能的多用途根求解器 fzero” 求解多项式在16附近的根，最终得到的结果为16.01468030580458，误差约为 $1.5\times10^{-2}$。我尝试了这样的方法，得到结果：

```matlab
clear, clc
format long
syms x
y = 1;
for i = 1:20
    y = y*(x-i);
end
s = expand(y);

% Explicit expression
f = @(x) x^20 - 210*x^19 + 20615*x^18 - 1256850*x^17 + 53327946*x^16 ...
    - 1672280820*x^15 + 40171771630*x^14 - 756111184500*x^13 + 11310276995381*x^12 - 135585182899530*x^11 ...
    + 1307535010540395*x^10 - 10142299865511450*x^9 + 63030812099294896*x^8 - 311333643161390640*x^7 ...
    + 1206647803780373360*x^6 - 3599979517947607200*x^5 + 8037811822645051776*x^4 - 12870931245150988800*x^3 ...
    + 13803759753640704000*x^2 - 8752948036761600000*x + 2432902008176640000;
f_zero = fzero(f, 17);

% Anonymous function converted from symbolic function
s = matlabFunction(s);
s_zero = fzero(s, 17);
```

```matlab
>> f_zero

f_zero =

  16.999679060899815

>> s_zero

s_zero =

  16.998633110109527
```

我采用了两种方法构建匿名函数：写出显式表达式和由符号函数转换。两种形式的求解误差分别在 $3.3\times10^{-4}$ 和 $1.4\times10^{-3}$ 左右。尽管今天实现的结果比作者当时得到的结果好一些，但是仍然可以得出结论：双精度计算机在求解单根问题时，仍然不能保证求解误差在我们期望的范围内。求根过程中保存系数时很小的误差对结果产生了很大的影响，并且无论多么高级的数值算法都会在一定程度上放大误差，这是数值算法固有的缺陷。

威尔金森本人在1984年写道：“对于我个人而言，我把这看作我的数值分析生涯最惨痛的经历。”

<br>

# Sensitivity of Roots Searching

前文所介绍的在求解三重根和求解Wilkinson多项式所遇到的问题，都是由于相同原因所造成的——**方程中小的求解误差造成求解根的大误差**。如果在输入中是一个小误差，在这种情况下，这样的问题被称为**敏感性(Sensitivity)**问题。在这一部分，我们将要对误差进行量化，并引入误差放大因子和条件数概念。

为了理解究竟是什么造成了误差的放大， 我们将建立公式以理解当方程改变时，根能移动多远。

假设问题是找到方程$f(x)=0$的根$r$，但是**由于数值计算问题方程本身发生了一个小的变化**$\varepsilon g(x)$，其中$\varepsilon$很小：

$$
f(x)+\varepsilon g(x)=0\notag
$$

$\Delta r$是由于求解上式而造成的根的变化，因而有：

$$
f(r+\Delta r)+\varepsilon g(r+\Delta r)=0\notag
$$

将$f$和$g$展开为一阶泰勒多项式：

$$
f(r)+(\Delta r)f'(r)+\varepsilon g(r)+\varepsilon (\Delta r)g'(r)+O((\Delta r)^2)=0\notag
$$

其中，$O((\Delta r)^2)$代表包含$(\Delta r)^2$和$\Delta r$的更高阶项。对于小的$\Delta r$，$O((\Delta r)^2)$可以忽略，于是我们可以近似得到：

$$
(\Delta r)(f'(r)+\varepsilon g'(r))\approx-f(r)-\varepsilon g(r)=-\varepsilon g(r)\notag
$$

进一步得到：

$$
\Delta r\approx \dfrac{-\varepsilon g(r)}{f'(r)+\varepsilon g'(r)}\notag
$$

假设和$f'(r)$相比，$\varepsilon$很小，并且$f'(r)\ne0$（*注意这一点假设*），于是有：

$$
\Delta r\approx -\varepsilon \dfrac{g(r)}{f'(r)}\notag
$$

总结上述推导内容，我们可以得到根的敏感公式：

> **根的敏感公式**
>
> 假设$r$是函数$f(x)$的根，并且$r+\Delta r$是$f(x)+\varepsilon g(x)$的根，则当$\varepsilon \ll f'(r)$时，根发生的偏离为：
> 
> $$
> \Delta r\approx-\dfrac{\varepsilon g(r)}{f'(r)}\label{sensitivity}
> $$

## Example 1

例如：估计$P(x)=(x-1)(x-2)(x-3)(x-4)(x-5)(x-6)-10^{-6}x^7$的最大根。

其中原方程$f(x)=(x-1)(x-2)(x-3)(x-4)(x-5)(x-6)$，方程发生误差项为$10^{-6}x^7$，其中$\varepsilon=10^{-6}$，$g(x)=x^7$，最大根为$r=6$。问题是，我们加上误差项后，根发生了多少变化？

根据式$\eqref{sensitivity}$，可以得到：

$$
\Delta r\approx-\dfrac{\varepsilon 6^7}{5!}=-2332.8\varepsilon\label{sensiE}
$$

这意味着在函数$f(x)$相对大小$\varepsilon$的输入误差，在根中被一个超过2000的因子放大。

我们估计$P(x)$的最大根为$r+\Delta r=6-2.3328\varepsilon=6.0023328$。对$P(x)$使用`fzero`求解，我们得到数值解为：

```matlab
clc, clear, close all

fun = @(x) (x-1)*(x-2)*(x-3)*(x-4)*(x-5)*(x-6)-10^(-6)*x^(7);
f_zero = fzero(fun, 10);
```

```matlab
f_zero =
   6.002326754746450
```

得到的计算结果约为6.0023268。

因此，式$\eqref{sensiE}$的估计足以告诉我们在根拟合的过程中误差如何放大。问题数据的第6位的误差带给结果第3位的影响，意味着以误差放大因子2332.8，将会造成丢失三位有效数字。

对于一个一般算法生成的近似$x_c$，我们定义：

$$
误差放大因子=\dfrac{相对前向误差}{相对后向误差}
$$

前向误差指的是解的变化，该变化可以使得$x_a$准确，在根求解问题中前向误差对应$\vert x_a-r\vert$；后向误差指的是输入中的变化，该变化使得$x_c$是正确的解。对于前向误差和后向误差有大量可以选择的方式，这依赖于我们想要探索哪一种敏感性。更一般地情况，**任何输入数据的变化都可以用于后向误差**，比如在上例中选择$g(x)=x^7$(或者取其他的函数形式，这取决于我们对于问题的了解)。

在求解根的过程中的误差放大因子如下：

$$
误差放大因子=\vert\dfrac{\Delta r/r}{\varepsilon g(r)/g(r)}\vert=\vert\dfrac{-\varepsilon g(r)/(rf'(r))}{\varepsilon}\vert=\dfrac{\vert g(r)\vert}{\vert rf'(r)\vert}\label{eq3}
$$

对于上例，为$6^7/(6\times5!)=388.8$。

但是，我们使用数值求解方法就是不知道真实的根$r$是多少，对于更一般的方程组，式$\eqref{sensitivity}$和$\eqref{eq3}$的意义在哪里呢？
{: .notice--primary}

## Example 2

在Wilkinson多项式中，$x^{15}$中的变化对于根$r=16$的影响是多大呢？

我们可以定义扰动函数：$W_\varepsilon=W(x)+\varepsilon g(x)$，其中$g(x)$定义为$g(x)=-1672280820x^{15}$(这个系数就是Wilkinson多项式中$x^{15}$的系数)，并且有$W'(16)=15!4!$。

**(1) 考察根中的变化**

利用公式$\eqref{sensitivity}$，可以得到根中的变化近似为：

$$
\Delta r\approx\dfrac{16^{15}1672280820\varepsilon}{15!4!}\approx 6.1432\times10^{13}\varepsilon
$$

根据博客[十进制数字的浮点数表示与机器表示(IEEE 754)](http://whatastarrynight.com/mathematics/Floating-Point-Arithmetic/#%E6%9C%BA%E5%99%A8%E7%B2%BE%E5%BA%A6%E7%9A%84%E6%84%8F%E4%B9%89)，我们可以知道，对于每个保存的数字都有和机器精度同样阶数的相对误差。在$x^{15}$项中的变化$\varepsilon_{mach}$使得根$r=16$相对移动：
$$
\Delta r\approx (6.1432\times10^{13})(\pm2.22\times10^{-16})\approx\pm0.0136
$$
**(2) 考察误差放大因子**

根据式$\eqref{eq3}$可以计算误差放大因子：

$$
\dfrac{\vert g(r)\vert}{\vert rf'(r)\vert}=\dfrac{16^{15}\times1672280820}{16\times4!15!}\approx3.8\times10^{12}
$$

误差放大因子的重要性在于，它告诉我们16位数位的操作精度在输入和输出的过程中会有多少位的丢失。对于放大因子是$10^{12}$的问题，我们估计在计算过程中会丢掉16位中的12位有效数字，从而在根中仅留下4个有效数字。

## Condition

这些误差放大的例子表明，根求解过程对于特定的输入变化的敏感性。问题可能或多或少地敏感，这依赖于如何设计输入的变化(即$g(x)$)。问题的条件数定义为所有输入变化，或者至少特定的变化所造成的最大误差放大，条件数高的问题称为病态问题(ill-conditioned problem)，条件数在1附近的问题称为良态问题(well conditioned probel )。

条件数(Condition number)也是误差放大度量的一种方式。数值分析**是对算法的研究**，算法把定义问题的数据作为输入，对应的结果作为输出。条件数指的是理论问题本身所带来的误差放大部分，和用于求解问题的特定算法无关。

**“条件数仅仅度量由于问题本身带来的误差放大”**，这一点很重要。和条件数一起，还有一个平行的概念，即稳定。**(数值)稳定**([Numerical stability - Wikipedia](https://en.wikipedia.org/wiki/Numerical_stability))指的是由于算法小的输入误差造成的放大，而不是问题本身。如果一个算法在小的后向误差存在的时候，总能给出一个近似解，则称该算法是稳定的。如果问题的条件好，算法稳定，我们可以期望同时具有小的后向误差和前向误差。

<br>

**Reference**

[1] Sauer T. 数值分析(原书第2版). 北京: 机械工业出版社, 2014.10(2021.1重印).

