假设观测数据$Y_1,Y_2,\cdots,Y_N$由下面的GMM生成：
$$
P(y\vert\theta)=\sum^{K}_{k=1}\alpha_k\cdot\varphi(y\vert\theta_k)
$$
其中，$\theta=(\alpha_1,\alpha_2,\cdots,\alpha_k;\theta_1,\theta_2,\cdots,\theta_K)$，使用EM算法估计GMM的参数集合$\theta$。

观测数据$Y_j,j=1,2,\cdots,N$是这样产生的：首先根据概率$\alpha_k$选择第$k$个高斯分布分模型$\varphi(y\vert\theta_k)$，然后由第$k$个分模型的概率分布$\varphi(y\vert\theta_k)$生成观测数据$Y_j$。这时，观测数据$Y_j,j=1,2,\cdots,N$是已知的，反应观测数据$Y_j$来自第$k$个分模型的数据是未知的，其中$k=1,2,\cdots,K$，以隐变量$z_{jk}$表示，其定义如下：
$$
z_{jk}=\left\{
\begin{split}
&1,\ &第j个观测数据来自第k个GMM分模型\\
&0,\ &否则\\
\end{split}\right.
$$
可以看到$z_{jk}$是一个0-1随机变量。

有了观测数据$Y_j$和未观测数据$z_{jk}$(即隐变量)，则第$j$条数据所对应的完全数据为：
$$
(Y_j,z_{j1},z_{j2},\cdots,z_{jK}),\ j=1,2,\cdots,N
$$
于是，可以写出完全数据的似然函数：
$$
\begin{split}
P(Y_1,\cdots,Y_N,z\vert\theta)&=P(Y_1,z_{11},z_{12},\cdots,z_{1K}\vert\theta)P(Y_2,z_{21},z_{22},\cdots,z_{2K}\vert\theta)\cdots P(Y_N,z_{N1},z_{N2},\cdots,z_{NK}\vert\theta)\\
&=\prod_{j=1}^NP(Y_j,z_{j1},z_{j2},\cdots,z_{jK}\vert\theta)\\
&=\prod_{j=1}^N\Big(\alpha_1\varphi(Y_j\vert\theta_1)\Big)^{z_{j1}}\Big(\alpha_2\varphi(Y_j\vert\theta_2)\Big)^{z_{j2}}\cdots\Big(\alpha_K\varphi(Y_j\vert\theta_K)\Big)^{z_{jK}}\\
&=\prod_{j=1}^N\prod_{k=1}^K\Big(\alpha_k\varphi(Y_j\vert\theta_k)\Big)^{z_{jk}}\\
&=\prod_{j=1}^N\prod_{k=1}^K\alpha_k^{z_{jk}}\times\prod_{j=1}^N\prod_{k=1}^K\Big(\varphi(Y_j\vert\theta_k)\Big)^{z_{jk}}\\
&=\prod_{k=1}^K\alpha_k^{\sum_{j=1}^Nz_{jk}}\times\prod_{j=1}^N\prod_{k=1}^K\Big(\varphi(Y_j\vert\theta_k)\Big)^{z_{jk}}
\end{split}\label{eq1}
$$
若令$n_k=\sum_{j=1}^Nz_{jk}$，并有$\sum_{k=1}^Kn_k=N$，则上式继续化为：
$$
\begin{split}
P(Y_1,\cdots,Y_N,z\vert\theta)&=\prod_{k=1}^K\alpha_k^{n_k}\times\prod_{j=1}^N\prod_{k=1}^K\Big(\varphi(Y_j\vert\theta_k)\Big)^{z_{jk}}\\
&=\prod_{k=1}^K \alpha_k^{n_k}\prod_{j=1}^N\Big(\varphi(Y_j\vert\theta_k)\Big)^{z_{jk}}\\
&=\prod_{k=1}^K \alpha_k^{n_k}\prod_{j=1}^N\Big[\dfrac{1}{\sqrt{2\pi}\sigma_k}\exp(-\dfrac1{2\sigma_k^2}(Y_j-\mu_k))\Big]^{z_{jk}}
\end{split}
$$


于是可以得到完全数据的对数似然函数为：
$$
\begin{split}
\log P(Y_1,\cdots,Y_N,z\vert\theta)&=\sum_{k=1}^K\Big\{n_k\log\alpha_k+\sum_{j=1}^Nz_{jk}\Big[\log\dfrac1{\sqrt{2\pi}}-\log\sigma_k-\dfrac{1}{2\sigma_k^2}(Y_j-\mu_k)^2\Big]
\Big\}
\end{split}
$$
EM算法的E步：确定Q函数。

完全数据的对数似然函数$\log P(Y,Z\vert\theta)$关于在给定观测数据$Y$和当前参数$\theta^{(i)}$下对未观测数据$Z$的条件概率分布$P(Z\vert Y,\theta^{i})$的期望称为Q函数，即：
$$
\begin{split}
Q(\theta,\theta^{(i)})&=\mathrm{E}_Z\Big[\log P(Y,Z\vert\theta)\vert Y,\theta^{(i)}\Big]\\
&=\sum_Z\log P(Y,Z\vert\theta)P(Z\vert Y,\theta^{(i)})
\end{split}
$$
因此，GMM的Q函数为
$$
\begin{split}
Q(\theta,\theta^{(i)})&=\mathrm{E}\sum_{k=1}^K\Big\{n_k\log\alpha_k+\sum_{j=1}^Nz_{jk}\Big[\log\dfrac1{\sqrt{2\pi}}-\log\sigma_k-\dfrac{1}{2\sigma_k^2}(Y_j-\mu_k)^2\Big]\\
&=\sum_{k=1}^K\Big\{\sum_{j=1}^N\mathrm{E}(z_{jk})\log\alpha_k+\sum_{j=1}^N\mathrm{E}(z_{jk})\Big[\log\dfrac1{\sqrt{2\pi}}-\log\sigma_k-\dfrac{1}{2\sigma_k^2}(Y_j-\mu_k)^2\Big]
\end{split}\label{Q1}
$$
令$\hat{z}_{jk}=\mathrm{E}(z_{jk}\vert Y,\theta)$：
$$
\begin{split}
\hat{z}_{jk}&=\mathrm{E}(z_{jk}\vert Y,\theta)\\
&=P(z_{jk}=1\vert Y,\theta)\\
&=\dfrac{P(z_{jk}=1,\ Y_j\vert\theta)}{\sum_{k=1}^KP(z_{jk}=1,Y_j\vert\theta)}\\
&=\dfrac{P(Y_j\vert z_{jk}=1,\theta)P(z_{jk}=1\vert\theta)}{\sum_{k=1}^KP(Y_j\vert z_{jk}=1,\theta)P(z_{jk}=1\vert\theta)}\\
&=\dfrac{\alpha_k\varphi(Y_j\vert\theta_k)}{\sum_{k=1}^K\alpha_k\varphi(Y_j\vert\theta_k)},\ j=1,2,\cdots,N,\ k=1,2,\cdots,K
\end{split}
$$
$\hat{z_{jk}}$为当前模型下第$j$个观测数据来自第$k$个分模型的概率，称为分模型$k$对观测数据$Y_j$的**响应度**。

将$\hat{z}_{jk}=\mathrm{E}(z_{jk})$以及$n_k=\sum_{j=1}^N\mathrm{E}({z_{jk}})$代入公式$\eqref{Q1}$，可以得到：
$$
Q(\theta,\theta^{(i)})=\sum_{k=1}^K\Big\{n_k\log\alpha_k+\sum_{j=1}^N\hat{z}_{jk}\Big[\log\dfrac1{\sqrt{2\pi}}-\log\sigma_k-\dfrac{1}{2\sigma_k^2}(Y_j-\mu_k)^2\Big]\label{Q2}
$$
EM算法的第M步。

迭代的M步是求Q函数$Q(\theta,\theta^{(i)})$对$\theta$的极大值，即求新一轮迭代的模型参数：
$$
\theta^{(i+1)}=\arg\max_{\theta}Q(\theta,\theta^{(i)})
$$
使用$\hat{\mu}_k$，$\hat{\sigma^2}_k$及$\hat{\alpha}_k$，$k=1,2,\cdots,K$，表示$\theta^{(i+1)}$的各参数，使用的方式是：

- $\hat{\mu}_k$和$\hat{\sigma^2}_k$只需要将$\eqref{Q1}$分别对$\mu_k$，$\sigma_k^2$求偏导令其为0即可，类似于MLE

$$
\hat{\mu}_k=\dfrac{\sum_{j=1}^N\hat{z}_{jk}Y_j}{\sum_{j=1}^N\hat{z}_{jk}},\ k=1,2,\cdots,K
$$

$$
\hat{\sigma^2}_k=\dfrac{\sum_{j=1}^N\hat{z}_{jk}(Y_j-\mu_k)^2}{\sum_{j=1}^N\hat{z}_{jk}},\ k=1,2,\cdots,K
$$

- $\hat{\alpha}_k$是在$\sum_{k=1}^K\alpha_k=1$的条件下求对$\alpha_k$的偏导数并令其为0，若没有这个约束条件，则$\hat{\alpha}_k=n_k/\alpha_k$，在有这个约束条件的情况下则为：
  $$
  \hat{\alpha}_k=\dfrac{n_k}{N}=\dfrac{\sum_{j=1}^N\hat{z}_{jk}}{N},\ k=1,2,\cdots,K
  $$

重复上述计算，直到对数自然函数值不再有明显的变化为止。



