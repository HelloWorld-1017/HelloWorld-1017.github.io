---
title: Theorem Environments and Block Environments in LaTeX Beamer
toc: false
categories:
 - LaTeX
tag: 
 - LaTeX beamer
 - LaTeX listings
date: 2023-10-19 19:53:29 +0800
last_modified_at: 2025-01-26 15:53:25 +0800
---

```latex
\documentclass{beamer}
\usetheme{Warsaw}
\usepackage{listings}

\begin{document}
	\begin{frame}{Theorem Environments}
		\begin{columns}
			\begin{column}{0.5\textwidth}
				
				\begin{theorem}<1->[Name]
					(This is theorem environment.)
				\end{theorem}
				
				\begin{proof}<1->[Name]
					(This is proof environment.)
				\end{proof}
				
				\begin{example}<1->[Name]
					(This is example environment.)
				\end{example}
				
				\begin{definition}<1->[Name]
					(This is definition environment.)
				\end{definition}
			\end{column}
		
			\begin{column}{0.5\textwidth}
				\begin{corollary}<1->[Name]
					(This is corollary environment.)
				\end{corollary}
				
				\begin{fact}<1->[Name]
					(This is fact environment.)
				\end{fact}
				
				\begin{examples}<1->[Name]
					(This is examples environment.)
				\end{examples}
				
				\begin{definitions}<1->[Name]
					(This is definitions environment.)
				\end{definitions}
				
				\begin{lemma}<1->[Name]
					(This is lemma environment.)
				\end{lemma}
				
			\end{column}
		\end{columns}
	\end{frame}
	
	\begin{frame}[t]{Block Environments}
		
		\begin{block}<1->{block environment}
			This is block environment.
		\end{block}
		
		\begin{alertblock}<1->{alertblock environment}
			This is alertblock environment.
		\end{alertblock}
		
		\begin{exampleblock}<1->{exampleblock environment}
			This is exampleblock environment.
		\end{exampleblock}
	
	\end{frame}
\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310191950879.png" alt="new-1" style="zoom: 33%;" />

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310191952304.png" alt="new-2" style="zoom: 33%;" />

<br>

**References**

[1] [https://latex-beamer.com/tutorials/blocks/](https://latex-beamer.com/tutorials/blocks/).