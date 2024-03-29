---
layout: single
title: 从易处理性和有效性的角度看待问题与模型
date: 2022-08-12 12:20:13 +0800
categories:
 - Mathematics
 - Uncertainty
tags: 
 - Operations Research
toc: true
---

<br>

很多科学问题、工程问题都可以归结为一个优化问题：在考虑一定的 **约束** 下，规划 **决策变量** ，使得表征 **求解目的** 的 **目标函数** 最小。优化问题的求解大致分为 **精确求解** 和 **启发式求解** 两种方法，这两种方法的共同点是，它们都需要写出决策变量、约束、目标函数等要素（后面将会提到，这些要素需要 *精确* 写出）。再看过一些蒙特卡洛模拟求解数学问题的实例后，我感觉蒙特卡洛模拟实际上是另一种看待并求解优化问题的方式。今天在重读 Ronald 所著的《运筹学(Optimization in Operations Research)》时，惊奇地发现 Ronald 在书的第一章就对这两种不同的角度做出了详细的说明 😆。Ronald 将两种方式分别定义为规范性模型和描述性模型，并且将两者之间的选择归结为有效性和易处理性之间的权衡。易处理性与有效性之间“不可兼得”的关系是 Ronald 在《运筹学》的第一章一直在强调的主题，Ronald 从这个角度讲述了很多运筹学方法论的内容。

<br>

# 运筹学中的数学模型

## 数学模型

Ronald 首先简单地定义了 **数学模型**：

>  数学模型(mathematical model) 是一个包含 <u>变量</u> 及问题相关特征之间 <u>关系</u> 的集合体。

牛顿、爱因斯坦等伟大的科学家所做的工作，就是将我们日常生活中遇到的各种问题和自然法则用简洁的数学公式描述出来，构建起数学模型，便于进行更深入的分析和探索。而 **运筹学(operations research, OR)** 作为数学的一个分支，就是一门研究如何为复杂的 <u>工程</u> 或者 <u>管理</u> 问题构建数学模型（将问题特征用数学语言合理表示），以及如何分析模型和探索所有解决方案的学科。

下图展示了运筹学处理问题的一般步骤：

![image-20220810232148016](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220810232148016.png)

- 一般步骤开始于建模，我们首先需要定义相关变量（决策变量），以及量化用于描述问题相关行为的一些关系（约束和目标函数）。在建模的过程中，存在着对现实问题不同程度的简化和合理假设。

- 之后是分析。我们需要应用数学方法与技术找到模型建议的结论，并同时 ⚠ 注意这些结论来自简化后的模型，而非最初的实际问题。

- 最后我们需要做出推论，以表明这些源自于模型的结论对于解决实际问题的合理性。另一方面，推论也可能证明这些源自于模型的结论对于解决问题是不充分的或者难以执行的，这时我们就需要修正模型并重新进行上述步骤

## 决策、约束、目标

在建立运筹学模型时，我们需要从三个维度——决策、约束和目标去关注问题：

> 三个建模的基本关注点：
>
> 1）决策者需要做出的决策(decision)：决策通常以决策变量的形式表示；
>
> 2）限制决策选择的约束(constraint)：约束体现了决策变量之间的关系，约束的数量、复杂性和合理性通常取决于实际问题的简化程度；
>
> 3）人们偏好的决策所产生的目标(objective)：目标是判断一个决策优于另一个决策的标准，目标的选择通常和人们看待问题的方式有关。

在处理许多实际决策问题时，**明确** 地定义出决策、约束与目标对于阐明问题非常有帮助。

## 从后向到前向：系统边界与敏感性分析

在数学模型构建的过程中涉及很多“数量”，这些数量既有给定的参数，也有未知的决策变量。给定的参数以及待确定的决策变量之间的界限构成了系统边界。**参数**(parameter，即给定的数量)用于定义系统内部模型的目标函数以及约束，之后，通过对决策变量的分析，进而输出系统的结果，即**输出变量**(output variable)。

![image-20220811101446253](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220811101446253.png)

> 📃✏ BTW，Sauer 在《数值分析》书中也给出过类似解决问题的流程。Sauer 将问题的求解过程归结为下面这种形式：
> 
> $$
> 定义问题的数据(信息)\rightarrow\fbox{求解过程}\rightarrow 解\notag
> $$
> 
> 从而定义了后向误差(在信息和数据一侧)和前向误差(在解的一侧)，用于解释数值求根算法无法有效降低前向误差的原因。
>
> 运筹学中也是类似的分析思路，所对应的内容就是敏感性分析。

我们必须意识到系统边界内的参数实际上存在**任意性**，并且包含着人们认知的**模糊性**和**局限性**，我们只是在一种限定下得到了一种结果。这种限定是必然的，因为如果我们对参数的任意性不做任何限制，我们就无法对模型进行有效的分析；另一方面，我们也需要稍微放宽一些限制，以探索参数的变化会如何改变模型的分析结果，这就是敏感性分析的初衷。

