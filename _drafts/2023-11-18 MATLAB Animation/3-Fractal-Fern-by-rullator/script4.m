clc,clear,close all

contestAnimator()

function contestAnimator()
animFilename = "animation.gif";
fps = 6;
% Create the gif
for frame = 1:96
    disp(frame)
    drawframe(frame)
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
persistent NumOfPts fig ax xs ys colors
if f == 1
    rng("default")
    NumOfPts = 1000;
    fig = figure("Color","w","Position",[426.33,93.67,1681.33,1158]);
    ax = axes(fig);
    ax.Toolbar.Visible = "off";
    hold(ax,"on"),grid(ax,"on"),box(ax,"on")
    colors = rand(NumOfPts,3);

    pts = nan(NumOfPts,2);
    x = rand(NumOfPts,1);
    y = rand(NumOfPts,1);
    xs = nan(NumOfPts,48);
    ys = nan(NumOfPts,48);

    for i = 1:96
        p = rand(NumOfPts,1);
        idx1 = p<0.01;
        if sum(idx1) ~=0
            pts(idx1,1) = 0;
            pts(idx1,2) = 0.16*y(idx1);
        end

        idx2 = p>=0.01 & p<0.08;
        if sum(idx2) ~= 0
            pts(idx2,1) = 0.2*x(idx2)-0.26*y(idx2);
            pts(idx2,2) = 0.23*x(idx2)+0.22*y(idx2)+1.6;
        end

        idx3 = p>=0.08 & p<0.15;
        if sum(idx3) ~= 0
            pts(idx3,1) = -0.15*x(idx3)+0.28*y(idx3);
            pts(idx3,2) = 0.26*x(idx3)+0.24*y(idx3)+0.44;
        end

        idx4 = p>=0.15;
        if sum(idx4) ~= 0
            pts(idx4,1) = 0.85*x(idx4)+0.04*y(idx4);
            pts(idx4,2) = -0.04*x(idx4)+0.85*y(idx4)+1.6;
        end
        x = pts(:,1);
        y = pts(:,2);
        xs(:,i) = pts(:,1);
        ys(:,i) = pts(:,2);
    end
end

for i = 1:NumOfPts
    scatter(ax,xs(i,f),ys(i,f),".","MarkerEdgeColor",colors(i,:))
end

axis(ax,[-3,3,0,11]);
end