taking XXX as An Example



由于电路和系统中存在电感和电容，当电路中**激励源的频率变化**时，电路中的感抗、容抗将跟随频率变化，从而导致**电路的工作状态也跟随频率变化**。这种电路和系统的工作状态跟随频率而变化的现象，被称为电路和系统的**频率特性（frequency characteristic）**，又称为**频率响应（frequency response）**。通常采用单输入-单输出（一个激励变量-一个输出变量）的方式，在输入变量和输出变量之间建立函数关系，来描述电路的频率特性，这一函数称为电路和系统的**网络函数**。

注：下文仅对正弦稳态电路的频率特性进行分析。
{: .notice--primary}

电路在一个正弦电源激励下稳定时，各部分的相应都是同频率的正弦量，由正弦量的向量定义的网络函数为：
$$
H(\mathrm{j}\omega):=\dfrac{\dot{R}_k(\mathrm{j}\omega)}{\dot{E}_{sj}(\mathrm{j}\omega)}
$$
该式定义的网络函数是描述**正弦稳态**下响应与激励之间的一种关系。其中，$\dot{R}_k(\mathrm{j}\omega)$为输出端口$k$的相应，为电压向量$\dot{U}_k(\mathrm{j}\omega)$或电流向量$\dot{I}_k(\mathrm{j}\omega)$；$\dot{E}_{sj}(\mathrm{j}\omega)$为输入端口$j$的输入变量（正弦激励），为电压源相量$\dot{U}_{sj}(\mathrm{j}\omega)$或电流源相量$\dot{I}_{sj}(\mathrm{j}\omega)$。

网络函数不仅与电路的结构、参数值有关，还与输入、输出变量的类型以及端口对的相互位置有关。这就如同从不同的“窗口”来分析研究网络的频率特性，可以从不同角度寻找电路比较优越的频率特性和电路工作的最佳频率范围。**网络函数是网络性质的一种体现，与输入、输出幅值无关**。

网络函数$H(\mathrm{j}\omega)$是一个复数，它的频率特性分为两个部分。它的模值$\vert H(\mathrm{j}\omega)\vert$是两个正弦量的有效值（或幅值）的比值，它与频率的关系$\vert H(\mathrm{j}\omega)\vert\text{-}\omega$称为**幅频特性（amplitude frequency characteristic）**。$H(\mathrm{j}\omega)$的幅角$\varphi(\mathrm{j}\omega)=\arg[H(\mathrm{j}\omega)]$是两个同频正向量的相位差（又称为相移），$\varphi(\mathrm{j}\omega)\text{-}\omega$称为**相移特性（phase shift characteristic）**。幅频特性、相移特性与频率的关系，都可以在图上用曲线表示，称为网络的**频率响应曲线**，即幅频响应与相频响应曲线。

网络函数等于单位激励（$\dot{U}_{sj}$或$\dot{I}_{sj}$为1单位量）的响应。因此，一旦获得端口对的网络函数，也就能求得网络在任意正弦输入时的端口正弦响应，即：
$$
\dot{U}_k(\text{or }\dot{I}_{k})=H(\mathrm{j}\omega)\cdot\dot{U}_{sj}(\text{or }\dot{I}_{sj})
$$
<br>

如下图所示，有一个RLC串联电路，元件的值见标注：

==figure==

该RLC串联电路的输入阻抗$Z(\mathrm{j}\omega)$可以表示为：
$$
Z(\mathrm{j}\omega)=R+\mathrm{j}(\omega L-\dfrac1{\omega C})=3+\mathrm{j}(\omega4-\dfrac1{\omega5})
$$
相移特性为：
$$
\varphi(\mathrm{j}\omega)=\mathrm{arctan}(\dfrac{\omega4-\dfrac1{\omega5}}{3})
$$
幅频特性为：
$$
\vert Z(\mathrm{j}\omega)\vert=\dfrac{R}{\cos\varphi(\mathrm{j}\omega)}=\dfrac3{\cos(\mathrm{arctan}(\dfrac{\omega4-\dfrac1{\omega5}}{3}))}
$$

