Let $e_0$ be the number of runs in $V$ whose elements are $0$ and let $e_1$ be the number of runs whose elements are $1$. Obviously, $U=e_0+e_1$.

Let the runs of each kind be arranged in the ascending order of the indices of $v_i$. Let $r_{0j}$ be the number of elements $0$ in the $j^{\text{th}}$ run of that kind ($j=1,2,\cdots,e_0$) and let $r_{1j^{\prime}}$ be the number of element $1$ in the $j^{\prime \text{th}}$ run of that kind $(j^{\prime}=1,2,\cdots,e_1)$:
$$
\textcolor{red}{\underline{0\ 0}}\ 
\textcolor{green}{\underline{ 1\ 1\ 1}}\ 
\textcolor{red}{\underline{0}}\ 
\textcolor{green}{\underline{1}}\ 
\textcolor{red}{\underline{0\ 0}}\ 
\textcolor{green}{\underline{1}}\ 
\textcolor{red}{\underline{0}}\ 
\textcolor{green}{\underline{ 1\ 1\ 1\ 1\ 1}}
$$
$e_1=4$, $e_2=4$
$$
1,2\vert
3,4,5\vert
6\vert
7\vert
8,9\vert
10\vert
11\vert
12,13,14,15,16
$$

$$
r_{01}=2,\quad r_{02}=1,\quad r_{03}=2,\quad r_{04}=1
$$

$$
r_{01^\prime}=3,\quad r_{02^\prime}=1,\quad r_{03^\prime}=1,\quad r_{04^\prime}=5
$$

The following relations obviously hold:
$$
\begin{split}
&\sum_{j=1}^{e_0}r_{0j}=m\\
&\sum_{j^\prime=1}^{e_1}r_{1j^\prime}=n\\
\end{split}
$$

$$
1\le e_0\le m,\quad1\le e_1\le n
$$

$$
\vert e_0-e_1\vert\le1
$$

==why?==

**References**

[1] On a Test Whether Two Samples are From the Same Population