---
layout: single
title: Test Working with Collections
date: 2022-08-21 13:25:23 +0800
categories: 
 - Github Pages
tags: 
 - Jekyll
toc: false
classes: wide
---

（1）在 `_config.yml` 中配置 portfolio collection

```yaml
collections:
  portfolio:
    output: true
    permalink: /:collection/:path/
```

并设置 posts 和 pages 的默认 Front Matter

```yaml
defaults:
  # _portfolio
  - scope:
      path: ""
      type: portfolio
    values:
      layout: single
      author_profile: true
```

（2）在 `_pages` 文件夹中写入 `portfolio.md` 文件

```markdown
---
title: Portfolio
layout: collection
permalink: /portfolio/
collection: portfolio
entries_layout: grid
classes: wide
---
```

这个文件设置了呈现所有 portfolio 中所有文件的页面。

（3）在 `/_data/navigation.yml` 文件中添加如下代码

```yaml
main:
  # ......
  - title: "Portfolio"
    url: /portfolio/
```

上述代码的功能是使 Portfolio 出现在导航栏中。

（4）在网站的根目录下创建 `_portfolio` 文件夹

![image-20220821124622493](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220821124622493.png)

之后，在该文件夹中创建几个测试文件：`portfolio1.md`，`portfolio2.md`，`portfolio3.md`。

```markdown
---
title: Portfolio1
---
```

```markdown
---
title: Portfolio2
---
```

```markdown
---
title: Portfolio3
---
```

<br>

最后，在本地 `bundle exec jekyll serve` ，查看效果：

<img src="https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220821125002104.png" alt="image-20220821125002104"  />

![image-20220821132729171](https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/img/image-20220821132729171.png)

<br>

**参考**

[1] [Working with Collections - Minimal Mistakes (mmistakes.github.io)](https://mmistakes.github.io/minimal-mistakes/docs/collections/)

[2] [Portfolio - Minimal Mistakes (mmistakes.github.io)](https://mmistakes.github.io/minimal-mistakes/portfolio/)

[3] [mmistakes/jekyll-sample-content: Sample Jekyll content (posts, pages, collections, and images) to test your theme against. (github.com)](https://github.com/mmistakes/jekyll-sample-content)