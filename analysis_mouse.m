close all
clear all

addpath('image_processing_functions')
addpath('used_functions')
addpath(genpath('../data/raw_data'))

file_store='analysed'

filename='mut_171_right';

contra='261018Mice_mutant_171_E7B0.BLK.mat'
ipsi='261018Mice_mutant_171_E8B0.BLK.mat'
% binocular='241018Mice_mutant__E11B0.BLK.mat';


condition=5;
pprest=[1,3]; %prestimulus frames used for analysis [from:to]
alfa=1;%alfa parameter for baseline
clip=2; %std clipping used to se the signal
normalization='background div';%'background subs','background div', (Type of normalization)
thr=0.7; %response region threshold
greymap=flipud(colormap('gray'))
colormap_use= colormap(greymap)
background_color=[0.2,0.2,0.4]

% Types of normalization:
%'cocktail', ' blank'
%'dif_back_div', 'dif_back_div_blank' , 'dif_back_div_cock',
%'dif_back_subs','dif_back_subs_blank','dif_back_subs_cock'


%%%%%%%%%%%%%%%%       Extract the data                    %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
exp={contra; ipsi}   % {righteye; lefteye;binocular};
for i=1:length(exp)
    load(exp{i,:})

    quepasa=num2str(input('one condition experiment? type: yes or no: ','s'))

    if strcmp(quepasa,'yes')
        cond_master=input('select condition for analysis c0 or c1');
        c0=cond_master;
        c1=cond_master;
        c2=cond_master;
        c3=cond_master;
        c4=cond_master;
    end

    % single_condition_map_montage(c0,c1,c2,c3,c4,ik,condition,pprest,alfa,clip,normalization)
    [cellc1,cellc2,cellc3,cellc4,cond1bl,cond2bl,cond3bl,cond4bl]=mouse_montage240418(c0,c1,c2,c3,c4,alfa,pprest,clip,normalization);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%        select frame for     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%           analysis            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    frame=input('Select frame for analysis, single or mean [frame:toframe]  = ');  %consola de comandos y seleccionar frame
    % [c1,c2,c3,c4]=singlecond_map_selec(c0,c1,c2,c3,c4,ik,condition,pprest,alfa,frame,clip,normalization);
    c1=cellc1(:,:,frame);c2=cellc2(:,:,frame);c3=cellc3(:,:,frame);c4=cellc4(:,:,frame);
    c1_B=cond1bl(:,:,frame);c2_B=cond2bl(:,:,frame);c3_B=cond3bl(:,:,frame);c4_B=cond4bl(:,:,frame);
    if i==1
        % right_cond = input('Select right eye condition; c1 , c2 , c3 or c4  = ', 's');
        % right_frame=frame;
        % right=mean(eval(right_cond),3);
        % right_B=mean(eval([right_cond '_B']),3);
        rc1=cellc1; rc2=cellc2; rc3=cellc3; rc4=cellc4;
        rc1_raw=cond1bl; rc2_raw=cond2bl; rc3_raw=cond3bl; rc4_raw=cond4bl;
        Rclframe=frame;
    end
    if i==2
        % left_cond=input('Select left eye condition; c1 , c2 , c3 or c4   = ' , 's');
        % left_frame=frame;
        % left=mean(eval(left_cond),3);
        % left_B=mean(eval([left_cond '_B']),3);
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
m=5;  %size of convolution mask
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
RGp1_raw=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n),'symmetric'),RC1frames,'UniformOutput', false)) ;
RGp2_raw=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n),'symmetric'),RC2frames,'UniformOutput', false)) ;
RGp3_raw=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n),'symmetric'),RC3frames,'UniformOutput', false)) ;
RGp4_raw=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n),'symmetric'),RC4frames,'UniformOutput', false)) ;
LGp1_raw=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n),'symmetric'),LC1frames,'UniformOutput', false)) ;
LGp2_raw=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n),'symmetric'),LC2frames,'UniformOutput', false)) ;
LGp3_raw=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n),'symmetric'),LC3frames,'UniformOutput', false)) ;
LGp4_raw=cell2mat(cellfun(@(x) ordfilt2(x,median(1:m*n), ones(m,n),'symmetric'),LC4frames,'UniformOutput', false)) ;
% 
% % 
% % Denoise raw data with background divison for fine ODI quantification
% % using a mean filter
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

