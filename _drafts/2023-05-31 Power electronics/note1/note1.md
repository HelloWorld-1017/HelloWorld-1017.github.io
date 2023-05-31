# Extrinsic Semiconductor

**非本征半导体（extrinsic semiconductor）**是一种在半导体晶体生产过程中向晶体中掺杂了（ is doped with）被称作掺杂剂（doping agent）的微量元素或者化学物质（trace element or chemical）的半导体 [1]。掺杂杂质的目的是改变纯半导体晶体（pure semiconductor crystal，也被称作intrinsic semiconductor，本征半导体）的电学性质。在非本征半导体中，主要是这些存在于晶体晶格（crystal lattice）中的外部掺杂原子（foreign dopant atoms）提供电荷载流子（charge carriers），这些电荷载流子携带电流通过晶格。

掺杂剂主要有两种类型，一种是电子供体掺杂剂（electron donor dopant），一种是电子受体掺杂剂（electron acceptor dopant）：

## Electron donor dopant (n-type semiconductor)

**电子供体掺杂剂**是一种能够在晶体晶格中释放移动导电电子（mobile conduction electron）的原子。掺杂了电子供体掺杂剂的非本征半导体也被称为**N型半导体（n-type semiconductor）**，因为这种非本征半导体晶格中负电子（**n**egative electrons）为主要电荷载流子（majority charge carriers，即**多子**），空穴为少数电荷载流子（minority charge carriers，即**少子**）。常见的用于制造N型硅的电子供体掺杂剂为磷（phosphorus）或砷（arsenic）。

## Electron acceptor dopant (p-type semiconductor)

**电子受体掺杂剂**是一种能够从晶格中接受电子的原子。电子受体掺杂剂可以在晶格中产生一个**空穴（hole，or electron hole）**，空穴可以像电子一样穿过晶格，起作用 *类似于* 带正电荷的粒子（act similarly to positively-charged particles）[2]。掺杂了电子受体掺杂剂的非本征半导体也被称作**P型半导体（p-type semiconductor）**，因为这种非本征半导体晶格中正空穴（positive holes）是多子，电子为少子。常见的用于制造P型硅的掺杂剂为硼（boron）或镓（gallium）。

## Attention

需要注意的一点是，无论是N型半导体还是P型半导体，它们对外都是呈现电中性的。因为本征半导体和掺杂剂都是平衡的，只不过当掺杂剂掺杂到晶格结构后，由于结构中具有共价键，掺杂原子进入到晶格结构中会有一个电子或者空穴没有参与到晶格结构中，成为（弱束缚的）多子 [3]。

<br>

# p-n Conjunction Diode

将P型半导体和N型半导体“拼接”在一起就可以形成一个PN结二极管（p-n junction diode）[4]：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230530160615747.png" alt="image-20230530160615747" style="zoom:50%;" />

## Depletion region of p-n conjunction diode (Equilibrium)

P型半导体和N型半导体中的主要载流子在二极管的正常工作温度下会发生**热致振动（thermally induced vibrations）**，使得其在半导体晶格周围随机移动，并向载流子浓度降低的方向上（the direction of decreasing carrier concentration）扩散。这些可移动的载流子在PN结附近会留下电离的掺杂原子（ionized dopant atoms），形成一个电场。例如，当N区的电子从N区扩散至P区时，会在N区留下一个缺少电子的电离原子，因而产生一个净正电荷；同样地，当空穴从P区扩散至N区时，会在P区留下具有具有净负电荷的电离原子。在PN结附近的电离原子的区域被称作**空间电荷层（space-charge layer）**，或者称作**耗尽层（depletion region，势垒层）**：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230530160639365.png" alt="image-20230530160639365" style="zoom:50%;" />

在这个耗尽层内的电离原子会产生净电压为$v_0$的电场$E$。电压$v_0$构成了一个**能垒（energy barrier）**，倾向于阻止载流子的扩散：使载流子向反方向漂移（drift）。随着更多的移动载流子扩散穿过PN结，这个电场会持续构建，直到电压和电场强度大到足以抑制移动电荷穿过PN结，达到稳定状态（Equilibrium）。



## Applied on reverse-bias voltage

