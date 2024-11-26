---
title: HTML `<time>` Tag
toc: false
categories:
 - Web Development
tags:
 - HTML
date: 2024-11-25 13:22:16 +0800
last_modified_at: 2024-11-25 13:22:16 +0800
---

HTML `<time>` tag[^1]:

<div class="quote--left" markdown="1">

The `<time>` tag defines a specific time (or datetime).

The `datetime` attribute of this element is used translate the time into a machine-readable format so that browsers can offer to add date reminders through the user's calendar, and search engines can produce smarter search results.

</div>

Those available `datetime` formats can be found in documentations[^2][^3].

It should be noted that "the `<time>` element does not render as anything special in any of the major browsers"[^4], for example:

```html
Today is <time datetime="2024-11-25">Nov. 25, 2024</time>.
```

Today is <time datetime="2024-11-25">Nov. 25, 2024</time>.

We can see there is nothing special, but we can check its difference in developer mode. So I think the `<time>` tag is mainly convenient for web development, e.g. when using CSS and JavaScript, not for formating date strings.

<br>

**References**

[^1]: [HTML `<time>` Tag](https://www.w3schools.com/tags/tag_time.asp).
[^2]: [HTML `<time>` `datetime` Attribute](https://www.w3schools.com/tags/att_time_datetime.asp).
[^3]: [{% raw %}`<time>`{% endraw %}: The (Date) Time element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/time).
[^4]: [W3Schools Tryit Editor](https://www.w3schools.com/tags/tryit.asp?filename=tryhtml5_time).