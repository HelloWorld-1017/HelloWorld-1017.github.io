clc,clear,close all

for i = ["_data", "_includes", "_layouts", "_pages", "_sass", "assets"]
    rootPath = fullfile(pwd,i);
    helperMain(rootPath)
    fprintf("========================\n")
end

function helperMain(rootPath)
files = string;
folders = string;

% Collect file name and corresponding folder name
helperFind(rootPath);

folders(1)  = [];
files(1) = [];

folders = replace(folders,pwd,".");

folderNames = unique(folders);
folderNames = sort(folderNames,"ascend");

for jj = 1:numel(folderNames)
    idx = folders == folderNames(jj);
    disp(folderNames(jj))
    fprintf("\t%s\n",files(idx));
end

% Find files recursively
    function helperFind(PATH)
        roots = dir(PATH);
        for i = 3:numel(roots)
            if roots(i).isdir
                helperFind(fullfile(roots(i).folder,roots(i).name));
            else
                folders(end+1,1) = roots(i).folder; %#ok
                files(end+1,1) = roots(i).name; %#ok
            end
        end
    end
end