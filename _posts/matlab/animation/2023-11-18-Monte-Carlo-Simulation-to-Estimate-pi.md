---
title: Monte Carlo Simulation to Estimate $\pi$
toc: false
categories:
 - Mathematics
 - MATLAB
 - Uncertainty
tags:
 - MATLAB Animation
 - MATLAB Graphics
 - Number Theory
header: 
  image: https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311181442343.gif
date: 2023-11-18 17:40:37 +0800
last_modified_at: 2023-11-19 02:10:17 +0800
---

Recently, I heard about a small official MATLAB contest, “MATLAB Flipbook mini Hack” [^1], and in this contest participants should upload a user-defined function for rendering a short animation, that is a `.gif` file. I feel that many works in the gallery [^1] are very amazing, cause participants are just allowed to upload an easy function `drawframe(f)` (up to 2,000 characters [^2]), which is for creating a single frame, therefore, the transition between a frame and its subsequent frame is just realized by mathematical operations! Excited by it, I learned a better way to create `.gif` file in MATLAB (refer to Blog [^3]). And today I found a Mike’s work [^4] animating Monte Carlo estimation for $\pi$. This is a very classical example to illustrate the wisdom of Mote Carlo simulation. Mike’s code [^4] is clear and straightforward, but when I want to enrich some details on which, I encountered some problems, so I will record them in this blog. The final `.gif` file I created shows as follows, and my main improvement is about showing more text information:

![gif](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311181442343.gif)

the complete code is:

<div id="script-1"></div>

```matlab
clc,clear,close all

rng("default")
gifFileName = "gif.gif";
if exist(gifFileName,"file")
    delete(gifFileName)
end
fps = 24;

figure("Color","w","Position",[1000,918,694.33,420])

tiledlayout(3,3,"TileSpacing","tight")
nexttile(1,[3,2])
ax1 = gca();

nexttile(6)
ax2 = gca();

for f = 1:500
    helperDrawFrame(f,ax1,ax2)
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if f == 1
        imwrite(A,map,gifFileName,"LoopCount",Inf,"DelayTime",1/fps)
    else
        imwrite(A,map,gifFileName,"WriteMode","append","DelayTime",1/fps)
    end
end


function helperDrawFrame(f,ax1,ax2)
persistent total_points inside_points outside_points
if f == 1
    total_points = 0;
    inside_points = 0;
    outside_points = 0;
end

% Settings for ax1
set(ax1,"Xlim",[-1,1],"YLim",[-1,1], ...
    "FontSize",15,"FontName","Times New Roman", ...
    "LineWidth",1.2)
ax1.Toolbar.Visible = "off";
hold(ax1,"on"),box(ax1,"on")
daspect(ax1,[1,1,1])

% Settings for ax2
set(ax2,"Visible","off")
hold(ax2,"off")

% Carry out Monte Carlo simulation in ax1
pointsPerCount = f*50;
total_points = total_points+pointsPerCount;

x = 2*rand(1,pointsPerCount)-1;
y = 2*rand(1,pointsPerCount)-1;
d = sqrt(x.^2+y.^2);
idx = d<=1;
inside_points = inside_points+sum(idx);
outside_points = outside_points+sum(~idx);

theta = 0:0.01:2*pi;
plot(ax1,cos(theta),sin(theta),"LineWidth",1.5,"Color","k")
scatter(ax1,x(idx),y(idx),1,"b.");
scatter(ax1,x(~idx),y(~idx),1,"r.");

% Display information in ax2
cla(ax2)
estimatedPi = num2str(4*inside_points/total_points,"%.8f");
realPi = '3.14159265';
idx = find(diff(realPi(1:end)==estimatedPi(1:end)) == -1);
idx = idx(1);

FontSize = 15;
vSpace = 0.5;
text(ax2,0,3*vSpace,sprintf("Total points: %s",num2str(total_points)), ...
    "FontSize",FontSize,"FontName","Times New Roman")
text(ax2,0,2*vSpace,sprintf("Inside points: %s",num2str(inside_points)), ...
    "FontSize",FontSize,"FontName","Times New Roman")
text(ax2,0,1*vSpace,sprintf("Outside points: %s",num2str(outside_points)), ...
    "FontSize",FontSize,"FontName","Times New Roman")
text(ax2,0,0,sprintf("Real %s: %s%s%s%s...","\pi","\color{blue}",realPi(1:idx),"\color{red}",realPi(idx+1:end)), ...
    "InterPreter","tex","FontSize",FontSize,"FontName","Times New Roman")
text(ax2,0,-1*vSpace, ...
    sprintf("Estimated %s: %s%s%s%s...","\pi","\color{blue}",estimatedPi(1:idx),"\color{red}",estimatedPi(idx+1:end)),...
    "InterPreter","tex","FontSize",FontSize,"FontName","Times New Roman")
end
```