可以看到，由于串联电路中同时存在电感$L$和电容$C$，两者的频率特性不仅相反（感抗与$\omega$成正比，而容抗与$\omega$成反比），而且直接相减（电抗角相差180度）。因此，一定存在一个角频率$\omega_0$，使得感抗与容抗相互完全抵消，即$X(\mathrm{j}\omega_0)=0$（易求出$\omega_0=1/2\sqrt5$）。因此，阻抗$Z(\mathrm{j}\omega)$以$\omega_0=1/2\sqrt5$为中心，在全频域内随频率变动的情况可以分为三个频区：

- $\omega<1/2\sqrt5$（容性区）：此时$X(\mathrm{j}\omega)<0$，$\varphi(\mathrm{j}\omega)<0$，$\vert Z(\mathrm{j}\omega)\vert>R$，且有$\lim_{\omega\rightarrow0}\vert Z(\mathrm{j}\omega)\vert=\infty$；
- $\omega=1/2\sqrt5$（电阻性）：此时$X(\mathrm{j}\omega)=0$，$\varphi(\mathrm{j}\omega)=0$，$\vert Z(\mathrm{j}\omega)\vert=R$；
- $\omega>1/2\sqrt5$（感性区）：此时$X(\mathrm{j}\omega)>0$，$\varphi(\mathrm{j}\omega)>0$，$\vert Z(\mathrm{j}\omega)\vert>R$，且有$\lim_{\omega\rightarrow\infty}\vert Z(\mathrm{j}\omega)\vert=\infty$；

我们可以绘制出相应的相移特性和幅频特性的曲线：

![image-20230531212138329](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230531212138329.png)

注：绘图代码见附录A。
{: .notice--primary}

当$\omega=\omega_0$时，$X(\mathrm{j}\omega)=0$，电路的工作状况将出现一些重要的特征：

（1）$\varphi(\mathrm{j}\omega)=0$，所以此时$\dot{I}(\mathrm{j}\omega)$与$\dot{U}(\mathrm{j}\omega)$同向，工程上将电路的这一特殊状态定义为**谐振（resonance）**，由于是在RLC串联电路中发生的谐振，又称为串联谐振（series resonance）。由上述分析可知，谐振发生的条件为：
$$
\mathrm{Im}[Z(\mathrm{j}\omega)]=X(\mathrm{j}\omega_0)=\omega_0L-\dfrac1{\omega_0C}=0\\
$$
这只有在电感、电容同时存在时，上述条件才满足。由上式可知，电路发生谐振的角频率$\omega_0$和频率$f_0$为：
$$
\omega_0=\dfrac1{\sqrt{LC}},\ f_0=\dfrac1{2\pi\sqrt{LC}}
$$
可以看出，RLC串联电路的谐振频率只有一个，且仅与电路中L、C有关，与电阻R无关。

$\omega_0$（或$f_0$）称为电路的**固有频率**（或**自由频率**）。因此，**只有当输入信号$u_s$的频率与电路的固有频率$f_0$相同时，才能在电路中激起谐振**。如果电路中L、C可调，则可以改变电路的固有频率，此时RLC串联电路就具有选择任一频率谐振（**调谐**），或避开某一频率谐振（**失谐**）的性能；也可以利用串联谐振现象，判别输入的频率。

（2）$Z(\mathrm{j}\omega)=R$为最小值（极小值），电路在谐振时的电流$I(\mathrm{j}\omega)$为极大值（也是最大值），有：
$$
I(\mathrm{j}\omega_0)=\dfrac{U_s(\mathrm{j}\omega)}{R}
$$
这个极大值又称为**谐振峰**，这是RLC串联电路发生谐振的突出标志。当$u_s$的幅值不变时，谐振峰仅与电阻$R$有关，所以，电阻R时唯一能控制和调节谐振峰的电路元件，==从而控制谐振时的电感和电容的电压及其储能状态==。==。。。在下一节着重分析==

