function[SNR]=sig2noise_2(It,im,roi)
%--------------------------------------------------------------------------
% This function calulates de signal to noise ratio SNR of:
% 1) Global response off al conditions SNR(C1+C2+C3+C4)
% 2) Of the columns of response of each condition SNR(C1), SNR(C2)...
% Inputs:
% It...................................structure with all condition frames
% im...........................strucutre with all processed mean image frames  
% roi..........................Region of interest for the signal 
%
% Output:
% SNR
%    . global.......... SNR(C1+C2+C3+C4)               (1,:)=mean;(2,:)std
%    . bl.............. SNR (blank)
%    . c1_roi................Roi for columns of C1
%    . c2_roi................Roi for columns of C2
%    . c3_roi................Roi for columns of C3
%    . c4_roi................Roi for columns of C4
%    . c1resp................mean(C1)resp               (1,:)=mean;(2,:)std
%    . c2resp................mean(C2)resp               (1,:)=mean;(2,:)std
%    . c3resp................mean(C3)resp               (1,:)=mean;(2,:)std
%    . c4resp................mean(C4)resp               (1,:)=mean;(2,:)std
%    . _c....................contrast SNR formula    
%    . _rat..................std from blank


%-----------------------------------------------------------------------

thr=0.2;

  
%------------Calculate Global SNR-----------------------------------------

totr=(It.Gp1+It.Gp2+It.Gp3+It.Gp4)./4;
[SNR.global,SNR.bl]=sig_timecourse(totr,It.Gp0,roi,roi);
% [SNR.global,SNR.bl]=sig_timecourse(totr,totr,roi,roi);

%------------Calculate SNR for each ori-----------------------------------

roi(roi==0)=nan;
cardinal=im.equ_cardinal.*roi;
oblique=im.equ_oblique.*roi;
SNR.c1_roi=double(cardinal>1-thr);
SNR.c2_roi=double(cardinal<thr);
SNR.c3_roi=double(oblique<thr);
SNR.c4_roi=double(oblique>1-thr);

[SNR.c1]=sig_timecourse(It.Gp1,It.Gp0,SNR.c1_roi,SNR.c1_roi);
[SNR.c2]=sig_timecourse(It.Gp2,It.Gp0,SNR.c2_roi,SNR.c2_roi);
[SNR.c3]=sig_timecourse(It.Gp3,It.Gp0,SNR.c3_roi,SNR.c3_roi);
[SNR.c4]=sig_timecourse(It.Gp4,It.Gp0,SNR.c4_roi,SNR.c4_roi);

[SNR.glb_rat,SNR.glb_c]=SNRrat(SNR.global(1,:),SNR.bl(1,:),SNR.bl(2,:))
[SNR.c1_rat,SNR.c1_c]=SNRrat(SNR.c1(1,:),SNR.bl(1,:),SNR.bl(2,:))
[SNR.c2_rat,SNR.c2_c]=SNRrat(SNR.c2(1,:),SNR.bl(1,:),SNR.bl(2,:))
[SNR.c3_rat,SNR.c3_c]=SNRrat(SNR.c3(1,:),SNR.bl(1,:),SNR.bl(2,:))
[SNR.c4_rat,SNR.c4_c]=SNRrat(SNR.c4(1,:),SNR.bl(1,:),SNR.bl(2,:))

%-------------------------Plot Figures-------------------------------------
wd=1.5;
f0=figure

errorbar(1:20,SNR.bl(1,:),SNR.bl(2,:),'-o' ,'LineWidth',wd),hold on
errorbar(1:20,SNR.global(1,:),SNR.global(2,:),'-o','LineWidth',wd )
hold on
mX=(SNR.c1(1,:)+SNR.c2(1,:)+SNR.c3(1,:)+SNR.c4(1,:))./4;
sX=(SNR.c1(2,:)+SNR.c2(2,:)+SNR.c3(2,:)+SNR.c4(2,:))./4; 
errorbar(1:20,mX,sX,'-o','LineWidth',wd)

legend('blank', 'Global response','mean each column response')
xlabel('frames'), ylabel('response'),set(gca,'Xlim',[1,20])
f0.Name='Global SNR'

