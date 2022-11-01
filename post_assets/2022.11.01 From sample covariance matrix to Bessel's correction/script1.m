clc, clear, close all

population = [0, 0, 0, 1, 2, 9];
for i = 2:6
    % Sample number
    n = i;

    % Calculate average of sample variance
    samples = nchoosek(population, n);
    means = mean(samples, 2);
    % Unbiased
    UnbiasedVars = sum((samples-means).^2/(n-1), 2);
    averageUnBiasedSampleVar = mean(UnbiasedVars);
    % Biased
    BiasedVars = sum((samples-means).^2/n, 2);
    averageBiasedSampleVar = mean(BiasedVars);

    % Calculate population variance
    % Unbiased
    UnBiasedPopulationVar = var(population, 0);
    % Biased
    BiasedPopulationVar = var(population, 1);

    % Print result
    disp(sprintf("Sample number n = %d\n" + ...
        "Avarege of unbiased sample variance:%.4f\n" + ...
        "Unbiased population variance:%.4f\n"+ ...
        "Biased population variance:%.4f\n"+...
        "Avarege of biased sample variance:%.4f\n", ...
        n, averageUnBiasedSampleVar, UnBiasedPopulationVar, averageBiasedSampleVar, BiasedPopulationVar));
end