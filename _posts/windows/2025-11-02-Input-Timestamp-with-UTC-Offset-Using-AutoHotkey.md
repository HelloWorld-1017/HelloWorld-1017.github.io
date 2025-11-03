---
title: Input Timestamp with UTC Offset Using AutoHotkey
toc: false
categories:
 - Windows
 - Web Development
tags:
 - Jekyll
location: Buffalo, United States
date: 2025-11-02 10:51:48 -0500
last_modified_at: 2025-11-02 21:39:48 -0500
---

Due to that when I writing a blog (hosted on Jekyll website), I need to input a `date` information in Front Matter block, to quickly input current time (i.e., timestamp), before I defined an Chinese Pinyin phrase `ct` as `%yyyy%-%MM%-%dd% %HH%:%mm%:%ss% -0400` in Microsoft Pinyin Input Methods[^2] according to walterlv's blog[^1]. However, this method has two problems:

1. The time zone information, i.e., zero UTC offset[^3] `-0400` is fixed, because this is no way, like using variables in `%yyyy%-%MM%-%dd% %HH%:%mm%:%ss%`, to obtain this information from Windows system in Microsoft Pinyin Input Method. So, if I move to another time zone, I need to modify this self-defined phrase again.
2. As reported in walterlv's blog[^1] (actually I ever found this bug before), once above phrase `ct` is defined with time variables, if I edit this phrase next time, variables won't work any more --- it will become a fixed time ---  I need to redefine this phrase using variables again.

Today (2:00 am, Sunday, November 2, 2025), the time of NY state changed from EST to EDT, i.e., 1 hour backward[^3][^4]; I have to modify the UTC offset from `-0400` to `-0500` accordingly, so above two problems annoyed me again.

As mentioned, actually there is no a variable corresponding to UTC offset in MS Pinyin input, so I have to find another method. Finally, I decided to use software AutoHotkey[^5]. 

A Reddit user provides such a way[^6], i.e., using a shortcut key `Win+;` to input the timestamp:

```
#;::{
    SendText(FormatTime(,"ShortDate"))
}
```

<div class="notice--primary" markdown="1">

Or,

```
#;::{
    SendText(FormatTime(,"yyyy-MM-dd HH:mm:ss"))
}
```

</div>

(btw, this is an AutoHotkey v2.0 script.) where the `FormatTime` function[^7] is used to input current time using a certain time form. However, again, the `FormatTime` per se doesn't support UTC offset. Then, I found a very elegant way to add offset (other methods I found are much more complicated and I couldn't understand)[^8]:

```
^!v::
FormatTime, CurrentDateTime,, dd/MM/yyyy - hh:mm:ss
time:=A_Now 
EnvSub, time, A_NowUTC, Hours
SendRaw Jitendra - %CurrentDateTime%(GMT
if time>0
sendraw +%time%
if time<0
sendraw %time%
sendraw )
Return
```

which uses current local time `time` minus UTC time `A_NowUTC` to obtain the offset (and return it to) `time` in format `Hours`, and then display it using text after some post-procession. Next, I used ChatGPT to simplify it as:

```
#;::
FormatTime, CurrentDateTime,, yyyy-MM-dd HH:mm:ss
time:=A_Now 
EnvSub, time, A_NowUTC, Hours

sign := (time >= 0) ? "+" : "-"
absH := Abs(time)
hh   := (absH < 10) ? "0" . absH : absH
tz   := sign . hh . "00"

textInfo := CurrentDateTime . " " . tz
SendInput {Text}%textInfo%
Return
```

Note: This is a v1.1 version script, and we should download AutoHotkey v1.1 although it is deprecated.
{: .notice--warning}

At this time, if I use shortcut key `Win+;`, I'll get:

```
2025-11-02 13:37:04 -0500
```

Beautiful!

There are two points should be noted:

1. In the second line, note there are two commas between `CurrentDateTime` and `yyyy-MM-dd HH:mm:ss`, because time format is the third parameter of `FormatTime` function;
2. At last, use `{Text}` to output timestamp in pure text. Otherwise, if I use `Win+;` under the Pinyin input method, the colon will be full-width (Chinese colon).

<br>

**References**

[^1]: [用微软拼音快速输入自定义格式的时间和日期](https://blog.walterlv.com/ime/2017/09/18/date-time-format-using-microsoft-pinyin.html).
[^2]: [Input Method Editors (IME)](https://learn.microsoft.com/en-us/windows/apps/design/input/input-method-editors).
[^3]: [Three GitHub Repo Timestamps Obtained through REST API: `created_at`, `updated_at`, and `pushed_at` (including a simple introduction to ISO 8601)](/2024-07-28/16-03-22.html).
[^4]: [Daylight Saving Time Changes 2025 in New York, New York, USA](https://www.timeanddate.com/time/change/usa/new-york).
[^5]: [AutoHotkey](https://www.autohotkey.com/).
[^6]: [https://www.reddit.com/r/Windows11/comments/1c10ij0/comment/kz0tjgh/?utm\_source=share&utm\_medium=web3x&utm\_name=web3xcss&utm\_term=1&utm\_content=share\_button](https://www.reddit.com/r/Windows11/comments/1c10ij0/comment/kz0tjgh/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button).
[^7]: [FormatTime](https://www.autohotkey.com/docs/v2/lib/FormatTime.htm).
[^8]: [https://superuser.com/a/93576](https://superuser.com/a/93576).
