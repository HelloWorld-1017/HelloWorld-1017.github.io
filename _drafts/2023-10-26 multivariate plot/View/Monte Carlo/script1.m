clc,clear,close all

rng("default")
gifFileName = "gif.gif";
if exist(gifFileName,"file")
    delete(gifFileName)
end
fps = 24;

figure("Color","w","Position",[1000,918,631,420])

tiledlayout(3,3,"TileSpacing","tight")
nexttile(1,[3,2])
ax1 = gca();

nexttile(6)
ax2 = gca();

for f = 1:500
    helperDrawFrame(f,ax1,ax2)
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if f == 1
        imwrite(A,map,gifFileName,"LoopCount",Inf,"DelayTime",1/fps)
    else
        imwrite(A,map,gifFileName,"WriteMode","append","DelayTime",1/fps)
    end
end


function helperDrawFrame(f,ax1,ax2)
persistent total_points inside_points outside_points
if f == 1
    total_points = 0;
    inside_points = 0;
    outside_points = 0;
end

% Settings for ax1
set(ax1,"Xlim",[-1,1],"YLim",[-1,1], ...
    "FontSize",15,"FontName","Times New Roman", ...
    "LineWidth",1.2)
ax1.Toolbar.Visible = "off";
hold(ax1,"on"),box(ax1,"on")
daspect(ax1,[1,1,1])

% Settings for ax2
set(ax2,"Visible","off")
hold(ax2,"off")

% Carry out Monte Carlo simulation in ax1
pointsPerCount = f*700;
total_points = total_points+pointsPerCount;

x = 2*rand(1,pointsPerCount)-1;
y = 2*rand(1,pointsPerCount)-1;
d = sqrt(x.^2+y.^2);
idx = d<=1;

inside_points = inside_points+sum(idx);
outside_points = outside_points+sum(~idx);

theta = 0:0.01:2*pi;
plot(ax1,cos(theta),sin(theta),"LineWidth",1.5,"Color","k")
scatter(ax1,x(idx),y(idx),1,"b.");
scatter(ax1,x(~idx),y(~idx),1,"r.");

% Display information in ax2
cla(ax2)
estimatedPi = num2str(4*inside_points/total_points,"%.8f");
realPi = '3.14159265';
idx = find(diff(realPi(1:end)==estimatedPi(1:end)) == -1);
idx = idx(1);

FontSize = 15;
vSpace = 0.5;
text(ax2,0,3*vSpace,"Total points: "+num2str(total_points), ...
    "FontSize",FontSize,"FontName","Times New Roman")
text(ax2,0,2*vSpace,"Inside points: "+inside_points, ...
    "FontSize",FontSize,"FontName","Times New Roman")
text(ax2,0,1*vSpace,"Outside points: "+outside_points, ...
    "FontSize",FontSize,"FontName","Times New Roman")
text(ax2,0,0,"Real \pi: "+realPi,"InterPreter","tex", ...
    "FontSize",FontSize,"FontName","Times New Roman")
text(ax2,0,-1*vSpace, ...
    "Estimated \pi: "+"\color{blue}"+estimatedPi(1:idx)+"\color{red}"+estimatedPi(idx+1:end),...
    "InterPreter","tex","FontSize",FontSize,"FontName","Times New Roman")
end