（3）电抗电压$U_X(\mathrm{j}\omega)=0$，即有：
$$
\begin{split}
\dot{U}(\mathrm{j}\omega_0)&=\mathrm{j}(\omega_0L-\dfrac1{\omega_0C})\dot{I}(\mathrm{j}\omega_0)\\
&=\mathrm{j}\dfrac{\omega_0L}{R}\dot{U}_s(\mathrm{j}\omega_0)-\mathrm{j}\dfrac1{\omega_0CR}\dot{U}_s(\mathrm{j}\omega_0)\\
&=\dot{U}_L(\mathrm{j}\omega_0)+\dot{U}_C(\mathrm{j}\omega_0)=0
\end{split}
$$
因此，L、C串联端口相当于短路，但$\dot{U}_L(\mathrm{j}\omega_0)$、$\dot{U}_C(\mathrm{j}\omega_0)$分别不等于零，两者模值相等且反相，相互完全抵消。根据这一点，串联谐振又称为**电压谐振**。此外，工程上将上式中的比值$\omega_0L/R=1/\omega_0CR$定义为谐振电路的**品质因数**$Q$（称$Q$值），即：
$$
Q:=\dfrac{\omega_0L}R=\dfrac1{\omega_0CR}=\dfrac1R\sqrt{\dfrac{L}{C}}\label{eqQ}
$$
$Q$值不仅综合反映了电路中三个参数对谐振状态的影响，而且也是分析和比较谐振电路频率特性的一个重要的辅助参数。用$Q$值表示$U_L(\mathrm{j}\omega)$和$U_C(\mathrm{j}\omega)$为：
$$
U_L(\mathrm{j}\omega)=U_C(\mathrm{j}\omega)=QU_s(\mathrm{j}\omega_0)\label{eq3}
$$
显然，**当$Q>1$时，电感和电容两端将分别出现比$U_s(\mathrm{j}\omega_0)$高$Q$倍的过电压**。在高电压的电路系统中（如电力系统），这种过电压非常高，可能会危及系统的安全，必须采取必要的防范措施。但在低电压的电路系统中，如无线电接收系统中，则要利用谐振时出现得过电压来获得较大的输出信号。

$Q$值可通过测定谐振时的电感或电容电压求得，即：
$$
Q=\dfrac{U_C({\mathrm{j}\omega_0)}}{U_S({\mathrm{j}\omega_0)}}=\dfrac{U_L({\mathrm{j}\omega_0)}}{U_S({\mathrm{j}\omega_0)}}
$$
而谐振时点入R的端电压$U_R({\mathrm{j}\omega_0)}$为：
$$
\dot{U}_R({\mathrm{j}\omega_0)}=\dot{U}_S({\mathrm{j}\omega_0)}
$$
这也是**谐振峰**。这表明谐振时，电阻R上缴获的全额的输入电压。

根据上述分析可知，RLC串联电路中的三个元件都可以作为信号的输出口，**只要参数选配得当，输出信号的幅值就能大于等于输入信号的幅值**。

（4）$Q(\mathrm{j}\omega_0)=0$，即电路吸收的无功功率等于零，有：
$$
Q(\mathrm{j}\omega_0)=Q_L(\mathrm{j}\omega_0)+Q_C(\mathrm{j}\omega_0)=\omega LI^2(\mathrm{j}\omega_0)-\dfrac1{\omega_0C}I^2(\mathrm{j}\omega_0)=0
$$
上式表明，电感吸收的无功功率等于电容发出的无功功率，但各自不等于零。电路中储存的**电磁能**在L与C之间**以两倍于谐振频率的频率**做周期性的交换，相互完全补偿，自成独立系统，与外源无能量交换。