data.contra_raw=(RC1raw+RC2raw+RC3raw+RC4raw)./4;
data.ipsi_raw=(LC1raw+LC2raw+LC3raw+LC4raw)./4;
data.contra_eq=(RC1eq+RC2eq+RC3eq+RC4eq)./4;
data.ipsi_eq=(LC1eq+LC2eq+LC3eq+LC4eq)./4;
data.contra_filt=(RC1+RC2+RC3+RC4)./4;
data.ipsi_filt=(LC1+LC2+LC3+LC4)./4;

% if necesarry cut a subregion of the image (to remove big artifacts)
% just for the purpouse of visualization
% 
% cut_row_1=1;
% cut_row_2=300;
% cut_col_1=1;
% cut_col_2=300;
% data.contra_raw=data.contra_raw(cut_row_1:cut_row_2,cut_col_1:cut_col_2)
% data.ipsi_raw=data.ipsi_raw(cut_row_1:cut_row_2,cut_col_1:cut_col_2)
% data.contra_eq=data.contra_eq(cut_row_1:cut_row_2,cut_col_1:cut_col_2)
% data.ipsi_eq=data.ipsi_eq(cut_row_1:cut_row_2,cut_col_1:cut_col_2)
% data.contra_filt=data.contra_filt(cut_row_1:cut_row_2,cut_col_1:cut_col_2)
% data.ipsi_filt=data.ipsi_filt(cut_row_1:cut_row_2,cut_col_1:cut_col_2)


figure,subplot(2,3,1), imagesc(data.contra_filt), axis image, colormap gray,title('filt contra'), colorbar
subplot(2,3,2),  imagesc(data.ipsi_filt), axis image, colormap gray,title(' filt ipsi')
subplot(2,3,3), imagesc(data.contra_eq), axis image,  colormap gray,title('Eq contra')
subplot(2,3,4),  imagesc(data.ipsi_eq), axis image,  colormap gray,title('Eq ipsi')
subplot(2,3,5), imagesc(data.contra_raw), axis image,  colormap gray,title('raw contra')
subplot(2,3,6),  imagesc(data.ipsi_raw), axis image, colormap gray,title('raw ipsi'), colorbar


data.min_reponse=min([data.contra_raw(:);data.ipsi_raw(:)])
data.max_reponse=max([data.contra_raw(:);data.ipsi_raw(:)])

figure
subplot(1,2,1), imagesc(data.contra_raw), axis image,  colormap gray,title('raw contra'), colorbar
clim([data.min_reponse, data.max_reponse])
subplot(1,2,2), imagesc(data.ipsi_raw), axis image,  colormap gray,title('raw ipsi'),colorbar
clim([data.min_reponse, data.max_reponse])


%%
%Select ROI of interest
contra=mat2gray(data.contra_raw);
ipsi=mat2gray(data.ipsi_raw);

figure, subplot(1,2,1),imagesc(ipsi), axis image, colormap gray
subplot(1,2,2),imagesc(contra), axis image, colormap gray

[im1,im2,ROI]=selec_roi(ipsi,contra);
% ROI=ones(size(RC1eq))
% ROI(ROI==0)=nan;

%%
%estimate background noise
contra_back=data.contra_raw;
ipsi_back=data.ipsi_raw;

[contra_eq_rand,SNR_contra]=estimate_back_noise(contra_back,ROI);
fprintf('snr for contra stim is: %2f\n', SNR_contra);
[ipsi_eq_rand,SNR_ipsi]=estimate_back_noise(ipsi_back,ROI);
fprintf('snr for ipsi stim is: %2f\n', SNR_ipsi);



