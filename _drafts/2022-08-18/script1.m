syms x1(t) x2(t)
eqns = [diff(x1, t)==x2, diff(x2, t)==-x1 - x2];
conds = [x1(0)==0, x2(0)==0];
S = dsolve(eqns);