储存的电磁能的总和为一常数，可根据$i$或$u_S$的最大值求得，即：
$$
\begin{split}
W(\mathrm{j}\omega_0)&=W_L(\mathrm{j}\omega_0)+W_C(\mathrm{j}\omega_0)=\dfrac12LI^2_m(\mathrm{j}\omega_0)=\dfrac12CU^2_{C_m}(\mathrm{j}\omega_0)\\
\end{split}
$$
进一步根据式$\eqref{eq3}$有：
$$
\begin{split}
W(\mathrm{j}\omega_0)&=\dfrac12CU^2_{C_m}(\mathrm{j}\omega_0)\\
&=\dfrac12C(\sqrt2U_c(\mathrm{j}\omega_0))^2\\
&=\dfrac12C(\sqrt2QU_S(\mathrm{j}\omega_0))^2\\
&=CQ^2U_S^2(\mathrm{j}\omega_0)
\end{split}
$$
同时，电压源$u_s$只发出有功功率$P(\mathrm{j}\omega_0)$，供电阻R消耗，即：
$$
\bar{S}_S(\mathrm{j}\omega_0)=RI^2(\mathrm{j}\omega_0)=\dfrac{U_S^2(\mathrm{j}\omega_0)}{R}=P(\mathrm{j\omega_0})
$$
电路的$Q$值也可以根据谐振时电感或电容的无功功率和电阻消耗的有功功率$P(\mathrm{j}\omega_0)$的比值表示：
$$
Q=\dfrac{\omega_0LI^2(\mathrm{j}\omega_0)}{RI^2(\mathrm{j}\omega_0)}=\dfrac{\vert Q_L(\mathrm{j}\omega_0)\vert}{P(\mathrm{j}\omega_0)}=\dfrac{\vert Q_C(\mathrm{j}\omega_0)\vert}{P(\mathrm{j}\omega_0)}
$$
<br>

## Taking a break ...

总结计算Q的方式；



<br>

在上一节，主要分析了RLC串联电路在谐振状态下的特性；并且在分析频率特性时，采用的是“从端口看进去”的方式，是从阻抗的角度分析电路的频率特性。但实际上，我们可以通过其他不同的“窗口”，即使用不同的**网络函数**：
$$
\dfrac{\dot{U}_R(\mathrm{j}\omega)}{\dot{U}_S(\mathrm{j}\omega)},\ \dfrac{\dot{U}_L(\mathrm{j}\omega)}{\dot{U}_S(\mathrm{j}\omega)},\ \dfrac{\dot{U}_C(\mathrm{j}\omega)}{\dot{U}_S(\mathrm{j}\omega)}
$$
分析当输入信号$u_S$的幅值不变而$\omega$变动时电路的频率特性。这些网络的频率特性都被统称为电路的**频率响应（频响）**。

在分析频率响应之前首先需要说明的是，在后文中，为了便于比较不同参数的RLC串联电路的频率响应之间在性能上的差异，我们采用实际角频率$\omega$与谐振点处角频率$\omega_0$作为横坐标$\eta$，即有关系式：
$$
\dfrac{\omega}{\omega_0}=\eta,\ \omega=\eta\omega_0
$$
这样，所有的RLC电路都在$\eta=1$处谐振，我们就可以在同一个相对尺度之下比较相互频率特性的差异，这一共同的尺度也表示各谐振电路的**偏谐程度**（即偏离谐振点的程度）。

并且在实际中，由于不同的RLC电路输入幅值也是不同的，因此在绘制频率响应曲线时，纵坐标的度量也需要除以谐振点的输入电压得到一个相对的尺度，但是下文中为了简化分析，我们就假设电路的输入电压幅值都是单位值。

## Frequency response $\dot{U}_R(\mathrm{j}\eta)$

