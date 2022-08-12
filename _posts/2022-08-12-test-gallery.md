---
layout: single
title: 测试 Gallery
date: 2022-08-12 20:16:09 +0800
categories: 
 - Github Pages
tags: Jekyll
toc: false
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
gallery2:
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
gallery3:
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
---

<br>

And then drop-in the gallery include --- gallery `caption` is optional.

```liquid
{% raw %}{% include gallery caption="This is a sample gallery with **Markdown support**." %}{% endraw %}
```

{% include gallery caption="This is a sample gallery with **Markdown support**." %}

---

And place it like so: 

```liquid
{% raw %}{% include gallery id="gallery2" caption="This is a second gallery example with images hosted externally." %}{% endraw %}
```

{% include gallery id="gallery2" caption="This is a second gallery example with images hosted externally." %}

---

And for giggles one more gallery just to make sure this works. To fill page content container add `class="full"`.

{% include gallery id="gallery3" class="full" caption="This is a third gallery example with two images and fills the entire content container." %}

---

Gallery column layout can be overrided by setting a `layout`.

```liquid
{% raw %}{% include gallery id="gallery" layout="half" caption="This is a half gallery layout example." %}{% endraw %}
```

{% include gallery id="gallery" layout="half" caption="This is a half gallery layout example." %}




参考

[1] [Post: Gallery - Minimal Mistakes (mmistakes.github.io)](https://mmistakes.github.io/minimal-mistakes/post formats/post-gallery/)
