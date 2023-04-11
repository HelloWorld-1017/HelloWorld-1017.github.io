clc,clear,close all

rgb = imread('peppers.png');
% imshow(rgb)

r = rgb(:,:,1);
g = rgb(:,:,2);
b = rgb(:,:,3);
colormap('jet')
histogram2(r,g,'DisplayStyle','tile','ShowEmptyBins','on', ...
    'XBinLimits',[0 255],'YBinLimits',[0 255],'EdgeColor','none');
axis equal
colorbar
xlabel('Red Values')
ylabel('Green Values')
title('Green vs. Red Pixel Components')

