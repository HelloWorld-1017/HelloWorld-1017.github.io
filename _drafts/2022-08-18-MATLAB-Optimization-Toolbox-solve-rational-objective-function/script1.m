% Write objective function
x = optimvar('x');
y = optimvar('y');
f = (x-y)^2/(4+(x+y)^4)*(x+y^2)/(1+y^2);

% Create an optimization problem
prob = optimproblem('Objective',f);

% Set initial points, and call solve
x0.x = -1;
x0.y = 1;
[sol,fval,exitflag,output] = solve(prob,x0)