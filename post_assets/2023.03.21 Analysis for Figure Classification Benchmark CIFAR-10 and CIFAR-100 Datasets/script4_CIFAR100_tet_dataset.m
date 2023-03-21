clc,clear,close all

load test.mat

% For superclass
[ClassVariable,~] = findgroups(coarse_labels);
nums_superclass = splitapply(@numel, coarse_labels, ClassVariable);
disp(nums_superclass')

% For class
[ClassVariable,~] = findgroups(fine_labels);
nums_class = splitapply(@numel, fine_labels, ClassVariable);
disp(nums_class')