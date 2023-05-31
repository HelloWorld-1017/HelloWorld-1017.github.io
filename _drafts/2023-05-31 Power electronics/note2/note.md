电力电子技术领域（the filed of power electronics）关注的事情之一就是使用电子设备处理电力（electrical power），其中的关键要素就是开关变换器（switching converter），如下图所示：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531110244115.png" alt="image-20230531110244115" style="zoom:50%;" />

通常而言，开关转换器包含功率输入端口、控制输入端口和功率输出端口。原始输入功率按照控制输入的规定进行处理，产生调节后的输出功率。这一过程能够实现一些基本的功能。

- 在DC-DC变换器（dc-dc converter）中，DC输入电压转换为具有更高或者更低幅值的DC输出电压，这一过程可能会调转电压的极性，或者需要隔离输入电压和输出电压的地参考电位；
- 在AC-DC整流器（ac-dc rectifier）中，AC输入电压则可以被整流为DC输出电压。在这个过程中，可以控制DC输出电压和（或）AC输入电流波形；
- 在DC-AC逆变器（dc-ac inversion）中，DC输入电压可以被转换为可控幅值或可控频率的AC输出电压；
- 在AC-AC循环转换（ac-ac cycloconversion）中，AC输入电压可以被转换为可控幅值或可控频率的AC输出电压。

在以上的过程中，**控制（control）**的部分是不可或缺的；从下图可以看到，控制器模块是任何功率处理系统的组成部分：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531113125676.png" alt="image-20230531113125676" style="zoom:50%;" />

<br>

在任何的功率处理应用中，高效率（high efficiency）都是必不可少的。提高效率能够节省费用，也能够节约能源，但是提高效率的首要原因并不是这些，而是：**建造能够产生大量输出功率的低效转换器是非常不切实际的**。下面就来解释这一点。

若转换器的输出功率为$P_{out}$，输入功率为$P_{in}$，则转换器的效率$\eta$定义为两者之比：
$$
\eta=\dfrac{P_{out}}{P_{in}}\label{eq0}
$$
转换器的损失$P_{loss}$定义为：
$$
P_{loss}=P_{in}-P_{loss}
$$
则输出功率与损失功率之比$Q$为：
$$
Q=\dfrac{P_{out}}{P_{loss}}=\dfrac\eta{1-\eta}\label{eq1}
$$
$Q$是功率转换器质量的一个基本度量。

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531122949468.png" alt="image-20230531122949468" style="zoom:50%;" />

```matlab
clc,clear,close all

eta = linspace(0.3,1,1e3);

hold(gca,'on')
box(gca,'on')
grid(gca,'on')
plot((1-eta)./eta,eta, ...
    'Color','k','LineWidth',1.5)
ylim([0,1])
xlabel('$1/Q\ (P_{loss}/P_{out})$','Interpreter','latex')
ylabel('$\eta$','Interpreter','latex')
```

损失功率$P_{loss}$会转换为转换器电路元件的热量，并且必须使用冷却系统（cooling system）来散掉这些热量。

在许多应用中，**冷却系统去除这些热量的能力限制了转换器的最大输出功率**。如果损失的功率非常多，则就需要一个大的并且昂贵的冷却系统，并且转换系统中的电路元件会工作在非常高的温度条件下，系统的稳定性就会降低。因此，提高转换器的效率就对于获得更高的功率输出非常关键，其中一方面就体现在提高效率能够相对减小冷却系统的尺寸和重量。

<br>

各种传统的电路元件如下图所示：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531123136812.png" alt="image-20230531123136812" style="zoom: 67%;" />

可用的电路器件包括：

- 电阻元件（resistive elements）；
- 电容元件（capacitive elements）；
- 磁性元件（magnetic devices），包括电感（inductor）和变压器（transformer）；
- 工作在**线性模式**的半导体元件（semiconductor devices operated in the switched mode），例如A类或B类放大器（such as class A or class B amplifiers）；
- 工作在**开关模式**的半导体器件（semiconductor devices operated in the switched mode），例如在逻辑器件中要么工作在完全导通或者完全开断状态的晶体管（such as in logic devices where transistors operate in either the fully on or fully off states）；

在传统的信号处理应用中，效率并不是首要考虑的事情，通常会尽可能避免使用磁性元件，因为磁性元件的体积较大且难以集成化。相反，在开关转换器中，电容和磁性元件都是非常重要的，因为在理想状态下它们都不消耗功率；而电阻元件和工作在线性模式的的半导体器件则应该避免使用。并且，开关转换器中也经常使用工作在开关模式的半导体器件：当半导体器件工作在阻断状态下，其电流为零，因此功率损耗（power dissipation）为零；当工作在开通状态下，其导通压降非常小，因而功率耗散也非常小。因此总体而言，半导体器件的功率耗散是比较低的。总之，**电容元件、电感元件以及开关模式的半导体器件非常适合于构建高效的转换器**。

