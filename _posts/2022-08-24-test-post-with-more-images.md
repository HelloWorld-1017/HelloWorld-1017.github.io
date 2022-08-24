---
layout: single
title: 测试 Post with more images(HTML `<figure>` 标签)
date: 2022-08-24 10:07:19 +0800
categories: 
 - Github Pages
tags: Jekyll
classes: wide
---

# 引用 COS 图像

将图片复制到 .md 文件中时，地址为：

```html
![image-20220824095532680](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png)
```

只需要使用后面的超链接：

```html
https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png
```

将此超链接插入到 html 语言的 `<figure> ` 标签中引用图像，并设置图片名称：

```html
<figure>
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <figcaption>Single figure.</figcaption>
</figure>
```

<figure>
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <figcaption>Fig1</figcaption>
</figure>



排列两张图像：

```html
<figure class="half">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <figcaption>Two figures.</figcaption>
</figure>
```

<figure class="half">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <figcaption>Two figures.</figcaption>
</figure>



排列三张图像：

```html
<figure class="third">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <figcaption>Three figures.</figcaption>
</figure>
```

<figure class="third">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220824095532680.png">
    <figcaption>Three figures.</figcaption>
</figure>
# 图像插入超链接

另外，图片和标题都可以插入超链接指向其他网址，以 Minimal Mistakes 官方 sample $^{[1]}$中的一张网络图片为例：

```html
<figure>
	<a href="http://farm9.staticflickr.com/8426/7758832526_cc8f681e48_b.jpg"><img src="http://farm9.staticflickr.com/8426/7758832526_cc8f681e48_c.jpg"></a>
	<figcaption><a href="http://www.flickr.com/photos/80901381@N04/7758832526/" title="Morning Fog Emerging From Trees by A Guy Taking Pictures, on Flickr">Morning Fog Emerging From Trees by A Guy Taking Pictures, on Flickr</a>.</figcaption>
</figure>
```

<figure>
	<a href="http://farm9.staticflickr.com/8426/7758832526_cc8f681e48_b.jpg"><img src="http://farm9.staticflickr.com/8426/7758832526_cc8f681e48_c.jpg"></a>
	<figcaption><a href="http://www.flickr.com/photos/80901381@N04/7758832526/" title="Morning Fog Emerging From Trees by A Guy Taking Pictures, on Flickr">Morning Fog Emerging From Trees by A Guy Taking Pictures, on Flickr</a>.</figcaption>
</figure>

<br>

**参考**

[1] [Markup: Another Post with Images - Minimal Mistakes (mmistakes.github.io)](https://mmistakes.github.io/minimal-mistakes/markup-more-images/)