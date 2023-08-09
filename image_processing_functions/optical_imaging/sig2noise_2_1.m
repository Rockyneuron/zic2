function[SNR]=sig2noise_2(It,im,roiS,roiB)
%--------------------------------------------------------------------------
% This function calulates de signal to noise ratio SNR of:
% 1) Global response off al conditions SNR(C1+C2+C3+C4)
% 2) Of the columns of response of each condition SNR(C1), SNR(C2)...
% Inputs:
% It...................................structure with all condition frames
% im...........................strucutre with all processed mean image frames  
% roiS..........................Region of interest for the signal 
% roiB.........................Region of interest for the blank 
%
% Output:
% SNR
%    . glbresp.......... SNR(C1+C2+C3+C4)               (1,:)=mean;(2,:)std
%    . blresp.............. SNR (blank)
%    . c1_roi................Roi for columns of C1
%    . c2_roi................Roi for columns of C2
%    . c3_roi................Roi for columns of C3
%    . c4_roi................Roi for columns of C4
%    . c1resp................mean(C1_roi)resp           (1,:)=mean;(2,:)std
%    . c2resp................mean(C2_roi)resp           (1,:)=mean;(2,:)std
%    . c3resp................mean(C3_roi)resp           (1,:)=mean;(2,:)std
%    . c4resp................mean(C4_roi)resp           (1,:)=mean;(2,:)std
%    . c1bl................Roi for columns of C1        (1,:)=mean;(2,:)std
%    . c2bl................Roi for columns of C2        (1,:)=mean;(2,:)std
%    . c3bl................Roi for columns of C3        (1,:)=mean;(2,:)std
%    . c4bl................Roi for columns of C4        (1,:)=mean;(2,:)std
%    . _c....................contrast SNR formula    
%    . _rat..................std from blank



%------------------------------------------------------------------------

%--------segment rois of response for each condition---------------------
thr=0.2;
roiS(roiS==0)=nan;
cardinal=im.equ_cardinal.*roiS;
oblique=im.equ_oblique.*roiS;
SNR.c1_roi=double(cardinal>1-thr);
SNR.c2_roi=double(cardinal<thr);
SNR.c3_roi=double(oblique<thr);
SNR.c4_roi=double(oblique>1-thr);


if nargin==4
%------------Calculate  signal timecourse for each ori--------------------

[SNR.c1resp]=sig_timecourse(It.Gp1,SNR.c1_roi);
[SNR.c1bl]=sig_timecourse(It.Gp1,roiB);

[SNR.c2resp]=sig_timecourse(It.Gp2,SNR.c2_roi);
[SNR.c2bl]=sig_timecourse(It.Gp2,roiB);

[SNR.c3resp]=sig_timecourse(It.Gp3,SNR.c3_roi);
[SNR.c3bl]=sig_timecourse(It.Gp3,roiB);

[SNR.c4resp]=sig_timecourse(It.Gp4,SNR.c4_roi);
[SNR.c4bl]=sig_timecourse(It.Gp4,roiB);

%------------Calculate Global signal timecourse---------------------------

totr=(It.Gp1+It.Gp2+It.Gp3+It.Gp4)./4;
[SNR.glbresp]=sig_timecourse(totr,roiS);
[SNR.blresp]=sig_timecourse(totr,roiB);



elseif nargin==3
    
%------------Calculate  signal timecourse for each ori--------------------
   
[SNR.c1resp]=sig_timecourse(It.Gp1,SNR.c1_roi);
[SNR.c1bl]=sig_timecourse(It.Gp0,SNR.c1_roi);

[SNR.c2resp]=sig_timecourse(It.Gp2,SNR.c2_roi);
[SNR.c2bl]=sig_timecourse(It.Gp0,SNR.c2_roi);

[SNR.c3resp]=sig_timecourse(It.Gp3,SNR.c3_roi);
[SNR.c3bl]=sig_timecourse(It.Gp0,SNR.c3_roi);

