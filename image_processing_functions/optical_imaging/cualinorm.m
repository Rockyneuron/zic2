
function[im]=cualinorm(im)
for i=1:size(im,3)
    
    im(:,:,i)=mat2gray(im(:,:,i));
    
    
end
    
end