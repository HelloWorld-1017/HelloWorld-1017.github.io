---
title: Wrap Text Around an Image in Webpage
toc: false
categories:
 - Web Development
tags:
 - HTML
 - CSS
drafted_at: 2024-07-02 08:28:43 +0800
date: 2024-07-04 11:09:08 +0800
last_modified_at: 2024-07-04 11:09:08 +0800
modification_history:
 - 2024-07-04 11:09:08 +0800
---

To wrap text around an image in webpages, blog[^1] provides two ways. The first one is by specifying `align` attribute of  HTML `<img>` tag as `"left"` (or `"right"`), and the second is by putting the image into a `<div>` tag and then specifying the division’s style as `"float:left"` (or `"float:right"`). Take the `"left"` case.

**(1) Specify `align="left"` for `<img>` tag**

<div class="notice" markdown="1">

<p style="text-align:center"><font size="7">Lorem Ipsum</font></p>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur interdum dui id bibendum pretium. Donec id nunc id sapien pellentesque elementum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi vitae arcu egestas tortor maximus tempor. Nunc sit amet est orci. Duis erat magna, varius aliquam massa consequat, commodo blandit diam. Maecenas cursus ex eu urna volutpat consectetur. Sed mi tellus, condimentum sit amet odio in, pharetra elementum nisl. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod ligula et metus facilisis, in posuere augue bibendum. Mauris sit amet augue fermentum, scelerisque erat at, ultrices nisl. Proin nec ex ut risus vulputate consequat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Proin et malesuada est.

Donec eu bibendum nisl, et tempus nisl. Sed id ullamcorper nibh, sed elementum nulla. Donec volutpat diam id ipsum mollis tristique. Nunc arcu diam, venenatis ac mauris pharetra, eleifend pretium nunc. Sed enim ex, convallis eget posuere a, vestibulum sed elit. Praesent a congue ipsum, a fermentum lacus. Sed eleifend volutpat mollis. Suspendisse bibendum diam non neque consequat commodo. In dignissim, leo at suscipit molestie, leo ligula vestibulum diam, ut tristique leo arcu eget eros.

<div id="fig-1"></div>

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" align="left" width="370" hspace="50" vspace="50"/>

Sed eleifend at tortor vel euismod. Fusce odio turpis, finibus sit amet elit eget, ornare gravida ante. Nullam elementum molestie lorem, at convallis mauris maximus posuere. Aenean efficitur quis ipsum ut volutpat. Morbi metus augue, blandit nec erat eu, suscipit scelerisque libero. Fusce viverra urna nec turpis sodales, vel molestie odio cursus. Praesent quis dapibus lectus. In ut vulputate ligula.

Ut et facilisis mauris. In eget pellentesque eros, at porttitor lorem. Cras interdum eros elit, rutrum dapibus dui lacinia vel. Quisque in nunc enim. Pellentesque mollis diam tortor, ut lacinia sapien rhoncus at. Cras finibus, dolor quis fermentum luctus, urna sem tempus nibh, ac pretium velit elit sed libero. Nunc aliquam hendrerit ex, varius pretium massa rutrum in. Pellentesque facilisis ex justo, blandit sollicitudin purus vehicula eu. Nam non urna sit amet dui placerat commodo.

Donec vehicula viverra tempus. Morbi lorem erat, facilisis eu consectetur in, dignissim id ante. Curabitur tincidunt nunc bibendum, dictum arcu eu, egestas quam. Nulla ex diam, mollis id erat quis, blandit interdum nulla. Nulla non facilisis turpis. Donec varius rutrum libero id tempus. Sed ullamcorper sapien vitae lacus commodo, sollicitudin feugiat odio varius. Etiam sem tortor, ultrices vel elit ac, tempor egestas odio. Ut rutrum orci a congue laoreet. Suspendisse euismod nisl ut enim lobortis ultrices in id nisi. Phasellus sed iaculis est. Aenean eget eros ut eros sollicitudin laoreet facilisis nec tellus. Suspendisse tempor nunc et justo ullamcorper varius.

Donec sagittis, risus in volutpat auctor, est mi iaculis tortor, eget sollicitudin tellus lorem a urna. Integer placerat libero sit amet elit vehicula facilisis. Donec iaculis nunc quis lectus ultricies, vel aliquet leo pretium. Sed placerat congue pellentesque. Phasellus placerat nec urna eu auctor. Maecenas lacinia tellus et semper efficitur. Praesent a massa quis felis semper commodo. Integer varius magna efficitur, efficitur tortor id, dictum purus. Integer a nisl leo.

