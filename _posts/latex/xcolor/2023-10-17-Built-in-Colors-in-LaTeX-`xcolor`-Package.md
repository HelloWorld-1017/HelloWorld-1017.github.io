---
title: Built-in Colors in LaTeX `xcolor` Package
categories:
 - Design
 - MATLAB
 - LaTeX
 - R
tags:
 - LaTeX Box
 - LaTeX xcolor
date: 2023-10-17 18:16:22 +0800
last_modified_at: 2024-09-06 07:43:45 +0800
---

# 19 base colours (always available)

![image-20231017180425175](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231017180425175.png)

```latex
\documentclass{article}
\usepackage{geometry}
\geometry{a3paper}
\usepackage{xcolor}
\renewcommand{\baselinestretch}{1.2}
\pagestyle{empty} 
\newcommand\myfcolorbox[1]{\fcolorbox{black}{#1}{\phantom{\tiny{color}}} \textbf{#1}\quad}

\begin{document}
	\begin{center}
		\begin{tabular}{lllll}
			\myfcolorbox{black} & \myfcolorbox{darkgray} & \myfcolorbox{lime} & \myfcolorbox{pink} & \myfcolorbox{violet} \\ \myfcolorbox{blue} &
			\myfcolorbox{gray} & \myfcolorbox{magenta} & \myfcolorbox{purple} & \myfcolorbox{white} \\ \myfcolorbox{brown} & \myfcolorbox{green} &
			\myfcolorbox{olive} & \myfcolorbox{red} & \myfcolorbox{yellow} \\ \myfcolorbox{cyan} & \myfcolorbox{lightgray} & \myfcolorbox{orange} &
			\myfcolorbox{teal} &
		\end{tabular}
	\end{center}
\end{document}
```

<br>

# 68 colours via `dvipsnames` option

![image-20231017180457962](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231017180457962.png)

```latex
\documentclass{article}
\usepackage{geometry}
\geometry{a3paper}
\usepackage[dvipsnames]{xcolor}
\renewcommand{\baselinestretch}{1.2}
\pagestyle{empty}
\newcommand\myfcolorbox[1]{\fcolorbox{black}{#1}{\phantom{\tiny{color}}} \textbf{#1}\quad}

\begin{document}
	\begin{center}
		\begin{tabular}{llll}
			\myfcolorbox{GreenYellow} & \myfcolorbox{RubineRed} & \myfcolorbox{RoyalPurple} & \myfcolorbox{Emerald} \\ 
			\myfcolorbox{Yellow} & \myfcolorbox{WildStrawberry} & \myfcolorbox{BlueViolet} & \myfcolorbox{JungleGreen} \\ 
			\myfcolorbox{Goldenrod} & \myfcolorbox{Salmon} & \myfcolorbox{Periwinkle} & \myfcolorbox{SeaGreen} \\ 
			\myfcolorbox{Dandelion} & \myfcolorbox{CarnationPink} & \myfcolorbox{CadetBlue} & \myfcolorbox{Green} \\ 
			\myfcolorbox{Apricot} & \myfcolorbox{Magenta} & \myfcolorbox{CornflowerBlue} & \myfcolorbox{ForestGreen} \\ 
			\myfcolorbox{Peach} & \myfcolorbox{VioletRed} & \myfcolorbox{MidnightBlue} & \myfcolorbox{PineGreen} \\ 
			\myfcolorbox{Melon} & \myfcolorbox{Rhodamine} & \myfcolorbox{NavyBlue} & \myfcolorbox{LimeGreen} \\
			\myfcolorbox{YellowOrange} & \myfcolorbox{Mulberry} & \myfcolorbox{RoyalBlue} & \myfcolorbox{YellowGreen} \\
			\myfcolorbox{Orange} & \myfcolorbox{RedViolet} & \myfcolorbox{Blue} & \myfcolorbox{SpringGreen} \\
			\myfcolorbox{BurntOrange} & \myfcolorbox{Fuchsia} & \myfcolorbox{Cerulean} & \myfcolorbox{OliveGreen} \\
			\myfcolorbox{Bittersweet} & \myfcolorbox{Lavender} & \myfcolorbox{Cyan} & \myfcolorbox{RawSienna} \\
			\myfcolorbox{RedOrange} & \myfcolorbox{Thistle} & \myfcolorbox{ProcessBlue} & \myfcolorbox{Sepia} \\
			\myfcolorbox{Mahogany} & \myfcolorbox{Orchid} & \myfcolorbox{SkyBlue} & \myfcolorbox{Brown} \\
			\myfcolorbox{Maroon} & \myfcolorbox{DarkOrchid} & \myfcolorbox{Turquoise} & \myfcolorbox{Tan} \\
			\myfcolorbox{BrickRed} & \myfcolorbox{Purple} & \myfcolorbox{TealBlue} & \myfcolorbox{Gray} \\
			\myfcolorbox{Red} & \myfcolorbox{Plum} & \myfcolorbox{Aquamarine} & \myfcolorbox{Black} \\
			\myfcolorbox{OrangeRed} & \myfcolorbox{Violet} & \myfcolorbox{BlueGreen} & \myfcolorbox{White} \\
		\end{tabular}
	\end{center}
\end{document}
```

<br>

# 151 colours via `svgnames` option

![image-20231017181148199](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231017181148199.png)

```latex
\documentclass{article}
\usepackage{geometry}
\geometry{a3paper}
\usepackage[svgnames]{xcolor}
\renewcommand{\baselinestretch}{1.2}
\pagestyle{empty}
\newcommand\myfcolorbox[1]{\fcolorbox{black}{#1}{\phantom{\tiny{color}}} \textbf{#1}\quad}

\begin{document}
	\begin{raggedright}
		\begin{tabular}{llll}
			\myfcolorbox{AliceBlue} & \myfcolorbox{DarkKhaki} & \myfcolorbox{Green} & \myfcolorbox{LightSlateGrey} \\ 
			\myfcolorbox{AntiqueWhite} & \myfcolorbox{DarkMagenta} & \myfcolorbox{GreenYellow} & \myfcolorbox{LightSteelBlue} \\
			\myfcolorbox{Aqua} & \myfcolorbox{DarkOliveGreen} & \myfcolorbox{Grey} & \myfcolorbox{LightYellow} \\
			\myfcolorbox{Aquamarine} & \myfcolorbox{DarkOrange} & \myfcolorbox{Honeydew} & \myfcolorbox{Lime} \\
			\myfcolorbox{Azure} & \myfcolorbox{DarkOrchid} & \myfcolorbox{HotPink} & \myfcolorbox{LimeGreen} \\
			\myfcolorbox{Beige} & \myfcolorbox{DarkRed} & \myfcolorbox{IndianRed} & \myfcolorbox{Linen} \\
			\myfcolorbox{Bisque} & \myfcolorbox{DarkSalmon} & \myfcolorbox{Indigo} & \myfcolorbox{Magenta} \\
			\myfcolorbox{Black} & \myfcolorbox{DarkSeaGreen} & \myfcolorbox{Ivory} & \myfcolorbox{Maroon} \\
			\myfcolorbox{BlanchedAlmond} & \myfcolorbox{DarkSlateBlue} & \myfcolorbox{Khaki} & \myfcolorbox{MediumAquamarine} \\
			\myfcolorbox{Blue} & \myfcolorbox{DarkSlateGray} & \myfcolorbox{Lavender} & \myfcolorbox{MediumBlue} \\
			\myfcolorbox{BlueViolet} & \myfcolorbox{DarkSlateGrey} & \myfcolorbox{LavenderBlush} & \myfcolorbox{MediumOrchid} \\
			\myfcolorbox{Brown} & \myfcolorbox{DarkTurquoise} & \myfcolorbox{LawnGreen} & \myfcolorbox{MediumPurple} \\
			\myfcolorbox{BurlyWood} & \myfcolorbox{DarkViolet} & \myfcolorbox{LemonChiffon} & \myfcolorbox{MediumSeaGreen} \\
			\myfcolorbox{CadetBlue} & \myfcolorbox{DeepPink} & \myfcolorbox{LightBlue} & \myfcolorbox{MediumSlateBlue} \\
			\myfcolorbox{Chartreuse} & \myfcolorbox{DeepSkyBlue} & \myfcolorbox{LightCoral} & \myfcolorbox{MediumSpringGreen} \\
			\myfcolorbox{Chocolate} & \myfcolorbox{DimGray} & \myfcolorbox{LightCyan} & \myfcolorbox{MediumTurquoise} \\
			\myfcolorbox{Coral} & \myfcolorbox{DimGrey} & \myfcolorbox{LightGoldenrod} & \myfcolorbox{MediumVioletRed} \\
			\myfcolorbox{CornflowerBlue} & \myfcolorbox{DodgerBlue} & \myfcolorbox{LightGoldenrodYellow} & \myfcolorbox{MidnightBlue} \\
			\myfcolorbox{Cornsilk} & \myfcolorbox{FireBrick} & \myfcolorbox{LightGray} & \myfcolorbox{MintCream} \\
			\myfcolorbox{Crimson} & \myfcolorbox{FloralWhite} & \myfcolorbox{LightGreen} & \myfcolorbox{MistyRose} \\
			\myfcolorbox{Cyan} & \myfcolorbox{ForestGreen} & \myfcolorbox{LightGrey} & \myfcolorbox{Moccasin} \\
			\myfcolorbox{DarkBlue} & \myfcolorbox{Fuchsia} & \myfcolorbox{LightPink} & \myfcolorbox{NavajoWhite} \\
			\myfcolorbox{DarkCyan} & \myfcolorbox{Gainsboro} & \myfcolorbox{LightSalmon} & \myfcolorbox{Navy} \\
			\myfcolorbox{DarkGoldenrod} & \myfcolorbox{GhostWhite} & \myfcolorbox{LightSeaGreen} & \myfcolorbox{NavyBlue} \\
			\myfcolorbox{DarkGray} & \myfcolorbox{Gold} & \myfcolorbox{LightSkyBlue} & \myfcolorbox{OldLace} \\
			\myfcolorbox{DarkGreen} & \myfcolorbox{Goldenrod} & \myfcolorbox{LightSlateBlue} & \myfcolorbox{Olive} \\
			\myfcolorbox{DarkGrey} & \myfcolorbox{Gray} & \myfcolorbox{LightSlateGray} & \myfcolorbox{OliveDrab} \\
			\myfcolorbox{Orange} & \myfcolorbox{Plum} & \myfcolorbox{Sienna} & \myfcolorbox{Thistle} \\
			\myfcolorbox{OrangeRed} & \myfcolorbox{PowderBlue} & \myfcolorbox{Silver} & \myfcolorbox{Tomato} \\
			\myfcolorbox{Orchid} & \myfcolorbox{Purple} & \myfcolorbox{SkyBlue} & \myfcolorbox{Turquoise} \\
			\myfcolorbox{PaleGoldenrod} & \myfcolorbox{Red} & \myfcolorbox{SlateBlue} & \myfcolorbox{Violet} \\
			\myfcolorbox{PaleGreen} & \myfcolorbox{RosyBrown} & \myfcolorbox{SlateGray} & \myfcolorbox{VioletRed} \\
			\myfcolorbox{PaleTurquoise} & \myfcolorbox{RoyalBlue} & \myfcolorbox{SlateGrey} & \myfcolorbox{Wheat} \\
			\myfcolorbox{PaleVioletRed} & \myfcolorbox{SaddleBrown} & \myfcolorbox{Snow} & \myfcolorbox{White} \\
			\myfcolorbox{PapayaWhip} & \myfcolorbox{Salmon} & \myfcolorbox{SpringGreen} & \myfcolorbox{WhiteSmoke} \\
			\myfcolorbox{PeachPuff} & \myfcolorbox{SandyBrown} & \myfcolorbox{SteelBlue} & \myfcolorbox{Yellow} \\
			\myfcolorbox{Peru} & \myfcolorbox{SeaGreen} & \myfcolorbox{Tan} & \myfcolorbox{YellowGreen} \\
			\myfcolorbox{Pink} & \myfcolorbox{Seashell} & \myfcolorbox{Teal}
		\end{tabular}
	\end{raggedright}
\end{document}
```

