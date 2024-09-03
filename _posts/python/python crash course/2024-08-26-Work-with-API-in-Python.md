---
title: "Takeaways from <i>Python Crash Course</i>: Work with API in Python"
categories:
 - Python
 - Web Development
 - GitHub
tags:
 - <i>Python Crash Course</i>
 - Native Python
 - Python Plotly
 - Python requests
 - Python json
 - GitHub API
 - JSON
date: 2024-08-26 22:00:40 +0800
last_modified_at: 2024-08-28 05:36:58 +0800
---

This post is a record made while learning Chapter 17 “Working with APIs” in Eric Matthes’s book, *Python Crash Course*.[^1]
{: .notice--primary}

# Web API

Sometimes in a program we could use a <i class="term">web application programming interface (API)</i> to automatically request specific information from a website---rather than entire pages---and then use that information to generate a visualization. Because programs written like this will always use <i class="emphasize">current data</i> to generate a visualization, even when that data might be rapidly changing, it will always be up to date.

A web API is a part of a website designed to <i class="emphasize">interact with programs</i>. Those programs use <i class="emphasize">very specific URLs</i> to <i class="term">request</i> certain information. This kind of request is called an <i class="term">API call</i>. The requested data will be returned in an easily processed format, such as JSON or CSV (based on my ever experience, the former accounts for the majority). Most apps that rely on <i class="emphasize">external data sources</i>, such as apps that integrate with social media sites, rely on API calls.

<br>

# GitHub web API

## Request data using an API call

