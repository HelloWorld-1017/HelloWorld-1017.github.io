---
title: Some Common Circuit Component Diagrams Provided by the LaTeX CircuiTikZ Package
toc: false
categories:
 - Electrical Engineering
 - LaTeX
tags:
 - LaTeX circuitikz
 - LaTeX TikZ
 - TeX
date: 2025-06-14 16:53:22 +0800
last_modified_at: 2025-06-14 16:53:22 +0800
---

The Overleaf article[^1] provides some very efficient code to show various circuit component diagrams provided by the LaTeX CircuiTikZ package. I would collect them together and make a record in this post.

From this example we can see that the `circuitikz` environment is very flexible, even can be used in the `tabular` environment. Besides, `\kern` is a TeX primitive[^2], used to "get a specified amount of horizontal space"[^3].

{% raw %}

```latex
\documentclass[landscape,12pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage{circuitikz}
\renewcommand{\arraystretch}{3}
\pagestyle{empty}

\newcommand{\thiscirc}[1]{%
	\texttt{#1}\kern5pt\hfill
	\begin{circuitikz}%
		\draw (0,0) node [#1] {};
	\end{circuitikz}%
	{\hspace{5mm}}%
}

\newcommand{\bipole}[1]{%
	\texttt{#1}\kern5pt \hfill
	\begin{circuitikz}%
		\draw (0,0) to [#1] (2,0); 
	\end{circuitikz}%
	\hspace{5mm}%
}

\begin{document}

\newpage
\vspace*{\fill}
\begin{center}
	\begin{tabular}{lll} 
		\thiscirc{ground} & \thiscirc{sground} & \thiscirc{nground}\\
		\thiscirc{rground} & \thiscirc{pground} & \thiscirc{cground}\\
		\thiscirc{tlinestub} & \thiscirc{antenna} & \thiscirc{rxantenna}\\
	\end{tabular}
\end{center}
\vspace*{\fill}

\newpage
\vspace*{\fill}
\begin{center}
	\begin{tabular}{lll} 
		\bipole{ammeter} & \bipole{voltmeter} & \bipole{short}\\
		\bipole{open} & \bipole{lamp} & \bipole{generic}\\
		\bipole{tgeneric} & \bipole{ageneric} & \bipole{fullgeneric}\\
		\bipole{tfullgeneric} & \bipole{memristor} & \bipole{american resistor}\\
		\bipole{vR} & \bipole{american potentiometer} & \bipole{european resistor}\\
		\bipole{european resistor} & \bipole{european potentiometer} & \bipole{varistor}\\
		\bipole{photoresistor} & \bipole{thermocouple} & \bipole{thermistor}\\
		\bipole{thermistor ntc} & \bipole{fuse} & \bipole{afuse}\\
		\bipole{battery} & \bipole{battery1} & \bipole{european voltage source}\\
		\bipole{american voltage source} & \bipole{european current source} & \bipole{american current source}\\
	\end{tabular}
\end{center}
\vspace*{\fill}

\newpage
\vspace*{\fill}
\begin{center}
	\begin{tabular}{lll} 
		\bipole{empty diode} & \bipole{empty Schottky diode} & \bipole{empty Zener diode}\\
		\bipole{empty tunnel diode} & \bipole{photodiode} & \bipole{empty diode}\\
		\bipole{empty varcap} & \bipole{full diode} & \bipole{full Schottky diode}\\
		\bipole{full Zener diode} & \bipole{full tunnel diode} & \bipole{full photodiode}\\
		\bipole{full led} & \bipole{full varcap} & \bipole{squid}\\
		\bipole{barrier} & & \\
	\end{tabular}
\end{center}
\vspace*{\fill}

\newpage
\vspace*{\fill}
\begin{center}
	\begin{tabular}{lll} 
		\bipole{capacitor} & \bipole{polar capacitor} & \bipole{variable capacitor}\\
		\bipole{cute inductor} & \bipole{variable cute inductor} & \bipole{american inductor}\\
		\bipole{variable american inductor} & \bipole{european inductor} & \bipole{variable european inductor}\\
		\bipole{transmission line} & \bipole{vsourcesin} & \bipole{isourcesin}\\
		\bipole{closing switch} & \bipole{opening switch} & \bipole{push button}\\
	\end{tabular}
\end{center}
\vspace*{\fill}

\end{document}
```

{% endraw %}

![png-1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20250614172153341.png)

![png-2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20250614172203009.png)

![png-3](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20250614172210304.png)

![png-4](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20250614172217893.png)

<br>

**References**

[^1]: [CircuiTikz package](https://www.overleaf.com/learn/latex/CircuiTikz_package).
[^2]: [TeX primitives listed by TeX engine](https://www.overleaf.com/learn/latex/TeX_primitives_listed_by_TeX_engine).
[^3]: [TeX Kern Command](https://www.tutorialspoint.com/tex_commands/kern.htm).
