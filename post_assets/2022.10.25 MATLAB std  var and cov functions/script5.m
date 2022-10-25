clc, clear, close all

A = [2, 5;
    3, 3;
    4, 2;
    7, 4;
    9, 6];
mu = mean(A);

COV = ((A(1, :)-mu)'*(A(1, :)-mu)+...
    (A(2, :)-mu)'*(A(2, :)-mu)+...
    (A(3, :)-mu)'*(A(3, :)-mu)+...
    (A(4, :)-mu)'*(A(4, :)-mu)+...
    (A(5, :)-mu)'*(A(5, :)-mu))/(height(A)-1);
