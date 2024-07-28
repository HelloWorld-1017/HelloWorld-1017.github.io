---
title: "Three GitHub Repo Timestamps Obtained through REST API: `created_at`, `updated_at`, and `pushed_at` (including a simple introduction to ISO 8601)"
categories:
 - GitHub
tags:
 - JSON
 - REST API
date: 2024-07-28 16:03:22 +0800
last_modified_at: 2024-07-28 16:03:22 +0800
---

# `"created_at"`, `"updated_at"`, and `"pushed_at"`

In blog[^1], I record the way of obtaining information of a specific GitHub repository through REST API. The returned information is in JSON format, and in which there’re three key-value pairs concerning time:

```json
{
  // ...
  "created_at": "2022-07-16T07:16:20Z",
  "updated_at": "2024-06-27T15:17:36Z",
  "pushed_at": "2024-06-27T15:17:32Z",
  // ...
}
```

`"created_at"` shows when the repository was created. As for the difference between `pushed_at` and `updated_at`, Ivan Zuzak explains it on Stack Overflow[^2]:

The difference is that `pushed_at` represents the date and time of the **last commit**, whereas the `updated_at` represents the date and time of the **last change** the the repository. A change to the repository might be a commit, but it may also be other things, such as changing the description of the repo, creating wiki pages, etc. In other words, commits are a subset of updates, and **the `pushed_at` timestamp will therefore either be the same as the `updated_at` timestamp, or it will be an earlier timestamp**.
{: .quote--left}

The answer is very clear. And, as Tomáš Hübelbauer comments[^2], `updated_at` will update if the repo is starred by someone. I verify this point simply; it’s right. 

<br>

# ISO 8601

Above three timestamps adopt the same date format, i.e. <abbr title="International Organization for Standardization">ISO</abbr> 8601[^3]: `yyyy-mm-ddThh:mm:ssZ`, where:

- T is the time designator that precedes the time components of the representation.
- Z is the zone designator for the **zero** <abbr title="Coordinated Universal Time">UTC</abbr>[^4] offset.

<div class="notice--primary" markdown="1">

UTC+00:00[^5] is also known as:

- Greenwich Mean Time (GMT)
- Western European Time

<p><a href="https://commons.wikimedia.org/wiki/File:UTC%2B0000_-_2021.svg#/media/File:UTC+0000_-_2021.svg"><img src="https://upload.wikimedia.org/wikipedia/commons/e/e2/UTC%2B0000_-_2021.svg" alt="UTC+0000 - 2021.svg" width="1783"></a><br>By Theklan - <span class="int-own-work" lang="en">Own work</span>, <a href="http://creativecommons.org/publicdomain/zero/1.0/deed.en" title="Creative Commons Zero, Public Domain Dedication">CC0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=143021774">Link</a>.</p>

</div>

Different time zones adopt different UTC offsets, and they can be expressed in ISO 8601 date format like `yyyy-mm-ddThh:mm:ss+hh:mm` or `yyyy-mm-ddThh:mm:ss-hh:mm`. For example:

- Pacific Time Zone (North America, Log Angeles)[^7]

  - Pacific Standard Time (PST): `yyyy-mm-ddThh:mm:ss-08:00`
  - Pacific Daylight Time (PDT): `yyyy-mm-ddThh:mm:ss-07:00`
- New York Time (EST, Eastern Standard Time)[^6] 
  - Eastern Standard Time (EST): `yyyy-mm-ddThh:mm:ss−05:00`
  - Eastern Daylight Time (EDT): `yyyy-mm-ddThh:mm:ss−04:00`
- United Kingdom[^11]
  - Western European Time (a.k.a. GMT): `yyyy-mm-ddThh:mm:ssZ` or `yyyy-mm-ddThh:mm:ss+0000`
  - British Summer Time: `yyyy-mm-ddThh:mm:ss+0100`
- Central European Time (CET)[^12], used in Germany, France, Switzerland[^14], Belgium, Italy, Netherlands, Norway, Poland, Spain, Sweden, Denmark etc.
  - Central European Time (CET): `yyyy-mm-ddThh:mm:ss+0100`
  - Central European Summer Time (CEST)[^13]: `yyyy-mm-ddThh:mm:ss+0200`
- China Standard Time (CST), or Beijing Time (BJT)[^8]
  - `yyyy-mm-ddThh:mm:ss+08:00` (Daylight saving time has not been observed since 1991[^10].)
- Japan Standard Time (JST)[^9]
  - `yyyy-mm-ddThh:mm:ss+09:00` (Daylight saving time is not observed in this time zone.)

<br>

# In closing

What is mentioned before is sufficient for me to understand above three GitHub repo timestamps. By the way, during my process of looking for information, I found some useful websites for querying time or converting date format, such as: [Time.is](https://time.is/), [UTC Time Now](https://www.utctime.net/), [timeanddate.com](https://www.timeanddate.com/), and [Timestamp Converter](https://www.timestamp-converter.com/).

<br>

**References**

[^1]: [Get GitHub Repository Information through RESTful API - WHAT A STARRY NIGHT~](http://127.0.0.1:4000/2024-06-28/00-19-15.html#top).
[^2]: [https://stackoverflow.com/a/15922637/22763127.](https://stackoverflow.com/a/15922637/22763127.)
[^3]: [ISO 8601 - Wikipedia](https://en.wikipedia.org/wiki/ISO_8601).
[^4]: [Coordinated Universal Time - Wikipedia](https://en.wikipedia.org/wiki/Coordinated_Universal_Time).
[^5]: [UTC+00:00 - Wikipedia](https://en.wikipedia.org/wiki/UTC%2B00:00).

[^6]: [Eastern Time Zone - Wikipedia](https://en.wikipedia.org/wiki/Eastern_Time_Zone).
[^7]: [Pacific Time Zone - Wikipedia](https://en.wikipedia.org/wiki/Pacific_Time_Zone).
[^8]: [Time in China - Wikipedia](https://en.wikipedia.org/wiki/Time_in_China).
[^9]: [Japan Standard Time - Wikipedia](https://en.wikipedia.org/wiki/Japan_Standard_Time).
[^10]: [Daylight Saving Time 2024 in China](https://www.timeanddate.com/time/change/china).
[^11]: [Time in the United Kingdom - Wikipedia](https://en.wikipedia.org/wiki/Time_in_the_United_Kingdom).
[^12]: [Central European Time - Wikipedia](https://en.wikipedia.org/wiki/Central_European_Time).
[^13]: [Central European Summer Time - Wikipedia](https://en.wikipedia.org/wiki/Central_European_Summer_Time).
[^14]: [Time in Switzerland - Wikipedia](https://en.wikipedia.org/wiki/Time_in_Switzerland).
