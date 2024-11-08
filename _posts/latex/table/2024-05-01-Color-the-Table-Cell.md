---
title: Color the Table Cell in LaTeX
categories:
 - LaTeX
tags:
 - LaTeX Table
toc: false
date: 2024-05-01 22:04:11 +0800
last_modified_at: 2024-05-01 22:04:11 +0800
---

Few days ago, when I was writing my blog[^1], I found Hosang's paper[^2], *What makes for effective detection proposals?*, which proposed the evaluation metric AR (Average Recall) for assessing the object detector performance. 

In the paper, the format of this table appealed to me:

![image-20240501194038559](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405011941493.png)

I rarely saw the colored table in papers before, so when I first saw this table I found that it's really an efficient and elegant way to make a comparison between numerical data, as Hosang explains in the table title:

- Green indicates improvement of at least 2 AP;
- Blue indicated minor change ($-2\le\text{AP}<2$);
- White indicates a decrease by more than 2 AP.

Luckily, Hosang uploaded TeX source file of their paper to arXiv website[^2], so I have the opportunity to see how they created it. 

From their `.tex` file, I identify the minimum available TeX code for reproducing this table:

{% raw %}

```latex
\documentclass[english,british,10pt,journal,compsoc]{IEEEtran}
\usepackage{amsmath}
\usepackage{babel}
\usepackage{colortbl}

\newcommand\celln{ } % White color
\newcommand\cellp{\cellcolor[rgb]{0.8510, 0.9176, 0.8275}} % Green cell
\newcommand\cellz{\cellcolor[rgb]{0.7882, 0.8549, 0.9725}} % Blue cell

\makeatletter
\@ifundefined{showcaptionsetup}{}{\PassOptionsToPackage{caption=false}{subfig}}
\usepackage{subfig}
\makeatother

\begin{document}
\begin{table*}
	\setlength\tabcolsep{2pt}
	\hspace*{\fill}
	\begin{tabular}{ccccccccccccccccccccccc}
		& {\scriptsize{}aero} & {\scriptsize{}bicycle} & {\scriptsize{}bird} & {\scriptsize{}boat} & {\scriptsize{}bottle} & {\scriptsize{}bus} & {\scriptsize{}car} & {\scriptsize{}cat} & {\scriptsize{}chair} & {\scriptsize{}cow} & {\scriptsize{}table} & {\scriptsize{}dog} & {\scriptsize{}horse} & {\scriptsize{}mbike} & {\scriptsize{}person} & {\scriptsize{}plant} & {\scriptsize{}sheep} & {\scriptsize{}sofa} & {\scriptsize{}train} & {\scriptsize{}tv} & {\scriptsize{}\quad{}} & {\scriptsize{}mean}\tabularnewline
		\hline 
		{\scriptsize{}LM-LLDA }\texttt{\scriptsize{}Dense} & {\scriptsize{}33.7} & {\scriptsize{}61.3} & {\scriptsize{}12.4} & {\scriptsize{}18.5} & {\scriptsize{}26.7} & {\scriptsize{}53.0} & {\scriptsize{}57.2} & {\scriptsize{}22.4} & {\scriptsize{}22.7} & {\scriptsize{}25.6} & {\scriptsize{}25.1} & {\scriptsize{}14.0} & {\scriptsize{}59.2} & {\scriptsize{}51.0} & {\scriptsize{}39.1} & {\scriptsize{}13.6} & {\scriptsize{}21.7} & {\scriptsize{}38.0} & {\scriptsize{}48.8} & {\scriptsize{}44.0} &  & {\scriptsize{}34.4}\tabularnewline
		\hline 
		\texttt{\scriptsize{}Bing} & {\scriptsize{}\celln-7.5} & {\scriptsize{}\celln-23.2} & {\scriptsize{}\celln-6.2} & {\scriptsize{}\celln-8.1} & {\scriptsize{}\celln-10.6} & {\scriptsize{}\celln-13.3} & {\scriptsize{}\celln-17.5} & {\scriptsize{}\celln-6.8} & {\scriptsize{}\celln-9.8} & {\scriptsize{}\celln-15.4} & {\scriptsize{}\celln-7.5} & {\scriptsize{}\cellz-1.4} & {\scriptsize{}\celln-19.6} & {\scriptsize{}\celln-19.0} & {\scriptsize{}\celln-16.1} & {\scriptsize{}\celln-3.4} & {\scriptsize{}\celln-6.6} & {\scriptsize{}\celln-18.1} & {\scriptsize{}\celln-18.8} & {\scriptsize{}\celln-10.0} &  & {\scriptsize{}\celln-11.9}\tabularnewline
		\texttt{\scriptsize{}CPMC} & {\scriptsize{}\cellz-1.0} & {\scriptsize{}\celln-15.0} & {\scriptsize{}\cellz-0.2} & {\scriptsize{}\celln-4.4} & {\scriptsize{}\celln-13.5} & {\scriptsize{}\cellz-1.8} & {\scriptsize{}\celln-9.2} & {\scriptsize{}\cellp3.2} & {\scriptsize{}\celln-9.1} & {\scriptsize{}\celln-2.6} & {\scriptsize{}\cellp5.1} & {\scriptsize{}\cellp2.2} & {\scriptsize{}\celln-4.2} & {\scriptsize{}\celln-4.8} & {\scriptsize{}\celln-7.0} & {\scriptsize{}\cellz-2.0} & {\scriptsize{}\celln-2.6} & {\scriptsize{}\cellz1.2} & {\scriptsize{}\celln-4.1} & {\scriptsize{}\celln-4.9} &  & {\scriptsize{}\celln-3.7}\tabularnewline
		\texttt{\textbf{\scriptsize{}EdgeBoxes}} & {\scriptsize{}\cellz-2.0} & {\scriptsize{}\celln-6.1} & {\scriptsize{}\cellz-0.7} & {\scriptsize{}\celln-3.8} & {\scriptsize{}\celln}\textbf{\scriptsize{}-6.7} & {\scriptsize{}\cellz}\textbf{\scriptsize{}0.6} & {\scriptsize{}\celln}\textbf{\scriptsize{}-5.8} & {\scriptsize{}\cellz-1.1} & {\scriptsize{}\cellz}\textbf{\scriptsize{}-2.0} & {\scriptsize{}\cellz-1.8} & {\scriptsize{}\celln-4.6} & {\scriptsize{}\cellz0.4} & {\scriptsize{}\cellz-1.3} & {\scriptsize{}\cellz}\textbf{\scriptsize{}-1.3} & {\scriptsize{}\celln-3.0} & {\scriptsize{}\cellz-1.7} & {\scriptsize{}\cellz}\textbf{\scriptsize{}-0.1} & {\scriptsize{}\cellz-0.9} & {\scriptsize{}\cellz-0.2} & {\scriptsize{}\cellz-1.1} &  & {\scriptsize{}\celln}\textbf{\scriptsize{}-2.2}\tabularnewline
		\texttt{\scriptsize{}Endres} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}-1.5}} & {\scriptsize{}\celln}\foreignlanguage{english}{\textbf{\scriptsize{}-5.8}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}-0.6}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-4.8}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-12.7}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}-1.1}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-7.1}} & {\scriptsize{}\cellp}\foreignlanguage{english}{{\scriptsize{}3.4}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-6.9}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-3.2}} & {\scriptsize{}\cellp}\foreignlanguage{english}{{\scriptsize{}4.7}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}1.9}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-2.4}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-2.4}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-7.7}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-2.8}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}-1.9}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}1.5}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}0.4}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-4.2}} &  & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-2.7}}\tabularnewline
		\texttt{\textbf{\scriptsize{}Geodesic}} & {\scriptsize{}\cellz-1.9} & {\scriptsize{}\celln-8.1} & {\scriptsize{}\cellz-0.2} & {\scriptsize{}\celln-4.6} & {\scriptsize{}\celln-14.4} & {\scriptsize{}\cellz0.6} & {\scriptsize{}\celln-6.5} & {\scriptsize{}\cellp2.6} & {\scriptsize{}\celln-7.3} & {\scriptsize{}\cellz}\textbf{\scriptsize{}-1.3} & {\scriptsize{}\cellp4.7} & {\scriptsize{}\cellp2.4} & {\scriptsize{}\celln-2.5} & {\scriptsize{}\celln-2.7} & {\scriptsize{}\celln-4.7} & {\scriptsize{}\cellz-1.2} & {\scriptsize{}\cellz-0.7} & {\scriptsize{}\cellz-0.1} & {\scriptsize{}\cellz}\textbf{\scriptsize{}1.9} & {\scriptsize{}\cellz0.2} &  & {\scriptsize{}\celln}\textbf{\scriptsize{}-2.2}\tabularnewline
		\texttt{\textbf{\scriptsize{}MCG}} & {\scriptsize{}\cellz-0.7} & {\scriptsize{}\celln-7.2} & {\scriptsize{}\cellz0.1} & {\scriptsize{}\celln-3.6} & {\scriptsize{}\celln}\textbf{\scriptsize{}-6.7} & {\scriptsize{}\cellz-1.2} & {\scriptsize{}\celln-7.0} & {\scriptsize{}\cellp3.4} & {\scriptsize{}\celln-3.2} & {\scriptsize{}\celln-2.3} & {\scriptsize{}\cellp5.0} & {\scriptsize{}\cellz1.9} & {\scriptsize{}\celln-3.5} & {\scriptsize{}\cellz}\textbf{\scriptsize{}-1.3} & {\scriptsize{}\cellz}\textbf{\scriptsize{}-1.5} & {\scriptsize{}\cellz}\textbf{\scriptsize{}-1.1} & {\scriptsize{}\cellz-1.3} & {\scriptsize{}\cellp2.2} & {\scriptsize{}\cellz0.3} & {\scriptsize{}\cellz}\textbf{\scriptsize{}0.5} &  & {\scriptsize{}\cellz}\textbf{\scriptsize{}-1.4}\tabularnewline
		\texttt{\scriptsize{}Objectness} & {\scriptsize{}\celln-10.3} & {\scriptsize{}\celln-15.1} & {\scriptsize{}\cellz-2.0} & {\scriptsize{}\celln-6.2} & {\scriptsize{}\celln-11.0} & {\scriptsize{}\celln-9.5} & {\scriptsize{}\celln-13.0} & {\scriptsize{}\celln-3.6} & {\scriptsize{}\celln-10.0} & {\scriptsize{}\celln-6.4} & {\scriptsize{}\celln-7.8} & {\scriptsize{}\cellz-1.0} & {\scriptsize{}\celln-11.6} & {\scriptsize{}\celln-15.9} & {\scriptsize{}\celln-13.0} & {\scriptsize{}\celln-2.7} & {\scriptsize{}\celln-5.8} & {\scriptsize{}\celln-11.2} & {\scriptsize{}\celln-10.9} & {\scriptsize{}\celln-12.9} &  & {\scriptsize{}\celln-9.0}\tabularnewline
		\texttt{\scriptsize{}Rahtu} & {\scriptsize{}\cellz-0.3} & {\scriptsize{}\celln-13.2} & {\scriptsize{}\cellz-0.3} & {\scriptsize{}\cellz}\textbf{\scriptsize{}-1.2} & {\scriptsize{}\celln-13.0} & {\scriptsize{}\cellz-0.6} & {\scriptsize{}\celln-12.0} & {\scriptsize{}\cellp3.3} & {\scriptsize{}\celln-10.5} & {\scriptsize{}\celln-4.3} & {\scriptsize{}\cellp2.0} & {\scriptsize{}\cellp2.1} & {\scriptsize{}\celln-3.2} & {\scriptsize{}\celln-4.9} & {\scriptsize{}\celln-7.9} & {\scriptsize{}\celln-2.8} & {\scriptsize{}\celln-4.9} & {\scriptsize{}\celln-5.0} & {\scriptsize{}\cellz0.0} & {\scriptsize{}\celln-3.7} &  & {\scriptsize{}\celln-4.0}\tabularnewline
		\texttt{\scriptsize{}Rand.Prim} & {\scriptsize{}\cellp}\textbf{\scriptsize{}2.1} & {\scriptsize{}\celln-10.4} & {\scriptsize{}\cellz-0.5} & {\scriptsize{}\celln-4.5} & {\scriptsize{}\celln-13.2} & {\scriptsize{}\cellz-1.9} & {\scriptsize{}\celln-10.1} & {\scriptsize{}\cellp5.0} & {\scriptsize{}\celln-6.7} & {\scriptsize{}\celln-3.5} & {\scriptsize{}\cellp2.0} & {\scriptsize{}\cellp2.4} & {\scriptsize{}\celln-4.4} & {\scriptsize{}\celln-5.1} & {\scriptsize{}\celln-10.0} & {\scriptsize{}\celln-2.3} & {\scriptsize{}\cellz-1.8} & {\scriptsize{}\cellz1.2} & {\scriptsize{}\celln-3.8} & {\scriptsize{}\celln-4.4} &  & {\scriptsize{}\celln-3.5}\tabularnewline
		\texttt{\scriptsize{}Rantalankila} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}0.5}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-13.6}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}0.3}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-3.0}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-12.9}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-3.6}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-9.0}} & {\scriptsize{}\cellp}\foreignlanguage{english}{{\scriptsize{}4.4}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-5.6}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-3.7}} & {\scriptsize{}\cellp}\foreignlanguage{english}{{\scriptsize{}4.1}} & {\scriptsize{}\cellp}\foreignlanguage{english}{{\scriptsize{}2.5}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-2.2}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-4.0}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-7.8}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-2.5}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-3.8}} & {\scriptsize{}\cellp}\foreignlanguage{english}{\textbf{\scriptsize{}2.1}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}-1.5}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}-0.7}} &  & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-3.0}}\tabularnewline
		\texttt{\textbf{\scriptsize{}Rigor}} & {\scriptsize{}\cellz1.7} & {\scriptsize{}\celln-7.9} & {\scriptsize{}\cellz0.5} & {\scriptsize{}\celln-4.1} & {\scriptsize{}\celln-12.4} & {\scriptsize{}\cellz-0.8} & {\scriptsize{}\celln-9.0} & {\scriptsize{}\cellp}\textbf{\scriptsize{}6.3} & {\scriptsize{}\celln-6.9} & {\scriptsize{}\cellz-1.7} & {\scriptsize{}\cellz1.8} & {\scriptsize{}\cellp}\textbf{\scriptsize{}2.9} & {\scriptsize{}\cellz}\textbf{\scriptsize{}-0.9} & {\scriptsize{}\celln-3.3} & {\scriptsize{}\celln-7.7} & {\scriptsize{}\cellz-1.8} & {\scriptsize{}\cellz-1.3} & {\scriptsize{}\cellz1.6} & {\scriptsize{}\cellz-1.2} & {\scriptsize{}\cellz-1.7} &  & {\scriptsize{}\celln}\textbf{\scriptsize{}-2.3}\tabularnewline
		\texttt{\textbf{\scriptsize{}SelectiveSearch}} & {\scriptsize{}\cellz1.3} & {\scriptsize{}\celln-7.7} & {\scriptsize{}\cellz}\textbf{\scriptsize{}1.0} & {\scriptsize{}\celln-4.3} & {\scriptsize{}\celln-11.1} & {\scriptsize{}\cellz-1.7} & {\scriptsize{}\celln-7.8} & {\scriptsize{}\cellp3.9} & {\scriptsize{}\celln-4.8} & {\scriptsize{}\cellz-1.5} & {\scriptsize{}\cellp}\textbf{\scriptsize{}5.4} & {\scriptsize{}\cellp2.2} & {\scriptsize{}\cellz-1.4} & {\scriptsize{}\celln-3.8} & {\scriptsize{}\celln-6.0} & {\scriptsize{}\cellz-1.5} & {\scriptsize{}\cellz-0.8} & {\scriptsize{}\cellz0.6} & {\scriptsize{}\celln-2.4} & {\scriptsize{}\celln-2.1} &  & {\scriptsize{}\celln}\textbf{\scriptsize{}-2.1}\tabularnewline
		\hline 
		\texttt{\scriptsize{}Gaussian} & {\scriptsize{}\celln-6.6} & {\scriptsize{}\celln-13.4} & {\scriptsize{}\cellz-0.7} & {\scriptsize{}\celln-4.4} & {\scriptsize{}\celln-15.0} & {\scriptsize{}\celln-6.1} & {\scriptsize{}\celln-16.0} & {\scriptsize{}\cellz0.9} & {\scriptsize{}\celln-9.1} & {\scriptsize{}\celln-8.0} & {\scriptsize{}\cellz0.3} & {\scriptsize{}\cellz1.2} & {\scriptsize{}\celln-4.2} & {\scriptsize{}\celln-6.9} & {\scriptsize{}\celln-10.3} & {\scriptsize{}\celln-2.3} & {\scriptsize{}\celln-6.5} & {\scriptsize{}\celln-4.5} & {\scriptsize{}\celln-3.6} & {\scriptsize{}\celln-12.1} &  & {\scriptsize{}\celln}\emph{\scriptsize{}-6.4}\tabularnewline
		\texttt{\scriptsize{}SlidingWindow} & {\scriptsize{}\celln-21.8} & {\scriptsize{}\celln-20.7} & {\scriptsize{}\celln-3.2} & {\scriptsize{}\celln-8.1} & {\scriptsize{}\celln-16.6} & {\scriptsize{}\celln-14.7} & {\scriptsize{}\celln-22.1} & {\scriptsize{}\cellz-0.7} & {\scriptsize{}\celln-9.8} & {\scriptsize{}\celln-11.7} & {\scriptsize{}\celln-10.2} & {\scriptsize{}\cellz-1.4} & {\scriptsize{}\celln-14.7} & {\scriptsize{}\celln-20.1} & {\scriptsize{}\celln-14.8} & {\scriptsize{}\celln-3.8} & {\scriptsize{}\celln-7.7} & {\scriptsize{}\celln-21.0} & {\scriptsize{}\celln-20.8} & {\scriptsize{}\celln-14.8} &  & {\scriptsize{}\celln-12.9}\tabularnewline
		\texttt{\scriptsize{}Superpixels} & {\scriptsize{}\celln-23.9} & {\scriptsize{}\celln-52.2} & {\scriptsize{}\celln-3.1} & {\scriptsize{}\celln-9.4} & {\scriptsize{}\celln-17.4} & {\scriptsize{}\celln-43.9} & {\scriptsize{}\celln-42.3} & {\scriptsize{}\celln-10.2} & {\scriptsize{}\celln-11.3} & {\scriptsize{}\celln-12.6} & {\scriptsize{}\celln-15.8} & {\scriptsize{}\celln-8.5} & {\scriptsize{}\celln-50.1} & {\scriptsize{}\celln-41.7} & {\scriptsize{}\celln-30.9} & {\scriptsize{}\celln-4.4} & {\scriptsize{}\celln-10.6} & {\scriptsize{}\celln-25.2} & {\scriptsize{}\celln-39.7} & {\scriptsize{}\celln-8.2} &  & {\scriptsize{}\celln-23.1}\tabularnewline
		\texttt{\scriptsize{}Uniform} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-3.2}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-18.8}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-4.0}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-4.8}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-15.2}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-8.6}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-16.6}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}0.2}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-10.4}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-8.8}} & {\scriptsize{}\cellp}\foreignlanguage{english}{{\scriptsize{}3.7}} & {\scriptsize{}\cellz}\foreignlanguage{english}{{\scriptsize{}1.3}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-6.6}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-11.3}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-10.2}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-3.6}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-8.9}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-5.8}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-5.1}} & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-20.2}} &  & {\scriptsize{}\celln}\foreignlanguage{english}{{\scriptsize{}-7.8}}\tabularnewline
		\hline 
		{\scriptsize{}Top methods avg.} & {\scriptsize{}\cellz-0.3} & {\scriptsize{}\celln-7.4} & {\scriptsize{}\cellz0.1} & {\scriptsize{}\celln-4.1} & {\scriptsize{}\celln-10.2} & {\scriptsize{}\cellz-0.5} & {\scriptsize{}\celln-7.2} & {\scriptsize{}\cellp3.0} & {\scriptsize{}\celln-4.8} & {\scriptsize{}\cellz-1.7} & {\scriptsize{}\cellp2.5} & {\scriptsize{}\cellp2.0} & {\scriptsize{}\cellz-1.9} & {\scriptsize{}\celln-2.5} & {\scriptsize{}\celln-4.6} & {\scriptsize{}\cellz-1.5} & {\scriptsize{}\cellz-0.8} & {\scriptsize{}\cellz0.7} & {\scriptsize{}\cellz-0.3} & {\scriptsize{}\cellz-0.8} &  & {\scriptsize{}\cellz-2.0}\tabularnewline
	\end{tabular}\hspace*{\fill}
	\protect\caption{\label{tab:pascal-llda-dpm-per-class}LM-LLDA detection results on
		PASCAL 2007 (with bounding box regression). The top row indicates
		the average precision (AP) of LM-LLDA alone, while the other rows
		show the difference in AP when adding proposal methods. Green indicates
		improvement of at least $2\,\mbox{AP}$, blue indicates minor change
		($-2\le\text{AP}<2$), and white indicates a decrease by more than
		$2\,\mbox{AP}$. \texttt{Edge\-Boxes} achieves top results on 6 of
		the 20 categories; \texttt{MCG} performs best overall with -1.4 mAP
		loss.}
\end{table*}
\end{document}
```

