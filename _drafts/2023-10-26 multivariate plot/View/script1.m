clc,clear,close all

gifFileName = "gif.gif";
delayTime = 1/24;
firstFrame = true;

figure("Color","w")
ax = axes();
view(3)
hold(ax,"on")
set(ax,"XLim",[0,2],"YLim",[0,2],"ZLim",[0,2], ...
    "XDir","reverse","YDir","reverse","ZDir","normal","Visible","off")
axis(ax,"off")

sz = 20;
fontSize = 20;
plot3([0,1],[0,1],[0,1], ...
    "LineWidth",1.5,"Marker",".","Color","r","MarkerSize",sz)
text(1.2,1.2,1.2,"$(1,1,1)$","Interpreter","latex","FontSize",fontSize-3,"Color","r")
plot3([0,1],[0,0],[0,0], ...
    "LineWidth",1.5,"Marker",".","Color","k","MarkerSize",sz)
text(1.2,0,0,"$x$","Interpreter","latex","FontSize",fontSize)
plot3([0,0],[0,1],[0,0], ...
    "LineWidth",1.5,"Marker",".","Color","k","MarkerSize",sz)
text(0,1.2,0,"$y$","Interpreter","latex","FontSize",fontSize)
plot3([0,0],[0,0],[0,1], ...
    "LineWidth",1.5,"Marker",".","Color","k","MarkerSize",sz)
text(0,0,1.2,"$z$","Interpreter","latex","FontSize",fontSize)

angle = 0.5;
initialView = ax.View; % (-36.5,30)
angles1 = [initialView(1)*ones(1,47),...
    initialView(1):angle:-initialView(1),...
    -initialView(1)*ones(1,47),...
    -initialView(1):-angle:2*initialView(1),...
    2*initialView(1)*ones(1,47),...
    2*initialView(1):angle:initialView(1),...
    initialView(1)*ones(1,47)];
angles2 = [initialView(2):-angle:-initialView(2),...
    -initialView(2)*ones(1,47),...
    -initialView(2):angle:2*initialView(2),...
    2*initialView(2)*ones(1,47),...
    2*initialView(2):-angle:initialView(2)];
Azimuths = [angles1,initialView(1)*ones(size(angles2))];
Elevations = [initialView(2)*ones(size(angles1)),angles2];

for i = 1:numel(Azimuths)
    ax.View = [Azimuths(i),Elevations(i)];
    title(sprintf("Azimuth: %.1f, Elevation: %.1f",ax.View))
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

