---
title: Accelerate Deployment of Jekyll Website
categories:
 - Web Development
tags:
 - Jekyll
date: 2025-01-17 19:14:21 +0800
last_modified_at: 2025-01-18 22:14:51 +0800
---

# Introduction

Along with the number of posts increasing continuously, deploying Jekyll website (locally) consumes more time. Though less than 40 seconds per time (30\~40 seconds for most cases), this problem disturbs me, because I always check out the post content after adding a new post or making some modifications, and during this process Jekyll will re-deploy as long as the website files have changed and saved, which usually means wasting tens of seconds time and time again. Today, I want to solve this problem. I find a blog[^1] on-line, which provides several ways to accelerate deployment. I’ll try some of them, and make a record in this post.

<br>

# Method 1: Upgrade Jekyll version

For my case, change the line `gem "jekyll", "~> 3.7"` into `gem 'jekyll', '~> 4.0'` in the `Gemfile` file of website root directory, then delete `_site` file to avoid errors, and finally run the command `bundle exec jekyll serve`.

```
Configuration file: C:/Users/whatastarrynight/Desktop/website/website/_config.yml
            Source: C:/Users/whatastarrynight/Desktop/website/website
       Destination: C:/Users/whatastarrynight/Desktop/website/website/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
       Jekyll Feed: Generating feed for posts
          Conflict: The following destination is shared by multiple files.
                    The written file may end up with unexpected contents.
                    C:/Users/whatastarrynight/Desktop/website/website/_site/404.html
                     - 404.html
                     - _pages/404.md

          Conflict: The following destination is shared by multiple files.
                    The written file may end up with unexpected contents.
                    C:/Users/whatastarrynight/Desktop/website/website/_site/2022-08-12/10-14-13.html
                     - C:/Users/whatastarrynight/Desktop/website/website/_posts/web development/jekyll/minimal-mistake/2022-08-12-Test-Header-Image-(External-Links).md
                     - C:/Users/whatastarrynight/Desktop/website/website/_posts/web development/jekyll/minimal-mistake/2022-08-12-Test-Header-Image-(Locally).md

                    done in 9.403 seconds.
 Auto-regeneration: enabled for 'C:/Users/whatastarrynight/Desktop/website/website'
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
```

As can be seen, the deployment speed increases (I tried more times, approximately 10\~20 seconds for each), and meanwhile there are two conflicts reported, the reason for which is both two files, for each pair, use the same URL address because they have an identical `date` value in the front matter block (see my previous blog[^11]). This kind of checking is an added feature of the new Jekyll version.

However, upgrading Jekyll is not that recommended and should be used with caution, because it would lead to version conflict. Here is my own experience.

GitHub Pages “Dependency versions” webpage[^3] shows that the supported Jekyll version is `3.10.0`, and when I clicked the corresponding “jekyll” hyperlink in the webpage, the website jumped to “Jekyll” page of RubyGems.org[^4], and it shows that the newest Jekyll version is `4.3.4`, and users can get it using code `gem 'jekyll', '~> 4.3', '>= 4.3.4'` in the `Gemfile` file. Without thinking too much, I mistakenly believed that this version is also supported by GitHub Pages (it’s clearly not because the supported one is `3.10.0` as mentioned above), so I took a step further, replacing `gem 'jekyll', '~> 4.0'` with `gem 'jekyll', '~> 4.3', '>= 4.3.4'`. Deployed again, and I got some errors so:

```
Deprecation Warning [import]: Sass @import rules are deprecated and will be removed in Dart Sass 3.0.0.

More info and automated migrator: https://sass-lang.com/d/import

  ╷
2 │ @import "main";
  │         ^^^^^^
  ╵
    C:\Users\whatastarrynight\Desktop\website\website\assets\css\main.scss 2:9  root stylesheet
Error: expected "{".
  ╷
5 │ @charset "utf-8";
  │                 ^
  ╵
  C:\Users\whatastarrynight\Desktop\website\website\assets\css\main.scss 5:17  @import
  C:\Users\whatastarrynight\Desktop\website\website\assets\css\main.scss 2:9   root stylesheet
  Conversion error: Jekyll::Converters::Scss encountered an error while converting 'assets/css/main.scss':
                    expected "{".
                    ------------------------------------------------
      Jekyll 4.3.4   Please append `--trace` to the `serve` command
                     for any additional information or backtrace.
                    ------------------------------------------------
C:/Ruby31-x64/lib/ruby/gems/3.1.0/gems/jekyll-sass-converter-3.0.0/lib/jekyll/converters/scss.rb:175:in `rescue in convert': expected "{". (Jekyll::Converters::Scss::SyntaxError)
```

which indicates current Jekyll version is so new that many previous features are deprecated and even not supported. I found some solutions on the Internet[^5][^6][^7][^8], but I suddenly realized that this version is not available in GitHub Pages. So, I wanted to downgrade Jekyll, but I didn’t find an elegant way. I think the reason is that many dependencies has also been changed, which leads to more version conflicts, like[^10]. So, I finally chose to directly delete Ruby on my computer, and then re-install Jekyll following blog[^9] (note that the Ruby and Jekyll version). At last, the version of Jekyll I’m using is `3.10.0`.

<br>

# Method 2: Use incremental build

Jekyll provides a command, `jekyll serve --incremental`, to realize incremental build. Indeed, realizing incremental build can greatly decrease the consumed time of re-deployment, except for the first deployment, to basically less than 2 seconds. This function is exactly what I find, but it’s still an experimental feature to date[^12], meaning that the function may not work as expected every now and then:

{% raw %}

<div class="quote--left" markdown="1">

**Incremental regeneration is still an experimental feature**

While incremental regeneration will work for the most common cases, it will not work correctly in every scenario. Please be extremely cautious when using the feature, and report any problems not listed below by [opening an issue on GitHub](https://github.com/jekyll/jekyll/issues/new).

Incremental regeneration helps shorten build times by only generating documents and pages that were updated since the previous build. It does this by keeping track of both file modification times and inter-document dependencies in the `.jekyll-metadata` file.

Under the current implementation, incremental regeneration will only generate a document or page if either it, or one of its dependencies, is modified. Currently, the only types of dependencies tracked are includes (using the `{% include %}` tag) and layouts. This means that plain references to other documents (for example, the common case of iterating over `site.posts` in a post listings page) will not be detected as a dependency.

To remedy some of these shortfalls, putting `regenerate: true` in the front-matter of a document will force Jekyll to regenerate it regardless of whether it has been modified. Note that this will generate the specified document only; references to other documents’ contents will not work since they won’t be re-rendered.

Incremental regeneration can be enabled via the `--incremental` flag (`-I` for short) from the command-line or by setting `incremental: true` in your configuration file.

</div>

{% endraw %}

At least, I find that the website won’t be updated correctly when files added or deleted.

<br>

# Method 3: Change Windows operating system

Jekyll is written in Ruby[^2]:

<div class="quote--left" markdown="1">

Jekyll is a static site generator written in Ruby by Tom Preston-Werner.

</div>

and it seems that Ruby is naturally compiled slowly on Windows system[^1][^13], probably because of Windows not supporting compiling Ruby by multi-cores[^1]. Changing Windows system into Linux (or Mac[^15]) may help to improve.

<br>

# By the way ...

From the blog[^1], I also learned two Jekyll options, `--verbose` option and `--profile` option.

The command `jekyll serve --verbose` is for convenient debugging[^14]:

```
  Logging at level: debug
Configuration file: C:/Users/whatastarrynight/Desktop/website/website/_config.yml
         Requiring: tzinfo
          Timezone: Asia/Shanghai -08:00
  Logging at level: debug
         Requiring: jekyll-paginate
         Requiring: jekyll-sitemap
         Requiring: jekyll-gist
         Requiring: jekyll-feed
         Requiring: jekyll-include-cache
         Requiring: jemoji
         Requiring: jekyll-algolia
            Source: C:/Users/whatastarrynight/Desktop/website/website
       Destination: C:/Users/whatastarrynight/Desktop/website/website/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
       EntryFilter: excluded /Gemfile
       EntryFilter: excluded /Gemfile.lock
           Reading: _posts/aesthetics/2024-04-30-Montage-and-Long-Take.md
           Reading: _posts/ansys/2023-08-26-Use-MATLAB-Script-to-Construct-Solenoid-Model.md
           Reading: _posts/business/2024-11-29-Special-Letters-from-WEB-and-CTM.md
           Reading: _posts/business/2024-12-06-Berkshire-Hathaway-vs-SP5000-NASDAQ100.md
           Reading: _posts/business/2024-12-14-Assets.md
           Reading: _posts/c/2022-09-11-C-language-char-and-char-string.md
           Reading: _posts/c/2022-09-26-C-Code-header files.md
           Reading: _posts/collections/2023-11-27-Romantic-Acknowledgements.md
           ...
                    done in 19.874 seconds.
         Requiring: jekyll-watch
           Watcher: Ignoring (?-mix:^_config\.yml)
           Watcher: Ignoring (?-mix:^_site\/)
           Watcher: Ignoring (?-mix:^\.sass\-cache\/)
           Watcher: Ignoring (?-mix:^Gemfile)
           Watcher: Ignoring (?-mix:^Gemfile\.lock)
 Auto-regeneration: enabled for 'C:/Users/whatastarrynight/Desktop/website/website'