当使用电阻电压$\dot{U}_R(\mathrm{j}\eta)$作为输出变量时，其对应的网络函数$H_R(\mathrm{j}\eta)$可以表示为：
$$
\begin{split}
H_R(\mathrm{j}\eta)&=\dfrac{\dot{U}_R(\mathrm{j}\omega)}{\dot{U}_S(\mathrm{j}\omega)}=\dfrac{R}{R+\mathrm{j}(\omega L-\dfrac1{\omega C})}\\
&=\dfrac{1}{1+\mathrm{j}(\eta\dfrac{\omega_0 L}{R}-\dfrac1{\eta\omega_0 CR})}\\
\end{split}
$$
根式$\eqref{eqQ}$，有：
$$
H_R(\mathrm{j}\eta)=\dfrac1{1+\mathrm{jQ(\eta-\dfrac{1}{\eta})}}
$$
进一步可以得到：
$$
\begin{split}
H_R(\mathrm{j}\eta)&=\dfrac{1-\mathrm{j}Q(\eta-\dfrac1\eta)}{1+Q^2(\eta-\dfrac1\eta)^2}\\
&=\dfrac{\sqrt{1+Q^2(\eta-\dfrac1\eta)^2}}{1+Q^2(\eta-\dfrac1\eta)^2}\angle\mathrm{arctan}\big(-Q(\eta-\dfrac1\eta)\big)\\
&=\dfrac1{\sqrt{1+Q^2(\eta-\dfrac1\eta)^2}}\angle\mathrm{arctan}\big(-Q(\eta-\dfrac1\eta)\big)
\end{split}\label{HR}
$$
最终，我们可以得到频率响应：
$$
\begin{split}
\varphi(\mathrm{j}\eta)&=-\mathrm{arctan}\big[Q(\eta-\dfrac1\eta)\big]\\
\big\vert H_R(\mathrm{j}\eta)\big\vert&=\dfrac1{\sqrt{1+Q^2(\eta-\dfrac1\eta)^2}}
\end{split}\label{eqHR}
$$
可以看到，**不同参数的RLC串联电路在频响上的差异，可以通过各自的$Q$值体现**。我们可以绘制出两个不同的$Q$值所对应的频响曲线：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230601192150927.png" alt="image-20230601192150927" style="zoom:50%;" />

```matlab
clc,clear,close all

% Set Q values
Q1 = 10;
Q2 = 3;

% Calculate phase shift and amplitude frequency characteristic with
% different Q values
eta = linspace(0.01,2,1e3);
phi = @(Q,eta) -atan(Q*(eta-1./eta));
HR = @(Q,eta) 1./sqrt(1+Q^2*(eta-1./eta).^2);
phi1 = phi(Q1,eta)/(2*pi)*360; % convert rad/s to degree
phi2 = phi(Q2,eta)/(2*pi)*360; % convert rad/s to degree
HR1 = HR(Q1,eta);
HR2 = HR(Q2,eta);

% Plot phase shift characteristic with different Q values
figure('Units','pixels','Position',[717,329.67,1116,420])
tiledlayout(1,2)
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,phi1,'LineWidth',1.5, ...
    'Color',[249,82,107]/255,'DisplayName',['$Q_1=$',num2str(Q1)])
plot(eta,phi2,'LineWidth',1.5, ...
    'Color',[7,84,213]/255,'DisplayName',['$Q_2=$',num2str(Q2)])
legend('Interpreter','latex')
xlabel('$\eta$','Interpreter','latex')
ylabel('$\varphi(\mathrm{j}\eta)\ ({}^\circ)$','Interpreter','latex')
yticks(-90:30:90)
title('Phase shift characteristic')

% Plot amplitude frequency characteristic with different Q values
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,HR1,'LineWidth',1.5, ...
    'Color',[249,82,107]/255,'DisplayName',['$Q_1=$',num2str(Q1)])
plot(eta,HR2,'LineWidth', ...
    1.5,'Color',[7,84,213]/255,'DisplayName',['$Q_2=$',num2str(Q2)])
xline(1,'Color',[0.5,0.5,0.5],'LineWidth',1.5,'DisplayName','Resonance')
legend('Interpreter','latex')
xlabel('$\eta$','Interpreter','latex')
ylabel('$U_R(\mathrm{j}\eta)$','Interpreter','latex')
title('Amplitude frequency characteristic')
```

我们可以看到，不同$Q$值所对应的RLC电路具有以下特点和差异：

（1）它们都在谐振点$\eta=1$处出现峰值，在其邻域$\eta=1+\Delta\eta$内都有较大幅度的输出信号，这表明RLC串联电路都具有**在全频域内选择各自谐振信号**的性能，工程上将这一性能称为**“选择性”**；

