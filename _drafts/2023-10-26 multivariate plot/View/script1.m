clc,clear,close all

gifFileName = "gif.gif";
delayTime = 1/12;
firstFrame = true;

figure("Color","w")
ax = axes();
view(3)
hold(ax,"on"),box(ax,"on")
xlim([0,2]),ylim([0,2]),zlim([0,2])
plot3([0,1],[0,1],[0,1], ...
    "LineWidth",1.5,"Color","k")
scatter3(0,0,0,50,"filled","Marker","o","MarkerFaceColor","r")
scatter3(1,1,1,50,"filled","Marker","o","MarkerFaceColor","b")
ax.XDir = "reverse";
ax.YDir = "reverse";
ax.ZDir = "normal";

angle = 1;
num = 360/angle;
for i = 1:num

    ax.View = ax.View+[angle,0];
    title(sprintf("View:%.2f, %.2f",ax.View))
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if firstFrame
        firstFrame = false;
        imwrite(A,map,gifFileName,"LoopCount",Inf,"DelayTime",delayTime);
        pause(2)
    else
        imwrite(A,map,gifFileName,"WriteMode","append","DelayTime",delayTime);
    end
end

pause(1)

for i = 1:num
    ax.View = ax.View+[0,angle];
    title(sprintf("View:%.2f, %.2f",ax.View))
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if firstFrame
        firstFrame = false;
        imwrite(A,map,gifFileName,"LoopCount",Inf,"DelayTime",delayTime);
        pause(2)
    else
        imwrite(A,map,gifFileName,"WriteMode","append","DelayTime",delayTime);
    end
end


