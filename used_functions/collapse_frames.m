function[RC1,RC2,RC3,RC4,RC1raw,RC2raw,RC3raw,RC4raw]=collapse_frames(RGp1,RGp2,RGp3,RGp4,rc1_raw,rc2_raw,rc3_raw,rc4_raw,frame)

RC1=mat2gray(mean(RGp1(:,:,frame),3));
RC2=mat2gray(mean(RGp2(:,:,frame),3));
RC3=mat2gray(mean(RGp3(:,:,frame),3));
RC4=mat2gray(mean(RGp4(:,:,frame),3));

RC1raw=mean(rc1_raw(:,:,frame),3);
RC2raw=mean(rc2_raw(:,:,frame),3);
RC3raw=mean(rc3_raw(:,:,frame),3);
RC4raw=mean(rc4_raw(:,:,frame),3);

nbins=50;

figure
subplot(2,4,1),imagesc(RC1), colormap gray, axis image,title('filt c1')
subplot(2,4,2),histogram(RC1(:),nbins);
subplot(2,4,3),imagesc(RC2), colormap gray, axis image,title('filt c2')
subplot(2,4,4),histogram(RC2(:),nbins);
subplot(2,4,5),imagesc(RC3), colormap gray, axis image,title('filt c3')
subplot(2,4,6),histogram(RC3(:),nbins);
subplot(2,4,7),imagesc(RC4), colormap gray, axis image,title('filt c4')
subplot(2,4,8),histogram(RC4(:),nbins);

figure,
subplot(2,4,1),imagesc(RC1raw), colormap gray, axis image,title('raw c4')
subplot(2,4,2),histogram(RC1raw(:),nbins);
subplot(2,4,3),imagesc(RC2raw), colormap gray, axis image,title('raw c4')
subplot(2,4,4),histogram(RC2raw(:),nbins);
subplot(2,4,5),imagesc(RC3raw), colormap gray, axis image,title('raw c4')
subplot(2,4,6),histogram(RC3raw(:),nbins);
subplot(2,4,7),imagesc(RC4raw), colormap gray, axis image,title('raw c4')
subplot(2,4,8),histogram(RC4raw(:),nbins);


