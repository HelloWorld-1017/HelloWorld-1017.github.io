clc,clear,close all

load test_batch.mat

[ClassVariable,Class] = findgroups(labels);
nums = splitapply(@numel, labels, ClassVariable);

disp(nums')