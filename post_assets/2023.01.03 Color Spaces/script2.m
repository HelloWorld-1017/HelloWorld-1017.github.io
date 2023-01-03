clc, clear, close all

[X, map] = imread('corn.tif');

figure("Units", "pixels", "Position", [215,276,761,352])
tiledlayout(1,2)
nexttile
imshow(X)
colorbar

nexttile
imshow(X, map)
colorbar

figure
nexttile
newmap = rgb2gray(map);
imshow(X, newmap)
colorbar