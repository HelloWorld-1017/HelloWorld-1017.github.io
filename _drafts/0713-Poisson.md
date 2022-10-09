

# 泊松分布

In probability theory and statistics, the Poisson distribution is a **discrete** probability distribution that expresses the probability of **a given number of events** occurring **in a fixed interval of time or space** if these events (1) occur with a known constant mean rate and (2) independently of the time since the last event.

## 概率质量函数PMF

A discrete random variable $X$ is said to have a Poisson distribution, with parameter $\lambda >0$, if it has a probability mass function given by:
$$
f(k;\lambda)=P(X=k)=\dfrac{\lambda^ke^{-\lambda}}{k!}
$$
==定义域的问题==

where

-  $k$  is the number of occurrences 
-  $e$ is Euler's number!
-  $!$ is the factorial function
-  $\lambda$, one parameter

The equation can be adapted if, instead of the average number of events $\lambda$, we are given the average rate $r$ at which events occur. Then $\lambda=rt$, and:

$$
P(k\ events\ in\ interval\ t)=\dfrac{(rt)^ke^{-rt}}{k!}
$$

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220714081554818.png" alt="image-20220714081554818" style="zoom:67%;" />

```matlab
% MATLAB script
% Compute the PMF of the Poisson distribution with various parameters.
x = 0:15;
p1 = poisspdf(x,1);
p2 = poisspdf(x,4);
p3 = poisspdf(x, 10);

% Plot the PMF with bars of width 1.
figure
bar(x, p1, 1), hold on
bar(x, p2, 1), hold on
bar(x, p3, 1), hold off
alpha(0.5)
legend("\lambda=1", "\lambda=4", "\lambda=10");
xlabel('Occurences')
ylabel('P(X=k)')
title('Poisson distribution PMF')
```

> 上图仅仅展示了在区间 $[0, 15]$ 上的PMF图像，实际上，变量 $x$ 的的取值范围是 $[0,+\infty)$。

## 累积分布函数CDF
The cumulative distribution function (CDF) of the Poisson distribution is
$$
P(X\le x)=F(x\vert \lambda)=e^{-\lambda}\sum_{i=0}^{floor(x)}\dfrac{\lambda^i}{i!}
$$

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220714081624250.png" alt="image-20220714081624250" style="zoom:67%;" />

```matlab
% MATLAB script
% Compute Poisson Distribution CDF
x = 0:15;
F1 = poisscdf(x,1);
F2 = poisscdf(x,4);
F3 = poisscdf(x,10);

% Plot the CDF
figure
LineWidth = 1.7;
stairs(x, F1, LineWidth=LineWidth), hold on
stairs(x, F2, LineWidth=LineWidth), hold on
stairs(x, F3, LineWidth=LineWidth), hold off
legend("\lambda=1", "\lambda=4", "\lambda=10", "Location", "southeast");
xlabel('Occurences')
ylabel('$P(X\le k)$', Interpreter='latex')
title('Poisson distribution CDF')
```



## 均值和方差

The positive real number $\lambda$ is equal to the expected value of $X$ and also to its variance.
$$
\lambda=E(X)=Var(X)
$$

## 应用实例

The Poisson distribution may be useful to model events such as:

- the number of meteorites greater than 1 meter diameter that strike Earth in a year;
- the number of patients arriving in an emergency room between 10 and 11 pm; and
- the number of laser photons hitting a detector in a particular time interval.

## 前提假设

The Poisson distribution is an appropriate model if the following assumptions are true:

- $k$ is the number of times an event occurs in an interval and $k$ can take values 0, 1, 2, ….

- The occurrence of one event does not affect the probability that a second event will occur. That is, **events occur independently**.

- **The average rate at which events occur is independent of any occurrences**. For simplicity, this is usually assumed to be constant, but may in practice vary with time.

- **Two events cannot occur at exactly the same instant**; instead, at each very small sub-interval, either exactly one event occurs, or no event occurs.

If these conditions are true, then k is a Poisson random variable, and the distribution of k is a Poisson distribution.



## 和其他常用分布的联系

The Poisson distribution is also the limit of a binomial distribution, for which the probability of success for each trial equals λ divided by the number of trials, as the number of trials approaches infinity (see Related distributions).



# 泊松过程

## 定义

In probability, statistics and related fields, a Poisson point process is a type of random mathematical object that consists of points randomly located on a mathematical space. The Poisson point process is often called simply the Poisson process, but it is also called a Poisson random measure, Poisson random point field or Poisson point field.

This point process has convenient mathematical properties, which has led to it being frequently defined in Euclidean space and used as a mathematical model for seemingly random processes in numerous disciplines。

The process is named after French mathematician Siméon Denis Poisson despite Poisson never having studied the process. Its name derives from the fact that **if a collection of random points in some space forms a Poisson process, then the number of points in a region of finite size is a random variable with a Poisson distribution**.

The Poisson point process is often defined on the real line, where it can be considered as a **stochastic process**. In this setting, it is used, for example, in **queueing theory** to model random events, such as the arrival of customers at a store, phone calls at an exchange or occurrence of earthquakes, distributed in time.

> 实数轴，排队论

In the plane, the point process, also known as a **spatial Poisson process**, can represent the locations of scattered objects such as transmitters in a wireless network, particles colliding into a detector, or trees in a forest.

> 平面，空间泊松分布

In all settings, the Poisson point process has the property that **each point is stochastically independent to all the other points in the process,** which is why it is sometimes called a purely or completely random process.

局限性

Despite its wide use as a stochastic model of phenomena representable as points, the inherent nature of the process implies that it does not adequately describe phenomena where there is sufficiently strong interaction between the points. This has inspired the proposal of other point processes, some of which are constructed with the Poisson point process, that seek to capture such interaction.

