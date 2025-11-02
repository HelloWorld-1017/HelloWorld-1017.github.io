---
title: Autoplay YouTube Videos When Using Embed Code to Share
toc: false
categories:
 - Web Development
tags:
 - HTML
location: Buffalo, United States
date: 2025-10-31 20:32:56 -0400
last_modified_at: 2025-10-31 20:32:56 -0400
---

When using embed code to share YouTube videos, we can set `autoplay` option as `1` to make it autoplay[^1]. Here is an example:

```html
<iframe class="iframe--video" width="560" height="315" src="https://www.youtube.com/embed/8eg__nN-CtQ?si=izinjWYnk7GKgCaU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay=1; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
```

<iframe class="iframe--video" width="560" height="315" src="https://www.youtube.com/embed/8eg__nN-CtQ?si=izinjWYnk7GKgCaU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay=1; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

<br>

**References**

[^1]: [How can I autoplay a video using the new embed code style for Youtube?](https://stackoverflow.com/questions/3405242/how-can-i-autoplay-a-video-using-the-new-embed-code-style-for-youtube).
