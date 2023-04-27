clc,clear,close all

%% First row, second column
tic
A = ones(10^4);
for t = 1:100
    for j = 1:height(A)
        for i = 1:width(A)
            A(i,j) = A(i,j)+1;
        end
    end
end
toc

%% First column, second row
clear all

tic
B = ones(10^4);
for t = 1:100
    for i = 1:width(B)
        for j = 1:height(B)
            B(i,j) = B(i,j)+1;
        end
    end
end
toc
