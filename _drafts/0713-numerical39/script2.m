a = 0.4; % lower limits
b = 1;    % upper limits
theta = 5e-7; % the minimum interval length
maxIteration = 200;
func = @(x) (x-2/3)^3;

[root, num, list_x, range_list] = BisectionMethod(func, a, b, theta, maxIteration);

function [root, num, list_x, range_list] = BisectionMethod(func, a, b, theta, maxIteration)
% Record the convergence process of x0
list_x = [];
% Record the interval length of each iteration
range_list = [];
num = 0;

% If upper and lower bounds of interval are wrong
if a > b || func(a) * func(b) > 0 || abs(a - b) < theta
    warning('Boundary setting error.')
    return
end

if func(a) * func(b) == 0
    if func(a) == 0
        root = a;
        return
    else
        root = b;
        return
    end
end

while (b-a)/2 > theta
    c = (a + b) / 2;
    list_x(num+1) = c;
    range_list(num+1) = abs(a-b);
    num = num + 1;

    if abs(func(c)) <= 0.5*eps
        root = c;
        return
    end

    if func(a) * func(c) < 0
        b = c;
    elseif func(a) * func(c) > 0
        a = c;
    end

    if num >= maxIteration
        warning("There maybe exists solution, but the algorithm does not converge.")
    end
end
root = (b+a)/2;
end



