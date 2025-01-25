---
title: Hello, Metafont!
toc: false
categories:
 - Design
 - LaTeX
tags:
 - Metafont
date: 2025-01-17 12:11:58 +0800
last_modified_at: 2025-01-22 14:52:03 +0800
header:
 image: https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501201426702.svg
---

Metafont is a type of macro language to define fonts, and it was originally developed by Donald Knuth when he wrote the TeX typesetting software.[^1]

<div class="quote--left" markdown="1">

Metafont is a description language used to define raster fonts. It is also the name of the interpreter that executes Metafont code, generating the bitmap fonts that can be embedded into e.g. PostScript. Metafont was devised by Donald Knuth as a companion to his TeX typesetting system.

One of the characteristics of Metafont is that the points defining the shapes of the <i class="term">glyphs</i>[^6]—for example top of a stem, or intersection of a stem and crossbar—are defined with geometrical equations; the intent that the three stems of an ‘m’ are equally spaced horizontally might be expressed as $x_2-x_1=x_3-x_2$ if points 1, 2, and 3 are at the bottom ends of the three stems, whereas the intent that they all end on the same vertical position would be $y_1=y_2=y_3$.

Metafont is a <i class="emphasize">macro language</i>, where operations such as "draw a lower case top of stem serif at point 4" might appear as one macro instruction (with the point as argument) in the program for a letter. For describing shapes, Metafont has a rich set of path construction operations that mostly relieves the user of having to calculate control points.

Many families of Metafont fonts are set up so that the main source file for a font only defines a small number of design parameters (x-height, em width, slant, vertical stroke width, etc.), then calling a separate source file common for a whole range of fonts to actually draw the individual glyphs; this is the meta aspect of the system.

...

Donald Knuth started work on font creation software in 1977, and produced the first version of Metafont in 1979. Due to shortcomings in the original Metafont language, Knuth developed an entirely new Metafont system in 1984, and it is this revised system that is used today; Metafont has a versioning system similar to that of TeX, where the number asymptotically approaches $e$ with each revision.

</div>

<div class="quote--left" markdown="1">

Metafont, not strictly part of TeX, is a font description system which allows the designer to describe characters algorithmically. <i class="emphasize">It uses Bézier curves in a fairly standard way to generate the actual characters to be displayed</i>, but Knuth devotes substantial attention to the rasterizing problem on bitmapped displays. Another thesis, by John Hobby, further explores this problem of digitizing "<i class="term">brush trajectories</i>". This term derives from the fact that <i class="emphasize">Metafont describes characters as having been drawn by abstract brushes (and erasers)</i>. It is commonly believed that TeX is based on bitmap fonts but, in fact, these programs "know" nothing about the fonts that they are using other than their dimensions. It is the responsibility of the device driver to appropriately handle fonts of other types, including PostScript Type 1 and TrueType. Computer Modern (commonly known as "the TeX font") is freely available in Type 1 format, as are the AMS math fonts. Users of TeX systems that output directly to PDF, such as pdfTeX, XeTeX, or LuaTeX, generally never use Metafont output at all.[^2]

</div>

Here is an example from Wikipedia[^1].

Firstly, we create a file named `beta.mf`, whose content is:

```latex
%file name: beta.mf
%mode_setup;
% Define a beanlike shape for the character B
beginchar("B",11pt#,11pt#,0);
  % Setup coordinates as an equation system
  y1=y2=y3=0;
  y4=y5=y6=h;
  x1=x4=0;
  x2=x5=w;
  x3=x6=2*w;

  % Define pen
  pickup pencircle xscaled 0.2w yscaled 0.04w rotated 45;

  % Draw the character curve
  % z1 is the same as (x1, y1)
  draw z1..z3..z6{z2-z6}..z5..{z4-z2}z4..cycle;
endchar;

end
```

then use Metafont interpreter `mf`, by `ljfour` mode (LJ4 emulation mode[^5]), to compile the `beta.mf` file:

```powershell
mf '\mode=ljfour; mode_setup; input beta.mf';
```

then the printed information on the terminal is:

```
This is METAFONT, Version 2.71828182 (TeX Live 2021/W32TeX) (preloaded base=mf)
(beta.mf [66] )
Font metrics written on beta.tfm.
Output written on beta.600gf (1 character, 856 bytes).
Transcript written on beta.log.
```

and three files, `beta.tfm`, `beta.log`, and `beta.600gf` are generated.

Next, use the command:

```powershell
gftopk beta.600gf beta.600pk
```

to convert the file `beta.600gf` into `beta.600pk`. Here the role of `gftopk` is[^3]:

<div class="quote--left" markdown="1">

The `gftopk` program converts a generic font file output by, for example, `mf`, to a packed font file for use by DVI-reading programs. Packed font files (`pk` files) are much smaller than the corresponding `gf` files, so they are generally the font format of choice.

</div>

At last, we can use the defined font in LaTeX document by the `\newfont` command[^4]:

{% raw %}

```latex
\documentclass{article}

\newfont{\letterbeta}{beta}
\newcommand{\otherbeta}{{\letterbeta B}}

\begin{document}
    Let's try having a strange \otherbeta\ here.
\end{document}
```

{% endraw %}

![image-20250120143352447](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202501201435102.png)

<br>

**References**

[^1]: [Metafont](https://en.wikipedia.org/wiki/Metafont).
[^2]: [TeX: Metafont](https://en.wikipedia.org/wiki/TeX#Metafont).
[^3]: [gftopk(1)](https://linux.die.net/man/1/gftopk).
[^4]: [`\newfont` (LaTeX2e unofficial reference manual (January 2025))](https://latexref.xyz/_005cnewfont.html).
[^5]: [Understanding Printer Emulation](https://support2.epson.net/manuals/english/page/epl_n2120/ref_g/CP_5.HTM).
[^6]: [Glyph](https://en.wikipedia.org/wiki/Glyph): A glyph is any kind of purposeful mark. In typography, a glyph is "the specific shape, design, or representation of a character". It is a particular graphical representation, in a particular typeface, of an element of written language.