当PN结二极管两端施加（相对于PN方向）的反向偏置电压时，该电压与耗尽层的电场方向相同，因此会引起PN结附近掺杂原子的进一步电离，并且外部电路的电荷添加到了耗尽层，增加了耗尽层的大小，进而增加耗尽层的电场强度，并导致出现二极管的电容效应（capacitive effect）。

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230530160723049.png" alt="image-20230530160723049" style="zoom:50%;" />

此时，二极管处于阻断（off-state）的状态。

## Applied on forward-bias voltage

当PN结二极管两端施加（相对于PN方向）的正向偏置电压时，该电压与耗尽层的电场方向相反，因此降低了耗尽层两端的电压，使得耗尽层电场不足以抑制载流子扩散穿过PN结；**自由载流子（即P区的空穴以及N区的电子）可以在二极管内定向移动形成电流**：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230530164152998.png" alt="image-20230530164152998" style="zoom:50%;" />

此时，二极管处于导通状态（on-state），并且可以看到二极管两端具有一个正向导通压降（Forward conduction voltage drop）$v$。

另外，从上图中可以看出，虽然载流子可以穿过PN结进行定向移动，但是对于PN两个区而言，同样存在多子和少子：

- P区中，空穴为多子，电子为少子；
- N区中，电子为多子，空穴为少子；

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230530164031934.png" alt="image-20230530164031934" style="zoom: 33%;" />

许多过程都会导致区域内的少子失去它们的能量，使得它们无法继续运动，并且和区域内的多子复合（recombine）。复合的过程以一定的速率发生，因此我们可以视作少子会在复合前会持续一段有效寿命（effective lifetime）；并且随着少子扩散穿过PN结而运动，少子浓度会因为复合过程而逐渐降低：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230530205906093.png"/>

并且，==少子扩散的速率由浓度曲线的斜率决定 ??==。

<br>

上文中，无论是对于二极管阻断状态的分析还是对于导通状态的分析，都是在平衡状态下进行的。但实际上，在很多时候我们都希望分析二极管开断的暂态过程。因此，

# Shockley Diode Equation

肖特基二极管公式（Shockley diode equation，或称为二极管定律，diode law）描述了半导体二极管在**中等**恒流（moderate constant）正向偏置电压或反向偏置电压下的指数电流-电压关系 [5]：
$$
I_D=I_S(\mathrm{e}^{v/nV_T}-1)\label{eqDiode}
$$
其中：

- $I_D$为二极管电流；

- $I_S$为反向饱和电流（reverse-bias saturation current）；

- $v$是二极管两端的电压；

- $V_T$是热电压（thermal voltage）[6]，有$V_T=kT/q_e$，其中$k=1.38\times10^{-23}\mathrm{J/K}$为玻尔兹曼常数（Boltzmann’s constant），$T$是开氏温度（Kelvin temperature），$q_e$是基本电荷（elementary charge）。当温度为27摄氏度时，$V_T$近似为25.852 mV。

- $n$称为理想因子（ideal factor，AKA quality factor or emission coefficient）。通常情况下，理想因子从1到2取值（有时会更高），这取决于半导体的制造工艺和半导体材料。当$n=1$时，有：
  $$
  I_D=I_S(\mathrm{e}^{v/V_T}-1)\label{ideal}
  $$
  该公式就被称为肖特基理想二极管公式。

<br>

Wikipedia中给出了Shockley从费米能级（qusi-Fermi level）的角度出发的推导方式 [5]。

==反过来推导一下==，推出浓度的公式，很简单的。

稳态

二极管的正向导通压降大致取为0.7，绘制一下图像；



关于肖特基二极管公式，Erickson在书中也进行了推导。但是我觉得Erickson书中的推导的步骤好像是有些问题的，下面就简单梳理一下Erickson的推导方法（在施加正向偏置电压下的推导）：

（1）Erickson首先指出，在前向偏置电压的作用下，二极管是由电荷控制的（charge controlled）；PN结处耗尽层两端的电压$v$与耗尽层边缘的少子电荷浓度$p_s$（N区中的空穴浓度）和$n_s$（P区中的电子浓度）有关，之后给出了一个描述N区耗尽层右侧边缘空穴浓度$p_s$的公式：
$$
p_s(t)=Q_{s0}(\mathrm{e}^{\lambda v(t)}-1)\label{eq1}
$$
注：在这个公式中，$\lambda$表示上文所述的热电压；另外，Erickson并没有指出$Q_{s0}$的含义。
{: .notice--warning}

