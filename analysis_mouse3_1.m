close all
clear all

addpath('image_processing_functions')
addpath('used_functions')
addpath(genpath('../data/raw_data'))

file_store='C:\projects\zic2\redo_analysis\new_scripts\analysed'

filename='mutant_170_right';


contra='251018Mice_mutant_170_E9B0.BLK.mat'
ipsi='251018Mice_mutant_170_E8B0.BLK.mat'
% binocular='241018Mice_mutant__E11B0.BLK.mat';


condition=5;
pprest=[1,3]; %prestimulus frames que usamos en el analysis [from:to]
alfa=1;%proporcion del baseline que eliminamos
clip=2; %std que usamos para ver la'no imagen
normalization='background div';%'background subs','background div',...
thr=0.7; %response region threshold
greymap=flipud(colormap('gray'))
colormap_use= colormap(greymap)
%'cocktail', ' blank'
%'dif_back_div', 'dif_back_div_blank' , 'dif_back_div_cock',
%'dif_back_subs','dif_back_subs_blank','dif_back_subs_cock'


%%%%%%%%%%%%%%%% Extract the data%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp={contra; ipsi}   % {righteye; lefteye;binocular};
for i=1:length(exp)
    load(exp{i,:})

    quepasa=num2str(input('one condition experiment? type: yes or no','s'))

    if strcmp(quepasa,'yes')
        cond_master=input('select condition for analysis c0 or c1','s');
        c0=cond_master;
        c1=cond_master;
        c2=cond_master;
        c3=cond_master;
        c4=cond_master;
    end

    % single_condition_map_montage(c0,c1,c2,c3,c4,ik,condition,pprest,alfa,clip,normalization)
    [cellc1,cellc2,cellc3,cellc4,cond1bl,cond2bl,cond3bl,cond4bl]=mouse_montage240418(c0,c1,c2,c3,c4,alfa,pprest,clip,normalization);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%select frame for%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%analysis%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    frame=input('Select frame for analysis, single or mean [frame:toframe]  = ');  %consola de comandos y seleccionar frame
    % [c1,c2,c3,c4]=singlecond_map_selec(c0,c1,c2,c3,c4,ik,condition,pprest,alfa,frame,clip,normalization);
    c1=cellc1(:,:,frame);c2=cellc2(:,:,frame);c3=cellc3(:,:,frame);c4=cellc4(:,:,frame);
    c1_B=cond1bl(:,:,frame);c2_B=cond2bl(:,:,frame);c3_B=cond3bl(:,:,frame);c4_B=cond4bl(:,:,frame);
    if i==1
        right_cond = input('Select right eye condition; c1 , c2 , c3 or c4  = ', 's');
        right_frame=frame;
        right=mean(eval(right_cond),3);
        right_B=mean(eval([right_cond '_B']),3);
        rc1=cellc1; rc2=cellc2; rc3=cellc3; rc4=cellc4;
        rc1_raw=cond1bl; rc2_raw=cond2bl; rc3_raw=cond3bl; rc4_raw=cond4bl;
        Rclframe=frame;
    end
    if i==2
        left_cond=input('Select left eye condition; c1 , c2 , c3 or c4   = ' , 's');
        left_frame=frame;
        left=mean(eval(left_cond),3);
        left_B=mean(eval([left_cond '_B']),3);
        lc1=cellc1; lc2=cellc2; lc3=cellc3; lc4=cellc4;
        lc1_raw=cond1bl; lc2_raw=cond2bl; lc3_raw=cond3bl; lc4_raw=cond4bl;
        Lclframe=frame;

    end
end
%%
%------------------------Normalize frames cualitatively--------------------

LC1frames=num2cell(lc1_raw,[1,2]);
LC2frames=num2cell(lc2_raw,[1,2]);
LC3frames=num2cell(lc3_raw,[1,2]);
LC4frames=num2cell(lc4_raw,[1,2]);

