---
title: Cross Reference in Markdown Files and Web Pages
categories:
 - Web Development
tags:
 - HTML
 - Jekyll
 - Markdown
date: 2023-10-10 16:37:25 +0800
last_modified_at: 2024-08-25 18:37:34 +0800
---

# HTML `<div>` element

## Fundamental usage

The cross reference in the Jekyll-based website could be realised by adding HTML `<div>` tag and whose `id` property in the `.md` file [[1]](#ref-1).

Firstly, use `<div id="xxx"></div>` to create a "division" in the specified position [[2]](#ref-2), like:

```markdown
**References**
<div id="ref-1"></div>
[1] [Markdown 添加文献引用 - 别再闹了 - 博客园](https://www.cnblogs.com/jiading/articles/12966059.html).
<div id="ref-2"></div>
[2] [HTML div tag - w3schools](https://www.w3schools.com/tags/tag_div.ASP).
```

We could use adding hyperlink for text to refer division with a certain `id`: 

```markdown
This is reference [[1]](#ref-1).

This is reference [[2]](#ref-2).
```

This is reference [[1]](#ref-1).

This is reference [[2]](#ref-2). 

After deploying web page, it will direct to the referred division when we clicking the text content with hyperlink, and the website address of the division is like:

![image-20231010165147365](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231010165147365.png)

however, this function is not available in the original `.md` file. 

## The cases of Multiple definition and missing definition of HTML `<div>` tag

Added on Oct. 31, 2023.
{: .notice--primary}

If we inserted multiple divisions with the same `id` properties, for example, we defined two or more division using `<div id="ref"></div>`, no error will occur. However, when readers click the text like `[<text>](#ref)`, the web page will jump to the **first** position where `<div id="ref"></div>` is placed.

If we forget defining a division with a tag `refff` but we refer it using `[<text>](#refff)`, there also won't be errors when we click, and hyperlink will be changed as like:

![image-20231031122550528](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202310311225627.png)

but the web page won't jump to anywhere.

At this point, the HTML language is more tolerant than LaTeX typesetting system.

<br>

# Markdown footnote identifier

Added on Nov. 4, 2023.
{: .notice--primary}

## Fundamental usage from Markdown Guid [[3](#ref-3)]

Another way of cross reference is using Markdown identifier [[3](#ref-3)], i.e., creating a footnote reference by `[^<footnote>]`, and adding footnote by  `[^<footnote>]:<footnote_content>`. For example: 

<div id="md-1"></div>

```markdown
Here's [^2] a [^1] simple [^1] footnote,[^1] and here's a longer one.[^bignote]

[^1]: This is the first footnote.

[^bignote]: Here's one with multiple paragraphs and code.

[^2]: This is the second foot note.
```

<br>

Here's [^2] a [^1] simple [^1] footnote,[^1] and here's a longer one.[^bignote]

[^1]: This is the first footnote.
[^bignote]: Here's one with multiple paragraphs and code.
[^2]: This is the second foot note.

<br>

[Markdown content](#md-1) will render output in `.md` file like this:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311041406971.png" alt="image-20231104140651912" style="zoom:50%;" />

If we click the blue mark which `[^1]` renders, markdown file will direct to where `[^1]:This is the first footnote.` defines; and similarly, if we click the orange carriage return symbol after `[^1]:This is the first footnote.`, markdown file will return to where `[^1]` puts, and different orange carriage return symbols correspond to different `[^1]` identifiers. It is more efficient than using HTML `<div>` tag, cause the latter doesn't function in `.md` file. 

But the rendered appearance of [markdown content](#md-1) is kind of different from that in `.md` file, reflecting in two aspects. Firstly, the detailed footnote contents will ALWAYS appear at the end of the page, no matter where they are put in `.md` file (It is reasonable, cause it is what "footnote" actually means). And the second one is that, the web page will re-name these footnotes using numbers, and re-organize them according to the occurrence order of  `[^<footnote>]`. In a word, it is very similar to cross reference in LaTeX.

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311041602011.png" alt="image-20231104160220867" style="zoom:50%;" />

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311041603210.png" alt="image-20231104160332159" style="zoom:50%;" />

Besides, the website will automatically generate URL for each "footnote content":

```
http://127.0.0.1:4000/2023-10-10/08-37-25.html#fn:2
http://127.0.0.1:4000/2023-10-10/08-37-25.html#fn:1
http://127.0.0.1:4000/2023-10-10/08-37-25.html#fn:bignote
```

and for each "footnote":

```
http://127.0.0.1:4000/2023-10-10/08-37-25.html#fnref:2
http://127.0.0.1:4000/2023-10-10/08-37-25.html#fnref:1
http://127.0.0.1:4000/2023-10-10/08-37-25.html#fnref:1:1
http://127.0.0.1:4000/2023-10-10/08-37-25.html#fnref:1:2
http://127.0.0.1:4000/2023-10-10/08-37-25.html#fnref:bignote
```

Anyway, I think it is a more convenient and efficient way to create a cross reference in Jekyll-based web page compared with using HTML `<div>` tag because it could produce more flexible redirections both in `.md` file and web page.

## Formatting footnote style

Besides, we could format the footnote style using SCSS language. For the Jekyll theme “minimal-mistakes” [^7] which I use, the footnote style is specified by the following codes in `.\_sass\minimal-mistakes\_utilities.scss` file:

```scss
.footnote {
  color: mix(#fff, $gray, 25%);
  text-decoration: none;
}

.footnotes {
  color: mix(#fff, $gray, 25%);

  ol,
  li,
  p {
    margin-bottom: 0;
    font-size: $type-size-6;
  }
}

a.reversefootnote {
  color: $gray;
  text-decoration: none;

  &:hover {
    text-decoration: underline;
  }
}
```

I changed it to [^4] [^5] [^6]:

```scss
.footnote {
  color: #3366CC;
  text-decoration: none;
}
.footnote:before {
  content: "[";
}
.footnote:after {
  content: "]";
}

.footnotes {
  color: #3366CC;
  ol,
  li,
  p {
    margin-bottom: 0;
    font-size: 100%;
    text-decoration: none;
  }
}

a.reversefootnote {
  color: #FF0000;
  text-decoration: none;
  &:hover {
    text-decoration: underline;
  }
}
```

The new footnote style is like:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311041918567.png" alt="image-20231104191833536" style="zoom:50%;" />

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311041918177.png" alt="image-20231104191802117" style="zoom:50%;" />

<br>

**References**

<div id="ref-1"></div>
[1] [Markdown 添加文献引用 - 别再闹了 - 博客园](https://www.cnblogs.com/jiading/articles/12966059.html).

<div id="ref-2"></div>
[2] [HTML div tag - w3schools](https://www.w3schools.com/tags/tag_div.ASP).

<div id="ref-3"></div>
[3] [Extended Syntax: Footnotes - Markdown Guide](https://www.markdownguide.org/extended-syntax/#footnotes).

[^4]:  [font-size - CSS: Cascading Style Sheets - MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/font-size).
[^5]: [text-decoration - CSS: Cascading Style Sheets - MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/text-decoration).
[^6]: [html - Square brackets with CSS - Stack Overflow](https://stackoverflow.com/questions/13651022/square-brackets-with-css).
[^7]: [mmistakes/minimal-mistakes- Github](https://github.com/mmistakes/minimal-mistakes).