该公式表明，前向偏置电压越大，PN结的两端就有越多的少子；同时也表明，除非耗尽层边缘的少子减少，否则结电压不会减少。

（2）之后，将PN结一侧的少子电荷的总电荷量记作$q(t)$。一方面，少子电荷量$q(t)$会因为复合而减少，另一方面会因为正电流$i(t)$的作用而增大，因此有：
$$
\dfrac{\mathrm{d}q(t)}{\mathrm{d}t}=i(t)-\dfrac{q(t)}{\tau_L}\label{eq2}
$$
其中，$q/\tau_L$（单位是安培）是少子复合的速率。

（3）在动态平衡条件下，PN结两侧的少子电荷总量不会改变，因而有：
$$
\dfrac{\mathrm{d}q(t)}{\mathrm{d}t}=0
$$
根据式$\eqref{eq1}$和式$\eqref{eq2}$可以得到：
$$
i(t)=\dfrac{q(t)}{\tau_L}=\dfrac{Q_0}{\tau_L}(\mathrm{e}^{\lambda v(t)}-1)=I_0(\mathrm{e}^{\lambda v(t)}-1)\label{eq3}
$$
式$\eqref{eq3}$就是就是指数二极管公式（exponential diode equation）。

可以看到，式$\eqref{eq3}$和式$\eqref{ideal}$中热电压在指数中的位置是不一样的，一个是在分母上，一个是在分子上。我觉得这里是Erickson写错了，因为两个单位为伏特的量相乘并非是一个无量纲的系数。

但是，Erickson在整个推导过程以及书中后文想要强调的一点是正确的：即**指数二极管公式是描述平衡状态下的方程，在暂态条件下（例如在二极管开关瞬间）并不成立，尤其是在二极管关断的暂态过程中**。

<br>



- 电压$v(t)$由存储的少子电荷浓度决定，如式$\eqref{eq1}$所示。
- 为了降低电压，存储的少子电荷必须被移除。
- 二极管关断的暂态过程中的电流可以从式$\eqref{eq3}$推导出。
- 式$\eqref{eq2}$表明负电流可以主动减少存储的少子电荷。

下图展示了在二极管开断的暂态过程中，典型的二极管波形和存储的少子电荷浓度变化情况。

![image-20230529202835710](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230529202835710.png)

（1）当$t<t_0$时，二极管处于导通的状态，具有一个前向电压$v(t_0)>0$，导通的电流大小为$i(t_0)=I_{on}$。耗尽层从PN结处延伸了距离$x_0$，图4.31(b)中的灰色区域就表示$t=t_0$时的耗尽层。在$x>x_0$的范围内，少子的电荷分布如曲线$t=t_0$所示。~~这条曲线的斜率与少子扩散的速度成比例；$x=x_0$处的斜率与$I_{on}$成比例~~。

（2）当$t=t_0$时，外部电路开始调转外施电流$i(t)$的方向（外部电路决定了电流的变化速率$\mathrm{d} i/\mathrm{d}t$）；

（3）当$t=t_1$时，电流已经变为反向。总的存储的电荷量，即图4.31(b)中少子电荷浓度曲线下方的区域，已经逐渐减少，这种减少是由负电流和复合现象所导致的，如式$\eqref{eq2}$所示。耗尽层边缘的电荷浓度曲线的斜率是负数，PN结上电流是反向的==？==。由于其极性，耗尽层内的电场而不反对少子在反方向上的流动，并且此时的电流$i(t)$包括反向流过耗尽层的少子。由于$x=x_0$处少子电荷浓度仍然是非常重要的，式$\eqref{eq1}$表明耗尽层两端的电压仍然是正的。由于二极管方程的指数性质，当$t=t_1$时，电压$v(t)$仍然轻微地少于它的初始值，二极管仍然是前向偏置的。

（4）当$t=t_2$时，$x=x_0$处的少子电荷已经被完全移除。式$\eqref{eq1}$预测耗尽层两端的电压仍然是负的。然而，如图4.31(b)所示，当$x>x_0$时少子仍然存在。对于$t>t_2$，随着电压的负极性进一步增大，少子电荷持续被移除。当$t=t_3$时，耗尽层进一步延伸至$x_3$。最终，在$t=t_4$时，所有的少子电荷都被移除。此时，二极管阻断全反向电压$V_{off}$，没有实质性的反向电流。

