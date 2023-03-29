Momentum function

牛顿第二定律可以写作：
$$
\boldsymbol{\mathrm{F}}=m\boldsymbol{\mathrm{a}}\label{eq1}
$$
其中，$\boldsymbol{\mathrm{F}}$是施加在质量体$m$上的力，$\boldsymbol{\mathrm{a}}$是加速度。式$\eqref{eq1}$的另一种更通用的表达式是：
$$
\boldsymbol{\mathrm{F}}=\dfrac{\mathrm{d}}{\mathrm{d}t}(m\boldsymbol{\mathrm{V}})\label{eq2}
$$
其中，$m\boldsymbol{\mathrm{V}}$称作质量体$m$的动量（momentum）。式$\eqref{eq2}$体现了理论流体动力学的第二基本原理：
$$
\mathrm{Force\ =time\ rate\ of\ change\ of\ momentum}\notag
$$
将这一原理，即式$\eqref{eq2}$，应用到一个空间位置固定的有限控制体上，如下图所示：

![image-20230329231542103](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230329231542103.png)

首先关注式$\eqref{eq2}$的左端项$\boldsymbol{\mathrm{F}}$，它是当流体流过控制体时施加在流体上的力（which is the force exerted on the fluid as it flows through the control volume）。这个力有两个来源：

- 体积力（Body forces）：包括重力（gravity），电磁力（electromagnetic forces），或者或任何其他“远距离作用”于体积$\mathcal{V}$内部的流体的力（or any other forces which "act at distance" on the fluid inside inside $\mathcal{V}$）.
- 表面力（Surface forces）：施加在控制面$S$上的压力（pressure）和剪切力（shear stress）；

## Body forces

令$\boldsymbol{\mathrm{f}}$表示每**单位质量**施加在控制体$\mathcal{V}$内部的流体上的净体积力，则施加在体微元$\mathrm{d}\mathcal{V}$上的体积力可以表示为：
$$
\rho\boldsymbol{\mathrm{f}}\mathrm{d}\mathcal{V}
$$
则施加在整个控制体上的体积力可以表示为：
$$
\mathrm{Body\ force}=\iiint_\mathcal{V}\rho\boldsymbol{\mathrm{f}}\mathrm{d}\mathcal{V}
$$

## Pressure

由于压力施加在面积微元$\mathrm{d}S$上的表面力微元为：
$$
-p\boldsymbol{\mathrm{dS}}
$$
其中负号表示压力施加的方向与$\boldsymbol{\mathrm{dS}}$的方向相反，即控制面所承受的压力方向指向控制体的内部。因此，施加在整个控制面上的表面力可以表示为：
$$
\mathrm{Pressure\ force}=-\iint_Sp\boldsymbol{\mathrm{dS}}
$$

## Viscous stress

在粘性流体中（viscous flow），剪切力（shear stress）和法向粘性力（normal viscous）同样施加在黏性表面。粘性力（viscous stresses）的分析非常复杂，为了简化分析，在这里将施加在控制面上的总体的粘性力概括表示为
$$
\boldsymbol{\mathrm{F}}_{viscous}
$$
<br>

综上，我们可以得到“流体穿过空间位置的控制体时所受的合力（the total force experienced by the fluid as it is sweeping through the fixed control volume）”，即式$\eqref{eq2}$的左端项，表示为：
$$
\boldsymbol{\mathrm{F}}=\iiint_\mathcal{V}\rho\boldsymbol{\mathrm{f}}\mathrm{d}\mathcal{V}-\iint_Sp\boldsymbol{\mathrm{dS}}+\boldsymbol{\mathrm{F}}_{viscous}
$$
<br>

现在考虑$\eqref{eq2}$的右端项。流体穿过位置空间固定的控制体时动量的时间变化率可以表示为两项的总和：
$$
\mathrm{Net\ flow\ of\ momentum\ }out\ \mathrm{of\ control\ volume\ across\ surface}\ S\equiv\boldsymbol{\mathrm{G}}
$$
以及：
$$
\mathrm{Time\ rate\ of\ change\ of\ momentum\ due\ to\ unsteady\ fluctuations\ of\ flow\ properties\ inside}\ \mathcal{V}\equiv\boldsymbol{\mathrm{H}}
$$
<br>

