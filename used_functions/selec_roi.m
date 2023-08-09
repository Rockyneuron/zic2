
function[im,im2,e]=selec_roi(im,im2)
%%%%%select ROI

BW = roipoly(im2) ;
e=double(BW);
im2=e.*im2;
im=im.*e;



end

