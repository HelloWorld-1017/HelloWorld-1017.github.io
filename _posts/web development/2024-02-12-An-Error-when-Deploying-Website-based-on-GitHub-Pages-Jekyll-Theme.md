---
title: An Error when Deploying Website based on GitHub-Pages Jekyll Theme
toc: false
categories:
 - Web Development
tags:
 - Jekyll
date: 2024-02-12 16:25:03 +0800
last_modified_at: 2024-08-25 18:38:41 +0800
---

Recently, I try to commit changes to my repository, **HelloWorld-1017/HelloWorld-1017.github.io: My personal website** [^1], to update my GitHub-Pages based website just as usual. However, I failed to deploy it times and times again:

![image-20240212161304832](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402121613913.png)

At the beginning, I believed that it was not caused by my local Jekyll-concerned settings as I could succeed deploying website locally. 

I remember that I ever encountered this kind of situation one day. I tried many ways, but none of them helped, so I discarded all changes and gave up debugging later on. However, surprisingly, the website could be successfully deployed the next day, without any changes to settings. So, it may be an error that occurred on the GitHub server.

I tried to do the same this time, that is just wait for a while and try again, but as shown in the above figure, it doesn't work.

So later on, I checked out the deployment details, and found that the deployment was terminated when "build with Jekyll" [^2]:

![image-20240212223408331](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402122234415.png)

and the detailed message showed as follows:

