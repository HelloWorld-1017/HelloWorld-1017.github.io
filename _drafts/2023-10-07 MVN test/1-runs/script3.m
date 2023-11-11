clc,clear,close all

samples = [47,44,49,48,50,51,45];
idx = samples == median(samples);
samples = string(double(samples>median(samples)));
samples(idx) = [];

[totalRuns,runsInfo] = helperCountRuns(samples);