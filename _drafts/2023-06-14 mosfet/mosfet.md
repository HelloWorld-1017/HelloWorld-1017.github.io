MOSFET是对称的（symmetrical），即source和drain端口可以交换（interchanged）

因此，S端和substrate端在内部连接，因此我们看到的MOSFET就只有三个端口，

==fig==，0235

S端和substrate端是等电位的，中间没有电流

在MOSFET中，我们想要使得电流从D端口流向S端口

![](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615180941834.png)

因此需要在D端口和S端口中连接一个电源，该电压被称作$V_{DS}$。

电源的正电压增加了D端口的电势，因此增加了Drain和substrate之间的耗尽层宽度，

![image-20230615181232676](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615181232676.png)

因此，当MOSFET处于关断状态下，没有电流从D端口流向S端口，这被称作为cut-off region。为了使得电流能够从Drain流向Source，我们需要在它们中间创建一个通道（channel），即在门级和substrate之间添加一个电压源。该电压被称作为$V_{gs}$，

![image-20230615181531431](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615181531431.png)

由于substrate是p型半导体，因此多子为空穴，少子为电子，因此电池会在substrate中间创建一个电场

![image-20230615181722209](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615181722209.png)

使得substrate之间的电子向电场的反方向流动，即向门级移动。

由于绝缘体的存在这些电子不能从substrate中流向gate，因此这些电子就会在substrate中，即门级附近累积。

电容可以在两个金属板上储存电荷；同样地，我们可以通过在两个盘子中间添加绝缘体来增加电容值，（电容计算公式）

![image-20230615182159652](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615182159652.png)

同样地，MOSFET中的绝缘体不仅阻隔了电子，并且还增加了正电荷的数量，因此吸引了更多的电子。因此，如果我们增加$V_{gs}$，更多的电子会被吸引到门级，并且开始填充一些空穴；并且，由于门级强烈的正电荷量，空穴开始远离门级。此时门级附近的区域内没有空穴，并且有一些自由电子，于是这部分区域成为了N型半导体。这在S级和D级之间创建了一个通道，使得自由电子可以从S级流向D级（从这个角度讲，也可以解释为什么它们叫做source和drain，因为sourece供应电子，而D级由于收集电子），电流（AKA drain current）也就从D级流向了S级：

![image-20230615183331625](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615183331625.png)

这个通道的厚度可以通过改变门级电压改变，随着电压的增加（减小）通道的宽度会增加（减小）。通道的形成电压就被称作阈值电压（threshold voltage）。。

此时，MOSFET处于ohmic或者linear region，在这个区域内，遵从欧姆定律，即随着$V_{DS}$的增加，电流增加。

但是，随着电压的增加，drain和substrate之间的耗尽层会增加，因为它们是反向偏置的；通道开始在靠近drain端处增加耗尽层，因为drain是正电势，而。。。。，限制了电流流过。随着电压的增加，会到达一个点，此时通道完全夹断（pinch off），这被称作夹断效应（pinch-off effect）。在实际中，通道没有被完全关断，因为。。。

![image-20230615184333602](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615184333602.png)

因此，没有停止电流，而是有一个constant saturated current。这个电流被称作saturation current，此时的电压被称作saturation voltage，

此时，如果增加电压，reverse biasing会增加，通道会进一步减小，但是电流不会增加，因为已经饱和了，这被称作是饱和区（saturation region）。



但是，如果我们增加$V_{GS}$两端的电压，我们就可以进一步增加通道的宽度，

![image-20230615184811176](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615184811176.png)

MOSFET被称作是电压控制器件（voltage control devices），因为门级的电压量能够控制从D流向S级的电流，

![image-20230615184946605](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615184946605.png)

另一种被称作depletion type的MOSFET，

它和enhancement type是类似的，但是depletion type MOSFET在掺杂时已经形成了一个通道：

![image-20230615185141394](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615185141394.png)

其他的工作原理都是相似的，除了depletion type的MOSFET需要一个负的门级电压才能关闭通道。

从开关的角度讲，depletion type的MOSFET是常开的，而enhancement MOSFET是常闭的

最后是符号问题：

![image-20230615185616960](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230615185616960.png)