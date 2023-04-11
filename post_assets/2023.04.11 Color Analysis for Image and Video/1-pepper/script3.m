clc,clear,close all

rgb = imread('peppers.png');
r = rgb(:,:,1);
g = rgb(:,:,2);
b = rgb(:,:,3);

hold(gca,"on")
box(gca,"on")
grid(gca,"on")
histogram(r,'BinMethod','integers','FaceColor','r','EdgeAlpha',0,'FaceAlpha',1)
histogram(g,'BinMethod','integers','FaceColor','g','EdgeAlpha',0,'FaceAlpha',0.5)
histogram(b,'BinMethod','integers','FaceColor','b','EdgeAlpha',0,'FaceAlpha',0.5)
xlabel('RGB value')
ylabel('Frequency')
title('Color histogram in RGB color space')
xlim([0 257])