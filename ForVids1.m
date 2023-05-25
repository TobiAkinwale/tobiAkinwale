
V=VideoReader('filename');
nFrames=V.NumFrames();
templateFrameNums=round(nFrames/2)+(-10000:10000);
% read in the template frames(WxHx200001)
templateImage=mean(templateFrameNums,3);
%read in all frames( or in chunks: for i=1:nFrames/chunkSize)
%for i=1:nFrames
curFrame=V.CurrentTime();
%specify value for where you want to start from using CurrentTime
frameDiff=sum(abs(curFrame(:)-templateImage(:)));