where

![image-20231023142442209](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310231424288.png)

<br>

# 317 colours via `x11names` option

![image-20231017180606510](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231017180606510.png)

![image-20231017181223397](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231017181223397.png)

```latex
\documentclass{article}
\usepackage{geometry}
\geometry{a3paper}
\usepackage[x11names]{xcolor}
\usepackage{longtable}
\renewcommand{\baselinestretch}{1.2}
\pagestyle{empty}
\newcommand\myfcolorbox[1]{\fcolorbox{black}{#1}{\phantom{\tiny{color}}} \textbf{#1}\quad}

\begin{document}
	\begin{raggedright}
		\begin{longtable}{llll}
			\myfcolorbox{AntiqueWhite1} & \myfcolorbox{Chocolate3} & \myfcolorbox{DeepPink1} & \myfcolorbox{IndianRed3} \\ 
			\myfcolorbox{AntiqueWhite2} & \myfcolorbox{Chocolate4} & \myfcolorbox{DeepPink2} & \myfcolorbox{IndianRed4} \\ 
			\myfcolorbox{AntiqueWhite3} & \myfcolorbox{Coral1} & \myfcolorbox{DeepPink3} & \myfcolorbox{Ivory1} \\ 
			\myfcolorbox{AntiqueWhite4} & \myfcolorbox{Coral2} & \myfcolorbox{DeepPink4} & \myfcolorbox{Ivory2} \\ 
			\myfcolorbox{Aquamarine1} & \myfcolorbox{Coral3} & \myfcolorbox{DeepSkyBlue1} & \myfcolorbox{Ivory3} \\
			\myfcolorbox{Aquamarine2} & \myfcolorbox{Coral4} & \myfcolorbox{DeepSkyBlue2} & \myfcolorbox{Ivory4} \\
			\myfcolorbox{Aquamarine3} & \myfcolorbox{Cornsilk1} & \myfcolorbox{DeepSkyBlue3} & \myfcolorbox{Khaki1} \\
			\myfcolorbox{Aquamarine4} & \myfcolorbox{Cornsilk2} & \myfcolorbox{DeepSkyBlue4} & \myfcolorbox{Khaki2} \\
			\myfcolorbox{Azure1} & \myfcolorbox{Cornsilk3} & \myfcolorbox{DodgerBlue1} & \myfcolorbox{Khaki3} \\
			\myfcolorbox{Azure2} & \myfcolorbox{Cornsilk4} & \myfcolorbox{DodgerBlue2} & \myfcolorbox{Khaki4} \\
			\myfcolorbox{Azure3} & \myfcolorbox{Cyan1} & \myfcolorbox{DodgerBlue3} & \myfcolorbox{LavenderBlush1} \\
			\myfcolorbox{Azure4} & \myfcolorbox{Cyan2} & \myfcolorbox{DodgerBlue4} & \myfcolorbox{LavenderBlush2} \\
			\myfcolorbox{Bisque1} & \myfcolorbox{Cyan3} & \myfcolorbox{Firebrick1} & \myfcolorbox{LavenderBlush3} \\
			\myfcolorbox{Bisque2} & \myfcolorbox{Cyan4} & \myfcolorbox{Firebrick2} & \myfcolorbox{LavenderBlush4} \\
			\myfcolorbox{Bisque3} & \myfcolorbox{DarkGoldenrod1} & \myfcolorbox{Firebrick3} & \myfcolorbox{LemonChiffon1} \\
			\myfcolorbox{Bisque4} & \myfcolorbox{DarkGoldenrod2} & \myfcolorbox{Firebrick4} & \myfcolorbox{LemonChiffon2} \\
			\myfcolorbox{Blue1} & \myfcolorbox{DarkGoldenrod3} & \myfcolorbox{Gold1} & \myfcolorbox{LemonChiffon3} \\
			\myfcolorbox{Blue2} & \myfcolorbox{DarkGoldenrod4} & \myfcolorbox{Gold2} & \myfcolorbox{LemonChiffon4} \\
			\myfcolorbox{Blue3} & \myfcolorbox{DarkOliveGreen1} & \myfcolorbox{Gold3} & \myfcolorbox{LightBlue1} \\
			\myfcolorbox{Blue4} & \myfcolorbox{DarkOliveGreen2} & \myfcolorbox{Gold4} & \myfcolorbox{LightBlue2} \\
			\myfcolorbox{Brown1} & \myfcolorbox{DarkOliveGreen3} & \myfcolorbox{Goldenrod1} & \myfcolorbox{LightBlue3} \\
			\myfcolorbox{Brown2} & \myfcolorbox{DarkOliveGreen4} & \myfcolorbox{Goldenrod2} & \myfcolorbox{LightBlue4} \\
			\myfcolorbox{Brown3} & \myfcolorbox{DarkOrange1} & \myfcolorbox{Goldenrod3} & \myfcolorbox{LightCyan1} \\
			\myfcolorbox{Brown4} & \myfcolorbox{DarkOrange2} & \myfcolorbox{Goldenrod4} & \myfcolorbox{LightCyan2} \\
			\myfcolorbox{Burlywood1} & \myfcolorbox{DarkOrange3} & \myfcolorbox{Green1} & \myfcolorbox{LightCyan3} \\
			\myfcolorbox{Burlywood2} & \myfcolorbox{DarkOrange4} & \myfcolorbox{Green2} & \myfcolorbox{LightCyan4} \\
			\myfcolorbox{Burlywood3} & \myfcolorbox{DarkOrchid1} & \myfcolorbox{Green3} & \myfcolorbox{LightGoldenrod1} \\
			\myfcolorbox{Burlywood4} & \myfcolorbox{DarkOrchid2} & \myfcolorbox{Green4} & \myfcolorbox{LightGoldenrod2} \\
			\myfcolorbox{CadetBlue1} & \myfcolorbox{DarkOrchid3} & \myfcolorbox{Honeydew1} & \myfcolorbox{LightGoldenrod3} \\
			\myfcolorbox{CadetBlue2} & \myfcolorbox{DarkOrchid4} & \myfcolorbox{Honeydew2} & \myfcolorbox{LightGoldenrod4} \\
			\myfcolorbox{CadetBlue3} & \myfcolorbox{DarkSeaGreen1} & \myfcolorbox{Honeydew3} & \myfcolorbox{LightPink1} \\
			\myfcolorbox{CadetBlue4} & \myfcolorbox{DarkSeaGreen2} & \myfcolorbox{Honeydew4} & \myfcolorbox{LightPink2} \\
			\myfcolorbox{Chartreuse1} & \myfcolorbox{DarkSeaGreen3} & \myfcolorbox{HotPink1} & \myfcolorbox{LightPink3} \\
			\myfcolorbox{Chartreuse2} & \myfcolorbox{DarkSeaGreen4} & \myfcolorbox{HotPink2} & \myfcolorbox{LightPink4} \\
			\myfcolorbox{Chartreuse3} & \myfcolorbox{DarkSlateGray1} & \myfcolorbox{HotPink3} & \myfcolorbox{LightSalmon1} \\
			\myfcolorbox{Chartreuse4} & \myfcolorbox{DarkSlateGray2} & \myfcolorbox{HotPink4} & \myfcolorbox{LightSalmon2} \\
			\myfcolorbox{Chocolate1} & \myfcolorbox{DarkSlateGray3} & \myfcolorbox{IndianRed1} & \myfcolorbox{LightSalmon3} \\
			\myfcolorbox{Chocolate2} & \myfcolorbox{DarkSlateGray4} & \myfcolorbox{IndianRed2} & \myfcolorbox{LightSalmon4} \\
			\myfcolorbox{LightSkyBlue1} & \myfcolorbox{Orange3} & \myfcolorbox{RosyBrown1} & \myfcolorbox{SpringGreen3} \\
			\myfcolorbox{LightSkyBlue2} & \myfcolorbox{Orange4} & \myfcolorbox{RosyBrown2} & \myfcolorbox{SpringGreen4} \\
			\myfcolorbox{LightSkyBlue3} & \myfcolorbox{OrangeRed1} & \myfcolorbox{RosyBrown3} & \myfcolorbox{SteelBlue1} \\
			\myfcolorbox{LightSkyBlue4} & \myfcolorbox{OrangeRed2} & \myfcolorbox{RosyBrown4} & \myfcolorbox{SteelBlue2} \\
			\myfcolorbox{LightSteelBlue1} & \myfcolorbox{OrangeRed3} & \myfcolorbox{RoyalBlue1} & \myfcolorbox{SteelBlue3} \\
			\myfcolorbox{LightSteelBlue2} & \myfcolorbox{OrangeRed4} & \myfcolorbox{RoyalBlue2} & \myfcolorbox{SteelBlue4} \\
			\myfcolorbox{LightSteelBlue3} & \myfcolorbox{Orchid1} & \myfcolorbox{RoyalBlue3} & \myfcolorbox{Tan1} \\
			\myfcolorbox{LightSteelBlue4} & \myfcolorbox{Orchid2} & \myfcolorbox{RoyalBlue4} & \myfcolorbox{Tan2} \\
			\myfcolorbox{LightYellow1} & \myfcolorbox{Orchid3} & \myfcolorbox{Salmon1} & \myfcolorbox{Tan3} \\
			\myfcolorbox{LightYellow2} & \myfcolorbox{Orchid4} & \myfcolorbox{Salmon2} & \myfcolorbox{Tan4} \\
			\myfcolorbox{LightYellow3} & \myfcolorbox{PaleGreen1} & \myfcolorbox{Salmon3} & \myfcolorbox{Thistle1} \\
			\myfcolorbox{LightYellow4} & \myfcolorbox{PaleGreen2} & \myfcolorbox{Salmon4} & \myfcolorbox{Thistle2} \\
			\myfcolorbox{Magenta1} & \myfcolorbox{PaleGreen3} & \myfcolorbox{SeaGreen1} & \myfcolorbox{Thistle3} \\
			\myfcolorbox{Magenta2} & \myfcolorbox{PaleGreen4} & \myfcolorbox{SeaGreen2} & \myfcolorbox{Thistle4} \\
			\myfcolorbox{Magenta3} & \myfcolorbox{PaleTurquoise1} & \myfcolorbox{SeaGreen3} & \myfcolorbox{Tomato1} \\
			\myfcolorbox{Magenta4} & \myfcolorbox{PaleTurquoise2} & \myfcolorbox{SeaGreen4} & \myfcolorbox{Tomato2} \\
			\myfcolorbox{Maroon1} & \myfcolorbox{PaleTurquoise3} & \myfcolorbox{Seashell1} & \myfcolorbox{Tomato3} \\
			\myfcolorbox{Maroon2} & \myfcolorbox{PaleTurquoise4} & \myfcolorbox{Seashell2} & \myfcolorbox{Tomato4} \\
			\myfcolorbox{Maroon3} & \myfcolorbox{PaleVioletRed1} & \myfcolorbox{Seashell3} & \myfcolorbox{Turquoise1} \\
			\myfcolorbox{Maroon4} & \myfcolorbox{PaleVioletRed2} & \myfcolorbox{Seashell4} & \myfcolorbox{Turquoise2} \\
			\myfcolorbox{MediumOrchid1} & \myfcolorbox{PaleVioletRed3} & \myfcolorbox{Sienna1} & \myfcolorbox{Turquoise3} \\
			\myfcolorbox{MediumOrchid2} & \myfcolorbox{PaleVioletRed4} & \myfcolorbox{Sienna2} & \myfcolorbox{Turquoise4} \\
			\myfcolorbox{MediumOrchid3} & \myfcolorbox{PeachPuff1} & \myfcolorbox{Sienna3} & \myfcolorbox{VioletRed1} \\
			\myfcolorbox{MediumOrchid4} & \myfcolorbox{PeachPuff2} & \myfcolorbox{Sienna4} & \myfcolorbox{VioletRed2} \\
			\myfcolorbox{MediumPurple1} & \myfcolorbox{PeachPuff3} & \myfcolorbox{SkyBlue1} & \myfcolorbox{VioletRed3} \\
			\myfcolorbox{MediumPurple2} & \myfcolorbox{PeachPuff4} & \myfcolorbox{SkyBlue2} & \myfcolorbox{VioletRed4} \\
			\myfcolorbox{MediumPurple3} & \myfcolorbox{Pink1} & \myfcolorbox{SkyBlue3} & \myfcolorbox{Wheat1} \\
			\myfcolorbox{MediumPurple4} & \myfcolorbox{Pink2} & \myfcolorbox{SkyBlue4} & \myfcolorbox{Wheat2} \\
			\myfcolorbox{MistyRose1} & \myfcolorbox{Pink3} & \myfcolorbox{SlateBlue1} & \myfcolorbox{Wheat3} \\
			\myfcolorbox{MistyRose2} & \myfcolorbox{Pink4} & \myfcolorbox{SlateBlue2} & \myfcolorbox{Wheat4} \\
			\myfcolorbox{MistyRose3} & \myfcolorbox{Plum1} & \myfcolorbox{SlateBlue3} & \myfcolorbox{Yellow1} \\
			\myfcolorbox{MistyRose4} & \myfcolorbox{Plum2} & \myfcolorbox{SlateBlue4} & \myfcolorbox{Yellow2} \\
			\myfcolorbox{NavajoWhite1} & \myfcolorbox{Plum3} & \myfcolorbox{SlateGray1} & \myfcolorbox{Yellow3} \\
			\myfcolorbox{NavajoWhite2} & \myfcolorbox{Plum4} & \myfcolorbox{SlateGray2} & \myfcolorbox{Yellow4} \\
			\myfcolorbox{NavajoWhite3} & \myfcolorbox{Purple1} & \myfcolorbox{SlateGray3} & \myfcolorbox{Gray0} \\
			\myfcolorbox{NavajoWhite4} & \myfcolorbox{Purple2} & \myfcolorbox{SlateGray4} & \myfcolorbox{Green0} \\
			\myfcolorbox{OliveDrab1} & \myfcolorbox{Purple3} & \myfcolorbox{Snow1} & \myfcolorbox{Grey0} \\
			\myfcolorbox{OliveDrab2} & \myfcolorbox{Purple4} & \myfcolorbox{Snow2} & \myfcolorbox{Maroon0} \\
			\myfcolorbox{OliveDrab3} & \myfcolorbox{Red1} & \myfcolorbox{Snow3} & \myfcolorbox{Purple0} \\
			\myfcolorbox{OliveDrab4} & \myfcolorbox{Red2} & \myfcolorbox{Snow4} & \\
			\myfcolorbox{Orange1} & \myfcolorbox{Red3} & \myfcolorbox{SpringGreen1} & \\
			\myfcolorbox{Orange2} & \myfcolorbox{Red4} & \myfcolorbox{SpringGreen2} & \\
		\end{longtable}
	\end{raggedright}
\end{document}
```