In this script, there exist four points should be noted:

**(I) MATLAB persistent variables**

In Mike’s work [^4], the points number displaying in the axes title is the number of newly-added points, here I want to show the number of accumulated points  from the first frame. On another hand, I want to imitate the way of creating `.gif` file of all participants in the contest [^1], that is decoupling the processes of rendering frame and appending frame to `.gif` file, updating each frame by invoking an identical defined `helperDrawFrame ` function. Therefore, I decide to use MATLAB persistent variables [^5] to record points information:

```matlab
...
function helperDrawFrame(f,ax1,ax2)
persistent total_points inside_points outside_points
...
end
```

As described in the official documentation [^5], persistent variables could be cleared from workplace by `clear` function. However, I found that **the `clear` function doesn’t work if users interrupt the script running: the values stored in persistent variables still exist.** This is somewhat weird, but it is also very easy to handle this problem, we could initialize these persistent variables while creating the first frame:

```matlab
...
function helperDrawFrame(f,ax1,ax2)
persistent total_points inside_points outside_points
if f == 1
    total_points = 0;
    inside_points = 0;
    outside_points = 0;
end
...
end
```

**(II) `sprintf` function and `text` function** 

As described in my previous Blog [^6], specifying text for `title` function by `sprintf` is more convenient than concatenating strings, and actually, `sprintf` function could be used in any case that needs to link strings. At that Blog, I found that `sprintf` function is not usable when we need to use text interpreter. For example:

```matlab
clc,clear,close all
figure("Color","w")
axes("Visible","off")
text(0.5,0.5,sprintf("$\pi$: %.4f",3.1415), ...
    "Interpreter","latex")
```

The figure shows like:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311181614963.png" alt="image-20231118161411796" style="zoom:50%;" />

and a warning occurs:

```
Warning: Escaped character '\p' is not valid. See 'doc
sprintf' for supported special characters. 
> In script3 (line 5) 
Warning: Error updating Text.

 String scalar or character vector must have valid
 interpreter syntax:
$
```

which is caused by `sprintf` function:

```
>> sprintf("$\pi$: %.4f",3.1415)
Warning: Escaped character '\p' is not valid. See 'doc
sprintf' for supported special characters. 
ans = 
    "$"
```

But today, I found an answer to solve this problem in Blog [^7], that is formatting the LaTeX syntax as well:

```matlab
clc,clear,close all
figure("Color","w")
axes("Visible","off")
text(0.5,0.5,sprintf("%s: %.4f","$\pi$",3.1415), ...
    "Interpreter","latex")
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311181620582.png" alt="image-20231118162051546" style="zoom: 50%;" />

At this time, it works! Therefore, in [Script 1](#script-1), I adopt a similar way.

**(III) LaTeX vs. TeX interpreter**

For MATLAB `title`, `text`, `xlabel`, `ylabel` and other similar functions displaying text in figures, two interpreters are available for `"Interpreter"` property, i.e. `tex` and `latex`, and there exist two differences between these two. For example:

```matlab
clc,clear,close all
figure("Color","w")
axes("Visible","off")
text(0.5,0.6,sprintf("%s: %.4f","$\pi$",3.1415), ...
    "Interpreter","latex","FontSize",15)
text(0.5,0.5,sprintf("%s: %.4f","\pi",3.1415), ...
    "Interpreter","latex","FontSize",15)
