---
title: "The Source File Structure of Jekyll Theme \"minimal-mistakes\""
subtitle: Realize file tree in MATLAB
categories:
 - Web Development
 - MATLAB
 - Windows
tags:
 - Jekyll
 - Regular Expression
 - Data Structure
 - MATLAB Language Fundamentals
 - MATLAB Programming
date: 2023-10-25 21:25:49 +0800
last_modified_at: 2024-07-19 04:21:10 +0800
---

# Introduction

My personal website is based on a Jekyll theme "minimal-mistakes"[^1], but I don't know much about Jekyll as well as other languages for website establishment, like HTML, CSS for instance, as I have no idea about how to debug it. So, taking "minimal-mistakes" theme as an example, I want to learn these step by step. As the first step, I want to obtain a file tree of website folder.

In the website root folder, we could type the command:

```
dir /b/og
```

N.B., `/b`: Displays a bare list of directories and files, with no additional information; `/og`: Sorts the output according to "Group directories first" rule. More details could be found in[^2].
{: .notice--primary}

in Windows CMD, a list of files and folders in the first level folder will show up:

```
.github
_sass
.sass-cache
_posts
assets
_pages
_life
_layouts
images
_includes
_site
_drafts
_docs
_data
_config.yml
tree.txt
index.html
Gemfile.lock
Gemfile
favicon.ico
404.html
.gitignore
README.md
```

where the files for constructing website components are mainly put in `_data`, `_includes`, `_layouts`, `_pages`, `_sass`, and `assets` folders. But when I try to list all subfolders and files in these six folders, I encountered some problems.

At first, `tree` command actually is more suitable for listing file tree compare with `dir`, however, `tree` command in Windows CMD[^3] is not that powerful and flexible as that in Linux system[^4]. I found many sources on the Internet, but didn't find how to list file tree for *some certain* subfolders (i.e., it seems to only support to list file tree for *all* subfolders).

On another hand, `dir` command in Windows CMD, which is used above, provides various options. We could use:

```
dir /d/s "_data" "_includes" "_layouts" "_pages" "_sass" "assets"
```

N.B., `/s`: Lists every occurrence of the specified file name within the specified directory and all subdirectories[^2].
{: .notice--primary}

> or output the lists to `list.txt`:
>
> ```
> dir /d/s "_data" "_includes" "_layouts" "_pages" "_sass" "assets" > list.txt
> ```

to inspect these folders, but I don't like whose display format. 

At last, I decided to realise my requirement using MATLAB, and during which process, I found it is very interesting as it reflects a classical problem, i.e., how to traverse every node of a *tree* data structure in a *recursive* way, which I rarely encountered before. And my final code is:

```matlab
clc,clear,close all

for i = ["_data" "_includes" "_layouts" "_pages" "_sass" "assets"]
    rootPath = fullfile(pwd,i);
    fprintf("=======%s=======\n",i)
    helperMain(rootPath)
end

function helperMain(rootPath)
files = string; %#ok
folders = string;
allFolders = string;

% Collect file name and corresponding folder name
helperFind(rootPath);

% Post-process for `folders` and `files`
folders(1)  = [];
files(1) = [];
allFolders(1) = [];

folders = replace(folders,pwd,".");
allFolders = replace(allFolders,pwd,".");

folderNames = sort(unique(folders),"ascend");
allFolderNames = sort(unique(allFolders),"ascend");

onlyHaveSubFolders = allFolderNames(~arrayfun(@(x) sum(x==folderNames),allFolderNames));

sizeFolderNames = arrayfun(@(x) numel(string(regexp(x,"\","split"))), folderNames);

for jj = 1:height(sizeFolderNames)
    subFolders(jj,1:sizeFolderNames(jj)) = string(regexp(folderNames(jj,1),"\","split")); %#ok
end

% Print file tree
for jj = 1:numel(folderNames)
    idx = folders == folderNames(jj,1); %#ok
    subfolders = rmmissing(subFolders(jj,:));
    numLevel = numel(subfolders)-2;
    if sum(string(strjoin(subfolders(1:end-1),"\")) == onlyHaveSubFolders)
        eval(strcat('fprintf("%',num2str(8*(numLevel-1)),'s%s%s\n","",filesep,subfolders(end-1))'));
        onlyHaveSubFolders(onlyHaveSubFolders == string(strjoin(subfolders(1:end-1),"\"))) = [];
    end
    eval(strcat('fprintf("%',num2str(8*(numLevel)),'s%s%s\n","",filesep,subfolders(end))'));
    eval(strcat('arrayfun(@(x) fprintf("%',num2str(8*(numLevel+1)),'s%s\n","",x), files(idx));'))
end

% Find files recursively
    function helperFind(PATH)
        roots = dir(PATH);
        for i = 3:numel(roots)
            if roots(i).isdir
                allFolders(end+1,1) = roots(i).folder; %#ok
                helperFind(fullfile(roots(i).folder,roots(i).name));
            else
                allFolders(end+1,1) = roots(i).folder; %#ok
                folders(end+1,1) = roots(i).folder; %#ok
                files(end+1,1) = roots(i).name; %#ok
            end
        end
    end
end
```

N.B., This script should be put in the website root folder.
{: .notice--primary}

Generally, I wrote a recursive function `helperFind` to find each file in specified folders, and mainly record whose folder name and file name in global variables `folders` and `files`. Then make a post-process to better display files information in order.

