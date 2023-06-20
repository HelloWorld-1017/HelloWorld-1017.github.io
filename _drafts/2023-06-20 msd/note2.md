Simulating Ideal and Practical

Signals and Systems





# Introduction to Double Mass-Spring-Damper System

两个质量-弹簧-阻尼系统 [1] 连接在一起就可以得到一个二自由度的质量-弹簧-阻尼系统：

![image-20230620083127863](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230620083127863.png)

对两个质量块分别列写力的平衡方程可以得到：
$$
\begin{split}
&F_1-k_1x_1-b_1v_1-k_2(x_1-x_2)-b_2(v_1-v_2)=m_1a_1\\
&F_2-k_2(x_2-x_1)-b_2(v_2-v_1)=m_1a_2\\
\end{split}\label{eq0}
$$
当（1）$k_1=k_2=k$，且$b_1=b_2=b$；（2）$F_1=F_2=0$；（3）$m_1=m_2=m$时，有：
$$
\begin{split}
&-kx_1-bv_1-k(x_1-x_2)-b(v_1-v_2)=ma_1\\
&-k(x_2-x_1)-b(v_2-v_1)=ma_2\\
\end{split}\label{eq1}
$$
若系统的初始条件为两个弹簧的形变量为$x_0=1\ \mathrm{m}$，则根据系统方程$\eqref{eq1}$，就可以搭建出相对应的Simulink仿真模型 [1]：

![image-20230619153329559](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230619153329559.png)

并得到质量块的位置与速度随时间的变化曲线：

![image-20230619160411359](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230619160411359.png)

有波形曲线可以看到，两个质量块最终会稳定在$x=0\ \mathrm{m}$处，速度会稳定在$v=0\ \mathrm{m/s}$，因此关于该仿真模型，我们可以得到以下结论：

（1）两个质量-弹簧-阻尼系统都是以墙为原点，此处的坐标为$x=0$。因此，系统2的初始形变量$x_0=2\ \mathrm{m}$（系统2的位置积分模块）表示弹簧2的初始形变为$x_0=1\ \mathrm{m}$；

（2）弹簧是理想的，当弹簧的形变量为零时就是一个“点”，而当弹簧的形变量为负数时，则弹簧向负方向延伸；

（3）质量体是理想的，是一个无穷小的质点，仅仅有质量这一个参数而没有体积，因而也就不占有长度。

（4）墙体也是理想的，因为质量块1的位移可以是负数；

<br>







![image-20230619170038387](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230619170038387.png)

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230619170115719.png" alt="image-20230619170115719" style="zoom:67%;" />





当垂直的时候，且平衡的时候：

![image-20230619215759037](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20230619215759037.png)





根据式$\eqref{eq0}$，有：
$$
\begin{split}
&m\mathrm{g}-kx_1+k(x_1-x_2)=0\\
&m\mathrm{g}-k(x_2-x_1)=0\\
\end{split}
$$
在该模型中，质量体的质量`m`为`3.6`，弹簧的弹性系数`k`为`400`，由此可以解得：
$$
\begin{split}
&x_1=0.17658\\
&x_2=0.26587\\
\end{split}
$$
由此可以获得质量体1和质量体2的实际位置：
$$
\begin{split}
&P_1=5.5-0.17658=5.32342\\
&P_2=11-0.17658-0.26487=10.55855\\
\end{split}\notag
$$






如何改进这些理想的部分呢？

<br>

地面在上方的情况（断路器的情况）；

<br>

如果我们将二自由度的质量-弹簧-阻尼系统的位置和速度作为状态向量$\mathrm{\boldsymbol{z}}$作为状态向量：
$$
\begin{bmatrix}
z_1\\
z_2\\
z_3\\
z_4\\
\end{bmatrix}=
\begin{bmatrix}
x_1\\
v_1\\
x_2\\
v_2\\
\end{bmatrix}
$$
则根据式$\eqref{eq0}$有：
$$
\begin{split}
&\dot{z}_1=z_2\\
&\dot{z}_2=\dfrac1{m_1}\Big[F_1-(k_1+k_2)z_1-(b_1+b_2)z_2+k_2z_3+b_2z_4\Big]\\
&\dot{z}_3=z_4\\
&\dot{z}_4=\dfrac1{m_2}\Big[F_2+k_2z_1+b_2z_2-k_2z_3-b_2z_4\Big]
\end{split}
$$

可以写作：
$$
\begin{split}
\begin{bmatrix}
\dot{z}_1\\
\dot{z}_2\\
\dot{z}_3\\
\dot{z}_4\\
\end{bmatrix}&=
\begin{bmatrix}
0&1&0&0\\
-\dfrac{k_1+k_2}{m_1}&-\dfrac{b_1+b_2}{m_1}&\dfrac{k_2}{m_1}&\dfrac{b_2}{m_1}\\
0&0&0&1\\
\dfrac{k_2}{m_2}&\dfrac{b_2}{m_2}&-\dfrac{k_2}{m_2}&-\dfrac{b_2}{m_2}
\end{bmatrix}
\begin{bmatrix}
z_1\\
z_2\\
z_3\\
z_4\\
\end{bmatrix}+
\begin{bmatrix}
0&0\\
\dfrac1{m_1}&0\\
0&0\\
0&\dfrac1{m_2}
\end{bmatrix}
\begin{bmatrix}
F_1\\
F_2\\
\end{bmatrix}\\
&=A\cdot z+B\cdot u
\end{split}
$$
其中，$A$为系统的**状态矩阵**，$B$为**输入矩阵**，$u$为**输入（控制）向量**。

假设我们只对质量块的位置感兴趣，则有：
$$
y=Cz+Du
$$
其中，$y$为**输出向量**，$C$为**输出矩阵**：
$$
y=\begin{bmatrix}
y_1\\
y_2\\
\end{bmatrix},\quad 
C=\begin{bmatrix}
1&0&0&0\\
0&0&1&0\\
\end{bmatrix},\quad
D = 
\begin{bmatrix}
0&0\\
0&0\\
\end{bmatrix}\label{eq3}
$$




带入模型的参数后：
$$
A=\begin{bmatrix}
0&1&0&0\\
-\dfrac{2k}{m}&-\dfrac{2b}{m}&\dfrac{k}{m}&\dfrac{b}{m}\\
0&0&0&1\\
\dfrac{k}{m}&\dfrac{b}{m}&-\dfrac{k}{m}&-\dfrac{b}{m}
\end{bmatrix}\notag
$$

$$
B=\begin{bmatrix}
0&0\\
\dfrac1m&0\\
0&0\\
0&\dfrac1m
\end{bmatrix}\notag
$$

矩阵$C$和矩阵$D$的取值与$\eqref{eq3}$是一致的。







<br>

**References**

[1] [Mass-Spring-Damper Simulation in MATLAB - What a starry night~](http://whatastarrynight.com/matlab/Mass-Spring-Damper-Simulation-in-MATLAB/).

[2] [Double Mass-Spring-Damper in Simulink and Simscape - MathWorks](https://ww2.mathworks.cn/help/simscape/ug/double-mass-spring-damper-in-simulink-and-simscape.html).

[3] [Spring-Mass-Damper System, 2DOF - YouTube](https://www.youtube.com/watch?v=s5zO2fuiW7c).

[4] [二自由度质量-弹簧-阻尼串联系统的Simulink仿真 - 知乎](https://zhuanlan.zhihu.com/p/104566650).
