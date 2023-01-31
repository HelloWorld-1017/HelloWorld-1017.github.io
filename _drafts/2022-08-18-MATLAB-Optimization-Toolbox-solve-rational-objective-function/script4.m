syms x
eqn = exp(log(x)*log(3*x)) == 4;
% S = solve(eqn,x)

S = solve(eqn,x,'IgnoreAnalyticConstraints',true)