---
title: "Test Webpage Layout `splash` of Jekyll Theme \"minimal-mistakes\""
layout: splash
categories:
 - Web Development
tags:
 - Jekyll
 - HTML

header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg
  actions:
    - label: "REFERENCE LINK"
      url: "https://github.com/mmistakes/minimal-mistakes/blob/master/docs/_pages/splash-page.md"
  caption: "IMAGE CAPTION"
excerpt: "This is excerpt."
intro: 
  - excerpt: 'This is excerpt.'

feature_row:
  - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg
    image_caption: "IMAGE CAPTION"
    alt: "placeholder image 1"
    title: "Placeholder 1"
    excerpt: "This is excerpt."
    url: "https://helloworld-1017.github.io/"
    btn_label: "Read More"
    btn_class: "btn--primary"
  - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg
    image_caption: "IMAGE CAPTION"
    alt: "placeholder image 2"
    title: "Placeholder 2"
    excerpt: "This is excerpt."
    url: "https://helloworld-1017.github.io/"
    btn_label: "Read More"
    btn_class: "btn--primary"
  - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg
    image_caption: "IMAGE CAPTION"
    alt: "placeholder image 2"
    title: "Placeholder 3"
    excerpt: "This is excerpt."
    url: "https://helloworld-1017.github.io/"
    btn_label: "Read More"
    btn_class: "btn--primary"

feature_row2:
  - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg
    image_caption: "IMAGE CAPTION"
    alt: "placeholder image 2"
    title: "Placeholder Image Left Aligned"
    excerpt: 'This is excerpt.'
    url: "https://helloworld-1017.github.io/"
    btn_label: "Read More"
    btn_class: "btn--primary"

feature_row3:
  - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg
    image_caption: "IMAGE CAPTION"
    alt: "placeholder image 2"
    title: "Placeholder Image Right Aligned"
    excerpt: 'This is excerpt.'
    url: "https://helloworld-1017.github.io/"
    btn_label: "Read More"
    btn_class: "btn--primary"

feature_row4:
  - image_path: https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg
    image_caption: "IMAGE CAPTION"
    alt: "placeholder image 2"
    title: "Placeholder Image Center Aligned"
    excerpt: 'This is excerpt.'
    url: "https://helloworld-1017.github.io/"
    btn_label: "Read More"
    btn_class: "btn--primary"

date: 2024-05-31 20:08:05 +0800
last_modified_at: 2024-07-13 16:44:21 +0800
---

{% include feature_row id="intro" type="center" %}

{% include feature_row %}

{% include feature_row id="feature_row2" type="left" %}

{% include feature_row id="feature_row3" type="right" %}

{% include feature_row id="feature_row4" type="center" %}





