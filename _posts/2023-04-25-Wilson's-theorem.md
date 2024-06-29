---
layout: single
title: Wilson's Theorem
date: 2023-04-25 20:06:05 +0800
categories: 
 - Mathematics
tags:
 - Prime Obsession
 - Number Theory
---


# Wilson's Theorem

在代数和数论中，**Wilson's theorem**表明 [1,2] ：对于自然数$n>1$，**当且仅当**：

$$
(n-1)!\equiv -1 (\mathrm{mod}\ n)\label{eq1}
$$

$n$才是一个素数，即**式$\eqref{eq1}$是“$n$为素数”的一个充要条件**。例如，对于$n=11$，有：

$$
(11-1)!=3628800\notag
$$

$$
3628800\ \mathrm{mod}\ 11=-1\notag
$$

式$\eqref{eq1}$有另外两种等价形式：

$$
(n-1)!\equiv n-1 (\mathrm{mod}\ n)\label{eq2}
$$

$$
(n-1)!+1=kn,\ \text{where k is positive integer}.
$$

<br>

# Formula for primes Based on Wilson's theorem

根据Wilson's theorem，可以得到一个很简单的用于**精确**产生素数的公式（formula for primes）[3]：

注：*In number theory, a **formula for primes** is a formula generating the prime numbers, exactly and without exception* [3]. 
{: .notice--primary}

$$
f(n)=\Big\lfloor\dfrac{n!\ \mathrm{mod}\ (n+1)}{n}\Big\rfloor(n-1)+2\label{eq3}
$$

如果$n+1$是素数，那么根据$\eqref{eq2}$有$n!\equiv n(\mathrm{mod}\ n+1)$，因此$\eqref{eq3}$中的$\lfloor n!\ \mathrm{mod}\ (n+1)/n\rfloor=1$，$f(n)=n+1$，式$\eqref{eq3}$就产生了一个素数$n+1$；如果$n+1$不是素数，则$n!\ \mathrm{mod}\ (n+1)<n$，则$\lfloor n!\ \mathrm{mod}\ (n+1)/n\rfloor=0$，因此式$\eqref{eq3}$就产生了一个素数2。

但是，这种产生素数的方式是非常低效的，因为式$\eqref{eq3}$需要计算阶乘；对于非常大的$n$，阶乘的运算是非常庞大的。

<br>

**References**

[1] [Wilson's theorem - Wikipedia](https://en.wikipedia.org/wiki/Wilson's_theorem).

[2] [Formula of Generating Prime Numbers in Matlab](https://www.matlabassignmentexperts.com/formula-to-generate-prime-number.html).

[3] [Formula for primes - Wikipedia](https://en.wikipedia.org/wiki/Formula_for_primes).

