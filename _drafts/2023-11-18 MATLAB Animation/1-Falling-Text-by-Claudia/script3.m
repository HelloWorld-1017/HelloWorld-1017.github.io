clc,clear,close all

% Falling string
string = 'MATLAB';

fig = figure("Units","pixels","Position",[453.66,462.33,560,419.99]);
% z = zoom(ax);
% z.Enable = "off";
fig.MenuBar = "none";
fig.ToolBar = "none";

ax = gca();
hold(ax,"on"),box(ax,"on")

disableDefaultInteractivity(ax)
ax.Toolbar.Visible = "off";

xticks(-0.2:0.1:0.8)
set(ax,"XLim",[-0.2,0.8],"YLim",[0,1],"LineWidth",1.5)
colors = get(ax,"ColorOrder");

len = length(string);
x = 0.1*(1:len);
y = 0.7*ones(len,1);

yline(ax,y,"Color","b","LineWidth",1.5,"LineStyle","-")
arrayfun(@(x) xline(ax,x,"Color","b","LineWidth",1.5,"LineStyle","-"),x)
scatter(ax,x,y,70,"filled", ...
    "Marker","hexagram","MarkerFaceColor","r");

ts = gobjects(len,1);
for i = 1:len
    ts(i) = text(ax,x(i),y(i),string(i), ...
        "Rotation",0, ...
        "FontName","Times New Roman", ...
        "FontSize",30,"Color",colors(i,:), ...
        "EdgeColor","k","LineWidth",0.5,...
        "BackgroundColor","w", ...
        "Margin",3, ...
        "HorizontalAlignment","right", ...
        "VerticalAlignment","cap");
    extents = ts(i).Extent;
    scatter(ax,extents(1),extents(2),20,"filled", ...
        "Marker","o","MarkerFaceColor","k")
    scatter(ax,extents(1)+extents(3),extents(2),20,"filled", ...
        "Marker","o","MarkerFaceColor","k")
    scatter(ax,extents(1),extents(2)+extents(4),20,"filled", ...
        "Marker","o","MarkerFaceColor","k")
    scatter(ax,extents(1)+extents(3),extents(2)+extents(4),20,"filled", ...
        "Marker","o","MarkerFaceColor","k")
end