RC1frames=num2cell(rc1_raw,[1,2]);
RC2frames=num2cell(rc2_raw,[1,2]);
RC3frames=num2cell(rc3_raw,[1,2]);
RC4frames=num2cell(rc4_raw,[1,2]);

RC1frames_norm=(cellfun(@(x) mat2gray(x),RC1frames,'UniformOutput', false)) ;
RC2frames_norm=(cellfun(@(x) mat2gray(x),RC2frames,'UniformOutput', false)) ;
RC3frames_norm=(cellfun(@(x) mat2gray(x),RC3frames,'UniformOutput', false)) ;
RC4frames_norm=(cellfun(@(x) mat2gray(x),RC4frames,'UniformOutput', false)) ;

LC1frames_norm=(cellfun(@(x) mat2gray(x),LC1frames,'UniformOutput', false)) ;
LC2frames_norm=(cellfun(@(x) mat2gray(x),LC2frames,'UniformOutput', false)) ;
LC3frames_norm=(cellfun(@(x) mat2gray(x),LC3frames,'UniformOutput', false)) ;
LC4frames_norm=(cellfun(@(x) mat2gray(x),LC4frames,'UniformOutput', false)) ;

%%

%--------------- Denoise data---------------------
m=5;  %tamaño de la mascara
n=5;

% Denoise normalized data for cualitative ocular dominance areas

RGp1=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),RC1frames_norm,'UniformOutput', false)) ;
RGp2=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),RC2frames_norm,'UniformOutput', false)) ;
RGp3=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),RC3frames_norm,'UniformOutput', false)) ;
RGp4=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),RC4frames_norm,'UniformOutput', false)) ;
LGp1=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),LC1frames_norm,'UniformOutput', false)) ;
LGp2=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),LC2frames_norm,'UniformOutput', false)) ;
LGp3=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),LC3frames_norm,'UniformOutput', false)) ;
LGp4=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n)),LC4frames_norm,'UniformOutput', false)) ;

% Denoise raw data with background divison for fine ODI quantification
RGp1_raw=cell2mat(cellfun(@(x) ordfilt2(x,mean(1:m*n), ones(m,n),'symmetric'),RC1frames,'UniformOutput', false)) ;
RGp2_raw=cell2mat(cellfun(@(x) ordfilt2(x,mean(1:m*n), ones(m,n),'symmetric'),RC2frames,'UniformOutput', false)) ;
RGp3_raw=cell2mat(cellfun(@(x) ordfilt2(x,mean(1:m*n), ones(m,n),'symmetric'),RC3frames,'UniformOutput', false)) ;
RGp4_raw=cell2mat(cellfun(@(x) ordfilt2(x,mean(1:m*n), ones(m,n),'symmetric'),RC4frames,'UniformOutput', false)) ;
LGp1_raw=cell2mat(cellfun(@(x) ordfilt2(x,mean(1:m*n), ones(m,n),'symmetric'),LC1frames,'UniformOutput', false)) ;
LGp2_raw=cell2mat(cellfun(@(x) ordfilt2(x,mean(1:m*n), ones(m,n),'symmetric'),LC2frames,'UniformOutput', false)) ;
LGp3_raw=cell2mat(cellfun(@(x) ordfilt2(x,mean(1:m*n), ones(m,n),'symmetric'),LC3frames,'UniformOutput', false)) ;
LGp4_raw=cell2mat(cellfun(@(x) ordfilt2(x,mean(1:m*n), ones(m,n),'symmetric'),LC4frames,'UniformOutput', false)) ;


