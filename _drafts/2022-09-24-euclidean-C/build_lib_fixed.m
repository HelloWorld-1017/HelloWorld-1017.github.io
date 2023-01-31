% Load the test data
load euclidean_data.mat
% Generate code for euclidean.m with codegen. Use the test data as example
% input
codegen -report -config:lib euclidean.m -args {x, cb}