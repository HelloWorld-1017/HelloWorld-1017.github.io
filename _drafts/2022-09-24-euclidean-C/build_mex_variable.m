% Load the test data
load euclidean_data.mat

% Use coder.typeof to specify variable-size inputs
eg_x=coder.typeof(x,[3 1],1);
eg_cb=coder.typeof(cb,[3 216],1);

% Generate code for euclidean.m using coder.typeof to specify
% upper bounds for the example inputs
codegen -report euclidean.m -args {eg_x,eg_cb}