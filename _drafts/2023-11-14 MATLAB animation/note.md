---
layout: single
title: "xxxx"
date: 2023-11-xx xx:xx:xx +0800
categories:
 - MATLAB
tags:
 - MATLAB Animation
 - MATLAB Graphics
 - MATLAB Data Import and Export
---

# Introduction

In the previous Blogs, I ever used MATLAB to create GIF file, like animating Bézier curve [^1], plotting phase trajectories of Van del Pol Circuit [^2] and Chua's circuit [^3]. It is a better way to  show a changing progress using GIF file rather than static figure, but according my ever experience, MATLAB seems not good at creating GIF, and the worst problem is that it will spend a lot of time in the generation problem. For example, I use the following codes to plot the dynamic solutions of Chua's circuit  in [^3] :

<div id="script-1"></div>

```matlab
clc,clear,close all

tic
gifFile = "Chua1.gif";
if exist(gifFile,"file")
    delete(gifFile)
end

figure, axes, view(-6.9,37.1)
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
xlabel("x"),ylabel("y"),zlabel("z")
axis([-3,3,-0.4,0.4,-4,4])
h = animatedline(gca,"LineWidth",1.3);

[t,y] = ode45(@chua,[0 100],[0.7 0 0]);

for i = 1:numel(y(:,1))
    addpoints(h,y(i,1),y(i,2),y(i,3))
    drawnow
    exportgraphics(gcf,gifFile,"Append",true);
end
toc

function out = chua(t,in)
x = in(1);
y = in(2);
z = in(3);

alpha  = 15.6;
beta   = 28;
m0     = -1.143;
m1     = -0.714;

h = m1*x+0.5*(m0-m1)*(abs(x+1)-abs(x-1));

xdot = alpha*(y-x-h);
ydot = x-y+z;
zdot  = -beta*y;

out = [xdot,ydot,zdot]';
end
```

<div id="gif-1"></div>

![Chua1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142120396.gif)

The size of this `.gif` file is 71,387 KB.
{: .notice--primary}

The result is fine, but this progress will cost 289.32 seconds, which is too long. So, at that time, I believed that this is an inherent problem of MATLAB itself, so I ever tried to learn Python manim package [^4][^5], but I didn't persist since I have no much extra time to do it.

