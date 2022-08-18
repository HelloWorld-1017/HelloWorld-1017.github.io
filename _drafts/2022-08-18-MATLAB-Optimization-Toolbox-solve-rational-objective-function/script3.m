% syms x
% eqn = x^5 == 3125;
% S = solve(eqn,x)

syms x
eqn = x^5 == 3125;
S = solve(eqn,x,"Real",true)