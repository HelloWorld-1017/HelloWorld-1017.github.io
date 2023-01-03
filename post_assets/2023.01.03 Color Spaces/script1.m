clc, clear, close all

figure("Units", "pixels", "Position", [280,251,1303,541])
tiledlayout(1,2)

% RGB figure
nexttile
RGB = imread('peppers.png');
imshow(RGB)

% Grayscale figure
nexttile
I = rgb2gray(RGB);
imshow(I)