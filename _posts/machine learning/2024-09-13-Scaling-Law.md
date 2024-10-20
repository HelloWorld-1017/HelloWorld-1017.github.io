---
title: Scaling Law in Machine Learning
toc: false
categories:
 - Machine Learning
date: 2024-09-13 09:33:51 +0800
last_modified_at: 2024-10-19 17:02:29 +0800
---

Scaling law in machine learning[^1]:

<div class="quote--left" markdown="1">

In machine learning, a <i class="term">neural scaling law</i> is an <i class="emphasize">empirical</i> scaling law that describes how neural network performance changes as key factors are scaled up or down. These factors typically include the number of parameters, training dataset size, and training cost.

In general, a neural model can be characterized by 4 parameters: size of the model, size of the training dataset, cost of training, error rate after training. Each of these four variables can be precisely defined into a real number. These are usually written as $N$, $D$, $C$, $L$ (number of parameters, dataset size, computing cost, loss).

A neural scaling law is a theoretical or empirical statistical law between these parameters. There are also other parameters with other scaling laws.

</div>

The abstract of paper, *Scaling Laws for Neural Language Models*[^2]: 

<div class="quote--left" markdown="1">

We study <i class="term">empirical scaling laws</i> for <i class="emphasize">language model performance</i> on the cross-entropy loss. The loss scales as a power-law with model size, dataset size, and the amount of compute used for training, with some trends spanning more than seven orders of magnitude. Other architectural details such as network width or depth have minimal effects within a wide range. Simple equations govern the dependence of overfitting on model/dataset size and the dependence of training speed on model size. These relationships allow us to <i class="emphasize">determine the optimal allocation of a fixed compute budget</i>. Larger models are significantly more sample-efficient, such that optimally compute-efficient training involves training very large models on a relatively modest amount of data and stopping significantly before convergence.

</div>

**References**

- [No Priors Ep. 80 \| With Andrej Karpathy from OpenAI and Tesla](https://www.youtube.com/watch?v=hM_h0UA7upI).

[^1]: [Neural scaling law](https://en.wikipedia.org/wiki/Neural_scaling_law).
[^2]: Kaplan, Jared, et al. "Scaling laws for neural language models." arXiv preprint arXiv:2001.08361 (2020), available at: [https://arxiv.org/abs/2001.08361](https://arxiv.org/abs/2001.08361).