% Denoise raw data with background divison for fine ODI quantification
% using a mean filter
% w= fspecial('gaussian',[m,n],5)
% 
% RGp1_raw=cell2mat(cellfun(@(x) imfilter(x,w,'replicate'),RC1frames,'UniformOutput', false)) ;
% RGp2_raw=cell2mat(cellfun(@(x) imfilter(x,w,'replicate'),RC2frames,'UniformOutput', false)) ;
% RGp3_raw=cell2mat(cellfun(@(x) imfilter(x,w,'replicate'),RC3frames,'UniformOutput', false)) ;
% RGp4_raw=cell2mat(cellfun(@(x) imfilter(x,w,'replicate'),RC4frames,'UniformOutput', false)) ;
% LGp1_raw=cell2mat(cellfun(@(x) imfilter(x,w,'replicate'),LC1frames,'UniformOutput', false)) ;
% LGp2_raw=cell2mat(cellfun(@(x) imfilter(x,w,'replicate'),LC2frames,'UniformOutput', false)) ;
% LGp3_raw=cell2mat(cellfun(@(x) imfilter(x,w,'replicate'),LC3frames,'UniformOutput', false)) ;
% LGp4_raw=cell2mat(cellfun(@(x) imfilter(x,w,'replicate'),LC4frames,'UniformOutput', false)) ;

%% ---------------Colapse Raw data and filtered data ---------------------

[RC1,RC2,RC3,RC4,RC1raw,RC2raw,RC3raw,RC4raw]=collapse_frames(RGp1,RGp2,RGp3,RGp4,RGp1_raw,RGp2_raw,RGp3_raw,RGp4_raw,frame) ;
[LC1,LC2,LC3,LC4,LC1raw,LC2raw,LC3raw,LC4raw]=collapse_frames(LGp1,LGp2,LGp3,LGp4,LGp1_raw,LGp2_raw,LGp3_raw,LGp4_raw,frame)  ;


%% --------------- Equalize images ---------------------------------------

[RC1eq,RC2eq,RC3eq,RC4eq]=custom_equalization(RC1,RC2,RC3,RC4);
[LC1eq,LC2eq,LC3eq,LC4eq]=custom_equalization(LC1,LC2,LC3,LC4);

%%
contra_raw=(RC1raw+RC2raw+RC3raw+RC4raw)./4;
ipsi_raw=(LC1raw+LC2raw+LC3raw+LC4raw)./4;
contra_eq=(RC1eq+RC2eq+RC3eq+RC4eq)./4;
ipsi_eq=(LC1eq+LC2eq+LC3eq+LC4eq)./4;
contra_filt=(RC1+RC2+RC3+RC4)./4;
ipsi_filt=(LC1+LC2+LC3+LC4)./4;

figure,subplot(2,3,1), imagesc(contra_filt), axis image, colormap gray,title('filt contra'), colorbar
subplot(2,3,2),  imagesc(ipsi_filt), axis image, colormap gray,title(' filt ipsi')
subplot(2,3,3), imagesc(contra_eq), axis image,  colormap gray,title('Eq contra')
subplot(2,3,4),  imagesc(ipsi_eq), axis image,  colormap gray,title('Eq ipsi')
subplot(2,3,5), imagesc(contra_raw), axis image,  colormap gray,title('raw contra')
subplot(2,3,6),  imagesc(ipsi_raw), axis image, colormap gray,title('raw ipsi'), colorbar


min_reponse=min([contra_raw(:);ipsi_raw(:)])
max_reponse=max([contra_raw(:);ipsi_raw(:)])

figure,subplot(1,2,1), imagesc(contra_raw), axis image,  colormap gray,title('raw contra'), colorbar
subplot(1,2,2), imagesc(ipsi_raw), axis image,  colormap gray,title('raw ipsi'),colorbar
clim([min_reponse, max_reponse])

% lets flip de signal
% contra_raw=max(contra_raw)-contra_raw
% ipsi_raw=max(ipsi_raw)-ipsi_raw
% 
% contra_eq=max(contra_eq)-contra_eq
% ipsi_eq=max(ipsi_eq)-ipsi_eq
% 
% contra_filt=max(contra_filt)-contra_filt
% ipsi_filt=max(ipsi_filt)-ipsi_filt

