---
layout: single
title: Simple State Machines LabVIEW Template
date: 2022-12-31 16:51:31 +0800
categories: 
 - LabVIEW
---

# Introduction

之前对于LabVIEW的学习都集中在VI的搭建，而大型的LabVIEW程序往往都是“项目”，由多个VI构成。LabVIEW官方同样提供了一些模板项目，并且都会自带一个documentation文件夹，该文件夹中包含着一个.html文件，用以介绍模板项目的使用和扩展。本博客就结合“简单状态机”的模板项目和documentation，对LabVIEW的状态机模式进行学习。

![image-20221230220237312](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230220237312.png?raw=true)

“简单状态机”项目中Main.vi的前面板：

![image-20221230220348439](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230220348439.png?raw=true)

程序框图：

![image-20221230220413259](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230220413259.png?raw=true)

<br>

# State Machines

“简单状态机”项目，用于定义各代码段的执行顺序。这种特定的实现通常也被称为摩尔机——下一个状态取决于当前状态。

对于以下类似的应用程序采用状态机模式就非常有效：

- 单个页面或包含多个选项卡的对话框。对话框的每个选项卡对应用于一种状态。用户单击特定的选项卡时，启动状态转移。对于每个选项卡，用户可执行的操作都包含在相应的状态中。
- 自动取款机(ATM)。该应用程序可能涉及以下几种状态：等待用户输入、检查请求的金额是否超过账户余额、吐钞、打印收据等
- 自动取款机(ATM)。该应用程序可能涉及以下几种状态：等待用户输入、检查请求的金额是否超过账户余额、吐钞、打印收据等

从整体上看，整个主程序状态机就是一个while循环结构包裹着一个条件结构，我们通过设置条件结构的分支来设定不同的状态。在这个简单的状态机项目中，一共有5种状态：

![image-20221230224438447](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230224438447.png?raw=true)

上图中的每一种状态对应于主VI中条件结构的一个分支，所对应的程序框图为：

![image-20221230224305568](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230224305568.png?raw=true)

每一种状态都需要：

1. 执行某项操作
2. 通过向While循环的移位寄存器传递指令，指定状态机的下一个状态

![image-20221230231815404](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230231815404.png?raw=true)

> 注：所有的条件分支都需要定义各自的输出隧道，如果有分支没有配置输出隧道，LabVIEW会显示类似下面的空心方框来提示错误。
>
> ![image-20221230231609686](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230231609686.png?raw=true)



<br>

# `Data.ctl` and `State.ctl`

`.ctl`是自定义控件文件，我们可以在项目浏览器中创建该类型的文件。在这个模板项目中，一共有两个自定义控件，分别是`Data.ctl`和`State.ctl`，它们的作用是：

- 每种状态可以访问一个数据簇，簇中包含的数据类型通过`Data.ctl`定义。
- `State.ctl`是一个自定义类型，罗列了有效的状态。用自定义类型实现状态转移的方法限制了可能的转移操作数量，减小了状态机陷入不可识别状态的可能性。

下文会对这两个自定义控件的定义和使用做详细的介绍。

<br>

# Adding Initialization Code

按照下列步骤为应用程序初始化添加代码：

1）选择条件结构的Initialize条件分支。

2）为应用程序初始化添加代码。例如，可能需要打开一个磁盘文件用于记录，因此需要对`Data.ctl`中的数据设定初始值。自定义控件`Data.ctl`由一个簇构成：

![image-20221230233509416](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230233509416.png?raw=true)

之后，类似插入子VI，右键插入`Data.ctl`，并参照模板进行连线：

![image-20221230234213515](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221230234213515.png?raw=true)

3）确定待转移的下一个状态。默认情况下，"Initialize"状态转移至"Wait for Event"状态。根据应用程序的需求，用户可修改该代码，转移至其他状态。

<br>

# Adding a Control that Initiates a State Transition

1）在前面板上添加一个控件；

2）选择条件结构的"Wait for Event"分支，并在事件结构中添加事件分支；

