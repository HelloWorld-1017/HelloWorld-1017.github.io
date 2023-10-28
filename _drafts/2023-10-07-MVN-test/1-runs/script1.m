clc,clear,close all

samples = [44, 40, 33, 26, 27, 44, 46, 54, 50, 50, 51];
signs = diff(samples);
idx_minus = signs<0;
idx_plus = signs>0;
idx_zero = signs==0;
signs = string(signs);
signs(idx_minus) = "minus";
signs(idx_plus) = "plus";
signs(idx_zero) = [];

[totalRuns,runsInfo] = helperCountRuns(signs);