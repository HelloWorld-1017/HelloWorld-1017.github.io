clc, clear, close all

%% Data Preparation
% Load train data
degradationData = helperLoadData('train_FD002.txt');

% Split the degradation data into a training data set 
% and a validation data set for later performance evaluation
rng('default')  % For repeatablility
numEnsemble = length(degradationData);
numFold = 5;
cv = cvpartition(numEnsemble, 'KFold', numFold);
trainData = degradationData(training(cv, 1));
validationData = degradationData(test(cv, 1));

% Specify groups of variables of interest
varNames = string(degradationData{1}.Properties.VariableNames);
timeVariable = varNames{2};
conditionVariables = varNames(3:5);
dataVariables = varNames(6:26);

% Visualize a sample of the ensemble data
nsample = 10;
figure('Units', 'pixels', 'Position', [609, 265,1306, 990])
helperPlotEnsemble(trainData, timeVariable, [conditionVariables(1:2) dataVariables(1:2)], nsample)


%% 
% Notice that each ensemble member contains 3 operating conditions: "op_setting_1", "op_setting_2", and "op_setting_3". 
% Firstly, extract the table from each cell and concatenate them into a single table.
trainDataUnwrap = vertcat(trainData{:});
opConditionUnwrap = trainDataUnwrap(:, cellstr(conditionVariables));

% Visualize all operating points on a 3D scatter plot.
% It clearly shows 6 regimes and the points in each regime are in very close proximity.
figure(2)
helperPlotClusters(opConditionUnwrap)

% Use clustering techniques to locate the 6 clusters automatically. 
% Repeat the K-means clustering algorithm several times with different initial conditions and pick the results with the lowest cost
opts = statset('Display', 'final');
[clusterIndex, centers] = kmeans(table2array(opConditionUnwrap), 6, ... 
    'Distance', 'sqeuclidean', 'Replicates', 5, 'Options', opts);

% Visualize the clustering results and the identified cluster centroids
figure(3)
helperPlotClusters(opConditionUnwrap, clusterIndex, centers)

%% 
centerstats = struct('Mean', table(), 'SD', table());
for v = dataVariables
    centerstats.Mean.(char(v)) = splitapply(@mean, trainDataUnwrap.(char(v)), clusterIndex);
    centerstats.SD.(char(v))   = splitapply(@std,  trainDataUnwrap.(char(v)), clusterIndex);
end

trainDataNormalized = cellfun(@(data) regimeNormalization(data, centers, centerstats), ...
    trainData, 'UniformOutput', false);

figure(4)
helperPlotEnsemble(trainDataNormalized, timeVariable, dataVariables(1:4), nsample)

%% Trendability Analysis


%% Custom Functions
function degradationData = helperLoadData(filename)
% Copyright 2017-2018 The MathWorks, Inc.

% Load the text file as a table
t = readtable(filename);

% Add variable names to the table
VarNames = {...
    'id', 'time', 'op_setting_1', 'op_setting_2', 'op_setting_3', ...
    'sensor_1', 'sensor_2', 'sensor_3', 'sensor_4', 'sensor_5', ...
    'sensor_6', 'sensor_7', 'sensor_8', 'sensor_9', 'sensor_10', ...
    'sensor_11', 'sensor_12', 'sensor_13', 'sensor_14', 'sensor_15', ...
    'sensor_16', 'sensor_17', 'sensor_18', 'sensor_19', 'sensor_20', ...
    'sensor_21'};
t.Properties.VariableNames = VarNames;

% Split the signals from each machine ID into individual tables 
% and collect the tables in a cell array.
IDs = t{:,1};
nID = unique(IDs);
degradationData = cell(numel(nID),1);
for ct=1:numel(nID)
    idx = IDs == nID(ct);
    degradationData{ct} = t(idx,:);
end
end

function helperPlotEnsemble(ensemble, TimeVariable, DataVariables, nsample, varargin)
% Copyright 2017-2018 The MathWorks, Inc.
% ensemble, 208x1 cell

