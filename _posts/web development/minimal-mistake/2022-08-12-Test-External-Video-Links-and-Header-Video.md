---
title: "Test External Video Links and Header Video of Jekyll Theme \"minimal-mistakes\""
categories: 
 - Web Development
tags:
 - Jekyll
toc: false
header:
  video:
    id: BV1pC4y1a7QP
    provider: bilibili
classes: wide
date: 2022-08-12 13:44:15 +0800
last_modified_at: 2024-08-25 18:31:04 +0800
---

# 使用 YAML 嵌入 Header Video

```yaml
header:
  video:
    id: BV1pC4y1a7QP
    provider: bilibili
```

<br>

# 网页内嵌入视频

## 方式1：使用 liquid （推荐）

```liquid
{% raw %}{% include video id="BV1pC4y1a7QP" provider="bilibili" %}{% endraw %}
```

{% include video id="BV1pC4y1a7QP" provider="bilibili" %}



## 方式2：使用 iframe 标签

```html
<iframe src="//player.bilibili.com/player.html?aid=795997075&bvid=BV1pC4y1a7QP&page=1&high_quality=1&danmaku=0" allowfullscreen="allowfullscreen" width="100%" height="100%" scrolling="no" frameborder="0" sandbox="allow-top-navigation allow-same-origin allow-forms allow-scripts"> </iframe>
```

<iframe src="//player.bilibili.com/player.html?aid=795997075&bvid=BV1pC4y1a7QP&page=1&high_quality=1&danmaku=0" allowfullscreen="allowfullscreen" width="100%" height="100%" scrolling="no" frameborder="0" sandbox="allow-top-navigation allow-same-origin allow-forms allow-scripts"> </iframe>

<br>

**References**

[1] [Layout: Header Video - Minimal Mistakes (mmistakes.github.io)](https://mmistakes.github.io/minimal-mistakes/layout/uncategorized/layout-header-video/).

