考虑一个小的流体维微团在流场中移动，如下图所示：

![image-20230418133726838](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230418133726838.png)

速度场给定为：
$$
\boldsymbol{\mathrm{V}}=u\boldsymbol{\mathrm{i}}+v\boldsymbol{\mathrm{j}}+w\boldsymbol{\mathrm{k}}
$$
其中：
$$
\begin{split}
&u=u(x,y,z,t)\\
&v=v(x,y,z,t)\\
&w=w(x,y,z,t)\\
\end{split}
$$
另外，密度场给定为：
$$
\rho=\rho(x,y,z,t)
$$
在时间$t_1$时，流体微团处于流场中的点1处，并且密度为：
$$
\rho_1=\rho(x_1,y_1,z_1,t_1)
$$
时间$t_2$时，流体微团移动到了流场中的点2处，密度为：
$$
\rho_2=\rho(x_2,y_2,z_2,t_2)
$$
由于$\rho=\rho(x,y,z,t)$，流体微团在点2处的密度$\rho_2$可以用泰勒展开式进行表达：
$$
\begin{split}
\rho_2=&\rho_1
+\Big(\dfrac{\partial\rho}{\partial x}\Big)\Big\vert_1(x_2-x_1)
+\Big(\dfrac{\partial\rho}{\partial y}\Big)\Big\vert_1(y_2-y_1)\\
&+\Big(\dfrac{\partial\rho}{\partial z}\Big)\Big\vert_1(z_2-z_1)
+\Big(\dfrac{\partial\rho}{\partial t}\Big)\Big\vert_1(t_2-t_1)+\text{high-order terms}
\end{split}
$$
忽略高阶项，进一步有：
$$
\dfrac{\rho_2-\rho_1}{t_2-t_1}=
\Big(\dfrac{\partial\rho}{\partial x}\Big)\Big\vert_1\dfrac{x_2-x_1}{t_2-t_1}
+\Big(\dfrac{\partial\rho}{\partial y}\Big)\Big\vert_1\dfrac{y_2-y_1}{t_2-t_1}
+\Big(\dfrac{\partial\rho}{\partial z}\Big)\Big\vert_1\dfrac{z_2-z_1}{t_2-t_1}
+\Big(\dfrac{\partial\rho}{\partial t}\Big)\Big\vert_1
$$
式中，$(\rho_2-\rho_1)/(t_2-t_1)$表示“随着流体微元从点1移动到点2，流体微元密度的**平均（average）**时间变化率。随着时间$t_2$无限接近$t_1$，这一项可以写作：
$$
\lim_{t_2\rightarrow t_1}\dfrac{\rho_2-\rho_1}{t_2-t_1}=\dfrac{D\rho}{Dt}
$$
这里，左端项$D\rho/Dt$表示随着流体微团移动经过点1，流体微团密度的**瞬时（instantaneous）**时间变化率。符号
$$
D/Dt
$$
被定义为物质导数（substantial derivative）。

注意，$D\rho/Dt$随着一个给定流体微团（a **given fluid element**）穿过空间，该流体微团密度的时间变化率。我们的视角始终锁定在这个流体微团运动，在它经过点1时，我们看到了它的密度发生了变化。因此，它与$(\partial\rho/\partial t)_1$









哈密顿算子？

