syms a b c d x
eqn = a*x^3 + b*x^2 + c*x + d == 0;

S = solve(eqn, x, 'MaxDegree', 3)
