---
title: "Goodhart's law, \"When a measure becomes a target, it cease to be a good measure.\""
toc: false
categories:
 - Mathematics
 - Psychology
 - Philosophy
 - Quotes
tags:
 - Probability Theory and Mathematical Statistics
 - Experiment
date: 2022-09-28 23:42:17 +0800
last_modified_at: 2024-08-02 16:23:37 +0800
---

<div class="quote--left" markdown="1">

When a measure becomes a target, it cease to be a good measure.

by British economist Charles Goodhart.

</div>

Significance test是一个科学的统计推断形式，在学术研究中，研究人员也常用$p$值衡量实验数据的可靠性，以及对比处理方法优劣。但是，正如Goodhart's law指出的：When a measure becomes a target, it cease to a good measure[^1]。当科学**指标**$p$值，作为一个实验人员追求的**目标**时，往往就会变得不可靠。实验人员甚至会主观地强加“实验者预期效应”，即$p$值操纵(p-hacking)。

p-hacking主要发生在两个阶段，一是在**数据采集阶段**，实验人员会根据当前的显著性结果决定是否停止收集样本，因为$p$值对样本量非常敏感，比如当样本量增加的时候，$p$值可能从不显著转为显著。因此，有些研究者先收集一部分样本，统计分析发现结果不显著，于是再接着补充一部分样本，直到统计显著后才停止收集数据。这种错误的做法会对研究的可重复造成影响；二是在**数据分析阶段**，采用不合理的手段使数据达到显著，使用各种方式“折磨”数据，让它“吐出”$p<0.05$的结果。

分析数据的统计性质，的确需要大样本，但是“大”的定义不能依据于“想要”，可以设置一个阈值，但是不能根据结果去找阈值；同样的，数据是一定要经过处理和分析的，但是不能根据结果无限度地摆弄数据处理步骤。这何尝不是一种数据泄露呢？**数据的信息泄露到了方法中**。

总的来说，Significant test作为科学的一部分，本身是没有错误的，这种错误是主观的。此时，再想想Hypothesis test，它的核心本身就不是“证明”，而是“态度”和“倾向”，不由感叹于统计学这门学科独特的严谨性和美感。

<br>

**References**

[^1]: [Goodhart's law - Wikipedia](https://en.wikipedia.org/wiki/Goodhart%27s_law).