function [ res ] = CheckGoodNews( img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tmp=img;
img=rgb2gray(img);
[h,w]=size(img);
thresh=sum(sum(img>170));
halfsize=0.5*h*w;
if(thresh>=halfsize)
    t=adaptthresh(img, 0.7);
    img=imbinarize(img,t);
else
 img=imbinarize(img);
end
[h w]=size(img);
cum=zeros(1,w);
ones=0;
zero=0;
for i=1:h
    for j=1:w
        if(img(i,j)==0)
            zero=zero+1;
        end
        if(img(i,j)==1)
            ones=ones+1;
        end
    end
end
if(ones>zero)
img=~img;
end
%figure,imshow(img);
for i=1:w
    for j=3:h-10
        cum(1,i)=cum(1,i)+img(j,i);
    end
end 
cum=imbinarize(cum);
%figure,imshow(cum);
cnt=0;
cnt1=0;
for i=1:w
    if cum(1,i)==0
        cnt=cnt+1;
        if(cnt==1)
            s=i;
        end
    elseif i~=1&&cum(1,i)~=cum(1,i-1)
       if(cnt>=9)          
           cnt1=cnt1+1;        
           dis(cnt1)=cnt; 
           start(cnt1)=s;
       end        
        cnt=0;
       end
end
cnt1
if((cnt1==2&&abs(dis(1)-dis(2))<6))
    res=1;
else
    res=0;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

