---
title: Add a Scroll Bar for a HTML Division (HTML `<div>` Tag)
categories:
 - Web Development
tags:
 - HTML
date: 2024-06-26 11:41:42 +0800
last_modified_at: 2024-06-26 11:41:42 +0800
modification_history:
 - 2024-06-26 11:41:42 +0800
---

# Add a vertical scroll bar

```html
<div style="overflow:scroll;
            height:400px;
            width:800px;
            background-color:gray;
            color:white;
            padding:37px;
            margin:auto;"
     markdown="1">

<font size="7">Lorem Ipsum</font>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a turpis at magna consequat posuere ac mattis turpis. Nunc lacinia at eros eget mollis. Integer lobortis, est quis tristique luctus, turpis sapien molestie magna, ut feugiat purus est tincidunt elit. Quisque luctus odio nec mi elementum mollis non eget dui. Fusce vitae nulla eget ligula tristique eleifend. Vivamus ac tincidunt nunc, eu lacinia nisi. Praesent sodales maximus varius. Aenean at tortor ac ligula dapibus efficitur eu ac est.

Cras sed viverra urna. Quisque ut tellus consequat, tristique diam sed, cursus leo. Nunc tristique, velit id consectetur tincidunt, leo neque semper nibh, id faucibus nisi ipsum nec nibh. Donec vel tempus magna. Vestibulum placerat est felis, finibus pellentesque elit elementum ac. Donec posuere posuere neque, at tincidunt sapien mattis sed. Vestibulum sed dapibus massa, vitae tincidunt erat. Donec at sapien sodales, aliquam ex tempor, finibus turpis. Ut sodales turpis ut libero pellentesque, nec interdum neque vehicula. Quisque vulputate turpis urna, quis venenatis est pulvinar semper. Nam et aliquet leo, sed sodales risus. Phasellus quis consectetur nibh. Maecenas a lobortis ex. Proin efficitur elit eget lacinia elementum.

Fusce id vulputate odio, vitae venenatis urna. Aenean bibendum mollis pretium. Aliquam ac urna ac augue aliquam vestibulum. Nulla placerat scelerisque orci non pulvinar. Aenean tortor nunc, vehicula in accumsan sed, auctor ac dolor. Quisque eget nibh vitae nulla lobortis efficitur. Ut eget orci odio. Morbi diam nunc, dictum sed faucibus id, tempor quis felis.

</div>
```

<div style="overflow:scroll;
            height:400px;
            width:800px;
            background-color:gray;
            color:white;
            padding:37px;
            margin:auto;"
     markdown="1">

<font size="7">Lorem Ipsum</font>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a turpis at magna consequat posuere ac mattis turpis. Nunc lacinia at eros eget mollis. Integer lobortis, est quis tristique luctus, turpis sapien molestie magna, ut feugiat purus est tincidunt elit. Quisque luctus odio nec mi elementum mollis non eget dui. Fusce vitae nulla eget ligula tristique eleifend. Vivamus ac tincidunt nunc, eu lacinia nisi. Praesent sodales maximus varius. Aenean at tortor ac ligula dapibus efficitur eu ac est.

Cras sed viverra urna. Quisque ut tellus consequat, tristique diam sed, cursus leo. Nunc tristique, velit id consectetur tincidunt, leo neque semper nibh, id faucibus nisi ipsum nec nibh. Donec vel tempus magna. Vestibulum placerat est felis, finibus pellentesque elit elementum ac. Donec posuere posuere neque, at tincidunt sapien mattis sed. Vestibulum sed dapibus massa, vitae tincidunt erat. Donec at sapien sodales, aliquam ex tempor, finibus turpis. Ut sodales turpis ut libero pellentesque, nec interdum neque vehicula. Quisque vulputate turpis urna, quis venenatis est pulvinar semper. Nam et aliquet leo, sed sodales risus. Phasellus quis consectetur nibh. Maecenas a lobortis ex. Proin efficitur elit eget lacinia elementum.

Fusce id vulputate odio, vitae venenatis urna. Aenean bibendum mollis pretium. Aliquam ac urna ac augue aliquam vestibulum. Nulla placerat scelerisque orci non pulvinar. Aenean tortor nunc, vehicula in accumsan sed, auctor ac dolor. Quisque eget nibh vitae nulla lobortis efficitur. Ut eget orci odio. Morbi diam nunc, dictum sed faucibus id, tempor quis felis.

