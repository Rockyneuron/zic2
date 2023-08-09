function[g,SNR]=estimate_back_noise(I,ROI) 

% I=mat2gray(I);
%estimating noise parameters
%1) Seleciono una region del background, homogenea y veo la distriibucion
%del histograma

%%%backgorund
 figure, imagesc(I), colormap gray,axis image,title('select background')
     h_rect = imrect();

% Rectangle position is given as [xmin, ymin, width, height]
pos_rect = h_rect.getPosition();
% Round off so the coordinates can be used as indices
pos_rect = round(pos_rect);
% Select part of the image
background_im = I(pos_rect(2) + (0:pos_rect(4)), pos_rect(1) + (0:pos_rect(3)));
% histograma del ROI
proi=imhist(background_im);


%%%signal
 figure, imagesc(I), colormap gray,axis image,title('select signal')
     h_rect = imrect();
% Rectangle position is given as [xmin, ymin, width, height]
pos_rect = h_rect.getPosition();
% Round off so the coordinates can be used as indices
pos_rect = round(pos_rect);
% Select part of the image
signal_im = I(pos_rect(2) + (0:pos_rect(4)), pos_rect(1) + (0:pos_rect(3)));
% histograma de zona no homohgenea
proi=imhist(signal_im);


%%    ---Compute signal to noise ratio
back_mean=mean(background_im(:));
back_std=std(background_im(:));
signal_mean=mean(signal_im(:))
SNR=(signal_mean-back_mean)/back_std

figure,
subplot(2,2,1), imagesc(background_im), title('background'), axis image, colormap gray
subplot(2,2,2), imagesc(signal_im), title('signal'), axis image, colormap gray
subplot(2,2,3), histogram(background_im), title('background'),hold on,
histogram(signal_im), title('SNR'),legend('background','signal')




f=zeros(size(I));
g=imnoise(f,'gaussian',back_mean,back_std)

figure,
imagesc(g), title('background'), axis image, colormap gray

g(ROI==1)=I(ROI==1);

