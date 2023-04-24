clc,clear,close all

numRange = [1e3,1e6,1e9,1e12,1e15,1e18];
nums = nan(1,numel(numRange));

for j = 1:numel(numRange)
    tic
    num = 0;
    for i = 1:numRange(j)
        PrimeIdx = isprime(i);
        num = num+PrimeIdx;
    end
    nums(j) = num;
    fprintf("%s,%s\n",num2str(numRange(j)),num2str(num))
    toc
end

% for i = 1:1000
%     numbers = (i-1)*1e6+1:i*1e6;
%     PrimeIdx = isprime(numbers);
%     numPrimes = sum(PrimeIdx);
% %     fprintf("[%s,%s]",num2str(min(numbers)),num2str(max(numbers)))
% %     disp(numPrimes)
% end