```
/usr/bin/docker run --name ghcrioactionsjekyllbuildpagesv1010_f92a33 --label 437496 --workdir /github/workspace --rm -e "INPUT_SOURCE" -e "INPUT_DESTINATION" -e "INPUT_FUTURE" -e "INPUT_BUILD_REVISION" -e "INPUT_VERBOSE" -e "INPUT_TOKEN" -e "HOME" -e "GITHUB_JOB" -e "GITHUB_REF" -e "GITHUB_SHA" -e "GITHUB_REPOSITORY" -e "GITHUB_REPOSITORY_OWNER" -e "GITHUB_REPOSITORY_OWNER_ID" -e "GITHUB_RUN_ID" -e "GITHUB_RUN_NUMBER" -e "GITHUB_RETENTION_DAYS" -e "GITHUB_RUN_ATTEMPT" -e "GITHUB_ACTOR_ID" -e "GITHUB_ACTOR" -e "GITHUB_WORKFLOW" -e "GITHUB_HEAD_REF" -e "GITHUB_BASE_REF" -e "GITHUB_EVENT_NAME" -e "GITHUB_SERVER_URL" -e "GITHUB_API_URL" -e "GITHUB_GRAPHQL_URL" -e "GITHUB_REF_NAME" -e "GITHUB_REF_PROTECTED" -e "GITHUB_REF_TYPE" -e "GITHUB_WORKFLOW_REF" -e "GITHUB_WORKFLOW_SHA" -e "GITHUB_REPOSITORY_ID" -e "GITHUB_TRIGGERING_ACTOR" -e "GITHUB_WORKSPACE" -e "GITHUB_ACTION" -e "GITHUB_EVENT_PATH" -e "GITHUB_ACTION_REPOSITORY" -e "GITHUB_ACTION_REF" -e "GITHUB_PATH" -e "GITHUB_ENV" -e "GITHUB_STEP_SUMMARY" -e "GITHUB_STATE" -e "GITHUB_OUTPUT" -e "RUNNER_OS" -e "RUNNER_ARCH" -e "RUNNER_NAME" -e "RUNNER_TOOL_CACHE" -e "RUNNER_TEMP" -e "RUNNER_WORKSPACE" -e "ACTIONS_RUNTIME_URL" -e "ACTIONS_RUNTIME_TOKEN" -e "ACTIONS_CACHE_URL" -e "ACTIONS_ID_TOKEN_REQUEST_URL" -e "ACTIONS_ID_TOKEN_REQUEST_TOKEN" -e "ACTIONS_RESULTS_URL" -e GITHUB_ACTIONS=true -e CI=true -v "/var/run/docker.sock":"/var/run/docker.sock" -v "/home/runner/work/_temp/_github_home":"/github/home" -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" -v "/home/runner/work/_temp/_runner_file_commands":"/github/file_commands" -v "/home/runner/work/HelloWorld-1017.github.io/HelloWorld-1017.github.io":"/github/workspace" ghcr.io/actions/jekyll-build-pages:v1.0.10

Warning: the running version of Bundler (2.1.4) is older than the version that created the lockfile (2.5.6). We suggest you to upgrade to the version that created the lockfile by running `gem install bundler:2.5.6`.
https://github.com/jekyll/jekyll-commonmark.git (at refs/pull/44/head@53092e1)
is not yet checked out. Run `bundle install` first.

Warning: The github-pages gem can't satisfy your Gemfile's dependencies. If you want to use a different Jekyll version or need additional dependencies, consider building Jekyll site with GitHub Actions: https://jekyllrb.com/docs/continuous-integration/github-actions/
To use retry middleware with Faraday v2.0+, install `faraday-retry` gem
/usr/local/bundle/gems/jekyll-3.9.4/lib/jekyll/excerpt.rb:135:in `extract_excerpt': undefined method `excerpt_separator' for #<Jekyll::Page @name="404.md"> (NoMethodError)
	from /usr/local/bundle/gems/jekyll-3.9.4/lib/jekyll/excerpt.rb:25:in `initialize'
	from /usr/local/bundle/gems/jekyll-relative-links-0.7.0/lib/jekyll-relative-links/generator.rb:173:in `new'
	from /usr/local/bundle/gems/jekyll-relative-links-0.7.0/lib/jekyll-relative-links/generator.rb:173:in `replace_relative_links_excerpt!'
	from /usr/local/bundle/gems/jekyll-relative-links-0.7.0/lib/jekyll-relative-links/generator.rb:64:in `replace_relative_links!'
	from /usr/local/bundle/gems/jekyll-relative-links-0.7.0/lib/jekyll-relative-links/generator.rb:44:in `block in generate'
	from /usr/local/bundle/gems/jekyll-relative-links-0.7.0/lib/jekyll-relative-links/generator.rb:39:in `each'
	from /usr/local/bundle/gems/jekyll-relative-links-0.7.0/lib/jekyll-relative-links/generator.rb:39:in `generate'
	from /usr/local/bundle/gems/jekyll-3.9.4/lib/jekyll/site.rb:175:in `block in generate'
	from /usr/local/bundle/gems/jekyll-3.9.4/lib/jekyll/site.rb:173:in `each'
	from /usr/local/bundle/gems/jekyll-3.9.4/lib/jekyll/site.rb:173:in `generate'
	from /usr/local/bundle/gems/jekyll-3.9.4/lib/jekyll/site.rb:70:in `process'
	from /usr/local/bundle/gems/jekyll-3.9.4/lib/jekyll/command.rb:28:in `process_site'
	from /usr/local/bundle/gems/jekyll-3.9.4/lib/jekyll/commands/build.rb:65:in `build'
	from /usr/local/bundle/gems/jekyll-3.9.4/lib/jekyll/commands/build.rb:36:in `process'
	from /usr/local/bundle/gems/github-pages-229/bin/github-pages:70:in `block (3 levels) in <top (required)>'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `block in execute'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `each'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/command.rb:220:in `execute'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary/program.rb:42:in `go'
	from /usr/local/bundle/gems/mercenary-0.3.6/lib/mercenary.rb:19:in `program'
	from /usr/local/bundle/gems/github-pages-229/bin/github-pages:6:in `<top (required)>'
	from /usr/local/bundle/bin/github-pages:23:in `load'
	from /usr/local/bundle/bin/github-pages:23:in `<main>'
	
