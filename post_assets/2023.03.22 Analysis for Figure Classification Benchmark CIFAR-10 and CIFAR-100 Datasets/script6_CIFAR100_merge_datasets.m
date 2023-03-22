clc,clear,close all

[X_train,Y_train_coarse,Y_train_fine,filenames_train] = loadBatchAsFourDimensionalArray('train.mat');
[X_test,Y_test_coarse,Y_test_fine,filenames_test] = loadBatchAsFourDimensionalArray('test.mat');
data = cat(4,X_train,X_test);
coarse_labels = [Y_train_coarse;Y_test_coarse];
fine_labels = [Y_train_fine;Y_test_fine];
filenames = [filenames_train;filenames_test];

save("CIFAR-100.mat","data","coarse_labels","fine_labels","filenames")

function [XBatch,coarse_categoricalLabels,fine_categoricalLabels,filenames] = loadBatchAsFourDimensionalArray(filename)
s = load(filename);
XBatch = s.data';
XBatch = reshape(XBatch,32,32,3,[]);
XBatch = permute(XBatch,[2 1 3 4]);
[coarse_categoricalLabels,fine_categoricalLabels] = convertLabelsToCategorical(s.coarse_labels,s.fine_labels);
filenames = s.filenames;
end

function [coarse_categoricalLabels,fine_categoricalLabels] = ...
    convertLabelsToCategorical(coarse_integerLabels,fine_integerLabels)
s = load("meta.mat");
coarse_categoricalLabels = categorical(coarse_integerLabels,0:19,s.coarse_label_names);
fine_categoricalLabels = categorical(fine_integerLabels,0:99,s.fine_label_names);
end