二极管在反向恢复过程中的能量消耗，如图4.31(a)中的波形所预测的那样。对于$t<t_0$，流入二极管的能量为：
$$
p(t)=v(t)i(t)=V_FI_{on}
$$
其中$V_F$为二极管的前向压降，由式$\eqref{eq3}$给出。这是二极管的传导损失（conduction loss）。当$t=t_1$时，电流已经反向尽管电压仍然是正的；二极管则提供能量（但是在经典的converter中，这个能量损失在converter的其他地方，通常是在晶体管transistor中）

当$t_2<t<t_4$是，电压和电流都是负的，二极管再次消耗能量。除了由流过耗尽层的勺子电荷引起的负电流之外，额外的电流通过对耗尽层的电容进行充电而引起。电流的电容分量不构成二极管内的功率损耗。尽管如此，此时的功率损耗非常大，因为电压和电流都是非常大的，这部分的功率损失会导致二极管内大量的开关损失。我们很快可以看到，$t_0\sim t_4$整个时间段内，二极管内以及相关的开关晶体管的总的开关损失是非常大的。

$t_0\sim t_4$的整个时间段被称作反向恢复时间（reverse recovery time），记作$t_r$。电流$i(t)$波形中负数的部分所对应的电荷量被称作恢复电压（recovered charge），记作$Q_r$。这部分电荷包含通过负$i(t)$被主动去除的存储的少子电荷，也包含反向偏置耗尽层的容性电荷的变化量。

$t_2$时刻的负电流峰值是非常大的，有时会是开通电流$I_{on}$的数倍，这取决于二极管的性质。这会在反向恢复过程中导致非常大的瞬时功率耗散（instantaneous power dissipation），具有显著的$Q_r$大小。

如果开关的速度非常慢，则$Q_r$的幅值会降低；这导致更多的存储的少子电荷复合，而不是通过负$i(t)$被主动移除。如果$t_0<t<t_2$的时间段内的斜率$\mathrm{d}i/\mathrm{d}t$降低，则$Q_r$也会降低。

**柔和因数（softness factor）**$S$定义为：
$$
S=\dfrac{t_4-t_2}{t_2-t_0}
$$
如果一个二极管关断的暂态过程具有比较大的$S$，则这种二极管被称作**软恢复二极管（soft recovery diode）**；相反，如果二极管关断的暂态过程具有比较小的$S$，则这种二极管被称为**快速二极管（snappy diode）**。软恢复二极管的降低的$\mathrm{d}v/\mathrm{d}t$有助于相关的功率晶体管的开通过程，并且能够减少电磁干扰（electromagnetic interference）的产。半导体制造生可以通过设计来调整二极管的柔性因数$S$。

因此，二极管常见的指数$i-v$曲线只是一种平衡关系，在暂态条件下可能会违反这种关系。在开关开通以及关断的暂态过程中，电流会显著地偏移平衡状态的$i-v$曲线，这是因为存储的少子电荷的变化以及反向在反向偏置耗尽层中的变化。反向恢复时间$t_r$是移除二极管中的少子并使其锁住全施负电压（full applied negative voltage）所需的时间。在反向恢复过程中在二极管负向电流下的区域是恢复电荷$Q_r$。





<br>

**References**

[1] [Extrinsic semiconductor - Wikipedia](https://en.wikipedia.org/wiki/Extrinsic_semiconductor#N-type_semiconductors)

[2] [Electron hole - Wikipedia](https://en.wikipedia.org/wiki/Electron_hole).

[3] [P型半导体和N型半导体和PN结对外显什么电性？为什么？ - xxx旳的回答 - 知乎](https://www.zhihu.com/question/320324870/answer/2356696633).

[4] Erickson, Robert W., and Dragan Maksimovic. *Fundamentals of power electronics*. Springer Science & Business Media, 2007.

[5] [Shockley diode equation - Wikipedia](https://en.wikipedia.org/wiki/Shockley_diode_equation).

[6] [Boltzmann constant: thermal voltage - Wikipedia](https://en.wikipedia.org/wiki/Boltzmann_constant#The_thermal_voltage).





[p-n junction - Wikipedia](https://en.wikipedia.org/wiki/P–n_junction)





[The PN Junction Diode and Diode Characteristics - Video Tutorial (allaboutcircuits.com)](https://www.allaboutcircuits.com/video-tutorials/the-pn-junction-and-the-diode/).
