---
title: LaTeX TikZ Option `execute at end picture`
toc: false
categories:
 - LaTeX
tags:
 - LaTeX TikZ
location: Buffalo, United States
date: 2025-11-08 15:18:01 -0500
last_modified_at: 2025-11-15 13:10:02 -0500
---

There is a LaTeX TikZ option `execute at end picture`[^1]:

<div class="quote--left" markdown="1">
`/tikz/execute at end picture=⟨code⟩`


This option installs `⟨code⟩` that will be executed at the end of the picture. Using this option multiple times will cause the code to accumulate. This option must also be given in the optional argument of the `{tikzpicture}` environment.

</div>

```latex
\documentclass[tikz]{standalone}
\usetikzlibrary{backgrounds}

\begin{document}
	
\begin{tikzpicture}[execute at end picture=%
	{
		\begin{pgfonlayer}{background}
			\path[fill=yellow,rounded corners]
			(current bounding box.south west) rectangle
			(current bounding box.north east);
		\end{pgfonlayer}
	}]
	\node at (0,0) {X};
	\node at (2,1) {Y};
\end{tikzpicture}

\end{document}
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251112223015461.png" alt="png-1" style="width:50%;" />

By the way, there is another similar option `execute at begin picture`[^1]:

<div class="quote--left" markdown="1">
`/tikz/execute at begin picture=⟨code⟩`

This option causes `⟨code⟩` to be executed at the beginning of the picture. This option must be given in the argument of the `{tikzpicture}` environment itself since this option will not have an effect otherwise. After all, the picture has already “started” later on. The effect of multiply setting this option accumulates.

This option is mainly used in styles like the `every picture` style to execute certain code at the start of a picture.

</div>

but if we use it in the above case, we can't get a normal output.

<br>

**References**

[^1]: [Hierarchical Structures: Package, Environments, Scopes, and Styles](https://tikz.dev/tikz-scopes#pgf./tikz/execute:at:begin:picture).