3）添加并配置事件的分支：例如设置当前面板的控件的值发生变化时，触发事件：

![image-20221231113231665](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221231113231665.png?raw=true)

4）在分支中，为新控件拖曳程序框图接线端；（在这个模板项目中，控件没有与其他的内容连接，只是放在了它所对应的事件分支结构之中）；

5）确定用户与该控件交互后待转移的状态，将枚举型的值设为这个状态，然后连线至 Next State 输出隧道：

![image-20221231114430225](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221231114430225.png?raw=true)

最终，对于"Wait for Event"条件结构大概是这个样子：

![image-20221231120653544](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221231120653544.png?raw=true)

<br>

# Adding a State

在前面的过程中，对于这样的状态标签：

![image-20221231120746870](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221231120746870.png?raw=true)

我是通过枚举常量进行构建的，而更正确的方式是通过添加`.ctl`自定义控件实现。

我们在项目浏览器中创建一个`State.ctl`，并添加到VI中。此时的图标和之前的枚举常量是一样的，只是左上角有一个黑色小三角，鼠标放在这个小三角上，会显示这样的信息：

![image-20221231122344238](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221231122344238.png?raw=true)

如果我们想要再添加新的状态，那么可以通过更新`State.ctl`的方式来实现。

首先，选定一个State.ctl枚举型，打开自定义类型：

![image-20221231124340877](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221231124340877.png?raw=true)

在后面添加新的状态：

![image-20221231124440523](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221231124440523.png?raw=true)

之后保存即可。

这样做的好处是，如果我们更改VI中的一个State.ctl枚举型，那么其他的State.ctl枚举型都会进行相应的改变。而我们之前使用的简单的枚举常量的方式是无法做到这一点的。

当添加了一个状态后，我们需要将新状态添加至状态机中：

1. 在Main.vi的条件结构中添加一个分支

2. 为该状态添加执行代码。完成该步骤时，需注意下列事项：

   - 通过“按名称解除捆绑”和“按名称捆绑”函数访问和修改状态数据：

     ![image-20221231124951609](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221231124951609.png?raw=true)

   - 将函数的错误接线端与错误移位寄存器相连

   - 连线“假”常量至布尔输出隧道。只有"Stop"状态可以使循环停止运行

   - 必须为每种状态设定待转移的下一个状态。将下一个状态的值连接至"Next State"输出隧道。连入该接线端之前，还可以按条件实现一定的逻辑。下图显示了逻辑的一个范例：

     ![image-20221231125034882](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221231125034882.png?raw=true)

     上述代码中，如数据大于0，则下一个状态为User State 1。否则，下一个状态为User State 2。如需实现更高级的条件逻辑，可采用条件结构.

   - 确保应用程序在一定条件下可转移至这种新的状态。

<br>

# Conditional Terminal of While Loop

此时程序仍然无法运行，因为我们之前并没有为最外层的While循环设置条件接线端的连线。在这一部分，我们参照模板进行连线。

![image-20221231132804111](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20221231132804111.png?raw=true)

While循环的停止条件设置为`真时停止`，而由或运算得到“真”的情况：要么是程序报错，要么是布尔常量为真，要么两者同时为真。前一种情况很好理解，那么为什么要引入布尔常量呢？这么做是为了给不同的状态定义循环的停止条件。

我们可以看到，`Exit`条件分支下的布尔常量是`True`，而其他条件分支下的布尔常量都是`False`。这样的逻辑表示：在`Exit`状态下，自动停止循环，即自动终止程序；而在其他状态下，只有在程序出现错误时才会终止程序。

<br>

Reference

[1] [Modify the Simple State Machine LabVIEW Template](https://knowledge.ni.com/KnowledgeArticleDetails?id=kA03q000000YICmCAO&l=en-HK)

[2] [Application Design Patterns: State Machines](https://www.ni.com/en-us/support/documentation/supplemental/16/simple-state-machine-template-documentation.html).



