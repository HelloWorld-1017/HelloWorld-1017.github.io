Fermat’s Little Theorem and Fermat Primality Test

Prime Obsession

Number Theory



# Fermat’s little theorem

In number theory, Fermat’s little theorem states that if $p$ is a prime number, the for any integer $a$, the number $a^p-a$ is an integer multiple of $p$. In the notation of modular arithmetic, this is expressed as:
$$
a^p\equiv a\ (\text{mod}\ p)
$$
For example, for prime $\textcolor{red}{p=7}$, and $\textcolor{blue}{a=1,3,4,5,\ \text{or}\ 6}$, then we have:
$$
\begin{split}
&\textcolor{blue}{1}^{\textcolor{red}{7}}-\textcolor{blue}{1}=0=0\times\textcolor{blue}{1}\\
&\textcolor{blue}{3}^{\textcolor{red}{7}}-\textcolor{blue}{3}=2184=728\times\textcolor{blue}{3}\\
&\textcolor{blue}{4}^{\textcolor{red}{7}}-\textcolor{blue}{4}=16380=4095\times\textcolor{blue}{4}\\
&\textcolor{blue}{5}^{\textcolor{red}{7}}-\textcolor{blue}{5}=78120=11160\times\textcolor{blue}{5}\\
&\textcolor{blue}{6}^{\textcolor{red}{7}}-\textcolor{blue}{6} =279930=46655\times\textcolor{blue}{6}\\
\end{split}
$$
i.e.,
$$
\begin{split}
&\textcolor{blue}{1}^\textcolor{red}{7}\equiv\textcolor{blue}{1}\ (\text{mod}\ 7)\\
&\textcolor{blue}{3}^\textcolor{red}{7}\equiv\textcolor{blue}{3}\ (\text{mod}\ 7)\\
&\textcolor{blue}{4}^\textcolor{red}{7}\equiv\textcolor{blue}{4}\ (\text{mod}\ 7)\\
&\textcolor{blue}{5}^\textcolor{red}{7}\equiv\textcolor{blue}{5}\ (\text{mod}\ 7)\\
&\textcolor{blue}{6}^\textcolor{red}{7}\equiv\textcolor{blue}{6}\ (\text{mod}\ 7)\\
\end{split}
$$


```matlab
p = 7;
a = [1,3,4,5,6];
arrayfun(@(x,y,z) fprintf("p=%d, a=%d, a^p-a=%d, mod(a^p-a,a)=%d\n",p,x,y,z), ...
    a,a.^p-a,mod(a.^p-a,a))
```

```
p=7, a=1, a^p-a=0, mod(a^p-a,a)=0
p=7, a=3, a^p-a=2184, mod(a^p-a,a)=0
p=7, a=4, a^p-a=16380, mod(a^p-a,a)=0
p=7, a=5, a^p-a=78120, mod(a^p-a,a)=0
p=7, a=6, a^p-a=279930, mod(a^p-a,a)=0
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



# Fermat primality test





<br>

**References**

[1] [Fermat's little theorem - Wikipedia](https://en.wikipedia.org/wiki/Fermat%27s_little_theorem).

[^2]: [Coprime integers - Wikipedia](https://en.wikipedia.org/wiki/Coprime_integers).

[3] [Fermat primality test - Wikipedia](https://en.wikipedia.org/wiki/Fermat_primality_test).