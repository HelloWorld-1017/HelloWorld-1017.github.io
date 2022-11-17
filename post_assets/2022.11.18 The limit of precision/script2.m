a = 0; 
b = 1; 
epsilon = 5e-7; 
maxIteration = 200;
func = @(x) (x-2/3).^3;

[root, num, list_x, range_list] = BisectionMethod(func, a, b, epsilon, maxIteration);


function [root, num, list_x, range_list] = BisectionMethod(func, a, b, epsilon, maxIteration)
% Record the convergence process of x0
list_x = [];
% Record the interval length of each iteration
range_list = [];
num = 0;

% If upper and lower bounds of interval are wrong
if a > b || func(a) * func(b) > 0 || abs(a - b) < epsilon
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

while (b-a)/2 > epsilon
    c = (a + b) / 2;
    list_x(num+1) = c;
    range_list(num+1) = abs(a-b);
    num = num + 1;
    
%     if func(c) == 0
    if abs(func(c)-0) <= 0.5*eps
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



