clc, clear, close all

% A, 1-by-4; B, 1-by-4
C = bsxfun(@(a, b) a-b, [1, 2, 3, 4], [6, 9, 7, 10]);

% A, 3-by-1; B, 3-by-1
C = bsxfun(@(a, b) a-b, [1, 2, 3]', [6, 9, 7]');

% A, 3-by-1; B, 1-by-4
C = bsxfun(@(a, b) a-b, [1, 2, 3]', [6, 9, 7, 10]);

% A, 1-by-3; B, 4-by-1
C = bsxfun(@(a, b) a-b, [1, 2, 3], [6, 9, 7, 10]');