% contra_raw=imcomplement(contra_raw)
% ipsi_raw=imcomplement(ipsi_raw)
% 
% contra_eq=imcomplement(contra_eq)
% ipsi_eq=imcomplement(ipsi_eq)
% 
% contra_filt=imcomplement(contra_filt)
% ipsi_filt=imcomplement(ipsi_filt)
% 
% figure,subplot(2,3,1), imagesc(contra_filt), axis image, colormap(greymap),title('filt contra'), colorbar
% subplot(2,3,2),  imagesc(ipsi_filt), axis image, colormap(greymap),title(' filt ipsi')
% subplot(2,3,3), imagesc(contra_eq), axis image,  colormap(greymap),title('Eq contra')
% subplot(2,3,4),  imagesc(ipsi_eq), axis image,  colormap(greymap),title('Eq ipsi')
% subplot(2,3,5), imagesc(contra_raw), axis image,  colormap(greymap),title('raw contra')
% subplot(2,3,6),  imagesc(ipsi_raw), axis image, colormap(greymap),title('raw ipsi'), colorbar


%%
%Select ROI of interest

figure, subplot(1,2,1),imagesc(ipsi_filt), axis image, colormap(colormap_use)
subplot(1,2,2),imagesc(contra_filt), axis image, colormap(colormap_use)

[im1,im2,ROI]=selec_roi(ipsi_filt,contra_filt);
% ROI=ones(size(RC1eq))

% ROI(ROI==0)=nan;


%%
%estimate background noise
contra_back=contra_raw
ipsi_back=ipsi_raw
[contra_eq_rand,SNR_contra]=estimate_back_noise(contra_back,ROI)
fprintf('snr for contra stim is: %2f\n', SNR_contra);
[ipsi_eq_rand,SNR_ipsi]=estimate_back_noise(ipsi_back,ROI)
fprintf('snr for ipsi stim is: %2f\n', SNR_ipsi);



%% Treshhold at 70 % peak response

ROI(ROI==0)=nan;


contra=contra_raw.*ROI;
ipsi=ipsi_raw.*ROI;

contra(ROI==1)=mat2gray(contra(ROI==1));
ipsi(ROI==1)=mat2gray(ipsi(ROI==1));

contra_reg=((1-contra)>thr);
ipsi_reg=((1-ipsi)>thr);

contra=contra_reg.*contra;
ipsi=ipsi_reg.*ipsi;

contra_filt=(contra_filt).*contra_reg;
ipsi_filt=(ipsi_filt).*ipsi_reg;
contra_eq=(contra_eq).*contra_reg;
ipsi_eq=(ipsi_eq).*ipsi_reg;
contra_raw=(contra_raw).*contra_reg;
ipsi_raw=(ipsi_raw).*ipsi_reg;

figure, imagesc(contra), axis image, colormap gray, colorbar
figure, imagesc(ipsi), axis image, colormap gray,colorbar


%%
%-------------------Area de Solapamiemto--------------------------------%

contra_area=contra>0;
ipsi_area=ipsi>0;
solap=(2*contra_area)-(1*ipsi_area);


figure,subplot(1,3,1), imagesc(contra_area), axis image, colormap gray,title('contra area')
subplot(1,3,2),  imagesc(ipsi_area), axis image, colormap gray,title('ipsi area')
subplot(1,3,3), imagesc(solap), axis image, colormap gray,title('solap bin=1 contra=2 ipsi=-1')

%%

%---------------------Peak distance---------------------------------------%

[cpeak,valc1]=findpeak(1-contra);
[ippeak,valip1]=findpeak(1-ipsi);

[c1out]=center_of_mass_3(contra);
[ip1out]=center_of_mass_3(ipsi);


D_peaks = pdist([cpeak;ippeak]);
CM_dist = pdist([c1out(2:end);ip1out(2:end)]);

figure, imagesc(solap), axis image, colormap gray,title('Raw contra')
hold on, plot([cpeak(2),ippeak(2)],[cpeak(1),ippeak(1)],'o')
hold on, plot([c1out(3),ip1out(3)],[c1out(2),ip1out(2)],'o')

