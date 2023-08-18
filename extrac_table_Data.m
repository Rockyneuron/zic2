close all
clear all



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ferret Exctract data%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
fid = fopen('exp.txt');
data = textscan(fid,'%s');
fclose(fid);
mouse=data{1,1}
variable=[];
c_areas=[];
i_areas=[];
datos{1}='filename';
datos{2}='area_resp';datos{3}='contra_resp';
datos{4}='ipsi_resp';datos{5}='bino area';
datos{6}='pure_contra_area';datos{7}='pure_ipsi_area';
datos{8}='bino/tot';datos{9}='pure_contra/tot';
datos{10}='pure_ipsi/tot';datos{11}='contra_resp/tot';
datos{12}='ipsi_resp/tot';datos{13}='bino/ipsi_resp';
datos{14}='center_of_mass';datos{15}='max_peak'; 
datos{16}='RAW_bin_ODI';datos{17}='std_RAW_bin_ODI';
datos{18}='filt_bin_ODI' ;datos{19}='std_filt_bin_ODI';
datos{20}='bin_equ_ODI';datos{21}='std_bin_equ_ODI';
datos{22}='RAW_ODI_all';datos{23}='std_RAW_ODI_all'
datos{24}='filt_all_ODI';datos{25}='std_filt_all_ODI'
datos{26}='all_eqODI';datos{27}='std_all_eqODI';
datos{28}='contra_blk';datos{29}='ipsi_blk' ;
datos{30}='frames';datos{31}='pprest';
datos{32}='alfa';datos{33}='clip';
datos{34}='normalization';datos{35}='thr';
datos{36}='exp_loc';datos{37}='SNR_contra';
datos{38}='SNR_ipsi';
datos{39}='contra_max_response';
datos{40}='contra_min_response';
datos{41}='ipsi_max_response';
datos{42}='ipsi_min_response';

datos{43}='contra_seg_max_response';
datos{44}='contra_seg_min_response';
datos{45}='ipsi_seg_max_response';
datos{46}='ipsi_seg__min_response';
datos{47}='ttest2_seg_area';datos{48}='ttest2_whole_area';

cd analysed
for ii =1:length(mouse)


cd(mouse{ii})
load(mouse{ii})

%extract areas if intersest
tot_area=length(find(solap));
contra_resp=sum(area.contra_area(:));
ipsi_resp=sum(area.ipsi_area(:));

%Extract binocular, pura contra and pure ipsi areas
bino_area=sum(sum(area.solap==1));
pure_contra_area=sum(sum(area.solap==2));
pure_ipsi_area=sum(sum(area.solap==-1));

% Put the data into an exported table    
datos{ii+1,1}=mouse{ii};

%responsea areas
datos{ii+1,2}=tot_area;
datos{ii+1,3}=contra_resp;
datos{ii+1,4}=ipsi_resp;

datos{ii+1,5}=bino_area;
datos{ii+1,6}=pure_contra_area;
datos{ii+1,7}=pure_ipsi_area;

datos{ii+1,8}= bino_area/tot_area
datos{ii+1,9}= pure_contra_area/tot_area
datos{ii+1,10}= pure_ipsi_area/tot_area

datos{ii+1,11}=contra_resp/tot_area;
datos{ii+1,12}= ipsi_resp/tot_area;
datos{ii+1,13}= bino_area/ipsi_resp;

%peaks
datos{ii+1,14}= peaks.CM_dist;
datos{ii+1,15}=peaks.D_peaks;

%ODI bino region
datos{ii+1,16}= mean(bin_RAW_ODI(roi.bino_index));
datos{ii+1,17}= std(bin_RAW_ODI(roi.bino_index));
datos{ii+1,18}=mean(bin_filt_ODI(roi.bino_index));
datos{ii+1,19}=std(bin_filt_ODI(roi.bino_index));
datos{ii+1,20}= mean(bin_equ_ODI(roi.bino_index));
datos{ii+1,21}= std(bin_equ_ODI(roi.bino_index));

%ODI all region
datos{ii+1,22}= mean(RAW_ODI(roi.all_area_index));
datos{ii+1,23}= std(RAW_ODI(roi.all_area_index));
datos{ii+1,24}=mean(filt_ODI(roi.all_area_index));
datos{ii+1,25}=std(filt_ODI(roi.all_area_index));
datos{ii+1,26}= mean(equ_ODI(roi.all_area_index));
datos{ii+1,27}= std(equ_ODI(roi.all_area_index));

%metadata of analysis
datos{ii+1,28}= exp{1};
datos{ii+1,29}= exp{2};
datos{ii+1,30}= frame;
datos{ii+1,31}= pprest;
datos{ii+1,32}= alfa;
datos{ii+1,33}= clip;
datos{ii+1,34}= normalization;
datos{ii+1,35}=thr
datos{ii+1,36}=file_store

%Signal to noise ratio
datos{ii+1,37}=SNR.contra
datos{ii+1,38}=SNR.ipsi

datos{ii+1,39}=max(data.contra_raw(:));
datos{ii+1,40}=min(data.contra_raw(:));
datos{ii+1,41}=max(data.ipsi_raw(:));
datos{ii+1,42}=min(data.ipsi_raw(:));

datos{ii+1,43}=max(data.seg.contra_raw(:));
datos{ii+1,44}=min(data.seg.contra_raw(:));
datos{ii+1,45}=max(data.seg.ipsi_raw(:)); 
datos{ii+1,46}=min(data.seg.ipsi_raw(:));

[h,p,ci,stats_seg]=ttest2(data.seg.contra_raw(:),data.seg.ipsi_raw(:),'Vartype','unequal');
datos{ii+1,47}=stats_seg.tstat;

[h,p,ci,stats_all]=ttest2(data.contra_raw(:),data.ipsi_raw(:),'Vartype','unequal');
datos{ii+1,48}=stats_all.tstat;
close all

cd('..')
end
writecell(datos,'preliminar_4.xlsx')


