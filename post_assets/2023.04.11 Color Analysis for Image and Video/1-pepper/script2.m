clc,clear,close all

rgb = imread('peppers.png');

r = rgb(:,:,1);
g = rgb(:,:,2);
b = rgb(:,:,3);

figure('Units','pixels','Position',[805,413.67,1406,420])
colormap('jet')
tiledlayout(1,3)
nexttile
histogram2(r,g,'DisplayStyle','tile','ShowEmptyBins','on', ...
    'XBinLimits',[0 255],'YBinLimits',[0 255],'EdgeColor','none');
ax = gca;
ax.CLim = [0 500];
axis equal
colorbar
xlabel('Red Values')
ylabel('Green Values')
title('Green vs. Red Pixel Components')

nexttile
histogram2(r,b,'DisplayStyle','tile','ShowEmptyBins','on',...
    'XBinLimits',[0 255],'YBinLimits',[0 255],'EdgeColor','none');
ax = gca;
ax.CLim = [0 500];
axis equal
colorbar
xlabel('Red Values')
ylabel('Blue Values')
title('Blue vs. Red Pixel Components')


nexttile
histogram2(g,b,'DisplayStyle','tile','ShowEmptyBins','on',...
    'XBinLimits',[0 255],'YBinLimits',[0 255],'EdgeColor','none');
ax = gca;
ax.CLim = [0 500];
axis equal
colorbar
xlabel('Green Values')
ylabel('Blue Values')
title('Green vs. Blue Pixel Components')






