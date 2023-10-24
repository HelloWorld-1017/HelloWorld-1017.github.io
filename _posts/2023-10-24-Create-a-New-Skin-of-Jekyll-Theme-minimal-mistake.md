---
layout: single
title: "Create a New Skin of Jekyll Theme \"minimal-mistake\""
date: 2023-10-24 16:15:45 +0800
categories:
 - Jekyll
---

# Introduction

Jekyll theme "minimal-mistake" [[1]](#ref) provides nine optional skins [[2]](#ref), and we could specify it in `_config.yml`:

```yaml
minimal_mistakes_skin : "air" # "air", "aqua", "contrast", "dark", "dirt", "neon", "mint", "plum", "sunrise"
```

These skins are defined by `.scss` files (SCSS, i.e., Sassy Cascading Style Sheets, is a more advanced and evolved variant of the CSS language [[3]](#ref)), and these files, named `_<name>.scss`, are stored in the `.\_sass\minimal-mistakes\skins` folder. For example, `.\_sass\minimal-mistakes\skins\_air.scss` file is like:

```scss
/* ==========================================================================
   Air skin
   ========================================================================== */

/* Colors */
$background-color: #eeeeee !default;
$text-color: #222831 !default;
$muted-text-color: #393e46 !default;
$primary-color: #0092ca !default;
$border-color: mix(#fff, #393e46, 75%) !default;
$footer-background-color: $primary-color !default;
$link-color: #393e46 !default;
$masthead-link-color: $text-color !default;
$masthead-link-color-hover: $text-color !default;
$navicon-link-color-hover: mix(#fff, $text-color, 80%) !default;

.page__footer {
  color: #fff !important; // override
}

.page__footer-follow .social-icons .svg-inline--fa {
  color: inherit;
}
```

As can be seen, the `.scss` file mainly defines some colour settings of website components.

<br>

# Create `_myskin.scss` on Oct. 24, 2023

On Oct. 24, 2023, I make a copy of `_air.scss` and renamed it as `_myskin.scss`, and in which I changed colour settings of `background-color`, `link-color`, `primary-color`, and `text-color`. The complete code shows as follows:

```scss
/* ==========================================================================
   myskin skin, modified from Air skin, available from Oct. 24, 2023.
   Oct. 24, 2023:
    background-color: #eeeeee -> #ffffff;
    link-color: #393e46 -> #0076A8 -> #3366CC ;
    primary-color: #0092ca -> #0076A8;
    text-color: #222831 -> #000000;
   ========================================================================== */

/* Colors */
$background-color: #ffffff !default;
$link-color: #3366CC !default;
$primary-color: #0076A8 !default;
$text-color: #000000 !default;

$muted-text-color: #393e46 !default;
$border-color: mix(#fff, #393e46, 75%) !default;
$footer-background-color: $primary-color !default;
$masthead-link-color: $text-color !default;
$masthead-link-color-hover: $text-color !default;
$navicon-link-color-hover: mix(#fff, $text-color, 80%) !default;

.page__footer {
  color: #fff !important; // override
}

.page__footer-follow .social-icons .svg-inline--fa {
  color: inherit;
}
```

Afterwards, changing the corresponding option in `_config.yml`:

```yaml
minimal_mistakes_skin : "myskin"
```

will make it work.

<br>

<div id = "ref"></div>

**References**

[1] [mmistakes/minimal-mistakes - GitHub](https://github.com/mmistakes/minimal-mistakes). 

[2] [mmistakes/minimal-mistakes: Skins (color variations) - GitHub](https://github.com/mmistakes/minimal-mistakes).

[3] [Difference Between CSS and SCSS - BYJU's](https://byjus.com/gate/difference-between-css-and-scss/).
