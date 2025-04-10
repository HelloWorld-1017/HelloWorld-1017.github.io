---
title: Conditional Independence
toc: false
categories:
 - Mathematics
tags:
 - Probability Theory and Mathematical Statistics
date: 2025-04-10 10:04:41 +0800
last_modified_at: 2025-04-10 10:04:41 +0800
---

<div class="quote--left" markdown="1">

Let $A$, $B$, and $C$ be events. $A$ and $B$ are said to be <i class="term">conditionally independent</i> given $C$ if and only if $P(C)>0$ and:

$$
P(A\vert B,C) = P(A\vert C)\label{eq1}
$$

...

Equivalently, conditional independence may be stated as:

$$
P(A,B\vert C) = P(A\vert C)P(B\vert C)\label{eq2}
$$

</div>

Eq. $\eqref{eq1}$ means that “the probability of $A$ given $C$ is the same as the probability of $A$ given both $B$ and $C$, this equality expresses that <i class="emphasize">$B$ contributes nothing to the certainty of $A$</i>”[^1] and hence $A$ and $B$ are conditionally independent, given $C$. Eq. $\eqref{eq2}$ better expresses this meaning, and we can derive Eq. $\eqref{eq2}$ from Eq. $\eqref{eq1}$[^1]:

$$
\begin{split}
&P(A\vert B,C) = P(A\vert C)\\
\Rightarrow&\dfrac{P(A,B,C)}{P(B,C)} = \dfrac{P(A,C)}{P(C)}\\
\Rightarrow&P(A,B,C) = \dfrac{P(A,C)P(B,C)}{P(C)}\\
\Rightarrow&\dfrac{P(A,B,C)}{P(C)} = \dfrac{P(A,C)P(B,C)}{P(C)P(C)}\\
\Rightarrow&\dfrac{P(A,B,C)}{P(C)} = \dfrac{P(A,C)}{P(C)}\dfrac{P(B,C)}{P(C)}\\
\Rightarrow&P(A,B\vert C) = P(A\vert C)P(B\vert C)
\end{split}\notag
$$

Besides, it should be noted that, the fact that $A$ and $B$ are independent doesn’t means that they are conditionally independent given event $C$, like an example in video[^2]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202504101232186.png" alt="image-20250410123220888" style="width:67%;" />

From the right case we can see that $P(A,B)=P(A)P(B)$, but $P(A,B\vert C) = P(A\vert C)P(B\vert C)$, i.e. Eq. $\eqref{eq2}$, doesn’t hold.

By the way, the left Venn diagram can explain Eq. $\eqref{eq2}$ very well, but not clearly for Eq. $\eqref{eq1}$.

<br>

**References**

- [Review Notes and Supplementary Notes CS229 Course Machine Learning Standford University](https://www.ctanujit.org/uploads/2/5/3/9/25393293/mathematics_for_machine_learning__cs229__1.pdf), chapter 2: Probability Theory Review for Machine Learning, p. 5.

[^1]: [Conditional independence](https://en.wikipedia.org/wiki/Conditional_independence).
[^2]: [L03.5 Conditional Independence](https://www.youtube.com/watch?v=7B3cDe39lwY).