> **敏感性分析**用于评价某个参数取值变化对于数学模型结果的影响。

❗ **任何完整的运筹学研究都包含参数敏感性的分析。**❗

## 🧡易处理性 & 有效性

**解析解(closed-form solution)** 就是能够基于输入参数用公式表达出来的用于描述决策变量选择的解。解析解的优势就在于它是基于参数的表达式，因而能够在不同的参数取值条件下通过简单计算直接得到结果，并且能够提供丰富的敏感性分析（函数偏导计算）。因此，解析解实际上代表着数学模型的 *最终分析*。

但是更多的优化问题并没有解析解，甚至无法找到最优解，此时的敏感性分析就会变得比较棘手，我们能做的工作就很有限。于是，就引出了模型 **易处理性** 的概念。

> 易处理性(tractability)是指模型便于分析的程度，即有多少分析是可操作。
>

显然，具有解析解的数学问题是易处理的。

解析解的公式很漂亮，但是，**我们是否应该将所有运筹学的目标都设置为找到解析解呢**？显然不是这样的。再回过头看一下运筹学的研究步骤

![image-20220810232148016](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220810232148016.png)

我们研究问题的目标并不是为了漂亮的数学形式，而是要提供决策帮助人们解决问题。因此我们还需要从另一个维度考察模型——**有效性**。

> 有效性(validity)是指由模型推断得到的结果适用于真实系统的程度。

解的有效性通常与建模过程中的假设和简化程度有关。在 **相同** 的假设下，对于不同的问题的求解会得到两组不同的解析解，虽然都是解析解，它们的易处理性都会得到保证，但是它们用于解决实际问题时的有效性却是不同的，因为相同的假设在面临不同的问题时有效性是不同的。

总的来说，**模型有效性与分析易处理性之间的权衡贯穿运筹学问题求解始终。**

<br>

# 规范性模型与描述性模型

一开始构建模型时，我们总是从一个很简单的模型入手，比如假设一个参数为常数。但是随着对实际问题认识得更加深刻，我们就会问一些类似的问题：为什么假设这个参数为常数？可以有哪些改进？

假设参数为常数的行为并非合理得显而易见，我们可以对此做出改进，而用于模拟真实系统的**计算机仿真模型**就是改进的一种方式。计算机仿真模型可以模拟出现实世界中未曾出现过的情形，可以创造出许多可能的世界，但是在这些可能的世界里得到的结果值得相信吗？确切地说，没有人知道。但是我们可以确定的是，仿真模型是有效的。

> 仿真模型的有效性：**仿真模型由于非常准确地跟踪了真实的系统的行为，因而具有较高的有效性**.
>

仿真模型可以为分析提供很多参考。但是同时也应当注意的是，仿真模型也是基于大量的假设构建的。

<br>

之前由决策、约束、目标所构成的模型，通常称之为 **规范性模型(prescriptive model)**，而像计算机仿真模型这样 <u>用于评估某些决策变量的结果而非寻求最优的决策变量的模型</u> 称为 **描述性模型(descriptive model)** 。这样的评估一些明确的决策变量的描述性模型有时能够告诉决策者需要知道的一切，这是有意义的，因为在实践中很多问题所允许存在的解是有限的。

![image-20220812100731997](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220812100731997.png)

但是，由于描述性模型的输入参数和决策变量都是确定的，与规范性模型相比，它所提供的信息相差甚远，所能产生的推论较少，难以开展后续的分析，**易处理性较差**。

这里再一次体现出模型易处理性和有效性之间的“对抗”：借助如仿真模型这种 *结构性较低的数学形式* 可以大大提高有效性，但是，这种缺乏结构性的数学形式会严重限制分析的可能性。**模型的有效性高通常意味着易处理性较低**。

<br>

# 精确所带来的危险

## 数值搜索

很多的优化问题的目标函数和约束都很复杂，难以从数学上得到认识或者进行操作，**数值搜索**为我们提供了一种推进问题解决的新思路。

> 数值搜索(numerical search)是这样一种过程：它系统地 **尝试** 不同的决策变量选择，并不断 **追踪** 能够使目标函数为当前最好的可行解。我们之所以称这样的搜索为数值搜索，是因为它处理的是具有明确取值的变量，而规范性模型中的符号变量。

一般来说，**数值搜索的结论受限于被探索的变量的取值范围**，除非模型的数学结构支持对搜索范围的进一步缩减。

注：不能混淆数值搜索和仿真模型。数值搜索是解决规范性模型的一类算法，目的还是寻找最优的决策变量，而仿真模型属于描述性模型。

## 最优解的现实意义

在大多数情况下，数值搜索找到的解都是启发式/近似最优解。

