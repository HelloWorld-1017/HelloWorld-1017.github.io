clc,clear,close all

contestAnimator()

function contestAnimator()
animFilename = "gif.gif"; % Output file name
firstFrame = true;
fps = 24;
% Create the gif
for frame = 1:24*10
    drawframe(frame)
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if firstFrame
        firstFrame = false;
        imwrite(A,map,animFilename,"LoopCount",Inf,"DelayTime",1/fps);
    else
        imwrite(A,map,animFilename,"WriteMode","append","DelayTime",1/fps);
    end
end
end

function drawframe(f)
persistent fig ax sc
if f == 1
    fig = figure("Color","w");
    ax = axes(fig,"Visible","off");
    ax.Toolbar.Visible = "off";
    hold(ax,"on"),box(ax,"on"),grid(ax,"on")
end

rng("default")
sideLength = 1;
rotationAngle = pi./2;
R = sideLength./sqrt(3);
verticesX = [
    R.*cos(rotationAngle);
    R.*cos(rotationAngle+2.*pi./3)
    R.*cos(rotationAngle+4.*pi./3)
    ];
verticesY = [
    R.*sin(rotationAngle);
    R.*sin(rotationAngle+2.*pi./3)
    R.*sin(rotationAngle+4.*pi./3)
    ];
additionalX = [0];
additionalY = [0];
for i = 1:(f.*150)
    r = randi([1 3]);
    newX = (additionalX(end)+verticesX(r))./2;
    newY = (additionalY(end)+verticesY(r))./2;
    additionalX = [additionalX; newX];
    additionalY = [additionalY; newY];
end
if f ~= 1
    delete(sc)
end

sc = scatter([verticesX; additionalX],[verticesY; additionalY],1,"MarkerEdgeColor","k");
end