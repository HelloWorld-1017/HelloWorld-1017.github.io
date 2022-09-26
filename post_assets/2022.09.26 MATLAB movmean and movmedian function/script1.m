clc, clear, close all

A = [4 8 6 -1 -2 -3 -1 3 4 5];
M1 = movmean(A, 3);
M2 = movmean(A, 3, 'Endpoints', 'discard');

M3 = movmean(A, 4);
M4 = movmean(A, 4, 'Endpoints', 'discard');

M5 = movmean(A, [2, 1]);
M6 = movmean(A, [2, 1], 'Endpoints', 'discard');


M7 = movmean(A, [2, 0]);
M8 = movmean(A, [2, 0], 'Endpoints', 'discard');