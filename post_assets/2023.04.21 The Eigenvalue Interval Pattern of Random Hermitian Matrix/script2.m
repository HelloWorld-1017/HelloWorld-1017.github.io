clc,clear,close all
rng("default")

% Construct real symmetric matrix
A = randn(269);
H = tril(A,-1)+triu(A',0);
DiagCoeff = sqrt(2)*diag(ones(269,1));
DiagCoeff(DiagCoeff==0) = 1;
H = DiagCoeff.*H;

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