</div>

<br>

# Add a horizontal scroll bar

```html
<div style="overflow-x:scroll;
            white-space:nowrap;
            height:400px;
            width:800px;
            background-color:gray;
            color:white;
            padding:37px;
            margin:auto;"
     markdown="1">

<font size="7">Lorem Ipsum</font>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a turpis at magna consequat posuere ac mattis turpis. Nunc lacinia at eros eget mollis. Integer lobortis, est quis tristique luctus, turpis sapien molestie magna, ut feugiat purus est tincidunt elit. Quisque luctus odio nec mi elementum mollis non eget dui. Fusce vitae nulla eget ligula tristique eleifend. Vivamus ac tincidunt nunc, eu lacinia nisi. Praesent sodales maximus varius. Aenean at tortor ac ligula dapibus efficitur eu ac est.

Cras sed viverra urna. Quisque ut tellus consequat, tristique diam sed, cursus leo. Nunc tristique, velit id consectetur tincidunt, leo neque semper nibh, id faucibus nisi ipsum nec nibh. Donec vel tempus magna. Vestibulum placerat est felis, finibus pellentesque elit elementum ac. Donec posuere posuere neque, at tincidunt sapien mattis sed. Vestibulum sed dapibus massa, vitae tincidunt erat. Donec at sapien sodales, aliquam ex tempor, finibus turpis. Ut sodales turpis ut libero pellentesque, nec interdum neque vehicula. Quisque vulputate turpis urna, quis venenatis est pulvinar semper. Nam et aliquet leo, sed sodales risus. Phasellus quis consectetur nibh. Maecenas a lobortis ex. Proin efficitur elit eget lacinia elementum.

Fusce id vulputate odio, vitae venenatis urna. Aenean bibendum mollis pretium. Aliquam ac urna ac augue aliquam vestibulum. Nulla placerat scelerisque orci non pulvinar. Aenean tortor nunc, vehicula in accumsan sed, auctor ac dolor. Quisque eget nibh vitae nulla lobortis efficitur. Ut eget orci odio. Morbi diam nunc, dictum sed faucibus id, tempor quis felis.

</div>
```

<div style="overflow-x:scroll;
            white-space:nowrap;
            height:400px;
            width:800px;
            background-color:gray;
            color:white;
            padding:37px;
            margin:auto;"
     markdown="1">
<font size="7">Lorem Ipsum</font>

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque a turpis at magna consequat posuere ac mattis turpis. Nunc lacinia at eros eget mollis. Integer lobortis, est quis tristique luctus, turpis sapien molestie magna, ut feugiat purus est tincidunt elit. Quisque luctus odio nec mi elementum mollis non eget dui. Fusce vitae nulla eget ligula tristique eleifend. Vivamus ac tincidunt nunc, eu lacinia nisi. Praesent sodales maximus varius. Aenean at tortor ac ligula dapibus efficitur eu ac est.

Cras sed viverra urna. Quisque ut tellus consequat, tristique diam sed, cursus leo. Nunc tristique, velit id consectetur tincidunt, leo neque semper nibh, id faucibus nisi ipsum nec nibh. Donec vel tempus magna. Vestibulum placerat est felis, finibus pellentesque elit elementum ac. Donec posuere posuere neque, at tincidunt sapien mattis sed. Vestibulum sed dapibus massa, vitae tincidunt erat. Donec at sapien sodales, aliquam ex tempor, finibus turpis. Ut sodales turpis ut libero pellentesque, nec interdum neque vehicula. Quisque vulputate turpis urna, quis venenatis est pulvinar semper. Nam et aliquet leo, sed sodales risus. Phasellus quis consectetur nibh. Maecenas a lobortis ex. Proin efficitur elit eget lacinia elementum.

Fusce id vulputate odio, vitae venenatis urna. Aenean bibendum mollis pretium. Aliquam ac urna ac augue aliquam vestibulum. Nulla placerat scelerisque orci non pulvinar. Aenean tortor nunc, vehicula in accumsan sed, auctor ac dolor. Quisque eget nibh vitae nulla lobortis efficitur. Ut eget orci odio. Morbi diam nunc, dictum sed faucibus id, tempor quis felis.

</div>
