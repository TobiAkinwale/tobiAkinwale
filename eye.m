
NI=Untitled;
first_cam=find(NI(:,13)==1); %rename to NI
first_cam=first_cam(1,1);
last_cam=find(NI(:,13)==max(NI(:,13)));
last_cam=max(last_cam);
cam_on=NI(first_cam:last_cam,:);
%match=round((cam_on(:,13))/2); for the eye csv the NI camera frame is 2x
%the no of frames
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
newy=-2:4/800:2;
all_x=avg_pos2(:,[1,3,5,7]);
all_y=avg_pos2(:,[2,4,6,8]);
avg_pos2x=mean(all_x,2);
avg_pos2y=mean(all_y,2);
V=VideoReader("6670right0413.mp4");
frameRate=200;
timeInterval = 1 / frameRate;
x=avg_pos2x;
y=avg_pos2y;

% numFrames = length(x);
% distance = zeros(numFrames-1, 1);
% speed = zeros(numFrames-1, 1);
% for i = 1:numFrames-1
%     distance(i) = sqrt((x(i+1) - x(i))^2 + (y(i+1) - y(i))^2);
%     speed(i) = distance(i) / timeInterval;
% end
% averageSpeed = mean(speed);
% maxSpeed = max(speed);

totalperm=cat(3,perm,perm2,perm3);
totalavg=mean(perm,3);
totalavgx=totalavg(:,[1,3,5,7]);
totalavgy=totalavg(:,[2,4,6,8]);
total_vgx=mean(totalavgx,2);
total_vgy=mean(totalavgy,2);
plot(total_vgx)
newy=-2:4/800:2;
figure;plot(newy,total_vgx)
total_vgx=smooth(total_vgx);
total_vgy=smooth(total_vgy);
figure;plot(newy,total_vgx,'LineWidth',2.0)
point=0;
hold on
line([point point],ylim,'LineWidth',2.0,'Linestyle','--','Color','r')
hold off
figure;plot(newy,total_vgy,'LineWidth',2.0)
point=0;
hold on
line([point point],ylim,'LineWidth',2.0,'Linestyle','--','Color','r')
hold off
der=abs(diff(avg_pos2y));
dist=vecnorm(der,2,2);
dist=smooth(dist);
totalder=abs(diff(total_vgy));
totaldist=vecnorm(totalder,2,2);
totaldist=smooth(totaldist);
newy1=-2:4/799:2;

figure;plot(newy1,totaldist,'LineWidth',2.0)
point=0;
hold on
line([point point],ylim,'LineWidth',2.0,'Linestyle','--','Color','r')
hold off
mea_der=mean(der,3);
b=[1:30]/30;
fut = filtfilt(b,1,mea_der);