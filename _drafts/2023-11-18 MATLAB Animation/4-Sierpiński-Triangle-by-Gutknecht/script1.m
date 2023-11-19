clc,clear,close all

contestAnimator()

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

function drawframe(f)
rng('default')
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
    newX = (additionalX(end) + verticesX(r))./2;
    newY = (additionalY(end) + verticesY(r))./2;
    additionalX = [additionalX; newX];
    additionalY = [additionalY; newY];
end
scatter([verticesX; additionalX],[verticesY; additionalY],1)
axis off
end