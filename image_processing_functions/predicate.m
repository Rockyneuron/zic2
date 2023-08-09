  function flag = thresh_merge_seg(region)
%       sd = std2(region);
%       m = mean2(region);
%       flag = (sd > 0.1) & (m > 0.7) & (m < 0.5);

tmap=statxture(region);

% flag=tmap(3)>0.02 && tmap(3)<0.5;
flag=tmap(6)>4;

% flag=tmap(2)>10;
         end