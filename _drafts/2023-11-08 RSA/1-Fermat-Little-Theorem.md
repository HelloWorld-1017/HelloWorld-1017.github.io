Fermat’s Little Theorem and Fermat Primality Test

Prime Obsession

Number Theory



# Fermat’s little theorem

In number theory, Fermat’s little theorem states that if $p$ is a prime number, the for any integer $a$, the number $a^p-a$ is an integer multiple of $p$. In the notation of modular arithmetic, this is expressed as:
$$
a^p\equiv a\ (\text{mod}\ p)
$$
<div id="example-1"></div>

For example, for prime $\textcolor{red}{p=7}$, and $\textcolor{blue}{a=1,3,4,5,\ \text{or}\ 6}$, then we have:
$$
\begin{split}
&\textcolor{blue}{1}^{\textcolor{red}{7}}-\textcolor{blue}{1}=0=0\times\textcolor{red}{7}=0\times\textcolor{blue}{1}\\
&\textcolor{blue}{3}^{\textcolor{red}{7}}-\textcolor{blue}{3}=2184=312\times\textcolor{red}{7}=728\times\textcolor{blue}{3}\\
&\textcolor{blue}{4}^{\textcolor{red}{7}}-\textcolor{blue}{4}=16380=2340\times\textcolor{red}{7}=4095\times\textcolor{blue}{4}\\
&\textcolor{blue}{5}^{\textcolor{red}{7}}-\textcolor{blue}{5}=78120=11160\times\textcolor{red}{7}=2232\times\textcolor{blue}{5}\\
&\textcolor{blue}{6}^{\textcolor{red}{7}}-\textcolor{blue}{6} =279930=39990\times\textcolor{red}{7}=6665\times\textcolor{blue}{6}\\
\end{split}
$$
i.e.,
$$
\begin{split}
&\textcolor{blue}{1}^\textcolor{red}{7}\equiv\textcolor{blue}{1}\ (\text{mod}\ \textcolor{red}{7})\\
&\textcolor{blue}{3}^\textcolor{red}{7}\equiv\textcolor{blue}{3}\ (\text{mod}\ \textcolor{red}{7})\\
&\textcolor{blue}{4}^\textcolor{red}{7}\equiv\textcolor{blue}{4}\ (\text{mod}\ \textcolor{red}{7})\\
&\textcolor{blue}{5}^\textcolor{red}{7}\equiv\textcolor{blue}{5}\ (\text{mod}\ \textcolor{red}{7})\\
&\textcolor{blue}{6}^\textcolor{red}{7}\equiv\textcolor{blue}{6}\ (\text{mod}\ \textcolor{red}{7})\\
\end{split}
$$


```matlab
p = 7;
a = [1,3,4,5,6];
arrayfun(@(x,y,z,m) fprintf("p=%d, a=%d, a^p-a=%d, mod(a^p-a,p)=%d, (a^p-a)/p=%.2f\n",p,x,y,z,m), ...
    a,a.^p-a,mod(a.^p-a,p),(a.^p-a)./p)
```

```
p=7, a=1, a^p-a=0, mod(a^p-a,p)=0, (a^p-a)/p=0.00
p=7, a=3, a^p-a=2184, mod(a^p-a,p)=0, (a^p-a)/p=312.00
p=7, a=4, a^p-a=16380, mod(a^p-a,p)=0, (a^p-a)/p=2340.00
p=7, a=5, a^p-a=78120, mod(a^p-a,p)=0, (a^p-a)/p=11160.00
p=7, a=6, a^p-a=279930, mod(a^p-a,p)=0, (a^p-a)/p=39990.00
```

$\textcolor{red}{p=2}$

```
p=2, a=1, a^p-a=0, mod(a^p-a,a)=0
p=2, a=3, a^p-a=6, mod(a^p-a,a)=0
p=2, a=4, a^p-a=12, mod(a^p-a,a)=0
p=2, a=5, a^p-a=20, mod(a^p-a,a)=0
p=2, a=6, a^p-a=30, mod(a^p-a,a)=0
```



