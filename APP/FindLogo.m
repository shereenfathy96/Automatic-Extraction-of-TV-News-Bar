function [Logo] = FindLogo(a ,p1,p2,p3,p4)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
f=0;
for framenumber=1:a.NumberOfFrames
 b=read(a,framenumber);
img=imcrop(b,[p1,p2,p3,p4]);
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
one=0;
zero=0;
for i=1:h
    for j=1:w
        if(img(i,j)==0)
            zero=zero+1;
        end
        if(img(i,j)==1)
            one=one+1;
        end
    end
end
if(one>zero)
img=~img;
end
%figure,imshow(img);
for i=1:w
    for j=3:h%%%%%%-8
        cum(1,i)=cum(1,i)+img(j,i);
    end
end 
cum=imbinarize(cum);
%figure,imshow(cum)
idx=1;
dis=zeros(1,w);
startl=zeros(1,w);
endl=zeros(1,w);
cnt=0;
for i=1:w
    if cum(1,i)==0
        cnt=cnt+1;
        if cnt==1
            startl(1,idx)=i;
        end
    elseif i~=1&&cum(1,i)~=cum(1,i-1)
        endl(1,idx)=i;
        dis(1,idx)=cnt;
        cnt=0;
        idx=idx+1;
    end
end
b=0;
e=0;
flag=0;
%figure,imshow(tmp);
for i=1:idx-1
    if dis(i)>=10&&dis(i+1)>=10&&dis(i)<=30&&dis(i+1)<=30
         f=f+1;
         alldis(f)=startl(i+1)-endl(i);
         allstart(f)=startl(i+1);
         allend(f)=endl(i);
         frame(f)=framenumber;
         newsbar=imcrop(read(a,framenumber),[p1,p2,p3,p4]);
         news=imcrop(newsbar,[endl(i),1,startl(i+1)-endl(i),p4]);
      %   news=imcrop(read(a,framenumber),[endl(i),1,startl(i+1)-endl(i),p4]);
%   imgname=strcat(num2str(framenumber),'-');
%   imgname=strcat(imgname,num2str(f));  
%    imgname=strcat(imgname,'.jpg');
%    imgname=strcat('F:\sem1\Image\Tasks\3\APP\output\',imgname);
%    imwrite(news,imgname);
    end
 end
end
 Logo=logo(alldis,allstart,allend,frame,f,a,p1,p2,p3,p4);
end