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
t = linspace(0,2*pi);
n = 4;
tiledlayout(n,n,'TileSpacing','none','Padding','tight');
for c = 1:n
    for r = 1:n
        nexttile
        plot(cos(r*t),sin(c*t),LineWidth=2)
        hold on
        t1 = (f:.5:f+3)/48*(2*pi);
        scatter(cos(r*t1),sin(c*t1),16,"red","o","filled",...
            "AlphaData",(1:7)./7,"MarkerFaceAlpha","flat")
        axis padded off
    end
end
set(gcf,Color=[1 1 0.85])
end