Nullam tincidunt mi et mi placerat egestas. Nunc fermentum eu felis at facilisis. In a massa libero. Vivamus leo odio, consectetur vel tincidunt non, eleifend ut tortor. Nullam eget lacus a erat dignissim ultrices. Integer et mi commodo, pellentesque velit id, porta sem. Aliquam non consectetur nisi. Nam erat turpis, lobortis ac metus ut, pretium malesuada magna. Nulla lobortis, nisi ac varius feugiat, ex neque maximus mauris, ut volutpat dolor sem sed est. Nam condimentum iaculis tincidunt. Etiam ac porta lorem. Suspendisse vestibulum placerat ligula ac luctus. Nulla facilisi. Sed dictum quis augue quis cursus.

</div>

<div class="notice--primary" markdown="1" id="html-1">
HTML code for above image:

```html
<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" align="left" width="370" hspace="50" vspace="50"/>
```

</div>

**(2) Specify `style="float:left"` for `<div>` tag**

<div class="notice" markdown="1">

<p style="text-align:center"><font size="7">Lorem Ipsum</font></p>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur interdum dui id bibendum pretium. Donec id nunc id sapien pellentesque elementum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi vitae arcu egestas tortor maximus tempor. Nunc sit amet est orci. Duis erat magna, varius aliquam massa consequat, commodo blandit diam. Maecenas cursus ex eu urna volutpat consectetur. Sed mi tellus, condimentum sit amet odio in, pharetra elementum nisl. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod ligula et metus facilisis, in posuere augue bibendum. Mauris sit amet augue fermentum, scelerisque erat at, ultrices nisl. Proin nec ex ut risus vulputate consequat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Proin et malesuada est.

Donec eu bibendum nisl, et tempus nisl. Sed id ullamcorper nibh, sed elementum nulla. Donec volutpat diam id ipsum mollis tristique. Nunc arcu diam, venenatis ac mauris pharetra, eleifend pretium nunc. Sed enim ex, convallis eget posuere a, vestibulum sed elit. Praesent a congue ipsum, a fermentum lacus. Sed eleifend volutpat mollis. Suspendisse bibendum diam non neque consequat commodo. In dignissim, leo at suscipit molestie, leo ligula vestibulum diam, ut tristique leo arcu eget eros.

<div id="fig-2"></div>

<div style="float:left;">
<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" width="370" hspace="50" vspace="50"/>
</div>

Sed eleifend at tortor vel euismod. Fusce odio turpis, finibus sit amet elit eget, ornare gravida ante. Nullam elementum molestie lorem, at convallis mauris maximus posuere. Aenean efficitur quis ipsum ut volutpat. Morbi metus augue, blandit nec erat eu, suscipit scelerisque libero. Fusce viverra urna nec turpis sodales, vel molestie odio cursus. Praesent quis dapibus lectus. In ut vulputate ligula.

Ut et facilisis mauris. In eget pellentesque eros, at porttitor lorem. Cras interdum eros elit, rutrum dapibus dui lacinia vel. Quisque in nunc enim. Pellentesque mollis diam tortor, ut lacinia sapien rhoncus at. Cras finibus, dolor quis fermentum luctus, urna sem tempus nibh, ac pretium velit elit sed libero. Nunc aliquam hendrerit ex, varius pretium massa rutrum in. Pellentesque facilisis ex justo, blandit sollicitudin purus vehicula eu. Nam non urna sit amet dui placerat commodo.

Donec vehicula viverra tempus. Morbi lorem erat, facilisis eu consectetur in, dignissim id ante. Curabitur tincidunt nunc bibendum, dictum arcu eu, egestas quam. Nulla ex diam, mollis id erat quis, blandit interdum nulla. Nulla non facilisis turpis. Donec varius rutrum libero id tempus. Sed ullamcorper sapien vitae lacus commodo, sollicitudin feugiat odio varius. Etiam sem tortor, ultrices vel elit ac, tempor egestas odio. Ut rutrum orci a congue laoreet. Suspendisse euismod nisl ut enim lobortis ultrices in id nisi. Phasellus sed iaculis est. Aenean eget eros ut eros sollicitudin laoreet facilisis nec tellus. Suspendisse tempor nunc et justo ullamcorper varius.

