---
title: "An XeLaTeX Compilation Error: `Undefined control sequence. \\pdfglyphtounicode` "
toc: false
categories:
 - LaTeX
tags:
 - dvips
 - LaTeX Warnings and Errors
 - pdfLaTeX
 - TeXstudio
 - XeLaTeX
 - LuaTeX
date: 2024-07-24 16:47:47 +0800
last_modified_at: 2024-11-12 16:09:07 +0800
---

Today, when I compile a `.tex` file (which I created on another computer before) in TeXstudio, some errors like `Undefined control sequence. \pdfglyphtounicode` are printed in `Log` box:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407241712033.png" alt="image-20240724171201996" style="zoom:67%;" />

But on the other hand, corresponding PDF file can be normally generated, and I can preview it as usual. Besides, these errors don’t exist when I compile other `.tex` files.

Later, I notice messages in `Messages` box:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407241713631.png" alt="image-20240724171327589" style="zoom: 80%;" />

which shows that complier pdflatex works well but xelatex doesn’t. Probably this is why above case appears.

I remember that previously these two “green” lines always appeared after a successful compilation, and I thought they indicate that everything is OK, so I have never read it carefully. Now I realize that I have been using two compilers to compile `.tex` files all along, and `Default Compiler` configuration also shows this point:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407241729521.png" alt="image-20240724172921385" style="zoom: 67%;" />

After I changing `Default Compiler` option from `txs:///pdflatex | txs:///xelatex` to `txs:///pdflatex`, that is cancel xelatex compilation, aforementioned errors disappear. So, I guess these errors are caused by that some characters in this `.tex` file are not supported by xelatex (but I’m not certain, because all characters in the file are English letters).

<br>

As introduced on 31th page of Prof. Liu’s book, *Introduction to LaTeX*[^1], there are different compilation methods, and hence different compilers like pdflatex[^2], xelatex[^3], and dvips[^4], to convert TeX source code to PDF file, and in which xelatex can best support processing Chinese characters:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407241655015.png" alt="image-20240724165541952" style="zoom:80%;" />

So, I think for this reason I added xelatex as a default compiler before. 

<br>

**References**

[^1]: [LaTeX入门](https://yun.weicheng.men/Book/LaTeX%E5%85%A5%E9%97%A8.pdf)，刘海洋编著, pp. 31.
[^2]: [pdfTeX](https://en.wikipedia.org/wiki/PdfTeX)
[^3]: [XeTeX](https://en.wikipedia.org/wiki/XeTeX)
[^4]: [dvips](https://en.wikipedia.org/wiki/Dvips).
