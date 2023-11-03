---
layout: single
title: "Built-in Colour Names in LaTeX xcolor Package"
date: 2023-10-17 18:16:22 +0800
last_modified_at: 2023-11-03 12:40:47 +0800
categories:
 - LaTeX
 - Graphic Design and Typography
 - R
 - MATLAB
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

# Something more ...

Garrick’s blog [[3]](#ref) provides a way using `tidyverse` [[4]](#ref), a collection of R packages, to gather RGB-tuple of the colors defined in `xcolor` package. He extracts colour information from zipped files which are downloaded from `http://www.ukern.de/tex/xcolor/tex/svgnam.def.gz` and `http://www.ukern.de/tex/xcolor/tex/x11nam.def.gz`, and then organises colour tuples into a `.csv` file (Garrick provides this file in his blog [[3]](#ref) as wel). I want to reproduce it using MATLAB, but these two zipped files seems not common compressed format; I tried different ways but finally failed to open them. 

So here, for the convenience of future use, I just downloaded the `xcolors.csv` file which Garrick provides [[3]](#ref), and then display its content in MATLAB: 

```matlab
colorTable = readtable("xcolors.csv");
% colorStruct = table2struct(colorTable);
disp(colorTable)
```

```
             color                r        g        b  
    ________________________    _____    _____    _____

    {'AliceBlue'           }     0.94    0.972        1
    {'AntiqueWhite'        }     0.98     0.92    0.844
    {'AntiqueWhite1'       }        1    0.936     0.86
    {'AntiqueWhite2'       }    0.932    0.875      0.8
    {'AntiqueWhite3'       }    0.804    0.752     0.69
    {'AntiqueWhite4'       }    0.545    0.512     0.47
    {'Aqua'                }        0        1        1
    {'Aquamarine'          }    0.498        1     0.83
    {'Aquamarine1'         }    0.498        1     0.83
    {'Aquamarine2'         }    0.464    0.932    0.776
    {'Aquamarine3'         }      0.4    0.804    0.668
    {'Aquamarine4'         }     0.27    0.545    0.455
    {'Azure'               }     0.94        1        1
    {'Azure1'              }     0.94        1        1
    {'Azure2'              }     0.88    0.932    0.932
    {'Azure3'              }    0.756    0.804    0.804
    {'Azure4'              }    0.512    0.545    0.545
    {'Beige'               }     0.96     0.96    0.864
    {'Bisque'              }        1    0.894     0.77
    {'Bisque1'             }        1    0.894     0.77
    {'Bisque2'             }    0.932    0.835    0.716
    {'Bisque3'             }    0.804    0.716     0.62
    {'Bisque4'             }    0.545     0.49     0.42
    {'Black'               }        0        0        0
    {'BlanchedAlmond'      }        1     0.92    0.804
    {'Blue'                }        0        0        1
    {'Blue1'               }        0        0        1
    {'Blue2'               }        0        0    0.932
    {'Blue3'               }        0        0    0.804
    {'Blue4'               }        0        0    0.545
    {'BlueViolet'          }     0.54     0.17    0.888
    {'Brown'               }    0.648    0.165    0.165
    {'Brown1'              }        1     0.25     0.25
    {'Brown2'              }    0.932     0.23     0.23
    {'Brown3'              }    0.804      0.2      0.2
    {'Brown4'              }    0.545    0.136    0.136
    {'BurlyWood'           }     0.87     0.72     0.53
    {'Burlywood1'          }        1    0.828    0.608
    {'Burlywood2'          }    0.932    0.772     0.57
    {'Burlywood3'          }    0.804    0.668     0.49
    {'Burlywood4'          }    0.545     0.45    0.332
    {'CadetBlue'           }    0.372     0.62    0.628
    {'CadetBlue1'          }    0.596     0.96        1
    {'CadetBlue2'          }    0.556    0.898    0.932
    {'CadetBlue3'          }     0.48    0.772    0.804
    {'CadetBlue4'          }    0.325    0.525    0.545
    {'Chartreuse'          }    0.498        1        0
    {'Chartreuse1'         }    0.498        1        0
    {'Chartreuse2'         }    0.464    0.932        0
    {'Chartreuse3'         }      0.4    0.804        0
    {'Chartreuse4'         }     0.27    0.545        0
    {'Chocolate'           }    0.824     0.41    0.116
    {'Chocolate1'          }        1    0.498     0.14
    {'Chocolate2'          }    0.932    0.464     0.13
    {'Chocolate3'          }    0.804      0.4    0.112
    {'Chocolate4'          }    0.545     0.27    0.075
    {'Coral'               }        1    0.498    0.312
    {'Coral1'              }        1    0.448    0.336
    {'Coral2'              }    0.932    0.415    0.312
    {'Coral3'              }    0.804    0.356     0.27
    {'Coral4'              }    0.545    0.244    0.185
    {'CornflowerBlue'      }    0.392    0.585     0.93
    {'Cornsilk'            }        1    0.972    0.864
    {'Cornsilk1'           }        1    0.972    0.864
    {'Cornsilk2'           }    0.932     0.91    0.804
    {'Cornsilk3'           }    0.804    0.785    0.694
    {'Cornsilk4'           }    0.545    0.532     0.47
    {'Crimson'             }    0.864     0.08    0.235
    {'Cyan'                }        0        1        1
    {'Cyan1'               }        0        1        1
    {'Cyan2'               }        0    0.932    0.932
    {'Cyan3'               }        0    0.804    0.804
    {'Cyan4'               }        0    0.545    0.545
    {'DarkBlue'            }        0        0    0.545
    {'DarkCyan'            }        0    0.545    0.545
    {'DarkGoldenrod'       }     0.72    0.525    0.044
    {'DarkGoldenrod1'      }        1    0.725     0.06
    {'DarkGoldenrod2'      }    0.932     0.68    0.055
    {'DarkGoldenrod3'      }    0.804    0.585    0.048
    {'DarkGoldenrod4'      }    0.545    0.396     0.03
    {'DarkGray'            }    0.664    0.664    0.664
    {'DarkGreen'           }        0    0.392        0
    {'DarkGrey'            }    0.664    0.664    0.664
    {'DarkKhaki'           }     0.74    0.716     0.42
    {'DarkMagenta'         }    0.545        0    0.545
    {'DarkOliveGreen'      }    0.332     0.42    0.185
    {'DarkOliveGreen1'     }    0.792        1     0.44
    {'DarkOliveGreen2'     }    0.736    0.932    0.408
    {'DarkOliveGreen3'     }    0.635    0.804    0.352
    {'DarkOliveGreen4'     }     0.43    0.545     0.24
    {'DarkOrange'          }        1     0.55        0
    {'DarkOrange1'         }        1    0.498        0
    {'DarkOrange2'         }    0.932    0.464        0
    {'DarkOrange3'         }    0.804      0.4        0
    {'DarkOrange4'         }    0.545     0.27        0
    {'DarkOrchid'          }      0.6    0.196      0.8
    {'DarkOrchid1'         }     0.75    0.244        1
    {'DarkOrchid2'         }    0.698    0.228    0.932
    {'DarkOrchid3'         }    0.604    0.196    0.804
    {'DarkOrchid4'         }    0.408    0.132    0.545
    {'DarkRed'             }    0.545        0        0
    {'DarkSalmon'          }    0.912     0.59     0.48
    {'DarkSeaGreen'        }     0.56    0.736     0.56
    {'DarkSeaGreen1'       }    0.756        1    0.756
    {'DarkSeaGreen2'       }    0.705    0.932    0.705
    {'DarkSeaGreen3'       }    0.608    0.804    0.608
    {'DarkSeaGreen4'       }     0.41    0.545     0.41
    {'DarkSlateBlue'       }    0.284     0.24    0.545
    {'DarkSlateGray'       }    0.185     0.31     0.31
    {'DarkSlateGray1'      }    0.592        1        1
    {'DarkSlateGray2'      }    0.552    0.932    0.932
    {'DarkSlateGray3'      }    0.475    0.804    0.804
    {'DarkSlateGray4'      }     0.32    0.545    0.545
    {'DarkSlateGrey'       }    0.185     0.31     0.31
    {'DarkTurquoise'       }        0    0.808     0.82
    {'DarkViolet'          }     0.58        0    0.828
    {'DeepPink'            }        1     0.08    0.576
    {'DeepPink1'           }        1     0.08    0.576
    {'DeepPink2'           }    0.932     0.07    0.536
    {'DeepPink3'           }    0.804    0.064    0.464
    {'DeepPink4'           }    0.545     0.04    0.312
    {'DeepSkyBlue'         }        0     0.75        1
    {'DeepSkyBlue1'        }        0     0.75        1
    {'DeepSkyBlue2'        }        0    0.698    0.932
    {'DeepSkyBlue3'        }        0    0.604    0.804
    {'DeepSkyBlue4'        }        0    0.408    0.545
    {'DimGray'             }     0.41     0.41     0.41
    {'DimGrey'             }     0.41     0.41     0.41
    {'DodgerBlue'          }    0.116    0.565        1
    {'DodgerBlue1'         }    0.116    0.565        1
    {'DodgerBlue2'         }     0.11    0.525    0.932
    {'DodgerBlue3'         }    0.094    0.455    0.804
    {'DodgerBlue4'         }    0.064    0.305    0.545
    {'FireBrick'           }    0.698    0.132    0.132
    {'Firebrick1'          }        1     0.19     0.19
    {'Firebrick2'          }    0.932    0.172    0.172
    {'Firebrick3'          }    0.804     0.15     0.15
    {'Firebrick4'          }    0.545      0.1      0.1
    {'FloralWhite'         }        1     0.98     0.94
    {'ForestGreen'         }    0.132    0.545    0.132
    {'Fuchsia'             }        1        0        1
    {'Gainsboro'           }    0.864    0.864    0.864
    {'GhostWhite'          }    0.972    0.972        1
    {'Gold'                }        1    0.844        0
    {'Gold1'               }        1    0.844        0
    {'Gold2'               }    0.932     0.79        0
    {'Gold3'               }    0.804     0.68        0
    {'Gold4'               }    0.545     0.46        0
    {'Goldenrod'           }    0.855    0.648    0.125
    {'Goldenrod1'          }        1    0.756    0.145
    {'Goldenrod2'          }    0.932    0.705    0.132
    {'Goldenrod3'          }    0.804    0.608    0.112
    {'Goldenrod4'          }    0.545     0.41     0.08
    {'Gray'                }      0.5      0.5      0.5
    {'Gray0'               }    0.745    0.745    0.745
    {'Green'               }        0      0.5        0
    {'Green0'              }        0        1        0
    {'Green1'              }        0        1        0
    {'Green2'              }        0    0.932        0
    {'Green3'              }        0    0.804        0
    {'Green4'              }        0    0.545        0
    {'GreenYellow'         }     0.68        1    0.185
    {'Grey'                }      0.5      0.5      0.5
    {'Grey0'               }    0.745    0.745    0.745
    {'Honeydew'            }     0.94        1     0.94
    {'Honeydew1'           }     0.94        1     0.94
    {'Honeydew2'           }     0.88    0.932     0.88
    {'Honeydew3'           }    0.756    0.804    0.756
    {'Honeydew4'           }    0.512    0.545    0.512
    {'HotPink'             }        1     0.41    0.705
    {'HotPink1'            }        1     0.43    0.705
    {'HotPink2'            }    0.932    0.415    0.655
    {'HotPink3'            }    0.804    0.376    0.565
    {'HotPink4'            }    0.545    0.228    0.385
    {'IndianRed'           }    0.804     0.36     0.36
    {'IndianRed1'          }        1    0.415    0.415
    {'IndianRed2'          }    0.932     0.39     0.39
    {'IndianRed3'          }    0.804    0.332    0.332
    {'IndianRed4'          }    0.545    0.228    0.228
    {'Indigo'              }    0.294        0     0.51
    {'Ivory'               }        1        1     0.94
    {'Ivory1'              }        1        1     0.94
    {'Ivory2'              }    0.932    0.932     0.88
    {'Ivory3'              }    0.804    0.804    0.756
    {'Ivory4'              }    0.545    0.545    0.512
    {'Khaki'               }     0.94      0.9     0.55
    {'Khaki1'              }        1    0.965     0.56
    {'Khaki2'              }    0.932      0.9     0.52
    {'Khaki3'              }    0.804    0.776     0.45
    {'Khaki4'              }    0.545    0.525    0.305
    {'Lavender'            }      0.9      0.9     0.98
    {'LavenderBlush'       }        1     0.94     0.96
    {'LavenderBlush1'      }        1     0.94     0.96
    {'LavenderBlush2'      }    0.932     0.88    0.898
    {'LavenderBlush3'      }    0.804    0.756    0.772
    {'LavenderBlush4'      }    0.545    0.512    0.525
    {'LawnGreen'           }    0.488     0.99        0
    {'LemonChiffon'        }        1     0.98    0.804
    {'LemonChiffon1'       }        1     0.98    0.804
    {'LemonChiffon2'       }    0.932    0.912     0.75
    {'LemonChiffon3'       }    0.804     0.79    0.648
    {'LemonChiffon4'       }    0.545    0.536     0.44
    {'LightBlue'           }     0.68    0.848      0.9
    {'LightBlue1'          }     0.75    0.936        1
    {'LightBlue2'          }    0.698    0.875    0.932
    {'LightBlue3'          }    0.604    0.752    0.804
    {'LightBlue4'          }    0.408    0.512    0.545
    {'LightCoral'          }     0.94      0.5      0.5
    {'LightCyan'           }     0.88        1        1
    {'LightCyan1'          }     0.88        1        1
    {'LightCyan2'          }     0.82    0.932    0.932
    {'LightCyan3'          }    0.705    0.804    0.804
    {'LightCyan4'          }     0.48    0.545    0.545
    {'LightGoldenrod'      }    0.933    0.867     0.51
    {'LightGoldenrod1'     }        1    0.925    0.545
    {'LightGoldenrod2'     }    0.932    0.864     0.51
    {'LightGoldenrod3'     }    0.804    0.745     0.44
    {'LightGoldenrod4'     }    0.545    0.505    0.298
    {'LightGoldenrodYellow'}     0.98     0.98    0.824
    {'LightGray'           }    0.828    0.828    0.828
    {'LightGreen'          }    0.565    0.932    0.565
    {'LightGrey'           }    0.828    0.828    0.828
    {'LightPink'           }        1    0.712    0.756
    {'LightPink1'          }        1    0.684    0.725
    {'LightPink2'          }    0.932    0.635     0.68
    {'LightPink3'          }    0.804     0.55    0.585
    {'LightPink4'          }    0.545    0.372    0.396
    {'LightSalmon'         }        1    0.628     0.48
    {'LightSalmon1'        }        1    0.628     0.48
    {'LightSalmon2'        }    0.932    0.585    0.448
    {'LightSalmon3'        }    0.804    0.505    0.385
    {'LightSalmon4'        }    0.545     0.34     0.26
    {'LightSeaGreen'       }    0.125    0.698    0.668
    {'LightSkyBlue'        }     0.53    0.808     0.98
    {'LightSkyBlue1'       }     0.69    0.888        1
    {'LightSkyBlue2'       }    0.644    0.828    0.932
    {'LightSkyBlue3'       }    0.552    0.712    0.804
    {'LightSkyBlue4'       }    0.376    0.484    0.545
    {'LightSlateBlue'      }    0.518     0.44        1
    {'LightSlateGray'      }    0.468    0.532      0.6
    {'LightSlateGrey'      }    0.468    0.532      0.6
    {'LightSteelBlue'      }     0.69     0.77     0.87
    {'LightSteelBlue1'     }    0.792    0.884        1
    {'LightSteelBlue2'     }    0.736    0.824    0.932
    {'LightSteelBlue3'     }    0.635     0.71    0.804
    {'LightSteelBlue4'     }     0.43    0.484    0.545
    {'LightYellow'         }        1        1     0.88
    {'LightYellow1'        }        1        1     0.88
    {'LightYellow2'        }    0.932    0.932     0.82
    {'LightYellow3'        }    0.804    0.804    0.705
    {'LightYellow4'        }    0.545    0.545     0.48
    {'Lime'                }        0        1        0
    {'LimeGreen'           }    0.196    0.804    0.196
    {'Linen'               }     0.98     0.94      0.9
    {'Magenta'             }        1        0        1
    {'Magenta1'            }        1        0        1
    {'Magenta2'            }    0.932        0    0.932
    {'Magenta3'            }    0.804        0    0.804
    {'Magenta4'            }    0.545        0    0.545
    {'Maroon'              }      0.5        0        0
    {'Maroon0'             }     0.69     0.19    0.376
    {'Maroon1'             }        1    0.204      0.7
    {'Maroon2'             }    0.932     0.19    0.655
    {'Maroon3'             }    0.804     0.16    0.565
    {'Maroon4'             }    0.545     0.11    0.385
    {'MediumAquamarine'    }      0.4    0.804    0.668
    {'MediumBlue'          }        0        0    0.804
    {'MediumOrchid'        }     0.73    0.332    0.828
    {'MediumOrchid1'       }     0.88      0.4        1
    {'MediumOrchid2'       }     0.82    0.372    0.932
    {'MediumOrchid3'       }    0.705     0.32    0.804
    {'MediumOrchid4'       }     0.48    0.215    0.545
    {'MediumPurple'        }    0.576     0.44     0.86
    {'MediumPurple1'       }     0.67     0.51        1
    {'MediumPurple2'       }    0.624    0.475    0.932
    {'MediumPurple3'       }    0.536    0.408    0.804
    {'MediumPurple4'       }    0.365     0.28    0.545
    {'MediumSeaGreen'      }    0.235      0.7    0.444
    {'MediumSlateBlue'     }    0.484    0.408    0.932
    {'MediumSpringGreen'   }        0     0.98    0.604
    {'MediumTurquoise'     }    0.284     0.82      0.8
    {'MediumVioletRed'     }     0.78    0.084     0.52
    {'MidnightBlue'        }    0.098    0.098     0.44
    {'MintCream'           }     0.96        1     0.98
    {'MistyRose'           }        1    0.894    0.884
    {'MistyRose1'          }        1    0.894    0.884
    {'MistyRose2'          }    0.932    0.835    0.824
    {'MistyRose3'          }    0.804    0.716     0.71
    {'MistyRose4'          }    0.545     0.49    0.484
    {'Moccasin'            }        1    0.894     0.71
    {'NavajoWhite'         }        1     0.87     0.68
    {'NavajoWhite1'        }        1     0.87     0.68
    {'NavajoWhite2'        }    0.932     0.81     0.63
    {'NavajoWhite3'        }    0.804      0.7    0.545
    {'NavajoWhite4'        }    0.545    0.475     0.37
    {'Navy'                }        0        0      0.5
    {'NavyBlue'            }        0        0      0.5
    {'OldLace'             }    0.992     0.96      0.9
    {'Olive'               }      0.5      0.5        0
    {'OliveDrab'           }     0.42    0.556    0.136
    {'OliveDrab1'          }    0.752        1    0.244
    {'OliveDrab2'          }      0.7    0.932    0.228
    {'OliveDrab3'          }    0.604    0.804    0.196
    {'OliveDrab4'          }     0.41    0.545    0.132
    {'Orange'              }        1    0.648        0
    {'Orange1'             }        1    0.648        0
    {'Orange2'             }    0.932    0.604        0
    {'Orange3'             }    0.804     0.52        0
    {'Orange4'             }    0.545    0.352        0
    {'OrangeRed'           }        1     0.27        0
    {'OrangeRed1'          }        1     0.27        0
    {'OrangeRed2'          }    0.932     0.25        0
    {'OrangeRed3'          }    0.804    0.215        0
    {'OrangeRed4'          }    0.545    0.145        0
    {'Orchid'              }    0.855     0.44     0.84
    {'Orchid1'             }        1    0.512     0.98
    {'Orchid2'             }    0.932     0.48    0.912
    {'Orchid3'             }    0.804     0.41     0.79
    {'Orchid4'             }    0.545     0.28    0.536
    {'PaleGoldenrod'       }    0.932     0.91    0.668
    {'PaleGreen'           }    0.596    0.985    0.596
    {'PaleGreen1'          }    0.604        1    0.604
    {'PaleGreen2'          }    0.565    0.932    0.565
    {'PaleGreen3'          }    0.488    0.804    0.488
    {'PaleGreen4'          }     0.33    0.545     0.33
    {'PaleTurquoise'       }    0.688    0.932    0.932
    {'PaleTurquoise1'      }    0.732        1        1
    {'PaleTurquoise2'      }    0.684    0.932    0.932
    {'PaleTurquoise3'      }     0.59    0.804    0.804
    {'PaleTurquoise4'      }      0.4    0.545    0.545
    {'PaleVioletRed'       }     0.86     0.44    0.576
    {'PaleVioletRed1'      }        1     0.51     0.67
    {'PaleVioletRed2'      }    0.932    0.475    0.624
    {'PaleVioletRed3'      }    0.804    0.408    0.536
    {'PaleVioletRed4'      }    0.545     0.28    0.365
    {'PapayaWhip'          }        1    0.936    0.835
    {'PeachPuff'           }        1    0.855    0.725
    {'PeachPuff1'          }        1    0.855    0.725
    {'PeachPuff2'          }    0.932    0.796     0.68
    {'PeachPuff3'          }    0.804    0.688    0.585
    {'PeachPuff4'          }    0.545    0.468    0.396
    {'Peru'                }    0.804     0.52    0.248
    {'Pink'                }        1    0.752    0.796
    {'Pink1'               }        1     0.71    0.772
    {'Pink2'               }    0.932    0.664     0.72
    {'Pink3'               }    0.804     0.57     0.62
    {'Pink4'               }    0.545     0.39    0.424
    {'Plum'                }    0.868    0.628    0.868
    {'Plum1'               }        1    0.732        1
    {'Plum2'               }    0.932    0.684    0.932
    {'Plum3'               }    0.804     0.59    0.804
    {'Plum4'               }    0.545      0.4    0.545
    {'PowderBlue'          }     0.69     0.88      0.9
    {'Purple'              }      0.5        0      0.5
    {'Purple0'             }    0.628    0.125     0.94
    {'Purple1'             }    0.608     0.19        1
    {'Purple2'             }     0.57    0.172    0.932
    {'Purple3'             }     0.49     0.15    0.804
    {'Purple4'             }    0.332      0.1    0.545
    {'Red'                 }        1        0        0
    {'Red1'                }        1        0        0
    {'Red2'                }    0.932        0        0
    {'Red3'                }    0.804        0        0
    {'Red4'                }    0.545        0        0
    {'RosyBrown'           }    0.736     0.56     0.56
    {'RosyBrown1'          }        1    0.756    0.756
    {'RosyBrown2'          }    0.932    0.705    0.705
    {'RosyBrown3'          }    0.804    0.608    0.608
    {'RosyBrown4'          }    0.545     0.41     0.41
    {'RoyalBlue'           }    0.255     0.41    0.884
    {'RoyalBlue1'          }    0.284    0.464        1
    {'RoyalBlue2'          }    0.264     0.43    0.932
    {'RoyalBlue3'          }    0.228    0.372    0.804
    {'RoyalBlue4'          }    0.152     0.25    0.545
    {'SaddleBrown'         }    0.545     0.27    0.075
    {'Salmon'              }     0.98      0.5    0.448
    {'Salmon1'             }        1     0.55     0.41
    {'Salmon2'             }    0.932     0.51    0.385
    {'Salmon3'             }    0.804     0.44     0.33
    {'Salmon4'             }    0.545    0.298    0.224
    {'SandyBrown'          }    0.956    0.644    0.376
    {'SeaGreen'            }     0.18    0.545     0.34
    {'SeaGreen1'           }     0.33        1    0.624
    {'SeaGreen2'           }    0.305    0.932     0.58
    {'SeaGreen3'           }    0.264    0.804      0.5
    {'SeaGreen4'           }     0.18    0.545     0.34
    {'Seashell'            }        1     0.96    0.932
    {'Seashell1'           }        1     0.96    0.932
    {'Seashell2'           }    0.932    0.898     0.87
    {'Seashell3'           }    0.804    0.772     0.75
    {'Seashell4'           }    0.545    0.525     0.51
    {'Sienna'              }    0.628     0.32    0.176
    {'Sienna1'             }        1     0.51     0.28
    {'Sienna2'             }    0.932    0.475     0.26
    {'Sienna3'             }    0.804    0.408    0.224
    {'Sienna4'             }    0.545     0.28     0.15
    {'Silver'              }    0.752    0.752    0.752
    {'SkyBlue'             }     0.53    0.808     0.92
    {'SkyBlue1'            }     0.53    0.808        1
    {'SkyBlue2'            }    0.494    0.752    0.932
    {'SkyBlue3'            }    0.424     0.65    0.804
    {'SkyBlue4'            }     0.29     0.44    0.545
    {'SlateBlue'           }    0.415    0.352    0.804
    {'SlateBlue1'          }    0.512    0.435        1
    {'SlateBlue2'          }     0.48    0.404    0.932
    {'SlateBlue3'          }     0.41     0.35    0.804
    {'SlateBlue4'          }     0.28    0.235    0.545
    {'SlateGray'           }     0.44      0.5    0.565
    {'SlateGray1'          }    0.776    0.888        1
    {'SlateGray2'          }    0.725    0.828    0.932
    {'SlateGray3'          }    0.624    0.712    0.804
    {'SlateGray4'          }    0.424    0.484    0.545
    {'SlateGrey'           }     0.44      0.5    0.565
    {'Snow'                }        1     0.98     0.98
    {'Snow1'               }        1     0.98     0.98
    {'Snow2'               }    0.932    0.912    0.912
    {'Snow3'               }    0.804     0.79     0.79
    {'Snow4'               }    0.545    0.536    0.536
    {'SpringGreen'         }        0        1    0.498
    {'SpringGreen1'        }        0        1    0.498
    {'SpringGreen2'        }        0    0.932    0.464
    {'SpringGreen3'        }        0    0.804      0.4
    {'SpringGreen4'        }        0    0.545     0.27
    {'SteelBlue'           }    0.275     0.51    0.705
    {'SteelBlue1'          }     0.39     0.72        1
    {'SteelBlue2'          }     0.36    0.675    0.932
    {'SteelBlue3'          }     0.31     0.58    0.804
    {'SteelBlue4'          }     0.21    0.392    0.545
    {'Tan'                 }    0.824    0.705     0.55
    {'Tan1'                }        1    0.648     0.31
    {'Tan2'                }    0.932    0.604    0.288
    {'Tan3'                }    0.804     0.52    0.248
    {'Tan4'                }    0.545    0.352     0.17
    {'Teal'                }        0      0.5      0.5
    {'Thistle'             }    0.848     0.75    0.848
    {'Thistle1'            }        1    0.884        1
    {'Thistle2'            }    0.932    0.824    0.932
    {'Thistle3'            }    0.804     0.71    0.804
    {'Thistle4'            }    0.545    0.484    0.545
    {'Tomato'              }        1     0.39     0.28
    {'Tomato1'             }        1     0.39     0.28
    {'Tomato2'             }    0.932     0.36     0.26
    {'Tomato3'             }    0.804     0.31    0.224
    {'Tomato4'             }    0.545     0.21     0.15
    {'Turquoise'           }     0.25     0.88    0.815
    {'Turquoise1'          }        0     0.96        1
    {'Turquoise2'          }        0    0.898    0.932
    {'Turquoise3'          }        0    0.772    0.804
    {'Turquoise4'          }        0    0.525    0.545
    {'Violet'              }    0.932     0.51    0.932
    {'VioletRed'           }    0.816    0.125    0.565
    {'VioletRed1'          }        1    0.244     0.59
    {'VioletRed2'          }    0.932    0.228     0.55
    {'VioletRed3'          }    0.804    0.196     0.47
    {'VioletRed4'          }    0.545    0.132     0.32
    {'Wheat'               }     0.96     0.87      0.7
    {'Wheat1'              }        1    0.905     0.73
    {'Wheat2'              }    0.932    0.848    0.684
    {'Wheat3'              }    0.804     0.73     0.59
    {'Wheat4'              }    0.545    0.494      0.4
    {'White'               }        1        1        1
    {'WhiteSmoke'          }     0.96     0.96     0.96
    {'Yellow'              }        1        1        0
    {'Yellow1'             }        1        1        0
    {'Yellow2'             }    0.932    0.932        0
    {'Yellow3'             }    0.804    0.804        0
    {'Yellow4'             }    0.545    0.545        0
    {'YellowGreen'         }    0.604    0.804    0.196
```

<br>

<div id="ref"></div>

**References**

[1] [Extending LaTeX’s color facilities: the xcolor package (v2.14, 2022/06/12), page 39](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/xcolor/xcolor.pdf).

[2] 刘海洋编著. LaTeX入门. 北京: 电子工业出版社, 2013.6.

[3] [The Colors  of `xcolor` - Garrick](https://www.garrickadenbuie.com/blog/colors-of-xcolor/).

[4] [tidyverse.org](https://www.tidyverse.org/).
