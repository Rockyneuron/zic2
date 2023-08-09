function[im]=stdimage(im,clip)
q=nanstd(im(:));
    media=nanmean(im(:));
   index_3=im<(media-q.*clip);
   im(index_3)=(media-q.*clip);
 index_4=im>(media+q.*clip); 
   im(index_4)=media+q.*clip;
   
  

end