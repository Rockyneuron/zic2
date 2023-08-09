function[SNR]=sig2noise_1(It,im,roi)

thr=0.2;

function[tmb,tms]=sig_timecourse(It,Itb,roi_s,roi_b)
        
roi_b(roi_b==0)=nan;
back=Itb.*repmat(roi_b,[1,1,20]);
% figure,montage(double2rgb(back,gray),gray),title('blank')
tmb=[nanmean(reshape(back,[size(back,1)*size(back,2),size(back,3)]),1);
nanstd(reshape(back,[size(back,1)*size(back,2),size(back,3)]),1)];

roi_s(roi_s==0)=nan;
signal=It.*repmat(roi_s,[1,1,20]);
% figure,montage(double2rgb(signal,gray),gray),title('single condition 1 blank')
tms=[nanmean(reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]),1);
nanstd(reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]),1)];


figure, plot(1:20,tmb(1,:),'-o')
hold on
plot(1:20,tms(1,:),'-o')

figure
plot(1:20,tms(1,:)./tmb(1,:),'-o')
    end
     
    function[SNR]=SNRrat(sig,back,stb)       
SNR=((sig-back)./stb);       
    end


%------------Calculate Global SNR-----------------------------------------

totr=(It.Gp1+It.Gp2+It.Gp3+It.Gp4)./4;
[Gb,Gs]=sig_timecourse(totr,It.Gp0,roi,roi);


%------------Calculate SNR for each ori-----------------------------------

roi(roi==0)=nan;
cardinal=im.equ_cardinal.*roi;
oblique=im.equ_oblique.*roi;
figure, imagesc(cardinal), colormap gray, axis image
c1_roi=double(cardinal<thr);%c1_roi(c1_roi==0)=nan;
c2_roi=double(cardinal>1-thr);%c2_roi(c2_roi==0)=nan;
c3_roi=double(oblique<thr);%c3_roi(c3_roi==0)=nan;
c4_roi=double(oblique>1-thr);%c4_roi(c4_roi==0)=nan;

figure, subplot(2,2,1),imagesc(c1_roi), colormap gray, axis image,title('c1')
 subplot(2,2,2),imagesc(c2_roi), colormap gray, axis image,title('c2')
 subplot(2,2,3),imagesc(c3_roi), colormap gray, axis image,title('c3')
 subplot(2,2,4),imagesc(c4_roi), colormap gray, axis image,title('c4')
 
 
[Gb,Gs1]=sig_timecourse(It.Gp1,It.Gp0,c1_roi,c1_roi);
[Gb,Gs2]=sig_timecourse(It.Gp2,It.Gp0,c2_roi,c2_roi);
[Gb,Gs3]=sig_timecourse(It.Gp3,It.Gp0,c3_roi,c3_roi);
[Gb,Gs4]=sig_timecourse(It.Gp4,It.Gp0,c4_roi,c4_roi);
figure, 
errorbar(1:20,Gb(1,:),Gb(2,:),'-o' ),hold on
errorbar(1:20,Gs1(1,:),Gs1(2,:),'-o' ), hold on,errorbar(1:20,Gs2(1,:),Gs2(2,:),'-o' ), hold on,
errorbar(1:20,Gs3(1,:),Gs3(2,:),'-o' ), hold on,errorbar(1:20,Gs4(1,:),Gs4(2,:),'-o' )
 legend('blank','c1','c2','c3','c4')

mX=(Gs1(1,:)+Gs2(1,:)+Gs3(1,:)+Gs4(1,:))./4;
sX=(Gs1(2,:)+Gs2(2,:)+Gs3(2,:)+Gs4(2,:))./4; 
figure, plot(mX,'o-'),title('')
figure, plot(sX,'o-')
      
  figure, 
 plot(1:20,Gb(2,:),'-o' ) ,hold on
plot(1:20,Gs1(2,:),'-o' ), hold on,plot(1:20,Gs2(2,:),'-o' ), hold on,
plot(1:20,Gs3(2,:),'-o' ), hold on,plot(1:20,Gs4(2,:),'-o' )
legend('stbl','stc1','stc2','stc3','stc4')



[SNR.c1]=SNRrat(Gs1(1,:),Gb(1,:),Gb(2,:))
[SNR.c2]=SNRrat(Gs2(1,:),Gb(1,:),Gb(2,:))
[SNR.c3]=SNRrat(Gs3(1,:),Gb(1,:),Gb(2,:))
[SNR.c4]=SNRrat(Gs4(1,:),Gb(1,:),Gb(2,:))

 figure, 
plot(1:20,SNR.c1,'-o' ), hold on,plot(1:20,SNR.c2,'-o' ), hold on,
plot(1:20,SNR.c3,'-o' ), hold on,plot(1:20,SNR.c4,'-o' )
ylabel('SNR'),xlabel('frames'),legend('c1','c2','c3','c4')

%------------Global SNR-----------------------------------








end




