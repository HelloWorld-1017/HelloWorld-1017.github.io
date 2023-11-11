Legendre Polynomials















$$
P_0(x)=1,\ P_n(x)=\dfrac1{2^nn!}\dfrac{\mathrm{d}^n}{\mathrm{d}x^n}(x^2-1)^n,\ \text{where}\ n=1,2,\cdots
$$




Let $\varphi(x)=(x^2-1)^n$,


$$
\begin{split}
\int_{-1}^1P_n(x)Q(x)\mathrm{d}x&=\int_{-1}^1Q(x)\Big(\dfrac1{2^nn!}\dfrac{\mathrm{d}^n}{\mathrm{d}x^n}(x^2-1)^n\Big)\mathrm{d}x\\
&=\dfrac1{2^nn!}\int_{-1}^1Q(x)\varphi^{(n)}(x)\mathrm{d}x\\
&=\dfrac1{2^nn!}Q(x)\varphi^{(n-1)}(x)\Big\vert_{-1}^1-\dfrac1{2^nn!}\int_{-1}^1Q'(x)\varphi^{(n-1)}(x)\mathrm{d}x\\
&=-\dfrac1{2^nn!}\int_{-1}^1Q'(x)\varphi^{(n-1)}(x)\mathrm{d}x\\
&=\dfrac1{2^nn!}\int_{-1}^1Q''(x)\varphi^{(n-2)}(x)\mathrm{d}x\\
&=\cdots\\
&=\dfrac{(-1)^n}{2^nn!}\int_{-1}^1Q^{(n)}(x)\varphi(x)\mathrm{d}x
\end{split}
$$
For each $Q(x)$ whose order is less than $n$, we have $Q^{(n)}\equiv 0$, therefore we have:
$$
\int_{-1}^1P_n(x)P_m(x)\mathrm{d}x=0,\ \text{if}\ m<n
$$
and similarly, we could get:
$$
\int_{-1}^1P_n(x)P_m(x)\mathrm{d}x=0,\ \text{if}\ m>n
$$
in coclusion, we have:
$$
\int_{-1}^1P_n(x)P_m(x)\mathrm{d}x=0,\ \text{if}\ m\ne n
$$
If $m=n$, i.e.,
$$
Q(x)=P_n(x)=\dfrac1{2^nn!}\varphi^{(n)}(x)
$$
we have:
$$
Q^{(n)}(x)=\dfrac{(2n)!}{2^nn!}
$$
therefore:
$$
\begin{split}
\int_{-1}^1P_n^2(x)\mathrm{d}x&=\dfrac{(-1)^n(2n)!}{2^{2n}(n!)^2}\int_{-1}^1\varphi(x)\mathrm{d}x\\
&=\dfrac{(-1)^n(2n)!}{2^{2n}(n!)^2}\int_{-1}^1(x^2-1)^n\mathrm{d}x\\
\textcolor{grey}{\Big(\text{Extract }(-1)^n\Big)}&=\dfrac{(2n)!}{2^{2n}(n!)^2}\int_{-1}^1(1-x^2)^n\mathrm{d}x\\
\textcolor{grey}{\Big(\text{As}\ (1-x^2)^n{\text{is an even function}}\Big)}&=\dfrac{2(2n)!}{2^{2n}(n!)^2}\int_0^1(1-x^2)^n\mathrm{d}x\\
\textcolor{grey}{\Big(\text{Let }x=\sin(t)\Big)}&=\dfrac{2(2n)!}{2^{2n}(n!)^2}\int_0^{\pi/2}\cos^{(2n+1)}(t)\mathrm{d}t\\
\end{split}
$$
According to Wallis' integrals [^2], we have:
$$
\begin{split}
\int_{-1}^1P_n^2(x)\mathrm{d}x&=\dfrac{2(2n)!}{2^{2n}(n!)^2}\int_0^{\pi/2}\cos^{(2n+1)}(t)\mathrm{d}t\\
&=\dfrac{2(2n)!}{2^{2n}(n!)^2}\times\dfrac{2^{2n}(n!)^2}{(2n+1)!}\\
&=\dfrac2{2n+1}
\end{split}
$$
Q.E.D.

<br>


$$
(n+1)P_{n+1}(x)=(2n+1)xP_n(x)-nP_{n-1}(x),\quad n=1,2,\cdots
$$









$$
\begin{split}
P_0(x)&=1\\
P_1(x)&=x\\
P_2(x)&=(3x^2-1)/2\\
P_3(x)&=(5x^3-3x)/2\\
P_4(x)&=(35x^4-30x^2+3)/8\\
P_5(x)&=(63x^5-70x^3+15x)/8\\
P_6(x)&=(231x^6-315x^4+105x^2-5)/16
\end{split}
$$


```matlab
x = -1:0.001:1;
P0 = ones(size(x));
P1 = @(x) x;
P2 = @(x) (3*x.^2-1)/2;
P3 = @(x) (5*x.^3-3*x)/2;
P4 = @(x) (35*x.^4-30*x.^2+3)/8;
P5 = @(x) (63*x.^5-70*x.^3+15*x)/8;
P6 = @(x) (231*x.^6-315*x.^4+105*x.^2-5)/16;

figure
hold(gca,"on")
box(gca,"on")
grid(gca,"on")
plot(x,P0,"LineWidth",1.5,"DisplayName","$P_0$")
plot(x,P1(x),"LineWidth",1.5,"DisplayName","$P_1$")
plot(x,P2(x),"LineWidth",1.5,"DisplayName","$P_2$")
plot(x,P3(x),"LineWidth",1.5,"DisplayName","$P_3$")
plot(x,P4(x),"LineWidth",1.5,"DisplayName","$P_4$")
plot(x,P5(x),"LineWidth",1.5,"DisplayName","$P_5$")
plot(x,P6(x),"LineWidth",1.5,"DisplayName","$P_6$")
yline(0,"LineWidth",1.5,"LineStyle","--","Color","k","HandleVisibility","off")
legend("Interpreter","latex","Location","northoutside","Orientation","horizontal")
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311102037562.png" alt="image-20231110203712486" style="zoom:67%;" />







**References**

[^1]: [Legendre polynomials - Wikipedia](https://en.wikipedia.org/wiki/Legendre_polynomials).
[^2]: [Wallis' integrals - Wikipedia](https://en.wikipedia.org/wiki/Wallis%27_integrals).









