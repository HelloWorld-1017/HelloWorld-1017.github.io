clc,clear,close all
rng("default")

% Construct Hermitian matrix
A = randn(269);
HReal = tril(A,-1)+triu(A',0);
B = randn(269);
Hcomplex = tril(B,-1)-triu(B',0);
Hcomplex = (1-diag(ones(269,1))).*Hcomplex;
H = HReal+Hcomplex*1i;

EigValues = eig(H);

for i = 1:10
    idx = find(EigValues>-50&EigValues<-40);
    SelectedEigValues = EigValues(idx);
    
end


% scatter(1:numel(v),v,'filled')
% 
% RandomPoints = rand(1,269)*10;
% scatter(1:numel(RandomPoints),RandomPoints)