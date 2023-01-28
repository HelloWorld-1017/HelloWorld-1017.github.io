clc, clear, close all

figure
tiledlayout(3,2)
for i = [8,4,2]
    nexttile
    a = RectanglePulse(i,20,20,20);
    a.Plot;

    nexttile
    a.PlotUniSpec;
    hold on
    a.PlotBiSpec;
end