---
title: HTML `<details>` Tag
categories:
 - Web Development
tags:
 - HTML
 - CSS
date: 2024-06-26 14:28:32 +0800
last_modified_at: 2024-08-25 18:51:33 +0800
---

# Basic syntax

Reference[^1] shows the basic syntax of  HTML `<details>` tag, like:

```html
<details><summary><font size="5">Lorem Ipsum</font></summary><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a turpis at magna consequat posuere ac mattis turpis. Nunc lacinia at eros eget mollis. Integer lobortis, est quis tristique luctus, turpis sapien molestie magna, ut feugiat purus est tincidunt elit. Quisque luctus odio nec mi elementum mollis non eget dui. Fusce vitae nulla eget ligula tristique eleifend. Vivamus ac tincidunt nunc, eu lacinia nisi. Praesent sodales maximus varius. Aenean at tortor ac ligula dapibus efficitur eu ac est.</p></details>
```

The result is:

<details><summary><font size="5">Lorem Ipsum</font></summary><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a turpis at magna consequat posuere ac mattis turpis. Nunc lacinia at eros eget mollis. Integer lobortis, est quis tristique luctus, turpis sapien molestie magna, ut feugiat purus est tincidunt elit. Quisque luctus odio nec mi elementum mollis non eget dui. Fusce vitae nulla eget ligula tristique eleifend. Vivamus ac tincidunt nunc, eu lacinia nisi. Praesent sodales maximus varius. Aenean at tortor ac ligula dapibus efficitur eu ac est.</p></details>

<br>

# Customize `<details>` style

Besides, we can use CSS to define a new `details--exmaple` class for `<details>` tag in `.scss` file: 

```css
.details--exmaple summary {
    color: blue;
    width: 50%;
    padding: 4px;
    margin: auto;
    text-align: center;
    background-color: #eeeeee;
    border: none;
    box-shadow: 1px 1px 5px #bbbbbb;
    border-radius: 5px;
    cursor: pointer;
}

.details--exmaple div {
    display: block;
    color: red;
    width: 90%;
    padding: 17px;
    margin: auto;
    background-color: #eeeeee;
    box-shadow: 1px 1px 5px #bbbbbb;
    border-radius: 5px;
}
```

Then, we can specify the `class` property of `<details>` tag as `"details--exmaple"` to use this new style:

```html
<details class="details--exmaple"><summary><font size="5">Lorem Ipsum</font></summary><div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a turpis at magna consequat posuere ac mattis turpis. Nunc lacinia at eros eget mollis. Integer lobortis, est quis tristique luctus, turpis sapien molestie magna, ut feugiat purus est tincidunt elit. Quisque luctus odio nec mi elementum mollis non eget dui. Fusce vitae nulla eget ligula tristique eleifend. Vivamus ac tincidunt nunc, eu lacinia nisi. Praesent sodales maximus varius. Aenean at tortor ac ligula dapibus efficitur eu ac est.</div></details>
```

as a result we have:

<details class="details--exmaple"><summary><font size="5">Lorem Ipsum</font></summary><div>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a turpis at magna consequat posuere ac mattis turpis. Nunc lacinia at eros eget mollis. Integer lobortis, est quis tristique luctus, turpis sapien molestie magna, ut feugiat purus est tincidunt elit. Quisque luctus odio nec mi elementum mollis non eget dui. Fusce vitae nulla eget ligula tristique eleifend. Vivamus ac tincidunt nunc, eu lacinia nisi. Praesent sodales maximus varius. Aenean at tortor ac ligula dapibus efficitur eu ac est.</div></details>

<br>

**References**

[^1]: [HTML details Tag](https://www.w3schools.com/tags/tag_details.asp).