Donec sagittis, risus in volutpat auctor, est mi iaculis tortor, eget sollicitudin tellus lorem a urna. Integer placerat libero sit amet elit vehicula facilisis. Donec iaculis nunc quis lectus ultricies, vel aliquet leo pretium. Sed placerat congue pellentesque. Phasellus placerat nec urna eu auctor. Maecenas lacinia tellus et semper efficitur. Praesent a massa quis felis semper commodo. Integer varius magna efficitur, efficitur tortor id, dictum purus. Integer a nisl leo.

Nullam tincidunt mi et mi placerat egestas. Nunc fermentum eu felis at facilisis. In a massa libero. Vivamus leo odio, consectetur vel tincidunt non, eleifend ut tortor. Nullam eget lacus a erat dignissim ultrices. Integer et mi commodo, pellentesque velit id, porta sem. Aliquam non consectetur nisi. Nam erat turpis, lobortis ac metus ut, pretium malesuada magna. Nulla lobortis, nisi ac varius feugiat, ex neque maximus mauris, ut volutpat dolor sem sed est. Nam condimentum iaculis tincidunt. Etiam ac porta lorem. Suspendisse vestibulum placerat ligula ac luctus. Nulla facilisi. Sed dictum quis augue quis cursus.

</div>

<div class="notice--primary" markdown="1" id="html-2">
HTML code for above image:

```html
<div style="float:left;">
<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" width="370" hspace="50" vspace="50"/>
</div>
```

</div>

<br>