text(0.5,0.4,sprintf("%s: %.4f","$\pi$",3.1415), ...
    "Interpreter","tex","FontSize",15)
text(0.5,0.3,sprintf("%s: %.4f","\pi",3.1415), ...
    "Interpreter","tex","FontSize",15)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311181656432.png" alt="image-20231118165654379" style="zoom:50%;" />

As can be seen:

(a) Identifier `$` is not needed while adopting `tex` interpreter, but it is necessary for `latex` interpreter;

(b) `latex` interpreter will parse the whole string (see `3.1415` of first line in above figure), while `tex` just parse the control sequence after slash `\<symbol>` (see `3.1415` of third and fourth lines in above figure).

**(IV) Coloring text**

Coloring text in MATLAB could be realized by control sequence `\color`, but it should be noted that, this control sequence could ONLY be identified by `tex` identifier:

```matlab
clc,clear,close all
figure("Color","w")
axes("Visible","off")
text(0.5,0.6,sprintf("%s%s: %.4f","\color{red}","$\pi$",3.1415), ...
    "Interpreter","latex","FontSize",15)
text(0.5,0.3,sprintf("%s%s: %.4f","\color{red}","\pi",3.1415), ...
    "Interpreter","tex","FontSize",15)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311181710574.png" alt="image-20231118171033070" style="zoom: 50%;" />

```
Warning: Error updating Text.

 String scalar or character vector must have valid interpreter syntax:
\color{red}$\pi$: 3.1415
```

furthermore, we could specify specific RGB tuple for `\color`, for example [^8]:

```matlab
clc,clear,close all
figure("Color","w")
axes("Visible","off")
text(0.5,0.5,sprintf("%s%s: %.4f","\color[rgb]{.5 .1 .1}","\pi",3.1415), ...
    "Interpreter","tex","FontSize",15)
text(0.5,0.4,sprintf("%s%s: %.4f","\color[rgb]{.1 .5 .1}","\pi",3.1415), ...
    "Interpreter","tex","FontSize",15)
text(0.5,0.3,sprintf("%s%s: %.4f","\color[rgb]{.1 .1 .5}","\pi",3.1415), ...
    "Interpreter","tex","FontSize",15)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311181715224.png" alt="image-20231118171516166" style="zoom: 50%;" />

<br>

At last, we look backward to Monte Carlo estimation for $\pi$. If changing the number of added points per frame (`pointsPerCount` of `helperDrawFrame` function in [Script 1](#script-1)) from 50 to 700, a Monte Carlo simulation involving more points shows like:

![gif](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311181447810.gif)

It can be seen that, using this simulation way to calculate $\pi$ converge very very slowly.

<br>

**References**

[^1]: [MATLAB Flipbook Mini Hack Gallery](https://ww2.mathworks.cn/matlabcentral/communitycontests/contests/6/entries).
[^2]: [MATLAB Flipbook Mini Hack Contest Description, Rules, and Terms - MATLAB](https://ww2.mathworks.cn/en/matlabcentral/contests/2023-mini-hack-contest-prizes-rules.html).
[^3]: [Create Animation in MATLAB: Render `.gif` and `.avi` File - What a starry night~](https://helloworld-1017.github.io/2023-11-16/15-18-58.html).

[^4]: [Monte-Carlo estimation of pi - MATLAB Flipbook Mini Hack](https://ww2.mathworks.cn/matlabcentral/communitycontests/contests/6/entries/13415).
[^5]: [MATLAB persistent: Define persistent variable - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/persistent.html).
[^6]: [MATLAB `sprintf` Function and `title` Function - What a starry night~](https://helloworld-1017.github.io/2022-09-12/14-42-37.html).
[^7]: [matlab sprintf latex interpreter - 掘金](https://juejin.cn/s/matlab%20sprintf%20latex%20interpreter).
[^8]: [Predefining colors for in-text coloring - MATLAB Answers - MATLAB Central](https://ww2.mathworks.cn/matlabcentral/answers/137525-predefining-colors-for-in-text-coloring).