% Randomly select 10(nsample) machines
randIdx = randperm(length(ensemble));
ensembleSample = ensemble(randIdx(1:nsample));

% Plot profiles
numData = length(DataVariables);
for i = 1:numData
    data2plot = DataVariables(i);
    subplot(numData, 1, i)
    hold on
    for j = 1:length(ensembleSample)
        ensembleMember = ensembleSample{j};
        if isa(ensembleMember, 'double') % Determine if input is 'double' class
            % TimeVariable and DataVariables are doubles
            if isempty(TimeVariable)
                plot(ensembleMember(:, DataVariables), varargin{:})
            else
                plot(ensembleMember(:, TimeVariable), ensembleMember(:, DataVariables), varargin{:})
            end
            xlblstr = "time";
            ylblstr = "Var " + data2plot;
        else
            % ensembleMember is a table
            plot(ensembleMember.(char(TimeVariable)), ensembleMember.(char(data2plot)), varargin{:})
            xlblstr = TimeVariable;
            ylblstr = data2plot;
        end
    end
    hold off
    ylabel(ylblstr, 'Interpreter', 'none')
end
xlabel(xlblstr)
end

function helperPlotClusters(X, idx, C)
% Copyright 2017-2018 The MathWorks, Inc.

if(nargin>1)
    hold on
    for i = 1:max(idx)
        scatter3(X{idx==i,1}, X{idx==i,2}, X{idx==i,3});
    end
    scatter3(C(:,1),C(:,2),C(:,3), 'x', 'MarkerFaceColor', [0 0 0], ...
        'MarkerEdgeColor', [0 0 0], 'LineWidth', 2);
    legendStr = ["Cluster "+(1:6), "Centroids"];
    legend(cellstr(legendStr), 'Location', 'NW');
    hold off
    view(-30,30)
    grid on
else
    scatter3(X{:,1}, X{:,2}, X{:,3});
end
xlabel(X.Properties.VariableNames{1}, 'Interpreter', 'none')
ylabel(X.Properties.VariableNames{2}, 'Interpreter', 'none')
zlabel(X.Properties.VariableNames{3}, 'Interpreter', 'none')
end

function data = regimeNormalization(data, centers, centerstats)
% Perform normalization for each observation (row) of the data
% according to the cluster the observation belongs to.
conditionIdx = 3:5;
dataIdx = 6:26;

% Perform row-wise operation
data{:, dataIdx} = table2array(...
    rowfun(@(row) localNormalize(row, conditionIdx, dataIdx, centers, centerstats), ...
    data, 'SeparateInputs', false));
end

function rowNormalized = localNormalize(row, conditionIdx, dataIdx, centers, centerstats)
% Normalization operation for each row.

% Get the operating points and sensor measurements
ops = row(1, conditionIdx);
sensor = row(1, dataIdx);

% Find which cluster center is the closest
dist = sum((centers - ops).^2, 2);
[~, idx] = min(dist);

% Normalize the sensor measurements by the mean and standard deviation of the cluster.
% Reassign NaN and Inf to 0.
rowNormalized = (sensor - centerstats.Mean{idx, :}) ./ centerstats.SD{idx, :};
rowNormalized(isnan(rowNormalized) | isinf(rowNormalized)) = 0;
end

function dataFused = degradationSensorFusion(data, sensorToFuse, weights)
% Combine measurements from different sensors according 
% to the weights, smooth the fused data and offset the data
% so that all the data start from 1

% Fuse the data according to weights
dataToFuse = data{:, cellstr(sensorToFuse)};
dataFusedRaw = dataToFuse*weights;

% Smooth the fused data with moving mean
stepBackward = 10;
stepForward = 10;
dataFused = movmean(dataFusedRaw, [stepBackward stepForward]);

% Offset the data to 1
dataFused = dataFused + 1 - dataFused(1);
end