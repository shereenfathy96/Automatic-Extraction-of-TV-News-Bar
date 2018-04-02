function [ NewsBar ] = ReadVideo( Path )
a=VideoReader(Path);
b=[];
IndexOfNews=1;
intFrames=uint8(a.NumberOfFrames/30);
intFrames=double(intFrames);
endBar=1;
for k = 2:intFrames
b= read(a,3+(k-1)*30)-read(a,1+(k-1)*30);
b=rgb2gray(b);
%b=im2bw(b,0.2);
b = edge(b,'sobel','vertical');
%figure,imshow(b);
b=double(b);
[startRow endRow]=calcMaxRowVar(b);
if(abs(startRow-IndexOfNews)>10)
   IndexOfNews=startRow;
   endBar=endRow;
else
   break;
end
end
[h w]=size(b);
sCol=10000;eCol=0;
%figure,imshow(b);
for i=IndexOfNews:endBar
    for j=1:w
        if(b(i,j)~=0&&j<sCol)
            sCol=j;
        elseif b(i,j)~=0&&j>eCol
            eCol=j;
        end
    end
end
i=1;
image=imcrop(read(a,30),[sCol,IndexOfNews,eCol-sCol+1,endBar-IndexOfNews]);

[sCol,eCol]=removeRightLeftParts(image,a);
image=imcrop(read(a,30),[sCol,IndexOfNews,eCol-sCol+1,endBar-IndexOfNews]);
%FixRotation(image);
next=0;
Logo=FindLogo(a,sCol,IndexOfNews,eCol-sCol+1,endBar-IndexOfNews);
figure,imshow(Logo);
while i<a.NumberOfFrames
b = read(a,i);
NewsBar=imcrop(b,[sCol,IndexOfNews,eCol-sCol,endBar-IndexOfNews]);
[next,flag]=Extract(NewsBar,i,a.NumberOfFrames-1,next);
if(i==a.NumberOfFrames-1)
    break;
end
 if(flag==0)
     i=i+1;
 else
i=min(i+flag,a.NumberOfFrames-1);
end
end
NewsBar=image;
end