f1=figure, 
errorbar(1:20,SNR.bl(1,:),SNR.bl(2,:),'-o','LineWidth',wd ),hold on
errorbar(1:20,SNR.c1(1,:),SNR.c1(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c2(1,:),SNR.c2(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c3(1,:),SNR.c3(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c4(1,:),SNR.c4(2,:),'-o' ,'LineWidth',wd)
 legend('blank','c1','c2','c3','c4'),
 xlabel('frames'), ylabel('mean response'),axis([1,21, 0,1])
 f1.Name='SNR for each condition';


 f3=figure, subplot(2,2,1),imagesc(SNR.c1_roi), colormap gray, axis image,title('c1')
 subplot(2,2,2),imagesc(SNR.c2_roi), colormap gray, axis image,title('c2')
 subplot(2,2,3),imagesc(SNR.c3_roi), colormap gray, axis image,title('c3')
 subplot(2,2,4),imagesc(SNR.c4_roi), colormap gray, axis image,title('c4')


  f7=figure, 
 plot(1:20,SNR.bl(2,:),'-o','LineWidth',wd ) ,hold on
plot(1:20,SNR.c1(2,:),'-o' ,'LineWidth',wd), hold on,
plot(1:20,SNR.c2(2,:),'-o' ,'LineWidth',wd), hold on,
plot(1:20,SNR.c3(2,:),'-o','LineWidth',wd ), hold on,
plot(1:20,SNR.c4(2,:),'-o' ,'LineWidth',wd)
legend('bl','c1','c2','c3','c4')
 xlabel('frames'), ylabel('std'),axis([1,21, 0,1])
 f7.Name='std SNR for each condition';


f4=figure, 
errorbar(1:20,SNR.c1_rat(1,:),SNR.c1(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c2_rat(1,:),SNR.c2(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c3_rat(1,:),SNR.c3(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c4_rat(1,:),SNR.c4(2,:),'-o','LineWidth',wd ),hold on,
errorbar(1:20,SNR.glb_rat(1,:),SNR.global(2,:),'-o','LineWidth',wd ),hold on,
line(1:length(SNR.bl),repmat(0,1,length(SNR.bl)),'Color','Black','LineWidth',wd )
 legend('c1','c2','c3','c4','global'),set(gca,'Xlim',[1,20])
 xlabel('frames'), ylabel('sig-blank/std(blank)')
 f4.Name='SNR std ratio';


f4=figure, 
errorbar(1:20,SNR.c1_c(1,:),SNR.c1(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c2_c(1,:),SNR.c2(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c3_c(1,:),SNR.c3(2,:),'-o','LineWidth',wd), hold on,
errorbar(1:20,SNR.c4_c(1,:),SNR.c4(2,:),'-o','LineWidth',wd ),hold on,
errorbar(1:20,SNR.glb_c(1,:),SNR.global(2,:),'-o','LineWidth',wd ),hold on,

line(1:length(SNR.bl),repmat(0,1,length(SNR.bl)),'Color','Black','LineWidth',wd )
 legend('c1','c2','c3','c4','global'),
 xlabel('frames'), ylabel('sig-blank/sig+blank/'),axis([1,20 -1 1])
 f4.Name='SNR contrat';

end


  function[tms,tmb]=sig_timecourse(It,Itb,roi_s,roi_b)
        roi_b(roi_b==0)=nan;
        back=Itb.*repmat(roi_b,[1,1,20]);
%         f=figure,montage(double2rgb(back,gray),gray),title('blank')
        f.Name='blank'
        tmb=[nanmean(reshape(back,[size(back,1)*size(back,2),size(back,3)]),1);
            nanstd(reshape(back,[size(back,1)*size(back,2),size(back,3)]),1)];
        
        roi_s(roi_s==0)=nan;
        signal=It.*repmat(roi_s,[1,1,20]);
%         figure,montage(double2rgb(signal,gray),gray),title('single condition 1 blank')
        tms=[nanmean(reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]),1);
            nanstd(reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]),1)];
      
    end

    function[SNR,SNRc]=SNRrat(sig,back,stb)
        SNR=((sig-back)./stb);
        SNRc=(sig-back)./(sig+back);

    end













