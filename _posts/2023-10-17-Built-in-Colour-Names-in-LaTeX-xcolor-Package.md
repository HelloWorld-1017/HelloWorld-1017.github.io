---
layout: single
title: "Built-in Colour Names in LaTeX xcolor Package"
date: 2023-10-17 18:16:22 +0800
categories:
 - LaTeX
 - Graphic Design and Typography
 - R
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

<br>

<div id="ref"></div>

**References**

[1] [Extending LaTeX’s color facilities: the xcolor package (v2.14, 2022/06/12), page 39](https://mirror-hk.koddos.net/CTAN/macros/latex/contrib/xcolor/xcolor.pdf).

[2] 刘海洋编著. LaTeX入门. 北京: 电子工业出版社, 2013.6.

[3] [The Colors  of `xcolor` - Garrick](https://www.garrickadenbuie.com/blog/colors-of-xcolor/).

[4] [tidyverse.org](https://www.tidyverse.org/).
