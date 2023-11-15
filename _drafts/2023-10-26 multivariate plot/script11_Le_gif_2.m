clc,clear,close all

load fisheriris
meas = meas(:,1:2);
sample = meas(7,:);
ts = -1:0.05:1;

vecs = [1/sqrt(2)*ones(1,numel(ts));ts];
gifFileName = "gif-24.gif";
delayTime = 1/24;
firstFrame = true;

figure("Color","w")
ax = gca();
hold(ax,"on"),box(ax,"on"),grid(ax,"on")
ax.LineWidth = 1.2;
xlim([-1,7]),ylim([-2,6])

p1 = plot([0,sample(1)],[0,sample(2)], ...
    "Color","b","LineWidth",1.5,"Marker",".","MarkerSize",20, ...
    "DisplayName","sample");

for i = 1:width(vecs)
    vec = vecs(:,i);
    proj = dot(sample,vec)/(dot(vec,vec))*vec;
    p2 = plot([0,vec(1)],[0,vec(2)], ...
        "Color","r","LineWidth",1,"Marker",".","MarkerSize",20);
    p3 = plot([0,proj(1)],[0,proj(2)], ...
        "Color","k","LineWidth",1,"Marker",".","MarkerSize",20, ...
        "DisplayName","sample projection");
    if i == 1
        legend([p1,p2,p3],{'projection','Vec','Projection'}, ...
            "Location","north","Orientation","horizontal","EdgeColor","none");
    else
        p2.HandleVisibility = "off";
        p3.HandleVisibility = "off";
    end
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if firstFrame
        firstFrame = false;
        imwrite(A,map,gifFileName,"LoopCount",Inf,"DelayTime",delayTime);
    else
        imwrite(A,map,gifFileName,"WriteMode","append","DelayTime",delayTime);
    end
end
