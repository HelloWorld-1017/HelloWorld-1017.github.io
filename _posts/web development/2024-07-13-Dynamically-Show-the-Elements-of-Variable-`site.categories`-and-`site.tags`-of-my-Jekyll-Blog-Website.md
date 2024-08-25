---
title: Elements in `site.categories` and `site.tags` of My Jekyll Blog Website
categories:
 - Web Development
tags:
 - Jekyll
date: 2024-07-13 15:59:18 +0800
last_modified_at: 2024-07-16 16:08:10 +0800
---

# `site.categories` elements

{% raw %}

```html
{% assign categories_max = 0 %}
{% for category in site.categories %}
 {% if category[1].size > categories_max %}
  {% assign categories_max = category[1].size %}
 {% endif %}
{% endfor %}

<ol>
{% for i in (1..categories_max) reversed %}
 {% for category in site.categories %}
  {% if category[1].size == i %}
  	<li>{{ category[0] }} ({{ i }})</li>
  {% endif %}
 {% endfor %}
{% endfor %}
</ol>
```

{% endraw %}

<br>

{% assign categories_max = 0 %}
{% for category in site.categories %}
 {% if category[1].size > categories_max %}
  {% assign categories_max = category[1].size %}
 {% endif %}
{% endfor %}

<ol>
{% for i in (1..categories_max) reversed %}
 {% for category in site.categories %}
  {% if category[1].size == i %}
  	<li>{{ category[0] }} ({{ i }})</li>
  {% endif %}
 {% endfor %}
{% endfor %}
</ol>

<br>

# `site.tags` elements

{% raw %}

```html
{% assign tags_max = 0 %}
{% for tag in site.tags %}
  {% if tag[1].size > tags_max %}
    {% assign tags_max = tag[1].size %}
  {% endif %}
{% endfor %}

<ol>
  {% for i in (1..tags_max) reversed %}
    {% for tag in site.tags %}
      {% if tag[1].size == i %}
      	<li> {{ tag[0] }} ({{ i }}) </li>
      {% endif %}
    {% endfor %}
  {% endfor %}
</ol>
```

{% endraw %}

<br>

{% assign tags_max = 0 %}
{% for tag in site.tags %}
  {% if tag[1].size > tags_max %}
    {% assign tags_max = tag[1].size %}
  {% endif %}
{% endfor %}

<ol>
  {% for i in (1..tags_max) reversed %}
    {% for tag in site.tags %}
      {% if tag[1].size == i %}
      	<li> {{ tag[0] }} ({{ i }}) </li>
      {% endif %}
    {% endfor %}
  {% endfor %}
</ol>

<br>

# References

[1] [minimal-mistakes/\_includes/posts-taxonomy.html at master · mmistakes/minimal-mistakes](https://github.com/mmistakes/minimal-mistakes/blob/master/_includes/posts-taxonomy.html).