---
title: "Test Gallery of Jekyll Theme \"minimal-mistakes\""
toc: false
categories:
 - Web Development
tags: 
 - Jekyll
classes: wide
gallery:
 - url: /images/PeakyBlinders1.jpg
   image_path: /images/PeakyBlinders1.jpg
   alt: "placeholder image 1"
   title: "Peaky Blinders 1"
 - url: /images/PeakyBlinders2.jpg
   image_path: /images/PeakyBlinders2.jpg
   alt: "placeholder image 2"
   title: "Peaky Blinders 2"
 - url: /images/PeakyBlinders3.jpg
   image_path: /images/PeakyBlinders3.jpg
   alt: "placeholder image 3"
   title: "Peaky Blinders 3"
 - url: /images/PeakyBlinders4.jpg
   image_path: /images/PeakyBlinders4.jpg
   alt: "placeholder image 4"
   title: "Peaky Blinders 4"
date: 2022-08-12 20:16:09 +0800
last_modified_at: 2024-08-25 18:31:50 +0800
---

在 YAML Front Matter 中写入：

```yaml
gallery:
 - url: /images/PeakyBlinders1.jpg
   image_path: /images/PeakyBlinders1.jpg
   alt: "placeholder image 1"
   title: "Peaky Blinders 1"
 - url: /images/PeakyBlinders2.jpg
   image_path: /images/PeakyBlinders2.jpg
   alt: "placeholder image 2"
   title: "Peaky Blinders 2"
 - url: /images/PeakyBlinders3.jpg
   image_path: /images/PeakyBlinders3.jpg
   alt: "placeholder image 3"
   title: "Peaky Blinders 3"
 - url: /images/PeakyBlinders4.jpg
   image_path: /images/PeakyBlinders4.jpg
   alt: "placeholder image 4"
   title: "Peaky Blinders 4"
```

之后就可以在正文中引用 `gallery` ，并且可以选择添加 `captain`

```liquid
{% raw %}{% include gallery caption="This is a sample gallery with **Markdown support**." %}{% endraw %}
```

{% include gallery caption="This is a sample gallery with **Markdown support**." %}

<br>

或者使用下面的方式引用：

```liquid
{% raw %}{% include gallery id="gallery" caption="This is a sample gallery with **Markdown support**." %}{% endraw %}
```

{% include gallery id="gallery" caption="This is a sample gallery with **Markdown support**." %}

并且可以使用 COS 图床，只需要更换为相应的 `url` 即可。

<br>

可以添加 `class="full"` 设置铺满整个 page content container：

```liquid
{% raw %}{% include gallery id="gallery" class="full" caption="This is a third gallery example with two images and fills the entire content container." %}{% endraw %}
```

{% include gallery id="gallery" class="full" caption="This is a third gallery example with two images and fills the entire content container." %}

<br>

可以使用 `layout` 属性重载 column layout ：

```liquid
{% raw %}{% include gallery id="gallery" layout="half" caption="This is a half gallery layout example." %}{% endraw %}
```

{% include gallery id="gallery" layout="half" caption="This is a half gallery layout example." %}

<br>

**References**

[1] [Post: Gallery - Minimal Mistakes (mmistakes.github.io)](https://mmistakes.github.io/minimal-mistakes/post formats/post-gallery/)
