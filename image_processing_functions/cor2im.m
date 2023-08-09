function[rd,ad]=cor2im(im)


[row,col]=find(im>-4*pi);
rd=[row, col];
ad=[];
for i=1:length(rd)
   
  ad(i)=im(rd(i,1), rd(i,2));  
    
end