[2025-01-18 18:55:25] INFO  WEBrick 1.9.1
[2025-01-18 18:55:25] INFO  ruby 3.1.3 (2022-11-24) [x64-mingw-ucrt]
[2025-01-18 18:55:25] DEBUG WEBrick::HTTPServlet::FileHandler is mounted on /.
[2025-01-18 18:55:25] DEBUG unmount .
[2025-01-18 18:55:25] DEBUG Jekyll::Commands::Serve::Servlet is mounted on .
    Server address: http://127.0.0.1:4000
[2025-01-18 18:55:25] INFO  WEBrick::HTTPServer#start: pid=22468 port=4000
  Server running... press ctrl-c to stop.
```

and `jekyll serve --profile` is to identify performance bottlenecks[^14]:

```
Configuration file: C:/Users/whatastarrynight/Desktop/website/website/_config.yml
            Source: C:/Users/whatastarrynight/Desktop/website/website
       Destination: C:/Users/whatastarrynight/Desktop/website/website/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
       Jekyll Feed: Generating feed for posts

Filename                                                                                               | Count |     Bytes |  Time
-------------------------------------------------------------------------------------------------------+-------+-----------+------
_layouts/single.html                                                                                   |   616 | 13415.49K | 3.376
_layouts/default.html                                                                                  |   640 | 22293.54K | 2.843
_includes/head.html                                                                                    |   640 |  1335.31K | 2.268
_includes/seo.html                                                                                     |   640 |   606.56K | 1.901
_includes/archive-single.html                                                                          |    23 |  2517.25K | 1.088
_layouts/categories.html                                                                               |     1 |   943.00K | 1.046
_includes/toc.html                                                                                     |   272 |   180.52K | 0.782
_includes/page__widget/page__taxonomy.html                                                             |   616 |   622.27K | 0.676
_layouts/tags.html                                                                                     |     1 |   996.31K | 0.560
_layouts/home.html                                                                                     |    20 |   519.99K | 0.356
_layouts/posts.html                                                                                    |     1 |   508.20K | 0.328
_includes/category-list.html                                                                           |   612 |   275.09K | 0.236
_includes/tag-list.html                                                                                |   437 |   232.67K | 0.173
_includes/page__widget/page__date.html                                                                 |   616 |   136.25K | 0.167
_includes/sidebar.html                                                                                 |   639 |    27.55K | 0.158
_includes/page__widget/page__meta.html                                                                 |   637 |   109.93K | 0.146
sitemap.xml                                                                                            |     1 |    80.60K | 0.146
_includes/page__widget/page__hero.html                                                                 |    40 |    18.00K | 0.075
_includes/footer_scripts.html                                                                          |   640 |  2361.25K | 0.070
_layouts/archive.html                                                                                  |    22 |  2471.26K | 0.065
feed.xml                                                                                               |     1 |   118.17K | 0.032
_includes/paginator.html                                                                               |    20 |    16.47K | 0.027
_includes/head_scripts_single.html                                                                     |   616 |   635.85K | 0.014
_includes/head_scripts.html                                                                            |   640 |   515.00K | 0.012
_includes/gallery                                                                                      |     8 |     7.65K | 0.009
_posts/latex/table/2025-01-16-LaTeX-Long-Table.md                                                      |     1 |     2.06K | 0.004
_layouts/splash.html                                                                                   |     1 |     6.95K | 0.004
_posts/web development/jekyll/minimal-mistake/2022-08-12-Test-Gallery-in-Jekyll-based-Website.md       |     1 |     5.10K | 0.004
_posts/web development/jekyll/minimal-mistake/2024-05-31-Test-Splash-Layout.md                         |     1 |     5.46K | 0.003
_includes/page__widget/page__hero_video.html                                                           |     4 |     1.06K | 0.003
_includes/nav_list                                                                                     |     2 |     3.62K | 0.003
_includes/feature_row                                                                                  |     1 |     5.45K | 0.003
_includes/video                                                                                        |     5 |     1.36K | 0.002
_posts/hardware/2024-11-16-FLUKE-Digital-Multimeters-18B+.md                                           |     1 |     2.06K | 0.002
_posts/latex/layout/2025-01-12-Make-the-Document-Orientation-as-Landscape.md                           |     1 |     2.42K | 0.001
_layouts/archive_year.html                                                                             |     1 |   508.43K | 0.001
_posts/moments/2022-06-20-What-a-sunny-day.md                                                          |     1 |     0.11K | 0.001
_posts/latex/hologo/2025-01-04-LaTeX-`hologo`-Package.md                                               |     1 |     4.12K | 0.001
_posts/web development/jekyll/2024-11-25-Date-and-Time-Formats.md                                      |     1 |     1.86K | 0.001
_posts/moments/2024-06-24-XJTU-iHarbour.md                                                             |     1 |     1.22K | 0.001
_posts/moments/2024-01-11-Guangzhou.md                                                                 |     1 |     0.19K | 0.001
_posts/web development/jekyll/minimal-mistake/2022-08-12-Test-External-Video-Links-and-Header-Video.md |     1 |     1.34K | 0.001
_includes/masthead.html                                                                                |     1 |     1.11K | 0.001
_posts/ideas/2022-08-06-Take-a-Little-Think-of-Monte-Carlo-Simulation.md                               |     1 |     2.66K | 0.000
_posts/web development/jekyll/minimal-mistake/2022-08-12-Test-notice-in-Jekyll-based-Website.md        |     1 |     7.24K | 0.000
_posts/latex/table/2024-05-01-Color-the-Table-Cell.md                                                  |     1 |    26.34K | 0.000
_includes/footer.html                                                                                  |     1 |     2.06K | 0.000
robots.txt                                                                                             |     1 |     0.04K | 0.000
_posts/web development/jekyll/minimal-mistake/2024-06-20-CSS-Buttons.md                                |     1 |    12.97K | 0.000
_posts/web development/jekyll/2025-01-03-Sort-Post-Tags-in-Alphabetical-Order.md                       |     1 |     2.31K | 0.000


                    done in 18.366 seconds.
 Auto-regeneration: enabled for 'C:/Users/whatastarrynight/Desktop/website/website'
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
```

The blog[^1] cites a blog of Michael Rose[^15] showing how to optimize Jekyll website based on this command. It’s more suitable for those huge websites.

<br>

**References**

[^1]: [GitHub-jekyll静态博客快速构建与优化--`jekyll serve --incremental --profile`](https://last2win.com/2020/01/25/github-jekyll-fast-build/).
[^2]: [Jekyll (software)](https://en.wikipedia.org/wiki/Jekyll_\(software\)).
[^3]: [Dependency versions](https://pages.github.com/versions/).
[^4]: [jekyll](https://rubygems.org/gems/jekyll).

[^5]: [Sass: Breaking Change: `@import` and global built-in functions](https://sass-lang.com/documentation/breaking-changes/import/).
[^6]: [Sass `@import` rules are deprecated and will be removed in Dart Sass 3.0.0 · Issue #7771 · nolimits4web/swiper](https://github.com/nolimits4web/swiper/issues/7771).
[^7]: [Error in Step by Step Tutorial](https://talk.jekyllrb.com/t/error-in-step-by-step-tutorial/7984/11).
[^8]: [[Bug] `Error: expected "{".` (RuntimeError) · Issue #9298 · jekyll/jekyll](https://github.com/jekyll/jekyll/issues/9298).
[^9]: [Install Jekyll on Windows](https://helloworld-1017.github.io/2023-01-03/09-55-32.html).
[^10]: [jekyll serve throws `'no implicit conversion of Hash into Integer'` error](https://stackoverflow.com/questions/66113639/jekyll-serve-throws-no-implicit-conversion-of-hash-into-integer-error/67580565#67580565).
[^11]: [Modify Permalink Structure of Jekyll Theme Minimal Mistakes](/2023-10-21/19-27-36.html).
[^12]: [Default Configuration](https://jekyllrb.com/docs/configuration/incremental-regeneration/).
[^13]: [Why is ruby so much slower on windows?](https://stackoverflow.com/questions/920201/why-is-ruby-so-much-slower-on-windows).
[^14]: [Configuration Options](https://jekyllrb.com/docs/configuration/options/).
[^15]: [Optimizing and automating my Jekyll site build](https://mademistakes.com/articles/using-jekyll-2017/).
