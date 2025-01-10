---
title: Realize a LaTeX Pseudo-code Block Using LaTeX `algorithm` and `algpseudocode` Package
toc: false
categories:
 - LaTeX
tags:
 - LaTeX algorithm
 - LaTeX algpseudocode
date: 2024-06-02 21:22:17 +0800
last_modified_at: 2025-01-09 15:40:27 +0800
---

Here is a LaTeX pseudo-code block example by LaTeX `algorithm` and `algpseudocode` package from the paper, *Wasserstein Generative Adversarial Networks*[^1][^2]:

```latex
\documentclass[a4paper,11pt]{article}
%\documentclass[a4paper,twocolumn]{article}
\usepackage{amsmath,amsfonts}
\usepackage{algorithm,algpseudocode}

\newcommand\PP{\mathbb{P}}

\begin{document}
\begin{algorithm}[t!]
\caption{WGAN, our proposed algorithm. All experiments in the paper
used the default values $\alpha = 0.00005$, $c = 0.01$, $m=64$, $n_{\text{critic}}=5$.}\label{algo::wgan}
	\begin{algorithmic}[1]
	 \Require: $\alpha$, the learning rate. $c$, the clipping parameter. $m$, the batch size. $n_{\text{critic}}$, the number of iterations of the critic per generator iteration.
	 \Require: $w_0$, initial critic parameters. $\theta_0$, initial generator's parameters.
	 \While{$\theta$ has not converged}
	   \For{$t = 0, ..., n_{\text{critic}}$}
	     \State Sample $\{x^{(i)}\}_{i=1}^m \sim \PP_r$ a batch from the real data.
	     \State Sample $\{z^{(i)}\}_{i=1}^m \sim p(z)$ a batch of prior samples.
	     \State $g_w \gets \nabla_w \left[\frac{1}{m}\sum_{i=1}^m f_w(x^{(i)}) - \frac{1}{m} \sum_{i=1}^m f_w(g_\theta(z^{(i)})) \right]$
	     \State $w \gets w + \alpha \cdot \text{RMSProp}(w, g_w) $
	     \State $w \gets \text{clip}(w, -c, c) $
	   \EndFor
	   \State Sample $\{z^{(i)}\}_{i=1}^m \sim p(z)$ a batch of prior samples.
	   \State $g_\theta \gets -\nabla_\theta \frac{1}{m} \sum_{i=1}^m f_w(g_\theta(z^{(i)}))$ 
	   \State $\theta \gets \theta - \alpha \cdot \text{RMSProp}(\theta, g_\theta)$
	 \EndWhile
	\end{algorithmic}
\end{algorithm}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501091545885.png" alt="image-20250109154531810" style="width:50%;" />

where the option `[1]` of `algorithmic` environment is to display the line numbers[^3]. If we delete it, so we have:

```latex
% ...
	\begin{algorithmic}
		% ...
	\end{algorithmic}
% ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501091551607.png" alt="image-20250109155117500" style="width:50%;" />

and if we use other certain number, like `[7]` for example, instead, we have:

```latex
% ...
	\begin{algorithmic}[7]
		% ...
	\end{algorithmic}
% ...
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501091553162.png" alt="image-20250109155311059" style="width:50%;" />

<br>

**References**

[^1]: [Wasserstein Generative Adversarial Networks](https://proceedings.mlr.press/v70/arjovsky17a.html).
[^2]: Arjovsky, Martin, Soumith Chintala, and Léon Bottou. "Wasserstein generative adversarial networks." *International conference on machine learning*. PMLR, 2017, [https://arxiv.org/abs/1701.07875](https://arxiv.org/abs/1701.07875).
[^3]: [Algorithms](https://www.overleaf.com/learn/latex/Algorithms).