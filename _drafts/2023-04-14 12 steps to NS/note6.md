在博客XX中，我们推导了空气动力学中的动量方程：
$$
\begin{split}
&\dfrac{\partial({\rho u)}}{\partial t}+\nabla\cdot(\rho u\boldsymbol{\mathrm{V}})=-\dfrac{\partial p}{\partial x}+\rho f_x+\boldsymbol({\mathcal{F}_x})_{viscous}\\
&\dfrac{\partial({\rho v)}}{\partial t}+\nabla\cdot(\rho v\boldsymbol{\mathrm{V}})=-\dfrac{\partial p}{\partial y}+\rho f_y+\boldsymbol({\mathcal{F}_y})_{viscous}\\
&\dfrac{\partial({\rho w)}}{\partial t}+\nabla\cdot(\rho w\boldsymbol{\mathrm{V}})=-\dfrac{\partial p}{\partial z}+\rho f_z+\boldsymbol({\mathcal{F}_z})_{viscous}\\
\end{split}
$$
以及相应的相应的适量矢量表示法：
$$
\dfrac{\partial}{\partial t}(\rho\boldsymbol{\mathrm{V}})+\nabla\cdot(\rho\boldsymbol{\mathrm{V}}\otimes\boldsymbol{\mathrm{V}})=-\nabla p+\rho\boldsymbol{f}+{\boldsymbol{\mathcal{F}}}_{viscous}
$$
在上面的式子中，体积力（body forces）被简单地表示为$\boldsymbol{f}$；表面力（surface forces），包括压力（pressure）和剪切力（shear stress）被简单地概括为${\boldsymbol{\mathcal{F}}}_{viscous}$。

本博客就。。。

假设有一个无体小移动地移动流体微团（质量固定）：

![image-20230419191814349](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20230419191814349.png)

我们对其应用牛顿第二定理，在$x$分量上有：
$$
F_x=ma_x\label{eq1}
$$
在式$\eqref{eq1}$中，$F_x$是作用于流体微团$x$方向上体积力和表面力的总和。我们**假设忽略体积力**，则作用在无穷小微团上的净力（net force）就只有表面力。例如：

- 在表面$abcd$（底部）上，作用在$x$方向上的只有剪切力（因为力作用的方向与$abcd$表面平行），值为$\tau_{yx}\mathrm{d}x\mathrm{d}z$，力的方向是从右向左的，**指向$x$的负方向**；
- 表面$efgh$（顶部）在表面$abcd$上方$\mathrm{d}y$处，因此作用在表面上的力为：$[\tau_{yx}+(\partial\tau_{yx}/\partial y)\mathrm{d}y]\mathrm{d}x\mathrm{d}z$，力的方向是从左向右的，**指向$x$的正方向**；

需要注意的是作用在表面$abcd$和$efgh$上的力的方向。**这是因为人们约定速度的所有三个分量$u$、$v$和$w$的正增加都发生在轴的正方向上**。速度$v$沿着$y$轴的正方向增加，因此在上述力的设定下，作用在$efgh$上的力是大于在作用在$abcd$上的力的，因此流体微团是有被向右“拖拽”的趋势。

类似的：

- 作用在表面$dcgh$的$x$方向上的剪切力大小为：$\tau_{zx}\mathrm{d}x\mathrm{d}y$；
- 作用在表面$abfe$的$x$方向上的剪切力大小为：$[\tau_{zx}+(\partial\tau_{zx}/\partial z)\mathrm{d}z]\mathrm{d}x\mathrm{d}y$；

作用在表面$bcgf$和表面$adhe$上则是压力和粘性力的和：

