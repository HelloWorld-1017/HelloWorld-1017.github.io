% create 'test.mat'
p = rand(1,10);
q = ones(10);
save('test.mat','p','q')

% List variables in 'test.mat'
whos('-file','test.mat')

% append 'a' in 'test.mat'
a = 50;
save('test.mat','a','-append')

% List varibles in new 'test.mat'
whos('-file','test.mat')