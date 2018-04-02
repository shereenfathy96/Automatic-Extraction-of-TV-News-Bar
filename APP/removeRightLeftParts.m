function [xoffSetStart1 ,xoffSetEnd1 ] = removeRightLeftParts( image ,a)
FinalImage=image;
[H W L]=size(image);
 if(L==3)
   image=rgb2gray(image);
 end;
 tmpImage=image;
 image=imbinarize(image);
 leftImage=image;
ones=0;
zero=0;
for i=1:H
    for j=W-130:W
        if(image(i,j)==0)
            zero=zero+1;
        end
        if(image(i,j)==1)
            ones=ones+1;
        end
    end
end
if(ones<=zero)
 image = imcomplement(image);
end
image=image(4:H-6,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ones=0;
zero=0;
for i=1:H
    for j=1:90
        if(leftImage(i,j)==0)
            zero=zero+1;
        end
        if(leftImage(i,j)==1)
            ones=ones+1;
        end
    end
end
if(ones<=zero)
 leftImage = imcomplement(leftImage);
end
leftImage=leftImage(6:H-6,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

[h w]=size(image);
intFrames=a.NumberOfFrames/30;
xoffSetEnd1=w;
xoffSetStart1=2;
matchNumRight=0;
matchNumLeft=0;
[parts,num]=bwlabel(image);
for i=1 : num
[rw,cl] = find(parts == i);
minX=min(cl);
maxX=max(cl);
minY=min(rw);
maxY=max(rw);

if (minX>w-130&&matchNumRight<2)                             % right most 
    part=imcrop(tmpImage,[minX,minY,maxX-minX,maxY-minY]);
    [ph pw]=size(part);
    if(pw<50||ph<8)
       continue; 
    end  
    q=0;
   
    for j=1 : intFrames
       frame=read(a,j+q); 
       frame=rgb2gray(frame);
       [fh fw]=size(frame);
       match = normxcorr2(part,frame);
       maxMatch=max(max(match(:)));    
       if(maxMatch>0.80)
           [ypeak, xpeak] = find(match==max(match(:)));           
           if(xpeak-size(part,2)>w-130&&ypeak>fh-200)              
           xoffSetEnd1 = xpeak-size(part,2);
           matchNumRight=matchNumRight+1;
           end  
       end
       q=q+30;
    end
end
if(matchNumRight==2)
   break; 
end
end
[parts,num]=bwlabel(leftImage);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   left part
for i=1 : num
[rw,cl] = find(parts == i);
minX=min(cl);
maxX=max(cl);
minY=min(rw);
maxY=max(rw);
if (minX<130&&matchNumLeft<2)
    part=imcrop(tmpImage,[0,minY,minX,maxY-minY]);
    [ph pw]=size(part);
    if(pw<50||ph<8)
       continue; 
    end  
    q=0;
   
    for j=1 : intFrames
       frame=read(a,j+q); 
       frame=rgb2gray(frame);
       [fh fw]=size(frame);
       match = normxcorr2(part,frame);
       maxMatch=max(max(match(:)));    
       if(maxMatch>0.85)
           [ypeak, xpeak] = find(match==max(match(:)));   
           if(xpeak<120&&xpeak>20&&ypeak>fh-200)              
           xoffSetStart1 = xpeak;
           matchNumLeft=matchNumLeft+1;
           end  
       end
       q=q+30;
    end
end
if(matchNumLeft==4)
     break; 
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xoffSetEnd1=xoffSetEnd1+3;
xoffSetEnd1=xoffSetEnd1-5;
res=tmpImage;
[h w]=size(tmpImage);
if(matchNumLeft<4)
    xoffSetStart1=2;
end
if(xoffSetEnd1~=1&&matchNumRight>1)
res=imcrop(FinalImage,[xoffSetStart1,0,xoffSetEnd1-xoffSetStart1,h]);
h='ok'
end
end