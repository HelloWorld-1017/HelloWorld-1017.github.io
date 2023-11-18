clc,clear,close all

gifFileName = "gif.gif";
if exist(gifFileName,"file")
    delete(gifFileName)
end
fps = 12;

num = 100;
for f = 1:num
    ps = helperDrawFrame(f);
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if f == 1
        imwrite(A,map,gifFileName,"LoopCount",Inf,"DelayTime",1/fps)
    else
        imwrite(A,map,gifFileName,"WriteMode","append","DelayTime",1/fps)
    end
    if f ~= num
        delete(ps)
    end
end

function ps = helperDrawFrame(f)
persistent fig theta x y FontSize XTickLabel ts ax h

% Initialize the figure and axes
if f == 1
    fig = figure("Position",[964.33,553,1528,368], ...
        "Color","w");
    tiledlayout(fig,2,3);
    ps = gobjects(3,1);

    theta = linspace(0,4*pi,100);
    x = cos(theta);
    y = sin(theta);
    FontSize = 13;
    XTickLabel = {'$$0$$','$$\pi$$','$$2\pi$$','$$3\pi$$','$$4\pi$$'};

    % For 1st axes
    ts.t1 = nexttile(1,[2,1]);
    ax.ax1 = newplot(ts.t1);
    hold(ax.ax1,"on"),box(ax.ax1,"on"),grid(ax.ax1,"minor")
    set(ax.ax1,"Xlim",[-1,1],"YLim",[-1,1], ...
        "FontSize",FontSize, ...
        "TickLabelInterpreter","latex")
    ax.ax1.Toolbar.Visible = "off";
    daspect(ax.ax1,[1,1,1])
    xlabel(ax.ax1,"$x$","Interpreter","latex","FontSize",FontSize)
    ylabel(ax.ax1,"$y$","Interpreter","latex","FontSize",FontSize)
    scatter(ax.ax1,0,0,30,"filled","k")
    plot(ax.ax1,[-1,1],[0,0], ...
        "LineWidth",1.5,"Color",0.7*ones(1,3),"LineStyle","--");
    plot(ax.ax1,x,y,"LineWidth",1.5,"Color","k")
    h.h1 = animatedline;

    % For 2nd axes
    ts.t2 = nexttile(2);
    ax.ax2 = newplot(ts.t2);
    ax.ax2.Toolbar.Visible = "off";
    set(ax.ax2,"Xlim",[0,theta(end)],"YLim",[-1,1], ...
        "XTick",0:pi:theta(end), ...
        "XTickLabel",XTickLabel, ...
        "TickLabelInterpreter","latex", ...
        "FontSize",FontSize)
    hold(ax.ax2,"on"),box(ax.ax2,"on"),grid(ax.ax2,"minor")
    h.h2 = animatedline(ax.ax2,"LineWidth",1.5,"Color","k");
    xlabel(ax.ax2,"$\theta$","Interpreter","latex","FontSize",FontSize)
    ylabel(ax.ax2,"$x$","Interpreter","latex","FontSize",FontSize)

    % For 3rd axes
    ts.t3 = nexttile(5);
    ax.ax3 = newplot(ts.t3);
    ax.ax3.Toolbar.Visible = "off";
    h.h3 = animatedline(ax.ax3,"LineWidth",1.5,"Color","k");
    set(ax.ax3,"Xlim",[0,theta(end)],"YLim",[-1,1], ...
        "XTick",0:pi:theta(end), ...
        "XTickLabel",XTickLabel, ...
        "TickLabelInterpreter","latex", ...
        "FontSize",FontSize)
    hold(ax.ax3,"on"),box(ax.ax3,"on"),grid(ax.ax3,"minor")
    xlabel(ax.ax3,"$\theta$","Interpreter","latex","FontSize",FontSize)
    ylabel(ax.ax3,"$y$","Interpreter","latex","FontSize",FontSize)

    % For 4th axes
    ts.t4 = nexttile(3,[2,1]);
    ax.ax4 = newplot(ts.t4);
    ax.ax4.Toolbar.Visible = "off";
    h.h4 = animatedline(ax.ax4,"LineWidth",1.5,"Color","k");
    h.h5 = animatedline(ax.ax4,"LineWidth",1.5,"Color","r");
    set(ax.ax4,"Xlim",[0,theta(end)],"YLim",[-pi-0.5,pi+0.5], ...
        "XTick",0:pi:theta(end), ...
        "XTickLabel",XTickLabel, ...
        "TickLabelInterpreter","latex", ...
        "FontSize",FontSize)
    hold(ax.ax4,"on"),box(ax.ax4,"on"),grid(ax.ax4,"minor")
    xlabel(ax.ax4,"$\theta$","Interpreter","latex","FontSize",FontSize)
end

% Plot for ax1
ps(1) = plot(ax.ax1,[0,x(f)],[0,0], ...
    "LineWidth",1.5,"Marker",".","MarkerSize",20,"Color","g");
ps(2) = plot(ax.ax1,[x(f),x(f)],[0,y(f)], ...
    "LineWidth",1.5,"Marker",".","MarkerSize",20,"Color","b");
ps(3) = plot(ax.ax1,[0,x(f)],[0,y(f)], ...
    "LineWidth",1.5,"Marker",".","MarkerSize",20,"Color","r");

% Plot for ax2
addpoints(h.h2,theta(f),x(f),20)
title(ax.ax2,sprintf("%s: %.2f, %s: %.2f","$\theta$",theta(f),"$x$",x(f)), ...
    "FontSize",FontSize,"Interpreter","latex")

% Plot for ax3
addpoints(h.h3,theta(f),y(f),20)
title(ax.ax3,sprintf("%s: %.2f, %s: %.2f","$\theta$",theta(f),"$y$",y(f)), ...
    "FontSize",FontSize,"Interpreter","latex")

% Plot for ax4
addpoints(h.h4,theta(f),atan2(x(f),y(f)),20)
addpoints(h.h5,theta(f),atan(x(f)/y(f)),20)
title(ax.ax4,sprintf("%s: %.2f, %s: %.2f, %s: %.2f", ...
    "$\theta$",theta(f),"atan($x$/$y$)",atan(x(f)/y(f)),"atan2($x$,$y$)",atan2(x(f),y(f))), ...
    "FontSize",FontSize,"Interpreter","latex")
end
