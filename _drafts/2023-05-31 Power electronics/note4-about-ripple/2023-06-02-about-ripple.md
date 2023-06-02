下图所示是一个使用理想的SPDT开关实现的Buck电路，能够实现降低DC输入电压的功能 [XX, previous blog]：

![image-20230602122148995](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230602122148995.png)

随着SPDT开关位置的变化，其输出电压波形$v_s(t)$如下图所示：

![image-20230602122415217](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230602122415217.png)

在实际中，这个理想的开关通常使用半导体器件（例如晶体管或二极管）实现。晶体管或者二极管被控制系统控制导通或阻断，以实现理想开关开合的功能。上图中：

- 开关的频率$f_s$等于开关周期开关周期$T_s$的倒数，其范围通常为$1\ \mathrm{kHz}\sim1\ \mathrm{MHz}$，这取决于半导体器件的开关速度；
- 占空比$D$是开关在开关周期$T_s$内处于位置1处的时长占比，取值为$(0,1)$；另外，定义$D'=1-D$，表示开关在开关周期$T_s$内处于位置2处的时长占比.

该开关可以减少电压的直流分量，并根据傅里叶分析有可知，$v_s(t)$的直流分量可以使用其平均值表示，即：
$$
\langle v_s\rangle=\dfrac1{T_s}\int_0^{T_s}v_s(t)\mathrm{d}t=\dfrac1{T_s}(DT_sV_g)=DV_g
$$
为了抑制$v_s(t)$中开关频率及其谐波的分量，可以在输出后添加一个低通滤波器：

![image-20230602141558202](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230602141558202.png)

该低通滤波器的截止频率需要远远小于开关频率。

> ==低通滤波器的分析XXXXXX==

输出电压$v(t)$基本上就等于$v_s(t)$的直流分量：
$$
v\approx\langle v_s\rangle=DV_g
$$
上述电路在理想状态下没有能量损耗。

<br>

由于不可能构建一个完美的滤波器，使得只传递DC分量而完全移除开关频率及其谐波分量。因此，低通滤波器会传递一些少量的有开关产生的高频谐波。因此，实际中的电压输出波形$v(t)$是类似于这样的：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230602194145897.png" alt="image-20230602194145897" style="zoom:67%;" />

即：
$$
v(t)=V+v_{ripple}(t)
$$
良好设计的转换器的输出电压开关波纹应该非常小。例如，在电脑中，电源供应具有3.3 V输出，开关的波纹通常要小于几十毫伏，或者小于DC分量$V$的1%。因此，我们通常假设开关波纹的开关波纹的幅值远小于DC分量：
$$
\vert\vert v_{ripple}\vert\vert\ll V
$$
因此有：
$$
v(t)\approx V
$$
这种近似方法，被称作是**小波纹近似（small-ripple approximation）**，或者**线性波纹近似（linear-ripple approximation）**，这种近似方法极大地简化了转换器波形的分析，是一种非常常用的简化方法。下文也采用这种方法进行分析。

> With this approximation, we replace the exponential or damped sinusoidal expressions for the inductor and capacitor waveforms with simpler linear waveforms; this approximation is justified provided that the switching period is much shorter than the natural time constants of the circuit. The small-ripple approximation is applied to the inductor currents and capacitor voltages of the converter, which are continuous variables. It must not be applied to discontinuous waveforms of the converter, such as the switch voltage, switch current, or inductor voltage.  

<br>

## Inductor current waveform

（1）当开关在位置1时，Buck电路的等效电路为：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230602205102184.png" alt="image-20230602205102184" style="zoom: 67%;" />

此时有：
$$
\left\{
\begin{split}
&v_L=V_g-v(t)\approx V_g-V\\
&v_L=L\dfrac{\mathrm{d}i_L(t)}{\mathrm{d}t}
\end{split}\label{eq11}
\right.
$$
于是可以得到：
$$
\dfrac{\mathrm{d}i_L(t)}{\mathrm{d}t}\approx\dfrac{V_g-V}{L}\label{eq1}
$$
（2）当开关在位置2时，等效电路为：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230602205914031.png" alt="image-20230602205914031" style="zoom: 67%;" />

此时有：
$$
\left\{
\begin{split}
&v_L(t)=-v(t)\approx -V\\
&v_L(t)=L\dfrac{\mathrm{d}i_L(t)}{\mathrm{d}t}\\
\end{split}
\right.\label{eq22}
$$
最终有：
$$
\dfrac{\mathrm{d}i_L(t)}{\mathrm{d}t}\approx\dfrac{-V}{L}\label{eq2}
$$
根据上述分析，我们可以绘制出稳态时电感电压的变化曲线：

![image-20230602210552781](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230602210552781.png)

并且，我们假设稳态时电感的起始值为$i_L(0)$，则根据式$\eqref{eq1}$和式$\eqref{eq2}$中电感电流变化的斜率，可以绘制出buck电路稳态时电感电流的变化曲线：

![image-20230602210636844](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230602210636844.png)

如稳态的电感电流曲线所示，电感电流曲线的峰值等于DC分量$I$加上peak-to-average波纹幅值$\Delta i_L$：
$$
i_L^{max}=I+\Delta i_L
$$
这个峰值电流不仅会流过电感，还会流过充当开关的半导体器件。因此，**我们在确定这些器件的额定值时，必须要考虑电感电流的峰值**。

由于我们可以知道开关在位置1时的电感电流的斜率$\mathrm{d}i_L(t)/\mathrm{d}t$（根据式$\eqref{eq1}$）、时长$DT_s$；另一方面，在稳态时$i_L(t)$的波形关于$I$对称。因此，我们就可以计算出波纹幅值$\Delta i_L$：
$$
2\Delta i_L=\Big(\dfrac{V_g-V}{L}\Big)(DT_s)
$$
可以解出：
$$
\Delta i_L=\dfrac{V_g-V}{2L}DT_s\label{eq3}
$$
通常，$\Delta i_L$大致在DC分量$I$的全负载值（full-load value）的10%-20%范围内。如果$\Delta i_L$的值过大，则会增加电感和半导体开关器件的峰值电流，相应地，它们的尺寸也会相应增大。

当我们确定了电流波纹$\Delta i_L$，我们就可以依据此来选择电感的值。根据式$\eqref{eq3}$，我们可以得到电感为：
$$
L=\dfrac{V_g-V}{2\Delta i_L}DT_s\label{eq4}
$$
**式$\eqref{eq4}$通常用于选择Buck电路中的电感值$L$。**

我们完全可以不使用小波纹近似法，而是使用精确的方法来计算上述过程。例如，可以使用拉普拉斯变换的方法来写出开关在不同位置时的完整表达式，之后通过拉普拉斯反变换计算出电路的周期性的稳定解，就能够找到波形的DC分量和峰值。但是这是一个繁琐的工作，并且结果几乎总是很难处理的。相比之下，小波纹近似是一种简单、快速的求解方法。

<br>

以上，我们就使用小波纹近似法求解出了Buck电路在稳定状态下电感电流的表达式并绘制出了相应的波形。接下来，我们考虑一下当开关第一次置于位置1时的电感电流表达式（仍然使用小波纹近似法）。

假设在初始状态下，电感电流和输出电压都为零，之后开关位于位置1以施加输入电压$V_g$。如下图所示：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230602220153373.png" alt="image-20230602220153373" style="zoom:67%;" />

电感的初始值$i_L(0)=0$，当开关第一次ON时，根据式$\eqref{eq11}$，电感电流会以斜率$(V_g-v(t))/L$增加，其中$v(t)=0$；之后，开关位于OFF的状态，根据式$\eqref{eq22}$，电感



