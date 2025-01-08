---
title: Sort Post Tags in Alphabetical Order in Jekyll Website
toc: false
categories:
 - Web Development
tags:
 - Jekyll
date: 2025-01-03 14:23:45 +0800
last_modified_at: 2025-01-04 14:59:05 +0800
---

For Jekyll website, we can sort post tags in alphabetical order using code[^1] (take the case of my website[^2]):

{% raw %}

```html
---
layout: archive
---

{{ content }}

{% assign sorted_tags = site.tags | sort %}

{% for tag in sorted_tags %}
  <a class="btn btn--label" href="#{{ tag[0] | slugify }}"">
    <i class=" fa fa-tags" aria-hidden="true"></i> {{ tag[0] }} ({{ tag[1].size }})
  </a>
{% endfor %}

{% assign entries_layout = page.entries_layout | default: 'list' %}
{% for tag in sorted_tags %}
  <section id="{{ tag[0] | slugify | downcase }}" class="taxonomy__section">
  <h2 class="archive__subtitle"><i class="fa fa-tags" aria-hidden="true" style="margin-right:0.3em;"></i>{{ tag[0] }}({{ tag[1].size }})</h2>
  <div class="entries-{{ entries_layout }}">
    {% for post in tag.last %}
      {% include archive-single.html type=entries_layout %}
    {% endfor %}
  </div>
  </section>
{% endfor %}
```

{% endraw %}

As a comparison, the code to list post tags based on the number of posts is:

{% raw %}

```html
---
layout: archive
---

{{ content }}

{% assign tags_max = 0 %}
{% for tag in site.tags %}
  {% if tag[1].size > tags_max %}
    {% assign tags_max = tag[1].size %}
  {% endif %}
{% endfor %}

<div class="label-panel">
  {% for i in (1..tags_max) reversed %}
    {% for tag in site.tags %}
      {% if tag[1].size == i %}
      <a class = "btn btn--label" href="#{{ tag[0] | slugify }}"">
        <i class="fa fa-tags" aria-hidden="true"></i> {{ tag[0] }} ({{ i }})
      </a>
      {% endif %}
    {% endfor %}
  {% endfor %}
</div>

{% assign entries_layout = page.entries_layout | default: 'list' %}
{% for i in (1..tags_max) reversed %}
  {% for tag in site.tags %}
    {% if tag[1].size == i %}
      <section id="{{ tag[0] | slugify | downcase }}" class="taxonomy__section">
        <h2 class="archive__subtitle"><i class="fa fa-tags" aria-hidden="true" style="margin-right:0.3em;"></i>{{ tag[0] }} ({{ i }})</h2>
        <div class="entries-{{ entries_layout }}">
          {% for post in tag.last %}
            {% include archive-single.html type=entries_layout %}
          {% endfor %}
        </div>
      </section>
    {% endif %}
  {% endfor %}
{% endfor %}
```

{% endraw %}

<br>

**References**

[^1]: [How to list all posts for any given tag?](https://talk.jekyllrb.com/t/how-to-list-all-posts-for-any-given-tag/1402).
[^2]: [POSTS BY TAG](/tags/).
