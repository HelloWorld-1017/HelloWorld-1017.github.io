---
title: "Test Sidebar with Navigation List of Jekyll Theme Minimal Mistakes"
toc: false
classes: wide
categories:
 - Web Development
tags: 
 - Jekyll
 - Jekyll Minimal Mistakes
sidebar:
  title: "Sample Title"
  nav: sidebar-sample
date: 2022-08-18 11:36:13 +0800
last_modified_at: 2024-08-25 18:35:51 +0800
---

首先在根目录的 `_data/navigation.yml` 文件中写入：

```yaml
sidebar-sample:
  - title: "Parent Page A"
    children:
      - title: "Child Page A1"
        url: /
      - title: "Child Page A2"
        url: /
      - title: "Child Page A3"
        url: /
      - title: "Child Page A4"
        url: /
  - title: "Parent Page B"
    children:
      - title: "Child Page B1"
        url: /
      - title: "Child Page B2"
        url: /
      - title: "Child Page B3"
        url: /
      - title: "Child Page B4"
        url: /
      - title: "Child Page B5"
        url: /
  - title: "Parent Page C"
    children:
      - title: "Child Page C1"
        url: /
      - title: "Child Page C2"
        url: /
      - title: "Child Page C3"
        url: /
      - title: "Child Page C4"
        url: /
      - title: "Child Page C5"
        url: /
  - title: "Parent Page D"
    children:
      - title: "Child Page D1"
        url: /
      - title: "Child Page D2"
        url: /
```

之后，在`.md`文件的 YAML Front Matter 中写入：

```yaml
sidebar:
  title: "Sample Title"
  nav: sidebar-sample
```

<br>

**References**

[1] [Layout: Sidebar with Navigation List - Minimal Mistakes (mmistakes.github.io)](https://mmistakes.github.io/minimal-mistakes/layout-sidebar-nav-list/).