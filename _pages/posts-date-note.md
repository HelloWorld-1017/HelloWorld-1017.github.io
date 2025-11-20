---
title: Posts Date Note
layout: single
toc: false
permalink: /posts-date-note.html
---

Jekyll website automatically converts all posts time, `date` field of front matter in `.md` file, into preset time zone during deployment, which is specified by the `timezone` field in the `_config.yml` file. On the other hand, to keep the posts permalink consistent, I ever made whose structure determined by `date`[^1], instead of `categories` and `title` since I will modify those two fields from time to time but I definitely won't modify the `date`. In these settings, if I change the `timezone` of `_config.yml` file, all previous permalinks will be changed, being added a time zone bias. This will cause all cross-references that point to my early blogs to stop working. So, I decide to keep `timezone` as `Asia/Shanghai` forever --- UTC+08:00, which is used in my early posts --- although sometimes I will travel to other countries/regions of different time zones. Anyway, exact post time of each blog, accurate to the second with UTC bias, can be found in its source `.md` file; permalinks and dates displayed on the website are all in UTC+08:00[^2].

Good luck! 👻

![Timezones2008_UTC+8_gray](https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/20251117100809475.png)

<br>

**References**

[^1]: [Modify Permalink Structure of Jekyll Theme Minimal Mistakes](/2023-10-21/19-27-36.html).
[^2]: [UTC+08:00](https://en.wikipedia.org/wiki/UTC%2B08:00).