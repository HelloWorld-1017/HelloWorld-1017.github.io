function p = helperSignificanceTest(accus_mix_minus_generate, numTimes)
left = arrayfun(@(x) sprintf("x_%s", num2str(x)), 1:1:numTimes);
left = char(join(left, ','));
right = repmat("[1, -1]", 1, numTimes);
right = char(join(right, ','));

eval(sprintf('[%s] = ndgrid(%s);', left, right));
expression = arrayfun(@(x) sprintf("x_%s(:)", num2str(x)), 1:1:numTimes);
expression = char(join(expression, ','));
eval(sprintf('x = [%s];', expression))

sum_prob = x*accus_mix_minus_generate;

sum_prob = sort(abs(sum_prob), 'descend');

sum_obs = sum(accus_mix_minus_generate);
p = sum(sum_prob>=abs(sum_obs))/numel(sum_prob);
end