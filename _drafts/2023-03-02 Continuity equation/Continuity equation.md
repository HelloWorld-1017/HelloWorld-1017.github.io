假设空间中有一个空间位置固定的有限控制体，如下图所示：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230322211115933.png" alt="image-20230322211115933" style="zoom:25%;" />

它的体积$\mathcal{V}$和控制面$\mathrm{\boldsymbol{S}}$不随时间变化；另一方面，流体会穿过这一控制体，由于流场的不稳定波动（due to the unsteady fluctuations of the flow filed）会导致控制体内的流体质量会发生变化。

假设控制面$\mathrm{\boldsymbol{S}}$足够小，使得速度$\mathrm{\boldsymbol{V}}$可以均匀地流过。在流体穿过控制面经过时间$\mathrm{d}t$后，会扫过虚线所包围的体积，可以表示为：
$$
\mathrm{Volume}=(V_n\mathrm{d}t)S\notag
$$
其中，$V_n$是速度$\boldsymbol{\mathrm{V}}$在控制面$\mathrm{\boldsymbol{S}}$法向上的分量。这部分所对应的质量为：
$$
\mathrm{Mass}=\rho(V_n\mathrm{d}t)S\notag
$$
我们定义每秒穿过控制面$\mathrm{\boldsymbol{S}}$的质量为**质量流量**（**mass flow**），单位为kg/s（kilogram per second），并记作$\dot{m}$：
$$
\dot{m}=\dfrac{\rho(V_n\mathrm{d}t)S}{\mathrm{d}t}=\rho V_nS\label{eq1}
$$
式$\eqref{eq1}$表明，流过控制面的质量流量定义为：
$$
\mathrm{Area\times density\times component\ of\ flow\ velocity\ \boldsymbol{normal}\ to\ the\ area}\notag
$$
进一步，可以定义**质量通量**（**mass flux**）为每单位面积（per unit area）的质量流量：
$$
\mathrm{Mass\ flux}=\dfrac{\dot{m}}{S}=\rho V_n
$$
单位是kg/(s·m^2)。

空气动力学中的许多公式中都包含密度和速度的乘积。在笛卡尔坐标系中，速度通常会表示为$\boldsymbol{\mathrm{V}}=u\mathrm{\boldsymbol{i}}+v\mathrm{\boldsymbol{j}}+w\mathrm{\boldsymbol{k}}$，当看到$\rho u$，$\rho v$和$\rho w$时，我们要意识到这些量其实是$x$，$y$和$z$方向上的mass flux. 更一般地讲，如果$V$是在任意方向上地速度的幅值，则乘积$\rho V$则是通过垂直于该方向的区域的mass flux（mass flow per unit area）.

<br>

考虑一个流场，该流场中的所有性质都是空间和时间的函数，例如对于密度有：$\rho=\rho(x,y,z,t)$。在这个流场中，考虑一个如下图所示的位置固定的有限控制体：

![image-20230322223915961](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230322223915961.png)

考虑在控制面的任意一个点，有：

- 流体速度，$\boldsymbol{\mathrm{V}}$；
- 向量微元表面积（vector elemental surface area），$\boldsymbol{\mathrm{dS}}$；

针对这个控制体应用能量守恒定律：

> **Mass conservation**: Mass can be neither created nor destroyed.

意味着：
$$
\begin{split}
&\mathrm{Net\ mass\ flow\ }\boldsymbol{out}\ \mathrm{of\ control\ volume\ through\ surface\ }S\\
=&\mathrm{time\ rate\ of}\ \boldsymbol{decrease}\ \mathrm{of\ mass\ inside\ control\ volume\ }\mathcal{V}
\end{split}\label{eq3}
$$
根据式$\eqref{eq1}$，可以得到穿过$\mathrm{d}S$的mass flow为：
$$
\rho V_n\mathrm{d}S=\rho \boldsymbol{\mathrm{V}}\cdot\boldsymbol{\mathrm{dS}}
$$
根据图2.19，可以看到$\boldsymbol{\mathrm{dS}}$的方向始终是指向控制体的**外侧**，因此，$\boldsymbol{\mathrm{V}}\cdot\boldsymbol{\mathrm{dS}}$的符号是正号，在物理上的含义就是mass flow是离开控制体的，即$\boldsymbol{\mathrm{V}}\cdot\boldsymbol{\mathrm{dS}}$代表**outflow**；反之，$\boldsymbol{\mathrm{V}}\cdot\boldsymbol{\mathrm{dS}}$的符号是负号，则表示一个**inflow**。

