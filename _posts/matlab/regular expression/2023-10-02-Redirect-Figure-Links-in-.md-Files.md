---
title: Redirect Figure Links in Markdown Files using MATLAB
toc: false
categories:
 - MATLAB
 - Web Development
tags:
 - Jekyll
 - MATLAB Language Fundamentals
 - Regular Expression
 - MATLAB Data Import and Analysis
date: 2023-10-02 18:37:29 +0800
last_modified_at: 2024-10-23 19:24:51 +0800
---

A few days ago, I began to use a GitHub public repository as image hosting for my personal website[^1]. However, previously I had been using Tencent Cloud COS (Cloud Object Storage) service for a long while, therefore the pictures I've ever uploaded are stored there. Today I migrate these pictures to my repository[^1]; definitely, it is easy, but I should redirect those picture links in the all `.md` files, which is kind of slow and painful if I modified them by hand. So I decide to use a MATLAB script to realize it automatically.

There exist three subfolders in my Tencent Cloud COS space, namely `DeLLLaptop`, `img` and `imgpersonal`. I download and directly put them into the subdirectory `migration` of my new GitHub repository[^1]:

![image-20231002162321331](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/image-20231002162321331.png)

So, all I need is to modify the former part of the original picture links, like converting links from:

```
https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/imgpersonal/image-20220707190620188.png
```

to

```
https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220707190620188.png?raw=true
```

N.B.: The `?raw=true` after picture file extension `.png` is seemingly necessary, otherwise the picture will not display normally. And note that the `r` of `raw` must be lowercase.
{: .notice--primary}

The `.md` source files of my website are all in the `_post` folder under the root directory (this is convention while using Jekyll to deploy website), so I make a copy of it and rename as `_posts_backup`. After that, I write the following code to batch processing links. Basically, the code firstly read the content of original `.md` file, and then matches specific link started with `https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/` and ended with `.png` (and `.jpg`, `.svg`, `.gif`); afterwards, the former part of links is replaced with `https://github.com/HelloWorld-1017/blog-images/blob/main/migration/` and tag `?raw=true` is added at the end of the link. At last, the code writes the new content into the new `.md` file.

```matlab
clc,clear,close all

mdFiles = dir("_posts_backup/*.md");

for i = 1:numel(mdFiles)
    fileName = mdFiles(i).name;
    content = fileread(fullfile(pwd,"_posts_backup",fileName));
    content = string(content);
    newContent = helperReplaceContent(content,".jpg");
    newContent = helperReplaceContent(newContent,".png");
    newContent = helperReplaceContent(newContent,".svg");
    newContent = helperReplaceContent(newContent,".gif");

    fileID = fopen(fullfile(pwd,"_posts",fileName),'w');
    fwrite(fileID,newContent);
    fclose(fileID);
    clear newContent
    disp(i)
end

function newContent = helperReplaceContent(content,fmt)
    text_withBoundaries = extractBetween(content,"https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/",fmt,"Boundaries","inclusive");
    text_withoutBoundaries = extractBetween(content,"https://blogimages-1309804558.cos.ap-nanjing.myqcloud.com/",fmt,"Boundaries","exclusive");
    newText = repmat("https://github.com/HelloWorld-1017/blog-images/blob/main/migration/",numel(text),1)+text_withoutBoundaries+repmat(fmt+"?raw=true",numel(text),1);
    newContent = replace(content,text_withBoundaries,newText);
end
```

This script seems easy, and actually it is, but I still spent hours on it as I have little experience about dealing with text by regular expression. On the other hand, there exist so many MATLAB built-in function to handle text which are all unfamiliar to me, such as `regexp`[^2], `pattern`[^3], `regexprep`[^4], `strfind`[^5], `strrep`[^6], `extract`[^7], and the functions which I finally adopt `extractBetween`[^8] and `replace`[^9], which means that there may be various approaches to achieve my goal. All these functions are from MATLAB Language Fundamentals part (rather than Text Analytics Toolbox by the way), and are for operating characters and strings. They are fundamental tools for analyzing text in the fields of like Natural Language Processing and Web crawler. 

Anyway, the effect of this MATLAB script is basically in expectation, although it is kind of ugly (I think so, as I believe there exist a better and more concise way to realize it; it’s just I don’t know). 

<br>

# References

[^1]: [HelloWorld-1017/blog-images](https://github.com/HelloWorld-1017/blog-images).
[^2]: [MATLAB Language Fundamentals: `regexp` - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/regexp.html).
[^3]: [MATLAB Language Fundamentals: `pattern` - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/pattern.html).
[^4]: [MATLAB Language Fundamentals: `regexprep` - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/regexprep.html).
[^5]: [MATLAB Language Fundamentals: `strfind` - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/strfind.html).
[^6]: [MATLAB Language Fundamentals: `strrep` - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/strrep.html).
[^7]: [MATLAB Language Fundamentals: `extract` - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/extract.html).
[^8]: [MATLAB Language Fundamentals: `extractBetween` - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/extractbetween.html).
[^9]: [MATLAB Language Fundamentals: `replace` - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/replace.html).

- [浅析正则表达式用法：匹配字符，数量，边界 - 古兰精 - 博客园](https://www.cnblogs.com/goloving/p/14001538.html).
- [MATLAB Data Import and Analysis: `fileread` - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/fileread.html).
- [MATLAB Programming: `dir` - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/dir.html).