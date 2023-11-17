clc,clear,close all

figure("Position",[1479,459.66,560,420])
set(gcf,"color","w")
ax = newplot;
hold(ax,"on"),box(ax,"on"),grid(gca,"minor")
daspect([1,1,1])

r = 1;
theta = linspace(0,2*pi,100);
x = r*cos(theta);
y = r*sin(theta);

plot(ax,x,y,"LineWidth",1.5,"Color","k")

gifFileName = "gif.gif";
fps = 24;
ps = gobjects(3,1);

for i = 1:numel(theta)
    ps(1) = plot([-1,1],[0,0], ...
        "LineWidth",1.5,"Color",0.7*ones(1,3),"LineStyle","--");
    ps(2) = plot([0,x(i)],[0,0], ...
        "LineWidth",1.5,"Marker",".","MarkerSize",20,"Color","g");
    ps(3) = plot([x(i),x(i)],[0,y(i)], ...
        "LineWidth",1.5,"Marker",".","MarkerSize",20,"Color","b");
    ps(4) = plot([0,x(i)],[0,y(i)], ...
        "LineWidth",1.5,"Marker",".","MarkerSize",20,"Color","r");
    scatter(0,0,30,"filled","k")
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if i == 1
        imwrite(A,map,gifFileName,"LoopCount",Inf,"DelayTime",1/fps)
    else
        for j = 1:fps
            imwrite(A,map,gifFileName,"WriteMode","append","DelayTime",1/fps)
        end
    end
    if i ~= numel(theta)
        delete(ps(2:end))
    end
end