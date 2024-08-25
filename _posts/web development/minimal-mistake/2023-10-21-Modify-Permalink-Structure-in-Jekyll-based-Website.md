---
title: "Modify Permalink Structure of Jekyll Theme \"minimal-mistakes\""
toc: false
categories:
 - Web Development
tags:
 - Jekyll
date: 2023-10-21 19:27:36 +0800
last_modified_at: 2024-08-25 18:38:06 +0800
---

My blog website is based on a Jekyll theme `minimal-mistake` [[1]](#ref). Under default settings, the permalink of a blog page is composite of `categories` key and the file name of corresponding `.md` file. For example, if I write a `.md` file named `2023-10-21-This-is-a-Test-File-(md-file-Name).md`, and whose content is:

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

![image-20231021173501798](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211735892.png)

As can be seen, the permalink is determined by `categories` key in YAML language area and the text after date in `.md` file name. And the website breadcrumbs are determined by `categories` and `title` key in YAML area. 

However, during the process of managing website contents, I find this permalink structure is kind of fragile, cause sometimes I would modify the categories of the blog and the `.md` file name, which makes the previous permalink is not available any more. So, I want to find a more unique permalink structure. 

Actually, the permalink structure setting could be found in `_config.yml` file:

![image-20231021163250999](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211632068.png)

We could change it to:

```yaml
permalink: /:year-:month-:day/:hour-:minute-:second:output_ext
```

N.B., Reference [[2]](#ref) and [[3]](#ref) give detailed information about how to specify this setting.
{: .notice--primary}

making date and time stamp construct permalink:

![image-20231021184024468](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211840545.png)

However, it shows that the Jekyll will resolve the content between the first and the second slash in permalink as a category, which is out of expectation. 

When I click `2023 10 21` in breadcrumbs, the website will jump to `categories.html`, but we could find that it doesn't create a real category:

![image-20231021184842941](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211848063.png)

On another hand, if we set permalink structure like:

```yaml
permalink: /:year-:month-:day-:hour-:minute-:second:output_ext
```

that is don't use slash to separate date and time, the permalink and breadcrumbs will show like this:

![image-20231021185305180](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211853271.png)

At this case, the breadcrumbs look useless.

I tend to use slash to make a separation, so I decide to delete breadcrumbs: open `.\layouts\single.html` and comment the following code:

![image-20231021190437416](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310211904471.png)

**Added on Oct. 27, 2023**: Actually, the breadcrumbs function could be closed by specifying `breadcrumbs` key in `_config.yml` to `false`, instead of commenting above code, the details could be found in [[4]](#ref).
{: .notice--warning}

The final effect is:

![image-20231021191203945](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310212107895.png)

not bad anyway ~

<br>

<div id="ref"></div>

**References**

[1] [mmistakes/minimal-mistakes - GitHub](https://github.com/mmistakes/minimal-mistakes).

[2] [https://mademistakes.com/mastering-jekyll/how-to-link/](https://mademistakes.com/mastering-jekyll/how-to-link/).

[3] [https://jekyllrb.com/docs/permalinks/](https://jekyllrb.com/docs/permalinks/).

[4] [Minimal Mistakes: Breadcrumb navigation (beta)](https://mmistakes.github.io/minimal-mistakes/docs/configuration/#breadcrumb-navigation-beta).

