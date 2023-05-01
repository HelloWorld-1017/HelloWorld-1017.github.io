clc,clear,close all

%% Call euclidean_mex.mexw64 function
load euclidean_data.mat
tic
for i = 1:1e7
    [y_min,y_max,idx,distance] = euclidean_mex(x,cb);
end
toc

%% Call euclidean.m function
clear all
load euclidean_data.mat
tic
for i = 1:1e7
    [y_min,y_max,idx,distance] = euclidean(x,cb);
end
toc