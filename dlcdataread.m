function dlctablefile = importfile(filename, dataLines)
prompt = 'Filename?'
str = input(prompt,"s")
if nargin < 2
    dataLines = [4, Inf];
end
opts = delimitedTextImportOptions("NumVariables", 13);
opts.DataLines = dataLines;
opts.Delimiter = ",";
opts.VariableNames = ["Var1", "DLC_resnet50_fMay6shuffle1_10000", "DLC_resnet50_fMay6shuffle1_10000_1", "Var4", "DLC_resnet50_fMay6shuffle1_10000_3", "DLC_resnet50_fMay6shuffle1_10000_4", "Var7", "DLC_resnet50_fMay6shuffle1_10000_6", "DLC_resnet50_fMay6shuffle1_10000_7", "Var10", "DLC_resnet50_fMay6shuffle1_10000_9", "DLC_resnet50_fMay6shuffle1_10000_10", "Var13"];
opts.SelectedVariableNames = ["DLC_resnet50_fMay6shuffle1_10000", "DLC_resnet50_fMay6shuffle1_10000_1", "DLC_resnet50_fMay6shuffle1_10000_3", "DLC_resnet50_fMay6shuffle1_10000_4", "DLC_resnet50_fMay6shuffle1_10000_6", "DLC_resnet50_fMay6shuffle1_10000_7", "DLC_resnet50_fMay6shuffle1_10000_9", "DLC_resnet50_fMay6shuffle1_10000_10"];
opts.VariableTypes = ["string", "double", "double", "string", "double", "double", "string", "double", "double", "string", "double", "double", "string"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, ["Var4", "Var7", "Var10", "Var13"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var4", "Var7", "Var10", "Var13"], "EmptyFieldRule", "auto");
dlctablefile = readtable(filename, opts);
dlctablefile = table2array(dlctablefile);
clear opts;
p = strcat("C:\Users\akinwaleov\OneDrive - National Institutes of Health\Desktop\dlc_cropped\", str, "dlc_cropped.mat");
save(p,"dlctablefile");
end
