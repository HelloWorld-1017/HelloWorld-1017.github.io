clc,clear,close all

gifFileName = "gif.gif";
delayTime = 1/24;
firstFrame = true;



fig = figure("Color","w","Position",[381,462.33,1198,471.33]);
tiledlayout(fig,1,2)
nexttile
ax1 = gca();
helperCreateAxes(ax1)

nexttile
ax2 = gca();
helperCreateAxes(ax2)


angle = 0.5;
initialView = ax1.View; % (-36.5,30)
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

r = 1;
x = r*sin(Elevations/180*pi).*cos(Azimuths/180*pi);
y = r*sin(Elevations/180*pi).*sin(Azimuths/180*pi);
z = r*cos(Elevations/180*pi);
% x = r*sin(Azimuths/180*pi).*cos(Elevations/180*pi);
% y = r*sin(Azimuths/180*pi).*sin(Elevations/180*pi);
% z = r*cos(Azimuths/180*pi);

for i = 1:numel(Azimuths)
    view(ax1,[Azimuths(i),Elevations(i)]);
    title(ax1,sprintf("Azimuth: %.1f, Elevation: %.1f",Azimuths(i),Elevations(i)))

    view(ax2,[x(i),y(i),z(i)])
    title(ax2,sprintf("x: %.2f, y: %.2f, z: %.2f",x(i),y(i),z(i)))

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

function helperCreateAxes(ax)
view(3)
hold(ax,"on")
set(ax,"XLim",[0,2],"YLim",[0,2],"ZLim",[0,2], ...
    "XDir","reverse","YDir","reverse","ZDir","normal")
axis(ax,"off")

sz = 20;
FontSize = 20;
LineWidth = 1.5;
plot3(ax,[0,1],[0,1],[0,1], ...
    "LineWidth",LineWidth,"Marker",".","Color","r","MarkerSize",sz)
text(ax,1.2,1.2,1.2,"$(1,1,1)$","Interpreter","latex","FontSize",FontSize-3,"Color","r")
plot3(ax,[0,1],[0,0],[0,0], ...
    "LineWidth",LineWidth,"Marker",".","Color","k","MarkerSize",sz)
text(ax,1.2,0,0,"$x$","Interpreter","latex","FontSize",FontSize)
plot3(ax,[0,0],[0,1],[0,0], ...
    "LineWidth",LineWidth,"Marker",".","Color","k","MarkerSize",sz)
text(ax,0,1.2,0,"$y$","Interpreter","latex","FontSize",FontSize)
plot3([0,0],[0,0],[0,1], ...
    "LineWidth",LineWidth,"Marker",".","Color","k","MarkerSize",sz)
text(ax,0,0,1.2,"$z$","Interpreter","latex","FontSize",FontSize)
end

