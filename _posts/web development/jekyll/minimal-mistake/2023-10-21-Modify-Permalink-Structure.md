---
title: "Modify Permalink Structure of Jekyll Theme Minimal Mistakes"
toc: false
categories:
 - Web Development
tags:
 - Jekyll
 - Jekyll Minimal Mistakes
date: 2023-10-21 19:27:36 +0800
last_modified_at: 2025-01-18 17:59:19 +0800
---

My blog website is based on a Jekyll theme `minimal-mistake`[^1]. Under default settings, the permalink of a blog page is composite of `categories` key and the file name of corresponding `.md` file. For example, if I write a `.md` file named `2023-10-21-This-is-a-Test-File-(md-file-Name).md`, and whose content is:

```markdown
---
layout: single
title: This is a Test File
date: 2023-10-21 16:42:58 +0800
categories:
 - Test Category 1
 - Test Category 2
tag: 
 - Test Tag 1
 - Test Tag 2
toc: false
---

This is content of test file.
```

After I post it, the corresponding website is like:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211735892.png" alt="image-20231021173501798" style="width:67%;" />

As can be seen, the permalink is determined by `categories` key in YAML language area and the text after date in `.md` file name. And the website breadcrumbs are determined by `categories` and `title` key in YAML area. 

However, during the process of managing website contents, I find this permalink structure is kind of fragile, cause sometimes I would modify the categories of the blog and the `.md` file name, which makes the previous permalink is not available any more. So, I want to find a more unique permalink structure. 

Actually, the permalink structure setting could be found in `_config.yml` file:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211632068.png" alt="image-20231021163250999" style="width:67%;" />

We could change it to:

```yaml
permalink: /:year-:month-:day/:hour-:minute-:second:output_ext
```

N.B., References[^2][^3] give detailed information about how to specify this setting.
{: .notice--primary}

making date and time stamp construct permalink:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211840545.png" alt="image-20231021184024468" style="width:67%;" />

However, it shows that the Jekyll will resolve the content between the first and the second slash in permalink as a category, which is out of expectation. 

When I click `2023 10 21` in breadcrumbs, the website will jump to `categories.html`, but we could find that it doesn't create a real category:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211848063.png" alt="image-20231021184842941" style="width:67%;" />

On another hand, if we set permalink structure like:

```yaml
permalink: /:year-:month-:day-:hour-:minute-:second:output_ext
```

that is don't use slash to separate date and time, the permalink and breadcrumbs will show like this:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211853271.png" alt="image-20231021185305180" style="width:67%;" />

At this case, the breadcrumbs look useless.

I tend to use slash to make a separation, so I decide to delete breadcrumbs: open `.\layouts\single.html` and comment the following code:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211904471.png" alt="image-20231021190437416" style="width:67%;" />

**Added on Oct. 27, 2023**: Actually, the breadcrumbs function could be closed by specifying `breadcrumbs` key in `_config.yml` to `false`, instead of commenting above code, the details could be found in[^4].
{: .notice--warning}

The final effect is:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310212107895.png" alt="image-20231021191203945" style="width:67%;" />

not bad anyway ~

<br>

**References**

[^1]: [mmistakes/minimal-mistakes](https://github.com/mmistakes/minimal-mistakes).
[^2]: [https://mademistakes.com/mastering-jekyll/how-to-link/](https://mademistakes.com/mastering-jekyll/how-to-link/).
[^3]: [https://jekyllrb.com/docs/permalinks/](https://jekyllrb.com/docs/permalinks/).
[^4]: [Minimal Mistakes: Breadcrumb navigation (beta)](https://mmistakes.github.io/minimal-mistakes/docs/configuration/#breadcrumb-navigation-beta).

