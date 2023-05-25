LineEphys1
parentdir = 'Z:\Neuropixels';
micedirs = listsubdirs(parentdir);
nmice = length(micedirs);
for m = 3
curdir = micedirs(m);
daydirs = listsubdirs(curdir);
ndirs = length(daydirs);
for d = 1
foldername = char(daydirs(d));
disp(foldername);
end
end
cd(foldername);
files = ls(fullfile(foldername,'*.csv'));
files = files(contains({files.name}, '*DLC'));
for j=1:numel(files)
    filename=files(j).name;
    dlcdataread(filename)
end
cd(parentdir);