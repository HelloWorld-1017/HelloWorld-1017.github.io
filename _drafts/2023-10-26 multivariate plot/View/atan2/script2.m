clc,clear,close all

r = 1;
theta = linspace(0,4*pi,100);
x = r*cos(theta);
y = r*sin(theta);

XTickLabel = {'$$0$$','$$\pi$$','$$2\pi$$','$$3\pi$$','$$4\pi$$'};
FontSize = 13;
titleFontSize = FontSize-3;

figure("Position",[964.33,553,1528,368])
tiledlayout(2,3)
set(gcf,"color","w")

nexttile(1,[2,1])
ax1 = newplot;
set(ax1,"Xlim",[-1,1],"YLim",[-1,1], ...
    "FontSize",FontSize, ...
    "TickLabelInterpreter","latex")
hold(ax1,"on"),box(ax1,"on"),grid(ax1,"minor")
daspect([1,1,1])

nexttile(2)
ax2 = newplot;
h2 = animatedline(ax2,"LineWidth",1.5,"Color","k");
set(ax2,"Xlim",[0,theta(end)],"YLim",[-1,1], ...
    "XTick",0:pi:theta(end), ...
    "XTickLabel",XTickLabel, ...
    "TickLabelInterpreter","latex", ...
    "FontSize",FontSize)
hold(ax2,"on"),box(ax2,"on"),grid(ax2,"minor")
% daspect([1,1,1])

nexttile(5)
ax3 = newplot;
h3 = animatedline(ax3,"LineWidth",1.5,"Color","k");
set(ax3,"Xlim",[0,theta(end)],"YLim",[-1,1], ...
    "XTick",0:pi:theta(end), ...
    "XTickLabel",XTickLabel, ...
    "TickLabelInterpreter","latex", ...
    "FontSize",FontSize)
hold(ax3,"on"),box(ax3,"on"),grid(ax3,"minor")
% daspect([1,1,1])

nexttile(3,[2,1])
ax4 = newplot;
h4 = animatedline(ax4,"LineWidth",1.5,"Color","k");
h5 = animatedline(ax4,"LineWidth",1.5,"Color","r");
set(ax4,"Xlim",[0,theta(end)],"YLim",[-pi-0.5,pi+0.5], ...
    "XTick",0:pi:theta(end), ...
    "XTickLabel",XTickLabel, ...
    "TickLabelInterpreter","latex", ...
    "FontSize",FontSize)
hold(ax4,"on"),box(ax4,"on"),grid(ax4,"minor")
% daspect([1,1,1])

plot(ax1,x,y,"LineWidth",1.5,"Color","k")

gifFileName = "gif.gif";
fps = 24;
ps = gobjects(10,1);

for f = 1:numel(theta)
    % Plot for ax1
    ps(1) = plot(ax1,[-1,1],[0,0], ...
        "LineWidth",1.5,"Color",0.7*ones(1,3),"LineStyle","--");
    ps(2) = plot(ax1,[0,x(f)],[0,0], ...
        "LineWidth",1.5,"Marker",".","MarkerSize",20,"Color","g");
    ps(3) = plot(ax1,[x(f),x(f)],[0,y(f)], ...
        "LineWidth",1.5,"Marker",".","MarkerSize",20,"Color","b");
    ps(4) = plot(ax1,[0,x(f)],[0,y(f)], ...
        "LineWidth",1.5,"Marker",".","MarkerSize",20,"Color","r");
    xlabel(ax1,"$x$","Interpreter","latex","FontSize",FontSize)
    ylabel(ax1,"$y$","Interpreter","latex","FontSize",FontSize)
    scatter(ax1,0,0,30,"filled","k")

    % Plot for ax2
    addpoints(h2,theta(f),x(f),20)
    title(ax2,sprintf("theta: %.2f, x: %.2f",theta(f),x(f)),"FontSize",titleFontSize)
    xlabel(ax2,"$\theta$","Interpreter","latex","FontSize",FontSize)
    ylabel(ax2,"$x$","Interpreter","latex","FontSize",FontSize)

    % Plot for ax3
    addpoints(h3,theta(f),y(f))
%     scatter(ax3,theta(f),y(f),20,"filled","k")
    title(ax3,sprintf("theta: %.2f, y: %.2f",theta(f),y(f)),"FontSize",titleFontSize)
    xlabel(ax3,"$\theta$","Interpreter","latex","FontSize",FontSize)
    ylabel(ax3,"$y$","Interpreter","latex","FontSize",FontSize)

    % Plot for ax4
    addpoints(h4,theta(f),atan2(x(f),y(f)))
    addpoints(h5,theta(f),atan(x(f)/y(f)))
%     scatter(ax4,theta(f),atan2(x(f),y(f)),20,"filled","k")
%     scatter(ax4,theta(f),atan(x(f)/y(f)),5,"filled","r")
    title(ax4,sprintf("theta: %.2f, atan(x/y): %.2f, atan2(x,y): %.2f", ...
        theta(f),atan(x(f)/y(f)),atan2(x(f),y(f))),"FontSize",titleFontSize)
    xlabel(ax4,"$\theta$","Interpreter","latex","FontSize",FontSize)

    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if f == 1
        imwrite(A,map,gifFileName,"LoopCount",Inf,"DelayTime",1/fps)
    else
        for j = 1:fps/2
            imwrite(A,map,gifFileName,"WriteMode","append","DelayTime",1/fps)
        end
    end
    if f ~= numel(theta)
        delete(ps(2:end))
    end
end