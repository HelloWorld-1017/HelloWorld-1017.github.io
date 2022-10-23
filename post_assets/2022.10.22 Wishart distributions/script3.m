clc, clear, close all

Sigma = eye(15);
dfs = [5e1, 1e2, 1e3, 1e4, 1e5, 1e6];
figure('Units', 'pixels', 'Position', [767, 409, 856, 633])
tiledlayout(2, 3, 'TileSpacing', 'tight', 'Padding', 'tight')
for i = 1:numel(dfs)
    df = dfs(i);
    S = iwishrnd(Sigma, df)*(df-15-1);
    nexttile
    imagesc(S)
    title(sprintf("n=%d", df))
    axis off
    colorbar
    set(gca, 'PlotBoxAspectRatio', [1, 1, 1])
end

exportgraphics(gcf, 'pic3.jpg', Resolution=300)