（2）当信号的频率偏离谐振频率后（$\eta\ne1$），输出信号的幅度都从峰值开始下降，表明**电路对非谐振的信号具有抑制能力（**简称**抑非能力**）。根据式$\eqref{HR}$，电路的抑非能力取决于下面的比值：
$$
\Big\vert Q(\eta-\dfrac1\eta)\Big\vert_{\eta\ne1}=\Big\vert\dfrac{X(1+\Delta\eta)}{R}\Big\vert\ \Big(\text{where }R=Z(\mathrm{j}\omega_0)\Big)
$$
该比值为：**信号偏离谐振频率后，电路电抗的增量（因为谐振时$X(\mathrm{j}1)=0$）与谐振时阻抗的比值**。它与电路的$Q$值成正比，$Q$值越大，该比值越大，电抗的相对增量就越大，电路的抑非能力就越强；这也说明，**电路的抑非能力主要是由非零电抗引起的**。

从曲线中可以看出，由于$Q_1>Q_2$，$Q_1$值所代表的电路的抑非能力强于$Q_2$值所代表的电路，因此$Q_1$值曲线急速下降，十分陡峭，而$Q_2$值曲线下降很慢，顶部的变化显得比较平缓。曲线的整体形状显示了电路在抑非能力上的差异，并且这一差异在谐振点附近尤为突出。当信号的频率远离谐振频率后，左侧趋同于RC电路，右侧趋同于RL电路，彼此的差异逐渐缩小直至趋于消失。

（3）电路在全频域内都有信号的输出，但只有在谐振点附近的邻域（$\eta=1+\Delta\eta$）内幅度较大，具有工程实际应用价值。因此，工程上设定了一个输出幅度指标来界定频率范围，划分出谐振电路的**通频带（通带）**和**阻带**。

通带限定的频域范围称为**带宽**，记为$BW$。工程上按照下面的式子决定通带的$BW$，即：
$$
\vert H_R(\mathrm{j}\eta)\vert\ge\dfrac1{\sqrt2}=0.707(\text{设定的指标})
$$
当上式取等号时，根据式$\eqref{eqHR}$有：
$$
\begin{split}
&\dfrac1{\sqrt{1+Q^2(\eta-\dfrac1\eta)^2}}=\dfrac1{\sqrt{2}}\\
\Rightarrow&Q(\eta-\dfrac1\eta)=\pm1
\end{split}
$$
于是可以求得两个频率点（一共四个解，舍去了两个负解）：
$$
\eta_1=-\dfrac1{2Q}+\sqrt{(\dfrac1{2Q})^2+1}<1,\ \omega_1=\eta_1\omega_0\ (下界)
$$

$$
\eta_2=\dfrac1{2Q}+\sqrt{(\dfrac1{2Q})^2+1}>1,\ \omega_2=\eta_2\omega_0\ (上界)
$$

因此，通频带$BW$为：
$$
BW=\omega_2-\omega_1=\dfrac{\omega_0}{Q}\label{eqBW}
$$
==绘制图像==

由上述所界定的通带位于频域中段，呈带状形，所以网络函数$H_R(\mathrm{j}\eta)$称为**带通函数**。通带的频率范围为：
$$
\omega_1\le\omega\le\omega_2
$$
$\omega_1$、$\omega_2$分别位于$\omega_0$两侧，因此$\omega_0$又常称为中心**频率**。

工程上对于$\omega_1$、$\omega_2$常另有称为，如**$3\ \mathrm{dB}$点**（因为按照分别的定义，此电压的比值相当于$20\log_{10}0.707=-3\ \mathrm{dB}$，即电压下降了$3\ \mathrm{dB}$），**半功率点**（因为此时电阻上的功率等于谐振时电阻功耗的一半），并有$\varphi(\mathrm{j}\eta_1)=45^\circ$，$\varphi(\mathrm{j}\eta_2)=-45^\circ$。

工程上也常用通带的带宽$BW$来比较和评价电路的性能。根据式$\eqref{eqBW}$，$BW$与$Q$值成反比，因而有：