{% endraw %}

As can be seen, they mainly used the `\cellcolor` command provided by `colortbl` package[^3] to define two new control commands, `\cellp` and `\cellz`, in the preamble area to color the table cell to green and blue. 

It should be noted that, `\cellcolor` command only changes the background color of the table cell, rather than put a colorful box, which occupies a certain amount of space, in the cell. So, there is no input parameter for `\cellcolor` command (and hence newly defined command `\cellp` and `\cellz`).

When creating the table, the authors used a lot of two commands repeatedly, i.e., `\foreignlanguage{english}{}` and `\scriptsize{}`. Command `\foreignlanguage` is from `babel` package[^5] imported in the preamble area. The `babel` package is to "manage culturally-determined typographical (and other) rules for a wide range of languages"[^5].  Jan Hosang is a German[^4], so I think he had his own considerations to use this package, but here it's OK if I delete them. 

As for `\scriptsize{}`, it is used to change font size. I try to define a new environment `ScriptFont`, and put the table in it, to avoid using `\scriptsize{}` time and time again, like:

{% raw %}

```latex
\documentclass[english,british,10pt,journal,compsoc]{IEEEtran}
\usepackage{amsmath}
\usepackage{babel}
\usepackage{colortbl}

\newcommand\celln{ }
\newcommand\cellp{\cellcolor[rgb]{0.8510, 0.9176, 0.8275}}
\newcommand\cellz{\cellcolor[rgb]{0.7882, 0.8549, 0.9725}}

\makeatletter
\@ifundefined{showcaptionsetup}{}{\PassOptionsToPackage{caption=false}{subfig}}
\usepackage{subfig}
\makeatother

% Self-defined environment `ScriptFont`
\newenvironment{ScriptFont}{\scriptsize}{\normalsize}

\begin{document}
	\begin{table*}
		\setlength\tabcolsep{2pt}
		\hspace*{\fill}
		\begin{ScriptFont}
		\begin{tabular}{ccccccccccccccccccccccc}
			& aero & bicycle & bird & boat & bottle & bus & car & cat & chair & cow & table & dog & horse & mbike & person & plant & sheep & sofa & train & tv & \quad{} & mean \tabularnewline
			\hline 
			LM-LLDA \texttt{Dense} & 33.7 & 61.3 & 12.4 & 18.5 & 26.7 & 53.0 & 57.2 & 22.4 & 22.7 & 25.6 & 25.1 & 14.0 & 59.2 & 51.0 & 39.1 & 13.6 & 21.7 & 38.0 & 48.8 & 44.0 & & 34.4 \tabularnewline
			\hline 
			\texttt{Bing} & \celln-7.5 & \celln-23.2 & \celln-6.2 & \celln-8.1 & \celln-10.6 & \celln-13.3 & \celln-17.5 & \celln-6.8 & \celln-9.8 & \celln-15.4 & \celln-7.5 & \cellz-1.4 & \celln-19.6 & \celln-19.0 &\celln-16.1 & \celln-3.4 & \celln-6.6 & \celln-18.1 & \celln-18.8 & \celln-10.0 & & \celln-11.9 \tabularnewline
			\texttt{CPMC} & \cellz-1.0 & \celln-15.0 & \cellz-0.2 & \celln-4.4 & \celln-13.5 & \cellz-1.8 & \celln-9.2 & \cellp3.2 & \celln-9.1 & \celln-2.6 & \cellp5.1 & \cellp2.2 & \celln-4.2 & \celln-4.8 & \celln-7.0 & \cellz-2.0 & \celln-2.6 & \cellz1.2 & \celln-4.1 & \celln-4.9 & & \celln-3.7 \tabularnewline
			\texttt{\textbf{EdgeBoxes}} & \cellz-2.0 & \celln-6.1 & \cellz-0.7 & \celln-3.8 & \celln\textbf{-6.7} & \cellz\textbf{0.6} & \celln\textbf{-5.8} & \cellz-1.1 & \cellz\textbf{-2.0} & \cellz-1.8 & \celln-4.6 & \cellz0.4 & \cellz-1.3 & \cellz\textbf{-1.3} & \celln-3.0 & \cellz-1.7 & \cellz\textbf{-0.1} & \cellz-0.9 & \cellz-0.2 & \cellz-1.1 & & \celln\textbf{-2.2} \tabularnewline
			\texttt{Endres} & \cellz-1.5 & \celln\textbf{-5.8} & \cellz-0.6 & \celln-4.8 & \celln-12.7 & \cellz-1.1 & \celln-7.1 & \cellp3.4 & \celln-6.9 & \celln-3.2 & \cellp4.7 & \cellz1.9 & \celln-2.4 & \celln-2.4 & \celln-7.7 & \celln-2.8 & \cellz-1.9 & \cellz1.5 & \cellz0.4 & \celln-4.2 & & \celln-2.7 \tabularnewline
			\texttt{\textbf{Geodesic}} & \cellz-1.9 & \celln-8.1 & \cellz-0.2 & \celln-4.6 & \celln-14.4 & \cellz0.6 & \celln-6.5 & \cellp2.6 & \celln-7.3 & \cellz\textbf{-1.3} & \cellp4.7 & \cellp2.4 & \celln-2.5 & \celln-2.7 & \celln-4.7 & \cellz-1.2 & \cellz-0.7 & \cellz-0.1 & \cellz\textbf{1.9} & \cellz0.2 & & \celln\textbf{-2.2} \tabularnewline
			\texttt{\textbf{MCG}} & \cellz-0.7 & \celln-7.2 &\cellz0.1 & \celln-3.6 & \celln\textbf{-6.7} & \cellz-1.2 & \celln-7.0 & \cellp3.4 & \celln-3.2 & \celln-2.3 & \cellp5.0 & \cellz1.9 & \celln-3.5 & \cellz\textbf{-1.3} & \cellz\textbf{-1.5} & \cellz\textbf{-1.1} & \cellz-1.3 & \cellp2.2 & \cellz0.3 & \cellz\textbf{0.5} & & \cellz\textbf{-1.4} \tabularnewline
			\texttt{Objectness} & \celln-10.3 & \celln-15.1 & \cellz-2.0 & \celln-6.2 & \celln-11.0 & \celln-9.5 & \celln-13.0 & \celln-3.6 & \celln-10.0 & \celln-6.4 & \celln-7.8 & \cellz-1.0 & \celln-11.6 & \celln-15.9 & \celln-13.0 & \celln-2.7 & \celln-5.8 & \celln-11.2 & \celln-10.9 & \celln-12.9 & & \celln-9.0 \tabularnewline
			\texttt{Rahtu} & \cellz-0.3 & \celln-13.2 & \cellz-0.3 & \cellz\textbf{-1.2} & \celln-13.0 & \cellz-0.6 & \celln-12.0 & \cellp3.3 & \celln-10.5 & \celln-4.3 & \cellp2.0 & \cellp2.1 & \celln-3.2 & \celln-4.9 & \celln-7.9 & \celln-2.8 & \celln-4.9 & \celln-5.0 & \cellz0.0 & \celln-3.7 & & \celln-4.0 \tabularnewline
			\texttt{Rand.Prim} & \cellp\textbf{2.1} & \celln-10.4 & \cellz-0.5 & \celln-4.5 & \celln-13.2 & \cellz-1.9 & \celln-10.1 & \cellp5.0 & \celln-6.7 & \celln-3.5 & \cellp2.0 & \cellp2.4 & \celln-4.4 & \celln-5.1 & \celln-10.0 & \celln-2.3 & \cellz-1.8 & \cellz1.2 & \celln-3.8 & \celln-4.4 & & \celln-3.5 \tabularnewline
			\texttt{Rantalankila} & \cellz0.5 & \celln-13.6 & \cellz0.3 & \celln-3.0 & \celln-12.9 & \celln-3.6 & \celln-9.0 & \cellp4.4 & \celln-5.6 & \celln-3.7 & \cellp4.1 & \cellp2.5 & \celln-2.2 & \celln-4.0 & \celln-7.8 & \celln-2.5 & \celln-3.8 & \cellp\textbf{2.1} & \cellz-1.5 & \cellz-0.7 & & \celln-3.0 \tabularnewline
			\texttt{\textbf{Rigor}} & \cellz1.7 & \celln-7.9 & \cellz0.5 & \celln-4.1 & \celln-12.4 & \cellz-0.8 & \celln-9.0 & \cellp\textbf{6.3} & \celln-6.9 & \cellz-1.7 & \cellz1.8 & \cellp\textbf{2.9} & \cellz\textbf{-0.9} & \celln-3.3 & \celln-7.7 & \cellz-1.8 & \cellz-1.3 & \cellz1.6 & \cellz-1.2 & \cellz-1.7 & & \celln\textbf{-2.3} \tabularnewline
			\texttt{\textbf{SelectiveSearch}} & \cellz1.3 & \celln-7.7 & \cellz\textbf{1.0} & \celln-4.3 & \celln-11.1 & \cellz-1.7 & \celln-7.8 & \cellp3.9 & \celln-4.8 & \cellz-1.5 & \cellp\textbf{5.4} & \cellp2.2 & \cellz-1.4 & \celln-3.8 & \celln-6.0 & \cellz-1.5 & \cellz-0.8 & \cellz0.6 & \celln-2.4 & \celln-2.1 & & \celln\textbf{-2.1} \tabularnewline	
			\hline 
			\texttt{Gaussian} & \celln-6.6 & \celln-13.4 & \cellz-0.7 & \celln-4.4 & \celln-15.0 & \celln-6.1 & \celln-16.0 & \cellz0.9 & \celln-9.1 & \celln-8.0 & \cellz0.3 & \cellz1.2 & \celln-4.2 & \celln-6.9 & \celln-10.3 & \celln-2.3 & \celln-6.5 & \celln-4.5 & \celln-3.6 & \celln-12.1 & & \celln\emph{-6.4} \tabularnewline
			\texttt{SlidingWindow} & \celln-21.8 & \celln-20.7 & \celln-3.2 & \celln-8.1 & \celln-16.6 & \celln-14.7 & \celln-22.1 & \cellz-0.7 & \celln-9.8 & \celln-11.7 & \celln-10.2 & \cellz-1.4 & \celln-14.7 & \celln-20.1 & \celln-14.8 & \celln-3.8 & \celln-7.7 & \celln-21.0 & \celln-20.8 & \celln-14.8 & & \celln-12.9 \tabularnewline
			\texttt{Superpixels} & \celln-23.9 & \celln-52.2 & \celln-3.1 & \celln-9.4 & \celln-17.4 & \celln-43.9 & \celln-42.3 & \celln-10.2 & \celln-11.3 & \celln-12.6 & \celln-15.8 & \celln-8.5 & \celln-50.1 & \celln-41.7 & \celln-30.9 & \celln-4.4 & \celln-10.6 & \celln-25.2 & \celln-39.7 & \celln-8.2 & & \celln-23.1 \tabularnewline
			\texttt{Uniform} & \celln-3.2 & \celln-18.8 & \celln-4.0 & \celln-4.8 & \celln-15.2 & \celln-8.6 & \celln-16.6 & \cellz0.2 & \celln-10.4 & \celln-8.8 & \cellp3.7 & \cellz1.3 & \celln-6.6 & \celln-11.3 & \celln-10.2 & \celln-3.6 & \celln-8.9 & \celln-5.8 & \celln-5.1 & \celln-20.2 & & \celln-7.8 \tabularnewline
			\hline 
			Top methods avg. & \cellz-0.3 & \celln-7.4 & \cellz0.1 & \celln-4.1 & \celln-10.2 & \cellz-0.5 & \celln-7.2 & \cellp3.0 & \celln-4.8 & \cellz-1.7 & \cellp2.5 & \cellp2.0 & \cellz-1.9 & \celln-2.5 & \celln-4.6 & \cellz-1.5 & \cellz-0.8 & \cellz0.7 & \cellz-0.3 & \cellz-0.8 & & \cellz-2.0 \tabularnewline
		\end{tabular}\hspace*{\fill}
	\end{ScriptFont}
		\protect\caption{\label{tab:pascal-llda-dpm-per-class}LM-LLDA detection results on PASCAL 2007 (with bounding box regression). The top row indicates the average precision (AP) of LM-LLDA alone, while the other rows show the difference in AP when adding proposal methods. Green indicates improvement of at least $2\,\mbox{AP}$, blue indicates minor change ($-2\le\text{AP}<2$), and white indicates a decrease by more than $2\,\mbox{AP}$. \texttt{Edge\-Boxes} achieves top results on 6 of the 20 categories; \texttt{MCG} performs best overall with -1.4 mAP loss.}
	\end{table*}
\end{document}
```

{% endraw %}

However, the generated table is:

![image-20240501220531064](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405012205345.png)

It can be seen that, at this time, the `ScriptFont` environment not only changes the font size of contents in the table, but also changes the line space, making the table more compact but sort of bad-looking. 

So, anyway, Hosang's method is more preferable.

<br>

# References

[^1]: [The Metrics of Average Precision (AP) and Average Recall (AR) in Object Detection Tasks - What a starry night~](https://helloworld-1017.github.io/2024-05-01/17-40-09.html).
[^2]: Hosang, Jan, et al. "What makes for effective detection proposals?." *IEEE transactions on pattern analysis and machine intelligence* 38.4 (2015): 814-830, available at: [[1502.05082] What makes for effective detection proposals?](https://arxiv.org/abs/1502.05082).
[^3]: [CTAN: Package colortbl](https://ctan.org/pkg/colortbl?lang=en).
[^4]: [Jan Hosang](https://janhosang.com/).
[^5]: [CTAN: Package babel](https://ctan.org/pkg/babel?lang=en).
