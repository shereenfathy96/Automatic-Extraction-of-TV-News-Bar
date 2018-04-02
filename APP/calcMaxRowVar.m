function [startRow endRow] = calcMaxRowVar( img )
[h w]=size(img);
img=double(img);
mean=[];
sum=0.0;
for i=1 : h
   sum=0.0;
  for j=1 : w
   sum=sum+img(i,j);
  end 
  mean(i)=sum/w;
end
var=-1e9;
for i=1 : h
   sum=0.0;
  for j=1 : w
   x=img(i,j)-mean(i);    
   y=x*x;
   sum=sum+y;
  end 
  sum=sum/w;
  if(sum>var)
     var=sum; 
     startRow=i;
  end
end

for i=startRow : h
   sum=0.0;
  for j=1 : w
   x=img(i,j)-mean(i);    
   y=x*x;
   sum=sum+y;
  end 
  sum=sum/w;
  if(sum<0.1)
     endRow=i;
     break;
  end
end
i=startRow;
while i
   sum=0.0;
  for j=1 : w
   x=img(i,j)-mean(i);    
   y=x*x;
   sum=sum+y;
  end 
  sum=sum/w;
  if(sum<0.1)
     startRow=i;
     break;
  end
  i=i-1;
end
startRow=startRow-8;
endRow=endRow+8 ;
end