- $Q$值越大，$BW$越窄，电路的选择性越好，抑非能力越强；
- $Q$值越小，$BW$越宽，电路选择性能越差，但带宽包含的信号多，信号流失少，有利于减少信号的失真。

上述这两种情况都有实际的工程应用价值。

## Frequency response $\dot{U}_L(\mathrm{j}\eta)$ and $\dot{U}_C(\mathrm{j}\eta)$

分别以电感电压$\dot{U}_C(\mathrm{j}\eta)$和电容电压$\dot{U}_L(\mathrm{j}\eta)$为输出变量的网络函数$H_C(\mathrm{j}\eta)$、$H_L(\mathrm{j}\eta)$分别为：
$$
\begin{split}
H_C(\mathrm{j}\eta)&=\dfrac{-\mathrm{j}\dfrac1{\omega C}}{R+\mathrm{j}(\omega L-\dfrac1{\omega C})}\\
&=\dfrac{-\mathrm{j}}{\omega CR+\mathrm{j}(\omega^2LC-1)}\\
&=\dfrac{-\mathrm{j}}{\eta\omega_0CR+\mathrm{j}(\eta^2\omega_0^2LC-1)}\\
&=\dfrac{-\mathrm{j}}{\eta\dfrac1Q+\mathrm{j}(\eta^2-1)}\\
&=\dfrac{-\mathrm{j}Q}{\eta+\mathrm{j}Q(\eta^2-1)}
\end{split}
$$

$$
\begin{split}
H_L(\mathrm{j}\eta)&=\dfrac{\mathrm{j}\omega L}{R+\mathrm{j}(\omega L-\dfrac1{\omega C})}\\
&=\dfrac{\mathrm{j}\omega^2 LC}{\omega CR+\mathrm{j}(\omega^2LC-1)}\\
&=\dfrac{\mathrm{j}\eta^2\omega_0^2LC}{\eta\omega_0CR+\mathrm{j}(\eta^2\omega_0^2LC-1)}\\
&=\dfrac{\mathrm{j}\eta^2}{\dfrac\eta Q+\mathrm{j}(\eta^2-1)}\\
&=\dfrac{\mathrm{j}Q}{\dfrac1\eta+\mathrm{j}Q(1-\dfrac1{\eta^2})}
\end{split}
$$

进一步可以推出：
$$
\begin{split}
H_C(\mathrm{j}\eta)&=\dfrac{-\mathrm{j}Q}{\eta+\mathrm{j}Q(\eta^2-1)}\\
&=\dfrac{-\mathrm{j}Q(\eta-\mathrm{j}Q(\eta^2-1))}{\eta^2+Q^2(\eta^2-1)^2}\\
&=\dfrac{-Q^2(\eta^2-1)-\mathrm{j}Q\eta}{\eta^2+Q^2(\eta^2-1)^2}\\
&=\dfrac{\sqrt{Q^4(\eta^2-1)^2+Q^2\eta^2}}{\eta^2+Q^2(\eta^2-1)^2}\angle\mathrm{arctan}(\dfrac{-\eta}{Q(\eta^2-1)})
\end{split}
$$

$$
\begin{split}
H_L(\mathrm{j}\eta)&=\dfrac{\mathrm{j}Q}{\dfrac1\eta+\mathrm{j}Q(1-\dfrac1{\eta^2})}\\
&=\dfrac{\mathrm{j}Q(\dfrac1\eta-\mathrm{j}Q(1-\dfrac1{\eta^2}))}{\dfrac1{\eta^2}+Q^2(1-\dfrac1{\eta^2})^2}\\
&=\dfrac{Q^2(1-\dfrac1{\eta^2})+\mathrm{j}Q\dfrac1\eta}{\dfrac1{\eta^2}+Q^2(1-\dfrac1{\eta^2})^2}\\
&=\dfrac{\sqrt{Q^4(1-\dfrac1{\eta^2})^2+Q^2\dfrac1{\eta^2}}}{\dfrac1{\eta^2}+Q^2(1-\dfrac1{\eta^2})^2}\angle\mathrm{arctan}(\dfrac{\eta}{Q(\eta^2-1)})
\end{split}
$$

