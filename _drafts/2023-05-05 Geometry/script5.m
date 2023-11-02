clc,clear,close all

% A = [1,2,3;2,4,5;3,5,7];
A = ones(3,3);

[v,lambda] = eig(A);
v_1 = v(:,1);
v_2 = v(:,2);
v_3 = v(:,3);

% U = gramschmidt(v);

lambda
v*lambda*v'-A
% U*lambda*U'-A

function U = gramschmidt(V)
[n,k] = size(V);
U = zeros(n,k);
U(:,1) = V(:,1)/norm(V(:,1));
for i = 2:k
    U(:,i) = V(:,i);
    for j = 1:i-1
        U(:,i) = U(:,i)-(U(:,j)'*U(:,i))*U(:,j);
    end
    U(:,i) = U(:,i)/norm(U(:,i));
end
end