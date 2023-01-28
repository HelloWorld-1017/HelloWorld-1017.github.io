clc, clear, close all

figure
tiledlayout(3,2)
for i = [4,8,16]
    nexttile
    a = RectanglePulse(1,i,20,20);
    a.Plot;

    nexttile
    a.PlotUniSpec;
    hold on
    a.PlotBiSpec;
end