Error:  Logging at level: debug Configuration file: /github/workspace/./_config.yml 
GitHub Pages: github-pages v229 
GitHub Pages: jekyll v3.9.4 
Theme: jekyll-theme-primer 
Theme source: /usr/local/bundle/gems/jekyll-theme-primer-0.6.0 
Requiring: jekyll-github-metadata 
Requiring: jekyll-seo-tag 
Requiring: jekyll-paginate 
Requiring: jekyll-sitemap 
Requiring: jekyll-gist 
Requiring: jekyll-feed 
Requiring: jekyll-include-cache 
Requiring: jemoji 
Requiring: jekyll-coffeescript 
Requiring: jekyll-commonmark-ghpages 
Requiring: jekyll-github-metadata 
Requiring: jekyll-relative-links 
Requiring: jekyll-optional-front-matter 
Requiring: jekyll-readme-index 
Requiring: jekyll-default-layout 
Requiring: jekyll-titles-from-headings 
GitHub Metadata: Initializing... 
Source: /github/workspace/. 
Destination: /github/workspace/./_site 
Incremental build: disabled. Enable with --incremental Generating... 
EntryFilter: excluded /Gemfile 
EntryFilter: excluded /Gemfile.lock 
Reading: _posts/2022-10-25-MATLAB-var-std-cov-functions.md 
Reading: _posts/2022-10-10-A-Small-Custom-Function-Testing-the-Output-Size-of-Each-Layer-of-Neural-Network-in-MATLAB.md
Reading: _posts/2024-02-08-One-Hot-Encoding-and-Decoding-in-MATLAB.md
Reading: _posts/2023-03-31-Momentum-Equations-of-the-Fluid-from-Fundamentals-of-Aerodynamics-by-Anderson.md
Reading: _posts/2023-01-03-Install-Jekyll-for-Windows.md
Reading: _posts/2022-06-09-Geometric-and-Algebraic-Definition-of-Dot-Product.md
Reading: _posts/2022-08-12-Test-Gallery-in-Jekyll-based-Website.md
Reading: _posts/2022-09-04-MATLAB-Graphics-tiledlayout-and-subplot.md
Reading: _posts/2023-02-26-A-Connection-Error-when-Using-MATLAB-Instrument-Control-Toolbox.md
Reading: _posts/2023-04-10-Constructing-A-Simple-MLP-for-Diabetes-Dataset-Binary-Classification-Problem-with-PyTorch.md
Reading: _posts/2023-04-13-Constructing-A-Simple-GoogLeNet-and-ResNet-for Solving-MNIST-Image-Classification-with-PyTorch.md
Reading: _posts/2022-06-23-Matlab-UI-Figure-and-Axes.md
Reading: _posts/2023-10-19-Change-enumerate-and-itemize-Style-in-LaTeX-beamer.md
Reading: _posts/2022-11-01-From-Sample-Covariance-Matrix-to-Bessel's-Correction.md
Reading: _posts/2023-02-25-A-GUI-Demo-Browser-from-MATLAB-GUI-Layout-Toolbox.md
Reading: _posts/2023-04-25-The-Prime-Number-Theorem-(PNT)-from-Prime-Obsession-by-Derbyshire.md Reading: _posts/2023-10-24-Create-a-New-Skin-of-Jekyll-Theme-minimal-mistakes.md
Reading: _posts/2023-02-07-Auxiliary-Voltage-Tests-for-Circuit-Breakers-from-Megger-Co.Ltd.md
Reading: _posts/2022-10-06-Batch-Modify-Files-and-Folders-Name.md
Reading: _posts/2022-06-11-Linear-Transformation-and-Matrix.md
Reading: _posts/2023-10-11-Customise-Figure-Caption-Style-in-LaTeX-System.md
Reading: _posts/2022-10-09-Generate-Synthetic-Signals-Using-Conditional-GAN-in-MATLAB.md
Reading: _posts/2023-04-22-Some-Classical-Series-and-Fourfold-Division-of-Mathematics-from-Prime-Obsession-by-Derbyshire.md
Reading: _posts/2022-06-14-Linear-System-of-Equations.md
Reading: _posts/2023-04-08-Saddle-Surface-and-Saddle-Point.md
Reading: _posts/2022-10-02-word-cloud-in-MATLAB.md
Reading: _posts/2022-10-21-Monty-Hall-Problem.md
Reading: _posts/2022-08-18-Test-Customised-Sidebar-in-Jekyll-based-Website.md
Reading: _posts/2023-02-26-An-Example-of-using-the-Panelbox-Minimize-Maximize-Function-from-MATLAB-GUI-Layout-Toolbox.md
Reading: _posts/2022-09-21-Similarity-Based-Remaining-Useful-Life-Estimation.md 
Reading: _posts/2023-11-16-Create-Animation-in-MATLAB.md 
Reading: _posts/2022-08-08-Using-the-App-to-Pass-Parameters-to-Simulink-Models-in-MATLAB.md Reading: _posts/2023-04-02-Conda-vs-Pip.md
Reading: _posts/2023-04-04-Constructing-A-Simple-Linear-Model-with-PyTorch.md
Reading: _posts/2023-08-30-Recording-How-to-Make-Annotations-in-LaTeX.md
Reading: _posts/2023-03-24-The-Physical-Meaning-of-Divergence-of-Velocity-from-Fundamentals-of-Aerodynamics-by-Anderson.md
Reading: _posts/2023-04-02-Common-Conda-Commands.md
Reading: _posts/2022-09-11-C-language-char-and-char-string.md
Reading: _posts/2023-10-27-The-Eigenvalue-Interval-Pattern-of-Sample-Covariance-Matrix.md
Reading: _posts/20
```

As can be seen, there are two warnings:

```
Warning: the running version of Bundler (2.1.4) is older than the version that created the lockfile (2.5.6). We suggest you to upgrade to the version that created the lockfile by running `gem install bundler:2.5.6`.
https://github.com/jekyll/jekyll-commonmark.git (at refs/pull/44/head@53092e1)
is not yet checked out. Run `bundle install` first.