%% Treshhold at 70 % peak response
ROI(ROI==0)=nan;

%type of data used for thresholding signal
contra=data.contra_raw.*ROI;
ipsi=data.ipsi_raw.*ROI;

%normalize values inside region of interest
contra(ROI==1)=mat2gray(contra(ROI==1));
ipsi(ROI==1)=mat2gray(ipsi(ROI==1));

%threshold values
contra_reg=((1-contra)>thr);
ipsi_reg=((1-ipsi)>thr);

%create nan rois
contra_reg=double(contra_reg==1);contra_reg(contra_reg==0)=nan;
ipsi_reg=double(ipsi_reg==1);ipsi_reg(ipsi_reg==0)=nan;

%save segmented data with nan values as background
data.seg.contra_filt=data.contra_filt.*contra_reg;
data.seg.ipsi_filt=data.ipsi_filt.*ipsi_reg;
data.seg.contra_eq=data.contra_eq.*contra_reg;
data.seg.ipsi_eq=data.ipsi_eq.*ipsi_reg;
data.seg.contra_raw=data.contra_raw.*contra_reg;
data.seg.ipsi_raw=data.ipsi_raw.*ipsi_reg;

data.seg.min_reponse=min([data.seg.contra_raw(:);data.seg.ipsi_raw(:)]);
data.seg.max_reponse=max([data.seg.contra_raw(:);data.seg.ipsi_raw(:)]);

% show response comparison of contra and ipsi signals
figure,subplot(1,2,1), imagesc(data.seg.contra_raw,'AlphaData',~isnan(contra_reg)),
axis image,  colormap gray,title('raw contra'), colorbar
set(gca,'color',background_color)
clim([data.seg.min_reponse, data.seg.max_reponse])
subplot(1,2,2), imagesc(data.seg.ipsi_raw,'AlphaData',~isnan(ipsi_reg)),
axis image,  colormap gray,title('raw ipsi'),colorbar
set(gca,'color',background_color)
clim([data.seg.min_reponse, data.seg.max_reponse])

hist_signal=figure, histogram(data.seg.contra_raw), title('segmented contra ipsi signal comparison'),hold on,
histogram(data.seg.ipsi_raw),legend('contra','ipsi')



%%
%-------------------Area de Solapamiemto--------------------------------%
% I obtain the variable solap where aI can segement the binocular 
% and monocular region of interest
% solap==1 binocular
% solap=-1 ipsi
% solap=2 contra 

contra_area=contra_reg>0;
ipsi_area=ipsi_reg>0;
solap=(2*contra_area)-(1*ipsi_area);

% Plot the solap variable
figure,subplot(1,3,1), imagesc(contra_area), axis image, colormap gray,title('contra area')
subplot(1,3,2),  imagesc(ipsi_area), axis image, colormap gray,title('ipsi area')
subplot(1,3,3), imagesc(solap), axis image, colormap gray,title('solap bin=1 contra=2 ipsi=-1')

%save rois of interest
roi.contra_index=solap==2
roi.ipsi_index=solap==-1
roi.bino_index=solap==1
roi.all_area_index=solap~=0
roi.hand_selected=ROI


%%
%---------------------Peak distance---------------------------------------%
% Peak distance obtained using maximum or center mass methods

% data used for peak calculation
contra=data.seg.contra_raw;
ipsi=data.seg.ipsi_raw;

% Find maximum response
[cpeak,valc1]=findpeak(1-contra);
[ippeak,valip1]=findpeak(1-ipsi);

% Find center of mass
[c1out]=center_of_mass_3(contra);
[ip1out]=center_of_mass_3(ipsi);

% peak distance
D_peaks = pdist([cpeak;ippeak]);
CM_dist = pdist([c1out(2:end);ip1out(2:end)]);

%plot solap with peaks
figure, imagesc(solap), axis image, colormap gray,title('Raw contra')
hold on, plot([cpeak(2),ippeak(2)],[cpeak(1),ippeak(1)],'o')
hold on, plot([c1out(3),ip1out(3)],[c1out(2),ip1out(2)],'o')

