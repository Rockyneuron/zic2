function[SNR]=sig2noise_noroi(I,q)

% %%%%21/11/2018
% % Q=number of std that we consider for signal
% % u=mean(I(:));
% u=0.5;
% ustd=std(I(:));
% signal=I(I<(u-q*ustd));
% noise=I(I>(u+q*ustd));
% 
% 
% figure,
% subplot(2,2,1), imagesc(1-noise), title('background'), axis image, colormap gray
% subplot(2,2,2), imagesc(1-signal), title('signal'), axis image, colormap gray
% subplot(2,2,3), imhist(1-noise), title('background')
% subplot(2,2,4), imhist(1-signal), title('signal')
% 
% 
% 
% % 
% % SNR=mean(1-signal)/std(1-noise);
% 
% SNR=mean(1-signal)/std(1-signal);
% 


%%%%22/11/2018

u=0.4; %umbral del 70%
ustd=0;
signal=I(I<(u-q*ustd));
noise=I(I>(u+q*ustd));


figure,
subplot(2,2,1), imagesc(1-noise), title('background'), axis image, colormap gray
subplot(2,2,2), imagesc(1-signal), title('signal'), axis image, colormap gray
subplot(2,2,3), imhist(1-noise), title('background')
subplot(2,2,4), imhist(1-signal), title('signal')



% 
% SNR=mean(1-signal)/std(1-noise);

SNR=mean(1-signal)/std(1-signal);


end