%%
%--------------------- ODI PIXEL A PIXEL----------------------------------%
custom_map=[0 0 0; colormap(gray)];
background_color=[0.2,0.2,0.4]

%all the region
filt_ODI=(contra_filt-ipsi_filt)./(contra_filt+ipsi_filt);
equ_ODI=(contra_eq-ipsi_eq)./(contra_eq+ipsi_eq);
RAW_ODI=(contra_raw-ipsi_raw)./(contra_raw+ipsi_raw);

%binocular region
nan_roi=double(solap==1); nan_roi(nan_roi==0)=nan;
bin_filt_ODI=filt_ODI.*nan_roi;
bin_equ_ODI=equ_ODI.*nan_roi;
bin_RAW_ODI=mat2gray(RAW_ODI).*nan_roi;

figure,subplot(3,2,1), imagesc(filt_ODI,'AlphaData',~isnan(filt_ODI)), axis image,
colormap(custom_map),set(gca,'color',background_color),title(filename, 'Interpreter', 'none');
subplot(3,2,2), hist(filt_ODI(:),20), title('OD filt Data')
subplot(3,2,3), imagesc(equ_ODI,'AlphaData',~isnan(equ_ODI)), colormap(custom_map),axis image,set(gca,'color',background_color);
subplot(3,2,4), hist(equ_ODI(:),20), title('OD Equalized Data')
subplot(3,2,5), imagesc(RAW_ODI,'AlphaData',~isnan(RAW_ODI)), colormap(custom_map),axis image,set(gca,'color',background_color);
subplot(3,2,6), hist(RAW_ODI(:),20), title('RAW Data')


figure,subplot(3,2,1), imagesc(bin_filt_ODI,'AlphaData',~isnan(bin_filt_ODI)), axis image, colormap(custom_map),set(gca,'color',background_color);
subplot(3,2,2), hist(bin_filt_ODI(:),20), title('OD bino filt Data')
subplot(3,2,3), imagesc(bin_equ_ODI,'AlphaData',~isnan(bin_equ_ODI)), colormap(custom_map),axis image,set(gca,'color',background_color);
subplot(3,2,4), hist(bin_equ_ODI(:),20), title('OD bino Equalized Data')
subplot(3,2,5), imagesc(bin_RAW_ODI,'AlphaData',~isnan(bin_RAW_ODI)), colormap(custom_map),axis image,set(gca,'color',background_color);
subplot(3,2,6), hist(bin_RAW_ODI(:),20), title('RAW bino Data')

%%
%---------------------------------OD MAP----------------------------------


figure, imagesc(filt_ODI,'AlphaData',~isnan(filt_ODI)), axis image, colormap(custom_map),set(gca,'color',background_color);

figure, imagesc(contra,'AlphaData',~isnan(RAW_ODI)), axis image, colormap(custom_map),set(gca,'color',background_color);


figure, imagesc(contra_raw-ipsi_raw,'AlphaData',~isnan(RAW_ODI)), axis image, colormap gray,set(gca,'color',background_color);


%%
%---------------------Save variables---------------------------------------%
if input('type yes to end analysis','s')=='yes'
else
    display('you have entered same else, press cntr+c to end analysis')
end

area.solap=solap;
area.contra_area=contra_area;
area.ipsi_area=ipsi_area;

peaks.D_peaks=D_peaks;
peaks.CM_dist=CM_dist;

ODI.filt=filt_ODI;
ODI.raw=equ_ODI;
ODI.equ=RAW_ODI;

ODIbino.filt=bin_filt_ODI;
ODIbino.raw=bin_equ_ODI;
ODIbino.equ=bin_RAW_ODI;

SNR.contra=SNR_contra;
SNR.ipsi=SNR_ipsi;

cd(file_store)
mkdir(filename); cd(filename); save(num2str(filename))