[SNR.c4resp]=sig_timecourse(It.Gp4,SNR.c4_roi);
[SNR.c4bl]=sig_timecourse(It.Gp0,SNR.c4_roi);

%------------Calculate Global signal timecourse---------------------------

totr=(It.Gp1+It.Gp2+It.Gp3+It.Gp4)./4;
[SNR.glbresp]=sig_timecourse(totr,roiS);
[SNR.blresp]=sig_timecourse(It.Gp0,roiS);

else
    error('Not enough input arguments')     
end

%-------------------Calculate SNR ---------------------------------------
  
[SNR.glb_rat,SNR.glb_c]=SNRrat(SNR.glbresp(1,:),SNR.blresp(1,:),SNR.blresp(2,:))
[SNR.c1_rat,SNR.c1_c]=SNRrat(SNR.c1resp(1,:),SNR.c1bl(1,:),SNR.c1bl(2,:))
[SNR.c2_rat,SNR.c2_c]=SNRrat(SNR.c2resp(1,:),SNR.c2bl(1,:),SNR.c2bl(2,:))
[SNR.c3_rat,SNR.c3_c]=SNRrat(SNR.c3resp(1,:),SNR.c3bl(1,:),SNR.c3bl(2,:))
[SNR.c4_rat,SNR.c4_c]=SNRrat(SNR.c4resp(1,:),SNR.c4bl(1,:),SNR.c4bl(2,:))

%-------------------------Plot Figures-------------------------------------

wd=1.5;
f0=figure
subplot(1,2,1)
errorbar(1:20,SNR.blresp(1,:),SNR.blresp(2,:),'-o' ,'LineWidth',wd),hold on
errorbar(1:20,SNR.glbresp(1,:),SNR.glbresp(2,:),'-o','LineWidth',wd )
hold on
mX=(SNR.c1resp(1,:)+SNR.c2resp(1,:)+SNR.c3resp(1,:)+SNR.c4resp(1,:))./4;
sX=(SNR.c1resp(2,:)+SNR.c2resp(2,:)+SNR.c3resp(2,:)+SNR.c4resp(2,:))./4;
errorbar(1:20,mX,sX,'-o','LineWidth',wd)
legend({'blank', 'Global response','mean each column response'},'FontSize',6)
xlabel('frames'), ylabel('response'),axis([1,21, 0,1]), axis square
% f0.Name='Global SNR'

