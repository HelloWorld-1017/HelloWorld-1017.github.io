---
title: Autoplay YouTube Videos (but Muted) When Using Embed Code to Share
toc: false
categories:
 - Web Development
tags:
 - HTML
location: Buffalo, United States
date: 2025-10-31 20:32:56 -0400
last_modified_at: 2025-11-02 22:53:30 -0500
---

When using embed code to share a YouTube video, we can set `autoplay` option as `1` to make it autoplay[^1]. Here is an example (where see `&autoplay=1&mute=1` at the end of url):

```html
<iframe class="iframe--video" width="560" height="315" src="https://www.youtube.com/embed/8eg__nN-CtQ?si=tLx-GQpPw2pKCOOt&autoplay=1&mute=1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
```

<iframe class="iframe--video" width="560" height="315" src="https://www.youtube.com/embed/8eg__nN-CtQ?si=tLx-GQpPw2pKCOOt&autoplay=1&mute=1" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

<br>

However, note that, right now only muted videos can be autoplayed because of Chrome's new autoplay policies[^2]:

<div class="quote--left" markdown="1">

<i class="emphasize">Chrome's autoplay policies changed in April of 2018</i> and I'm here to tell you why and how this affects video playback with sound. Spoiler alert: users are going to love it!

## New behaviors

As you may have [noticed](https://webkit.org/blog/7734/auto-play-policy-changes-for-macos/), web browsers are moving towards <i class="emphasize">stricter autoplay policies</i> in order to improve the user experience, minimize incentives to install ad blockers, and reduce data consumption on expensive and/or constrained networks. These changes are intended to give greater control of playback to users and to benefit publishers with legitimate use cases.

Chrome's autoplay policies are simple:

- <i class="emphasize">Muted autoplay is always allowed</i>.
- Autoplay with sound is allowed if:
  - The user has interacted with the domain (click, tap, etc.).
  - On desktop, the user's [Media Engagement Index](https://developer.chrome.com/blog/autoplay#media_engagement_index) threshold has been crossed, meaning the user has previously played video with sound.
  - The user has [added the site to their home screen](https://web.dev/customize-install/) on mobile or [installed the PWA](https://web.dev/progressive-web-apps/) on desktop.
- Top frames can [delegate autoplay permission](https://developer.chrome.com/blog/autoplay#iframe_delegation) to their iframes to allow autoplay with sound.

</div>

So, we should add `&mute=1` in the url at the same time. Then, users need to click the volume button, at the bottom left corner next to play button, to unmute the autoplayed video.

<br>

**References**

[^1]: [How can I autoplay a video using the new embed code style for Youtube?](https://stackoverflow.com/questions/3405242/how-can-i-autoplay-a-video-using-the-new-embed-code-style-for-youtube).
[^2]: [Autoplay policy in Chrome](https://developer.chrome.com/blog/autoplay).