In [HTML code 1](#html-1) and [HTML code 2](#html-2), attributes `hspace` and `vspace` of `<img>` tag are specified as `50`, meaning that we want to make a 50 px horizontal and vertical space between the text and the image. However,  [Fig. 1](#fig-1) and [Fig. 2](#fig-2) show that attribute specification of `vspace` works but that of `hspace` doesn’t. This is because HTML 5 doesn’t support `hspace` any more[^2]:

<div class="quote--left" markdown="1">

The HTML `<img>` `hspace` attribute is used to specify the number of whitespaces on the left and the right side of the image. The `hspace` attribute is not supported by HTML 5 you can use CSS there.

</div>

<div class="notice--warning" markdown="1">

However, as said in documentation[^3], HTML 5 doesn’t support `vspace` attribute either:

<div class="quote--left" markdown=1>

The HTML `<img>` `vspace` Attribute is used to specify the number of whitespaces on bottom and top side of an image.

Note: The HTML `vspace` Attribute not supported by HTML5.

</div>

But in the above two cases, `vspace` is indeed available. So, I’m kind of confused about this point 🤨

</div>

So, to realize our needs of setting a blank space, it is a choice to specify `padding` attribute of `<div>` style (or more detailed attributes `padding-top`, `padding-bottom`, `padding-left`, and `padding-right`). For example:

<div class="notice" markdown="1">

<p style="text-align:center"><font size="7">Lorem Ipsum</font></p>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur interdum dui id bibendum pretium. Donec id nunc id sapien pellentesque elementum. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi vitae arcu egestas tortor maximus tempor. Nunc sit amet est orci. Duis erat magna, varius aliquam massa consequat, commodo blandit diam. Maecenas cursus ex eu urna volutpat consectetur. Sed mi tellus, condimentum sit amet odio in, pharetra elementum nisl. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris euismod ligula et metus facilisis, in posuere augue bibendum. Mauris sit amet augue fermentum, scelerisque erat at, ultrices nisl. Proin nec ex ut risus vulputate consequat. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Proin et malesuada est.

<div style="float:left;padding:50px">
<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" width="370"/>
</div>

Donec eu bibendum nisl, et tempus nisl. Sed id ullamcorper nibh, sed elementum nulla. Donec volutpat diam id ipsum mollis tristique. Nunc arcu diam, venenatis ac mauris pharetra, eleifend pretium nunc. Sed enim ex, convallis eget posuere a, vestibulum sed elit. Praesent a congue ipsum, a fermentum lacus. Sed eleifend volutpat mollis. Suspendisse bibendum diam non neque consequat commodo. In dignissim, leo at suscipit molestie, leo ligula vestibulum diam, ut tristique leo arcu eget eros.

Sed eleifend at tortor vel euismod. Fusce odio turpis, finibus sit amet elit eget, ornare gravida ante. Nullam elementum molestie lorem, at convallis mauris maximus posuere. Aenean efficitur quis ipsum ut volutpat. Morbi metus augue, blandit nec erat eu, suscipit scelerisque libero. Fusce viverra urna nec turpis sodales, vel molestie odio cursus. Praesent quis dapibus lectus. In ut vulputate ligula.

Ut et facilisis mauris. In eget pellentesque eros, at porttitor lorem. Cras interdum eros elit, rutrum dapibus dui lacinia vel. Quisque in nunc enim. Pellentesque mollis diam tortor, ut lacinia sapien rhoncus at. Cras finibus, dolor quis fermentum luctus, urna sem tempus nibh, ac pretium velit elit sed libero. Nunc aliquam hendrerit ex, varius pretium massa rutrum in. Pellentesque facilisis ex justo, blandit sollicitudin purus vehicula eu. Nam non urna sit amet dui placerat commodo.

<div style="float:right;padding-left:50px;padding-bottom:50px">
<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" width="370"/>
</div>

Donec vehicula viverra tempus. Morbi lorem erat, facilisis eu consectetur in, dignissim id ante. Curabitur tincidunt nunc bibendum, dictum arcu eu, egestas quam. Nulla ex diam, mollis id erat quis, blandit interdum nulla. Nulla non facilisis turpis. Donec varius rutrum libero id tempus. Sed ullamcorper sapien vitae lacus commodo, sollicitudin feugiat odio varius. Etiam sem tortor, ultrices vel elit ac, tempor egestas odio. Ut rutrum orci a congue laoreet. Suspendisse euismod nisl ut enim lobortis ultrices in id nisi. Phasellus sed iaculis est. Aenean eget eros ut eros sollicitudin laoreet facilisis nec tellus. Suspendisse tempor nunc et justo ullamcorper varius.

Donec sagittis, risus in volutpat auctor, est mi iaculis tortor, eget sollicitudin tellus lorem a urna. Integer placerat libero sit amet elit vehicula facilisis. Donec iaculis nunc quis lectus ultricies, vel aliquet leo pretium. Sed placerat congue pellentesque. Phasellus placerat nec urna eu auctor. Maecenas lacinia tellus et semper efficitur. Praesent a massa quis felis semper commodo. Integer varius magna efficitur, efficitur tortor id, dictum purus. Integer a nisl leo.

Nullam tincidunt mi et mi placerat egestas. Nunc fermentum eu felis at facilisis. In a massa libero. Vivamus leo odio, consectetur vel tincidunt non, eleifend ut tortor. Nullam eget lacus a erat dignissim ultrices. Integer et mi commodo, pellentesque velit id, porta sem. Aliquam non consectetur nisi. Nam erat turpis, lobortis ac metus ut, pretium malesuada magna. Nulla lobortis, nisi ac varius feugiat, ex neque maximus mauris, ut volutpat dolor sem sed est. Nam condimentum iaculis tincidunt. Etiam ac porta lorem. Suspendisse vestibulum placerat ligula ac luctus. Nulla facilisi. Sed dictum quis augue quis cursus.

</div>

<div class="notice--primary" markdown="1">

HTML code for above two images:

```html
<div style="float:left;padding:50px">
<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" width="370"/>
</div>
```

```html
<div style="float:right;padding-left:50px;padding-bottom:50px">
<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202405312012650.jpg" alt="image-202405312012650" width="370"/>
</div>
```

</div>

# References

- [HTML \- Text \- Wrapping Text Around Images](https://www.uvm.edu/~bnelson/computer/html/wrappingtextaroundimages.html).

[^1]: [HTML/CSS实现文字环绕图片布局\_html文字环绕图片 \- CSDN博客](https://blog.csdn.net/yiyelanxin/article/details/75006925).
[^2]: “The `hspace` attribute is not supported by HTML 5 you can use CSS there.” [HTML \| `<img>` hspace Attribute - GeeksforGeeks](https://www.geeksforgeeks.org/html-img-hspace-attribute/).
[^3]: “The HTML vspace Attribute not supported by HTML5.” [HTML `<img>` vspace Attribute - GeeksforGeeks](https://www.geeksforgeeks.org/html-img-vspace-attribute/?ref=lbp).