In [Script 1](#script-1), generating GIF file is realized by appending each figure frame to a `.gif` file by `exportgraphic` function with `"append"` property `true`. This approach is obtained from official documentation of `exportgraphic` function [^6]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311150949958.png" alt="image-20231115094913877" style="zoom: 80%;" />

Today, I hear about an interesting officially-held contest "MATLAB Flipbook mini Hack" [^7]. In this small contest, users could upload their code, that is a user-defined `drawframe` function [^8] which is used to generate a frame of animation, therefore constructing a animation clip. I didn't find the main function used for invoking `drawframe` on the official website, but I find a slandarer's blog [^9], providing a `contestAnimation` function to create `.gif` file:

<div id="script-2"></div>

```matlab
function contestAnimator()
    animFilename = 'animation.gif'; % Output file name
    firstFrame = true;
    framesPerSecond = 24;
    delayTime = 1/framesPerSecond;
    % Create the gif
    for frame = 1:48
        drawframe(frame)
        fig = gcf(); 
        fig.Units = 'pixels';
        fig.Position(3:4) = [300,300];
        im = getframe(fig);
        [A,map] = rgb2ind(im.cdata,256);
        if firstFrame
            firstFrame = false;
            imwrite(A,map,animFilename, LoopCount=Inf, DelayTime=delayTime);
        else
            imwrite(A,map,animFilename, WriteMode="append", DelayTime=delayTime);
        end
    end
end
```

Luckily, it works. [Script 2](#script-2) gets each frame using `getframe` function and post-process it by `rgb2ind` function, and finally appends frame to `.gif` file by `imwrite` function. And in fact, it is similar to the way of generating `.gif` file provided by `imwrite` documentation [^10]:

```matlab
...
filename = "testAnimated.gif"; % Specify the output file name
for idx = 1:nImages
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,"gif","LoopCount",Inf,"DelayTime",1);
    else
        imwrite(A,map,filename,"gif","WriteMode","append","DelayTime",1);
    end
end
```

So, in the following text, I will make a detailed analysis for `getframe`, `rgb2ind` and `imwrite` functions in [Script 2](#script-2), and afterward, apply this method to plotting dynamic solutions of Chua's circuit, comparing it with [Script 1](#script-1). ==Finally, xxx==

<br>



```matlab
clc,clear,close all

tic
figure("Color","w")
axes
view(-6.9,37.1)
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
xlabel("x"),ylabel("y"),zlabel("z")
axis([-3,3,-0.4,0.4,-4,4])
h = animatedline(gca,"LineWidth",1.3);

firstFrame = true;
framesPerSecond = 24;
delayTime = 1/framesPerSecond;

gifFile = sprintf("Chua%s.gif",num2str(framesPerSecond));
if exist(gifFile,"file")
    delete(gifFile)
end

[t,y] = ode45(@chua,[0 100],[0.7 0 0]);

for i = 1:numel(y(:,1))
    addpoints(h,y(i,1),y(i,2),y(i,3))

    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);

    if firstFrame
        firstFrame = false;
        imwrite(A,map,gifFile,LoopCount=Inf,DelayTime=delayTime);
    else
        imwrite(A,map,gifFile,WriteMode="append",DelayTime=delayTime);
    end
end
toc

function out = chua(t,in)
x = in(1);
y = in(2);
z = in(3);

alpha  = 15.6;
beta   = 28;
m0     = -1.143;
m1     = -0.714;

h = m1*x+0.5*(m0-m1)*(abs(x+1)-abs(x-1));

xdot = alpha*(y-x-h);
ydot = x-y+z;
zdot  = -beta*y;

out = [xdot,ydot,zdot]';
end
```



![Chua24](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142248003.gif)

24, 55.35 seconds, and the file size is 69,244 KB:



If we change `framesPerSecond` from 24 to 60, and 200, respectively:

<figure class="half">
    <img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142306557.gif">
    <img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142312222.gif">
    <figcaption>(a) 60 fps, costs 56.96 seconds, file size 69,244 KB; (b) 200 fps, costs 59.37 seconds, file size 69,244 KB</figcaption>
</figure>




<br>



<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142354778.png" alt="image-20231114235303980" style="zoom: 67%;" />

[How To Change GIF Frame Rate 🚀 Speechify](https://speechify.com/blog/change-gif-frame-rate/?landing_url=https%3A%2F%2Fspeechify.com%2Fblog%2Fchange-gif-frame-rate%2F).



About Resolution

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142350981.png" alt="image-20231114235032925" style="zoom: 67%;" />

<br>

# `.avi` file



Python manim package [^4] also supports to generate `.avi` video file, 



```matlab
clc,clear,close all

tic
figure("Color","w")
axes
view(-6.9,37.1)
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
xlabel("x"),ylabel("y"),zlabel("z")
axis([-3,3,-0.4,0.4,-4,4])
h = animatedline(gca,"LineWidth",1.3);

FrameRate = 60;
aviFile = sprintf("Chua%s.avi",num2str(FrameRate));
if exist(aviFile,"file")
    delete(aviFile)
end

v = VideoWriter(aviFile);
v.FrameRate = FrameRate;
open(v)

[t,y] = ode45(@chua,[0 100],[0.7 0 0]);

for i = 1:numel(y(:,1))
    addpoints(h,y(i,1),y(i,2),y(i,3))

    fig = gcf();
    im = getframe(fig);
    writeVideo(v,im);
end
close(v)
toc

function out = chua(t,in)
x = in(1);
y = in(2);
z = in(3);

alpha  = 15.6;
beta   = 28;
m0     = -1.143;
m1     = -0.714;

h = m1*x+0.5*(m0-m1)*(abs(x+1)-abs(x-1));

xdot = alpha*(y-x-h);
ydot = x-y+z;
zdot  = -beta*y;

out = [xdot,ydot,zdot]';
end
```









| `.avi` File | `FrameRate` | Elapsed time | File size  | Video duration |
| ----------- | ----------- | ------------ | ---------- | -------------- |
| 1           | 24          | 31.38        | 118,449 KB | 01 min 35 sec  |
| 2           | 60          | 38.73        | 118,449 KB | 38 sec         |
| 3           | 120         | 33.90        | 118,449 KB | 19 sec         |
| 4           | 200         | 35.05        | 118,449 KB | 11 sec         |



"Uncompressed AVI"

Resolution



<br>

# Conclusion 

a new start!

<br>

**References**

[^1]: [Bernstein polynomial and Bézier curve - What a starry night~](https://helloworld-1017.github.io/2022-11-19/13-26-23.html).
[^2]: [Nonlinear Oscillation Circuit: Van del Pol Circuit - What a starry night~](https://helloworld-1017.github.io/2022-08-20/14-03-49.html).
[^3]:[Chaotic Circuit, Chua’s Circuit - What a starry night~](https://helloworld-1017.github.io/2022-08-19/15-07-21.html).
[^4]: [Hello, Python manim! - What a starry night~](https://helloworld-1017.github.io/2022-07-20/21-23-43.html).
[^5]: [Manim Community v0.18.0](https://docs.manim.community/en/stable/index.html).
[^6]: [MATLAB `exportgraphics`: Save plot or graphics content to file  - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/exportgraphics.html).
[^7]: [MATLAB Flipbook Mini Hack - MATLAB & Simulink](https://ww2.mathworks.cn/en/matlabcentral/contests/2023-matlab-mini-hack.html?q=&page=1).
[^8]: [MATLAB Flipbook Mini Hack Gallery](https://ww2.mathworks.cn/matlabcentral/communitycontests/contests/6/entries).
[^9]:[MATLAB - 官方举办的动图绘制大赛 - 第一周赛情回顾 - 知乎](https://zhuanlan.zhihu.com/p/666676042).
[^10]:[MATLAB `imwrite`: Write image to graphics file - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/imwrite.html).



[MATLAB `getframe`: Capture axes or figure as movie frame - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/getframe.html).

[MATLAB `rgb2ind`: Convert RGB image to indexed image - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/rgb2ind.html).

[MATLAB `VideoWriter`: Create object to write video files - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/videowriter.html).

[MATLAB `writeVideo`: Write video data to file - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/videowriter.writevideo.html).