% plot peaks with data
figure,
subplot(1,2,1),imagesc(contra), axis image, colormap gray,title('contra centers')
hold on, plot(cpeak(2),cpeak(1),'o')
hold on, plot(c1out(3),c1out(2),'o')
subplot(1,2,2),imagesc(ipsi), axis image, colormap gray,title('Ipsi centers')
hold on, plot(ippeak(2),ippeak(1),'o')
hold on, plot(ip1out(3),ip1out(2),'o')

%% -------------- OD and ODI calculation ----------------------------
% Calculate ODI and OD mas from raw, filtered and equalized data
% Data is flipped and normalize by maximum reponse for raw data.
% 
contra_raw=1-(data.contra_raw./data.max_reponse);
ipsi_raw=1-(data.ipsi_raw./data.max_reponse);

contra_eq=imcomplement(data.contra_eq);
ipsi_eq=imcomplement(data.ipsi_eq);

contra_filt=imcomplement(data.contra_filt);
ipsi_filt=imcomplement(data.ipsi_filt);


figure,subplot(2,3,1), imagesc(contra_filt), axis image, colormap(greymap),title('filt contra'), colorbar
subplot(2,3,2),  imagesc(ipsi_filt), axis image, colormap(greymap),title(' filt ipsi')
subplot(2,3,3), imagesc(contra_eq), axis image,  colormap(greymap),title('Eq contra')
subplot(2,3,4),  imagesc(ipsi_eq), axis image,  colormap(greymap),title('Eq ipsi')
subplot(2,3,5), imagesc(contra_raw), axis image,  colormap(greymap),title('raw contra')
subplot(2,3,6),  imagesc(ipsi_raw), axis image, colormap(greymap),title('raw ipsi')

min_reponse=min([contra_raw(:);ipsi_raw(:)]);
max_reponse=max([contra_raw(:);ipsi_raw(:)]);

figure,subplot(1,2,1), imagesc(contra_raw), axis image,  colormap(greymap),title('raw contra flipped'), colorbar
clim([min_reponse, max_reponse])
subplot(1,2,2), imagesc(ipsi_raw), axis image,  colormap(greymap),title('raw ipsi flipped'),colorbar
clim([min_reponse, max_reponse])

figure,
histogram(contra_raw(roi.contra_index),20), title('contra ipsi flipped'),hold on,
histogram(ipsi_raw(roi.ipsi_index),20),legend('contra','ipsi')

%%
%--------------------- ODI PIXEL A PIXEL----------------------------------%
custom_map=[0 0 0; colormap(gray)];

%all the region
all_region_roi=double(roi.all_area_index);all_region_roi(all_region_roi==0)=nan;

filt_ODI=(contra_filt-ipsi_filt)./(contra_filt+ipsi_filt);
equ_ODI=(contra_eq-ipsi_eq)./(contra_eq+ipsi_eq);
RAW_ODI=(contra_raw-ipsi_raw)./(contra_raw+ipsi_raw);

OD_filt= contra_filt-ipsi_filt;
OD_equ=contra_eq-ipsi_eq;
OD_raw=contra_raw-ipsi_raw;

%binocular region
bino_nan_roi=double(roi.bino_index); bino_nan_roi(bino_nan_roi==0)=nan;
bin_filt_ODI=filt_ODI.*bino_nan_roi;
bin_equ_ODI=equ_ODI.*bino_nan_roi;
bin_RAW_ODI=RAW_ODI.*bino_nan_roi;

