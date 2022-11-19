clc, clear, close all

pic = imread('test1.jpg');
colorNum = 5;

Rchannel = pic(:, :, 1);
Gchannel = pic(:, :, 2);
Bchannel = pic(:, :, 3);
RGBarray = double([Rchannel(:), Gchannel(:), Bchannel(:)]);

% k-means cluster
[idx, Centers] = kmeans(RGBarray, colorNum, ...
    'Distance', 'sqeuclidean', 'MaxIter', 1000);
Centers = round(Centers);

figure("Units", "pixels", "Position", [492.33, 324.33, 1472, 674])
tiledlayout(1, 2)

nexttile
imshow(pic)

nexttile
view(3)
hold(gca, "on")
grid(gca, "on")
box(gca, "on")
for i = 1:colorNum
    scatter3(RGBarray(idx==i, 1), RGBarray(idx==i, 2), RGBarray(idx==i, 3), ...
        'filled', 'CData', Centers(i,:)./255);
    legends{i}=[num2str(Centers(i,1)),' ',num2str(Centers(i,2)),' ',num2str(Centers(i,3))];
end
legend(legends, 'Color', [0.9412    0.9412    0.9412], ...
    'FontName','Cambria', 'LineWidth', 0.8, 'FontSize', 11)
ax = gca;
ax.GridLineStyle = '--';
ax.LineWidth = 1.2;

ax.XLabel.String = 'R channel';
ax.XLabel.FontSize = 13;
ax.XLabel.FontName = 'Cambria';

ax.YLabel.String = 'G channel';
ax.YLabel.FontSize = 13;
ax.YLabel.FontName = 'Cambria';

ax.ZLabel.String = 'B channel';
ax.ZLabel.FontSize = 13;
ax.ZLabel.FontName = 'Cambria';

exportgraphics(gcf, "pic1.png")