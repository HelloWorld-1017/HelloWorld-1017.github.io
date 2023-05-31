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
Q:=\dfrac{\omega_0L}R=\dfrac1{\omega_0CR}=\dfrac1R\sqrt{\dfrac{L}{C}}
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

上一节是从整个端口看进去的；分析了阻抗的频率响应；







<br>

# Appendix

## Appendix A

```matlab
clc,clear,close all

% Set elements parameters
R = 3;
L = 4;
C = 5;

% Solve omega_0
syms omega0
omega0 = solve(omega0*L-1/(omega0*C)==0,omega0); % 1/(2*sqrt(5))
omega0 = double(omega0(omega0>0));

% Calculate Phase shift characteristic and Amplitude frequency characteristic
omega = linspace(0.01,1,1e3);
phi = atan((omega*L-1./(omega*C))/R);
Z = R./cos(phi);
[ZMin,ZMinPos] = min(Z);

% Plot Phase shift characteristic and Amplitude frequency characteristic
figure('Units','pixels','Position',[717,329.67,1116,420])
tiledlayout(1,2)
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(omega,phi,'LineWidth',1.5,'Color','k','DisplayName','$\varphi(\mathrm{j}\omega)$')
xline(omega0,'--','LineWidth',1.5,'Color',[0.5,0.5,0.5],'HandleVisibility','off')
scatter(omega0,0,'filled','Color','r','DisplayName','$\omega_0$')
xlabel('$\omega$','Interpreter','latex')
ylabel('$\varphi(\mathrm{j}\omega)$','Interpreter','latex')
title('Phase shift characteristic')
legend('Interpreter','latex','Location','best')
nexttile
hold(gca,'on'),grid(gca,'on'),box(gca,'on')
plot(omega,Z,'LineWidth',1.5,'Color','k','DisplayName','$|Z(\mathrm{j}\omega)|$')
xline(omega0,'--','LineWidth',1.5,'Color',[0.5,0.5,0.5],'HandleVisibility','off')
scatter(omega(ZMinPos),ZMin,'filled','Color','r','DisplayName','$\omega_0$')
xlabel('$\omega$','Interpreter','latex')
ylabel('$|Z(\mathrm{j}\omega)|$','Interpreter','latex')
title('Amplitude frequency characteristic')
legend('Interpreter','latex','Location','best')
```

