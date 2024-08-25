---
title: "Test `notice` Division of Jekyll Theme \"minimal-mistakes\"" 
categories:
 - Web Development
tags:
 - Jekyll
 - HTML
 - CSS
date: 2022-08-12 17:03:13 +0800
last_modified_at: 2024-08-25 18:33:39 +0800
---

# Introduction

My personal website[^1] is created based on Jekyll theme "minimal-mistakes"[^2]. In this theme, there is a `.scss` file called `_notices.scss`[^3] defining a set of `notice` classes to stress some contents by wrapping them in the colorful box. 

```scss
/* ==========================================================================
   NOTICE TEXT BLOCKS
   ========================================================================== */

/**
 *  Default Kramdown usage (no indents!):
 *  <div class="notice" markdown="1">
 *  #### Headline for the Notice
 *  Text for the notice
 *  </div>
 */

@mixin notice($notice-color) {
  margin: 2em 0 !important;  /* override*/
  padding: 1em;
  color: $text-color;
  font-family: $global-font-family;
  font-size: $type-size-6 !important;
  text-indent: initial; /* override*/
  background-color: mix($background-color, $notice-color, $notice-background-mix);
  border-radius: $border-radius;
  box-shadow: 0 1px 1px rgba($notice-color, 0.25);

  h4 {
    margin-top: 0 !important; /* override*/
    margin-bottom: 0.75em;
    line-height: inherit;
  }

  @at-root .page__content #{&} h4 {
    /* using at-root to override .page-content h4 font size*/
    margin-bottom: 0;
    font-size: 1em;
  }

  p {
    &:last-child {
      margin-bottom: 0 !important; /* override*/
    }
  }

  h4 + p {
    /* remove space above paragraphs that appear directly after notice headline*/
    margin-top: 0;
    padding-top: 0;
  }

  a {
    color: mix(#000, $notice-color, 10%);

    &:hover {
      color: mix(#000, $notice-color, 50%);
    }
  }

  @at-root #{selector-unify(&, "blockquote")} {
    border-left-color: mix(#000, $notice-color, 10%);
  }

  code {
    background-color: mix($background-color, $notice-color, $code-notice-background-mix)
  }

	pre code {
		background-color: inherit;
	}

  ul {
    &:last-child {
      margin-bottom: 0; /* override*/
    }
  }
}

/* Default notice */

.notice {
  @include notice($light-gray);
}

/* Primary notice */

.notice--primary {
  @include notice($primary-color);
}

/* Info notice */

.notice--info {
  @include notice($info-color);
}

/* Warning notice */

.notice--warning {
  @include notice($warning-color);
}

/* Success notice */

.notice--success {
  @include notice($success-color);
}

/* Danger notice */

.notice--danger {
  @include notice($danger-color);
}
```

Way to stress only one paragraph including merely text and way to stress multiple paragraphs are sort of different; the former is very easy, while the latter is kind of complex (at least not a straightforward extension from the former). In this post, I would talk about them.

<br>

# Stress one paragraph of text

It is convenient to stress only one paragraph of text, all we need is to press `Shift + Enter` at the end of the paragraph and add code `{: .notice}`. That's it. 

**(1) `notice` class**

{% raw %}

```
NOTE：This is `{: .notice}` division[^3].
{: .notice}
```

{% endraw %}

NOTE：This is `{: .notice}` division[^3].
{: .notice}

**(2) `notice--primary` class**

{% raw %}

```
NOTE：This is `{: .notice--primary}` division[^3].
{: .notice--primary}
```

{% endraw %}

NOTE：This is `{: .notice--primary}` division[^3].
{: .notice--primary}

**(3) `notice--info` class**

{% raw %}

```
NOTE：This is `{: .notice--info}` division[^3].
{: .notice--info}
```

{% endraw %}

NOTE：This is `{: .notice--info}` division[^3].
{: .notice--info}

**(4) `notice--warning` class**

{% raw %}

```
NOTE：This is `{: .notice--warning}` division[^3].
{: .notice--warning}
```

{% endraw %}

NOTE：This is `{: .notice--warning}` division[^3].
{: .notice--warning}

**(5) `notice--danger` class**

{% raw %}

```
NOTE：This is `{: .notice--danger}` division[^3].
{: .notice--danger}
```

{% endraw %}

NOTE：This is `{: .notice--danger}` division[^3].
{: .notice--danger}

**(6) `notice--success` class**

{% raw %}

```
NOTE：This is `{: .notice--success}` division[^3].
{: .notice--success}
```

{% endraw %}

NOTE：This is `{: .notice--success}` division[^3].
{: .notice--success}

<br>

# Stress multiple paragraphs including more elements

## Method 1: use Jekyll liquid filter

If the purpose is to stress multiple paragraphs including more elements (images etc.) in a single notice, we could use liquid to capture content and then filter it with `markdownify` option. It is the way that offered by official sample blog of "minimal-mistakes" theme[^4].

For example:

{% raw %}

```
{% capture notice-2 %}

This is the 1st paragraph.

This is the 2nd paragraph.

This is the 3rd paragraph.

This is the text attached with a footnote[^3].

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" style="zoom:50%;" />

{% endcapture %}

<div class="notice--primary">{{ notice-2 | markdownify }}</div>
```

{% endraw %}

The result is like:

{% capture notice-2 %}

This is the 1st paragraph.

This is the 2nd paragraph.

This is the 3rd paragraph.

This is the text attached with a footnote[^3].

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" style="zoom:50%;" />

{% endcapture %}

<div class="notice--primary">{{ notice-2 | markdownify }}</div>

It looks well but one point: the footnote is plain text with no link that it should've had. About this point, I have no idea how to correct it.

## Method 2: directly use HTML `<div>` tag

Another way is directly putting all contents in a `<div>` tag with `class="$CLASS_NAME"` and `markdown="1"`[^5], which is obtained from the comments of `_notices.scss` file[^3].

For example:

{% raw %}

```
<div class="notice--primary" markdown="1">

This is the 1st paragraph.

This is the 2nd paragraph.

This is the 3rd paragraph.

This is the text attached with a footnote[^3].

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" style="zoom:50%;" />

</div>
```

{% endraw %}

The result is like:

<div class="notice--primary" markdown="1">

This is the 1st paragraph.

This is the 2nd paragraph.

This is the 3rd paragraph.

This is the text attached with a footnote[^3].

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" style="zoom:50%;" />

</div>

To my mind, this method is a more obvious way and by which the footnote works normally. 

<br>

**References**

- [Markup: HTML Tags and Formatting - Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/markup/markup-html-tags-and-formatting/#top).
- [Layout: Post with Sticky Table of Contents - Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/layout-table-of-contents-sticky/).
- [解决Jekyll代码块无法正常显示Liquid代码问题 - CSDN博客](https://blog.csdn.net/JireRen/article/details/52197045).

[^1]: [WHAT A STARRY NIGHT~](https://helloworld-1017.github.io/).
[^2]: [mmistakes/minimal-mistakes: Jekyll theme for building a personal site, blog, project documentation, or portfolio.](https://github.com/mmistakes/minimal-mistakes).
[^3]: [minimal-mistakes/\_sass/minimal-mistakes/\_notices.scss at master · mmistakes/minimal-mistakes](https://github.com/mmistakes/minimal-mistakes/blob/master/_sass/minimal-mistakes/_notices.scss).
[^4]: [Post: Notice - Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/post%20formats/post-notice/).
[^5]: [https://stackoverflow.com/a/69813865/22763127](https://stackoverflow.com/a/69813865/22763127).





