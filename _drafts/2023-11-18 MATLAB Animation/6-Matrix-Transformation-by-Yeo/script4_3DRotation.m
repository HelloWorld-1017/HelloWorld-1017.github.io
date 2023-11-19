clc,clear,close all

contestAnimator()

function contestAnimator()
animFilename = "gif.gif";
fps = 24;
% Create the gif
for frame = 1:48
    drawframe(frame)
    fig = gcf();
    im = getframe(fig);
    [A,map] = rgb2ind(im.cdata,256);
    if frame == 1
        imwrite(A,map,animFilename,"LoopCount",Inf,"DelayTime",1/fps);
    else
        imwrite(A,map,animFilename,"WriteMode","append","DelayTime",1/fps);
    end
end
end

function drawframe(f)
cla
set(gcf,"Color",[1,1,0.85])
view(3)
daspect(gca(),[1,1,1])

axis padded off

% matrix = [0, 1; 
%     1, 0];

rng("default")
% matrix = [1,2,0;1,2,0;1,1,1];
matrix = randn(3);

[x,y,z] = meshgrid(-9:3:9);

beginningPoints = [];
enddingPoints = [];

% 2-3
for i = 1:size(x,2)
    for j = 1:size(x,3)
        beginningPoints = [beginningPoints;x(i,1,j),y(i,1,j),z(i,1,j)];
        enddingPoints = [enddingPoints;x(i,end,j),y(i,end,j),z(i,end,j)];
    end
end

% 1-3
for i = 1:size(x,1)
    for j = 1:size(x,3)
        beginningPoints = [beginningPoints;x(1,i,j),y(1,i,j),z(1,i,j)];
        enddingPoints = [enddingPoints;x(end,i,j),y(end,i,j),z(end,i,j)];
    end
end

% 1-2
for i = 1:size(x,1)
    for j = 1:size(x,2)
        beginningPoints = [beginningPoints;x(i,j,1),y(i,j,1),z(i,j,1)];
        enddingPoints = [enddingPoints;x(i,j,end),y(i,j,end),z(i,j,end)];
    end
end

% setBasicCanvas(vu,vd,hl,hr);
mtx4vis = eye(3)+(matrix-eye(3))*((f-1)/(48-1));

aa = mtx4vis*beginningPoints';
aa = aa';

bb = mtx4vis*enddingPoints';
bb = bb';

for i = 1:height(beginningPoints)
    plot3([beginningPoints(i,1),enddingPoints(i,1)], ...
        [beginningPoints(i,2),enddingPoints(i,2)], ...
        [beginningPoints(i,3),enddingPoints(i,3)], ...
        "Color",[0.3,0.3,0.3],"LineWidth",0.5);
end

for i = 1:height(aa)
    plot3([aa(i,1),bb(i,1)], ...
        [aa(i,2),bb(i,2)], ...
        [aa(i,3),bb(i,3)], ...
        "Color",[0.3,0.3,0.3],"LineWidth",0.1);
end
axis([-9,9,-9,9,-9,9])

drawArrow([0,0,0],mtx4vis*[3;0;0],"r");
drawArrow([0,0,0],mtx4vis*[0;3;0],"g");
drawArrow([0,0,0],mtx4vis*[0;0;3],"b");

    function setBasicCanvas(vu,vd,hl,hr)
        set(gcf,"color","k","Position",[759.67,459,895.99,747.33])
        ax = newplot;
        daspect(ax, [1,1,1])
        set(ax,"position",[0 0 1 1],"visible","off")
        ax.Toolbar.Visible = "off";
        axis([-6,6,-6,6,-6,6])
%         plotLines(vu,vd);
%         plotLines(hl,hr);
    end

    function h = drawArrow(p1,p2,color)
        dp = p2-p1;
        hold on;
        h = quiver3(p1(1),p1(2),p1(3),dp(1),dp(2),dp(3), ...
            "filled","Color",color,"linewidth",2,"MaxHeadSize",0.5);
    end

%     function h = plotLines(v,color)
%         if nargin < 3
%             color = ones(1,3)*0.3;
%         end
%         assert(length(v1) == length(v2), ...
%             "The two input vectors must have same length!")
%         for i = 1:length(v1)
%             h(i) = line([v1(1, i), v2(1, i)], [v1(2, i), v2(2, i)],[v1(3, i), v2(3, i)], ...
%                 "color",color,"linewidth",0.5);
%         end
%     end
end