**精确最优解(exact optimal solution)** 是 *可被证明* 的能够使目标函数达到最优的可行解；而 **启发式(heuristic )/近似最优解(approximate optimum)** 只是通过 *描述性模型* 分析得到的可行解，并不保证它是真正的最优解。

> ⚠⚠⚠
>
>  这里，Ronald 定义启发式最优解是通过描述性模型得到的，但是这与他之前所定义的描述性模型（描述性模型是用于评估而非寻优）有所冲突。
>
> 我倾向于认为，启发式最优解应当强调 **它与精确最优解之间的距离**，而非强调得到启发式最优解的方式。因为有很多方式去得到一个启发式最优解，比如使用各种各样的数值搜索算法，或者将非线性问题合理线性化的处理方式。前者没有结构性的数学形式，易处理性较差，有效性高；而后者具有结构性的数学形式，易处理性较好，而有效性较差。这些方法并没有一个统一的特点。

数值搜索往往只能得到一个启发式最优解，即一个比较好的可行解。比较好就足够好了吗？我们是否有需要求出精确最优解？

答案取决于我们的目的。如果我们认为我们的目的是求解“模型”，那么我们会认为比较好还不够好，从数学上求出模型的精确解的尝试很有必要，很有意义；但是如果往前看，我们认为最终的目的是解决”问题“，那么比较好实际上已经足够好了。因为有时候数学上所推荐的最优决策（精确最优解）会随着输入的变化产生大幅度的波动，是相当“不稳定的”。并且，无论是在仿真模型中还是在工程实践中，精确最优解所对应的目标函数值都与理论上的最优目标函数值相去甚远。

> “用启发式最优解代替精确最优解所带来的损失，相比于采用通过有问题的模型假设与数据得到的精确最优解所引发的不确定性变化，有时微不足道。”

但是，精确解仍然有着一个很重要的现实意义：如果知道了精确最优解，我们便能知道启发解与精确解之间的距离，也就能够了解我们所采用的启发式算法的效果是怎样的，还有多少的改进空间。换一个角度讲，**精确解的存在，使得我们可以计算出一个算法的前向误差和后向误差**，对于数值搜索算法而言，也就提供了很好的算法终止的条件。

> “精确最优解的吸引力在于它们不仅能够提供很好的可行解，而且能够确定在一些固定的模型假设下模型能够达到什么样的效果”

## 确定模型与随机模型

精确最优解的不稳定性只是其中一个问题，正如前面在介绍描述性模型时所提到的，参数的确定性也是模型有效性低的原因。顺着描述性模型的思路向前走，我们很自然地想知道：如果一个参数服从某一分布，目标是否也会表现出特有的规律？于是就发展出随机模型。

如果一个数学模型的所有参数均被假设为确定的(deterministic)，则称之为 **确定模型**；而如果模型中存在一些只知道其概率分布的参数，则称之为 **随机(stochastic)模型** 或者 **概率(probabilistic)模型**。随机变量(random variable) 就是指随机模型中只知道概率分布的参数，区别于单一取值的参数。

在确定仿真模型的基础上，我们可以构建起一个随机仿真模型，以考察输入参数服从某一分布的情况下，目标（如$C(q,r)$，其中 $q$ 和 $r$ 是确定参数） 服从的分布。**随机仿真**（即 **蒙特卡罗仿真**）提供了一个工具，它通过如下的方式产生输出变量分布的样本：

（1）随机产生一个输入参数的实现序列；

（2）对不同的决策变量选择都进行随机仿真。

随机仿真是一个有效且广泛应用的运筹学建模技术，因为仿真模型极大的灵活性能够有效地使模型涵盖非常广泛的问题情形。但是，通常情况下我们只能得到近似的分布，还需要进一步采用统计评估技术来判定结论的置信度。

## 运筹学领域主要使用确定性模型

现实系统的参数几乎没有可以被确定量化的，随机模型更加符合我们对于现实系统的描述，通过随机仿真得到的分布描述可以更为完整合理地刻画系统。那么，为什么不对所有的问题都采用随机模型呢？答案是随机模型的易处理性很差，这是描述性模型共有的劣势。通过随机仿真测定出分布的工作量很大，另一方面，高有效性的要求会使分析工作进一步增多，最终导致模型的易处理性很差。

处理随机模型的数学工具在能力与通用性上均与处理确定模型的工具不一致，在运筹学领域，**我们的目标是进行优化，而大部分优化模型都是确定性模型**，这并非因为运筹学分析者认为所有问题参数都是确定的，而是由于通常只有忽略随机变化才能得到一些有用的描述性结果。

另一方面，当面临的案例具有成千上万个决策变量的时候，运用随机模型解决问题显然不太现实。

<br>

**参考**

[1] Ronald L. Rardin. 运筹学(原书第2版). 肖永波, 梁湧译. 北京: 机械工业出版社, 2018.6.

