clc,clear,close all

load fisheriris
meas = meas(:,1:3);
sample = meas(7,:);
ts = -pi:0.1:pi;

vecs = [1/sqrt(2)*ones(1,numel(ts));sin(ts);cos(ts)];
gifFileName = "gif-24.gif";
delayTime = 1/24;
firstFrame = true;

figure("Color","w")
ax = gca();
hold(ax,"on"),box(ax,"on"),grid(ax,"on")
ax.LineWidth = 1.2;
xlim([-1,5]),ylim([-1,5]),zlim([-3,4])
% view(17.10,25.80)
% view(-30.30,7.20)
view(-9.9,7.8+10)
p1 = plot3([0,sample(1)],[0,sample(2)],[0,sample(3)], ...
    "Color","b","LineWidth",1.5,"Marker",".","MarkerSize",20, ...
    "DisplayName","sample");

for i = 1:width(vecs)
    vec = vecs(:,i);
    proj = dot(sample,vec)/(dot(vec,vec))*vec;
    p2 = plot3([0,vec(1)],[0,vec(2)],[0,vec(3)], ...
        "Color","r","LineWidth",1,"Marker",".","MarkerSize",20);
    p3 = plot3([0,proj(1)],[0,proj(2)],[0,proj(3)], ...
        "Color","k","LineWidth",1,"Marker",".","MarkerSize",20, ...
        "DisplayName","sample projection");
    if i == 1
        legend([p1,p2,p3],{'Sample','Vec','Projection'}, ...
            "Location","north","Orientation","horizontal");
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
% for i = 0:0.01:10
%     ax.View = ax.View+[0,i];
%     fig = gcf();
%     im = getframe(fig);
%     [A,map] = rgb2ind(im.cdata,256);
%     imwrite(A,map,gifFileName,"WriteMode","append","DelayTime",delayTime);
% end


