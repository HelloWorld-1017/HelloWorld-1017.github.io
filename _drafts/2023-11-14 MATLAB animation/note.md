





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

```
Elapsed time is 289.316079 seconds.
```

![Chua1](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142120396.gif)

71,387 KB

```matlab
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

24, 55.355892 seconds, 69244 KB:

![Chua24](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142248003.gif)

48, 58.443024 seconds, 



60, 56.964376 seconds, 69244 KB:

![Chua60](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142306557.gif)

200, 59.375906 seconds, 69244 KB:

![Chua200](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142312222.gif)

<br>

![image-20231114235303980](https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142354778.png)

[How To Change GIF Frame Rate 🚀 Speechify](https://speechify.com/blog/change-gif-frame-rate/?landing_url=https%3A%2F%2Fspeechify.com%2Fblog%2Fchange-gif-frame-rate%2F).



About Resolution

<img src="https://raw.githubusercontent.com/HelloWorld-1017/blog-images/main/imgs/202311142350981.png" alt="image-20231114235032925" style="zoom: 67%;" />

<br>

# `.avi` file



FrameRate = 24, Elapsed time is 31.382262 seconds, size: 118,449 KB, 01:35

FrameRate = 60, Elapsed time is 38.731698 seconds, size: 118,449 KB, 00:38

FrameRate = 120, Elapsed time is 33.903433 seconds, size: 118,449 KB, 00:19

FrameRate = 200, Elapsed time is 35.050934 seconds, size: 118,449 KB, 00:11



<br>

**References**

[1] [MATLAB - 官方举办的动图绘制大赛 - 第一周赛情回顾 - 知乎](https://zhuanlan.zhihu.com/p/666676042).

[1] [Bernstein polynomial and Bézier curve - What a starry night~](https://helloworld-1017.github.io/2022-11-19/13-26-23.html).

[2] [Chaotic Circuit, Chua’s Circuit - What a starry night~](https://helloworld-1017.github.io/2022-08-19/15-07-21.html).

[`getframe`: Capture axes or figure as movie frame - MathWorks China](https://ww2.mathworks.cn/help/matlab/ref/getframe.html)

[`rgb2ind`: Convert RGB image to indexed image - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/rgb2ind.html).

[`imwrite`: Write image to graphics file - MathWorks](https://ww2.mathworks.cn/help/matlab/ref/imwrite.html).





