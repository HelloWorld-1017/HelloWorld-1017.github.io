---
title: Add A Copy Button for the Code Block in the Jekyll Website
toc: false
categories:
 - Web Development
tags:
 - CSS
 - JavaScript
 - Jekyll
 - SCSS
date: 2025-06-11 15:03:14 +0800
last_modified_at: 2025-06-11 15:03:14 +0800
---

Today, I added a copy button for each code block in my Jekyll website, based on the reference[^1].

At first, add such button styles in the `.\_sass\_buttons.scss` file:

```scss
// Copy-button style for the code block
@mixin button-copycode-style {
  background-color: #575757;
  color: white;
  font-weight: bold;
  padding-left: 0.7em;
  padding-right: 0.7em;
  position: absolute;
  top: -7px;
  right: 10px;
  outline: none;

  @extend %deactive-user-selection;
}

.btn.btn--copycode {
  @include button-copycode-style;
  color: white;
}

.btn.btn--copycode-success {
  @include button-copycode-style;
  color: white;
}
```

Then, add the following JavaScript code in the `.\_includes\footer_scripts.html` file to add a copy button for each code block on the webpage and set the respond to user’s click:

```html
<!-- Add a copy button for the code block -->
<script type="text/javascript">
  function InitCopyPaste() {
      const codeBlocks = document.querySelectorAll("div.highlighter-rouge .rouge-code");

      codeBlocks.forEach((codeblock, index) => {
        const code = codeBlocks[index].innerText;
        const copyCodeButton = document.createElement("button");
        copyCodeButton.innerHTML = "Copy";
        copyCodeButton.classList = "btn btn--copycode";

        // insert a copy button
        copyCodeButton.onclick = function () {
          window.navigator.clipboard.writeText(code.trim());
          copyCodeButton.innerHTML = "Copied!";
          copyCodeButton.classList.add("btn--copycode-success");
          copyCodeButton.classList.remove("btn--copycode");

          setTimeout(() => {
            copyCodeButton.innerHTML = "Copy";
            copyCodeButton.classList.remove("btn--copycode-success");
            copyCodeButton.classList.add("btn--copycode");
          }, 2000);
        };

        // make the button
        codeblock.appendChild(copyCodeButton);
      });
    }
    document.addEventListener("DOMContentLoaded", InitCopyPaste);
</script>
```

Here is a result:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images-1/main/imgs/202506111520523.png" alt="image-20250611152036420" style="width:67%;" />

<br>

**References**

- [How to Add a Copy-to-Clipboard Button to Jekyll](https://www.aleksandrhovhannisyan.com/blog/jekyll-copy-to-clipboard/).
- [`String.prototype.trim()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/trim).

[^1]: [Code Block Highlighter Copy/Paste (Jekyll)](https://www.blandersoft.com/short/code-block-copy-paste/).