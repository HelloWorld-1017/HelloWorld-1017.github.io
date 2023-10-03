clc,clear,close all

for i = 1:8
    a = rand(1,20);
    figure("Visible","off")
    hold(gca,"on"),grid(gca,"on"),box(gca,"on")
    plot(a,"Color","black","Marker","o","LineWidth",1.5)
    set(gca,"PlotBoxAspectRatio",[1 1 1], ...
        "LineWidth",1.2,"FontName","Times New Roman","FontSize",20)
    hold(gca,"off")
    exportgraphics(gca,sprintf("pic-%s.pdf",num2str(i)),"Resolution",600)
end
