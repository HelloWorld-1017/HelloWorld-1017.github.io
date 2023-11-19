clc,clear,close all

contestAnimator()

function contestAnimator()
animFilename = "gif.gif";
fps = 24;
% Create the gif
for frame = 1:48
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
persistent fig n t axs sc
if f == 1
    t = linspace(0,2*pi,1000);
    n = 7;
    sc = gobjects(n,n);
    fig = figure("Position",[245.67,433,952.67,716.67], ...
        "Color",[1,1,0.85]);
    tiledlayout(fig,n,n,"TileSpacing","none","Padding","tight");
    axs = gobjects(n,n);
    for c = 1:n
        for r = 1:n
            nexttile;
            axs(c,r) = gca();
            axs(c,r).Toolbar.Visible = "off";
            axis padded off
            axis equal
            hold(axs(c,r),"on"),box(axs(c,r),"on"),grid(axs(c,r),"on")
            plot(axs(c,r),cos(r*t),sin(c*t),"LineWidth",2,"Color","b")
        end
    end
end

for c = 1:n
    for r = 1:n
        t1 = (f:0.1:f+3)/48*(2*pi);
        if f ~= 1
            delete(sc(c,r));
        end
        sc(c,r) = scatter(axs(c,r),cos(r*t1),sin(c*t1),16,"red","o","filled",...
            "AlphaData",(1:numel(t1))./numel(t1),"MarkerFaceAlpha","flat");
    end
end
end