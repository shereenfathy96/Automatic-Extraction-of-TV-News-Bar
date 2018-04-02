function [  ] = FixRotation(frame )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure,imshow(frame);
RGBframe=rgb2gray(frame);
RGBframe=histeq(RGBframe);
RGBframe = imadjust(RGBframe,stretchlim(RGBframe),[]);
RGBframe=imbinarize(RGBframe);
figure,imshow(RGBframe);
 s=strel('line',3,0);
 RGBframe=~RGBframe;
 RGBframe=imdilate(RGBframe,s);
 %RGBframe=medfilt2(RGBframe);
 figure,imshow(RGBframe);
RGBframe = edge(RGBframe,'canny');
out=bwlabel(RGBframe);
figure,imshow(out);
bounds = regionprops(out, 'BoundingBox', 'Area' );
[area, Index] = max([bounds.Area]);
out=imcrop(out,[bounds(Index).BoundingBox(1),bounds(Index).BoundingBox(2),bounds(Index).BoundingBox(3),bounds(Index).BoundingBox(4)]);
figure,imshow(out);
figure,imshow(RGBframe);
[h w]=size(frame);
RGBframe=out;
[H,theta,rho] = hough(RGBframe);
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(RGBframe,theta,rho,P,'FillGap',5,'MinLength',7);
max_len=0;
for i=1:length(lines)
     len = norm(lines(i).point1 - lines(i).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = [lines(i).point1; lines(i).point2];
      t=lines(i).theta;
   end
end
%frame(xy_long(1,2):xy_long(2,2),xy_long(1,1):lines()
figure,plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
t=90-t;
if(t~=-90)
frame = imrotate(frame,-t);
end
figure,imshow(frame);
end

