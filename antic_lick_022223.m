clear all;
m = "21049-1"; d = "022223"; f = "Z:\Interval-Img\Interval training";
camread = 0;
ff = fullfile(f, m, d, "001.csv"); % ff = "C:\Users\takemarull\OneDrive - National Institutes of Health (1)\Lab share\Mouse colony\001\Interval training\21094-1Black\022323\001.csv";
T = readtable(ff);

sol = T.Var10; lick = T.Var9;
if camread == 1
    filename = "Z:\Interval-Img\941-B.mp4";
    if size(T,2)==13
        if sum(T.Var13~=0)
            camera = T.Var13;
        end
    end
    V = VideoReader(filename);
    nFrames = V.NumFrames;
    npix_w = V.Width; npix_h = V.Height;
    vidgray = zeros(npix_h,npix_w,nFrames,"uint8");
    i = 1;
    while hasFrame(V) 
        f1 = readFrame(V);
        vidgray(:,:,i) = f1(:,:,1); 
        i = i+1;
        if rem(i,1000)==0, disp(i); end
    end
end

%%
if exist("camera","Var")
    solold = sol;
    camstart = find(camera,1); camend = find(camera==V.NumFrames,1);
    if isempty(camend)
        camend = find(camera==max(camera),1,"last");
    end
    soluse = sol(camstart:camend);
    camuse = camera(camstart:camend);
    lickuse = lick(camstart:camend);
else
    soluse = sol; lickuse = lick;
end

solopen = find(soluse==1);
dif = diff(solopen);
delstarts = find(dif~=1); % delivery points
solstarts = [solopen(1); solopen(delstarts+1)]; % solenoid opens 

% lick_perc = NaN(length(solstarts),2);
b_lick = NaN(length(solstarts),1);
a_lick = NaN(length(solstarts),1);
for s = 1:length(solstarts)
    soltime = solstarts(s);
    move = soltime-200;
    fin = soltime+200;
    lick_before = lickuse(move:soltime-1); before_perc = sum(lick_before)/length(lick_before);
    lick_after = lickuse(soltime:fin); after_perc = sum(lick_after)/length(lick_after);
%     if ~(before_perc==0 && after_perc==0)
%         lick_perc(s,1) = before_perc; lick_perc(s,2) = after_perc; 
%     end
    if ~(before_perc>0.9) % ~(before_perc==0) && 
        b_lick(s) = before_perc;
    end
    if ~(after_perc>0.9) %  ~(after_perc==0) &&
        a_lick(s) = after_perc;
    end

    if exist("camera","var")
%         disp(strcat("anticipatory licking ", string(before_perc))); cc = camcrop(move:soltime-1); 
        disp(strcat("reward licking ", string(after_perc))); cc = camuse(soltime:fin);
        ccidx = unique(cc);
        disp_mov(vidgray(:,:,ccidx));
    end
end

% avg_b_all = mean(lick_perc(:,1),'omitnan'); avg_a_all = mean(lick_perc(:,2),'omitnan');
avg_b = mean(b_lick,'omitnan'); avg_a = mean(a_lick,'omitnan');
disp(strcat("mouse ", m, " day ", d, " - ", string(avg_b), " ", string(avg_a)))

clearvars lick_before lick_after after_perc before_perc avg_before avg_after move fin s soltime

