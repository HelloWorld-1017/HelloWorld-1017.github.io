---
title: "Install the Jekyll Theme \"minimal-mistakes\" in GitHub Pages"
categories: 
 - GitHub
 - Web Development
tags:
 - Jekyll
date: 2022-07-17 12:25:11 +0800
last_modified_at: 2024-08-25 18:42:49 +0800
---

# Minimal-mistakes-jekyll theme installation

一开始，使用 github pages + Jekyll 建立个人网站的时候，使用的是一个比较简单的主题，总体结构也很清晰，但是后面想给网站添加一些功能就比较麻烦，比如添加评论功能、添加站内搜索功能、SEO优化等等。麻烦就麻烦在一些插件的功能同样比较少，并且只有少数几个插件在 Github 白名单中。

后来就在 Github 找到了一些使用的人比较多的 [jekyll-theme](https://github.com/topics/jekyll-theme)，选择了 [minimal-mistakes](https://github.com/mmistakes/minimal-mistakes)。

[Miminal Mistaks官方文档](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/)中介绍的安装 Minimal mistakes Jekyll theme的方式主要有三种

1. [Gem-based method](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/#gem-based-method)
2. [Remote theme method](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/#remote-theme-method)
3. Fork the [Minimal Mistakes theme](https://github.com/mmistakes/minimal-mistakes/fork)

最先我使用的方式是第3种，直接 fork 仓库，之后按照[官方文档中的步骤](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/#remove-the-unnecessary)，移除不必要的文件夹和文档。之后网站成功构建成功，但是由于我对 [Jekyll](https://jekyllrb.com/) 的组织架构还不是很了解，因而觉得 fork 仓库得到的文件夹不够“干净”，想要修改却无从下手。

后来就采用了第1种方式：[Gem-based method](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/#gem-based-method)。

>**Gem-based method**
>With Gem-based themes, directories such as the assets, _layouts, _includes, and _sass are stored in the theme’s gem, hidden from your immediate view. **This allows for easier installation and updating as you don’t have to manage any of the theme files.**

这种方式类似于将网站的格式和内容分离开，用户只需要关注内容即可，jekyll 官网对gem-based的主题方式也有介绍：[Understanding gem-based themes](https://jekyllrb.com/docs/themes/#understanding-gem-based-themes)；并且支持配置默认样式，只用在网站文件夹中的创建同名文件夹和文件就可以覆盖。

gem-based 的方式很简洁，比较适合小白，但我在使用的过程中遇到了很多坑。最头疼的问题是：网站在本地启动时完全没有问题，但是 [Github 构建网站](https://jekyllrb.com/docs/continuous-integration/github-actions/#build-and-deploy) 时报错——Error: The minimal-mistakes-jekyll theme could not be found.

![image-20220717105859284](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717105859284.png?raw=true)

![image-20220717110023303](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717110023303.png?raw=true)

```
/usr/bin/docker run --name ghcrioactionsjekyllbuildpagesv104_e20132 --label 4cd98f --workdir /github/workspace --rm -e INPUT_SOURCE -e INPUT_DESTINATION -e INPUT_FUTURE -e INPUT_BUILD_REVISION -e INPUT_VERBOSE -e INPUT_TOKEN -e HOME -e GITHUB_JOB -e GITHUB_REF -e GITHUB_SHA -e GITHUB_REPOSITORY -e GITHUB_REPOSITORY_OWNER -e GITHUB_RUN_ID -e GITHUB_RUN_NUMBER -e GITHUB_RETENTION_DAYS -e GITHUB_RUN_ATTEMPT -e GITHUB_ACTOR -e GITHUB_WORKFLOW -e GITHUB_HEAD_REF -e GITHUB_BASE_REF -e GITHUB_EVENT_NAME -e GITHUB_SERVER_URL -e GITHUB_API_URL -e GITHUB_GRAPHQL_URL -e GITHUB_REF_NAME -e GITHUB_REF_PROTECTED -e GITHUB_REF_TYPE -e GITHUB_WORKSPACE -e GITHUB_ACTION -e GITHUB_EVENT_PATH -e GITHUB_ACTION_REPOSITORY -e GITHUB_ACTION_REF -e GITHUB_PATH -e GITHUB_ENV -e GITHUB_STEP_SUMMARY -e RUNNER_OS -e RUNNER_ARCH -e RUNNER_NAME -e RUNNER_TOOL_CACHE -e RUNNER_TEMP -e RUNNER_WORKSPACE -e ACTIONS_RUNTIME_URL -e ACTIONS_RUNTIME_TOKEN -e ACTIONS_CACHE_URL -e ACTIONS_ID_TOKEN_REQUEST_URL -e ACTIONS_ID_TOKEN_REQUEST_TOKEN -e GITHUB_ACTIONS=true -e CI=true -v "/var/run/docker.sock":"/var/run/docker.sock" -v "/home/runner/work/_temp/_github_home":"/github/home" -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" -v "/home/runner/work/_temp/_runner_file_commands":"/github/file_commands" -v "/home/runner/work/QinghuaMa.github.io/QinghuaMa.github.io":"/github/workspace" ghcr.io/actions/jekyll-build-pages:v1.0.4
/usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/theme.rb:84:in `rescue in gemspec': The minimal-mistakes-jekyll theme could not be found. (Jekyll::Errors::MissingDependencyException)
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/theme.rb:81:in `gemspec'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/theme.rb:19:in `root'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/theme.rb:12:in `initialize'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/site.rb:439:in `new'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/site.rb:439:in `configure_theme'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/site.rb:55:in `config='
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/site.rb:23:in `initialize'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/commands/build.rb:30:in `new'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/commands/build.rb:30:in `process'
	from /usr/local/bundle/gems/github-pages-227/bin/github-pages:70:in `block (3 levels) in <top (required)>'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `block in execute'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `each'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `execute'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/program.rb:42:in `go'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary.rb:19:in `program'
	from /usr/local/bundle/gems/github-pages-227/bin/github-pages:6:in `<top (required)>'
	from /usr/local/bundle/bin/github-pages:23:in `load'
	from /usr/local/bundle/bin/github-pages:23:in `<main>'
/usr/local/lib/ruby/2.7.0/rubygems/dependency.rb:311:in `to_specs': Could not find 'minimal-mistakes-jekyll' (>= 0) among 148 total gem(s) (Gem::MissingSpecError)
Checked in 'GEM_PATH=/github/home/.gem/ruby/2.7.0:/usr/local/lib/ruby/gems/2.7.0:/usr/local/bundle', execute `gem env` for more information
	from /usr/local/lib/ruby/2.7.0/rubygems/dependency.rb:323:in `to_spec'
	from /usr/local/lib/ruby/2.7.0/rubygems/specification.rb:986:in `find_by_name'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/theme.rb:82:in `gemspec'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/theme.rb:19:in `root'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/theme.rb:12:in `initialize'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/site.rb:439:in `new'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/site.rb:439:in `configure_theme'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/site.rb:55:in `config='
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/site.rb:23:in `initialize'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/commands/build.rb:30:in `new'
	from /usr/local/bundle/gems/jekyll-3.9.2/lib/jekyll/commands/build.rb:30:in `process'
	from /usr/local/bundle/gems/github-pages-227/bin/github-pages:70:in `block (3 levels) in <top (required)>'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `block in execute'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `each'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `execute'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/program.rb:42:in `go'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary.rb:19:in `program'
	from /usr/local/bundle/gems/github-pages-227/bin/github-pages:6:in `<top (required)>'
	from /usr/local/bundle/bin/github-pages:23:in `load'
	from /usr/local/bundle/bin/github-pages:23:in `<main>'
  Logging at level: debug
Configuration file: /github/workspace/./_config.yml
             Theme: minimal-mistakes-jekyll
github-pages 227 | Error:  The minimal-mistakes-jekyll theme could not be found.
```

即网站配置文件 _config.yml 中的 theme 设置错误

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717110600083.png?raw=true" alt="image-20220717110600083" style="zoom:50%;" />

但是这个属性完全是按照 minimal mistakes 官方文档中的要求设定的：[Gem-based method](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/#gem-based-method)。针对这个问题，我 google 了很久，也尝试了很多方法，例如：[Jekell theme could not be found](https://stackoverflow.com/questions/46380722/jekyll-theme-could-not-be-found)，但是都无法解决，每次都卡在这里。

之后想要采用第2种方式：[Remote theme method](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/#remote-theme-method)，这种方式类似于 Gem-based method，并且更便捷：

> Remote themes are similar to Gem-based themes, but do not require Gemfile changes or whitelisting making them ideal for sites hosted with GitHub Pages.

并且官方直接提供了 [Minimal mistakes remote theme starter](https://github.com/mmistakes/mm-github-pages-starter/generate) ，可以快速建立一个网站仓库。但是这种方式在本地构建的时候，一直会卡在 Remote Theme: Using the mmistakes/minmal-mistakes。

![image-20220717112153195](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717112153195.png?raw=true)

在 google 上找了一些解决该问题的方法：[Jekyll Remote Theme Doesnt Work Locally](https://www.faqcode4u.com/faq/181519/jekyll-remote-theme-doesnt-work-locally)，但是同样无法解决。后来看到了另一篇博客详细分析了这个问题：[Setting up jekyll with minimal-mistakes theme - Works for me](https://brasier.me/jekyll/theme/2019/01/19/installing-minimal-mistakes-jekyll/#)，其中提到：

> ......
>
> It takes exactly… a long time for it to pull down the remote theme on my local computer, but whatevs, it still builds. 
>
> ```
> done in 303.062 seconds.
> ```
>
> Looking at the Quick-start guide it says “Remote themes are similar to Gem-based themes, but do not require Gemfile changes or whitelisting making them ideal for sites hosted with GitHub Pages.”
>
> … and it doesn’t say…
>
> “**in order to host on GitHub Pages you must use a remote_theme or fork the repo.**” Although to be fair it’s not up to the theme to tell everyone how GitHub works. Just for a n00b like me, it would have been helpful. That’s all.
>
> ......

也就是说：（1）将 remote theme 部署在本地电脑上的确需要耗费很长的时间；（2）在GitHub Pages上使用 minimal-mistakes-jekyll 主题只能采用 [Remote theme method](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/#remote-theme-method) 或者Fork the [Minimal Mistakes theme](https://github.com/mmistakes/minimal-mistakes/fork) 的方式。

所以，现在又回到了fork仓库的方式。。。

但是，这次我并没有直接采用fork仓库的方式，而是找到找到之前使用 gem-based 时安装在本地的文件夹

>在 Windows 电脑上，使用 bundle info --path 命令寻找 gem-based method 安装的 minimal-mistakes-jekyll theme 的位置：
> ```bash
> $ bundle info --path minimal-mistakes-jekyll
> C:/Ruby31-x64/lib/ruby/gems/3.1.0/gems/minimal-mistakes-jekyll-4.24.0
> ```

这个文件夹比直接fork仓库得到的文件夹更加简洁

![image-20220717115246068](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717115246068.png?raw=true)

将上图中的文件夹都复制到网站项目仓库中。

然后，将 [Minimal mistakes remote theme starter](https://github.com/mmistakes/mm-github-pages-starter/generate) 中的 _page文件夹复制到网站项目文件夹中，并将其中的 _data 文件夹中的 navigation.yml 文件替换掉网站项目文件中的相应文件。

![image-20220717123632223](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717123632223.png?raw=true)

最后，按照官方文档中的 [Configuration](https://mmistakes.github.io/minimal-mistakes/docs/configuration/) 配置 _config.yml 文件，并且配置好 Gemfile 文件，上传到GitHub上。

但是在构建网站时又遇见了新的报错信息：

![image-20220717112918703](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717112918703.png?raw=true)

![image-20220717012644098](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717012644098.png?raw=true)

```
......

Conversion error: Jekyll::Converters::Scss encountered an error while converting 'assets/css/main.scss':
                    File to import not found or unreadable: minimal-mistakes/vendor/breakpoint/breakpoint. Load paths: /github/workspace/_sass /usr/local/bundle/gems/jekyll-theme-primer-0.6.0/_sass /usr/local/bundle/gems/jekyll-theme-primer-0.6.0/_sass on line 11

......
```

最后在 Github 上找到了解决方式：

[File to import not found or unreadable: vendor/breakpoint/breakpoint · Issue #1606 · mmistakes/minimal-mistakes](https://github.com/mmistakes/minimal-mistakes/issues/1606)

![image-20220717120046431](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717120046431.png?raw=true)

只需要将 .gitignore 文件中的 vendor 文件夹注释掉即可

<img src="https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717120217863.png?raw=true" alt="image-20220717120217863" style="zoom:50%;" />

至此，pull 一下

![image-20220717120500826](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/imgpersonal/image-20220717120500826.png?raw=true)

bingo~

<br>

# Other Tools

## Supporting MathJax

为了使得网站全站都支持MathJax公式输入，需要在`./_layouts/default.html`添加以下的代码：

```html
<head>
  <!-- Support MathJax and automatic equation numbering -->
  <!-- MathJax demos: https://github.com/mathjax/MathJax-demos-web#customization-->
  <!-- https://github.com/mathjax/MathJax-demos-web/blob/master/equation-refs.html.md -->
  <script>
    MathJax = {
      tex: {
        tags: 'all',  // should be 'ams', 'none', or 'all'
        inlineMath: [['$','$'], ['\\(', '\\)']],
        displayMath: [['$$', '$$'], ['\\[', '\\]']],
      //   Macros: {
      //     boldsymbol: ["\\boldsymbol{#1}",1],
      // }
      }
    };
  </script>
    <!-- Important for auto equation numbering-->
    <script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js"></script>

    
    <!-- Support mermaid -->
    <!-- https://mermaid-js.github.io/mermaid/#/n00b-gettingStarted?id=_3-calling-the-javascript-api -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script> mermaid.initialize({ startOnLoad: true }); </script> -->
    <!-- <div class="mermaid">mermaid code</div> -->
</head>
```

## Code block settings 

（2023年04月17日）

如果想要使得博客中的代码块显示行号，以及更多的显示主题格式或者功能，可以参考博客 [1] 使用`prism.js`的插件，可以直接在官网：[Download ▲ Prism ](https://prismjs.com/download.html#themes=prism-okaidia&languages=markup+css+clike+javascript+c+csharp+cpp+cilkc+cilkcpp+cmake+css-extras+csv+diff+git+linker-script+http+hpkp+hsts+ignore+java+javadoc+javadoclike+json+json5+jsonp+latex+markup-templating+matlab+nginx+nix+perl+php+php-extras+plsql+powershell+python+r+ruby+rust+sql+uri+vim+visual-basic+yaml&plugins=line-highlight+autolinker+custom-class+file-highlight+show-language+jsonp-highlight+highlight-keywords+inline-color+previewers+autoloader+keep-markup+command-line+unescaped-markup+normalize-whitespace+data-uri-highlight+toolbar+copy-to-clipboard+download-button+match-braces)下载，并按照博客 [1] 所提供的方式进行配置。但是在配置之后，网站中有的代码块会出现行号显示不全的情况：

![image-20230417093737199](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230417093737199.png?raw=true)

不太清楚这是什么原因导致的。

## Center the figures

（2023年04月17日）

虽然我们在`.md`文件中插入的图片都是居中显示的，但是在基于minimal-mistakes-jekyll构建的网站中图片都是左对齐的。个人觉得，图片还是居中显示比较美观，但是网上的很多解决方法都是针对单张图像的。使用这种方法来居中图片，显然太繁琐了。Stackoverflow中有一个相关问题 [2]，Lazy Ren做出了详细的回答，我采用了其中将所有图片都居中的一种方式：在`./assets/css/main.scss`文件中添加代码：

```css
img {
  display: block;
  margin-left: auto;
  margin-right: auto;
}
```

Lazy Ren也指出这种方式可能存在风险：

> But note that I have not tested deeply enough to find out any unwanted side effects. So use it at your own risk.

因为这段代码可能是将网站中的**所有**图像都居中。因此，一个“意料之外”的改变是主页中以及博客中的avatar就也被居中了：

![image-20230417095125144](https://github.com/HelloWorld-1017/blog-images/blob/main/migration/DeLLLaptop/image-20230417095125144.png?raw=true)

原本avatar是和文字是左端对齐的。

<br>

**References**

[1] [为 jekyll 中的代码块添加行号 - LIUMH的博客](https://hugueliu.github.io/2019/12/28/add_line_number_for_code_block_in_jekyll/).

[2] [css - Jekyll Blog Post: Centering Images - Stack Overflow](https://stackoverflow.com/questions/23819197/jekyll-blog-post-centering-images).
