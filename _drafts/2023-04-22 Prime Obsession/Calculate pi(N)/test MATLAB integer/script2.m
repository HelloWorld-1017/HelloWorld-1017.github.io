clc,clear,close all

%% A is double
tic
A = ones(10^4);
A = helperAccumulation(A);
class(A)
toc

%% B is int64
% clear all
tic
B = int64(ones(10^4));
B = helperAccumulation(B);
class(B)
toc

function A = helperAccumulation(A)
for t = 1:100
    for columns = 1:width(A)
        for rows = 1:height(A)
            A(rows,columns) = A(rows,columns)+1;
        end
    end
end
end
