function[out]=preprocess_maps(im)



%----------Move the histogram--------------------------------------------


figure,
subplot(1,2,1)
imagesc(im), colormap gray, axis image
subplot(1,2,2),imhist(im) ,axis square

Xd=mean(im(:));
Xds=std(im(:));


shift=(Xd-0.5);

ims=im-shift;
figure,
subplot(1,2,1)
imagesc(ims), colormap gray, axis image, colorbar
subplot(1,2,2),imhist(ims(:)) ,axis square


mean(ims(:))

%----------Now ecualize--------------------------------------------


m1=0.5, sig1=0.15, A1=1, K=0, bin=2^8%numel(dif2_1);
hgram = linspace(0,1,numel(ims));
[p,z]= custom_hist(m1, sig1, A1,K,bin);
figure,
plot(z,p,'.')
figure, 
plot(cumsum(p))


[dif2_1]=ip_histeq(ims,2^8,p');
mean(dif2_1(:))
% [dif2_1]=im2uint8(dif2_1);



% dif2_1=histeq(ims,p);

un=length(unique(dif2_1(:)))


out=dif2_1;





















end