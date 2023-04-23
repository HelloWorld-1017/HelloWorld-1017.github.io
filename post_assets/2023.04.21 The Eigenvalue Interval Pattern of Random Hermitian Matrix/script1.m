clc,clear,close all
rng("default")

% Construct Hermitian matrix
A = randn(269);
HReal = tril(A,-1)+triu(A',0);
DiagCoeff = sqrt(2)*diag(ones(269,1));
DiagCoeff(DiagCoeff==0) = 1;
HReal = DiagCoeff.*HReal;
B = randn(269);
Hcomplex = tril(B,-1)-triu(B',0);
Hcomplex = (1-diag(ones(269,1))).*Hcomplex;
H = HReal+Hcomplex*1i;

EigValues = eig(H);
disp(min(EigValues))
disp(max(EigValues))

% Random ponits drawn from uniform distribution
RandomPoints = rand(1,269)*(max(EigValues)-min(EigValues))+min(EigValues);
RandomPoints = sort(RandomPoints);

figure('Units','pixels','Position',[71,482.33,2399.33,253.99])
hold(gca,'on')
box(gca,'on')
grid(gca,'on')
scatter(EigValues,2*ones(1,numel(EigValues)),10, ...
    'filled','MarkerFaceColor',[7,84,213]/255, ...
    'DisplayName','Eigenvalues of Hermitian matrix')
scatter(RandomPoints,ones(1,numel(RandomPoints)),10, ...
    'filled','MarkerFaceColor',[249,82,107]/255,...
    'DisplayName','Uniform distribution random points')
legend()
set(gca,'yticklabel',[])
xlim([-50,50])
ylim([0.5,2.5])
xlabel("Value")