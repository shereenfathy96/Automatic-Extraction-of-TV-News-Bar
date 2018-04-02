function [image] = logo(dis,startidx,endidx,frame,len,video,p1,p2,p3,p4)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for i=1:len
    for j=1:len
        if dis(i)>dis(j)
            tmp=dis(i);
            dis(i)=dis(j);
            dis(j)=tmp;
            %%%%%%%%%%%%%%%%%
            tmp=startidx(i);
            startidx(i)=startidx(j);
            startidx(j)=tmp;
            %%%%%%%%%%%%%%%%
            tmp=endidx(i);
            endidx(i)=endidx(j);
            endidx(j)=tmp;
            %%%%%%%%%%%%%%%
            tmp=frame(i);
            frame(i)=frame(j);
            frame(j)=tmp;
        end
    end
end
mid=int32(len/2);
newsbar=imcrop(read(video,frame(mid)),[p1,p2,p3,p4]);
% newsbar=rgb2gray(newsbar);
% newsbar=imbinarize(newsbar);
image=imcrop(newsbar,[endidx(mid)-7,1,startidx(mid)-endidx(mid)+15,p4]);
end

