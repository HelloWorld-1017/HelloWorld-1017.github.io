

# Introduction

Displays a bare list of directories and files, with no additional information. The **/b** parameter overrides **/w**.

```cmd
dir "_data" "_includes" /b
```

```cmd
tree/f "_includes  "_data"
```

```cmd
dir /d "_includes" "_data" "_includes" "_layouts" "_pages" "_sass" "assets" > info.txt
```

<br>

```
dir /b/og
```

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

`_data`, `_includes`, `_layouts`, `_pages`, `_sass`, and `assets`







```cmd
dir /o:g "_includes" "_data" "_includes" "_layouts" "_pages" "_sass" "assets"
```



```matlab
clc,clear,close all

for i = ["_data", "_includes", "_layouts", "_pages", "_sass", "assets"]
    rootPath = fullfile(pwd,i);
    helperMain(rootPath)
    fprintf("========================\n")
end

function helperMain(rootPath)
files = string;
folders = string;

% Collect file name and corresponding folder name
helperFind(rootPath);

folders(1)  = [];
files(1) = [];

folders = replace(folders,pwd,".");

folderNames = sort(unique(folders),"ascend");
for jj = 1:numel(folderNames)
    idx = folders == folderNames(jj);
    disp(folderNames(jj))
    fprintf("\t%s\n",files(idx));
end

% Find files recursively
    function helperFind(PATH)
        roots = dir(PATH);
        for i = 3:numel(roots)
            if roots(i).isdir
                helperFind(fullfile(roots(i).folder,roots(i).name));
            else
                folders(end+1,1) = roots(i).folder; %#ok
                files(end+1,1) = roots(i).name; %#ok
            end
        end
    end
end
```

<br>

# `_data` folder

```
.\_data
	navigation.yml
	ui-text.yml
```

<br>

# `_includes` folder

```
.\_includes
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
.\_includes\analytics-providers
	custom.html
	google-gtag.html
	google-universal.html
	google.html
.\_includes\comments-providers
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
.\_includes\footer
	custom.html
.\_includes\head
	custom.html
.\_includes\search
	algolia-search-scripts.html
	google-search-scripts.html
	lunr-search-scripts.html
	search_form.html
```

<br>

# `_layouts` folder

```
.\_layouts
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
.\_pages
	404.md
	about.md
	category-archive.md
	life.md
	tag-archive.md
	year-archive.md
```

<br>

# `_sass` folder

```
.\_sass
	minimal-mistakes.scss
.\_sass\minimal-mistakes
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
.\_sass\minimal-mistakes\skins
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
.\_sass\minimal-mistakes\vendor\breakpoint
	_breakpoint.scss
	_context.scss
	_helpers.scss
	_legacy-settings.scss
	_no-query.scss
	_parsers.scss
	_respond-to.scss
	_settings.scss
.\_sass\minimal-mistakes\vendor\breakpoint\parsers
	_double.scss
	_query.scss
	_resolution.scss
	_single.scss
	_triple.scss
.\_sass\minimal-mistakes\vendor\breakpoint\parsers\double
	_default-pair.scss
	_default.scss
	_double-string.scss
.\_sass\minimal-mistakes\vendor\breakpoint\parsers\resolution
	_resolution.scss
.\_sass\minimal-mistakes\vendor\breakpoint\parsers\single
	_default.scss
.\_sass\minimal-mistakes\vendor\breakpoint\parsers\triple
	_default.scss
.\_sass\minimal-mistakes\vendor\magnific-popup
	_magnific-popup.scss
	_settings.scss
.\_sass\minimal-mistakes\vendor\susy
	_su.scss
	_susy-prefix.scss
	_susy.scss
.\_sass\minimal-mistakes\vendor\susy\plugins
	_svg-grid.scss
.\_sass\minimal-mistakes\vendor\susy\plugins\svg-grid
	_prefix.scss
	_svg-api.scss
	_svg-grid-math.scss
	_svg-settings.scss
	_svg-unprefix.scss
	_svg-utilities.scss
.\_sass\minimal-mistakes\vendor\susy\susy
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

`.scss` files, like skin settings 

<br>

# `assets` folder

```
.\assets\css
	main.scss
.\assets\js
	_main.js
	main.min.js
.\assets\js\lunr
	lunr-en.js
	lunr-gr.js
	lunr-store.js
	lunr.js
	lunr.min.js
.\assets\js\plugins
	gumshoe.js
	jquery.ba-throttle-debounce.js
	jquery.fitvids.js
	jquery.greedy-navigation.js
	jquery.magnific-popup.js
	smooth-scroll.js
.\assets\js\vendor\jquery
	jquery-3.5.1.js
```

<br>

<div id="ref"></div>

**References**

[1] https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree

[2] https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/dir

[3] https://helloworld-1017.github.io/2023-10-24/16-15-45.html
