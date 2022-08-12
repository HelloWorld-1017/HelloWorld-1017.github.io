---
layout: single
title: BiliBili 视频外链引用
date: 2022-08-12 13:44:15 +0800
categories: 
 - Github Pages
tags: Jekyll
toc: false
header:
  video:
    id: BV1pC4y1a7QP
    provider: bilibili
classes: wide
---

<br>

# 使用 YAML 嵌入 Header Video

```yaml
header:
  video:
    id: BV1pC4y1a7QP
    provider: bilibili
```

<br>

# 网页内嵌入视频

## 方式1

```html
<iframe src="//player.bilibili.com/player.html?aid=795997075&bvid=BV1pC4y1a7QP&page=1&high_quality=1&danmaku=0" allowfullscreen="allowfullscreen" width="100%" height="500" scrolling="no" frameborder="0" sandbox="allow-top-navigation allow-same-origin allow-forms allow-scripts"> </iframe>
```

<iframe src="//player.bilibili.com/player.html?aid=795997075&bvid=BV1pC4y1a7QP&page=1&high_quality=1&danmaku=0" allowfullscreen="allowfullscreen" width="100%" height="500" scrolling="no" frameborder="0" sandbox="allow-top-navigation allow-same-origin allow-forms allow-scripts"> </iframe>

<br>

## 方式2

![image-20220812151230533](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/DeLLLaptop/image-20220812151230533.png)

{% include video id="BV1pC4y1a7QP" provider="bilibili" %}





参考

[1] [Layout: Header Video - Minimal Mistakes (mmistakes.github.io)](https://mmistakes.github.io/minimal-mistakes/layout/uncategorized/layout-header-video/)

