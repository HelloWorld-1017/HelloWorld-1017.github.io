clc,clear,close all

load fisheriris
figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
andrewsplot(meas,"group",species,"LineWidth",1.2)