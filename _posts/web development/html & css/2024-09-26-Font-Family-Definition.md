---
title: Font Family Definition in HTML and CSS(/SCSS)
toc: false
categories:
 - Design
 - HTML
 - Web Development
tags:
 - CSS
 - SCSS
date: 2024-09-26 21:36:49 +0800
last_modified_at: 2025-01-07 14:16:13 +0800
---

In the `.scss` file of Jekyll theme Minimal Mistakes[^1], there are three font variables defined, `$serif`, `$sans-serif`, and `$monospace`:

<div id="font-defs"></div>

```scss
/* system typefaces */
$serif: Georgia, Times, serif !default;
$sans-serif: -apple-system, BlinkMacSystemFont, "Roboto", "Segoe UI",
  "Helvetica Neue", "Lucida Grande", Arial, sans-serif !default;
$monospace: Monaco, Consolas, "Lucida Console", monospace !default;
```

For each variable, a series of font names are specified. This is a kind of "fallback" system, to ensure maximum compatibility for different browsers or systems:

<div class="quote--left" markdown="1">

The `font-family` property should hold several font names as a <i class="term">"fallback" system</i>, to ensure maximum compatibility between browsers/operating systems. Start with the font you want, and end with a <i class="term">generic family</i> (to let the browser pick a similar font in the generic family, if no other fonts are available). The font names should be separated with a comma.[^4]

</div>

where the last font specified at the end, `serif`, `sans-serif`, and `monospace` for each, is a generic family, or rather, generic name[^2]:

<div class="quote--left" markdown="1">

You should always include at least one generic family name in a `font-family` list, since there's no guarantee that any given font is available. This lets the browser select an acceptable fallback font when necessary.

...

`<generic-name>`

Generic font families are a fallback mechanism, a means of preserving some of the style sheet author's intent when none of the specified fonts are available. Generic family names are keywords and must not be quoted. A generic font family should be the last item in the list of font family names. The following keywords are defined:

`serif`

Glyphs have finishing strokes, flared or tapering ends, or have actual serifed endings.

For example: Lucida Bright, Lucida Fax, Palatino, Palatino Linotype, Palladio, URW Palladio, serif.

`sans-serif`

Glyphs have stroke endings that are plain.

For example: Open Sans, Fira Sans, Lucida Sans, Lucida Sans Unicode, Trebuchet MS, Liberation Sans, Nimbus Sans L, sans-serif.

`monospace`

All glyphs have the same fixed width.

For example: Fira Mono, DejaVu Sans Mono, Menlo, Consolas, Liberation Mono, Monaco, Lucida Console, monospace.

...

</div>

In addition to above three generic names, there are also `cursive`, `fantasy`, `system-ui`, `ui-serif`, `ui-sans-serif`, `ui-monospace`, `ui-rounded`, `math`, `emoji`, and `fangsong`[^2].

For those font specifications before the generic font name, font names which are safer to become backup fonts should be put closer to the end. Here are some “the best web safe fonts”[^5]:

<div class="quote--left" markdown="1">

This means that you should add a list of similar "backup fonts" in the `font-family` property. If the first font does not work, the browser will try the next one, and the next one, and so on. Always end the list with a generic font family name.

...

The following list are the best web safe fonts for HTML and CSS:

- **Arial (sans-serif)**
  - Arial is the most widely used font for both online and printed media. Arial is also the default font in Google Docs. Arial is one of the safest web fonts, and it is available on all major operating systems.
- **Verdana (sans-serif)**
  - Verdana is a very popular font. Verdana is easily readable even for small font sizes.
- **Tahoma (sans-serif)**
  - The Tahoma font has less space between the characters.
- **Trebuchet MS (sans-serif)**
  - Trebuchet MS was designed by Microsoft in 1996. Use this font carefully. Not supported by all mobile operating systems.
- **Times New Roman (serif)**
  - Times New Roman is one of the most recognizable fonts in the world. It looks professional and is used in many newspapers and "news" websites. It is also the primary font for Windows devices and applications.
- **Georgia (serif)**
  - Georgia is an elegant serif font. It is very readable at different font sizes, so it is a good candidate for mobile-responsive design.
- **Garamond (serif)**
  - Garamond is a classical font used for many printed books. It has a timeless look and good readability.
- **Courier New (monospace)**
  - Courier New is the most widely used monospace serif font. Courier New is often used with coding displays, and many email providers use it as their default font. Courier New is also the standard font for movie screenplays.
- **Brush Script MT (cursive)**
  - The Brush Script MT font was designed to mimic handwriting. It is elegant and sophisticated, but can be hard to read. Use it carefully.

</div>

Besides, a GitHub issue[^3] advocates that it’s better to use "system" fonts, like `-apple-system`, `system-ui`, and `BlinkMacSystemFont`, rather than specific font names, to adapt to different systems and machines:

<div class="quote--left" markdown="1">

It's time to add: `font-family: -apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif`

This solution is harmless and very useful.

It is used by GitHub, Wordpress, Bootstrap, Medium, Ghost, etc.

The main reason for using "system" fonts is performance. Fonts are typically one of the largest/heaviest resources loaded on a website. If we can use a font already available on the user’s machine, we can completely eliminate the need to fetch this resource, making load times noticeably faster.
The beauty of system fonts is that it matches what the current OS uses, so it can be a comfortable look.

- `-apple-system` targets `San Francisco` in Safari (on Mac OS X and iOS), and it targets `Neue Helvetica` and `Lucida Grande` on older versions of Mac OS X. It properly selects between `San Francisco Text` and `San Francisco Display` depending on the text’s size.
- ...
- `BlinkMacSystemFont` is the equivalent for Chrome on Mac OS X.
- `Segoe UI` targets Windows and Windows Phone.
- `Roboto` targets Android and newer Chrome OS. It is deliberately listed after `Segoe UI` so that if you’re an Android developer on Windows and have `Roboto` installed, `Segoe UI` will be used instead.

</div>

In this example, the definition of `font-family` looks very similar to that of [`$sans-serif`](#font-defs) of Minimal Mistakes theme.

As for the system font `-apple-system`, here is an article introducing it detailedly[^6].

<br>

**References**

[^1]: [minimal-mistakes/\_sass/minimal-mistakes/\_variables.scss](https://github.com/mmistakes/minimal-mistakes/blob/master/_sass/minimal-mistakes/_variables.scss).

[^2]: [font-family - CSS: Cascading Style Sheets](https://developer.mozilla.org/en-US/docs/Web/CSS/font-family).
[^3]: [`font-family: -apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif` · Issue #665 · necolas/normalize.css](https://github.com/necolas/normalize.css/issues/665).

[^4]: [CSS Fonts](https://www.w3schools.com/css/css_font.asp).
[^5]: [CSS Web Safe Fonts](https://www.w3schools.com/css/css_font_websafe.asp).
[^6]: [What is font-family `-apple-system` ?](https://www.geeksforgeeks.org/what-is-font-family-apple-system/).