The point process depends on a single mathematical object, which, depending on the context, may be a constant, a locally integrable function or, in more general settings, a Radon measure. In the first case, the constant, known as the rate or intensity, is the average density of the points in the Poisson process located in some region of space. The resulting point process is called a homogeneous or stationary Poisson point process. In the second case, the point process is called an inhomogeneous or nonhomogeneous Poisson point process, and the average density of points depend on the location of the underlying space of the Poisson point process. The word point is often omitted, but there are other Poisson processes of objects, which, instead of points, consist of more complicated mathematical objects such as lines and polygons, and such processes can be based on the Poisson point process. Both the homogeneous and nonhomogeneous Poisson point processes are particular cases of the generalized renewal process.



## 定义

Depending on the setting, the process has several equivalent definitions as well as definitions of varying generality owing to its many applications and characterizations. 

- The Poisson point process can be defined, studied and used in one dimension, for example, on the real line, where it can be interpreted as a counting process or part of a queueing model; 
- in higher dimensions such as the plane where it plays a role in stochastic geometry and spatial statistics;
- or on more general mathematical spaces.

Consequently, the notation, terminology and level of mathematical rigour used to define and study the Poisson point process and points processes in general vary according to the context.

Despite all this, the Poisson point process has two key properties, **(1) the Poisson property** and **(2) the independence property**, that play an essential role in all settings where the Poisson point process is used. The two properties are not logically independent; indeed, independence implies the Poisson distribution of point counts, but not the converse.

## Poisson distribution of point counts

A Poisson point process is characterized via the Poisson distribution. The Poisson distribution is the probability distribution of a random variable $N$ (called a Poisson random variable) such that the probability that $N$ equals $n$ is given by:
$$
\mathbb{P}\{N=n\}=\dfrac{\Lambda^n}{n!}e^{-\Lambda}
$$
where the parameter $\Lambda$ determines the shape of the distribution. (In fact, $\Lambda$  equals the expected value of $N$, $E(N)=\Lambda$)。

By definition, a Poisson point process has the property that **the number of points in a bounded region of the process's underlying space is a Poisson-distributed random variable**.

## Complete independence

Consider a collection of disjoint and bounded subregions of the underlying space. By definition, the number of points of a Poisson point process in each bounded subregion will be completely independent of all the others.

This property is known under several names such as <u>complete randomness</u>, <u>complete independence</u>, or independent scattering and is common to all Poisson point processes. In other words, **there is a lack of interaction between different regions and the points in general, which motivates the Poisson process being sometimes called a purely or completely random process.**

# 指数分布

In probability theory and statistics, the exponential distribution is **the probability distribution of <u>*the time*</u> between events in a Poisson point process**, i.e., a process in which events occur continuously and independently at a constant average rate. It is a particular case of the gamma distribution. It is the continuous analogue of the geometric distribution, and it has the key property of being memoryless. In addition to being used for the analysis of Poisson point processes it is found in various other contexts.

## 定义

The PDF of an exponential distribution is

$$
f(x;\lambda)=
\left\{
\begin{align*} 
&\lambda e^{-\lambda x},&x\ge0,\\
&0,&x\lt0\end{align*} 
\right.
$$

Here $\lambda>0$ is the parameter of the distribution, often called the rate parameter. The distribution is supported on the interval $[0,\infty]$. If a random variable X has this distribution, we write $X\sim \mathrm{Exp}(\lambda)$.

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220714100043144.png" alt="image-20220714100043144" style="zoom:67%;" />

```matlab
% MATLAB script
% Compute the pdf of an Exponential distribution with various parameters lambda
x = 0:0.1:10;
f1 = exppdf(x, 0.5);
f2 = exppdf(x, 1);
f3 = exppdf(x, 1.5);

% Plot the pdf
figure;
LineWidth = 1.7;
Interpreter = 'latex';
plot(x, f1, LineWidth=LineWidth), hold on
plot(x, f2, LineWidth=LineWidth), hold on
plot(x, f3, LineWidth=LineWidth), hold on
legend("\lambda=0.5", "\lambda=1", "\lambda=1.5");
xlabel('$x$', Interpreter=Interpreter)
ylabel('$P(x)$', Interpreter=Interpreter)
title('Exponential distribution PDF')
```

The exponential distribution exhibits infinite divisibility.

The CDF is given by 
$$
F(x;\lambda)=
\left\{
\begin{align*} 
&1-e^{-\lambda x},&x\ge0,\\
&0,&x\lt0\end{align*} 
\right.
$$

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220714100013943.png" alt="image-20220714100013943" style="zoom:67%;" />

```matlab
% MATLAB script
% Compute the Exponential distribution CDF with various parameters lambda
x = 0:0.1:10;
F1 = expcdf(x,0.5);
F2 = expcdf(x,1);
F3 = expcdf(x,1.5);

% Plot the cdf
figure;
LineWidth = 1.7;
Interpreter = 'latex';
plot(x, F1, LineWidth=LineWidth), hold on
plot(x, F2, LineWidth=LineWidth), hold on
plot(x, F3, LineWidth=LineWidth), hold on
legend("\lambda=0.5", "\lambda=1", "\lambda=1.5");
xlabel('$x$', Interpreter=Interpreter)
ylabel('$P(X\le x)$', Interpreter=Interpreter)
title('Exponential distribution CDF')
```

### 均值，方差，原点矩，中值



### 无记忆性(Memorylessness)






总结

1. 概率分布是一个离散分布

**参考**

[1] wikipedia

[2] matlab doc, poisson, exponential

