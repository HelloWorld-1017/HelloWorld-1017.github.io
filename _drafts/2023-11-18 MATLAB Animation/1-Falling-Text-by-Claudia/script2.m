% [Falling - MATLAB Flipbook Mini Hack]
% (https://ww2.mathworks.cn/matlabcentral/communitycontests/contests/6/entries/13465)
clc,clear,close all

contestAnimator()

function contestAnimator()
animFilename = "gif.gif"; % Output file name
fps = 12;
% Create the gif
for frame = 1:48
    drawframe(frame);
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if frame == 1
        imwrite(A,map,animFilename,"LoopCount",Inf,"DelayTime",1/fps);
    else
        imwrite(A,map,animFilename,"WriteMode","append","DelayTime",1/fps);
    end
end
end

function drawframe(f)
persistent fig ax h colors  texts
persistent totalFrames eachFrame string x y textRotation

if f == 1
    % Define the frame vector
    totalFrames = 48;
    eachFrame = 1:totalFrames;

    fig = figure("Color","w");
    ax = axes(fig);
    ax.Toolbar.Visible = "off";
    axis([0 1 0 1]);
    axis equal;
    axis off
    h.h1 = animatedline(ax,"LineWidth",1.5,"Color","b");
    h.h2 = animatedline(ax,"LineWidth",1.5,"Color","b");
    h.h3 = animatedline(ax,"LineWidth",1.5,"Color","b");
    h.h4 = animatedline(ax,"LineWidth",1.5,"Color","b");
    h.h5 = animatedline(ax,"LineWidth",1.5,"Color","b");
    h.h6 = animatedline(ax,"LineWidth",1.5,"Color","b");

    colors = get(ax,"ColorOrder");

    % Falling string
    string = 'MATLAB';

    % Compute x
    x = eachFrame/totalFrames*0.5-0.2;

    % Compute y
    y = 1-0.5*((eachFrame*10)/totalFrames).^8;
    y = 0.5+y/10^8;

    % compute rotation
    textRotation = (y-0.5)*180;

    texts = gobjects(length(string),1);
end


if f ~= 1
    delete(texts)
    texts = gobjects(length(string),1);
end

for i=1:length(string)
    idx = i*4+f;
    if idx <= 48
        xPosition = x(idx)+0.08*i;
        yPosition = y(idx);
        addpoints(h.("h"+num2str(i)),xPosition,yPosition)
        texts(i) = text(xPosition,yPosition,string(i), ...
            "Rotation",textRotation(idx), ...
            "FontSize",30,"Color",colors(i,:), ...
            "EdgeColor","k","LineWidth",1.5,...
            "FontName","Times New Roman", ...
            "BackgroundColor","none", ...
            "Margin",0.1,"HorizontalAlignment","center");
    end
end
end
