---
title: "Style a New Skin of Jekyll Theme Minimal Mistakes"
categories:
 - Web Development
tags:
 - Jekyll
 - CSS
 - Jekyll Minimal Mistakes
date: 2023-10-24 16:15:45 +0800
last_modified_at: 2024-08-25 18:54:11 +0800
---

# Introduction

Jekyll theme "minimal-mistakes" [^1] provides nine optional skins [^2], and we could specify it in `_config.yml`:

```yaml
minimal_mistakes_skin : "air" # "air", "aqua", "contrast", "dark", "dirt", "neon", "mint", "plum", "sunrise"
```

These skins are defined by `.scss` files (SCSS, i.e., Sassy Cascading Style Sheets, is a more advanced and evolved variant of the CSS language [^3], and these files, named `_<name>.scss`, are stored in the `.\_sass\minimal-mistakes\skins` folder. For example, `.\_sass\minimal-mistakes\skins\_air.scss` file is like:

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

# Change the color matching of code block

Added on Nov. 14, 2023.
{: .notice--warning}

Adding the following code in the `_myskin.scss` will make the color matching of code block the same as that of `"contrast" ` skin:

```scss
/* contrast syntax highlighting (base16) */
$base00: #000000;
$base01: #242422;
$base02: #484844;
$base03: #6c6c66;
$base04: #918f88;
$base05: #b5b3aa;
$base06: #d9d7cc;
$base07: #fdfbee;
$base08: #ff6c60;
$base09: #e9c062;
$base0a: #ffffb6;
$base0b: #a8ff60;
$base0c: #c6c5fe;
$base0d: #96cbfe;
$base0e: #ff73fd;
$base0f: #b18a3d;
```

i.e., changing from:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311141942472.png" alt="image-20231114194242380" style="zoom:50%;" />

to:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311141942728.png" alt="image-20231114194253691" style="zoom:50%;" />

The detailed information could be found in references [^4] and [^5].

<br>

**References**

[^1]: [mmistakes/minimal-mistakes - GitHub](https://github.com/mmistakes/minimal-mistakes). 
[^2]: [mmistakes/minimal-mistakes: Skins (color variations) - GitHub](https://github.com/mmistakes/minimal-mistakes).
[^3]: [Difference Between CSS and SCSS - BYJU's](https://byjus.com/gate/difference-between-css-and-scss/).
[^4]: [基于Pages+Jekyll+Minimal-Mistakes搭建个人博客 - 悟尘记 - 李小龙的博客网站](https://www.lixl.cn/2019/061036412.html#toc-heading-4).
[^5]: [Stylesheets - Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/docs/stylesheets/#colors).
