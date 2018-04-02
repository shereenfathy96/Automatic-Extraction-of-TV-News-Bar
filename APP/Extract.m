function [ output ,flag] = Extract( img ,framenumber,len,width)
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
cnt=0;idx=1;
dis=zeros(1,w);
startl=zeros(1,w);
endl=zeros(1,w);
for i=1:w
    if cum(1,i)==0
        cnt=cnt+1;
        if cnt==1
            startl(1,idx)=i;
        end
    elseif i~=1&&cum(1,i)~=cum(1,i-1)
        if(cnt==1)
            cnt=0;
            continue;
        end
        endl(1,idx)=i-1;
        dis(1,idx)=cnt;
        cnt=0;
        idx=idx+1;
    end
end
b=0;
e=0;
flag=0;
cnt=0;
%figure,imshow(tmp);
i=idx-2;
output=width;
while i>0
  if dis(i)>=9&&dis(i)<=30&&dis(i+1)>=9&&dis(i+1)<=30&&e~=0 %%%5mn el a5r ll awl
  % b=startl(i);
    b=endl(i);
   if(len==framenumber)
   e-b
   end
   if(abs(e-b-width)<10&&len==framenumber)
    e=startl(i+1);b=0;i=i-1;
       continue;
   end
   if(abs(e-b-width)<5||e-b<130)
       break;
   end
   news=imcrop(tmp,[b,1,e-b,h]);
   if(CheckGoodNews(news)==1)
   cnt=cnt+1;
   %figure,imshow(news)   
    flag=int32((e-b)/10)+10;
   imgname=strcat(num2str(framenumber),'-');
  imgname=strcat(imgname,num2str(cnt));  
   imgname=strcat(imgname,'.jpg');
   imgname=strcat('C:\Users\dell\Documents\GitHub\Automatic-Extraction-of-TV-News-Bar\APP\output\',imgname);
   imwrite(news,imgname);
    output=e-b;
    width=e-b;
    e=startl(i+1);b=0;
   end
    if(len~=framenumber)
    break
    end
    elseif dis(i)>=9&&dis(i)<=30&&dis(i+1)>=9 
     %  e=endl(i+1);
     e=startl(i+1);
  end
    i=i-1;
end
end

