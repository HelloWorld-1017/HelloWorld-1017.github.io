---
title: "Test Working with Collections of Jekyll Theme Minimal Mistakes"
toc: false
classes: wide
categories: 
 - Web Development
tags:
 - Jekyll
 - Jekyll Minimal Mistakes
date: 2022-08-21 13:25:23 +0800
last_modified_at: 2024-08-25 18:36:21 +0800
---

（1）在 `_config.yml`文件 中配置名为portfolio的collection

```yaml
collections:
  portfolio:
    output: true
    permalink: /:collection/:path/
```

并设置  pages 和 posts 默认的 Front Matter：

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
permalink: /portfolio/
layout: collection
collection: portfolio
entries_layout: grid
classes: wide
sort_by: date
sort_order: reverse
---
```

该文件设置了portfolio的显示页面格式。

其中，页面的布局为`collection`，是由`/_layouts/collection.html`定义的。

（3）在 `/_data/navigation.yml` 文件中添加如下代码

```yaml
main:
  # ......
  - title: "Portfolio"
    url: /portfolio/
```

上述代码的功能是使 Portfolio 出现在导航栏中。

（4）在网站的根目录下创建 `_portfolio` 文件夹

![image-20220821124622493](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220821124622493.png?raw=true)

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

最后，在本地 `bundle exec jekyll serve` ，查看效果：

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220821125002104.png?raw=true" alt="image-20220821125002104"  />

![image-20220821132729171](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/img/image-20220821132729171.png?raw=true)

<br>

**References**

[1] [Working with Collections - Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/docs/collections/).

[2] [Portfolio - Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/portfolio/).

[3] [mmistakes/jekyll-sample-content: Sample Jekyll content (posts, pages, collections, and images) to test your theme against](https://github.com/mmistakes/jekyll-sample-content).