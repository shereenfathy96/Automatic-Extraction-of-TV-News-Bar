function [] = FixNewsbar(a,startrow,endrow)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
frame1=read(a,1);
newsbar=imcrop(frame1,[1,startrow,size(frame1,2),endrow-startrow]);
newsbar=rgb2gray(newsbar);
newsbar=imbinarize(newsbar);
out=bwlabel(newsbar);
bounds = regionprops(out, 'BoundingBox', 'Area' );
flag=1;
areas=[bounds.Area];
while flag
[area, Index] = max(areas);
if(area>1000)
    areas(Index)=0;
    continue;
else
   flag=0;
out=imcrop(out,[bounds(Index).BoundingBox(1),bounds(Index).BoundingBox(2),bounds(Index).BoundingBox(3),bounds(Index).BoundingBox(4)]);
end
end
figure,imshow(out);
end

