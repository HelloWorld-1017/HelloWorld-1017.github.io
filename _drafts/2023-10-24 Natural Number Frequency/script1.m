clc,clear,close all

load fisheriris.mat
clear species
data = meas(:);
clear meas

load ovariancancer.mat
clear grp
data = [data;obs(:)];
clear obs

load simulatedDataset.mat
clear labels
data = [data;flow(:)];
clear flow

data = normalise(data)*1e4;
totalNum = numel(data);

data = string(abs(data));

ratios1 = helperCalculateRatios(data,totalNum,1);
ratios2 = helperCalculateRatios(data,totalNum,2);
ratios3 = helperCalculateRatios(data,totalNum,3);
ratios = [ratios1,ratios2,ratios3];

figure
hold(gca,"on"),box(gca,"on"),grid(gca,"on")
b = bar(categorical(0:9),ratios,"FaceAlpha",1);
b(1).FaceColor = [7,84,213]/255;
b(1).DisplayName = "1st digit";
b(2).FaceColor = [249,82,107]/255;
b(2).DisplayName = "2nd digit";
b(3).FaceColor = "g";
b(3).DisplayName = "3rd digit";
legend()


function ratios = helperCalculateRatios(data,totalNum,pos)

for i = 1:totalNum
    numel = char(data(i));
    data(i) = numel(pos);
end

ratios = nan(10,1);
for i = 0:9
    ratios(i+1) = sum(strcmp(data,num2str(i)))/totalNum;
    fprintf("%s: %.4f\n",num2str(i),ratios(i+1))
end

end