If $a$ is not divisible by $p$, that is, if $a$ is coprime to $p$, then Fermat’s little theorem is equivalent to the statement that $a^{p-1}-1$ is an integer multiple of $p$, i.e.,
$$
a^{p-1}\equiv1\ (\text{mod}\ p)
$$


> The definition of Coprime integers [^2]: Two integers $a$ and $b$ are coprime, relatively prime, or mutually prime if the only positive integer that is a divisor of both of them is 1. Consequently, any prime number that divides $a$ does not divide $b$, and vice versa. This is equivalent to their greatest common divisor (GCD) being 1. We also could says that $a$ is prime to $b$ or $a$ is coprime with $b$.
>
> When the integers *a* and *b* are coprime, the standard way of expressing this fact in mathematical notation is to indicate that their greatest common divisor is one, by the formula $\text{gcd}(a,b)=1$ or $(a,b)=1$.
>
> It should be noted that, $a$ and $b$ are coprime dose not means that both $a$ and $b$ are primes. For example, $7$ and $10$ are coprime, i.e., $\mathrm{gcb}(7,10)=1$, but $10$ is not a prime.

In [Example 1](#example-1), $\mathrm{gcb}(p,a)=1$ for each $a$, so we have:
$$
\begin{split}
&\textcolor{blue}{1}^{\textcolor{red}{7}-1}-1=0=0\times\textcolor{red}{7}\\
&\textcolor{blue}{3}^{\textcolor{red}{7}-1}-1=728=104\times\textcolor{red}{7}\\
&\textcolor{blue}{4}^{\textcolor{red}{7}-1}-1=4095=585\times\textcolor{red}{7}\\
&\textcolor{blue}{5}^{\textcolor{red}{7}-1}-1=15624=2232\times\textcolor{red}{7}\\
&\textcolor{blue}{6}^{\textcolor{red}{7}-1}-1=46655=6665\times\textcolor{red}{7}\\
\end{split}
$$


```matlab
p = 7;
a = [1,3,4,5,6];
arrayfun(@(x,y,z,m) fprintf("p=%d, a=%d, a^(p-1)-1=%d, mod(a^(p-1)-1,p)=%d, (a^(p-1)-1)/p=%.4f\n",p,x,y,z,m), ...
    a,a.^(p-1)-1,mod(a.^(p-1)-1,p),(a.^(p-1)-1)/p)
```

```
p=7, a=1, a^(p-1)-1=0, mod(a^(p-1)-1,p)=0, (a^(p-1)-1)/p=0.0000
p=7, a=3, a^(p-1)-1=728, mod(a^(p-1)-1,p)=0, (a^(p-1)-1)/p=104.0000
p=7, a=4, a^(p-1)-1=4095, mod(a^(p-1)-1,p)=0, (a^(p-1)-1)/p=585.0000
p=7, a=5, a^(p-1)-1=15624, mod(a^(p-1)-1,p)=0, (a^(p-1)-1)/p=2232.0000
p=7, a=6, a^(p-1)-1=46655, mod(a^(p-1)-1,p)=0, (a^(p-1)-1)/p=6665.0000
```









# Fermat primality test











<br>

**References**

[1] [Fermat's little theorem - Wikipedia](https://en.wikipedia.org/wiki/Fermat%27s_little_theorem).

[^2]: [Coprime integers - Wikipedia](https://en.wikipedia.org/wiki/Coprime_integers).

[3] [Fermat primality test - Wikipedia](https://en.wikipedia.org/wiki/Fermat_primality_test).

[Fermat Primality Test - Baeldung on Computer Science](https://www.baeldung.com/cs/fermat-primality-test)

[Carmichael number - Wikipedia](https://en.wikipedia.org/wiki/Carmichael_number).