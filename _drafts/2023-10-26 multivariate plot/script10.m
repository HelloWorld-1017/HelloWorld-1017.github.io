clc,clear,close all

load fisheriris
meas = meas(:,1:3);
sample = meas(7,:);
ts = -pi:0.05:pi;

vecs = [1/sqrt(2)*ones(1,numel(ts));sin(ts);cos(ts)];
delayTime = 1/numel(ts);
animFilename = 'animation.gif';
firstFrame = true;

figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
xlim([-1,5])
ylim([-1,5])
zlim([-3,4])
view(17.1000,25.8000)
plot3([0,sample(1)],[0,sample(2)],[0,sample(3)], ...
    "Color","b","LineWidth",1.5,"Marker","o","DisplayName","sample")
for i = 1:width(vecs)
    vec = vecs(:,i);
    proj = dot(sample,vec)/(dot(vec,vec))*vec;
    plot3([0,vec(1)],[0,vec(2)],[0,vec(3)], ...
        "Color","r","LineWidth",1,"Marker","o");
    plot3([0,proj(1)],[0,proj(2)],[0,proj(3)], ...
        "Color","k","LineWidth",1,"Marker","o", ...
        "DisplayName","sample projection")
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if firstFrame
        firstFrame = false;
        imwrite(A,map,animFilename, LoopCount=Inf, DelayTime=delayTime);
    else
        imwrite(A,map,animFilename, WriteMode="append", DelayTime=delayTime);
    end
end