当$Q$值分别取1.1和1.5时，$H_C(\mathrm{j}\eta)$和$H_L(\mathrm{j}\eta)$所对应的频响曲线为：

```matlab
clc,clear,close all

% Set Q values
Q1 = 1.5;
Q2 = 1.1;

% Calculate phase shift and amplitude frequency characteristic with
% different Q values
eta = linspace(0.01,2,1e3);
phiC = @(Q,eta) atan(-eta./(Q*(eta.^2-1)));
HC = @(Q,eta) sqrt(Q^4*(eta.^2-1).^2+Q^2*eta.^2)./(eta.^2+Q^2*(eta.^2-1).^2);
phiC1 = phiC(Q1,eta)/(2*pi)*360; % convert rad/s to degree
phiC2 = phiC(Q2,eta)/(2*pi)*360; % convert rad/s to degree
HC1 = HC(Q1,eta);
HC2 = HC(Q2,eta);

phiL = @(Q,eta) atan(eta./(Q*(eta.^2-1)));
HL = @(Q,eta) sqrt(Q^4*(1-1./eta.^2).^2+Q^2./eta.^2)./(1./eta.^2+Q^2*(1-1./eta.^2).^2);
phiL1 = phiL(Q1,eta)/(2*pi)*360; % convert rad/s to degree
phiL2 = phiL(Q2,eta)/(2*pi)*360; % convert rad/s to degree
HL2 = HL(Q2,eta);
HL1 = HL(Q1,eta);

% Plot phase shift characteristic with different Q values
figure('Units','pixels','Position',[717,329.67,1116,420])
tiledlayout(1,2)
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,phiC1,'--','LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$C: Q_1=$',num2str(Q1)])
plot(eta,phiL1,'LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$L: Q_1=$',num2str(Q1)])
plot(eta,phiC2,'--','LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$C: Q_2=$',num2str(Q2)])
plot(eta,phiL2,'LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$L: Q_2=$',num2str(Q2)])
xline(1,'Color',[0.5,0.5,0.5],'LineWidth',1.5,'DisplayName','Resonance')
legend('Interpreter','latex','Location','southeast')
xlabel('$\eta$','Interpreter','latex')
ylabel('$\varphi(\eta)\ ({}^{\circ})$','Interpreter','latex')
yticks(-90:30:90)
title('Phase shift characteristic')

% Plot amplitude frequency characteristic with different Q values
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(eta,HC1,'--','LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$C: Q_1=$',num2str(Q1)])
plot(eta,HL1,'LineWidth',1.5,'Color',[249,82,107]/255,'DisplayName',['$L: Q_1=$',num2str(Q1)])
plot(eta,HC2,'--','LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$C: Q_2=$',num2str(Q2)])
plot(eta,HL2,'LineWidth',1.5,'Color',[7,84,213]/255,'DisplayName',['$L: Q_2=$',num2str(Q2)])
xline(1,'Color',[0.5,0.5,0.5],'LineWidth',1.5,'DisplayName','Resonance')
legend('Interpreter','latex','Location','southeast')
xlabel('$\eta$','Interpreter','latex')
ylabel('$U_R(\mathrm{j}\eta)/U_S(\mathrm{j}1)$','Interpreter','latex')
title('Amplitude frequency characteristic')
```

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230602092612396.png" alt="image-20230602092612396" style="zoom: 67%;" />

可以看到，由于$\dot{U}_C(\mathrm{j}\eta)$滞后$\dot{U}_R(\mathrm{j}\eta)$ $90^\circ$，而$\dot{U}_L(\mathrm{j}\eta)$超前$\dot{U}_R(\mathrm{j}\eta)$ $90^\circ$，相移特性曲线也表现出相似的特点。

但是使用上文所使用的呈现方式并非那么明显XXX（这涉及到==arctan函数==的性质）

比较简单，因此后文就不再分析$H_C(\mathrm{j}\eta)$和$H_L(\mathrm{j}\eta)$的相移特性，而主要分析它们的幅频特性。











<br>
