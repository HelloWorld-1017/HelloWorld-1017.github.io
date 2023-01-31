% Load the test data
load euclidean_data.mat
% Generate code for euclidean.m with codegen. Use the test data as example 
% input. Validate MEX by using test.m.
codegen -report euclidean.m -args {x, cb} -test test