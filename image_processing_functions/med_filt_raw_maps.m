function[im]=med_filt_raw_maps(frames,n,m,par,roi)

% Input
%frames................experimental frames
%m n []................median filter size
%par..................Parameters of each experiment
    %%
  %%%%%Aditional way of calculationg OPM without kashube filer, just a
  %%%%%median filter
im.roi=roi;
C0frames=num2cell(frames.blank,[1,2]);
C1frames=num2cell(frames.cond1,[1,2]);
C2frames=num2cell(frames.cond2,[1,2]);
C3frames=num2cell(frames.cond3,[1,2]);
C4frames=num2cell(frames.cond4,[1,2]);

%%
%-----------------------------Denoise data--------------------------------%
%----------------Normalize 0 to 1------------------------------------------

 C0frames=(cellfun(@(x) mat2gray(x),C0frames,'UniformOutput', false)) ;
 C1frames=(cellfun(@(x) mat2gray(x),C1frames,'UniformOutput', false)) ;
 C2frames=(cellfun(@(x) mat2gray(x),C2frames,'UniformOutput', false)) ;
 C3frames=(cellfun(@(x) mat2gray(x),C3frames,'UniformOutput', false)) ;
 C4frames=(cellfun(@(x) mat2gray(x),C4frames,'UniformOutput', false)) ;


%%%-------do median filter
    frm.Gp0=(cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),C0frames,'UniformOutput', false))) ;
    frm.Gp1=(cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),C1frames,'UniformOutput', false))) ;
    frm.Gp2=(cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),C2frames,'UniformOutput', false))) ;
    frm.Gp3=(cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),C3frames,'UniformOutput', false))) ;
    frm.Gp4=(cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),C4frames,'UniformOutput', false))) ;
%%%-------mean of the frames of interest
im.raw_C0=(mean(frm.Gp0(:,:,par.frame),3));
im.raw_C1=(mean(frm.Gp1(:,:,par.frame),3));
im.raw_C2=(mean(frm.Gp2(:,:,par.frame),3));
im.raw_C3=(mean(frm.Gp3(:,:,par.frame),3));
im.raw_C4=(mean(frm.Gp4(:,:,par.frame),3));

rmin=min([im.raw_C1(:);im.raw_C2(:);im.raw_C3(:);im.raw_C4(:)]);
rmax=max([im.raw_C1(:);im.raw_C2(:);im.raw_C3(:);im.raw_C4(:)]);

nbins=256;
vec=linspace(rmin,rmax,nbins);

p1=imhist(im.raw_C1,nbins)./numel(im.raw_C1(:));
p2=imhist(im.raw_C2,nbins)./numel(im.raw_C2(:));
p3=imhist(im.raw_C3,nbins)./numel(im.raw_C3(:));
p4=imhist(im.raw_C4,nbins)./numel(im.raw_C4(:));

figure,
subplot(2,4,1),imagesc(im.raw_C1,[rmin,rmax]), colormap gray, axis image,title(['c1 unique=' num2str(length(unique(im.raw_C1)))])
subplot(2,4,2),bar(vec,p1), axis([-0.1 1.1 0 0.15])
subplot(2,4,3),imagesc(im.raw_C2,[rmin,rmax]), colormap gray, axis image,title(['c2 unique=' num2str(length(unique(im.raw_C2)))])
subplot(2,4,4),bar(vec,p2), axis([-0.1 1.1 0 0.15])
subplot(2,4,5),imagesc(im.raw_C3,[rmin,rmax]), colormap gray, axis image,title(['c3 unique=' num2str(length(unique(im.raw_C3)))])
subplot(2,4,6),bar(vec,p3), axis([-0.1 1.1 0 0.15])
subplot(2,4,7),imagesc(im.raw_C4,[rmin,rmax]), colormap gray, axis image,title(['c4 unique=' num2str(length(unique(im.raw_C4)))])
subplot(2,4,8),bar(vec,p4), axis([-0.1 1.1 0 0.15])

% with equalization
[im.C1_equ]=ip_histeq(im.raw_C1.*im.roi,numel(im.raw_C1));
[im.C2_equ]=ip_histeq(im.raw_C2.*im.roi,numel(im.raw_C2));
[im.C3_equ]=ip_histeq(im.raw_C3.*im.roi,numel(im.raw_C3));
[im.C4_equ]=ip_histeq(im.raw_C4.*im.roi,numel(im.raw_C4));

rmin=min([im.C1_equ(:);im.C2_equ(:);im.C3_equ(:);im.C4_equ(:)]);
rmax=max([im.C1_equ(:);im.C2_equ(:);im.C3_equ(:);im.C4_equ(:)]);
nbins=256;
vec=linspace(rmin,rmax,nbins);
p1=imhist(im.C1_equ(im.roi),nbins)./numel(im.raw_C1(:));
p2=imhist(im.C2_equ(im.roi),nbins)./numel(im.raw_C2(:));
p3=imhist(im.C3_equ(im.roi),nbins)./numel(im.raw_C3(:));
p4=imhist(im.C4_equ(im.roi),nbins)./numel(im.raw_C4(:));
figure,
subplot(2,4,1),imagesc(im.C1_equ,[rmin,rmax]), colormap gray, axis image,title(['c1 unique=' num2str(length(unique(im.raw_C1)))])
subplot(2,4,2),bar(vec,p1)
subplot(2,4,3),imagesc(im.C2_equ,[rmin,rmax]), colormap gray, axis image,title(['c2 unique=' num2str(length(unique(im.raw_C2)))])
subplot(2,4,4),bar(vec,p2)
subplot(2,4,5),imagesc(im.C3_equ,[rmin,rmax]), colormap gray, axis image,title(['c3 unique=' num2str(length(unique(im.raw_C3)))])
subplot(2,4,6),bar(vec,p3)
subplot(2,4,7),imagesc(im.C4_equ,[rmin,rmax]), colormap gray, axis image,title(['c4 unique=' num2str(length(unique(im.raw_C4)))])
subplot(2,4,8),bar(vec,p4)





end