clear all;
close all;

g=dlcdataread('Video0005DLC_resnet50_smallcam-smallcageJan10shuffle1_10000.csv');
hop=g(14244:36497,:);%g=dlcdataread('Video0003DLC_resnet50_smallcamcageJan20shuffle1_10000.csv');
g=hop;
V=VideoReader("Video0005.mp4");
nFrames=V.NumFrames();
npix_w = V.Width;
npix_h = V.Height;
vidgray = zeros(npix_h,npix_w,nFrames,"uint8");
i=1;
while hasFrame(V) 
    f1=readFrame(V);
    vidgray(:,:,i) = f1(:,:,1); 
    i=i+1;
    if rem(i,1000)==0, disp(i); end
end
% 

figure; imshow(f1)
firstframe = vidgray(:,:,1);
figure; imshow(firstframe);
roi=drawrectangle;
left_end=round(roi.Vertices(1,1));
right_end=round(roi.Vertices(3,1));
mid_point=((right_end-left_end)/2)+left_end;
y_point_1=round(roi.Vertices(1,2));
y_point_2=round(roi.Vertices(2,2));
y_axes=g(:,8);
leftside_y=find(y_axes(:,1)<y_point_1);
leftside_yb=find(y_axes(:,1)>y_point_2);
both=cat(1,leftside_y,leftside_yb);
g(both,:)=[];
x_axes=g(:,7);
leftside_x=find(x_axes(:,1)>left_end & x_axes(:,1)<mid_point);
rightside_x=find(x_axes(:,1)>mid_point & x_axes(:,1)<right_end);

leftside_size=size(leftside_x,1);
rightside_size=size(rightside_x,1);
g_size=size(g,1);
middle_size=abs(g_size-(leftside_size+rightside_size));
xyz=[leftside_size,middle_size,rightside_size];
timexyz=round(xyz/V.FrameRate);
bar(xyz);
bar(timexyz);
xlabel('Left vs Middle vs Right');
ylabel('Time(sec)');

