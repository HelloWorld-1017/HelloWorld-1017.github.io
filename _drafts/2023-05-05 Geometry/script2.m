clc,clear,close all

rng("default")
A = [1,3;2,4];

[lamda1,v1] = eig(A)
[lamda2,v2] = eig(A')