Warning: The github-pages gem can't satisfy your Gemfile's dependencies. If you want to use a different Jekyll version or need additional dependencies, consider building Jekyll site with GitHub Actions: https://jekyllrb.com/docs/continuous-integration/github-actions/
To use retry middleware with Faraday v2.0+, install `faraday-retry` gem
/usr/local/bundle/gems/jekyll-3.9.4/lib/jekyll/excerpt.rb:135:in `extract_excerpt': undefined method `excerpt_separato
```

and one error reported above:

```
Error:  Logging at level: debug Configuration file: /github/workspace/./_config.yml 
GitHub Pages: github-pages v229 
GitHub Pages: jekyll v3.9.4 
Theme: jekyll-theme-primer 
Theme source: /usr/local/bundle/gems/jekyll-theme-primer-0.6.0 
Requiring: jekyll-github-metadata
......
```

At first, I spent a lot of time to fix these two warnings (update Bundler and add Gemfile's dependencies), but it doesn't work, meaning that these two warnings don't contribute to the following error. 

> In fact, I found these two warnings always exists although the website is successfully deployed, like the deployment on 4 Feb. 2024 for example [^3]:
>
> ![image-20240212175457777](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402121754944.png)
>
> I overlooked this point before.

At last, I found a question, which is posted on the Stack Overflow two days ago, reported the same problem [^4]. And user "maikhel" points out that [^5] this is because that "the build is broken due to GitHub update of Jekyll to v3.9.4". To fix it, we should **delete `excerpt: ...` of YAML header of some `.md` files in `_pages` folder**. For my website, I just delete it from `_pages\404.md` file [^6]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202402122220790.png" alt="image-20240212222043651" style="zoom:67%;" />

It's okay!

<br>

# References

[^1]: [HelloWorld-1017/HelloWorld-1017.github.io: My personal website](https://github.com/HelloWorld-1017/HelloWorld-1017.github.io).
[^2]: [pages build and deployment · HelloWorld-1017/HelloWorld-1017.github.io@8633359](https://github.com/HelloWorld-1017/HelloWorld-1017.github.io/actions/runs/7868662944/job/21466270928).
[^3]: [pages build and deployment · HelloWorld-1017/HelloWorld-1017.github.io@3bb778a](https://github.com/HelloWorld-1017/HelloWorld-1017.github.io/actions/runs/7771504966/job/21192879283).
[^4]: [github jekyll page build keeps failing - Stack Overflow](https://stackoverflow.com/questions/77972098/github-jekyll-page-build-keeps-failing).
[^5]: [https://stackoverflow.com/a/77973548/22763127](https://stackoverflow.com/a/77973548/22763127).
[^6]: [Update 404.md · HelloWorld-1017/HelloWorld-1017.github.io@7f83c20](https://github.com/HelloWorld-1017/HelloWorld-1017.github.io/commit/7f83c20d2c568b3a678b70064f837043e2cc747c).