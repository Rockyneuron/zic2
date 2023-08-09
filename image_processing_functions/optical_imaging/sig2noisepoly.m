function[tmb,tms]=sig2noisepoly(I,It,Itb)

function[tmb,tms]=sig_timecourse(It,roi_s,roi_b,Itb)
        
roi_b(roi_b==0)=nan;
back=Itb.*repmat(roi_b,[1,1,20]);
figure,montage(double2rgb(back,gray),gray),title('blank')
tmb=[nanmean(reshape(back,[size(back,1)*size(back,2),size(back,3)]),1);
nanstd(reshape(back,[size(back,1)*size(back,2),size(back,3)]),1)];

roi_s(roi_s==0)=nan;
signal=It.*repmat(roi_s,[1,1,20]);
figure,montage(double2rgb(signal,gray),gray),title('single condition 1 blank')
tms=[nanmean(reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]),1);
nanstd(reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]),1)];
  
    end
        
        
        
    

figure
%%%backgorund
imagesc(I), colormap gray,axis image, title('select background')
     h_rect = imrect(gca,[100  100 240 240]);
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
roi_b=zeros(size(I));
a=[pos_rect(2) + (0:pos_rect(4)); pos_rect(1) + (0:pos_rect(3))];
roi_b(a(1,:),a(2,:))=1;
%%%signal
figure,

[I_roi,I_roi,roi_s]=selec_roi(I,I);



img_map2 = I_roi(logical(roi_s));
% histograma del ROI
proi=imhist(img_map2);
% img_map1=
% 
% 
% figure,
% subplot(2,2,1), imagesc(1-img_map), title('background'), axis image, colormap gray
% subplot(2,2,2), imagesc(1-img_map2), title('signal'), axis image, colormap gray
% subplot(2,2,3), imhist(1-img_map), title('background')
% subplot(2,2,4), imhist(1-img_map2), title('signal')
% 
% 
% SNR=abs(mean(img_map2(:))-mean(img_map(:)))/std(img_map(:));
roi_b=roi_s;
[tmb,tms]=sig_timecourse(It,roi_s,roi_b,Itb)

figure, plot(1:20,tmb(1,:),'-o')
hold on
plot(1:20,tms(1,:),'-o')

figure,
plot(1:20,tms(1,:),'-o')

figure
plot(1:20,tms(1,:)./tmb(1,:),'-o')

end