GitHub’s API lets us request a wide range of information through API calls. For example, the call, [https://api.github.com/search/repositories?q=language:python&sort=stars](https://api.github.com/search/repositories?q=language:python&sort=stars), returns the number of Python projects currently hosted on GitHub and corresponding repo information. In this API call, 

- [`https://api.github.com/`](https://api.github.com/) directs the request to the part of GitHub that responds to API calls.
- `search/repositories` tells the API to conduct a search through all repositories on GitHub.
- The question mark `?` after `repositories` signals that we’re about to pass an argument. 
- The `q` stands for <i class="term">query</i>, and the equal sign `=` lets us begin specifying a query `q=`.
- `language:python` indicates that we want information only on repositories that have Python as the primary language.
- `&sort=stars` sorts the projects by the number of stars they’ve been acquired.

## Examine response

By `requests` package, here we can write code to automatically issue an API call and process the response:

```python
import requests

# Make an API call and store the response.
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars'
headers = {'Accept': 'application/vnd.github.v3+json'}
r = requests.get(url, headers=headers)
print(f"Status code: {r.status_code}")

# Examine the response dictionary
print(f"\nKeys in a response dictionary: {len(response_dict)}")
for key in response_dict.keys():
    print(key)
    
# Store API response in a variable.
response_dict = r.json()
print(f"\nTotal repositories: {response_dict['total_count']}")

# Explore information about the repositories.
repo_dicts = response_dict['items']
print(f"Repositories returned: {len(repo_dicts)}")

# Examine the first repository.
repo_dict = repo_dicts[0]
print(f"\nKeys in a repo dictionary: {len(repo_dict)}")
for key in sorted(repo_dict.keys()):
    print(key)
```

In the above script, the URL of the API call is stored in the `url` variable. Due to that GitHub is currently on the third version of its API, we define a HTTP headers `headers`[^7] to explicitly ask to use this version of the API. Then we use `requests` to make the call to the API: call `get()` method[^6] with the `url` and the `headers`, and then assign the <i class="term">response object</i> to the variable `r`. The response object has an attribute `status_code`, which tells us whether a request was made successful (A status code of `200` indicates a successful response). GitHub API will return the information in JSON format, so we then use the `json()` method to convert the response to a dictionary `response_dict`.

As will be shown, the response dictionary `response_dict` only contains three keys: `'total_count'`, `'incomplete_results'`, and `'items'`. 

- The value associated with `'total_count'` represents the total number of Python repositories on GitHub.
- Simple calls like this should return a complete set of results, so it’s safe to ignore the value associated with `'incomplete_results'`. But when making more complex API calls, we should consider checking this key.
- The value associated with `'items'` is a list containing a number of dictionaries, each of which contains data about an individual Python repository. We store this list of dictionaries in `repo_dicts`, and then print the length of `repo_dicts` to see how many repositories we have information for.

To look closer at the information returned about each repository, we pull out the first item from `repo_dicts` and store it in the variable `repo_dict`. Following results show that there are 80 keys in `repo_dict`. 

```
Status code: 200

Keys in a response dictionary: 3
total_count
incomplete_results
items

Total repositories: 15194717
Repositories returned: 30

Keys in a repo dictionary: 80
allow_forking
archive_url
archived
assignees_url
blobs_url
branches_url
clone_url
collaborators_url
comments_url
commits_url
compare_url
contents_url
contributors_url
created_at
default_branch
deployments_url
description
disabled
downloads_url
events_url
fork
forks
forks_count
forks_url
full_name
git_commits_url
git_refs_url
git_tags_url
git_url
has_discussions
has_downloads
has_issues
has_pages
has_projects
has_wiki
homepage
hooks_url
html_url
id
is_template
issue_comment_url
issue_events_url
issues_url
keys_url
labels_url
language
languages_url
license
merges_url
milestones_url
mirror_url
name
node_id
notifications_url
open_issues
open_issues_count
owner
private
pulls_url
pushed_at
releases_url
score
size
ssh_url
stargazers_count
stargazers_url
statuses_url
subscribers_url
subscription_url
svn_url
tags_url
teams_url
topics
trees_url
updated_at
url
visibility
watchers
watchers_count
web_commit_signoff_required
```

## Check for some values

We could print the values for a number of keys from the first repository’s dictionary, i.e. the most-starred Python project on GitHub as of this post.

```python
import requests

# Make an API call and store the response.
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars'
headers = {'Accept': 'application/vnd.github.v3+json'}
r = requests.get(url, headers=headers)
print(f"Status code: {r.status_code}")

# Store API response in a variable.
response_dict = r.json()
print(f"Total repositories: {response_dict['total_count']}")

# Explore information about the repositories.
repo_dicts = response_dict['items']
print(f"Repositories returned: {len(repo_dicts)}")

print("\nSelected information about first repository:")
print(f"Name: {repo_dict['name']}")
print(f"Owner: {repo_dict['owner']['login']}")
print(f"Stars: {repo_dict['stargazers_count']}")
print(f"Repository: {repo_dict['html_url']}")
print(f"Created: {repo_dict['created_at']}")
print(f"Updated: {repo_dict['updated_at']}")
print(f"Description: {repo_dict['description']}")
```

    Status code: 200
    Total repositories: 13077250
    Repositories returned: 30
    
    Selected information about first repository:
    Name: awesome-python
    Owner: vinta
    Stars: 216752
    Repository: https://github.com/vinta/awesome-python
    Created: 2014-06-27T21:00:06Z
    Updated: 2024-08-26T13:21:25Z
    Description: An opinionated list of awesome Python frameworks, libraries, software and resources.

## Summarize the top repositories


```python
import requests

# Make an API call and store the response.
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars'
headers = {'Accept': 'application/vnd.github.v3+json'}
r = requests.get(url, headers=headers)
print(f"Status code: {r.status_code}")

# Store API response in a variable.
response_dict = r.json()
print(f"Total repositories: {response_dict['total_count']}")

# Explore information about the repositories.
repo_dicts = response_dict['items']
print(f"Repositories returned: {len(repo_dicts)}")

print("\nSelected information about each repository:")
for repo_dict in repo_dicts:
    print("\nSelected information about first repository:")
    print(f"Name: {repo_dict['name']}")
    print(f"Owner: {repo_dict['owner']['login']}")
    print(f"Stars: {repo_dict['stargazers_count']}")
    print(f"Repository: {repo_dict['html_url']}")
    print(f"Created: {repo_dict['created_at']}")
    print(f"Updated: {repo_dict['updated_at']}")
    print(f"Description: {repo_dict['description']}")
```

    Status code: 200
    Total repositories: 14330565
    Repositories returned: 30
    
    Selected information about each repository:
    
    Selected information about first repository:
    Name: awesome-python
    Owner: vinta
    Stars: 216752
    Repository: https://github.com/vinta/awesome-python
    Created: 2014-06-27T21:00:06Z
    Updated: 2024-08-26T13:21:25Z
    Description: An opinionated list of awesome Python frameworks, libraries, software and resources.
    
    Selected information about first repository:
    Name: youtube-dl
    Owner: ytdl-org
    Stars: 130993
    Repository: https://github.com/ytdl-org/youtube-dl
    Created: 2010-10-31T14:35:07Z
    Updated: 2024-08-26T12:28:10Z
    Description: Command-line program to download videos from YouTube.com and other video sites
    
    Selected information about first repository:
    Name: yt-dlp
    Owner: yt-dlp
    Stars: 80920
    Repository: https://github.com/yt-dlp/yt-dlp
    Created: 2020-10-26T04:22:55Z
    Updated: 2024-08-26T13:03:09Z
    Description: A feature-rich command-line audio/video downloader
    
    Selected information about first repository:
    Name: whisper
    Owner: openai
    Stars: 66564
    Repository: https://github.com/openai/whisper
    Created: 2022-09-16T20:02:54Z
    Updated: 2024-08-26T13:04:27Z
    Description: Robust Speech Recognition via Large-Scale Weak Supervision
    
    Selected information about first repository:
    Name: gpt_academic
    Owner: binary-husky
    Stars: 63450
    Repository: https://github.com/binary-husky/gpt_academic
    Created: 2023-03-20T09:05:13Z
    Updated: 2024-08-26T12:36:04Z
    Description: 为GPT/GLM等LLM大语言模型提供实用化交互接口，特别优化论文阅读/润色/写作体验，模块化设计，支持自定义快捷按钮&函数插件，支持Python和C++等项目剖析&自译解功能，PDF/LaTex论文翻译&总结功能，支持并行问询多种LLM模型，支持chatglm3等本地模型。接入通义千问, deepseekcoder, 讯飞星火, 文心一言, llama2, rwkv, claude2, moss等。
    
    Selected information about first repository:
    Name: ansible
    Owner: ansible
    Stars: 62173
    Repository: https://github.com/ansible/ansible
    Created: 2012-03-06T14:58:02Z
    Updated: 2024-08-26T11:07:21Z
    Description: Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy and maintain. Automate everything from code deployment to network configuration to cloud management, in a language that approaches plain English, using SSH, with no agents to install on remote systems. https://docs.ansible.com.
    
    Selected information about first repository:
    Name: cpython
    Owner: python
    Stars: 61923
    Repository: https://github.com/python/cpython
    Created: 2017-02-10T19:23:51Z
    Updated: 2024-08-26T13:18:51Z
    Description: The Python programming language
    
    Selected information about first repository:
    Name: manim
    Owner: 3b1b
    Stars: 61546
    Repository: https://github.com/3b1b/manim
    Created: 2015-03-22T18:50:58Z
    Updated: 2024-08-26T12:34:16Z
    Description: Animation engine for explanatory math videos
    
    Selected information about first repository:
    Name: d2l-zh
    Owner: d2l-ai
    Stars: 60763
    Repository: https://github.com/d2l-ai/d2l-zh
    Created: 2017-08-23T04:40:24Z
    Updated: 2024-08-26T12:38:12Z
    Description: 《动手学深度学习》：面向中文读者、能运行、可讨论。中英文版被70多个国家的500多所大学用于教学。
    
    Selected information about first repository:
    Name: screenshot-to-code
    Owner: abi
    Stars: 55763
    Repository: https://github.com/abi/screenshot-to-code
    Created: 2023-11-14T17:53:32Z
    Updated: 2024-08-26T13:04:41Z
    Description: Drop in a screenshot and convert it to clean code (HTML/Tailwind/React/Vue)
    
    Selected information about first repository:
    Name: llama
    Owner: meta-llama
    Stars: 55229
    Repository: https://github.com/meta-llama/llama
    Created: 2023-02-14T09:29:12Z
    Updated: 2024-08-26T11:26:25Z
    Description: Inference code for Llama models
    
    Selected information about first repository:
    Name: sherlock
    Owner: sherlock-project
    Stars: 53971
    Repository: https://github.com/sherlock-project/sherlock
    Created: 2018-12-24T14:30:48Z
    Updated: 2024-08-26T13:22:55Z
    Description: Hunt down social media accounts by username across social networks
    
    Selected information about first repository:
    Name: openpilot
    Owner: commaai
    Stars: 49072
    Repository: https://github.com/commaai/openpilot
    Created: 2016-11-24T01:33:30Z
    Updated: 2024-08-26T09:04:44Z
    Description: openpilot is an operating system for robotics. Currently, it upgrades the driver assistance system in 275+ supported cars.
    
    Selected information about first repository:
    Name: big-list-of-naughty-strings
    Owner: minimaxir
    Stars: 46104
    Repository: https://github.com/minimaxir/big-list-of-naughty-strings
    Created: 2015-08-08T20:57:20Z
    Updated: 2024-08-26T06:49:29Z
    Description: The Big List of Naughty Strings is a list of strings which have a high probability of causing issues when used as user-input data.
    
    Selected information about first repository:
    Name: pandas
    Owner: pandas-dev
    Stars: 43078
    Repository: https://github.com/pandas-dev/pandas
    Created: 2010-08-24T01:37:33Z
    Updated: 2024-08-26T12:39:04Z
    Description: Flexible and powerful data analysis / manipulation library for Python, providing labeled data structures similar to R data.frame objects, statistical functions, and much more
    
    Selected information about first repository:
    Name: 30-Days-Of-Python
    Owner: Asabeneh
    Stars: 40528
    Repository: https://github.com/Asabeneh/30-Days-Of-Python
    Created: 2019-11-19T17:24:16Z
    Updated: 2024-08-26T13:09:57Z
    Description: 30 days of Python programming challenge is a step-by-step guide to learn the Python programming language in 30 days. This challenge may take more than100 days, follow your own pace.  These videos may help too: https://www.youtube.com/channel/UC7PNRuno1rzYPb1xLa4yktw
    
    Selected information about first repository:
    Name: Fooocus
    Owner: lllyasviel
    Stars: 39606
    Repository: https://github.com/lllyasviel/Fooocus
    Created: 2023-08-09T18:43:40Z
    Updated: 2024-08-26T11:03:39Z
    Description: Focus on prompting and generating
    
    Selected information about first repository:
    Name: text-generation-webui
    Owner: oobabooga
    Stars: 39175
    Repository: https://github.com/oobabooga/text-generation-webui
    Created: 2022-12-21T04:17:37Z
    Updated: 2024-08-26T12:33:41Z
    Description: A Gradio web UI for Large Language Models.
    
    Selected information about first repository:
    Name: bert
    Owner: google-research
    Stars: 37718
    Repository: https://github.com/google-research/bert
    Created: 2018-10-25T22:57:34Z
    Updated: 2024-08-26T08:30:03Z
    Description: TensorFlow code and pre-trained models for BERT
    
    Selected information about first repository:
    Name: FastChat
    Owner: lm-sys
    Stars: 36257
    Repository: https://github.com/lm-sys/FastChat
    Created: 2023-03-19T00:18:02Z
    Updated: 2024-08-26T12:48:42Z
    Description: An open platform for training, serving, and evaluating large language models. Release repo for Vicuna and Chatbot Arena.
    
    Selected information about first repository:
    Name: nanoGPT
    Owner: karpathy
    Stars: 35879
    Repository: https://github.com/karpathy/nanoGPT
    Created: 2022-12-28T00:51:12Z
    Updated: 2024-08-26T10:18:52Z
    Description: The simplest, fastest repository for training/finetuning medium-sized GPTs.
    
    Selected information about first repository:
    Name: GFPGAN
    Owner: TencentARC
    Stars: 35398
    Repository: https://github.com/TencentARC/GFPGAN
    Created: 2021-03-19T06:18:20Z
    Updated: 2024-08-26T12:14:53Z
    Description: GFPGAN aims at developing Practical Algorithms for Real-world Face Restoration.
    
    Selected information about first repository:
    Name: DeepSpeed
    Owner: microsoft
    Stars: 34478
    Repository: https://github.com/microsoft/DeepSpeed
    Created: 2020-01-23T18:35:18Z
    Updated: 2024-08-26T12:20:40Z
    Description: DeepSpeed is a deep learning optimization library that makes distributed training and inference easy, efficient, and effective.
    
    Selected information about first repository:
    Name: gym
    Owner: openai
    Stars: 34409
    Repository: https://github.com/openai/gym
    Created: 2016-04-27T14:59:16Z
    Updated: 2024-08-26T12:25:37Z
    Description: A toolkit for developing and comparing reinforcement learning algorithms.
    
    Selected information about first repository:
    Name: WeChatMsg
    Owner: LC044
    Stars: 32589
    Repository: https://github.com/LC044/WeChatMsg
    Created: 2023-01-11T05:03:49Z
    Updated: 2024-08-26T13:05:05Z
    Description: 提取微信聊天记录，将其导出成HTML、Word、Excel文档永久保存，对聊天记录进行分析生成年度聊天报告，用聊天数据训练专属于个人的AI聊天助手
    
    Selected information about first repository:
    Name: gradio
    Owner: gradio-app
    Stars: 31748
    Repository: https://github.com/gradio-app/gradio
    Created: 2018-12-19T08:24:04Z
    Updated: 2024-08-26T11:34:53Z
    Description: Build and share delightful machine learning apps, all in Python. 🌟 Star to support our work!
    
    Selected information about first repository:
    Name: sqlmap
    Owner: sqlmapproject
    Stars: 31733
    Repository: https://github.com/sqlmapproject/sqlmap
    Created: 2012-06-26T09:52:15Z
    Updated: 2024-08-26T12:49:37Z
    Description: Automatic SQL injection and database takeover tool
    
    Selected information about first repository:
    Name: certbot
    Owner: certbot
    Stars: 31243
    Repository: https://github.com/certbot/certbot
    Created: 2014-11-12T02:52:20Z
    Updated: 2024-08-26T10:54:16Z
    Description: Certbot is EFF's tool to obtain certs from Let's Encrypt and (optionally) auto-enable HTTPS on your server.  It can also act as a client for any other CA that uses the ACME protocol.
    
    Selected information about first repository:
    Name: poetry
    Owner: python-poetry
    Stars: 30907
    Repository: https://github.com/python-poetry/poetry
    Created: 2018-02-28T15:23:47Z
    Updated: 2024-08-26T12:01:26Z
    Description: Python packaging and dependency management made easy
    
    Selected information about first repository:
    Name: detectron2
    Owner: facebookresearch
    Stars: 29816
    Repository: https://github.com/facebookresearch/detectron2
    Created: 2019-09-05T21:30:20Z
    Updated: 2024-08-26T12:31:23Z
    Description: Detectron2 is a platform for object detection, segmentation and other visual recognition tasks.

## Monitor API rate limits

Most APIs are rate limited, which means there’s a limit to how many requests we can make in a certain amount of time. By URL [https://api.github.com/rate\_limit](https://api.github.com/rate_limit), we can check out if we’re approaching GitHub’s limits:


```python
import requests
import json

# Make an API call, and store the response.
url = 'https://api.github.com/rate_limit'
r = requests.get(url)
print(f"Status code: {r.status_code}")

# Explore the structure of the data.
response_dict = r.json()
readable_file = 'readable_gt_data.json'
with open(readable_file, 'w') as f:
    json.dump(json_data, f, indent=4)
```

```json
{
    "resources": {
        "core": {
            "limit": 60,
            "remaining": 52,
            "reset": 1724683438,
            "used": 8,
            "resource": "core"
        },
        "graphql": {
            "limit": 0,
            "remaining": 0,
            "reset": 1724683757,
            "used": 0,
            "resource": "graphql"
        },
        "integration_manifest": {
            "limit": 5000,
            "remaining": 5000,
            "reset": 1724683757,
            "used": 0,
            "resource": "integration_manifest"
        },
        "search": {
            "limit": 10,
            "remaining": 10,
            "reset": 1724680217,
            "used": 0,
            "resource": "search"
        }
    },
    "rate": {
        "limit": 60,
        "remaining": 52,
        "reset": 1724683438,
        "used": 8,
        "resource": "core"
    }
}
```

The information we’re interested in is the rate limit for the search API, that is the values of `"search"` key in the `"resources"` key. At this point, the limit is 10 requests per minute and that we have 10 requests remaining for the current minute. The `"reset"` key represents the time in Unix or epoch time (the number of seconds since midnight on January 1, 1970) when our quota will reset. If we reach our quota, we’ll get a short response informing that we’ve reached the API limit, and then all we need is to wait until the quota resets.

Many APIs require us to register and obtain an API key to make API calls. As of this post, GitHub has no such requirement, but if we request through an API key, we’ll have a higher rate limit.

<br>

# Visualize repositories using Plotly

## Basic Plotly chart


```python
import requests
from plotly.graph_objs import Bar
from plotly import offline

# Make an API call and store the response.
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars'
headers = {'Accept': 'application/vnd.github.v3+json'}
r = requests.get(url, headers=headers)
print(f"Status code: {r.status_code}")

# Process results.
response_dict = r.json()
repo_dicts = response_dict['items']
repo_names, stars = [], []
for repo_dict in repo_dicts:
    repo_names.append(repo_dict['name'])
    stars.append(repo_dict['stargazers_count'])

# Make visualization.
data = [{
    'type': 'bar',
    'x': repo_names,
    'y': stars,
}]

my_layout = {
    'title': 'Most-Starred Python Projects on GitHub',
    'xaxis': {'title': 'Repository'},
    'yaxis': {'title': 'Stars'},
    }

fig = {
    'data': data,
    'layout': my_layout,
    }
offline.plot(fig, filename='python_repos.html')
```

Webpage [`python_repos.html`](/webpages/2024-08-26/python_repos.html) shows the resulting chart.

## Refine the chart

We can include all the styling directives as key-value pairs in the `data` and `my_layout` dictionaries.


```python
import requests
from plotly.graph_objs import Bar
from plotly import offline

# Make an API call and store the response.
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars'
headers = {'Accept': 'application/vnd.github.v3+json'}
r = requests.get(url, headers=headers)
print(f"Status code: {r.status_code}")

# Process results.
response_dict = r.json()
repo_dicts = response_dict['items']
repo_names, stars = [], []
for repo_dict in repo_dicts:
    repo_names.append(repo_dict['name'])
    stars.append(repo_dict['stargazers_count'])

# Make visualization.
data = [{
    'type': 'bar',
    'x': repo_names,
    'y': stars,
    'marker': {
        'color': 'rgb(60, 100, 150)',
        'line': {
            'width': 1.5,
            'color': 'rgb(25, 25, 25)',
            },
        },
    }]

my_layout = {
    'title': 'Most-Starred Python Projects on GitHub',
    'titlefont': {'size': 28},
    'xaxis': {
        'title': 'Repository',
        'titlefont': {'size': 24},
        'tickfont': {'size': 14},
        },
    'yaxis': {
        'title': 'Stars',
        'titlefont': {'size': 24},
        'tickfont': {'size': 14},
        },
    }

fig = {
    'data': data,
    'layout': my_layout
    }
offline.plot(fig, filename='python_repos1.html')
```

The resulting [`python_repos1.html`](/webpages/2024-08-26/python_repos1.html) shows the restyled chart.

## Add hover text (a.k.a. tooltip)

Then, we can add some informative hover text, commonly called a <i class="term">tooltip</i>.


```python
import requests
from plotly.graph_objs import Bar
from plotly import offline

# Make an API call and store the response.
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars'
headers = {'Accept': 'application/vnd.github.v3+json'}
r = requests.get(url, headers=headers)
print(f"Status code: {r.status_code}")

# Process results.
response_dict = r.json()
repo_dicts = response_dict['items']
repo_names, stars, labels = [], [], []
for repo_dict in repo_dicts:
    repo_names.append(repo_dict['name'])
    stars.append(repo_dict['stargazers_count'])
    
    owner = repo_dict['owner']['login']
    description = repo_dict['description']
    label = f"{owner}<br />{description}"
    labels.append(label)

# Make visualization.
data = [{
    'type': 'bar',
    'x': repo_names,
    'y': stars,
    'hovertext': labels,
    'marker': {
        'color': 'rgb(60, 100, 150)',
        'line': {
            'width': 1.5,
            'color': 'rgb(25, 25, 25)',
            },
        },
    }]

my_layout = {
    'title': 'Most-Starred Python Projects on GitHub',
    'titlefont': {'size': 28},
    'xaxis': {
        'title': 'Repository',
        'titlefont': {'size': 24},
        'tickfont': {'size': 14},
    },
    'yaxis': {
        'title': 'Stars',
        'titlefont': {'size': 24},
        'tickfont': {'size': 14},
    },
}

fig = {
    'data': data,
    'layout': my_layout,
    }
offline.plot(fig, filename='python_repos2.html')
```

Then, we have [`python_repos2.html`](/webpages/2024-08-26/python_repos2.html).

## Add clickable links to the x-axis labels

Use the x-axis labels as a way to let the viewer visit any project’s home page on GitHub.

```python
import requests
from plotly.graph_objs import Bar
from plotly import offline

# Make an API call and store the response.
url = 'https://api.github.com/search/repositories?q=language:python&sort=stars'
headers = {'Accept': 'application/vnd.github.v3+json'}
r = requests.get(url, headers=headers)
print(f"Status code: {r.status_code}")

# Process results.
response_dict = r.json()
repo_dicts = response_dict['items']
repo_links, stars, labels = [], [], []
for repo_dict in repo_dicts:
    repo_name = repo_dict['name']
    repo_url = repo_dict['html_url']
    repo_link = f"<a href='{repo_url}'>{repo_name}</a>"
    repo_links.append(repo_link)
    
    stars.append(repo_dict['stargazers_count'])
    
    owner = repo_dict['owner']['login']
    description = repo_dict['description']
    label = f"{owner}<br />{description}"
    labels.append(label)

# Make visualization.
data = [{
    'type': 'bar',
    'x': repo_links,
    'y': stars,
    'hovertext': labels,
    'marker': {
        'color': 'rgb(60, 100, 150)',
        'line': {
            'width': 1.5,
            'color': 'rgb(25, 25, 25)',
            },
        },
    }]

my_layout = {
    'title': 'Most-Starred Python Projects on GitHub',
    'titlefont': {'size': 28},
    'xaxis': {
        'title': 'Repository',
        'titlefont': {'size': 24},
        'tickfont': {'size': 14},
    },
    'yaxis': {
        'title': 'Stars',
        'titlefont': {'size': 24},
        'tickfont': {'size': 14},
    },
}

fig = {
    'data': data,
    'layout': my_layout
    }
offline.plot(fig, filename='python_repos3.html')
```

The corresponding chart shows in [`python_repos3.html`](/webpages/2024-08-26/python_repos3.html). Now we can click any of the project names at the bottom of the chart to visit that project’s home page on GitHub. 

## More about Plotly and the GitHub API

To know more about working with Plotly charts, there are two good places to start: Python Plotly User Guide[^3] and figure reference[^4], which lists all the settings we can use to configure Plotly visualizations, including all the possible <i class="emphasize">chart types</i> as well as the <i class="emphasize">attributes</i> we can set for every configuration option.

As for the GitHub API, the most important reference is its official documentation[^5].

<br>

# The Hacker News API

On [Hacker News](http://news.ycombinator.com/), people share articles about programming and technology, and engage in lively discussions about those articles. The Hacker News API[^8][^9] provides access to data about all submissions and comments on the site, and we can use the API without having to register for a key.

Take an article, [https://hacker-news.firebaseio.com/v0/item/19155826.json](https://hacker-news.firebaseio.com/v0/item/19155826.json), as an example. 


```python
import requests
import json

# Make an API call, and store the response.
url = 'https://hacker-news.firebaseio.com/v0/item/19155826.json'
r = requests.get(url)
print(f"Status code: {r.status_code}")

# Explore the structure of the data.
response_dict = r.json()
readable_file = 'readable_hn_data.json'
with open(readable_file, 'w') as f:
    json.dump(response_dict, f, indent=4)
```

    Status code: 200

We can get a dictionary of information `response_dict` about the article with the ID `19155826`, and after converting it to JSON format, we have:

```json
{
    "by": "jimktrains2",
    "descendants": 221,
    "id": 19155826,
    "kids": [
        19156572,
        19158857,
        19156773,
        19157251,
        19156415,
        19159820,
        19157154,
        19156385,
        19156489,
        19158522,
        19156755,
        19156974,
        19158319,
        19157034,
        19156935,
        19158935,
        19157531,
        19158638,
        19156466,
        19156758,
        19156565,
        19156498,
        19156335,
        19156041,
        19156704,
        19159047,
        19159127,
        19156217,
        19156375,
        19157945
    ],
    "score": 728,
    "time": 1550085414,
    "title": "Nasa\u2019s Mars Rover Opportunity Concludes a 15-Year Mission",
    "type": "story",
    "url": "https://www.nytimes.com/2019/02/13/science/mars-opportunity-rover-dead.html"
}
```

The key `'descendants'` tells us the number of comments the article has received. The key `'kids'` provides the IDs of all comments made directly in response to this submission. Each of these comments might have comments of their own as well, so the number of descendants a submission has is usually greater than its number of kids.

The URL, [https://hacker-news.firebaseio.com/v0/topstories.json](https://hacker-news.firebaseio.com/v0/topstories.json), returns a simple list of all the IDs of the current top articles on Hacker News. We can use this call to find out which articles are on the home page right now, and then generate a series of API calls similar to the one we just examined. With this approach, we can print a summary of all the articles on the front page of Hacker News at this moment:


```python
from operator import itemgetter
import requests

# Make an API call and store the response.
url = 'https://hacker-news.firebaseio.com/v0/topstories.json'
r = requests.get(url)
print(f"Status code: {r.status_code}")

# Process information about each submission.
submission_ids = r.json()
submission_dicts = []
for submission_id in submission_ids[:30]:
    # Make a separate API call for each submission.
    url = f"https://hacker-news.firebaseio.com/v0/item/{submission_id}.json"
    r = requests.get(url)
    print(f"id: {submission_id}\tstatus: {r.status_code}")
    response_dict = r.json()
    
    # Build a dictionary for each article.
    submission_dict = {
        'title': response_dict['title'],
        'hn_link': f"http://news.ycombinator.com/item?id={submission_id}",
        'comments': response_dict['descendants'],
    }
    submission_dicts.append(submission_dict)

submission_dicts = sorted(submission_dicts, key=itemgetter('comments'),
                          reverse=True)

for submission_dict in submission_dicts:
    print(f"\nTitle: {submission_dict['title']}")
    print(f"Discussion link: {submission_dict['hn_link']}")
    print(f"Comments: {submission_dict['comments']}")
```

Submitted articles on Hacker News are ranked according to <i class="emphasize">an overall score</i> based on a number of factors including how many times it’s been voted up, how many comments it’s received, and how recent the submission is. If we want to sort the list of dictionaries <i class="emphasize">by the number of comments</i>, we could use a function `itemgetter()`[^11] from the `operator` module[^10]. We pass this function the key `'comments'`, and it pulls the value associated with that key from each dictionary in the list. The `sorted()` function then uses this value as its basis for sorting the list. We sort the list <i class="emphasize">in reverse order</i> to place the most-commented stories first.

    Status code: 200
    id: 41343826	status: 200
    id: 41342017	status: 200
    id: 41342637	status: 200
    id: 41343814	status: 200
    id: 41344004	status: 200
    id: 41344176	status: 200
    id: 41314492	status: 200
    id: 41338354	status: 200
    id: 41341786	status: 200
    id: 41336762	status: 200
    id: 41343924	status: 200
    id: 41327933	status: 200
    id: 41341797	status: 200
    id: 41310334	status: 200
    id: 41339308	status: 200
    id: 41343444	status: 200
    id: 41336497	status: 200
    id: 41337356	status: 200
    id: 41338776	status: 200
    id: 41338661	status: 200
    id: 41311416	status: 200
    id: 41310319	status: 200
    id: 41339818	status: 200
    id: 41341817	status: 200
    id: 41310085	status: 200
    id: 41309997	status: 200
    id: 41339667	status: 200
    id: 41343024	status: 200
    id: 41338729	status: 200
    id: 41302950	status: 200
    
    Title: Ask HN: What are you working on (August 2024)?
    Discussion link: http://news.ycombinator.com/item?id=41342017
    Comments: 768
    
    Title: NASA announces Boeing Starliner crew will return on SpaceX Crew-9
    Discussion link: http://news.ycombinator.com/item?id=41339667
    Comments: 610
    
    Title: You are not dumb, you just lack the prerequisites
    Discussion link: http://news.ycombinator.com/item?id=41338354
    Comments: 246
    
    Title: Hot Page – a graphical site builder
    Discussion link: http://news.ycombinator.com/item?id=41337356
    Comments: 89
    
    Title: Defenders think in lists, attackers think in graphs (2015)
    Discussion link: http://news.ycombinator.com/item?id=41342637
    Comments: 81
    
    Title: Small Strings in Rust: smolstr vs. smartstring
    Discussion link: http://news.ycombinator.com/item?id=41338776
    Comments: 70
    
    Title: Windows 0-day was exploited by North Korea to install advanced rootkit
    Discussion link: http://news.ycombinator.com/item?id=41302950
    Comments: 69
    
    Title: "YOLO" is not a valid hash construction
    Discussion link: http://news.ycombinator.com/item?id=41310319
    Comments: 65
    
    Title: Looming Liability Machines (LLMs)
    Discussion link: http://news.ycombinator.com/item?id=41343024
    Comments: 63
    
    Title: Anthropic Claude 3.5 can create icalendar files, so I did this
    Discussion link: http://news.ycombinator.com/item?id=41343826
    Comments: 55
    
    Title: Golang Interpreter Written in PHP
    Discussion link: http://news.ycombinator.com/item?id=41339818
    Comments: 49
    
    Title: Show HN: Visualize database schemas with a single query
    Discussion link: http://news.ycombinator.com/item?id=41339308
    Comments: 45
    
    Title: Ruby's official documentation just got a new look
    Discussion link: http://news.ycombinator.com/item?id=41344004
    Comments: 33
    
    Title: ArcticDB: Why a Hedge Fund Built Its Own Database
    Discussion link: http://news.ycombinator.com/item?id=41309997
    Comments: 32
    
    Title: Papersway – a scrollable window management for Sway/i3wm
    Discussion link: http://news.ycombinator.com/item?id=41341797
    Comments: 30
    
    Title: Birds aren't real – how to create your own "bird"
    Discussion link: http://news.ycombinator.com/item?id=41341817
    Comments: 26
    
    Title: AMD's Radeon 890M: Strix Point's Bigger iGPU
    Discussion link: http://news.ycombinator.com/item?id=41341786
    Comments: 23
    
    Title: Postgres as a Search Engine
    Discussion link: http://news.ycombinator.com/item?id=41343814
    Comments: 20
    
    Title: Serpent OS Prealpha0 Released
    Discussion link: http://news.ycombinator.com/item?id=41343444
    Comments: 19
    
    Title: Shell.how: Explain Shell Commands
    Discussion link: http://news.ycombinator.com/item?id=41336497
    Comments: 19
    
    Title: Techniques for safe garbage collection in Rust
    Discussion link: http://news.ycombinator.com/item?id=41311416
    Comments: 19
    
    Title: Consistently Making Wrong Decisions Whilst Writing Recreational C
    Discussion link: http://news.ycombinator.com/item?id=41336762
    Comments: 18
    
    Title: Julius: Open-source reimplementation of Caesar III
    Discussion link: http://news.ycombinator.com/item?id=41338661
    Comments: 15
    
    Title: Generating Mazes
    Discussion link: http://news.ycombinator.com/item?id=41327933
    Comments: 14
    
    Title: Neurotechnology numbers worth knowing (2022)
    Discussion link: http://news.ycombinator.com/item?id=41344176
    Comments: 8
    
    Title: Implementing React from Scratch
    Discussion link: http://news.ycombinator.com/item?id=41338729
    Comments: 7
    
    Title: Transferring energy from nitrogen to argon enables 2-way cascaded lasing in air
    Discussion link: http://news.ycombinator.com/item?id=41343924
    Comments: 5
    
    Title: Degrees of Kevin Bacon Using Postgres
    Discussion link: http://news.ycombinator.com/item?id=41314492
    Comments: 4
    
    Title: An introduction to the remontoire
    Discussion link: http://news.ycombinator.com/item?id=41310085
    Comments: 1
    
    Title: A 4096 channel event-based multielectrode array with asynchronous outputs
    Discussion link: http://news.ycombinator.com/item?id=41310334
    Comments: 0

However, if we encounter an article that has no comment when running the script, an error will be raised:

```
Status code: 200
id: 41355021	status: 200
id: 41355303	status: 200
id: 41353328	status: 200
id: 41356483	status: 200
id: 41353835	status: 200
id: 41356382	status: 200
id: 41356310	status: 200
---------------------------------------------------------------------------
KeyError                                  Traceback (most recent call last)
Cell In[3], line 23
     17     response_dict = r.json()
     19     # Build a dictionary for each article.
     20     submission_dict = {
     21         'title': response_dict['title'],
     22         'hn_link': f"http://news.ycombinator.com/item?id={submission_id}",
---> 23         'comments': response_dict['descendants'],
     24     }
     25     submission_dicts.append(submission_dict)
     27 submission_dicts = sorted(submission_dicts, key=itemgetter('comments'),
     28                           reverse=True)

KeyError: 'descendants'
```

We can choose to skip over this kind of articles using a `try-except-else` block:

```python
# ...
for submission_id in submission_ids[:30]:
    # ...
    
    # Build a dictionary for each article.
    try:
        submission_dict = {
            'title': response_dict['title'],
            'hn_link': f"http://news.ycombinator.com/item?id={submission_id}",
            'comments': response_dict['descendants'],
        }
    except KeyError:
        print(f"http://news.ycombinator.com/item?id={submission_id}")
    else:
        submission_dicts.append(submission_dict)

# ...
```

```
Status code: 200
id: 41364549	status: 200
id: 41338240	status: 200
id: 41346530	status: 200
id: 41346001	status: 200
id: 41365714	status: 200
id: 41346201	status: 200
id: 41366602	status: 200
http://news.ycombinator.com/item?id=41366602
id: 41366304	status: 200
id: 41358020	status: 200
id: 41356528	status: 200
id: 41364783	status: 200
id: 41365637	status: 200
id: 41361281	status: 200
id: 41364412	status: 200
id: 41336462	status: 200
id: 41338946	status: 200
id: 41365157	status: 200
id: 41366064	status: 200
id: 41363943	status: 200
id: 41365598	status: 200
id: 41363499	status: 200
id: 41365223	status: 200
id: 41337927	status: 200
id: 41364776	status: 200
id: 41354804	status: 200
id: 41366436	status: 200
id: 41355303	status: 200
id: 41358490	status: 200
id: 41347388	status: 200
id: 41347051	status: 200

Title: Dokku: My favorite personal serverless platform
Discussion link: http://news.ycombinator.com/item?id=41358020
Comments: 246

Title: NSA releases 1982 Grace Hopper lecture
Discussion link: http://news.ycombinator.com/item?id=41356528
Comments: 182

Title: Fixing a bug in Google Chrome as a first-time contributor
Discussion link: http://news.ycombinator.com/item?id=41355303
Comments: 149

Title: Show HN: Remove-bg – open-source remove background using WebGPU
Discussion link: http://news.ycombinator.com/item?id=41358490
Comments: 104

Title: Vim Racer
Discussion link: http://news.ycombinator.com/item?id=41347051
Comments: 69

Title: Box64 and RISC-V in 2024: What It Takes to Run the Witcher 3 on RISC-V
Discussion link: http://news.ycombinator.com/item?id=41364549
Comments: 55

Title: Notes on Buttondown.com
Discussion link: http://news.ycombinator.com/item?id=41364783
Comments: 48

Title: Tinybox of tinygrad by George Hotz is finally entering production
Discussion link: http://news.ycombinator.com/item?id=41365637
Comments: 44

Title: Erasure Coding for Distributed Systems
Discussion link: http://news.ycombinator.com/item?id=41361281
Comments: 42

Title: Clojure Desktop UI Framework
Discussion link: http://news.ycombinator.com/item?id=41336462
Comments: 41

Title: Sovereign Tech Fund to Invest €686k in FreeBSD Infrastructure Modernization
Discussion link: http://news.ycombinator.com/item?id=41364776
Comments: 40

Title: Why has Japan been hit with rice shortages, soaring prices despite normal crops?
Discussion link: http://news.ycombinator.com/item?id=41366304
Comments: 31

Title: Deliberate Practice and Acquisition of Expert Performance: A General Overview
Discussion link: http://news.ycombinator.com/item?id=41347388
Comments: 29

Title: Firewalling Your Code
Discussion link: http://news.ycombinator.com/item?id=41338240
Comments: 26

Title: Predicting the Future of Distributed Systems
Discussion link: http://news.ycombinator.com/item?id=41363499
Comments: 26

Title: Out of Your Head
Discussion link: http://news.ycombinator.com/item?id=41337927
Comments: 22

Title: RISC-V CPU arrives on a tablet starting at $149
Discussion link: http://news.ycombinator.com/item?id=41365223
Comments: 19

Title: Clay (short for C Layout) is a high performance 2D UI layout library
Discussion link: http://news.ycombinator.com/item?id=41338946
Comments: 18

Title: Vanilla Prime: A simpler, more sustainable way of web development
Discussion link: http://news.ycombinator.com/item?id=41365714
Comments: 17

Title: FreeBSD-rustdate, a reimplementation of FreeBSD-update
Discussion link: http://news.ycombinator.com/item?id=41364412
Comments: 14

Title: Attempting to Use GNU Guix (2019)
Discussion link: http://news.ycombinator.com/item?id=41354804
Comments: 14

Title: Ruby in Jupyter Notebook
Discussion link: http://news.ycombinator.com/item?id=41346201
Comments: 13

Title: 2023 state of the climate Entering uncharted territory
Discussion link: http://news.ycombinator.com/item?id=41365598
Comments: 12

Title: How to run Valgrind on a CGI program in C
Discussion link: http://news.ycombinator.com/item?id=41346001
Comments: 9

Title: The possibilities for dark matter have just shrunk – by a lot
Discussion link: http://news.ycombinator.com/item?id=41366064
Comments: 7

Title: How do you make safe, cheap nuclear reactors? Bury them a mile deep
Discussion link: http://news.ycombinator.com/item?id=41366436
Comments: 4

Title: Run System Commands in Ruby – When to use which methods to run shell commands
Discussion link: http://news.ycombinator.com/item?id=41365157
Comments: 3

Title: Parochialism in Time and Space (2021)
Discussion link: http://news.ycombinator.com/item?id=41346530
Comments: 1

Title: Qualcomm Oryon CPU Core Design
Discussion link: http://news.ycombinator.com/item?id=41363943
Comments: 0
```

Printing messages show that in this case there’s only one article, [http://news.ycombinator.com/item?id=41366602](http://news.ycombinator.com/item?id=41366602), with no comment, as follows:

![screencapture-news-ycombinator-item-2024-08-27-20_31_13](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202408272035524.png)

**References**

[^1]: [Python Crash Course: A Hands-on, Project-based Introduction to Programming (Second Edition)](https://khwarizmi.org/wp-content/uploads/2021/04/Eric_Matthes_Python_Crash_Course_A_Hands.pdf), Eric Matthes, pp. 359-375.
[^3]: [Creating and updating figures in Python](https://plot.ly/python/creating-and-updating-figures/).
[^4]: [Single-page reference in Python](https://plot.ly/python/reference/).
[^5]: [GitHub REST API documentation - GitHub Docs](https://docs.github.com/en/rest).

[^6]: [Python Requests get Method](https://www.w3schools.com/python/ref_requests_get.asp).
[^7]: [HTTP headers - HTTP \| MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers)
[^8]: [Hacker News Official API \| Hacker News](https://news.ycombinator.com/item?id=32540883).
[^9]: [HackerNews/API - GitHub](https://github.com/HackerNews/API).
[^10]: [operator — Standard operators as functions — Python 3.12.5 documentation](https://docs.python.org/3/library/operator.html).
[^11]: [operator: `operator.itemgetter()` — Standard operators as functions — Python 3.12.5 documentation](https://docs.python.org/3/library/operator.html#operator.itemgetter).
