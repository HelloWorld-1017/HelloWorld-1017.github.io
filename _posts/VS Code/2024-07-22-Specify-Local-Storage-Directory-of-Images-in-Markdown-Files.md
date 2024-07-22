---
title: "Specify Local Storage Directory of Images in Markdown Files when Markdown Editing with VS Code"
toc: false
categories:
 - VS Code
tags:
- Markdown
date: 2024-07-22 16:08:34 +0800
last_modified_at: 2024-07-22 16:08:34 +0800
---

To edit Markdown files in VS Code, extension Markdown All in One[^1] is commonly used. By using this extension, if users take a screenshot (or copy any image) and then paste it in Markdown file, a PNG image will be automatically stored in the same folder as the Markdown file being edited.

For example, I new a folder named `folder` and in which create a Markdown file `markdown.md`. Then, if I take a screenshot and paste it (`[Ctrl]` + `[V]`) in `markdown.md`, a piece of markdown code is generated:

```markdown
![alt text](image.png)
```

and at the same time, a PNG file named `image.png` appears in `folder`:

```powershell
tree /f
```

```
卷 新加卷 的文件夹 PATH 列表
卷序列号为 1CB5-B6F7
H:.
    image.png
    markdown.md

没有子文件夹
```

I think it’s not an orderly way to organize files if there are several Markdown files and image files (and maybe other types of files) in the same folder. Therefore, I want to find a way which can automatically store images in a uniform subfolder. Luckily, another extension Markdown Image[^2] can help to realize this point.

Markdown Image supports saving images locally or uploading them to image hosting service, like GitHub, Imgur, SM.MS, Qiniu, Upyun, etc.[^2]. For ‘local’ method, users have two ways to specify the directory where images to be stored: one is specifying an absolute path, and all images saved by the extension are put there, which is a default method; another one is by specifying a relative path, for example, a subfolder under the same folder as the Markdown file being edited.

To realize the second method, I change following settings:


<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407212007299.png" alt="image-20240721200713179" style="zoom: 33%;" />

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407212007744.png" alt="image-20240721200737703" style="zoom: 33%;" />

Specifically:

- `Base: File Name Format`: `./images/${YY}-${MM}/${YY}${MM}${DD}${HH}${mm}${ss}`.
- `Local: Path`: blank.
- `Local: Reference path`: `./images/${YY}-${MM}/`.

At this time, if I take a screenshot and paste it in Markdown file again (note that, to use the this extension, users should copy by keys `[Alt]` + `[Shift]` + `[V]`, or right-click menu `Paste Image`, rather than normal `[Ctrl]` + `[V]`), image path in Markdown file looks like:

```
![picture 0](./images/2024-07/20240721201149.png)
```

and a PNG file `20240721201149.png` is saved in the newly created subfolder `./images/2024-07/`:

```powershell
tree /f
```

```
卷 新加卷 的文件夹 PATH 列表
卷序列号为 1CB5-B6F7
H:.
│  image.png
│  markdown.md
│
└─images
    └─2024-07
            20240721201149.png
```

More organized, isn’t it?

<div class="notice--warning" markdown="1">
By the way, in the above example, to make Markdown Image available in current Markdown file `markdown.md`, I opened `folder` by `Open Folder ...` option in *Welcome* page, that is make `markdown.md` become part of a certain project:

![image-20240721201101324](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202407212011476.png)

Otherwise the extension is not functional, with a pop-up prompt showing that:

```
Please Open the project of the file with folder.

Source: Markdown Image
```

</div>

<br>

**References**

[^1]: [Markdown All in One - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one).
[^2]: [imlinhanchao/vsc-markdown-image at a2d74df7a53b213eb922cd38fd2b68e0287166b9](https://github.com/imlinhanchao/vsc-markdown-image/tree/a2d74df7a53b213eb922cd38fd2b68e0287166b9).