subplot(1,2,2),
errorbar(1:20,SNR.blresp(1,:),SNR.blresp(2,:),'-o','LineWidth',wd ),hold on
errorbar(1:20,SNR.c1resp(1,:),SNR.c1resp(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c2resp(1,:),SNR.c2resp(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c3resp(1,:),SNR.c3resp(2,:),'-o','LineWidth',wd ), hold on,
errorbar(1:20,SNR.c4resp(1,:),SNR.c4resp(2,:),'-o' ,'LineWidth',wd)
legend({'blank','c1','c2','c3','c4'},'FontSize',6),
xlabel('frames'), ylabel('mean response'),axis([1,21, 0,1]), axis square
% f1.Name='SNR for each condition';

figure,
subplot(1,2,1),
plot(1:20,SNR.c1_rat(1,:),'-o','LineWidth',wd ), hold on,
plot(1:20,SNR.c2_rat(1,:),'-o','LineWidth',wd ), hold on,
plot(1:20,SNR.c3_rat(1,:),'-o','LineWidth',wd ), hold on,
plot(1:20,SNR.c4_rat(1,:),'-o','LineWidth',wd ),hold on,
plot(1:20,SNR.glb_rat(1,:),'-o','LineWidth',wd ),hold on,
line(1:length(SNR.blresp),repmat(0,1,length(SNR.blresp)),'Color','Black','LineWidth',wd )
legend({'c1','c2','c3','c4','global'},'FontSize',4),set(gca,'Xlim',[1,20]), axis square
xlabel('frames'), ylabel('sig-blank/std(blank)')
% f4.Name='SNR std ratio';


subplot(1,2,2),
plot(1:20,SNR.c1_c(1,:),'-o','LineWidth',wd ), hold on,
plot(1:20,SNR.c2_c(1,:),'-o','LineWidth',wd ), hold on,
plot(1:20,SNR.c3_c(1,:),'-o','LineWidth',wd), hold on,
plot(1:20,SNR.c4_c(1,:),'-o','LineWidth',wd ),hold on,
plot(1:20,SNR.glb_c(1,:),'-o','LineWidth',wd ),hold on,
line(1:length(SNR.blresp),repmat(0,1,length(SNR.blresp)),'Color','Black','LineWidth',wd ), axis square
legend({'c1','c2','c3','c4','global'},'FontSize',4)

xlabel('frames'), ylabel('sig-blank/sig+blank/'),axis([1,20 -0.5 0.5])
% f4.Name='SNR contrat';


Hmap=[SNR.glb_rat',SNR.c1_rat',SNR.c2_rat',SNR.c3_rat',SNR.c4_rat' ];
figure, 
subplot(2,1,1),imagesc(Hmap), colormap autumn, colorbar, title('std from background'), axis square
set(gca,'XTick',[1,2,3,4,5], 'XTickLabel',{'Global', 'C1', 'C2', 'C3', 'C4'},'YTick',[2:2:20],'YTickLabel',{'1','2','3','4','5','6','7','8','9','10'})
subplot(2,1,2),
Hmap=[SNR.glb_c',SNR.c1_c',SNR.c2_c',SNR.c3_c',SNR.c4_c' ];
imagesc(Hmap), colormap autumn, colorbar, title('sig-blank/sig+blank'), axis square
set(gca,'XTick',[1,2,3,4,5], 'XTickLabel',{'Global', 'C1', 'C2', 'C3', 'C4'},'YTick',[2:2:20],'YTickLabel',{'1','2','3','4','5','6','7','8','9','10'})


f3=figure, subplot(2,2,1),imagesc(SNR.c1_roi), colormap gray, axis image,title('c1')
subplot(2,2,2),imagesc(SNR.c2_roi), colormap gray, axis image,title('c2')
subplot(2,2,3),imagesc(SNR.c3_roi), colormap gray, axis image,title('c3')
subplot(2,2,4),imagesc(SNR.c4_roi), colormap gray, axis image,title('c4')


% 
% f7=figure,
% plot(1:20,SNR.blresp(2,:),'-o','LineWidth',wd ) ,hold on
% plot(1:20,SNR.c1resp(2,:),'-o' ,'LineWidth',wd), hold on,
% plot(1:20,SNR.c2resp(2,:),'-o' ,'LineWidth',wd), hold on,
% plot(1:20,SNR.c3resp(2,:),'-o','LineWidth',wd ), hold on,
% plot(1:20,SNR.c4resp(2,:),'-o' ,'LineWidth',wd)
% legend('bl','c1','c2','c3','c4')
% xlabel('frames'), ylabel('std'),axis([1,21, 0,1])
% f7.Name='std SNR for each condition';

end


    function[SNR,SNRc]=SNRrat(sig,back,stb)
    
        SNR=((sig-back)./stb);
        
        



SNRc=(sig-back)./(sig+back);

    end

    function[SNR,SNRc]=SNRrat_1(sig,back,roi)
    
                
roi(roi==0)=nan;
signal=sig.*repmat(roi,[1,1,20]);
signal=reshape(signal,[size(signal,1)*size(signal,2),size(signal,3)]);
background=reshape(back,[size(back,1)*size(back,2),size(back,3)]);
stb=std(background);


[SNR,SNRc]=SNRrat(signal,background,stb)





    end




% R = corrcoef(SNR.glbresp(1,:),SNR.blresp(1,:));
% 







