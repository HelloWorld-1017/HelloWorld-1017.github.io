clc,clear,close all

%% A is double
tic
A = helperAccumulation(double(ones(10^4)));
disp(class(A))
toc

%% B is single
% clear
tic
B = helperAccumulation(single(ones(10^4)));
disp(class(B))
toc

%% C is int8
% clear
tic
C = helperAccumulation(int8(ones(10^4)));
disp(class(C))
toc

%% D is int16
% clear
tic
D = helperAccumulation(int16(ones(10^4)));
disp(class(D))
toc

%% E is int32
% clear
tic
E = helperAccumulation(int32(ones(10^4)));
disp(class(E))
toc

%% F is int64
% clear
tic
F = helperAccumulation(int64(ones(10^4)));
disp(class(F))
toc

%% G is uint8
% clear
tic
G = helperAccumulation(uint8(ones(10^4)));
disp(class(G))
toc

%% H is uint16
% clear
tic
H = helperAccumulation(uint16(ones(10^4)));
disp(class(H))
toc

%% I is uint32
% clear
tic
I = helperAccumulation(uint32(ones(10^4)));
disp(class(I))
toc

%% J is uint64
% clear
tic
J = helperAccumulation(uint64(ones(10^4)));
disp(class(J))
toc

function matrix = helperAccumulation(matrix)
for t = 1:100
    for columns = 1:width(matrix)
        for rows = 1:height(matrix)
            matrix(rows,columns) = matrix(rows,columns)+1;
        end
    end
end
end