The above MATLAB code running results will be presented in the following text, and each section corresponds to a single folder. 

<br>

# `_data` folder

```
=======_data=======
\_data
        navigation.yml
        ui-text.yml
```

<br>

# `_includes` folder

```
=======_includes=======
\_includes
        analytics.html
        archive-single.html
        author-profile-custom-links.html
        author-profile.html
        breadcrumbs.html
        browser-upgrade.html
        category-list.html
        comment.html
        comments.html
        documents-collection.html
        feature_row
        figure
        footer.html
        gallery
        group-by-array
        head.html
        masthead.html
        nav_list
        page__date.html
        page__hero.html
        page__hero_video.html
        page__meta.html
        page__taxonomy.html
        paginator.html
        post_pagination.html
        posts-category.html
        posts-tag.html
        scripts.html
        seo.html
        sidebar.html
        skip-links.html
        social-share.html
        tag-list.html
        toc
        toc.html
        video
        \analytics-providers
                custom.html
                google-gtag.html
                google-universal.html
                google.html
        \comments-providers
                custom.html
                custom_scripts.html
                discourse.html
                disqus.html
                facebook.html
                giscus.html
                scripts.html
                staticman.html
                staticman_v2.html
                utterances.html
        \footer
                custom.html
        \head
                custom.html
        \search
                algolia-search-scripts.html
                google-search-scripts.html
                lunr-search-scripts.html
                search_form.html
```

<br>

# `_layouts` folder

```
=======_layouts=======
\_layouts
        archive-taxonomy.html
        archive.html
        categories.html
        category.html
        collection.html
        compress.html
        default.html
        home.html
        posts.html
        search.html
        single.html
        splash.html
        tag.html
        tags.html
```

<br>

# `_pages` folder

```
=======_pages=======
\_pages
        404.md
        about.md
        category-archive.md
        life.md
        tag-archive.md
        year-archive.md
```

<br>

# `_sass` folde

```
=======_sass=======
\_sass
        minimal-mistakes.scss
        \minimal-mistakes
                _animations.scss
                _archive.scss
                _base.scss
                _buttons.scss
                _footer.scss
                _forms.scss
                _masthead.scss
                _mixins.scss
                _navigation.scss
                _notices.scss
                _page.scss
                _print.scss
                _reset.scss
                _search.scss
                _sidebar.scss
                _syntax.scss
                _tables.scss
                _utilities.scss
                _variables.scss
                \skins
                        _air.scss
                        _aqua.scss
                        _contrast.scss
                        _dark.scss
                        _default.scss
                        _dirt.scss
                        _mint.scss
                        _myskin.scss
                        _neon.scss
                        _plum.scss
                        _sunrise.scss
                \vendor
                        \breakpoint
                                _breakpoint.scss
                                _context.scss
                                _helpers.scss
                                _legacy-settings.scss
                                _no-query.scss
                                _parsers.scss
                                _respond-to.scss
                                _settings.scss
                                \parsers
                                        _double.scss
                                        _query.scss
                                        _resolution.scss
                                        _single.scss
                                        _triple.scss
                                        \double
                                                _default-pair.scss
                                                _default.scss
                                                _double-string.scss
                                        \resolution
                                                _resolution.scss
                                        \single
                                                _default.scss
                                        \triple
                                                _default.scss
                        \magnific-popup
                                _magnific-popup.scss
                                _settings.scss
                        \susy
                                _su.scss
                                _susy-prefix.scss
                                _susy.scss
                                \plugins
                                        _svg-grid.scss
                                        \svg-grid
                                                _prefix.scss
                                                _svg-api.scss
                                                _svg-grid-math.scss
                                                _svg-settings.scss
                                                _svg-unprefix.scss
                                                _svg-utilities.scss
                                \susy
                                        _api.scss
                                        _normalize.scss
                                        _parse.scss
                                        _settings.scss
                                        _su-math.scss
                                        _su-validate.scss
                                        _syntax-helpers.scss
                                        _unprefix.scss
                                        _utilities.scss
```

In this folder, all files are `.scss` files for styling website components, like files for setting website skins in `.\_sass\minimal-mistakes\skins` folder (could refer to[^5]).

<br>

# `assets` folder

```
=======assets=======
\assets
        \css
                main.scss
        \js
                _main.js
                main.min.js
                \lunr
                        lunr-en.js
                        lunr-gr.js
                        lunr-store.js
                        lunr.js
                        lunr.min.js
                \plugins
                        gumshoe.js
                        jquery.ba-throttle-debounce.js
                        jquery.fitvids.js
                        jquery.greedy-navigation.js
                        jquery.magnific-popup.js
                        smooth-scroll.js
                \vendor
                        \jquery
                                jquery-3.5.1.js
```

<br>

**References**

[^1]: [mmistakes/minimal-mistakes - GitHub](https://github.com/mmistakes/minimal-mistakes).
[^2]: [`dir` - Windows Server](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/dir).
[^3]: [`tree` - Windows Server](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree).
[^4]: [Tree command in Linux with examples - GeeksforGeeks](https://www.geeksforgeeks.org/tree-command-unixlinux/).
[^5]: [Create a New Skin of Jekyll Theme "minimal-mistakes" - What a starry night~](https://helloworld-1017.github.io/2023-10-24/16-15-45.html).
