clc; clear all; close all;
filename = 'Z:\July22\168\080222\video.mp4';
V=VideoReader(filename);
prompt = 'Filename?';
str = input(prompt,"s");
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
where_to_look = round(roi.Position);

firstrow = roi.Position(2);
lastrow = roi.Position(2) + roi.Position(4);
firstcol = roi.Position(1);
lastcol = roi.Position(1) + roi.Position(3);
first_pixelcounts_laserregion = firstframe(firstrow:lastrow,firstcol:lastcol);

laseroff_pixel_count = sum(first_pixelcounts_laserregion(:)>=240);
middleframes = vidgray(firstrow:lastrow,firstcol:lastcol,round(nFrames/2)+(-50:50));
laseron_pixel_counts = squeeze(sum(sum(middleframes>=240,1),2));
laseron_pixel_count_min = min(laseron_pixel_counts);
my_threshold = mean([laseroff_pixel_count,laseron_pixel_count_min]);
total_pixels = npix_w*npix_h;

vidgrayrect = vidgray(firstrow:lastrow,firstcol:lastcol,:);
vidgrayrectcount = squeeze(sum(sum(vidgrayrect>=240)));
pixel_counts_allframes_thresh = vidgrayrectcount>my_threshold;
figure; plot(pixel_counts_allframes_thresh); ylim([-0.1 1.1])


%code below writes the video to file
first1 = find(pixel_counts_allframes_thresh, 1, "first");
last1 = find(pixel_counts_allframes_thresh, 1, "last");
frames = read(V, [first1, last1]);
p = strcat("Z:\July22\168\080222");
cd(p);
video = VideoWriter(str,'MPEG-4');
video.FrameRate = round(V.FrameRate); 
open(video)
for i = 1:size(frames,4)    
    img = frames(:,:,:,i); 
    writeVideo(video,img); 
end
close(video);

