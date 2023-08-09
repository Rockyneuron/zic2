function[]=explore_dataframes(im,i)

    
im_aux=cualinorm(im);
a=(im(:,:,i));
figure,
subplot(2,2,1)
imagesc(im(:,:,i)), axis image, colormap gray,  title(['unique' num2str(length(unique(im(:,:,i)))) ' ' num2str(log2(length(unique(im(:,:,i))))) 'bits'])

subplot(2,2,2)
hist(a(:),256)
subplot(2,2,3)
imagesc(im_aux(:,:,i)), colormap gray,axis image,  title(['unique' num2str(length(unique(im(:,:,i)))) ' ' num2str(log2(length(unique(im(:,:,i))))) 'bits'])

subplot(2,2,4)
imhist(im_aux(:,:,i))

end