clc, clear, close all

Sigma = diag(1:15);
dfs = [1e1, 1e2, 1e3, 1e4, 1e5, 1e6];
figure('Units', 'pixels', 'Position', [767, 409, 856, 633])
tiledlayout(2, 3, 'TileSpacing', 'tight', 'Padding', 'tight')
for i = 1:numel(dfs)
    df = dfs(i);
    S = wishrnd(Sigma, df)/df;
    nexttile
    imagesc(S)
    title(sprintf("n=%d", df))
    axis off
    colorbar
    set(gca, 'PlotBoxAspectRatio', [1, 1, 1])
end

exportgraphics(gcf, 'pic2.jpg', Resolution=300)
