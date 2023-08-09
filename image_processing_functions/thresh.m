  function flag = thresh(region,thr)
      sd = std2(region);
      m = mean2(region);
     
      flag = m < 0.5  ;


         end