>对于具有$n$个变量$n$个方程的非线性方程组$F(\boldsymbol{x})$：
>$$
>\begin{equation*} 
>\left\{ 
>\begin{aligned}
>f_1(\boldsymbol{x}) &= 0\\
>f_2(\boldsymbol{x}) &= 0\\
>&\vdots \\
>f_n(\boldsymbol{x}) &= 0
>\end{aligned}
>\right.
>\end{equation*}
>$$
>
>可以采用多元牛顿法进行迭代求解。单变量情况下的函数导数 $f'$ 对应多元函数的雅各比矩阵，定义为：
>
>$$
>\begin{equation*}
>DF(\boldsymbol{x}) = 
>	\begin{bmatrix}
>		\dfrac{\partial f_1}{\partial x_1} & \dfrac{\partial f_1}{\partial x_2}  & \cdots & \dfrac{\partial f_1}{\partial x_n}\\ 
>		\dfrac{\partial f_2}{\partial x_1} & \dfrac{\partial f_2}{\partial x_2}  & \cdots & \dfrac{\partial f_2}{\partial x_n}\\
>		\vdots                             & \vdots                              & \vdots & \vdots                            \\
>		\dfrac{\partial f_n}{\partial x_1} & \dfrac{\partial f_n}{\partial x_2}  & \cdots & \dfrac{\partial f_n}{\partial x_n}
>	\end{bmatrix}
>\end{equation*}
>$$
>
>在点 $\boldsymbol{x}_0$ 附近的向量值函数的泰勒展开式为：
>
>$$
>\begin{equation}\label{multivariables}
>F(\boldsymbol{x})=F(\boldsymbol{x}_0)+DF(\boldsymbol{x}_0)\cdot (\boldsymbol{x} - \boldsymbol{x}_0) + O(\boldsymbol{x} - \boldsymbol{x}_0)^2
>\end{equation}
>$$
>
>牛顿方法基于线性近似，因此忽略 $O(\boldsymbol{x} - \boldsymbol{x}_0)^2$，将式 $\eqref{multivariables}$ 在 $\boldsymbol{r}$ 处展开得到：
>
>$$
>\begin{equation}
>0 = F(\boldsymbol{r})\approx F(\boldsymbol{x}_0)+DF(\boldsymbol{x}_0)\cdot (\boldsymbol{r} - \boldsymbol{x}_0)
>\end{equation}
>$$
>
>
>即：
>
>$$
>\begin{equation}\label{3.6}
>-DF(\boldsymbol{x}_0)^{-1}F(\boldsymbol{x}_0)\approx \boldsymbol{r} - \boldsymbol{x}_0
>\end{equation}
>$$
>
>
>于是可以得到多变量牛顿法的一般迭代形式：
>$$
>\begin{align}
>\boldsymbol{x}_0 &= \boldsymbol{k} \notag \\
>\boldsymbol{x}_{k+1} &=\boldsymbol{x}_{k} - DF(\boldsymbol{x}_k)^{-1}F(\boldsymbol{x}_k),\ k= 0,1,2,\cdots \label{multinewton}\\
>\end{align}
>$$
>