式$\eqref{eq3}$左端的Net mass flow表示整个控制面的mass flow，因此可以写作：
$$
\mathrm{left}=\iint_{S}\rho \boldsymbol{\mathrm{V}}\cdot\boldsymbol{\mathrm{dS}}\label{left}
$$
<br>

现在再考虑式$\eqref{eq3}$右端项。体微元$\mathrm{d}\mathcal{V}$中内所包含的质量可以写作：
$$
\rho\ \mathrm{d}\mathcal{V}\notag
$$
因此，整个控制体的整体质量可以表示为一个体积分：
$$
\iiint_{\mathcal{V}}\rho\ \mathrm{d}\mathcal{V}\notag
$$
于是，$\mathcal{V}$内的质量的**增量**的时间变化率（time rate of **increase** of mass）可以写作：
$$
\dfrac{\partial}{\partial t}\iiint_{\mathcal{V}}\rho\ \mathrm{d}\mathcal{V}\notag
$$
反过来，$\mathcal{V}$内的质量的**减量**的时间变化率（time rate of **decrease** of mass）有：
$$
-\dfrac{\partial}{\partial t}\iiint_{\mathcal{V}}\rho\ \mathrm{d}\mathcal{V}\label{right}
$$
该式子就是式$\eqref{eq3}$右端项所代表的含义。

最终，根据式$\eqref{eq3}$，$\eqref{left}$，$\eqref{right}$，就可以得到：
$$
\iint_{S}\rho \boldsymbol{\mathrm{V}}\cdot\boldsymbol{\mathrm{dS}}=-\dfrac{\partial}{\partial t}\iiint_{\mathcal{V}}\rho\ \mathrm{d}\mathcal{V}\notag
$$
即：
$$
\dfrac{\partial}{\partial t}\iiint_{\mathcal{V}}\rho\ \mathrm{d}\mathcal{V}+\iint_{S}\rho \boldsymbol{\mathrm{V}}\cdot\boldsymbol{\mathrm{dS}}=0\label{continuity_int}
$$
式$\eqref{continuity_int}$就是对空间位置固定的有限控制体应用质量守恒定律得到的最终结果，该公式被称为连续方程（continuity equation），确切地讲是积分形式的连续方程，是流体力学领域最基本的方程之一。

<br>

式$\eqref{continuity_int}$的优点是将流体力学的现象与有限空间区域联系起来，而不需要关心在某一个点处的行为（It has advantage of relating aerodynamic phenomena over a finite region of space without being concerned about the details of precisely what is happening at a given distinct point in the flow）. 但另一方面，我们在很多时候也会关心流体的细节，想要使用方程描述在给定点处的流体性质。因此，接下来，我们就从式$\eqref{continuity_int}$出发，推导微分形式的连续方程，用于描述给定点的流体性质。

首先，由于我们在推导式$\eqref{continuity_int}$使用的控制体是空间位置固定的，因此积分的极限也是固定的（since the control volume used to obtain $\eqref{continuity_int}$ is fixed in space, the limits of integration are also fixed），因此，时间导数是可以放置在体积分的符号中的，于是式$\eqref{continuity_int}$可以重写为：
$$
\iiint_{\mathcal{V}}\dfrac{\partial\rho}{\partial t}\ \mathrm{d}\mathcal{V}+\iint_{S} \rho\boldsymbol{\mathrm{V}}\cdot\boldsymbol{\mathrm{dS}}=0\notag
$$
根据散度定理又可以得到：
$$
\iiint_{\mathcal{V}}\dfrac{\partial\rho}{\partial t}\ \mathrm{d}\mathcal{V}+\iiint_{\mathcal{V}} \nabla(\rho\cdot\boldsymbol{\mathrm{V}})\mathrm{d}\mathcal{V}=0\notag
$$
进一步可以写作：
$$

$$












