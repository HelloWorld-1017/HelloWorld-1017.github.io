clc, clear, close all

x = 1:0.1:4;
y = x.^2;

fileFormats = [".jpg", ".tif"];
resolutions = [300, 600, 900, 1000, 2400];
for i = 1:numel(fileFormats)
    for j = 1:numel(resolutions)
        figure
        plot(x, y, 'Marker', 'o', LineWidth=1.5)
        title(strcat("Resolution: ", num2str(resolutions(j)), ", File Format: ", fileFormats(i)))
        box on
        exportgraphics(gcf, strcat("pic", num2str(resolutions(j)), fileFormats(i)), 'Resolution', resolutions(j))
    end
end