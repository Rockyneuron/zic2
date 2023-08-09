function[cumc1,cumc2,cumc3,cumc4]=image_view(im1,im2,im3,im4,tiempo,clip)

for i=1:tiempo
[aux_1]=stdimage(im1(:,:,i),clip);
cellc1(:,:,:,i)=double2rgb(aux_1, gray);
cumc1(:,:,i)=aux_1;
end
for i=1:tiempo
[aux_1]=stdimage(im2(:,:,i),clip);
cellc2(:,:,:,i)=double2rgb(aux_1, gray); 
cumc2(:,:,i)=aux_1;
end
for i=1:tiempo
[aux_1]=stdimage(im3(:,:,i),clip);
cellc3(:,:,:,i)=double2rgb(aux_1, gray);
cumc3(:,:,i)=aux_1;
end
for i=1:tiempo
[aux_1]=stdimage(im4(:,:,i),clip);
cellc4(:,:,:,i)=double2rgb(aux_1, gray);
cumc4(:,:,i)=aux_1;
end
figure,montage(cellc1,gray),title('single condition 1 blank') 
figure,montage(cellc2,gray),title('single condition 2 blank') 
figure,montage(cellc3,gray),title('single condition 3 blank') 
figure,montage(cellc4,gray),title('single condition 4 blank') 

end
% 
% 
% im=im1(:,:,7);
% 
% md_im=mean(im(:));
% q=std(im(:));
% clip=4;
% 
% figure, imagesc(im,[md_im-clip*q, md_im+clip*q ]), colormap gray, axis image
% 
% figure, imagesc(cumc1(:,:,7)), colormap gray, axis image