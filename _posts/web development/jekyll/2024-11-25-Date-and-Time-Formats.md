---
title: Date and Time Formats in Jekyll 
toc: false
categories:
 - Web Development
tags:
 - Jekyll
date: 2024-11-25 10:00:50 +0800
last_modified_at: 2024-11-25 13:13:00 +0800
---

**Predefined date filters**[^1][^2]

- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date_to_xmlschema }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date_to_xmlschema }}
- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date_to_rfc822 }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date_to_rfc822 }}
- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date_to_string }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date_to_string }}
- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date_to_long_string }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date_to_long_string }}
- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date_to_long_string: "ordinal" }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date_to_long_string : "ordinal" }}

<br>

**Combined date filters**[^2]

- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date: '%Y-%m-%d' }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date: '%Y-%m-%d' }}
- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date: '%m/%d/%Y' }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date: '%m/%d/%Y' }}
- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date: '%-m/%-d/%y' }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date: '%-m/%-d/%y' }}
- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date: '%B %-d, %Y' }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date: '%B %-d, %Y' }}
- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date: '%-d %B %Y' }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date: '%-d %B %Y' }}
- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date: '%B %-d, %Y' }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date: '%B %-d, %Y' }}
- {% raw %}`{{ "2024-11-25 10:00:50 +0800" | date: '%A, %B %-d, %Y' }}`{% endraw %}: {{ "2024-11-25 10:00:50 +0800" | date: '%A, %B %-d, %Y' }}

If there is no `-` before `d` in date format `'%-d %B %Y'`, numbers below ten would have a leading zero[^3], for example, {% raw %}`{{ "2024-11-07 10:00:50 +0800" | date: '%d %B %Y' }}`{% endraw %}({{ "2024-11-07 10:00:50 +0800" | date: '%d %B %Y' }}) vs. {% raw %}`{{ "2024-10-07 10:00:50 +0800" | date: '%-d %B %Y' }}`{% endraw %} ({{ "2024-10-07 10:00:50 +0800" | date: '%-d %B %Y' }}).
{: .notice--primary}

There are more formats of year, month, day, hour, minute, second, time zone, weekday, and week number etc. and more date patterns formed by their combination in blog[^2].

<br>

**References**

[^1]: [Liquid Filters \| Jekyll • Simple, blog-aware, static sites](https://jekyllrb.com/docs/liquid/filters/).
[^2]: [Jekyll Time and Date · Time And Date Formats used for J1 Template](https://jekyll.one/pages/public/tools/toolbox/jekyll/date_time_formats/).
[^3]: [liquid - How does Jekyll date formatting work?](https://stackoverflow.com/questions/7395520/how-does-jekyll-date-formatting-work).