- 作用在表面$adhe$的$x$方向上力为$p\mathrm{d}y\mathrm{d}z$（指向流体微团的内部）以及$\tau_{xx}\mathrm{d}y\mathrm{d}z$（指向$x$轴的负方向）；
- 作用在表面$bcgf$的$x$方向上力为$[p+(\partial p/\partial x)\mathrm{d}x]\mathrm{d}y\mathrm{d}z$（指向流体微团内部）以及$[\tau_{xx}+({\partial_{xx}/\partial x)\mathrm{d}x}]\mathrm{d}x\mathrm{d}z$（指向$x$轴的正方向）；

==???===

因此，式$\eqref{eq1}$的左端项可以写作：
$$
\begin{split}
F_x&=\Big[p-(p+\dfrac{\partial p}{\partial x}\mathrm{d}x)\Big]\mathrm{d}y\mathrm{d}z+\Big[(\tau_{xx}+\dfrac{\partial\tau_{xx}}{\partial x}\mathrm{d}x)-\tau_{xx}\Big]\mathrm{d}y\mathrm{d}z\\
&+\Big[(\tau_{yx}+\dfrac{\partial\tau_{yx}}{\partial y}\mathrm{d}y)-\tau_{yx}\Big]\mathrm{d}x\mathrm{d}z+
\Big[(\tau_{zx}+\dfrac{\partial\tau_{zx}}{\partial z}\mathrm{d}z)-\tau_{zx}\Big]\mathrm{d}x\mathrm{d}y
\end{split}
$$
即：
$$
F_x=\Big(-\dfrac{\partial p}{\partial x}+\dfrac{\partial\tau_{xx}}{\partial x}+\dfrac{\partial\tau_{yx}}{\partial y}+\dfrac{\partial\tau_{zx}}{\partial z}\Big)\mathrm{d}x\mathrm{d}y\mathrm{d}z
$$
另一方面，流体微团的质量为：
$$
m=\rho\mathrm{d}x\mathrm{d}y\mathrm{d}z
$$
并且加速度是流体微团速度变化的时间速率，由于我们是使用无穷小流体微团进行分析，因此该无穷小流体微团速度变化的时间速率就可以用物质导数 [3] 进行表示：
$$
a_x=\dfrac{Du}{Dt}
$$
因此，式$\eqref{eq1}$可以重新写作：
$$
\Big(-\dfrac{\partial p}{\partial x}+\dfrac{\partial\tau_{xx}}{\partial x}+\dfrac{\partial\tau_{yx}}{\partial y}+\dfrac{\partial\tau_{zx}}{\partial z}\Big)\mathrm{d}x\mathrm{d}y\mathrm{d}z\mathrm{d}x\mathrm{d}y\mathrm{d}z
=\rho\mathrm{d}x\mathrm{d}y\mathrm{d}z\cdot\dfrac{Du}{Dt}
$$
即：
$$
\rho\dfrac{Du}{Dt}=-\dfrac{\partial p}{\partial x}+\dfrac{\partial\tau_{xx}}{\partial x}+\dfrac{\partial\tau_{yx}}{\partial y}+\dfrac{\partial\tau_{zx}}{\partial z}\label{eq2}
$$
同理，对于$y$分量和$z$分量，有：
$$
\rho\dfrac{Dv}{Dt}=-\dfrac{\partial p}{\partial y}+\dfrac{\partial\tau_{xy}}{\partial x}+\dfrac{\partial\tau_{yy}}{\partial y}+\dfrac{\partial\tau_{zy}}{\partial z}\label{eq3}
$$

$$
\rho\dfrac{Dw}{Dt}=-\dfrac{\partial p}{\partial z}+\dfrac{\partial\tau_{xz}}{\partial x}+\dfrac{\partial\tau_{yz}}{\partial y}+\dfrac{\partial\tau_{zz}}{\partial z}\label{eq4}
$$

式$\eqref{eq2}$-$\eqref{eq4}$都是标量方程，被称作Navier-Stokes方程（以法国人M. Navier和英国人G. Stokes命名，他们两个人独立地在十九世纪前半叶推导出这个方程）。

==缺少了剪切力和黏性的关系==









<br>

**References**

[1]

[2]

