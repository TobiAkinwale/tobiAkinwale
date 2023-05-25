opts = delimitedTextImportOptions("NumVariables", 13);

% Specify range and delimiter
opts.DataLines = [2683, 23873];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "DLC_resnet50_fMay6shuffle1_10000", "DLC_resnet50_fMay6shuffle1_1", "DLC_resnet50_fMay6shuffle1_2", "DLC_resnet50_fMay6shuffle1_3", "DLC_resnet50_fMay6shuffle1_4", "DLC_resnet50_fMay6shuffle1_5", "DLC_resnet50_fMay6shuffle1_6", "DLC_resnet50_fMay6shuffle1_7", "DLC_resnet50_fMay6shuffle1_8", "DLC_resnet50_fMay6shuffle1_9", "DLC_resnet50_fMay6shuffle1_10", "DLC_resnet50_fMay6shuffle1_11"];
opts.SelectedVariableNames = ["DLC_resnet50_fMay6shuffle1_10000", "DLC_resnet50_fMay6shuffle1_1", "DLC_resnet50_fMay6shuffle1_2", "DLC_resnet50_fMay6shuffle1_3", "DLC_resnet50_fMay6shuffle1_4", "DLC_resnet50_fMay6shuffle1_5", "DLC_resnet50_fMay6shuffle1_6", "DLC_resnet50_fMay6shuffle1_7", "DLC_resnet50_fMay6shuffle1_8", "DLC_resnet50_fMay6shuffle1_9", "DLC_resnet50_fMay6shuffle1_10", "DLC_resnet50_fMay6shuffle1_11"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");

% Import the data
Video0001DLCresnet50fMay6shuffle110000filtered = readtable("C:\Users\akinwaleov\f-fff-2022-05-06\videos\Video0001DLC_resnet50_fMay6shuffle1_10000_filtered.csv", opts);