%plot all region figures
fig_odi=figure
subplot(3,2,1), imagesc(filt_ODI.*all_region_roi,'AlphaData',~isnan(all_region_roi)), axis image,
colormap(custom_map),set(gca,'color',background_color),title(filename, 'Interpreter', 'none');
subplot(3,2,2), histogram(filt_ODI(roi.all_area_index),20), title('OD filt Data')
subplot(3,2,3), imagesc(equ_ODI.*all_region_roi,'AlphaData',~isnan(all_region_roi)), colormap(custom_map),axis image,set(gca,'color',background_color);
subplot(3,2,4), histogram(equ_ODI(roi.all_area_index),20), title('OD Equalized Data')
subplot(3,2,5), imagesc(RAW_ODI.*all_region_roi,'AlphaData',~isnan(all_region_roi)), colormap(custom_map),axis image,set(gca,'color',background_color);
subplot(3,2,6), histogram(RAW_ODI(roi.all_area_index),20), title('RAW Data')


%plot all region figures
fig_odi_all=figure
subplot(3,2,1), imagesc(filt_ODI), axis image,
colormap(custom_map),title(filename, 'Interpreter', 'none');
subplot(3,2,2), histogram(filt_ODI(roi.all_area_index),20), title('OD filt Data')
subplot(3,2,3), imagesc(equ_ODI), colormap(custom_map),axis image,set(gca,'color',background_color);
subplot(3,2,4), histogram(equ_ODI(roi.all_area_index),20), title('OD Equalized Data')
subplot(3,2,5), imagesc(RAW_ODI), colormap(custom_map),axis image,set(gca,'color',background_color);
subplot(3,2,6), histogram(RAW_ODI(roi.all_area_index),20), title('RAW Data')


bino_odi=figure,subplot(3,2,1), imagesc(bin_filt_ODI,'AlphaData',~isnan(bin_filt_ODI)), axis image, colormap(custom_map),set(gca,'color',background_color);
subplot(3,2,2), histogram(bin_filt_ODI(roi.bino_index),20), title('OD bino filt Data')
subplot(3,2,3), imagesc(bin_equ_ODI,'AlphaData',~isnan(bin_equ_ODI)), colormap(custom_map),axis image,set(gca,'color',background_color);
subplot(3,2,4), histogram(bin_equ_ODI(roi.bino_index),20), title('OD bino Equalized Data')
subplot(3,2,5), imagesc(bin_RAW_ODI,'AlphaData',~isnan(bin_RAW_ODI)), colormap(custom_map),axis image,set(gca,'color',background_color);
subplot(3,2,6), histogram(bin_RAW_ODI(roi.bino_index),20), title('RAW bino Data')

%%
%---------------------------------OD MAP----------------------------------


figure, imagesc(filt_ODI,'AlphaData',~isnan(filt_ODI)), axis image, colormap(custom_map)
set(gca,'color',background_color),axis image
figure, imagesc(contra_raw-ipsi_raw,'AlphaData',~isnan(RAW_ODI)), axis image, colormap gray,set(gca,'color',background_color);


%%
%---------------------Save variables---------------------------------------%
if strcmp(input('type yes to end analysis\n','s'),'yes')
else
    display('you have entered same else, press cntr+c to end analysis')
end

area.solap=solap;
area.contra_area=contra_area;
area.ipsi_area=ipsi_area;

peaks.D_peaks=D_peaks;
peaks.CM_dist=CM_dist;

OD.filt=OD_filt
OD.equ=OD_equ   
OD.raw=OD_raw

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

imwrite(mat2gray(OD.raw),'OD.tif')
imwrite(mat2gray(~isnan(ROI)),'ROI.tif')
imwrite(mat2gray(solap),'solap.tif')
imwrite(mat2gray(data.contra_raw),'contra_raw.tif')
imwrite(mat2gray(data.ipsi_raw),'ipsi_raw.tif')
imwrite(mat2gray(data.contra_raw.*ROI),'contra_raw_roi.tif')
imwrite(mat2gray(data.ipsi_raw.*ROI),'ipsi_raw_roi.tif')
saveas(fig_odi,'filt_odi.png')
saveas(fig_odi_all,'filt_odi_all.png')
saveas(bino_odi,'bino_odi.png')
saveas(hist_signal,'hist_signal.png')    
writematrix(thr,'threshold.txt');

