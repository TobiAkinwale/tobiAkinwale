
NI=Untitled;
first_cam=find(NI(:,13)==1); %rename to NI
first_cam=first_cam(1,1);
last_cam=find(NI(:,13)==max(NI(:,13)));
last_cam=max(last_cam);
cam_on=NI(first_cam:last_cam,:);
%match=round((cam_on(:,13))/2);
%cam_on(:,13)=match;
%get dlc and rename to dlc
sol_cam=cam_on(:,[10,13]);

cam=sol_cam(:,2);
%crop cam based on the size of dlc here
dlc_size=size(dlc,1);
last_dlc=(find(cam==dlc_size));
last_dlc=max(last_dlc);
cam=cam(1:last_dlc,:);
dlc_cam=dlc(cam,:);
sol_cam=sol_cam(1:last_dlc,:);
sol_cam(:,[3:10])=dlc_cam;
solopen = find(sol_cam(:,1)==1);
dif = diff(solopen);
delstarts = find(dif~=1); % delivery points
solstarts = [solopen(1); solopen(delstarts+1)]; % solenoid opens 
tracker=[];

for s = 1:length(solstarts)
    soltime=solstarts(s);
    move=soltime-400;
    after=soltime+400;
    track=sol_cam(move:after,3:10);
    tracker=[tracker,track];

end
avg_pos=mean(tracker,2);
perm=permute(reshape(tracker,size(track,1),size(track,2),[]),[1,2,3]);
avg_pos2=mean(perm,3);
der=abs(diff(perm));
mea_der=mean(der,3);
b=[1:30]/30;
fut = filtfilt(b,1,mea_der);