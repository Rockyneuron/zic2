function[SNR,tmb,tms]=sig2noise_1(I,It,im)

function[tmb,tms]=sig_timecourse(It,roi_b,roi_s)
        
       back=It(roi_b(1,:),roi_b(2,:),:);
figure,montage(double2rgb(back,gray),gray),title('single condition 1 blank')
tmb=[mean(reshape(back,[size(back,1)*size(back,2),size(back,3)]),1);
std(reshape(back,[size(back,1)*size(back,2),size(back,3)]),1)];

signal=It(roi_s(1,:),roi_s(2,:),:);
figure,montage(double2rgb(signal,gray),gray),title('single condition 1 blank')
tms=[mean(reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]),1);
std(reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]),1)];

    end
        
%------------Calculate Global SNR-----------------------------------------

[Gb,Gs]=sig_timecourse(It,roi,roi);





        
    


%%%backgorund
figure,
imagesc(I), colormap gray,axis image, title('select background')
     h_rect = imrect(gca,[100  100 40 40]);
setFixedAspectRatioMode(h_rect,0)
setResizable(h_rect,0) 
input('Press intro to accept location');
% Rectangle position is given as [xmin, ymin, width, height]
 pos_rect = getPosition(h_rect)
% Round off so the coordinates can be used as indices
pos_rect = round(pos_rect);
% Select part of the image
roi_b=[pos_rect(2) + (0:pos_rect(4)); pos_rect(1) + (0:pos_rect(3))];
img_map = I(roi_b(1,:),roi_b(2,:));
% histograma del ROI
proi=imhist(img_map);


%%%signal
figure,
imagesc(I), colormap gray,axis image, title('select signal')
     h_rect = imrect(gca,[100  100 40 40]);
setFixedAspectRatioMode(h_rect,1)
setResizable(h_rect,0) 
input('Press intro to accept location');
% Rectangle position is given as [xmin, ymin, width, height]
pos_rect = h_rect.getPosition();
% Round off so the coordinates can be used as indices
pos_rect = round(pos_rect);
% Select part of the image
roi_s=[pos_rect(2) + (0:pos_rect(4)); pos_rect(1) + (0:pos_rect(3))];
img_map2 = I(roi_s(1,:),roi_s(2,:));
% histograma del ROI
proi=imhist(img_map2);



figure,
subplot(2,2,1), imagesc(1-img_map), title('background'), axis image, colormap gray
subplot(2,2,2), imagesc(1-img_map2), title('signal'), axis image, colormap gray
subplot(2,2,3), imhist(1-img_map), title('background')
subplot(2,2,4), imhist(1-img_map2), title('signal')


SNR=abs(mean(img_map2(:))-mean(img_map(:)))/std(img_map(:));


[tmb,tms]=sig_timecourse(It,roi_b,roi_s)


figure, plot(1:20,tmb(1,:),'-o')
hold on
plot(1:20,tms(1,:),'-o')

figure
plot(1:20,tms(1,:)./tmb(1,:),'-o')

end




