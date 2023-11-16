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

Luckily, it works. [Script 2](#script-2) gets each frame using `getframe` function and post-process it by `rgb2ind` function, and finally appends frame to `.gif` file by `imwrite` function. And in fact, it is similar to the way of generating `.gif` file provided by `imwrite` official documentation [^15]:

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

# `getframe` function

MATLAB `getframe` function [^11] is used to “Capture axes or figure as movie frame”. The basic usage of it is:

```matlab
rng("default")
x = rand(1,4);
y = rand(1,4);
scatter(x,y)
fig = gcf();
ax = gca();

% Capture axes as movie frame
F1 = getframe(ax)
% Capture figure as movie frame
F2 = getframe(fig)
```

where the figure will show like this:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311151907036.png" alt="image-20231115190706974" style="zoom: 67%;" />

and both `F1` and `F2` are all `struct` variable:

```
F1 = 
  struct with fields:
       cdata: [514×652×3 uint8]
    colormap: []

F2 = 
  struct with fields:
       cdata: [630×840×3 uint8]
    colormap: []
```

and whose `cdata` fields are RGB-tuple:

```
>> F1.cdata(1,1,:), F2.cdata(1,1,:)

  1×1×3 uint8 array
ans(:,:,1) =
   240
ans(:,:,2) =
   240
ans(:,:,3) =
   240

  1×1×3 uint8 array
ans(:,:,1) =
   240
ans(:,:,2) =
   240
ans(:,:,3) =
   240
```

We could reproduce axes or figure using `imshow` function:

```matlab
figure("Color",[7,84,213]/255)
imshow(F1.cdata)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311151920340.png" alt="image-20231115192044302" style="zoom:67%;" />

```matlab
figure("Color",[7,84,213]/255)
imshow(F2.cdata)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311151921765.png" alt="image-20231115192115724" style="zoom:67%;" />

The difference of capturing axes and capturing figure is clear to see. And what’s more, we could specify the second input argument, which is a four-element array, to get the specified area, like “Calculate Region to Include Title and Labels” example obtained from official documentation [^11]:

```matlab
clc,clear,close all

rng("default")
x = rand(1,4);
y = rand(1,4);
scatter(x,y)
title("Four andom points")

ax = gca();
ax.Units = "pixels";
pos = ax.Position;
ti = ax.TightInset;

rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3), pos(4)+ti(2)+ti(4)];
F = getframe(ax,rect);

figure("Color",[7,84,213]/255)
imshow(F.cdata)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311151934154.png" alt="image-20231115193403108" style="zoom:67%;" />

<br>

# `rgb2ind` function

After getting the frame, we could save it using `imwrite` function [^10], by (1) saving RGB image, or by (2) saving indexed image. The second way relies on using `rgb2ind` function [^12] to convert RGB image to indexed image. For example:

<div id="script-3"></div>

```matlab
clc,clear,close all

rng("default")
x = rand(1,4);
y = rand(1,4);
scatter(x,y)
fig = gcf();
ax = gca();

% Capture axes as movie frame
F = getframe(ax);

% Save figure by RGB image
imwrite(F.cdata,"jpg-1.jpg");

% Save figure by indexed image
[A,map] = rgb2ind(F.cdata,256);
imwrite(A,map,"jpg-2.jpg")
```

The `jpg-1.jpg` and `jpg-2.jpg` is exactly the same:

```matlab
clc,clear,close all

a = imread("jpg-1.jpg");
b = imread("jpg-2.jpg");
whos
```

```
 Name        Size                 Bytes  Class    Attributes
  a         514x652x3            1005384  uint8              
  b         514x652x3            1005384  uint8              
```

```
>> sum(a-b,"all")
ans =
     0
```

So, I speculate that, at this case, if the input of `imwrite` function is index image and whose map, `imwrite` function will convert it to RGB image automatically. However, if we want to use `imwrite` to save RGB image to a `.gif` file, it will throw an error:

```matlab
clc,clear,close all

rng("default")
x = rand(1,4);
y = rand(1,4);
scatter(x,y)
fig = gcf();
ax = gca();

% Capture axes as movie frame
F = getframe(ax);

% Save figure by RGB-tuple
imwrite(F.cdata,"gif.gif",WriteMode="append");
```

```
Error using writegif
3-D data not supported for GIF files. Data
must be 2-D or 4-D.

Error in imwrite (line 566)
        feval(fmt_s.write, data, map, filename, paramPairs{:});

Error in script6 (line 14)
imwrite(F.cdata,"gif.gif",WriteMode="append");
```

So, it explains why [Script 2](#script-2) adopts the second way, that is saving indexed image by `imwrite` function (`imwrite` document [^15] mentions this point as well.)

The outputs of code in [Script 3](#script-3):

```matlab
[A,map] = rgb2ind(F.cdata,256);
```

`A` is indexed image, and `map` is the associated colormap. 

Each row of `map` is a RGB tuple, representing a specific color, and the number of colors is determined by the second input argument “Number of quantized colors” `Q` (here is `256`) or “Tolerance used for uniform quantization” `tol` (concerning quantization algorithm [^14]). As for `A`, if the size of `F.cdata` is $h\times w\times 3$, then the size of `A` is $h \times w$, and each element $e_{i,j}$ in `A` denotes an index corresponding to the color order in `map`. 

For example, I found a colorful image “pepper.png” downloaded with MATLAB: 

```matlab
clc,clear,close all

img = imread("peppers.png");
imshow(img)
F = getframe(gca());

[A,map] = rgb2ind(F.cdata,256);
```

N.B., If we choose a more colorful image, the number of colors in `map` is determined by “Number of quantized colors” `Q` more, otherwise, it will mainly determined by “Tolerance used for uniform quantization” `tol`, that is, it is more less than the `Q` we specified.
{: .notice--warning}

For `A` and `map` int this case:

```
>> size(F.cdata), size(A), size(map)
ans =
   384   512     3
ans =
   384   512
ans =
   256     3
```

```
>> F.cdata(2,1,:)
  1×1×3 uint8 array
ans(:,:,1) =
   63
ans(:,:,2) =
   31
ans(:,:,3) =
   62
```

```
>> map(A(2,1)+1,:)*255
ans =
    59    29    59
```

N.B., Here, we add one to the elements in `A` to find a corresponding color in `map`. This detail is obtained from [^13], “If the image matrix is of data type `logical`, `uint8` or `uint16`, the colormap normally contains integer values in the range $[0, p–1]$ (where $p$ is the length of the colormap). The value 0 points to the first row in the colormap, the value 1 points to the second row, and so on.”
{: .notice--warning}

As can be seen, the RGB-tuple found based on `A` and `map`, `(59,29,59)`, is very similar to that original RGB array in `F.cdata`, `(63,31,62)`. However, they are not exactly the same, so in this image conversion process, some color information is lost. If we decrease the `Q` value further, this kind of distortion becomes more serious:

<div id="script-4"></div>

```matlab
clc,clear,close all

img = imread("peppers.png");
imshow(img)
F = getframe(gca());

[A1,map1] = rgb2ind(F.cdata,4);
[A2,map2] = rgb2ind(F.cdata,50);
[A3,map3] = rgb2ind(F.cdata,256);

imwrite(A1,map1,"img-1.jpg")
imwrite(A2,map2,"img-2.jpg")
imwrite(A3,map3,"img-3.jpg")
```

The original and the three saved figures show as follows:

<figure class="half">
    <img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311152220330.png">
    <img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311152059917.jpg">
    <img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311152059120.jpg">
    <img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311152100843.jpg">
    <figcaption>(a) Original "peppers.png", 280 KB; (b) "img-1.jpg", 50 KB; (c) "img-2.jpg", 36 kB; (d) "img-3.jpg", 27 KB</figcaption>
</figure>
The maximum value of `Q` is $65,536$ [^12]:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311161018258.png" alt="image-20231116101821045" style="zoom:67%;" />

However, in [Script 4](#script-4), specifying `Q` as the value over $256$ will occur some problems.

If we use the following code, which is similar to [Script 4](#script-4), to convert and save image:

```matlab
[A4,map4] = rgb2ind(F.cdata,65536);
imwrite(A4,map4,"img-4.jpg")
```

`imwrite` function will throw an error while saving: 

```
Error using writejpg>set_jpeg_props
UINT16 image data requires bitdepth specifically set to either 12 or 16.

Error in writejpg (line 49)
props = set_jpeg_props(data,varargin{:});

Error in imwrite (line 566)
        feval(fmt_s.write, data, map, filename, paramPairs{:});

Error in script5 (line 16)
imwrite(A4,map4,"img-4.jpg")
```

It reminds us to specify a higher value for `"BitDepth"` property, i.e.,

```matlab
[A4,map4] = rgb2ind(F.cdata,65536);
imwrite(A4,map4,"img-4.jpg","BitDepth",16)
```

It works and without any error, however, image `img-4.jpg` can’t inspected in Windows image viewer:

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311161046111.png" alt="image-20231116104612055" style="zoom:50%;" />

I suppose that Windows image viewer doesn't support viewing the image with this kind of bit depth.

But on another hand, we could import this `unit16` image using `imread` function, and view it by `imshow` function:

```matlab
clc,clear,close all

img = imread("img-4.jpg");
imshow(img)
```

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311161240708.png" alt="image-20231116124042514" style="zoom: 67%;" />

```
>> class(img)
ans =
    'uint16'
```

In addition, more detailed information about indexed image could be found in [^12] and [^13].


<br>

# `imwrite` function

As described above, `imwrite` function [^10] could be used to append multiple indexed images to an identical `.gif` file, and specifically, the corresponding code in [Script 2](#script-2) is:

```matlab
...
	firstFrame = true;
	...
    for frame = 1:48
        ...
        if firstFrame
            firstFrame = false;
            imwrite(A,map,animFilename,LoopCount=Inf,DelayTime=delayTime);
        else
            imwrite(A,map,animFilename,WriteMode="append",DelayTime=delayTime);
        end
    end
...
```

When saving the first fame, two properties of `imwrite` function, `LoopCount` and `DelayTime`, are specified, and when appending the subsequence frames, `WriteMode` and `DelayTime` are used. The meaning of specifying `WriteMode` as `"append"` is clear, so here we just need to understand what `LoopCount` and `DelayTime` are.

(1) `LoopCount` is the number of times to repeat the animation, and a `LoopCount` value of `Inf` causes the animation to loop continuously:

==screenshot==

and we just need to set it when add the first frame.



(2) `DelayTime` 

reciprocal of FPS (Frames Per Second, i.e., frame rate)

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
[^11]: [MATLAB `getframe`: Capture axes or figure as movie frame - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/getframe.html).
[^12]: [MATLAB `rgb2ind`: Convert RGB image to indexed image - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/rgb2ind.html).
[^13]: [Image Types in the Toolbox: Indexed Images - MathWorks](https://ww2.mathworks.cn/help/images/image-types-in-the-toolbox.html#f14-17587).
[^14]: [MATLAB `rgb2ind`: Tolerance used for uniform quantization `tol` - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/rgb2ind.html#mw_8a9ac938-c58d-4751-87ca-2cb78b014c3a).

[^15]: [MATLAB `imwrite`: Write Animated GIF - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/imwrite.html#mw_00bce5fe-d730-4bcb-8104-bcebe7d5262a).





[MATLAB `VideoWriter`: Create object to write video files - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/videowriter.html).

[MATLAB `writeVideo`: Write video data to file - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/videowriter.writevideo.html).





