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
cla
mtx2apply = [0, 1; 1, 0];
vu = ones(2, 9) * 4;
vu(1,:) = -4:4;
vd = ones(2, 9) * (-4);
vd(1,:) = -4:4;
hl = ones(2, 9) * (-4);
hl(2,:) = -4:4;
hr = ones(2, 9) * 4;
hr(2,:) = -4:4;
setBasicCanvas(vu, vd, hl, hr);
mtx4vis = eye(2) + (mtx2apply - eye(2)) * ((f-1)/(48-1));
hv = plotLines(mtx4vis * vu, mtx4vis * vd, [109, 155, 222]/255);
hh = plotLines(mtx4vis * hl, mtx4vis * hr, [109, 155, 222]/255);
ha1 = drawArrow([0, 0], mtx4vis * [1; 0], "r");
ha2 = drawArrow([0, 0], mtx4vis * [0; 1], "g");
function setBasicCanvas(vu, vd, hl, hr)
    set(gcf,'color','k')
    ax = newplot;
    daspect(ax, [1,1,1])
    set(ax, 'position', [0 0 1 1], 'visible', 'off')
    xlim([-4, 4])
    ylim([-4, 4])
    plotLines(vu, vd);
    plotLines(hl, hr);
end
function h = drawArrow(p1, p2, color)
    dp = p2 - p1;
    hold on;
    h = quiver(p1(1), p1(2) ,dp(1), dp(2), 0, "filled", "Color", color, "linewidth", 2, "MaxHeadSize", 0.5);
end
function h = plotLines(v1, v2, color)
    if nargin<3
        color = ones(1,3) * 0.3;
    end
    assert(length(v1) == length(v2), "The two input vectors must have same length!")
    for i = 1:length(v1)
        h(i) = line([v1(1, i), v2(1, i)], [v1(2, i), v2(2, i)], 'color', color, 'linewidth',1);
    end
end
end