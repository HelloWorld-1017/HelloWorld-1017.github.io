clc,clear,close all

primes1 = primes(10^9);
primes1 = gpuArray(primes1);

num1 = numel(primes1);
num1 = gpuArray(num1);
disp('done')


for i = 10^9+1:2:20^9
    isp = all(rem(i, primes1(primes1<=sqrt(i))));
    num1 = num1+isp;
end

% GPU占用率很高，但还是不行。。。还是太慢了