where

![image-20231023142412049](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310231424194.png)

<br>

# RGB tuples and hexadecimal color value

Garrick’s blog[^3] provides a way using `tidyverse`[^4], a collection of R packages, to gather RGB-tuple of the colors defined in `xcolor` package. He extracts colour information from zipped files which are downloaded from `http://www.ukern.de/tex/xcolor/tex/svgnam.def.gz` and `http://www.ukern.de/tex/xcolor/tex/x11nam.def.gz`, and then organises colour tuples into a `.csv` file (Garrick provides this file in his blog[^3] as well). I want to reproduce it using MATLAB, but these two zipped files seems not common compressed format; I tried different ways but finally failed to open them. 

So here, for the convenience of future use, I downloaded the `xcolors.csv` file which Garrick provides [^3], and display its contents in MATLAB: 

```matlab
clc,clear,close all

colorTable = readtable("xcolors.csv");
colorStruct = table2struct(colorTable);
colors = struct();

numPerFig = 36;
vertSpace = 20;
colorBoxPositions = repmat([0,0,70,15],numPerFig,1)-[zeros(numPerFig,1),vertSpace*(1:numPerFig)',zeros(numPerFig,1),zeros(numPerFig,1)];
textxPosition_color1 = 100;
textxPosition_color2 = textxPosition_color1+170;
textxPosition_color3 = textxPosition_color2+170;
textxPosition_color4 = textxPosition_color3+170;

FontSize = 12;
FontName = "Helvetiva";
pic_idx = 0;
for idx = 1:height(colorStruct)
    i = mod(idx-1,numPerFig)+1;
    if i == 1
        figure("Color","w","Position",[682,42,902,953])
        hold(gca,"on")
        set(gca,"FontName","Times New Roman","DataAspectRatio",[1,1,1])
        pic_idx = pic_idx+1;
    end

    colorName = colorStruct(idx).color;
    RGBtuple1 = [colorStruct(idx).r,colorStruct(idx).g,colorStruct(idx).b];
    RGBtuple2 = round(RGBtuple1*255);
    RGBHEX = sprintf("%s%s","#",string(dec2hex(RGBtuple2,2))');
    colors(idx).colorName = colorName;
    colors(idx).RGBtuple1 = {RGBtuple1};
    colors(idx).RGBtuple2 = {RGBtuple2};
    colors(idx).RGBHex = {RGBHEX};

    r = rectangle("Position",colorBoxPositions(i,:), ...
        "FaceColor",RGBtuple1,"Curvature",0.5,"LineWidth",1.2);

    textyPosition = r.Position(2)+r.Position(4)/2;
    text(textxPosition_color1,textyPosition, ...
        colorName,"FontSize",FontSize,"FontName",FontName)
    text(textxPosition_color2,textyPosition, ...
        sprintf("(%.3f %.3f %.3f)",RGBtuple1), ...
        "FontSize",FontSize,"FontName",FontName)
    text(textxPosition_color3,textyPosition, ...
        sprintf("(%-3d %-3d %-3d)",RGBtuple2), ...
        "FontSize",FontSize,"FontName",FontName)
    text(textxPosition_color4,textyPosition, ...
        sprintf("%s",RGBHEX), ...
        "FontSize",FontSize,"FontName",FontName)
    xlim([-10,600])
    axis(gca,"off")

    if i == numPerFig
        exportgraphics(gca,sprintf("pic_%d.jpg",pic_idx),"Resolution",600)
    end
end

disp(struct2table(colors))
```

![pic_1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141644874.jpg)

![pic_2](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141645437.jpg)

![pic_3](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141645505.jpg)

![pic_4](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141645352.jpg)

![pic_5](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141645444.jpg)

![pic_6](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141645095.jpg)

![pic_7](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141646123.jpg)

![pic_8](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141646277.jpg)

![pic_9](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141646720.jpg)

![pic_10](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141646365.jpg)

![pic_11](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141646682.jpg)

![pic_12](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141648117.jpg)

![pic_13](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202403141648317.jpg)

