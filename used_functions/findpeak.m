function[peak,value]=findpeak(im)

IM2 = im;
[x,y]=find(max(IM2(:))==IM2);
peak=[x,y];
value=IM2(x,y);

end