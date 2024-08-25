---
title: Embed an X (Twitter) Post in Webpage
toc: false
categories:
 - Web Development
tags:
 - HTML
 - JavaScript
date: 2024-06-28 09:28:31 +0800
last_modified_at: 2024-08-25 18:51:22 +0800
---

To embed an X (Twitter) post in personal blog or website by external link, we can copy the post link and then paste it in website ‘Twitter Publish’[^1] to get a HTML code snippet. Take a post by Elon Musk, paste its link [https://x.com/elonmusk/status/1805804111037919520](https://x.com/elonmusk/status/1805804111037919520) to ‘Twitter Publish’[^1]. Next, if choose ‘Embedded Video’ style, we can get HTML code:

```html
<blockquote class="twitter-tweet" data-media-max-width="560"><p lang="zxx" dir="ltr"><a href="https://t.co/MnvArHwJRm">pic.twitter.com/MnvArHwJRm</a></p>&mdash; Elon Musk (@elonmusk) <a href="https://twitter.com/elonmusk/status/1805804111037919520?ref_src=twsrc%5Etfw">June 26, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
```

and the effect is:

<blockquote class="twitter-tweet" data-media-max-width="560"><p lang="zxx" dir="ltr"><a href="https://t.co/MnvArHwJRm">pic.twitter.com/MnvArHwJRm</a></p>&mdash; Elon Musk (@elonmusk) <a href="https://twitter.com/elonmusk/status/1805804111037919520?ref_src=twsrc%5Etfw">June 26, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<br>

Another display option is ‘Embedded Post’ style:

```html
<blockquote class="twitter-tweet"><p lang="zxx" dir="ltr"><a href="https://t.co/MnvArHwJRm">pic.twitter.com/MnvArHwJRm</a></p>&mdash; Elon Musk (@elonmusk) <a href="https://twitter.com/elonmusk/status/1805804111037919520?ref_src=twsrc%5Etfw">June 26, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
```

at this time we have:

<blockquote class="twitter-tweet"><p lang="zxx" dir="ltr"><a href="https://t.co/MnvArHwJRm">pic.twitter.com/MnvArHwJRm</a></p>&mdash; Elon Musk (@elonmusk) <a href="https://twitter.com/elonmusk/status/1805804111037919520?ref_src=twsrc%5Etfw">June 26, 2024</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

As can be seen, in the rendering process a JavaScript file named `widgets.js` is invoked from the twitter CDN, [https://platform.twitter.com](https://platform.twitter.com) (actually I’m not sure if it’s right to call it as CDN, but at least I think its function amounts to a CDN).

<br>

**References**

[^1]: [Twitter Publish](https://publish.twitter.com/#).