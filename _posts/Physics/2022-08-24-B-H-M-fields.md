---
title: B Filed, H Filed, and M Filed
categories:
 - Physics
tags: 
 - Electromagnetism
date: 2022-08-24 13:02:47 +0800
last_modified_at: 2024-07-17 14:59:24 +0800
---


# 磁场简介

电场和磁场相互关联，都是电磁力(electromagnetic)的一部分，而电磁力是自然界四种基本力(fundamental forces)之一。

基本力(fundamental forces, AKA fundamental interaction)是指（似乎）不能简化为更基本相互作用的相互作用力，包括引力(gravitational interaction)、电磁力(electromagnetic interaction)、弱相互作用力(weak interaction)、强相互作用力(strong interaction)。
{: .notice--primary}

磁场被广泛应用于现代技术中，尤其是在电气工程(electrical engineering)和机电工程(electromechanics)中。电动机(electrical engineering)和发电机(generator)中则用到了旋转磁场(rotating magnetic fields)的原理。电气设备（如变压器）中的磁场相互作用可以概念化为磁路(magnetic circuits)。磁力可以通过霍尔效应(Hall effect)提供物质中电荷载流子(charge carriers)的信息。地球本身会产生自己的磁场，保护地球的臭氧层(Earth's ozone layer)免受太阳风暴(solar wind)的影响，并且指南针可以根据地球的磁场为航行提供方向。

磁场(magnetic field)是一种向量场，描述了移动电荷、电流和磁性物质所受到的磁影响。在磁场中运动的电荷受到垂直于其自身速度和磁场的力（洛伦兹力中磁场力的部分）。永磁体(permanent magnet)的磁场对铁等铁磁材料产生新引力，并吸引或排斥其他磁铁。另外，磁场将通过影响非磁性材料(nonmagnetic materials)外部原子电子(outer atomic electrons)的运动而对其施加力。

磁化材料(magnetized materials)周围的磁场是由电流（比如电磁铁electromagnets）和变化的电场(electric fields varying in time)产生的。由于磁场的强度和方向随位置的变化而变化，因此从数学上可以用一个向量方程来描述，因此磁场是一个向量场。

在电磁学领域，“磁场”这个概念用两个不同但是密切相关的向量场 $\boldsymbol{\mathrm{B}}$ 和 $\boldsymbol{\mathrm{H}}$ 来描述，$\boldsymbol{\mathrm{H}}$ 和 $\boldsymbol{\mathrm{B}}$ 在如何解释磁化(magnetization)方面不同。



磁场是由移动电荷(moving charges)和基本粒子的固有磁矩产生的。

固有磁矩与粒子基本量子性质(如自旋spin)有关。
{: .notice--primary}

<br>

# $\boldsymbol{\mathrm{B}}$ 场

在国际单位制中，$\boldsymbol{\mathrm{B}}$ 表示磁通（量）密度(magnetic flux density，也称作磁感应强度)，单位是 T (tesla)，等价于 $\mathrm{kg/(s^2\cdot A)}$ （kilogram per second^2 per ampere） 和 $\mathrm{N/(m\cdot A})$ （ newton per meter per ampere）。$\boldsymbol{\mathrm{B}}$ 场 是通过洛伦兹力进行定义的，根据 [洛伦兹力的描述](http://whatastarrynight.com/electromagnetism/Lorentz-force/) ：

$$
\boldsymbol{\mathrm{F}}=q\boldsymbol{\mathrm{E}}+q\boldsymbol{\mathrm{v}}\times\boldsymbol{\mathrm{B}}\label{lorentz}
$$

带电粒子所受到的力和带电粒子的位置、运动速度和运动方向，洛伦兹力将这个力分解为电场力和磁场力两部分，并且定义了电场和磁场 $\boldsymbol{\mathrm{B}}$ 的概念。电场所施加的电场力是施加于静止电荷的，与电荷的无关；而磁场所施加的磁场力与电荷的运动速度有关。

<br>

# $\boldsymbol{\mathrm{H}}$ 场

在国际单位制中， $\boldsymbol{\mathrm{H}}$ 表示磁场强度(magnetic field strength/magnetic field intensity/magnetic field/magnetizing field)，单位为 A/m (ampere per meter)。 **$\boldsymbol{\mathrm{H}}$ 场** 定义为：

$$
\boldsymbol{\mathrm{H}}\equiv\dfrac1{\mu_0}\boldsymbol{\mathrm{B}}-\boldsymbol{\mathrm{M}}\label{BHM}
$$

式中，$\mu_0$ 是真空磁导率(vacuum permeability)，$\boldsymbol{\mathrm{M}}$ 是磁化向量(magnetization vector)。



<br>

#  $\boldsymbol{\mathrm{M}}$ 场(磁化强度)

$\boldsymbol{\mathrm{M}}$ 场，即磁化强度。在经典电磁学中，磁化强度(magnetization)是用于描述磁性材料中永久磁偶极矩或感应磁偶极矩(permanent or induced magnetic dipole moments)密度的矢量场。在这个矢量场中的运动由方向描述，并且要么是轴向的(Axial)要么是径向的(Diametric)。负责磁化的磁矩来源于原子中电子运动产生的微观电流，或者是来源于电子或原子核的自旋(nuclei)。静磁化强度(net magnetization)由材料对外部磁场的响应产生。在磁场中，顺磁性物质(paramagnetic materials)只会产生很微弱的感应磁化强度，并在外部磁场移除后消失；而铁磁和铁磁材料(ferromagnetic and ferrimagnetic materials)在电场中会产生强烈的磁化强度，并且在移除外部磁场后，仍然保持磁化状态成为永磁体(permanent magnetic)。物质内的磁化强度不一定是一致的，并且在不同的点之间进行变化。**磁化强度不仅描述了物质对外施磁场的响应，还描述了物质是如何改变磁场的，并且可以用于计算这些交互过程中产生的力。**

<br>

物理学家和工程师通常将磁化强度定义为单位体积的磁矩(the quantity of magnetic moment per unit volume)，用伪矢量(pseudovector) $\boldsymbol{\mathrm{M}}$ 表示。$\boldsymbol{\mathrm{M}}$ 场，可以用下面的公式进行定义：

$$
\boldsymbol{\mathrm{M}}=\dfrac{\mathrm{d}\boldsymbol{\mathrm{m}}}{\mathrm{d}\boldsymbol{V}}\notag
$$

式中，$\mathrm{d}\boldsymbol{\mathrm{m}}$ 表示磁矩微元，$\mathrm{d}\boldsymbol{V}$ 表示体积微元。 

$\boldsymbol{\mathrm{M}}$ 场实际上就是在某一区域或者流形中磁矩的分布，下面的公式可以更好地反应这个特点：

$$
\boldsymbol{\mathrm{m}}=\iiint\boldsymbol{\mathrm{M}}\ \mathrm{d}\mathrm{V}\notag
$$

<figure>
    <a href="https://commons.wikimedia.org/wiki/File:Bound_currents.gif"><img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/Bound_currents.gif"></a>
    <figcaption>When the microscopic currents induced by the magnetization (black arrows) do not balance out, bound volume currents (blue arrows) and bound surface currents (red arrows) appear in the medium.</figcaption>
</figure>



磁化强度和概念可以类比于静电学中电极化(electric polarization)的概念，电极化是电场对物质影响的测量。电极化场(electric polarisation field)，即 $\boldsymbol{\mathrm{P}}$ 场，$\boldsymbol{\mathrm{P}}$ 场决定了表征区域或流形内电极极化的电偶极矩(electric dipole moment) $\boldsymbol{\mathrm{p}}$ ：

$$
\boldsymbol{\mathrm{P}}=\dfrac{\mathrm{d}\boldsymbol{\mathrm{p}}}{\mathrm{d}\boldsymbol{V}},\ \boldsymbol{\mathrm{p}}=\iiint\boldsymbol{\mathrm{P}}\ \mathrm{d}\mathrm{V}\notag
$$

<br>

#  $\boldsymbol{\mathrm{H}}$ 场与$\boldsymbol{\mathrm{B}}$场 、 $\boldsymbol{\mathrm{M}}$ 场之间的关系

在真空中，$\boldsymbol{\mathrm{B}}$ 和 $\boldsymbol{\mathrm{H}}$ 相互成比例的：

$$
\boldsymbol{\mathrm{H}}=\dfrac{\boldsymbol{\mathrm{B}}}{\mu_0}\label{vacuumHB}
$$

而在物质内部，不存在式 $\eqref{vacuumHB}$ 这样的比例关系，但是仍然满足：

$$
\boldsymbol{\mathrm{H}}=\dfrac1{\mu_0}\boldsymbol{\mathrm{B}}-\boldsymbol{\mathrm{M}}
$$


<figure class="half">
    <a href="https://commons.wikimedia.org/wiki/File:VFPt_magnets_BHM.svg"><img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824090148796.png?raw=true"></a>
        <figcaption>Comparison of B, H and M inside and outside a cylindrical bar magnet.</figcaption>
</figure>



<br>

**参考**

[1] [Magnetic field - Wikipedia](https://en.wikipedia.org/wiki/Magnetic_field).

[2] [Magnetization - Wikepedia](https://en.wikipedia.org/wiki/Magnetization).