<br>

假设现在需要构建一个简单的DC-DC转换器，如下图所示：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531130758229.png" alt="image-20230531130758229" style="zoom: 67%;" />

输入电压为100 V，我们期望将其转换为50 V的输出电压作用在5 Ω的电阻负载上，DC负载电流为10 A。

（1）根据电路的知识，我们可以简单地使用电阻元件来实现这一要求：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531131051411.png" alt="image-20230531131051411" style="zoom: 67%;" />

转换器仅仅由一个可变电阻（variable resistor）组成，将可变电阻的值调整至5 Ω就可以实现期望的DC-DC转换功能。但是，根据简单的功率计算可以得到：
$$
P_{in}=1000\ \mathrm{W},\ P_{out} = 500\ \mathrm{W},\ P_{loss}=500\ \mathrm{W}
$$
这个转换器的效率仅为50%。

（2）第二种方法是使用线性模式功率晶体管（linear-mode power transistor）来实现：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531131754099.png" alt="image-20230531131754099" style="zoom: 67%;" />

这种实现方式被称为线性串联调节器（the linear series-pass regulator）。线性模式功率晶体管的基电流（base current）有反馈系统（feedback system）控制，使得其可以输出期望的输出电压。

这个电路中，线性模式功率晶体管的功率损耗同样大概在500 W。因此，线性串联调节器通常只应用于只有几瓦特的低功率水平系统中。

（3）第三种方式是使用SPDT开关（single-pole double-throw）开关实现：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531133821118.png" alt="image-20230531133821118" style="zoom: 67%;" />

当开关的位置位于位置1时，开关输出的电压$v_s(t)$等于$V_g$，等于100 V；当开关的位置位于位置2时，开关输出的电压$v_s(t)$等于0。SPDT开关的位置周期性变化，使得开关的输出电压$v_s(t)$是一个频率为$f_s$（对应周期为$T_s=1/f_s$）的方波（rectangular waveform）：

![image-20230531134258807](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531134258807.png)

其中，**占空比（duty cycle）**$D$（$0\le D\le1$）定义为周期$T$内开关位于位置1的时间比例。在实际中，SPDT开关的功能通常使用开关模式的半导体器件实现。

SPDT开关改变了电压的DC分量。根据傅里叶分析，**周期波形的DC分量等于波形的平均值**。因此，开关输出电压$v_s(t)$的DC分量为：
$$
V_s=\dfrac1{T_s}\int_0^{T_s}v_s(t)\mathrm{d}t=DV_g
$$
因此，我们可以通过调整占空比$D$来改变开关输出的DC电压：将$D$调整为0.5，就可以使得转换器能够将输入电压$V_g=100\ \mathrm{V}$转换50 V的输出电压。

SPDT开关的优势是：在理想状态下，开关的功率耗散为零。

除了我们期望得到的DC分量$V_s$，开关的输出波形$v_s(t)$同样包含与开关频率相关的不期望的谐波（harmonics）。在大多数应用中，这些谐波必须被移除，以使得输出电压$v(t)$等于DC分量$V=V_s$。我们可以使用一个LC低通滤波器来实现这一点：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531135739216.png" alt="image-20230531135739216" style="zoom:67%;" />

当转折频率（comer frequency）$f_0$充分小于开关频率$f_s$，则滤波器基本上只能通过$v_s$的DC分量。如果开关、电感、电容都是理想的，则这个DC-DC转换器的效率能够达到100%。

进一步，我们在上面的电路中添加一个控制系统使得可以调整输出电压：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531141120994.png" alt="image-20230531141120994" style="zoom:67%;" />

由于输出电压是开关占空比的函数，控制系统的作用就是改变占空比以改变输出电压。另外，上图也展示了如何使用开关模式的半导体期间实现SPDT的功能。

从一开始的使用理想SPDT开关，到添加滤波器、添加控制系统，这整个改进的流程最终构建起一个用于降低DC电压的**降压转换器**（**buck converter**）。

<br>

与buck转换器相反，下图展示了用于升高DC电压的**升压转换器**（**boost converter**）：

![image-20230531141834382](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531141834382.png)

与buck电路相反，boost电路中电感和SPDT的位置对调。boost电路可以产生比输入电压更高的输出电压。通常，使用一个包含嵌入在电抗元件网络中的（embedded within a network of reactive elements）开关设备的转换器都能够将任意给定输入电压转换至任意期望的输出电压值：

![image-20230531142439664](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230531142439664.png)

<br>

