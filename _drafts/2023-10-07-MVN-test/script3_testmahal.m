clc,clear,close all

load fisheriris.mat
meas = meas(1:50,:);

[n,k] = size(meas);
mu = mean(meas);

% Calculate the sum of m_ii by matrix multiplication (biased)
Sigma_biased = cov(meas,1); % biased SCM
b_biased = ((meas-mu)/Sigma_biased*(meas-mu)').^2;
b_biased = sum(b_biased.*diag(ones(1,height(b_biased))),"all")/n;

% Calculate the sum of m_ii by matrix multiplication (unbiased)
Sigma_unbiased = cov(meas,0); % deffault setting: 0, unbiased SCM
b_unbiased = ((meas-mu)/Sigma_unbiased*(meas-mu)').^2;
b_unbiased = sum(b_unbiased.*diag(ones(1,height(b_unbiased))),"all")/n;

% Calculate the sum of m_ii by `mahal` function
b_mahal= mean(mahal(meas,meas).^2);

fprintf("Calculate the sum of m_ii by matrix multiplication(biased): %.4f,\n" + ...
    "Calculate the sum of m_ii by matrix multiplication (unbiased): %.4f,\n" + ...
    "Calculate the sum of m_ii by `mahal` function: %.4f.\n", ...
    b_biased,b_unbiased,b_mahal)