```
           colorName                   RGBtuple1               RGBtuple2          RGBHex    
    ________________________    ________________________    _______________    _____________

    {'AliceBlue'           }    {[     0.9400 0.9720 1]}    {[240 248 255]}    {["#F0F8FF"]}
    {'AntiqueWhite'        }    {[0.9800 0.9200 0.8440]}    {[250 235 215]}    {["#FAEBD7"]}
    {'AntiqueWhite1'       }    {[     1 0.9360 0.8600]}    {[255 239 219]}    {["#FFEFDB"]}
    {'AntiqueWhite2'       }    {[0.9320 0.8750 0.8000]}    {[238 223 204]}    {["#EEDFCC"]}
    {'AntiqueWhite3'       }    {[0.8040 0.7520 0.6900]}    {[205 192 176]}    {["#CDC0B0"]}
    {'AntiqueWhite4'       }    {[0.5450 0.5120 0.4700]}    {[139 131 120]}    {["#8B8378"]}
    {'Aqua'                }    {[               0 1 1]}    {[  0 255 255]}    {["#00FFFF"]}
    {'Aquamarine'          }    {[     0.4980 1 0.8300]}    {[127 255 212]}    {["#7FFFD4"]}
    {'Aquamarine1'         }    {[     0.4980 1 0.8300]}    {[127 255 212]}    {["#7FFFD4"]}
    {'Aquamarine2'         }    {[0.4640 0.9320 0.7760]}    {[118 238 198]}    {["#76EEC6"]}
    {'Aquamarine3'         }    {[0.4000 0.8040 0.6680]}    {[102 205 170]}    {["#66CDAA"]}
    {'Aquamarine4'         }    {[0.2700 0.5450 0.4550]}    {[ 69 139 116]}    {["#458B74"]}
    {'Azure'               }    {[          0.9400 1 1]}    {[240 255 255]}    {["#F0FFFF"]}
    {'Azure1'              }    {[          0.9400 1 1]}    {[240 255 255]}    {["#F0FFFF"]}
    {'Azure2'              }    {[0.8800 0.9320 0.9320]}    {[224 238 238]}    {["#E0EEEE"]}
    {'Azure3'              }    {[0.7560 0.8040 0.8040]}    {[193 205 205]}    {["#C1CDCD"]}
    {'Azure4'              }    {[0.5120 0.5450 0.5450]}    {[131 139 139]}    {["#838B8B"]}
    {'Beige'               }    {[0.9600 0.9600 0.8640]}    {[245 245 220]}    {["#F5F5DC"]}
    {'Bisque'              }    {[     1 0.8940 0.7700]}    {[255 228 196]}    {["#FFE4C4"]}
    {'Bisque1'             }    {[     1 0.8940 0.7700]}    {[255 228 196]}    {["#FFE4C4"]}
    {'Bisque2'             }    {[0.9320 0.8350 0.7160]}    {[238 213 183]}    {["#EED5B7"]}
    {'Bisque3'             }    {[0.8040 0.7160 0.6200]}    {[205 183 158]}    {["#CDB79E"]}
    {'Bisque4'             }    {[0.5450 0.4900 0.4200]}    {[139 125 107]}    {["#8B7D6B"]}
    {'Black'               }    {[               0 0 0]}    {[      0 0 0]}    {["#000000"]}
    {'BlanchedAlmond'      }    {[     1 0.9200 0.8040]}    {[255 235 205]}    {["#FFEBCD"]}
    {'Blue'                }    {[               0 0 1]}    {[    0 0 255]}    {["#0000FF"]}
    {'Blue1'               }    {[               0 0 1]}    {[    0 0 255]}    {["#0000FF"]}
    {'Blue2'               }    {[          0 0 0.9320]}    {[    0 0 238]}    {["#0000EE"]}
    {'Blue3'               }    {[          0 0 0.8040]}    {[    0 0 205]}    {["#0000CD"]}
    {'Blue4'               }    {[          0 0 0.5450]}    {[    0 0 139]}    {["#00008B"]}
    {'BlueViolet'          }    {[0.5400 0.1700 0.8880]}    {[ 138 43 226]}    {["#8A2BE2"]}
    {'Brown'               }    {[0.6480 0.1650 0.1650]}    {[  165 42 42]}    {["#A52A2A"]}
    {'Brown1'              }    {[     1 0.2500 0.2500]}    {[  255 64 64]}    {["#FF4040"]}
    {'Brown2'              }    {[0.9320 0.2300 0.2300]}    {[  238 59 59]}    {["#EE3B3B"]}
    {'Brown3'              }    {[0.8040 0.2000 0.2000]}    {[  205 51 51]}    {["#CD3333"]}
    {'Brown4'              }    {[0.5450 0.1360 0.1360]}    {[  139 35 35]}    {["#8B2323"]}
    {'BurlyWood'           }    {[0.8700 0.7200 0.5300]}    {[222 184 135]}    {["#DEB887"]}
    {'Burlywood1'          }    {[     1 0.8280 0.6080]}    {[255 211 155]}    {["#FFD39B"]}
    {'Burlywood2'          }    {[0.9320 0.7720 0.5700]}    {[238 197 145]}    {["#EEC591"]}
    {'Burlywood3'          }    {[0.8040 0.6680 0.4900]}    {[205 170 125]}    {["#CDAA7D"]}
    {'Burlywood4'          }    {[0.5450 0.4500 0.3320]}    {[ 139 115 85]}    {["#8B7355"]}
    {'CadetBlue'           }    {[0.3720 0.6200 0.6280]}    {[ 95 158 160]}    {["#5F9EA0"]}
    {'CadetBlue1'          }    {[     0.5960 0.9600 1]}    {[152 245 255]}    {["#98F5FF"]}
    {'CadetBlue2'          }    {[0.5560 0.8980 0.9320]}    {[142 229 238]}    {["#8EE5EE"]}
    {'CadetBlue3'          }    {[0.4800 0.7720 0.8040]}    {[122 197 205]}    {["#7AC5CD"]}
    {'CadetBlue4'          }    {[0.3250 0.5250 0.5450]}    {[ 83 134 139]}    {["#53868B"]}
    {'Chartreuse'          }    {[          0.4980 1 0]}    {[  127 255 0]}    {["#7FFF00"]}
    {'Chartreuse1'         }    {[          0.4980 1 0]}    {[  127 255 0]}    {["#7FFF00"]}
    {'Chartreuse2'         }    {[     0.4640 0.9320 0]}    {[  118 238 0]}    {["#76EE00"]}
    {'Chartreuse3'         }    {[     0.4000 0.8040 0]}    {[  102 205 0]}    {["#66CD00"]}
    {'Chartreuse4'         }    {[     0.2700 0.5450 0]}    {[   69 139 0]}    {["#458B00"]}
    {'Chocolate'           }    {[0.8240 0.4100 0.1160]}    {[ 210 105 30]}    {["#D2691E"]}
    {'Chocolate1'          }    {[     1 0.4980 0.1400]}    {[ 255 127 36]}    {["#FF7F24"]}
    {'Chocolate2'          }    {[0.9320 0.4640 0.1300]}    {[ 238 118 33]}    {["#EE7621"]}
    {'Chocolate3'          }    {[0.8040 0.4000 0.1120]}    {[ 205 102 29]}    {["#CD661D"]}
    {'Chocolate4'          }    {[0.5450 0.2700 0.0750]}    {[  139 69 19]}    {["#8B4513"]}
    {'Coral'               }    {[     1 0.4980 0.3120]}    {[ 255 127 80]}    {["#FF7F50"]}
    {'Coral1'              }    {[     1 0.4480 0.3360]}    {[ 255 114 86]}    {["#FF7256"]}
    {'Coral2'              }    {[0.9320 0.4150 0.3120]}    {[ 238 106 80]}    {["#EE6A50"]}
    {'Coral3'              }    {[0.8040 0.3560 0.2700]}    {[  205 91 69]}    {["#CD5B45"]}
    {'Coral4'              }    {[0.5450 0.2440 0.1850]}    {[  139 62 47]}    {["#8B3E2F"]}
    {'CornflowerBlue'      }    {[0.3920 0.5850 0.9300]}    {[100 149 237]}    {["#6495ED"]}
    {'Cornsilk'            }    {[     1 0.9720 0.8640]}    {[255 248 220]}    {["#FFF8DC"]}
    {'Cornsilk1'           }    {[     1 0.9720 0.8640]}    {[255 248 220]}    {["#FFF8DC"]}
    {'Cornsilk2'           }    {[0.9320 0.9100 0.8040]}    {[238 232 205]}    {["#EEE8CD"]}
    {'Cornsilk3'           }    {[0.8040 0.7850 0.6940]}    {[205 200 177]}    {["#CDC8B1"]}
    {'Cornsilk4'           }    {[0.5450 0.5320 0.4700]}    {[139 136 120]}    {["#8B8878"]}
    {'Crimson'             }    {[0.8640 0.0800 0.2350]}    {[  220 20 60]}    {["#DC143C"]}
    {'Cyan'                }    {[               0 1 1]}    {[  0 255 255]}    {["#00FFFF"]}
    {'Cyan1'               }    {[               0 1 1]}    {[  0 255 255]}    {["#00FFFF"]}
    {'Cyan2'               }    {[     0 0.9320 0.9320]}    {[  0 238 238]}    {["#00EEEE"]}
    {'Cyan3'               }    {[     0 0.8040 0.8040]}    {[  0 205 205]}    {["#00CDCD"]}
    {'Cyan4'               }    {[     0 0.5450 0.5450]}    {[  0 139 139]}    {["#008B8B"]}
    {'DarkBlue'            }    {[          0 0 0.5450]}    {[    0 0 139]}    {["#00008B"]}
    {'DarkCyan'            }    {[     0 0.5450 0.5450]}    {[  0 139 139]}    {["#008B8B"]}
    {'DarkGoldenrod'       }    {[0.7200 0.5250 0.0440]}    {[ 184 134 11]}    {["#B8860B"]}
    {'DarkGoldenrod1'      }    {[     1 0.7250 0.0600]}    {[ 255 185 15]}    {["#FFB90F"]}
    {'DarkGoldenrod2'      }    {[0.9320 0.6800 0.0550]}    {[ 238 173 14]}    {["#EEAD0E"]}
    {'DarkGoldenrod3'      }    {[0.8040 0.5850 0.0480]}    {[ 205 149 12]}    {["#CD950C"]}
    {'DarkGoldenrod4'      }    {[0.5450 0.3960 0.0300]}    {[  139 101 8]}    {["#8B6508"]}
    {'DarkGray'            }    {[0.6640 0.6640 0.6640]}    {[169 169 169]}    {["#A9A9A9"]}
    {'DarkGreen'           }    {[          0 0.3920 0]}    {[    0 100 0]}    {["#006400"]}
    {'DarkGrey'            }    {[0.6640 0.6640 0.6640]}    {[169 169 169]}    {["#A9A9A9"]}
    {'DarkKhaki'           }    {[0.7400 0.7160 0.4200]}    {[189 183 107]}    {["#BDB76B"]}
    {'DarkMagenta'         }    {[     0.5450 0 0.5450]}    {[  139 0 139]}    {["#8B008B"]}
    {'DarkOliveGreen'      }    {[0.3320 0.4200 0.1850]}    {[  85 107 47]}    {["#556B2F"]}
    {'DarkOliveGreen1'     }    {[     0.7920 1 0.4400]}    {[202 255 112]}    {["#CAFF70"]}
    {'DarkOliveGreen2'     }    {[0.7360 0.9320 0.4080]}    {[188 238 104]}    {["#BCEE68"]}
    {'DarkOliveGreen3'     }    {[0.6350 0.8040 0.3520]}    {[ 162 205 90]}    {["#A2CD5A"]}
    {'DarkOliveGreen4'     }    {[0.4300 0.5450 0.2400]}    {[ 110 139 61]}    {["#6E8B3D"]}
    {'DarkOrange'          }    {[          1 0.5500 0]}    {[  255 140 0]}    {["#FF8C00"]}
    {'DarkOrange1'         }    {[          1 0.4980 0]}    {[  255 127 0]}    {["#FF7F00"]}
    {'DarkOrange2'         }    {[     0.9320 0.4640 0]}    {[  238 118 0]}    {["#EE7600"]}
    {'DarkOrange3'         }    {[     0.8040 0.4000 0]}    {[  205 102 0]}    {["#CD6600"]}
    {'DarkOrange4'         }    {[     0.5450 0.2700 0]}    {[   139 69 0]}    {["#8B4500"]}
    {'DarkOrchid'          }    {[0.6000 0.1960 0.8000]}    {[ 153 50 204]}    {["#9932CC"]}
    {'DarkOrchid1'         }    {[     0.7500 0.2440 1]}    {[ 191 62 255]}    {["#BF3EFF"]}
    {'DarkOrchid2'         }    {[0.6980 0.2280 0.9320]}    {[ 178 58 238]}    {["#B23AEE"]}
    {'DarkOrchid3'         }    {[0.6040 0.1960 0.8040]}    {[ 154 50 205]}    {["#9A32CD"]}
    {'DarkOrchid4'         }    {[0.4080 0.1320 0.5450]}    {[ 104 34 139]}    {["#68228B"]}
    {'DarkRed'             }    {[          0.5450 0 0]}    {[    139 0 0]}    {["#8B0000"]}
    {'DarkSalmon'          }    {[0.9120 0.5900 0.4800]}    {[233 150 122]}    {["#E9967A"]}
    {'DarkSeaGreen'        }    {[0.5600 0.7360 0.5600]}    {[143 188 143]}    {["#8FBC8F"]}
    {'DarkSeaGreen1'       }    {[     0.7560 1 0.7560]}    {[193 255 193]}    {["#C1FFC1"]}
    {'DarkSeaGreen2'       }    {[0.7050 0.9320 0.7050]}    {[180 238 180]}    {["#B4EEB4"]}
    {'DarkSeaGreen3'       }    {[0.6080 0.8040 0.6080]}    {[155 205 155]}    {["#9BCD9B"]}
    {'DarkSeaGreen4'       }    {[0.4100 0.5450 0.4100]}    {[105 139 105]}    {["#698B69"]}
    {'DarkSlateBlue'       }    {[0.2840 0.2400 0.5450]}    {[  72 61 139]}    {["#483D8B"]}
    {'DarkSlateGray'       }    {[0.1850 0.3100 0.3100]}    {[   47 79 79]}    {["#2F4F4F"]}
    {'DarkSlateGray1'      }    {[          0.5920 1 1]}    {[151 255 255]}    {["#97FFFF"]}
    {'DarkSlateGray2'      }    {[0.5520 0.9320 0.9320]}    {[141 238 238]}    {["#8DEEEE"]}
    {'DarkSlateGray3'      }    {[0.4750 0.8040 0.8040]}    {[121 205 205]}    {["#79CDCD"]}
    {'DarkSlateGray4'      }    {[0.3200 0.5450 0.5450]}    {[ 82 139 139]}    {["#528B8B"]}
    {'DarkSlateGrey'       }    {[0.1850 0.3100 0.3100]}    {[   47 79 79]}    {["#2F4F4F"]}
    {'DarkTurquoise'       }    {[     0 0.8080 0.8200]}    {[  0 206 209]}    {["#00CED1"]}
    {'DarkViolet'          }    {[     0.5800 0 0.8280]}    {[  148 0 211]}    {["#9400D3"]}
    {'DeepPink'            }    {[     1 0.0800 0.5760]}    {[ 255 20 147]}    {["#FF1493"]}
    {'DeepPink1'           }    {[     1 0.0800 0.5760]}    {[ 255 20 147]}    {["#FF1493"]}
    {'DeepPink2'           }    {[0.9320 0.0700 0.5360]}    {[ 238 18 137]}    {["#EE1289"]}
    {'DeepPink3'           }    {[0.8040 0.0640 0.4640]}    {[ 205 16 118]}    {["#CD1076"]}
    {'DeepPink4'           }    {[0.5450 0.0400 0.3120]}    {[  139 10 80]}    {["#8B0A50"]}
    {'DeepSkyBlue'         }    {[          0 0.7500 1]}    {[  0 191 255]}    {["#00BFFF"]}
    {'DeepSkyBlue1'        }    {[          0 0.7500 1]}    {[  0 191 255]}    {["#00BFFF"]}
    {'DeepSkyBlue2'        }    {[     0 0.6980 0.9320]}    {[  0 178 238]}    {["#00B2EE"]}
    {'DeepSkyBlue3'        }    {[     0 0.6040 0.8040]}    {[  0 154 205]}    {["#009ACD"]}
    {'DeepSkyBlue4'        }    {[     0 0.4080 0.5450]}    {[  0 104 139]}    {["#00688B"]}
    {'DimGray'             }    {[0.4100 0.4100 0.4100]}    {[105 105 105]}    {["#696969"]}
    {'DimGrey'             }    {[0.4100 0.4100 0.4100]}    {[105 105 105]}    {["#696969"]}
    {'DodgerBlue'          }    {[     0.1160 0.5650 1]}    {[ 30 144 255]}    {["#1E90FF"]}
    {'DodgerBlue1'         }    {[     0.1160 0.5650 1]}    {[ 30 144 255]}    {["#1E90FF"]}
    {'DodgerBlue2'         }    {[0.1100 0.5250 0.9320]}    {[ 28 134 238]}    {["#1C86EE"]}
    {'DodgerBlue3'         }    {[0.0940 0.4550 0.8040]}    {[ 24 116 205]}    {["#1874CD"]}
    {'DodgerBlue4'         }    {[0.0640 0.3050 0.5450]}    {[  16 78 139]}    {["#104E8B"]}
    {'FireBrick'           }    {[0.6980 0.1320 0.1320]}    {[  178 34 34]}    {["#B22222"]}
    {'Firebrick1'          }    {[     1 0.1900 0.1900]}    {[  255 48 48]}    {["#FF3030"]}
    {'Firebrick2'          }    {[0.9320 0.1720 0.1720]}    {[  238 44 44]}    {["#EE2C2C"]}
    {'Firebrick3'          }    {[0.8040 0.1500 0.1500]}    {[  205 38 38]}    {["#CD2626"]}
    {'Firebrick4'          }    {[0.5450 0.1000 0.1000]}    {[  139 26 26]}    {["#8B1A1A"]}
    {'FloralWhite'         }    {[     1 0.9800 0.9400]}    {[255 250 240]}    {["#FFFAF0"]}
    {'ForestGreen'         }    {[0.1320 0.5450 0.1320]}    {[  34 139 34]}    {["#228B22"]}
    {'Fuchsia'             }    {[               1 0 1]}    {[  255 0 255]}    {["#FF00FF"]}
    {'Gainsboro'           }    {[0.8640 0.8640 0.8640]}    {[220 220 220]}    {["#DCDCDC"]}
    {'GhostWhite'          }    {[     0.9720 0.9720 1]}    {[248 248 255]}    {["#F8F8FF"]}
    {'Gold'                }    {[          1 0.8440 0]}    {[  255 215 0]}    {["#FFD700"]}
    {'Gold1'               }    {[          1 0.8440 0]}    {[  255 215 0]}    {["#FFD700"]}
    {'Gold2'               }    {[     0.9320 0.7900 0]}    {[  238 201 0]}    {["#EEC900"]}
    {'Gold3'               }    {[     0.8040 0.6800 0]}    {[  205 173 0]}    {["#CDAD00"]}
    {'Gold4'               }    {[     0.5450 0.4600 0]}    {[  139 117 0]}    {["#8B7500"]}
    {'Goldenrod'           }    {[0.8550 0.6480 0.1250]}    {[ 218 165 32]}    {["#DAA520"]}
    {'Goldenrod1'          }    {[     1 0.7560 0.1450]}    {[ 255 193 37]}    {["#FFC125"]}
    {'Goldenrod2'          }    {[0.9320 0.7050 0.1320]}    {[ 238 180 34]}    {["#EEB422"]}
    {'Goldenrod3'          }    {[0.8040 0.6080 0.1120]}    {[ 205 155 29]}    {["#CD9B1D"]}
    {'Goldenrod4'          }    {[0.5450 0.4100 0.0800]}    {[ 139 105 20]}    {["#8B6914"]}
    {'Gray'                }    {[0.5000 0.5000 0.5000]}    {[128 128 128]}    {["#808080"]}
    {'Gray0'               }    {[0.7450 0.7450 0.7450]}    {[190 190 190]}    {["#BEBEBE"]}
    {'Green'               }    {[          0 0.5000 0]}    {[    0 128 0]}    {["#008000"]}
    {'Green0'              }    {[               0 1 0]}    {[    0 255 0]}    {["#00FF00"]}
    {'Green1'              }    {[               0 1 0]}    {[    0 255 0]}    {["#00FF00"]}
    {'Green2'              }    {[          0 0.9320 0]}    {[    0 238 0]}    {["#00EE00"]}
    {'Green3'              }    {[          0 0.8040 0]}    {[    0 205 0]}    {["#00CD00"]}
    {'Green4'              }    {[          0 0.5450 0]}    {[    0 139 0]}    {["#008B00"]}
    {'GreenYellow'         }    {[     0.6800 1 0.1850]}    {[ 173 255 47]}    {["#ADFF2F"]}
    {'Grey'                }    {[0.5000 0.5000 0.5000]}    {[128 128 128]}    {["#808080"]}
    {'Grey0'               }    {[0.7450 0.7450 0.7450]}    {[190 190 190]}    {["#BEBEBE"]}
    {'Honeydew'            }    {[     0.9400 1 0.9400]}    {[240 255 240]}    {["#F0FFF0"]}
    {'Honeydew1'           }    {[     0.9400 1 0.9400]}    {[240 255 240]}    {["#F0FFF0"]}
    {'Honeydew2'           }    {[0.8800 0.9320 0.8800]}    {[224 238 224]}    {["#E0EEE0"]}
    {'Honeydew3'           }    {[0.7560 0.8040 0.7560]}    {[193 205 193]}    {["#C1CDC1"]}
    {'Honeydew4'           }    {[0.5120 0.5450 0.5120]}    {[131 139 131]}    {["#838B83"]}
    {'HotPink'             }    {[     1 0.4100 0.7050]}    {[255 105 180]}    {["#FF69B4"]}
    {'HotPink1'            }    {[     1 0.4300 0.7050]}    {[255 110 180]}    {["#FF6EB4"]}
    {'HotPink2'            }    {[0.9320 0.4150 0.6550]}    {[238 106 167]}    {["#EE6AA7"]}
    {'HotPink3'            }    {[0.8040 0.3760 0.5650]}    {[ 205 96 144]}    {["#CD6090"]}
    {'HotPink4'            }    {[0.5450 0.2280 0.3850]}    {[  139 58 98]}    {["#8B3A62"]}
    {'IndianRed'           }    {[0.8040 0.3600 0.3600]}    {[  205 92 92]}    {["#CD5C5C"]}
    {'IndianRed1'          }    {[     1 0.4150 0.4150]}    {[255 106 106]}    {["#FF6A6A"]}
    {'IndianRed2'          }    {[0.9320 0.3900 0.3900]}    {[  238 99 99]}    {["#EE6363"]}
    {'IndianRed3'          }    {[0.8040 0.3320 0.3320]}    {[  205 85 85]}    {["#CD5555"]}
    {'IndianRed4'          }    {[0.5450 0.2280 0.2280]}    {[  139 58 58]}    {["#8B3A3A"]}
    {'Indigo'              }    {[     0.2940 0 0.5100]}    {[   75 0 130]}    {["#4B0082"]}
    {'Ivory'               }    {[          1 1 0.9400]}    {[255 255 240]}    {["#FFFFF0"]}
    {'Ivory1'              }    {[          1 1 0.9400]}    {[255 255 240]}    {["#FFFFF0"]}
    {'Ivory2'              }    {[0.9320 0.9320 0.8800]}    {[238 238 224]}    {["#EEEEE0"]}
    {'Ivory3'              }    {[0.8040 0.8040 0.7560]}    {[205 205 193]}    {["#CDCDC1"]}
    {'Ivory4'              }    {[0.5450 0.5450 0.5120]}    {[139 139 131]}    {["#8B8B83"]}
    {'Khaki'               }    {[0.9400 0.9000 0.5500]}    {[240 230 140]}    {["#F0E68C"]}
    {'Khaki1'              }    {[     1 0.9650 0.5600]}    {[255 246 143]}    {["#FFF68F"]}
    {'Khaki2'              }    {[0.9320 0.9000 0.5200]}    {[238 230 133]}    {["#EEE685"]}
    {'Khaki3'              }    {[0.8040 0.7760 0.4500]}    {[205 198 115]}    {["#CDC673"]}
    {'Khaki4'              }    {[0.5450 0.5250 0.3050]}    {[ 139 134 78]}    {["#8B864E"]}
    {'Lavender'            }    {[0.9000 0.9000 0.9800]}    {[230 230 250]}    {["#E6E6FA"]}
    {'LavenderBlush'       }    {[     1 0.9400 0.9600]}    {[255 240 245]}    {["#FFF0F5"]}
    {'LavenderBlush1'      }    {[     1 0.9400 0.9600]}    {[255 240 245]}    {["#FFF0F5"]}
    {'LavenderBlush2'      }    {[0.9320 0.8800 0.8980]}    {[238 224 229]}    {["#EEE0E5"]}
    {'LavenderBlush3'      }    {[0.8040 0.7560 0.7720]}    {[205 193 197]}    {["#CDC1C5"]}
    {'LavenderBlush4'      }    {[0.5450 0.5120 0.5250]}    {[139 131 134]}    {["#8B8386"]}
    {'LawnGreen'           }    {[     0.4880 0.9900 0]}    {[  124 252 0]}    {["#7CFC00"]}
    {'LemonChiffon'        }    {[     1 0.9800 0.8040]}    {[255 250 205]}    {["#FFFACD"]}
    {'LemonChiffon1'       }    {[     1 0.9800 0.8040]}    {[255 250 205]}    {["#FFFACD"]}
    {'LemonChiffon2'       }    {[0.9320 0.9120 0.7500]}    {[238 233 191]}    {["#EEE9BF"]}
    {'LemonChiffon3'       }    {[0.8040 0.7900 0.6480]}    {[205 201 165]}    {["#CDC9A5"]}
    {'LemonChiffon4'       }    {[0.5450 0.5360 0.4400]}    {[139 137 112]}    {["#8B8970"]}
    {'LightBlue'           }    {[0.6800 0.8480 0.9000]}    {[173 216 230]}    {["#ADD8E6"]}
    {'LightBlue1'          }    {[     0.7500 0.9360 1]}    {[191 239 255]}    {["#BFEFFF"]}
    {'LightBlue2'          }    {[0.6980 0.8750 0.9320]}    {[178 223 238]}    {["#B2DFEE"]}
    {'LightBlue3'          }    {[0.6040 0.7520 0.8040]}    {[154 192 205]}    {["#9AC0CD"]}
    {'LightBlue4'          }    {[0.4080 0.5120 0.5450]}    {[104 131 139]}    {["#68838B"]}
    {'LightCoral'          }    {[0.9400 0.5000 0.5000]}    {[240 128 128]}    {["#F08080"]}
    {'LightCyan'           }    {[          0.8800 1 1]}    {[224 255 255]}    {["#E0FFFF"]}
    {'LightCyan1'          }    {[          0.8800 1 1]}    {[224 255 255]}    {["#E0FFFF"]}
    {'LightCyan2'          }    {[0.8200 0.9320 0.9320]}    {[209 238 238]}    {["#D1EEEE"]}
    {'LightCyan3'          }    {[0.7050 0.8040 0.8040]}    {[180 205 205]}    {["#B4CDCD"]}
    {'LightCyan4'          }    {[0.4800 0.5450 0.5450]}    {[122 139 139]}    {["#7A8B8B"]}
    {'LightGoldenrod'      }    {[0.9330 0.8670 0.5100]}    {[238 221 130]}    {["#EEDD82"]}
    {'LightGoldenrod1'     }    {[     1 0.9250 0.5450]}    {[255 236 139]}    {["#FFEC8B"]}
    {'LightGoldenrod2'     }    {[0.9320 0.8640 0.5100]}    {[238 220 130]}    {["#EEDC82"]}
    {'LightGoldenrod3'     }    {[0.8040 0.7450 0.4400]}    {[205 190 112]}    {["#CDBE70"]}
    {'LightGoldenrod4'     }    {[0.5450 0.5050 0.2980]}    {[ 139 129 76]}    {["#8B814C"]}
    {'LightGoldenrodYellow'}    {[0.9800 0.9800 0.8240]}    {[250 250 210]}    {["#FAFAD2"]}
    {'LightGray'           }    {[0.8280 0.8280 0.8280]}    {[211 211 211]}    {["#D3D3D3"]}
    {'LightGreen'          }    {[0.5650 0.9320 0.5650]}    {[144 238 144]}    {["#90EE90"]}
    {'LightGrey'           }    {[0.8280 0.8280 0.8280]}    {[211 211 211]}    {["#D3D3D3"]}
    {'LightPink'           }    {[     1 0.7120 0.7560]}    {[255 182 193]}    {["#FFB6C1"]}
    {'LightPink1'          }    {[     1 0.6840 0.7250]}    {[255 174 185]}    {["#FFAEB9"]}
    {'LightPink2'          }    {[0.9320 0.6350 0.6800]}    {[238 162 173]}    {["#EEA2AD"]}
    {'LightPink3'          }    {[0.8040 0.5500 0.5850]}    {[205 140 149]}    {["#CD8C95"]}
    {'LightPink4'          }    {[0.5450 0.3720 0.3960]}    {[ 139 95 101]}    {["#8B5F65"]}
    {'LightSalmon'         }    {[     1 0.6280 0.4800]}    {[255 160 122]}    {["#FFA07A"]}
    {'LightSalmon1'        }    {[     1 0.6280 0.4800]}    {[255 160 122]}    {["#FFA07A"]}
    {'LightSalmon2'        }    {[0.9320 0.5850 0.4480]}    {[238 149 114]}    {["#EE9572"]}
    {'LightSalmon3'        }    {[0.8040 0.5050 0.3850]}    {[ 205 129 98]}    {["#CD8162"]}
    {'LightSalmon4'        }    {[0.5450 0.3400 0.2600]}    {[  139 87 66]}    {["#8B5742"]}
    {'LightSeaGreen'       }    {[0.1250 0.6980 0.6680]}    {[ 32 178 170]}    {["#20B2AA"]}
    {'LightSkyBlue'        }    {[0.5300 0.8080 0.9800]}    {[135 206 250]}    {["#87CEFA"]}
    {'LightSkyBlue1'       }    {[     0.6900 0.8880 1]}    {[176 226 255]}    {["#B0E2FF"]}
    {'LightSkyBlue2'       }    {[0.6440 0.8280 0.9320]}    {[164 211 238]}    {["#A4D3EE"]}
    {'LightSkyBlue3'       }    {[0.5520 0.7120 0.8040]}    {[141 182 205]}    {["#8DB6CD"]}
    {'LightSkyBlue4'       }    {[0.3760 0.4840 0.5450]}    {[ 96 123 139]}    {["#607B8B"]}
    {'LightSlateBlue'      }    {[     0.5180 0.4400 1]}    {[132 112 255]}    {["#8470FF"]}
    {'LightSlateGray'      }    {[0.4680 0.5320 0.6000]}    {[119 136 153]}    {["#778899"]}
    {'LightSlateGrey'      }    {[0.4680 0.5320 0.6000]}    {[119 136 153]}    {["#778899"]}
    {'LightSteelBlue'      }    {[0.6900 0.7700 0.8700]}    {[176 196 222]}    {["#B0C4DE"]}
    {'LightSteelBlue1'     }    {[     0.7920 0.8840 1]}    {[202 225 255]}    {["#CAE1FF"]}
    {'LightSteelBlue2'     }    {[0.7360 0.8240 0.9320]}    {[188 210 238]}    {["#BCD2EE"]}
    {'LightSteelBlue3'     }    {[0.6350 0.7100 0.8040]}    {[162 181 205]}    {["#A2B5CD"]}
    {'LightSteelBlue4'     }    {[0.4300 0.4840 0.5450]}    {[110 123 139]}    {["#6E7B8B"]}
    {'LightYellow'         }    {[          1 1 0.8800]}    {[255 255 224]}    {["#FFFFE0"]}
    {'LightYellow1'        }    {[          1 1 0.8800]}    {[255 255 224]}    {["#FFFFE0"]}
    {'LightYellow2'        }    {[0.9320 0.9320 0.8200]}    {[238 238 209]}    {["#EEEED1"]}
    {'LightYellow3'        }    {[0.8040 0.8040 0.7050]}    {[205 205 180]}    {["#CDCDB4"]}
    {'LightYellow4'        }    {[0.5450 0.5450 0.4800]}    {[139 139 122]}    {["#8B8B7A"]}
    {'Lime'                }    {[               0 1 0]}    {[    0 255 0]}    {["#00FF00"]}
    {'LimeGreen'           }    {[0.1960 0.8040 0.1960]}    {[  50 205 50]}    {["#32CD32"]}
    {'Linen'               }    {[0.9800 0.9400 0.9000]}    {[250 240 230]}    {["#FAF0E6"]}
    {'Magenta'             }    {[               1 0 1]}    {[  255 0 255]}    {["#FF00FF"]}
    {'Magenta1'            }    {[               1 0 1]}    {[  255 0 255]}    {["#FF00FF"]}
    {'Magenta2'            }    {[     0.9320 0 0.9320]}    {[  238 0 238]}    {["#EE00EE"]}
    {'Magenta3'            }    {[     0.8040 0 0.8040]}    {[  205 0 205]}    {["#CD00CD"]}
    {'Magenta4'            }    {[     0.5450 0 0.5450]}    {[  139 0 139]}    {["#8B008B"]}
    {'Maroon'              }    {[          0.5000 0 0]}    {[    128 0 0]}    {["#800000"]}
    {'Maroon0'             }    {[0.6900 0.1900 0.3760]}    {[  176 48 96]}    {["#B03060"]}
    {'Maroon1'             }    {[     1 0.2040 0.7000]}    {[ 255 52 179]}    {["#FF34B3"]}
    {'Maroon2'             }    {[0.9320 0.1900 0.6550]}    {[ 238 48 167]}    {["#EE30A7"]}
    {'Maroon3'             }    {[0.8040 0.1600 0.5650]}    {[ 205 41 144]}    {["#CD2990"]}
    {'Maroon4'             }    {[0.5450 0.1100 0.3850]}    {[  139 28 98]}    {["#8B1C62"]}
    {'MediumAquamarine'    }    {[0.4000 0.8040 0.6680]}    {[102 205 170]}    {["#66CDAA"]}
    {'MediumBlue'          }    {[          0 0 0.8040]}    {[    0 0 205]}    {["#0000CD"]}
    {'MediumOrchid'        }    {[0.7300 0.3320 0.8280]}    {[ 186 85 211]}    {["#BA55D3"]}
    {'MediumOrchid1'       }    {[     0.8800 0.4000 1]}    {[224 102 255]}    {["#E066FF"]}
    {'MediumOrchid2'       }    {[0.8200 0.3720 0.9320]}    {[ 209 95 238]}    {["#D15FEE"]}
    {'MediumOrchid3'       }    {[0.7050 0.3200 0.8040]}    {[ 180 82 205]}    {["#B452CD"]}
    {'MediumOrchid4'       }    {[0.4800 0.2150 0.5450]}    {[ 122 55 139]}    {["#7A378B"]}
    {'MediumPurple'        }    {[0.5760 0.4400 0.8600]}    {[147 112 219]}    {["#9370DB"]}
    {'MediumPurple1'       }    {[     0.6700 0.5100 1]}    {[171 130 255]}    {["#AB82FF"]}
    {'MediumPurple2'       }    {[0.6240 0.4750 0.9320]}    {[159 121 238]}    {["#9F79EE"]}
    {'MediumPurple3'       }    {[0.5360 0.4080 0.8040]}    {[137 104 205]}    {["#8968CD"]}
    {'MediumPurple4'       }    {[0.3650 0.2800 0.5450]}    {[  93 71 139]}    {["#5D478B"]}
    {'MediumSeaGreen'      }    {[0.2350 0.7000 0.4440]}    {[ 60 179 113]}    {["#3CB371"]}
    {'MediumSlateBlue'     }    {[0.4840 0.4080 0.9320]}    {[123 104 238]}    {["#7B68EE"]}
    {'MediumSpringGreen'   }    {[     0 0.9800 0.6040]}    {[  0 250 154]}    {["#00FA9A"]}
    {'MediumTurquoise'     }    {[0.2840 0.8200 0.8000]}    {[ 72 209 204]}    {["#48D1CC"]}
    {'MediumVioletRed'     }    {[0.7800 0.0840 0.5200]}    {[ 199 21 133]}    {["#C71585"]}
    {'MidnightBlue'        }    {[0.0980 0.0980 0.4400]}    {[  25 25 112]}    {["#191970"]}
    {'MintCream'           }    {[     0.9600 1 0.9800]}    {[245 255 250]}    {["#F5FFFA"]}
    {'MistyRose'           }    {[     1 0.8940 0.8840]}    {[255 228 225]}    {["#FFE4E1"]}
    {'MistyRose1'          }    {[     1 0.8940 0.8840]}    {[255 228 225]}    {["#FFE4E1"]}
    {'MistyRose2'          }    {[0.9320 0.8350 0.8240]}    {[238 213 210]}    {["#EED5D2"]}
    {'MistyRose3'          }    {[0.8040 0.7160 0.7100]}    {[205 183 181]}    {["#CDB7B5"]}
    {'MistyRose4'          }    {[0.5450 0.4900 0.4840]}    {[139 125 123]}    {["#8B7D7B"]}
    {'Moccasin'            }    {[     1 0.8940 0.7100]}    {[255 228 181]}    {["#FFE4B5"]}
    {'NavajoWhite'         }    {[     1 0.8700 0.6800]}    {[255 222 173]}    {["#FFDEAD"]}
    {'NavajoWhite1'        }    {[     1 0.8700 0.6800]}    {[255 222 173]}    {["#FFDEAD"]}
    {'NavajoWhite2'        }    {[0.9320 0.8100 0.6300]}    {[238 207 161]}    {["#EECFA1"]}
    {'NavajoWhite3'        }    {[0.8040 0.7000 0.5450]}    {[205 179 139]}    {["#CDB38B"]}
    {'NavajoWhite4'        }    {[0.5450 0.4750 0.3700]}    {[ 139 121 94]}    {["#8B795E"]}
    {'Navy'                }    {[          0 0 0.5000]}    {[    0 0 128]}    {["#000080"]}
    {'NavyBlue'            }    {[          0 0 0.5000]}    {[    0 0 128]}    {["#000080"]}
    {'OldLace'             }    {[0.9920 0.9600 0.9000]}    {[253 245 230]}    {["#FDF5E6"]}
    {'Olive'               }    {[     0.5000 0.5000 0]}    {[  128 128 0]}    {["#808000"]}
    {'OliveDrab'           }    {[0.4200 0.5560 0.1360]}    {[ 107 142 35]}    {["#6B8E23"]}
    {'OliveDrab1'          }    {[     0.7520 1 0.2440]}    {[ 192 255 62]}    {["#C0FF3E"]}
    {'OliveDrab2'          }    {[0.7000 0.9320 0.2280]}    {[ 179 238 58]}    {["#B3EE3A"]}
    {'OliveDrab3'          }    {[0.6040 0.8040 0.1960]}    {[ 154 205 50]}    {["#9ACD32"]}
    {'OliveDrab4'          }    {[0.4100 0.5450 0.1320]}    {[ 105 139 34]}    {["#698B22"]}
    {'Orange'              }    {[          1 0.6480 0]}    {[  255 165 0]}    {["#FFA500"]}
    {'Orange1'             }    {[          1 0.6480 0]}    {[  255 165 0]}    {["#FFA500"]}
    {'Orange2'             }    {[     0.9320 0.6040 0]}    {[  238 154 0]}    {["#EE9A00"]}
    {'Orange3'             }    {[     0.8040 0.5200 0]}    {[  205 133 0]}    {["#CD8500"]}
    {'Orange4'             }    {[     0.5450 0.3520 0]}    {[   139 90 0]}    {["#8B5A00"]}
    {'OrangeRed'           }    {[          1 0.2700 0]}    {[   255 69 0]}    {["#FF4500"]}
    {'OrangeRed1'          }    {[          1 0.2700 0]}    {[   255 69 0]}    {["#FF4500"]}
    {'OrangeRed2'          }    {[     0.9320 0.2500 0]}    {[   238 64 0]}    {["#EE4000"]}
    {'OrangeRed3'          }    {[     0.8040 0.2150 0]}    {[   205 55 0]}    {["#CD3700"]}
    {'OrangeRed4'          }    {[     0.5450 0.1450 0]}    {[   139 37 0]}    {["#8B2500"]}
    {'Orchid'              }    {[0.8550 0.4400 0.8400]}    {[218 112 214]}    {["#DA70D6"]}
    {'Orchid1'             }    {[     1 0.5120 0.9800]}    {[255 131 250]}    {["#FF83FA"]}
    {'Orchid2'             }    {[0.9320 0.4800 0.9120]}    {[238 122 233]}    {["#EE7AE9"]}
    {'Orchid3'             }    {[0.8040 0.4100 0.7900]}    {[205 105 201]}    {["#CD69C9"]}
    {'Orchid4'             }    {[0.5450 0.2800 0.5360]}    {[ 139 71 137]}    {["#8B4789"]}
    {'PaleGoldenrod'       }    {[0.9320 0.9100 0.6680]}    {[238 232 170]}    {["#EEE8AA"]}
    {'PaleGreen'           }    {[0.5960 0.9850 0.5960]}    {[152 251 152]}    {["#98FB98"]}
    {'PaleGreen1'          }    {[     0.6040 1 0.6040]}    {[154 255 154]}    {["#9AFF9A"]}
    {'PaleGreen2'          }    {[0.5650 0.9320 0.5650]}    {[144 238 144]}    {["#90EE90"]}
    {'PaleGreen3'          }    {[0.4880 0.8040 0.4880]}    {[124 205 124]}    {["#7CCD7C"]}
    {'PaleGreen4'          }    {[0.3300 0.5450 0.3300]}    {[  84 139 84]}    {["#548B54"]}
    {'PaleTurquoise'       }    {[0.6880 0.9320 0.9320]}    {[175 238 238]}    {["#AFEEEE"]}
    {'PaleTurquoise1'      }    {[          0.7320 1 1]}    {[187 255 255]}    {["#BBFFFF"]}
    {'PaleTurquoise2'      }    {[0.6840 0.9320 0.9320]}    {[174 238 238]}    {["#AEEEEE"]}
    {'PaleTurquoise3'      }    {[0.5900 0.8040 0.8040]}    {[150 205 205]}    {["#96CDCD"]}
    {'PaleTurquoise4'      }    {[0.4000 0.5450 0.5450]}    {[102 139 139]}    {["#668B8B"]}
    {'PaleVioletRed'       }    {[0.8600 0.4400 0.5760]}    {[219 112 147]}    {["#DB7093"]}
    {'PaleVioletRed1'      }    {[     1 0.5100 0.6700]}    {[255 130 171]}    {["#FF82AB"]}
    {'PaleVioletRed2'      }    {[0.9320 0.4750 0.6240]}    {[238 121 159]}    {["#EE799F"]}
    {'PaleVioletRed3'      }    {[0.8040 0.4080 0.5360]}    {[205 104 137]}    {["#CD6889"]}
    {'PaleVioletRed4'      }    {[0.5450 0.2800 0.3650]}    {[  139 71 93]}    {["#8B475D"]}
    {'PapayaWhip'          }    {[     1 0.9360 0.8350]}    {[255 239 213]}    {["#FFEFD5"]}
    {'PeachPuff'           }    {[     1 0.8550 0.7250]}    {[255 218 185]}    {["#FFDAB9"]}
    {'PeachPuff1'          }    {[     1 0.8550 0.7250]}    {[255 218 185]}    {["#FFDAB9"]}
    {'PeachPuff2'          }    {[0.9320 0.7960 0.6800]}    {[238 203 173]}    {["#EECBAD"]}
    {'PeachPuff3'          }    {[0.8040 0.6880 0.5850]}    {[205 175 149]}    {["#CDAF95"]}
    {'PeachPuff4'          }    {[0.5450 0.4680 0.3960]}    {[139 119 101]}    {["#8B7765"]}
    {'Peru'                }    {[0.8040 0.5200 0.2480]}    {[ 205 133 63]}    {["#CD853F"]}
    {'Pink'                }    {[     1 0.7520 0.7960]}    {[255 192 203]}    {["#FFC0CB"]}
    {'Pink1'               }    {[     1 0.7100 0.7720]}    {[255 181 197]}    {["#FFB5C5"]}
    {'Pink2'               }    {[0.9320 0.6640 0.7200]}    {[238 169 184]}    {["#EEA9B8"]}
    {'Pink3'               }    {[0.8040 0.5700 0.6200]}    {[205 145 158]}    {["#CD919E"]}
    {'Pink4'               }    {[0.5450 0.3900 0.4240]}    {[ 139 99 108]}    {["#8B636C"]}
    {'Plum'                }    {[0.8680 0.6280 0.8680]}    {[221 160 221]}    {["#DDA0DD"]}
    {'Plum1'               }    {[          1 0.7320 1]}    {[255 187 255]}    {["#FFBBFF"]}
    {'Plum2'               }    {[0.9320 0.6840 0.9320]}    {[238 174 238]}    {["#EEAEEE"]}
    {'Plum3'               }    {[0.8040 0.5900 0.8040]}    {[205 150 205]}    {["#CD96CD"]}
    {'Plum4'               }    {[0.5450 0.4000 0.5450]}    {[139 102 139]}    {["#8B668B"]}
    {'PowderBlue'          }    {[0.6900 0.8800 0.9000]}    {[176 224 230]}    {["#B0E0E6"]}
    {'Purple'              }    {[     0.5000 0 0.5000]}    {[  128 0 128]}    {["#800080"]}
    {'Purple0'             }    {[0.6280 0.1250 0.9400]}    {[ 160 32 240]}    {["#A020F0"]}
    {'Purple1'             }    {[     0.6080 0.1900 1]}    {[ 155 48 255]}    {["#9B30FF"]}
    {'Purple2'             }    {[0.5700 0.1720 0.9320]}    {[ 145 44 238]}    {["#912CEE"]}
    {'Purple3'             }    {[0.4900 0.1500 0.8040]}    {[ 125 38 205]}    {["#7D26CD"]}
    {'Purple4'             }    {[0.3320 0.1000 0.5450]}    {[  85 26 139]}    {["#551A8B"]}
    {'Red'                 }    {[               1 0 0]}    {[    255 0 0]}    {["#FF0000"]}
    {'Red1'                }    {[               1 0 0]}    {[    255 0 0]}    {["#FF0000"]}
    {'Red2'                }    {[          0.9320 0 0]}    {[    238 0 0]}    {["#EE0000"]}
    {'Red3'                }    {[          0.8040 0 0]}    {[    205 0 0]}    {["#CD0000"]}
    {'Red4'                }    {[          0.5450 0 0]}    {[    139 0 0]}    {["#8B0000"]}
    {'RosyBrown'           }    {[0.7360 0.5600 0.5600]}    {[188 143 143]}    {["#BC8F8F"]}
    {'RosyBrown1'          }    {[     1 0.7560 0.7560]}    {[255 193 193]}    {["#FFC1C1"]}
    {'RosyBrown2'          }    {[0.9320 0.7050 0.7050]}    {[238 180 180]}    {["#EEB4B4"]}
    {'RosyBrown3'          }    {[0.8040 0.6080 0.6080]}    {[205 155 155]}    {["#CD9B9B"]}
    {'RosyBrown4'          }    {[0.5450 0.4100 0.4100]}    {[139 105 105]}    {["#8B6969"]}
    {'RoyalBlue'           }    {[0.2550 0.4100 0.8840]}    {[ 65 105 225]}    {["#4169E1"]}
    {'RoyalBlue1'          }    {[     0.2840 0.4640 1]}    {[ 72 118 255]}    {["#4876FF"]}
    {'RoyalBlue2'          }    {[0.2640 0.4300 0.9320]}    {[ 67 110 238]}    {["#436EEE"]}
    {'RoyalBlue3'          }    {[0.2280 0.3720 0.8040]}    {[  58 95 205]}    {["#3A5FCD"]}
    {'RoyalBlue4'          }    {[0.1520 0.2500 0.5450]}    {[  39 64 139]}    {["#27408B"]}
    {'SaddleBrown'         }    {[0.5450 0.2700 0.0750]}    {[  139 69 19]}    {["#8B4513"]}
    {'Salmon'              }    {[0.9800 0.5000 0.4480]}    {[250 128 114]}    {["#FA8072"]}
    {'Salmon1'             }    {[     1 0.5500 0.4100]}    {[255 140 105]}    {["#FF8C69"]}
    {'Salmon2'             }    {[0.9320 0.5100 0.3850]}    {[ 238 130 98]}    {["#EE8262"]}
    {'Salmon3'             }    {[0.8040 0.4400 0.3300]}    {[ 205 112 84]}    {["#CD7054"]}
    {'Salmon4'             }    {[0.5450 0.2980 0.2240]}    {[  139 76 57]}    {["#8B4C39"]}
    {'SandyBrown'          }    {[0.9560 0.6440 0.3760]}    {[ 244 164 96]}    {["#F4A460"]}
    {'SeaGreen'            }    {[0.1800 0.5450 0.3400]}    {[  46 139 87]}    {["#2E8B57"]}
    {'SeaGreen1'           }    {[     0.3300 1 0.6240]}    {[ 84 255 159]}    {["#54FF9F"]}
    {'SeaGreen2'           }    {[0.3050 0.9320 0.5800]}    {[ 78 238 148]}    {["#4EEE94"]}
    {'SeaGreen3'           }    {[0.2640 0.8040 0.5000]}    {[ 67 205 128]}    {["#43CD80"]}
    {'SeaGreen4'           }    {[0.1800 0.5450 0.3400]}    {[  46 139 87]}    {["#2E8B57"]}
    {'Seashell'            }    {[     1 0.9600 0.9320]}    {[255 245 238]}    {["#FFF5EE"]}
    {'Seashell1'           }    {[     1 0.9600 0.9320]}    {[255 245 238]}    {["#FFF5EE"]}
    {'Seashell2'           }    {[0.9320 0.8980 0.8700]}    {[238 229 222]}    {["#EEE5DE"]}
    {'Seashell3'           }    {[0.8040 0.7720 0.7500]}    {[205 197 191]}    {["#CDC5BF"]}
    {'Seashell4'           }    {[0.5450 0.5250 0.5100]}    {[139 134 130]}    {["#8B8682"]}
    {'Sienna'              }    {[0.6280 0.3200 0.1760]}    {[  160 82 45]}    {["#A0522D"]}
    {'Sienna1'             }    {[     1 0.5100 0.2800]}    {[ 255 130 71]}    {["#FF8247"]}
    {'Sienna2'             }    {[0.9320 0.4750 0.2600]}    {[ 238 121 66]}    {["#EE7942"]}
    {'Sienna3'             }    {[0.8040 0.4080 0.2240]}    {[ 205 104 57]}    {["#CD6839"]}
    {'Sienna4'             }    {[0.5450 0.2800 0.1500]}    {[  139 71 38]}    {["#8B4726"]}
    {'Silver'              }    {[0.7520 0.7520 0.7520]}    {[192 192 192]}    {["#C0C0C0"]}
    {'SkyBlue'             }    {[0.5300 0.8080 0.9200]}    {[135 206 235]}    {["#87CEEB"]}
    {'SkyBlue1'            }    {[     0.5300 0.8080 1]}    {[135 206 255]}    {["#87CEFF"]}
    {'SkyBlue2'            }    {[0.4940 0.7520 0.9320]}    {[126 192 238]}    {["#7EC0EE"]}
    {'SkyBlue3'            }    {[0.4240 0.6500 0.8040]}    {[108 166 205]}    {["#6CA6CD"]}
    {'SkyBlue4'            }    {[0.2900 0.4400 0.5450]}    {[ 74 112 139]}    {["#4A708B"]}
    {'SlateBlue'           }    {[0.4150 0.3520 0.8040]}    {[ 106 90 205]}    {["#6A5ACD"]}
    {'SlateBlue1'          }    {[     0.5120 0.4350 1]}    {[131 111 255]}    {["#836FFF"]}
    {'SlateBlue2'          }    {[0.4800 0.4040 0.9320]}    {[122 103 238]}    {["#7A67EE"]}
    {'SlateBlue3'          }    {[0.4100 0.3500 0.8040]}    {[ 105 89 205]}    {["#6959CD"]}
    {'SlateBlue4'          }    {[0.2800 0.2350 0.5450]}    {[  71 60 139]}    {["#473C8B"]}
    {'SlateGray'           }    {[0.4400 0.5000 0.5650]}    {[112 128 144]}    {["#708090"]}
    {'SlateGray1'          }    {[     0.7760 0.8880 1]}    {[198 226 255]}    {["#C6E2FF"]}
    {'SlateGray2'          }    {[0.7250 0.8280 0.9320]}    {[185 211 238]}    {["#B9D3EE"]}
    {'SlateGray3'          }    {[0.6240 0.7120 0.8040]}    {[159 182 205]}    {["#9FB6CD"]}
    {'SlateGray4'          }    {[0.4240 0.4840 0.5450]}    {[108 123 139]}    {["#6C7B8B"]}
    {'SlateGrey'           }    {[0.4400 0.5000 0.5650]}    {[112 128 144]}    {["#708090"]}
    {'Snow'                }    {[     1 0.9800 0.9800]}    {[255 250 250]}    {["#FFFAFA"]}
    {'Snow1'               }    {[     1 0.9800 0.9800]}    {[255 250 250]}    {["#FFFAFA"]}
    {'Snow2'               }    {[0.9320 0.9120 0.9120]}    {[238 233 233]}    {["#EEE9E9"]}
    {'Snow3'               }    {[0.8040 0.7900 0.7900]}    {[205 201 201]}    {["#CDC9C9"]}
    {'Snow4'               }    {[0.5450 0.5360 0.5360]}    {[139 137 137]}    {["#8B8989"]}
    {'SpringGreen'         }    {[          0 1 0.4980]}    {[  0 255 127]}    {["#00FF7F"]}
    {'SpringGreen1'        }    {[          0 1 0.4980]}    {[  0 255 127]}    {["#00FF7F"]}
    {'SpringGreen2'        }    {[     0 0.9320 0.4640]}    {[  0 238 118]}    {["#00EE76"]}
    {'SpringGreen3'        }    {[     0 0.8040 0.4000]}    {[  0 205 102]}    {["#00CD66"]}
    {'SpringGreen4'        }    {[     0 0.5450 0.2700]}    {[   0 139 69]}    {["#008B45"]}
    {'SteelBlue'           }    {[0.2750 0.5100 0.7050]}    {[ 70 130 180]}    {["#4682B4"]}
    {'SteelBlue1'          }    {[     0.3900 0.7200 1]}    {[ 99 184 255]}    {["#63B8FF"]}
    {'SteelBlue2'          }    {[0.3600 0.6750 0.9320]}    {[ 92 172 238]}    {["#5CACEE"]}
    {'SteelBlue3'          }    {[0.3100 0.5800 0.8040]}    {[ 79 148 205]}    {["#4F94CD"]}
    {'SteelBlue4'          }    {[0.2100 0.3920 0.5450]}    {[ 54 100 139]}    {["#36648B"]}
    {'Tan'                 }    {[0.8240 0.7050 0.5500]}    {[210 180 140]}    {["#D2B48C"]}
    {'Tan1'                }    {[     1 0.6480 0.3100]}    {[ 255 165 79]}    {["#FFA54F"]}
    {'Tan2'                }    {[0.9320 0.6040 0.2880]}    {[ 238 154 73]}    {["#EE9A49"]}
    {'Tan3'                }    {[0.8040 0.5200 0.2480]}    {[ 205 133 63]}    {["#CD853F"]}
    {'Tan4'                }    {[0.5450 0.3520 0.1700]}    {[  139 90 43]}    {["#8B5A2B"]}
    {'Teal'                }    {[     0 0.5000 0.5000]}    {[  0 128 128]}    {["#008080"]}
    {'Thistle'             }    {[0.8480 0.7500 0.8480]}    {[216 191 216]}    {["#D8BFD8"]}
    {'Thistle1'            }    {[          1 0.8840 1]}    {[255 225 255]}    {["#FFE1FF"]}
    {'Thistle2'            }    {[0.9320 0.8240 0.9320]}    {[238 210 238]}    {["#EED2EE"]}
    {'Thistle3'            }    {[0.8040 0.7100 0.8040]}    {[205 181 205]}    {["#CDB5CD"]}
    {'Thistle4'            }    {[0.5450 0.4840 0.5450]}    {[139 123 139]}    {["#8B7B8B"]}
    {'Tomato'              }    {[     1 0.3900 0.2800]}    {[  255 99 71]}    {["#FF6347"]}
    {'Tomato1'             }    {[     1 0.3900 0.2800]}    {[  255 99 71]}    {["#FF6347"]}
    {'Tomato2'             }    {[0.9320 0.3600 0.2600]}    {[  238 92 66]}    {["#EE5C42"]}
    {'Tomato3'             }    {[0.8040 0.3100 0.2240]}    {[  205 79 57]}    {["#CD4F39"]}
    {'Tomato4'             }    {[0.5450 0.2100 0.1500]}    {[  139 54 38]}    {["#8B3626"]}
    {'Turquoise'           }    {[0.2500 0.8800 0.8150]}    {[ 64 224 208]}    {["#40E0D0"]}
    {'Turquoise1'          }    {[          0 0.9600 1]}    {[  0 245 255]}    {["#00F5FF"]}
    {'Turquoise2'          }    {[     0 0.8980 0.9320]}    {[  0 229 238]}    {["#00E5EE"]}
    {'Turquoise3'          }    {[     0 0.7720 0.8040]}    {[  0 197 205]}    {["#00C5CD"]}
    {'Turquoise4'          }    {[     0 0.5250 0.5450]}    {[  0 134 139]}    {["#00868B"]}
    {'Violet'              }    {[0.9320 0.5100 0.9320]}    {[238 130 238]}    {["#EE82EE"]}
    {'VioletRed'           }    {[0.8160 0.1250 0.5650]}    {[ 208 32 144]}    {["#D02090"]}
    {'VioletRed1'          }    {[     1 0.2440 0.5900]}    {[ 255 62 150]}    {["#FF3E96"]}
    {'VioletRed2'          }    {[0.9320 0.2280 0.5500]}    {[ 238 58 140]}    {["#EE3A8C"]}
    {'VioletRed3'          }    {[0.8040 0.1960 0.4700]}    {[ 205 50 120]}    {["#CD3278"]}
    {'VioletRed4'          }    {[0.5450 0.1320 0.3200]}    {[  139 34 82]}    {["#8B2252"]}
    {'Wheat'               }    {[0.9600 0.8700 0.7000]}    {[245 222 179]}    {["#F5DEB3"]}
    {'Wheat1'              }    {[     1 0.9050 0.7300]}    {[255 231 186]}    {["#FFE7BA"]}
    {'Wheat2'              }    {[0.9320 0.8480 0.6840]}    {[238 216 174]}    {["#EED8AE"]}
    {'Wheat3'              }    {[0.8040 0.7300 0.5900]}    {[205 186 150]}    {["#CDBA96"]}
    {'Wheat4'              }    {[0.5450 0.4940 0.4000]}    {[139 126 102]}    {["#8B7E66"]}
    {'White'               }    {[               1 1 1]}    {[255 255 255]}    {["#FFFFFF"]}
    {'WhiteSmoke'          }    {[0.9600 0.9600 0.9600]}    {[245 245 245]}    {["#F5F5F5"]}
    {'Yellow'              }    {[               1 1 0]}    {[  255 255 0]}    {["#FFFF00"]}
    {'Yellow1'             }    {[               1 1 0]}    {[  255 255 0]}    {["#FFFF00"]}
    {'Yellow2'             }    {[     0.9320 0.9320 0]}    {[  238 238 0]}    {["#EEEE00"]}
    {'Yellow3'             }    {[     0.8040 0.8040 0]}    {[  205 205 0]}    {["#CDCD00"]}
    {'Yellow4'             }    {[     0.5450 0.5450 0]}    {[  139 139 0]}    {["#8B8B00"]}
    {'YellowGreen'         }    {[0.6040 0.8040 0.1960]}    {[ 154 205 50]}    {["#9ACD32"]}
```

<br>

**References**

- [Extending LaTeX’s color facilities: the xcolor package (v2.14, 2022/06/12)](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/xcolor/xcolor.pdf), p. 39.
- 刘海洋编著. LaTeX入门. 北京: 电子工业出版社, 2013.6.

[^3]: [The Colors  of `xcolor` - Garrick](https://www.garrickadenbuie.com/blog/colors-of-xcolor/).
[^4]: [tidyverse.org](https://www.tidyverse.org/).
