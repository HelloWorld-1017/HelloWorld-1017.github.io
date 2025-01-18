---
title:  Install Jekyll on Windows
toc: false
categories:
 - Web Development
tags: 
 - Jekyll
date: 2023-01-03 09:55:32 +0800
last_modified_at: 2025-01-18 15:19:23 +0800
---

前两天我给现在使用的这台笔记本电脑换了一块固态硬盘，重装了系统，电脑上的Jekyll也没有了，没有办法在本地预览GitHub Pages上的内容，因此需要重装一下Jekyll，本博客就简单记录一下安装的过程。主要的流程参考了博客 [^1]。

**Step 1：安装Ruby环境**

在官网下载RubyInstallers：[https://rubyinstaller.org/downloads/](https://rubyinstaller.org/downloads/)，我下载的是这个含有Devkit的x64版本：

![image-20230103090630806](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230103090630806.png?raw=true)

**Step 2 (seemingly optional)：安装RubyGems**

下载地址：[https://rubygems.org/pages/download](https://rubygems.org/pages/download)

下载`.zip`版本的压缩包，下载完成后解压缩到电脑的任意一个位置中。

注：我是将该文件夹放在了C盘的某一个位置，这导致在后面步骤中，需要以管理员身份在终端中运行命令。
{: .notice--warning}

**Step 3：安装Jekyll**

```bash
gem install jekyll -v '3.7'
```

**Step 4: 安装Bundler**

```bash
gem install bundler
```

bundler程序是一个用于自动安装其他程序的程序。

**Step 5：本地启动服务**

原本我想要直接使用`bundle exec jekyll serve`启动服务，但是出现了以下提示：

```
C:\Users\Tsing\Desktop\QinghuaMa.github.io>bundle exec jekyll serve

https://github.com/jekyll/jekyll-commonmark.git (at refs/pull/44/head@53092e1) is not yet checked out. Run `bundle install` first.
```

根据提示，先使用`bundle install`命令，但是又出现了新的错误：


```
C:\Users\Tsing\Desktop\QinghuaMa.github.io> bundle install

Fetching gem metadata from https://rubygems.org/.........
Fetching https://github.com/jekyll/jekyll-commonmark.git
fatal: unable to access 'https://github.com/jekyll/jekyll-commonmark.git/': Recv failure: Connection was reset

Retrying `git fetch --force --quiet --tags -- https://github.com/jekyll/jekyll-commonmark.git refs/heads/\*:refs/heads/\* refs/pull/44/head:refs/pull/44/head` at C:/Ruby31-x64/lib/ruby/gems/3.1.0/cache/bundler/git/jekyll-commonmark-d63e9807d408d3f16f9f0fbafb9e30457c6da7a7 due to error (2/4): Bundler::Source::Git::GitCommandError Git error: command `git fetch --force --quiet --tags -- https://github.com/jekyll/jekyll-commonmark.git refs/heads/\*:refs/heads/\* refs/pull/44/head:refs/pull/44/head` in directory C:/Ruby31-x64/lib/ruby/gems/3.1.0/cache/bundler/git/jekyll-commonmark-d63e9807d408d3f16f9f0fbafb9e30457c6da7a7 has failed.

If this error persists you could try removing the cache directory 'C:/Ruby31-x64/lib/ruby/gems/3.1.0/cache/bundler/git/jekyll-commonmark-d63e9807d408d3f16f9f0fbafb9e30457c6da7a7'
```

最后一句话提示我们删除一个在ruby下的cache目录，应该是之前的缓存文件导致的冲突。但我并没有删除它所提示的这个文件，而是直接删除了网站根目录下的`.sass-cache`文件夹，删除后再在终端中运行`bundle exec jekyll serve`即可启动后台服务器：

```
C:\Users\Tsing\Desktop\QinghuaMa.github.io>bundle exec jekyll serve

Configuration file: C:/Users/Tsing/Desktop/QinghuaMa.github.io/_config.yml
            Source: C:/Users/Tsing/Desktop/QinghuaMa.github.io
       Destination: C:/Users/Tsing/Desktop/QinghuaMa.github.io/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
       Jekyll Feed: Generating feed for posts
                    done in 28.36 seconds.
 Auto-regeneration: enabled for 'C:/Users/Tsing/Desktop/QinghuaMa.github.io'
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
```

此时，就可以在本地的`http://127.0.0.1:4000/`端口访问网站。

<br>

**Reference**

[^1]: [Windows 系统上安装 Jekyll（简单详细教程）](https://www.cnblogs.com/pergrand/p/12875597.html).
